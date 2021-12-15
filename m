Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8A9C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Dec 2021 12:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbhLOMCp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Dec 2021 07:02:45 -0500
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:32225
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237840AbhLOMCo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Dec 2021 07:02:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJF9E3FpMXZrWtwK2HqyYrDBqCpRStVMfwyyaOUIYr+OE3V6kmX1Zz2qfY7srqQjXkx0nIVIYTaYmYEw+ZiUzBXPmgITb+r+tTca0UU3EMxy8LpopHw64NPm+h1U7eYn3wvPHYkPZ7R9hboOKDgXlgHa0fBoCrfSLaZySKjyoASiKZ4ZtZQi7OF5v12ZHP96t2CY3iRk8gwgCeWd1PeTX23LUb78tGUrM16Vujc+V/vwma8t/6lJe16ckXPJ+ImkBeLaHOZbFbR3HFfvQ0/QUT7oEZ2yXSXOvFmFoAdRtzP5Fiqyq5H2mwA9CUP2/wypM8+xhTrYgzKuQZM7ECq5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2z5ukAcOG0Tn8cdnYHHNRK9BjTBbXcdlFjYefDNYx0=;
 b=lNVUvH4nG8LQhL4QMDjbN+V6mYCjSr6NKRM01xxMvbb9tz73UThYi0Gc1JfgoYsIj+BeD5F9+PeBifw1pa+4egfk4BWZVOXOelipyU0uw40b9Pm95V9BsHm8ITf62h6x2tSdyW88txXA1pF27eMBIaXsoDT1aJZKSleZgdXBnfiCf3dBaVnrDRvSZ1tqkspMfWR7OKgozYH3itrYAP6MeLZHBG+GC4k7AqRigaSBhSAqJxlpJ44oLODDt0Z/GUssUc/JcuxDI7Ua3cHUTku5Tcbl32dXOhNXEawJfQ5wWRKegvkWHNUzmD0Q9XVm1z5PpNRa5LKq9dgB076nCLBC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vanmierlo.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2z5ukAcOG0Tn8cdnYHHNRK9BjTBbXcdlFjYefDNYx0=;
 b=sdAfKS/nCGQfNDDllJBW0h4O6qK+12e8SLtT+4/m3DSppmXqIHUOKv0JUGZQyeW41hYUJiH8U+NqXPDX5tc1RE0NCQ+Uq22S8TOLDk2nXCH41CywQugjJUV641tVM3mN6/TjcOO5uVmxpcST9HBczojbJGXo4mypHQUIgGIC0i8=
Received: from BN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:ee::30)
 by DM6PR02MB4076.namprd02.prod.outlook.com (2603:10b6:5:9d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Wed, 15 Dec
 2021 12:02:41 +0000
Received: from BN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::47) by BN0PR04CA0025.outlook.office365.com
 (2603:10b6:408:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Wed, 15 Dec 2021 12:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT015.mail.protection.outlook.com (10.13.2.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Wed, 15 Dec 2021 12:02:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Dec 2021 04:02:38 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 15 Dec 2021 04:02:38 -0800
Envelope-to: git@xilinx.com,
 m.brock@vanmierlo.com,
 r.willenberg@hs-mannheim.de,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.254.241.49] (port=37964)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mxSzV-0007Xn-Sk; Wed, 15 Dec 2021 04:02:38 -0800
Message-ID: <917f7f35-fc43-f4df-1fa4-3039e97dfc6e@xilinx.com>
Date:   Wed, 15 Dec 2021 13:02:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
Content-Language: en-US
To:     Maarten Brock <m.brock@vanmierlo.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Ruediger Willenberg <r.willenberg@hs-mannheim.de>,
        <linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <git@xilinx.com>, <shubhrajyoti.datta@xilinx.com>
References: <20211118211745.133778-1-r.willenberg@hs-mannheim.de>
 <be268f13-7299-b701-55a9-0942d4aeb1e2@xilinx.com>
 <fd919b8b-4348-df1f-05cb-93405f947dba@hs-mannheim.de>
 <7d46faa1-9a89-907e-bbb4-a03b91be86d0@xilinx.com>
 <0ecd8ba236e18e580700b31ca415ba22@vanmierlo.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <0ecd8ba236e18e580700b31ca415ba22@vanmierlo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f88436b-2207-4e9a-2134-08d9bfc2cb13
X-MS-TrafficTypeDiagnostic: DM6PR02MB4076:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB4076EDBDEE7A24E13EE789D7C6769@DM6PR02MB4076.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0ufI0Cy00IxfyPvZTCBlB3f99bDKvM7WMTGT6o/vW0eWVSZKLE+T3qnfDL5UkCPCO+2pbyMEdwOkz99RlskhxZSN3aziz+CagNkKNJYVUGCYopjYvdlX6md3PTdcWipt3CjotML6eh2jkK3rzvdEEpXAsY0LBiu9uPiVew1I202rMhh0aclH5tPW50WEmOmyHGBJLXR4hHgLaCTnQHivnVrZ0QMSHeYte7eMDHkfr31COGnjPuD0JUSDqrQzji/aiMOAVloocglV1QaL2pCczzMzXHuKQRYuzREV23kmHCHVNP4iLrumtK64Sit37MVSw3SlAhGIVHLo+3FUjHCq/8XnOCigMRUmDdx2yDpcJMXekZ6vZZP/n3H3zUyN+/fYZznIyrua1SKeP3I8Bj2jQ/y8u5SyXMNXmHWUJTFqVD5uxr4SruHn+s7YT+5F1gNXcePUy5EDvZGmNWVgiOzFMrySgT0h5+hE+7d7n7MXhCcR2Td1dK5ZvbUqcMhNdYZX1WViHhGm8wo2bjDRmIJmV72UCmOK1yOT86gfQpGObh1VR6hPHiUc+Dr3rBYyewxG2btNzcY64tnlgYnePhJAA89gVddYmfAWYOq9bSN3wIBHyrhjp2bk/ZrU5z0Yh5sP7zkJmOC+dAit86Ca1wgA43y1WskYXSIBjTStnX9JcSZ0HOkT6P9HQjtkHX/V3O0YRY+91+UzNrtv6zkR2aRqR/BQzolKdv0dNnrD27ti1/D0BVSv0Af9Hdd0GGVSLvuv9JPeSSK5eqxgIK+HzWKKw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(426003)(54906003)(508600001)(6666004)(31696002)(110136005)(5660300002)(316002)(36860700001)(7636003)(31686004)(8936002)(36756003)(4001150100001)(8676002)(26005)(2616005)(336012)(53546011)(44832011)(2906002)(47076005)(186003)(83380400001)(9786002)(107886003)(70206006)(70586007)(356005)(82310400004)(4326008)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 12:02:39.9818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f88436b-2207-4e9a-2134-08d9bfc2cb13
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4076
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/26/21 16:35, Maarten Brock wrote:
> On 2021-11-23 13:19, Michal Simek wrote:
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
>>>>> @@ -676,7 +678,11 @@ static int ulite_assign(struct device *dev, int id, 
>>>>> u32 base, int irq,
>>>>>           dev_set_drvdata(dev, NULL);
>>>>>           return rc;
>>>>>       }
>>>>
>>>> nit: please keep this newline here.
>>>>
>>>>> -
>>>>> +    if (oor_id >= 0)
>>>>> +        dev_notice(dev,
>>>>> +            "assigned uartlite with device tree port-number=<%i> to %s%i\n",
>>>>> +            oor_id, ULITE_NAME, id);
>>>>> +
>>>>
>>>>
>>>>
>>>> [linux](master)$ ./scripts/checkpatch.pl --strict 
>>>> 0001-serial-uartlite-Move-out-of-range-port-numbers-into-.patch
>>>> CHECK: Alignment should match open parenthesis
>>>
>>> Thanks, I apparently didn't do "--strict" checking, sorry. Will fix both in 
>>> PATCH v3
>>>
>>>
>>>> And there is one more issue with this. If you start to mix serial IPs which 
>>>> are partially recorded in aliases. For example like this.
>>>>
>>>> aliases {
>>>>      serial0 = &uart1;
>>>> };
>>>>
>>>> uart0 {
>>>> ...
>>>> };
>>>> Uart0 is probed first. It is without alias and id 0 will be assigned to it. 
>>>> Then uart1 is probed. It looks at aliases you get id 0 but it is already 
>>>> taken and you end up with "cannot assign to %s%i; it is already in use"
>>>
>>> As I point out in the other thread
>>>   "[PATCH v2] uartlite: Update the default for the SERIAL_UARTLITE_NR_UARTS"
>>> (I don't feel crossposting all of it here would be good practice)
>>>
>>> a) the Xilinx DTG gives "serial" aliases to _all_ Xilinx UARTs
>>> b) the Xilinx DTG gives "port-number" properties to _all_ Xilinx UARTs
>>> c) these two are not assigned in the same order by the Xilinx DTG, which is 
>>> problematic
>>
>> DTG/MSS logic should be solved in different mailing list that's why
>> please move it there.
> 
> What mailing list? I'd like to be in on this.

xilinx forums.

> 
>>>
>>> uartlite.c currently looks at port-number properties, not aliases. So 
>>> unassigned aliases are not the issue. A similar-looking but more complicated 
>>> issue that COULD happen, to be transparent, is this:
>>
>> port-number is optional and as I said in the second thread I think
>> that this should be deprecated and removed. Most of DT drivers take
>> care about serial alias that's why we should go that route too.
>>
>> And I also remember that drivers shouldn't really use different names
>> as ttyUL, ttyPS, ttyAMA, etc but all of them should use the same name
>> as ttyUSB is doing.
>>
>> Thanks,
>> Michal
> 
> The port-number is optional, but currently automatically generated. The same goes
> for the aliases. How can one remove them from the device-tree? Is overwriting the
> only option? If so, what value would you recommend?

As was said DTG does the best to help you to describe system. You should take 
output of DTG and fix your design by hand to match your requirements.

> 
> If, and only if, devices would start to use the same name would the serial alias
> become a decent solution. But I'm sure that the 8250 driver currently does not
> supports e.g. ttyS25 when SERIAL_8250_NR_UARTS is configured for only 4 devices.
> 
> As a workaround I always patch the xilinx_uartps.c driver to also support
> port-number. This way I can overwrite the port-number values in the device-tree
> to get them numbered ttyPS0 and ttyPS1. And then I can use the serial alias for
> my 16550's.
> 
> &uart0 {
>          port-number = <0>;                      // this is a xilinx_uartps
> };
> 
> &uart1 {
>          port-number = <1>;                      // this is a xilinx_uartps
> };
> 
> &liteuarts_axi_uartlite_0 {
>          port-number = <0>;                      // this is a uartlite
> };
> 
> &liteuarts_axi_uartlite_1 {
>          port-number = <1>;                      // this is a uartlite
> };
> [...]
> &liteuarts_axi_uartlite_10 {
>          port-number = <10>;                     // this is a uartlite
> };
> 
> The 16550's also received a port-number but the driver ignores that.
> 
> aliases {
>          serial0 = &uart0;
>          serial1 = &fulluarts_axi_uart16550_1;
>          serial2 = &fulluarts_axi_uart16550_2;
>          serial3 = &fulluarts_axi_uart16550_3;
>          serial4 = &fulluarts_axi_uart16550_4;
>          serial5 = &fulluarts_axi_uart16550_5;
>          serial6 = &fulluarts_axi_uart16550_6;
>          serial7 = &fulluarts_axi_uart16550_7;
>          serial8 = &fulluarts_axi_uart16550_0;
> };
> 
> Note how I had to abuse serial8 to get the 16550_0 at ttyS0 with
> SERIAL_8250_NR_UARTS=8. This does leave me with several dangling serial aliases
> in the final device tree.
> 
> The fact that I have to use this workaround to me means that the serial naming
> and numbering system is broken.

I am not the right person to judge this. IIRC last time we discussed about it it 
was said that someone should take a look at USB tty behavior where this is solved.

> If you ask me, the solution is not to start using the serial alias, but abandon it
> and go for port-number entirely, at least for uartlite and xilinx_uartps. But
> eventually also for the 8250 driver and all others.
> 
> Btw. the port-number and the MSS also don't sort natural, but purely alphabetical.
> axi_uartlite_10 comes before axi_uartlite_2. Maybe I should have renamed them
> with a leading zero myself.

I choose the way that I am normally using serial aliases and don't using port 
numbers and systems have ttyPS0, PS1, S2, S3, UL4, UL5 etc. And I have stable 
number and not all ttyX starts from 0. Which is the same solution which Xilinx 
is using because I think I have introduced this behavior in DTG (or at least 
reviewed it).

Thanks,
Michal
