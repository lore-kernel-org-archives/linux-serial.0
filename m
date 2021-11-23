Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78F0C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 15:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhKWPIW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:08:22 -0500
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:46784
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230510AbhKWPIV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 10:08:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgDOedzgAohzNWf7LNil8SuVjF8/vJd7w1EkfDtHx6y+bYMBmXjkpuCIXx0JWT2U2gM7oRZW5SXRFWohbwrC2XcRF9KbKziJr2P94zTRRhyPgtRGa/5GREp4QNsa03PS5og3Cx50v+OAacGqMutpL/sMSmYEZA2kb8sMQ60Awi9+wlitcl+zcn/44mUIJA/nbMjeTpabeTnCwxNAuqkAUELTYgeII04V+slmXRH/7IHuSUXDM8X876D+32ODzRrYaw/vRNpIvSk/l6y9brmigRUlO69CCQxFlc56uq385DF8sUJBC1yGxn8r0nfSsASFSHA8mK0ewO5tt7QekQ3Bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMNgVJdzzQ4xTG5Krti2ZFm9paxrJ73lTKtqfyyzMZs=;
 b=GQni1tJD/N8SCB8HwlM2hvVO57m8ESD6wiAy1q6WqilhfYPE7Cp3MHOlax7H1VZ1gU1oIJee+N5SBTcMTdyLiZ+fg0bmfLb2Jq71d1/Z5BFJZkoJcWwHyHR+lL0q+f8q2TD39cxt+BSPxdb8uljQVL3C/sKiLVv1On2cOzMlcBnaYejQmOMx6VaIFx7ETyOyWpxVlSySSjJcFBcy5H9Nly/ziWdIrQKge4shKVWKWuiWjxTrf8zYA9IGXaO+7NQRb21ZX6v7gJunmKCjSEEVCES1Wf9Af+5+skcI9GS36RSUgzHswxUjp/ma0hB6/j7+bUvCZvNkmRWHB0DBY22sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=hs-mannheim.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMNgVJdzzQ4xTG5Krti2ZFm9paxrJ73lTKtqfyyzMZs=;
 b=CQoxYHJGd/JoeHpp9EVQhSkXQlJF7yHnTkw1zWf7lsqTqblvLeuxLppm2lmJObIRItJgaDSk4shwh9X3vHs0d9ii5eyihXXWkpZWQObGld3IBFMJ3lttxXc9VrqYJsmZu+zNGwmEKXjNrUGaB/YCMcN0CqKlQOTymObwbY7nEYY=
Received: from DM6PR01CA0029.prod.exchangelabs.com (2603:10b6:5:296::34) by
 DM5PR02MB2409.namprd02.prod.outlook.com (2603:10b6:3:51::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Tue, 23 Nov 2021 15:05:11 +0000
Received: from DM3NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::4f) by DM6PR01CA0029.outlook.office365.com
 (2603:10b6:5:296::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19 via Frontend
 Transport; Tue, 23 Nov 2021 15:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT035.mail.protection.outlook.com (10.13.4.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 15:05:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 23 Nov 2021 07:05:09 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 23 Nov 2021 07:05:09 -0800
Envelope-to: git@xilinx.com,
 r.willenberg@hs-mannheim.de,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.254.241.49] (port=51970)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mpXM4-000EVt-JO; Tue, 23 Nov 2021 07:05:08 -0800
Message-ID: <e8ecbe6d-2696-ca05-693f-46609e84a43b@xilinx.com>
Date:   Tue, 23 Nov 2021 16:05:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
Content-Language: en-US
To:     =?UTF-8?Q?R=c3=bcdiger_Willenberg?= <r.willenberg@hs-mannheim.de>,
        "Michal Simek" <michal.simek@xilinx.com>,
        <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>
References: <20211118211745.133778-1-r.willenberg@hs-mannheim.de>
 <be268f13-7299-b701-55a9-0942d4aeb1e2@xilinx.com>
 <fd919b8b-4348-df1f-05cb-93405f947dba@hs-mannheim.de>
 <7d46faa1-9a89-907e-bbb4-a03b91be86d0@xilinx.com>
 <1eb4b718-dc7e-047f-1fa3-0ec1ab52e787@hs-mannheim.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <1eb4b718-dc7e-047f-1fa3-0ec1ab52e787@hs-mannheim.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dac3b59-aa22-4004-3ffe-08d9ae92a4f0
X-MS-TrafficTypeDiagnostic: DM5PR02MB2409:
X-Microsoft-Antispam-PRVS: <DM5PR02MB24097E25BC1D968A3F967CF0C6609@DM5PR02MB2409.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8MC9W0QJt3EKpz8zbBqupXAv3MPQBGZbNEhTBG98pGSJPSRSJIRacqnkSG0OEluA4o8i5mVVeZjJyNA7SPa/oyt1ikGCj69sC6t70hA8SAM1CwcmkLu3bSm0/SA8C4igZwbmRu25EhjUXVyAyy/g5O7LLVSuFFU4YIVWF+W7e3/7Ysm5ItD5WarnNYaiztbgkINvXAzfjZdN1s7OC1LDY3aMEIvgwF3xyGGbMUq6ATK4UqtcvksAIE/r+3cb0hMlngfjye/0bjzYoNr0g3YOyQ5xJKiKuXEkWTJibKBi60PgpZjkDaRA1tKudzgctjJadibkrkwiAX31nQSK7kUjZyzCEXnHiEq2OlG6btXj2MpTAQyr/YJrCUluU53IC1ska7RXX3cCfT0lXg9sJvjrCivGrbrRsxgAmcM1vCiFJXVTVFKKntG8ahQOrgizJZQ1h4pkdEj3pVPr7rGdey4hTFhuKYSys7BeWWI6+bVais7UiHSXazDP8SWCB2ckyyYKO3AM0UsGgHWJaBKV6PLDv4SahVR/wSe4tgHZruQYXfzmJ3OG2AZ3cA0QpaXGEC9mMB9Qe/n7eKB6S3q2VRh23XBZki2ee9AwTkHz7xE1tQs71F7Wk17BKtm6ghaYqO8prYKMr4HU4sTSYU1/M3gRel3fPJmk4N4oZN8Qq4uhtCw/YN+V+B2A5b5m7rcCwZO5BLhx99CC3BXYIa0NkJJus0iHVD7wafQGktjVjZTZM8CdY0EcKeMeEvEj49e+cLCis9ryIydctTW18dtRSdJoQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(2906002)(7636003)(8676002)(54906003)(107886003)(31696002)(36756003)(44832011)(36860700001)(2616005)(110136005)(426003)(53546011)(508600001)(356005)(83380400001)(336012)(9786002)(70206006)(66574015)(186003)(31686004)(82310400004)(4326008)(316002)(47076005)(5660300002)(70586007)(8936002)(26005)(36906005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 15:05:10.4402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dac3b59-aa22-4004-3ffe-08d9ae92a4f0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2409
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/23/21 15:59, Rüdiger Willenberg wrote:
> Am 23.11.2021 um 13:19 schrieb Michal Simek:
>>
>>
>> On 11/22/21 23:08, Ruediger Willenberg wrote:
>>> Am 19.11.2021 um 13:21 schrieb Michal Simek:
>>>> On 11/18/21 22:17, Ruediger Willenberg wrote:
>>>>> Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
>>>>> the device tree port-number property is outside that range. This
>>>>> happens when there are other UART types in the system because the
>>>>> Xilinx device tree generator numbers all UARTs consecutively;
>>>>> as a result, not as many Uartlites as specified by the
>>>>> SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.
>>>>>
>>>>> Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
>>>>> ---
>>>>> Changes in v2:
>>>>>   - give KERN_NOTICE when changing the id,
>>>>>     with reference to the requested port-number
>>>>>
>>>>> -    if (id < 0 || id >= ULITE_NR_UARTS) {
>>>>> -        dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
>>>>> +    if (id == ULITE_NR_UARTS) {
>>>>> +        dev_err(dev, "maximum number of %s assigned\n", ULITE_NAME);
>>>>>           return -EINVAL;
>>>>>       }
>>>>> @@ -676,7 +678,11 @@ static int ulite_assign(struct device *dev, 
>>>>> int id, u32 base, int irq,
>>>>>           dev_set_drvdata(dev, NULL);
>>>>>           return rc;
>>>>>       }
>>>>
>>>> nit: please keep this newline here.
>>>>
>>>>> -
>>>>> +    if (oor_id >= 0)
>>>>> +        dev_notice(dev,
>>>>> +            "assigned uartlite with device tree port-number=<%i> 
>>>>> to %s%i\n",
>>>>> +            oor_id, ULITE_NAME, id);
>>>>> +
>>>>
>>>>
>>>>
>>>> [linux](master)$ ./scripts/checkpatch.pl --strict 
>>>> 0001-serial-uartlite-Move-out-of-range-port-numbers-into-.patch
>>>> CHECK: Alignment should match open parenthesis
>>>
>>> Thanks, I apparently didn't do "--strict" checking, sorry. Will fix 
>>> both in PATCH v3
>>>
>>>
>>>> And there is one more issue with this. If you start to mix serial 
>>>> IPs which are partially recorded in aliases. For example like this.
>>>>
>>>> aliases {
>>>>      serial0 = &uart1;
>>>> };
>>>>
>>>> uart0 {
>>>> ...
>>>> };
>>>> Uart0 is probed first. It is without alias and id 0 will be assigned 
>>>> to it. Then uart1 is probed. It looks at aliases you get id 0 but it 
>>>> is already taken and you end up with "cannot assign to %s%i; it is 
>>>> already in use"
>>>
>>> As I point out in the other thread
>>>   "[PATCH v2] uartlite: Update the default for the 
>>> SERIAL_UARTLITE_NR_UARTS"
>>> (I don't feel crossposting all of it here would be good practice)
>>>
>>> a) the Xilinx DTG gives "serial" aliases to _all_ Xilinx UARTs
>>> b) the Xilinx DTG gives "port-number" properties to _all_ Xilinx UARTs
>>> c) these two are not assigned in the same order by the Xilinx DTG, 
>>> which is problematic
>>
>> DTG/MSS logic should be solved in different mailing list that's why 
>> please move it there.
> 
> I agree in principle. Michal, since you have an @xilinx.com domain could 
> you please share where that place to discuss is?
> 
> The Linux "devicetree" list doesn't not seem the right place either for 
> a company-managed, separate repo. If this goes your suggested way 
> (completely changing the uartlite driver to use the "serial" alias, the 
> Xilinx DTG _needs_ to be improved, including respecting the serial0 
> alias for the designated console. I'd be glad to contribute to the 
> discussion there. Right not there's a mess that's not solved by throwing 
> out the port-number property alone.
> 
>>>
>>> uartlite.c currently looks at port-number properties, not aliases. So 
>>> unassigned aliases are not the issue. A similar-looking but more 
>>> complicated issue that COULD happen, to be transparent, is this:
>>
>> port-number is optional and as I said in the second thread I think 
>> that this should be deprecated and removed. Most of DT drivers take 
>> care about serial alias that's why we should go that route too.
>>
>> And I also remember that drivers shouldn't really use different names 
>> as ttyUL, ttyPS, ttyAMA, etc but all of them should use the same name 
>> as ttyUSB is doing.
> 
> Big improvements are good and well, but they tend to break things and 
> again it does mean the Xilinx DTG needs to move with that.
> I'd be immensely grateful if you could indicate _where_ to discuss those 
> changes, and who has the authority to speak for Xilinx. Off-list, if you 
> think that is more appropriate.

Let's just figure it out how it should be done properly and then there 
is no problem to update DTG based on it.

Thanks,
Michal
