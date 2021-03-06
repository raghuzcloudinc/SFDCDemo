public class BreaLeadAssignment{

public static void FindSalesInstallPartnerAdders(List<Lead> lst_Leads){
     system.debug('Entering FindSalesInstallPartnerAdders');
      Set<string> zipSet=new Set<String>();
      Set<string> stateSet=new Set<String>();
      Set<String> zipcodesset=new set<String>();
      Set<String> utilityset=new set<String>();
      Set<id> salesPartnerIds=new Set<id>();
      Map<String,Market_Assignment__c> maMap=new Map<String,Market_Assignment__c>();  
    for(Lead l:lst_Leads){
        if(l.channel__c=='Partner'&&l.custom_lead_source__c=='Partner: Legacy'&&l.sales_partner__c!=null){
            l.lock_assignment__c=true;
            l.lead_gen_partner__c=l.sales_partner__c;
            l.Lead_Origin__c='Partner';
            if(l.salesRep__c!=null){
            l.ownerid=l.salesRep__c;    
            }
            if(l.PostalCode!=null&&l.Postalcode.length()>=5){
              zipset.add(l.postalcode.substring(0,5));
              zipcodesset.add(l.postalcode.substring(0,5));
              utilityset.add(l.utility_company__c);
            }
          if(l.state!=null){
              stateset.add(l.state);
              zipcodesset.add(l.state);
              utilityset.add(l.utility_company__c);
          }  
          salesPartnerIds.add(l.sales_partner__c);
        }
    }
    if(!salesPartnerIds.isempty()){
    for(market_assignment__c ma:[select market__r.utility_company__c,market__r.state__c,zipcodes__c,role__c,Select_All_Zipcodes__c,Territory__c,Partner__c,partner__r.Lead_Eligible__c from Market_Assignment__c where (start_date__c<=today and end_date__c>=today and role__c includes ('Sales') and partner__r.Lead_Eligible__c=true and partner__r.Active__c=true and partner__c in:salesPartnerIds)or( start_date__c<=today and end_date__c>=today and role__c includes ('Sales') and partner__r.Lead_Eligible__c=true and partner__r.Active__c=true and market__r.state__c in:stateSet and partner__c in:salesPartnerIds)  order by Select_All_Zipcodes__c nulls last]){
       for(string zip:zipcodesset){                    
                    if(!String.isempty(ma.Zipcodes__c)&&!String.isempty(zip)&&ma.Zipcodes__c.contains(zip.trim())){
                        maMap.put(zip+' '+ma.Market__r.state__c+' '+ma.Market__r.utility_company__c+' '+ma.partner__c,ma);
                    }
                    if(ma.Select_All_Zipcodes__c==true&&!String.isempty(ma.market__r.state__c)&&stateset.contains(ma.market__r.state__c)){
                       maMap.put(ma.Market__r.state__c+' '+ma.Market__r.utility_company__c+' '+ma.partner__c,ma);
                    }
                }  
      }    
    List<Lead> InstallPartnerLead=new List<Lead>();
    for(Lead l: lst_leads){
     if(l.PostalCode!=null&&l.PostalCode.length()>=5){
        if(maMap.containsKey(l.postalcode.substring(0,5)+' '+l.state+' '+l.utility_company__c+' '+l.Sales_Partner__c)){          
          l.Market_Assignment_Sales__c=maMap.get(l.postalcode.substring(0,5)+' '+l.state+' '+l.utility_company__c+' '+l.Sales_Partner__c).id;
          if(maMap.get(l.postalcode.substring(0,5)+' '+l.state+' '+l.utility_company__c+' '+l.Sales_Partner__c).role__c.contains('Install')){
          l.Install_Partner__c=maMap.get(l.postalcode.substring(0,5)+' '+l.state+' '+l.utility_company__c+' '+l.Sales_Partner__c).partner__c;
          l.Market_Assignment_Install__c=maMap.get(l.postalcode.substring(0,5)+' '+l.state+' '+l.utility_company__c+' '+l.Sales_Partner__c).id;  
          }                  
        }
        }
        if(l.state!=null&&l.Market_Assignment_Sales__c==null){
        if(maMap.containsKey(l.state+' '+l.utility_company__c+' '+l.Sales_Partner__c)){          
          l.Market_Assignment_Sales__c=maMap.get(l.state+' '+l.utility_company__c+' '+l.Sales_Partner__c).id;
          if(maMap.get(l.state+' '+l.utility_company__c+' '+l.Sales_Partner__c).role__c.contains('Install')){
          l.Install_Partner__c=maMap.get(l.state+' '+l.utility_company__c+' '+l.Sales_Partner__c).partner__c;
          l.Market_Assignment_Install__c=maMap.get(l.state+' '+l.utility_company__c+' '+l.Sales_Partner__c).id;  
          }                  
        }  
        }
        if(l.Install_Partner__c!=null && l.Install_Partner__c!=System.Label.Sunrun_Inc_Id){
          LeadTriggerClass.clearLeadFields(l);
          nullOutFactors.nullOutFactors(l);
        }
        if(l.Install_Partner__c==null&&l.market_assignment_sales__c!=null){
            InstallPartnerLead.add(l);        
        }   
    }
    system.debug('---Find install partner leads'+InstallPartnerLead);
    if(!InstallPartnerLead.isempty()){
        SearchSalesInstallForPartners.doFindInstallPartner(InstallPartnerLead,zipcodesset,StateSet,utilityset);
    }
    FindEPCData.FindEPCData(lst_leads);
   }   
}
  Public Static Void BreaLeadshare(List<Lead> lst_Leads){
    Set<id> leadids=new Set<id>();
    Set<String> leadSourceSet=new Set<String>();
      for(Partner_Ma__c pma:Partner_Ma__c.getAll().values()){
            leadSourceSet.add(pma.Lead_Source__c);
        }
       for(lead l:lst_Leads){
         if((l.channel__c=='Partner'&&l.custom_lead_source__c=='Partner: Legacy')||(l.custom_lead_source__c!=null&&leadSourceSet.contains(l.custom_lead_source__c))){
           leadids.add(l.id);
         }
       }
       if(!leadids.isempty()){
         BreaLeadShare.BreaLeadShare(Leadids);
       }
    }
}