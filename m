Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE160C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 12:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhKWMKx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:10:53 -0500
Received: from mail-mw2nam08on2089.outbound.protection.outlook.com ([40.107.101.89]:63200
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235534AbhKWMKx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 07:10:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/7Lyg90KXg/mTcQavOWN5uGWKwAq+aVoYio7Q0n0rw6MzQFvGq4zq3LkRmmVOK6k7TMcRT4psvVHOZNiWWba7sLtR7NiLugzE3CzkH8RTrkEqN9kI3sesSD5+VRAmSwXNDzwEO+coCfRo/BUCB07wn70ToQhgQmCi210jCPIWDZeuldazLKxqmBv+aqi9JT6EGTnP0LmTzcSs9+SLG8ZDr5U2sjwFQsaCbiGleWAMI4PU3O8tCbTI7SkLOPoJxDKptnYKcrcp0mW1bIiTqjHH044Q5zn7EOuJeqO2qlUhZ6lzVAUPeGnzpVes1CgGe4hcrWCuS+eHbGzKWgzFG9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFd/9Rl/YTb09dOZeO3YeGj/NZmFeELvZzQ+3h2A+SY=;
 b=J5uyr170tXMrMUnKkkgjX61N7PTNDJLpR0kH375SXbwamizbv/Rco89v32BiaZkiZo+XDk9hG4b2NcIfsxwKWGqZO81S6hrBAKtOJEtdbiEKAxo/JY2UbpzJ96mZ3lsta47mTIycAhvWi8ObO9l+W/XeXbeYcZfn0u633GnKRw5ho7AsHDgukD0Lu+B0Q0ZLlLH71My/AwZZYlKrrGhp1mlCzafkhnNCnRGOeoo4rYjINgtbbBjjm89egIF6U6uwUYpbHlqSIfN2WcCDXwb6Dkca6+8ZPSYHDNR+klWxWZtFjGPLE7Mlisk8J579sTT64no9GtyIGoZZcEfjFbmJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=hs-mannheim.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFd/9Rl/YTb09dOZeO3YeGj/NZmFeELvZzQ+3h2A+SY=;
 b=jU7qltXmTygN4IAqqlA3QL24Z/ySNnFD1fnf3v6ZsXOV/cVHVeGbNE4zR7z4zb6ofBX/3Kg3k87OW7BCWepmAK5/a1AJpIz8hr+9wnpr4JFBuq72bji66gDrypOgb4HJS7nTbhciD1Cubs2MYmKjXaU2kQx7vyRjXZvattvOEFQ=
Received: from DM5PR12CA0066.namprd12.prod.outlook.com (2603:10b6:3:103::28)
 by DM6PR02MB6041.namprd02.prod.outlook.com (2603:10b6:5:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 12:07:43 +0000
Received: from DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::31) by DM5PR12CA0066.outlook.office365.com
 (2603:10b6:3:103::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Tue, 23 Nov 2021 12:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT037.mail.protection.outlook.com (10.13.4.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 12:07:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 23 Nov 2021 04:07:40 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 23 Nov 2021 04:07:40 -0800
Envelope-to: git@xilinx.com,
 r.willenberg@hs-mannheim.de,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.254.241.49] (port=34332)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mpUaJ-0002IM-Fp; Tue, 23 Nov 2021 04:07:39 -0800
Message-ID: <337b2e18-ddc9-5540-1c5b-b47f0517c240@xilinx.com>
Date:   Tue, 23 Nov 2021 13:07:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] uartlite: Update the default for the
 SERIAL_UARTLITE_NR_UARTS
Content-Language: en-US
To:     Ruediger Willenberg <r.willenberg@hs-mannheim.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        <linux-serial@vger.kernel.org>
CC:     <git@xilinx.com>, <gregkh@linuxfoundation.org>
References: <20211117051635.1316958-1-shubhrajyoti.datta@xilinx.com>
 <edf15265-548a-1315-9175-967dddb38d4b@hs-mannheim.de>
 <82ee1522-da4b-9fc6-bcf5-ceb94e307f96@xilinx.com>
 <e01371cd-de45-cf9d-191a-c088df43566a@hs-mannheim.de>
 <74bba210-dcf9-233b-e700-ffb61f9b5b22@xilinx.com>
 <91aa574a-c668-ae4b-e560-211b9bd6580f@hs-mannheim.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <91aa574a-c668-ae4b-e560-211b9bd6580f@hs-mannheim.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15a1ad9f-e1c1-41e2-0c07-08d9ae79d99e
X-MS-TrafficTypeDiagnostic: DM6PR02MB6041:
X-Microsoft-Antispam-PRVS: <DM6PR02MB604122D4C0D125587A494423C6609@DM6PR02MB6041.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhuDOdhDw3Bd6ybeL2CVhopExKAfUAfIxRbzL5h4Lm7RWyXXD8fD079C503zO7phxO4lbnqQoIMyCDpHtXqZjyJhRcomnrzn9UfBj0D4L5sASSS2qVYQsBhvNiojv/YIGyatq/NH1kGdCDoqR5vk99SSH2XrvTR6xrb3aYh6/EWHORVvi120TM45bKaNzr4iqtim4Oxmwro4lN1uVkz/qQUTgTbxDqgB5DjTTjTudFOcezQMj/8z/b9UvhRGo5bhhG+xpTGh8vfAEy4CqWT2MdY3yaKBpcUZnsGcOxe+JQjUW6ZBLlY71HdOhxs3SVqJwcDrRnsQfNbdrR5Hn8V2izcSXwO9nkXF4eUKel7V1Ja4exfnjj68Y1zpwa3s/5eA9PfG0vATViS0tQJ1mw6bqKnR8mtzVVPiplEtx19H0xHgeDwLBZ9FYAJztmfpvRRY2OzSQo++n9kZ9hgtF/xwUgtnAQEmrPvw2P7UjsaZSHlLxsCUWTsOYXUoN8PlO2r7l2chan28qZCU5xf7gAYjeXYNotcC6d2wqoEB35kMLyaw0a3+8EfmNv30LqlmD/ZNudTmxs+3E1E1v4w6GiunKzVFP4UOpnYy+apPaYJ+v1OL4tWcyllDamw2tYs581CE7VaIlrFdC2+zynzFWWhgsrbEvmoksgevbTBmktxB9vhPIwlTSoAHs1ffvlzJMtMH1adx+nhrPNNbTZYQ/fJlqUxJBgcdwUHDxiMJNX6Zlw+wJwpj11B7pa4XKmLop08CL3wAuGLm36SSlkqOLORM/Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(7636003)(70206006)(36860700001)(2616005)(70586007)(47076005)(53546011)(31686004)(4326008)(54906003)(44832011)(5660300002)(8936002)(36906005)(356005)(186003)(30864003)(9786002)(2906002)(31696002)(316002)(110136005)(508600001)(83380400001)(426003)(15650500001)(8676002)(36756003)(336012)(26005)(82310400004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 12:07:41.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a1ad9f-e1c1-41e2-0c07-08d9ae79d99e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6041
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/22/21 23:05, Ruediger Willenberg wrote:
> Am 19.11.2021 um 11:21 schrieb Michal Simek:
>>
>>
>> On 11/18/21 22:21, Ruediger Willenberg wrote:
>>> Am 18.11.2021 um 09:45 schrieb Michal Simek:
>>>> On 11/17/21 10:53, Ruediger Willenberg wrote:
>>>>> Am 17.11.2021 um 06:16 schrieb Shubhrajyoti Datta:
>>>>>> "The uartlite is used by FPGAs that support a basically unlimited 
>>>>>> number
>>>>>> of uarts so limiting it at 16 dosn't make sense as users might 
>>>>>> need more
>>>>>> than that."
>>>>>>
>>>>>> So change the default number of uarts back to 16.
>>>>>
>>>>> The DTG should number devices for each driver separately from 0;
>>>>> serial_core.c checks for (0 <= uart_port->line < NR_UART_PORTS). As a
>>>>> consequence, when a Zynq system has both a PS-UART and a Uartlite,
>>>>> setting SERIAL_UARTLITE_NR_UARTS explicitly to 1 in Kconfig means
>>>>> probing the uartlite fails, which is confusing to the unsuspecting
>>>>> KConfig user. Setting the default to 16 just kicks the can down the
>>>>> road because it will fail for more than 15 Uartlites (or less, if 
>>>>> there
>>>>> are more PS-UARTs or AXI 16550A UARTs).
>>>>
>>>> I have no problem with your patch and it is correct (I would prefer 
>>>> a message to show for this option). But it doesn't mean that default 
>>>> 1 was correct value to setup especially when range was setup by Sam 
>>>> from 1-256. And originally number 16 was used.
>>>
>>>> That's why I think this patch is still valid. If you don't like 
>>>> description it can be changed because definitely people are using 
>>>> systems with more then one uartlite and 1 is not reasonable default.
>>>> We can also take a look at default for others serial drivers
>>>> and none of them is using 1 as default. IIRC discussion about UARTPS 
>>>> it was said if number is not 
>>>
>>>
>>> Clarification: I support changing the default up to 16. It will avoid 
>>> problems for most cases where
>>> a) there are only a few Uartlites in the system
>>> AND
>>> b) the Kconfig user doesn't explictly specify SERIAL_UARTLITE_NR_UARTS
>>>
>>> I just wanted to point out that trouble ensues when
>>> a) somebody wants 16 Uartlites in a system when there is also a PS 
>>> UART (basically any Zynq)
>>> OR
>>> b) somebody explicitly sets the SERIAL_UARTLITE_NR_UARTS to the 
>>> number she built into a Zynq system
>>> (when the Uartlite driver is activated in menuconfig, the NR 
>>> parameters pops right up, so it's mighty tempting to actually set it 
>>> to the accurate number)
>>>
>>> Moving the default up should just not be a band-aid for the cases 
>>> where a single Uartlite can not be assigned, when really there is a 
>>> fundamental inconsistency between how serial_core.c has limited line 
>>> numbering since Kernel 2.6 (0 <= line_id < NR_UARTs) and what Xilinx 
>>> DTG does with UARTs.
>>>
>>>
>>>  > And using aliases for serial id identification is around for a 
>>> while and Xilinx DTG is aligned with
>>>  > it because via current dt you can't describe cases where you will 
>>> have stable numbers for different
>>>  > tty names like
>>>  > ttyS0, ttyUL0, ttyPS0, ttyAMA0, etc.
>>>  > That's why DTG generates it per all serial IDs.
>>>
>>> Sincere apologies, I do not quite understand this 
>>> explanation/argument. Would you be so kind to rephrase?
>>>
>>> (As I'm a newbie to this list, I'm not sure how much back-and-forth 
>>> is appropriate about a topic. Since my issue here is about the Xilinx 
>>> DTG, not Linux kernel code per se, I'd also be fine to continue 
>>> emailing off-list. There does not seem to be a similar list for 
>>> device-tree-xlnx)
>>
>> A lot of drivers are calling of_alias_get_id() which returns you ID 
>> from aliases list. If you don't use it or ID is more then your amount 
>> of allocates ports you are choosing different logic how to find proper 
>> number.
>>
>> In for example arch/arm/boot/dts/at91-kizbox3_common.dtsi
>> you can see
>>
>>   24         aliases {
>>   25                 serial0 = &uart0;
>>   26                 serial1 = &uart1;
>>   27                 serial2 = &uart2;
>>   28                 serial3 = &uart3;
>>   29                 serial4 = &uart4;
>>   30                 serial5 = &uart5;
>>   31                 serial6 = &uart8;
>>   32         };
>>
>> It means uart0 should become ttyX0 uart1 should become ttyX1, etc
>> If you have all uarts the same type then everything is fine.
>>
>> But on systems like FPGAs you have different types of uart and via DT 
>> you can't really describe things like this
>>      aliases {
>>              serial0 = &ps_uart; // to become ttyPS0
>>              serial0 = &uartlite; // to become ttyUL0
>>              serial0 = &uart16550; // to become ttyS0
>>              serial0 = &uartAMA; // to become ttyAMA0
>>          ...
>>      }
>>
>> This is not allowed in DT. You can have only one alias with the same ID.
>> And if you don't use aliases order depends on probe order which 
>> doesn't need to be stable.
>> If you have only one instance of IP then you will get just id 0 but if 
>> you have multiple instances of the same IP type then order is 
>> unpredictable. And you really don't want to assigned console to data 
>> uart channel and vice-versa or mix channels, etc.
>>
>> That's why Xilinx DTG assigns number to every IP to be stable and 
>> predictable. A lot of people think that what you get from DTG doesn't 
>> need to be changed but that's not intention of DTG at all. DTG just 
>> does the best to describe the system. It is up to user to do whatever 
>> changes are required for their system. If you don't like it feel free 
>> to change/fix it.
>>
>> And in past port-number property was in spec but it not supported by 
>> all drivers.
>> I think we have also generated it for 16550 xilinx uart in past.
>>
>> Thanks,
>> Michal
> 
> Thank you Michal for kindly taking the time to explain this in detail, 
> that was very helpful.
> 
> I've now looked at this more closely and experimented with different 
> combinations of ps_uart, AXI Uartlite, mdm_uart and AXI UART16550A. 
> Relevant observations (Michal you'll know most of this):
> 
> 1. The Xilinx DTG adds the "port-number" property to all Zynq/Zynq-US 
> Cadence UARTs, AXI Uartlite, mdm_uart and AXI UART16550A (it's only 
> documented so far in the DT-binding file for uartlite)
> 
> 2. The current "port-number" mechanism in the Xilinx DTG enumerates in 
> the order in which they are listed in the MSS file generated by 
> proprietary Xilinx binaries, be it Vitis/XSCT or petalinux-config. The 
> only exception is when the MSS file declares a UART the OS 
> serial_console, then that one gets 0 and everyone else follows (this is 
> required because the DTG also always sets the kernel bootarg for console 
> to ttyPS_0_ , ttyUL_0_ , etc.)
> 
> 3. For one type of driver (uartps, uartns, uartlite), the Xilinx 
> binaries list the UARTs in the MSS file strictly alphabetically by 
> HW_INSTANCE name (that's even true if I mix AXI Uartlites and mdm_uarts, 
> which both use the uartlite driver). So the port-numbers follow strictly 
> (with the console exception) and reproducibly.
> 
> 4. The Xilinx DTG gives "serial" aliases to _all_ said UARTs, however 
> the order is different than the port-numbers/the MSS order:
> 
> 4.1. ps_uarts (and I suppose other cadence uarts) come first; if 
> ps_uart1 is declared console in the MSS, it gets "serial0", even if 
> there is ps_uart0, which then gets "serial1".
> 
> 4.2. other UARTs get higher serial aliases, however the order can mix 
> UARTs of different drivers, like Uartlite and AXI16550. This order is 
> not based on MSS, memory addresses, instance names or even order added 
> or interconnect ports in the Vivado Block Design. It is intransparent to 
> me even after looking at devicetree.tcl and seems to change with 
> different combinations of PL UARTs
> 
> 4.3. even if I declare a Uartlite as the boot console for both u-boot 
> and the Linux kernel in the PetaLinux menuconfig, "serial0" still goes 
> to the ps_uart (that uartlite becomes the first other serial*, though). 
> This is unfortunate because the early bootarg is "serial0:115200n8", so 
> all the early kernel output still goes out over the ps_uart against the 
> configuration.
> 
> 
> Lastly I would like to observe that the patch I sent in to 
> git@xilinx.com for the Xilinx DTG
> a) preserves the port-numbering in MSS order for each driver type 
> (uartps, uartns, uartlite)
> b) preserves the special port-number=<0> treatment for the UART declared 
> the OS console
> but
> c) enumerates up consecutively from 0 per driver 
> (uartps,uartns,uartlite), therefore fixing the allocation issue brought 
> into focus by the introduction of the SERIAL_UARTLITE_NR_UARTS parameter 
> to the kernel. The order is reliable and reproducible because it is 
> dependent on the MSS structure. The same is not true for the "serial" 
> alias.
> 
> Michal, as you have kindly explained above, there cannot be serial 
> aliases with the same number, and in combination with the unpredictable 
> numbering of non-cadence uarts, the "serial" alias mechanism is 
> unsuitable right now to properly deal with multiple UART types which 
> will pop up in FPGA systems.
> 
> 
> I therefore respectfully urge Xilinx to adopt my DTG patch. It does not 
> break anything and keeps numbering as reliable as it is right now, but 
> it fixes the inconsistency with kernel numbering policy.
> 
> 
> Since Xilinx tool and Linux kernel development are not synced-up, 
> changes on either side should not break the other; the DTG patch does 
> not break the Linux side. The 

/tty/serial/uartlite.c patch that we are
> discussing in the separate thread
>   "[PATCH v2] serial: uartlite: Move out-of-range port-numbers into 
> ULITE_NR_UARTS range"
> is a fix for what the DTG does right now, but does not break with either 
> version.

DTG is out of scope of linux-serial mailing list that's why I am not 
going to comment it here.

And we should strictly talk about the patch itself here but I think Greg 
should give us his thoughts on it if make sense to use free ID instead 
of ID which user specifically asking for.

And before I list options we should likely deprecate DT port-number 
property completely.

We should use DT serial alias ID for port assignment and if it is above 
or NR_PORTs just fail.

If there is no alias ID
1) you can find free ID and use it (your patch)
2) you can use the highest alias (the best for the same IP type) and use it
3) you can generate it at run time (but it was reverted from ps uart in 
past)

Thanks,
Michal
