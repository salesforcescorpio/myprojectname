<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Appointment_reminder_to_customer</fullName>
        <description>Appointment reminder to customer</description>
        <protected>false</protected>
        <recipients>
            <field>Personal_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Apponitment_Reminder_to_customer</template>
    </alerts>
    <alerts>
        <fullName>Appointment_reminder_to_user</fullName>
        <description>Appointment reminder to user</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Apponitment_Reminder_to_user</template>
    </alerts>
    <alerts>
        <fullName>New_Opportunity_email_alert</fullName>
        <description>New Opportunity email alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Opportunity</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_stage_change_alert</fullName>
        <description>Opportunity stage change alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_Stage_Changed</template>
    </alerts>
</Workflow>
