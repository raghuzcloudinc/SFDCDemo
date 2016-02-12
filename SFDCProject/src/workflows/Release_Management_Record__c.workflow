<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_Release_Management_Record_created_awaiting_approval</fullName>
        <description>New Release Management Record created, awaiting approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>adharsh.fnu@sunrun.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>aditya.boyapally@sunrun.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>arun.muthuraman@sunrun.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>djohnson@sunrun.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mahender.ambati@sunrun.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>purnachander.chada@sunrunhome.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pveloori@sunrunhome.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>raghu.puchala@sunrun.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>revathi.krishnan@sunrun.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rmasineni@sunrunhome.com.prod</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sheetal.chaudhari@sunrunhome.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>srajan@sunrunhome.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sravanthi.gillala@sunrun.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Deployment_Request_Created</template>
    </alerts>
    <rules>
        <fullName>Generate_Approval_Email</fullName>
        <actions>
            <name>New_Release_Management_Record_created_awaiting_approval</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Release_Management_Record__c.Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <description>An approval email is generated every time a new release management record gets created.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
