<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Test_Email</fullName>
        <description>Test Email</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Personal_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/test_email</template>
    </alerts>
    <alerts>
        <fullName>Test_Send_Mail</fullName>
        <description>Test Send Mail</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Personal_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/test_email</template>
    </alerts>
    <alerts>
        <fullName>UDV_Reminder_Alert</fullName>
        <description>UDV Reminder Alert</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/UDV_reminder</template>
    </alerts>
    <fieldUpdates>
        <fullName>update_first_name</fullName>
        <field>First_Name__c</field>
        <name>update first name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>default values to the last name n first name</fullName>
        <actions>
            <name>update_first_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>IF((ISNULL( First_Name__c ) || ISNULL( Last_Name__c )), true, false)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
