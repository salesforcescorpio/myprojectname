<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_on_Account</fullName>
        <description>Email Alert on Account</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Recepient__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/test_email</template>
    </alerts>
</Workflow>
