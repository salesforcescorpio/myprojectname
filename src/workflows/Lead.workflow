<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Lead_Appointment_reminder_to_customer</fullName>
        <description>Lead Appointment reminder to customer</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Lead_Appointment_reminder_to_customer</template>
    </alerts>
    <alerts>
        <fullName>Lead_Appointment_reminder_to_user</fullName>
        <description>Lead Appointment reminder to user</description>
        <protected>false</protected>
        <recipients>
            <recipient>info.arlingtonhall@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Lead_Appointment_reminder_to_user</template>
    </alerts>
    <fieldUpdates>
        <fullName>Populate_Email_field</fullName>
        <field>Email_new__c</field>
        <formula>Email</formula>
        <name>Populate Email field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_First_Name</fullName>
        <field>First_Name__c</field>
        <formula>FirstName</formula>
        <name>Update First Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Last_Name</fullName>
        <description>This is used to update last name</description>
        <field>Last_Name__c</field>
        <formula>LastName</formula>
        <name>Update Last Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Populate Email</fullName>
        <actions>
            <name>Populate_Email_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Email</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update the First and Last Name of Lead</fullName>
        <actions>
            <name>Update_First_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Last_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow will update the First_Name__c and the Last_Name__c field on the lead object</description>
        <formula>OR( FirstName !=null , LastName !=null)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
