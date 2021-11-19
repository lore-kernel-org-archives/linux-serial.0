Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C8BC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 10:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA7561B31
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 10:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhKSKYo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:24:44 -0500
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:51905
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233172AbhKSKYo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 05:24:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl7oGaCY1xA22fzFD7w8CvQqTM40ya6iJhmdfhbMn8McEZ5TIPosOJDH9ya8z1q0qiB6hCCdbpDifDKd9wHX/BHeGO1kBv4z2lTkN/01MowLvBauL6FzgW1+xGcgbU7jm6D+U85jM+MWFgVyuOnsArU9Jfarc3q8Qj9Cuvxvy6Nq923lv9F3zsCXJ5WjJYcasB3GFdGsQ9u6p2k5LypZG4Cfg4M0y0NJcn+TX/Tr1HoPf9xNki5ujBnx154o2lr5cpWNtzM0O0XFRekRREuGcwLKOTy7fJdY0QwKgSawmzurJXBhXua4ZJFn9bzdW7D4wOPrx5g5QJpqZftlgS66Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O00E3CGAoRohEMoMRg0YlYmkQ1kDzGVIzt9QrYvA80Q=;
 b=NBXQyCXqHTS46e22obopirbq5G2BtMX5BeqCwA1DAZesfthuAY6Vq9OCQkJWJEPapImpMk9eoULhaoGJJkZDq2QopgSnvLrsByepwoRggxnWAwDCnZKb6OP1wZ8LzMOefhnjfi/ASd0F536Ypew0et/v+K9BJLIqNphzjqD4a6Lc1vlXmc0hTfBXEdaSLyYJRIE5JjKOtBNR90sb2xvHOhMzp+qqbLXWnB8uo5TZXkYaEN/eMP5IUWiSWeqn/gEjX9mV4SVsNOqpoXXRkhMowH5Em+Z9psbsonGtyZY3x91ApM/02C+fH98SpiP4bC33JL2Eqt1sSxQ5/uYSIqoGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=hs-mannheim.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O00E3CGAoRohEMoMRg0YlYmkQ1kDzGVIzt9QrYvA80Q=;
 b=UZVahFmE033cgtg/UAzSqGlOlTbF/AHu2fM+Lh1Cyt0In76WfhZ9YlbvagqcUFvEsGOfQGkJNiMeKbw8LAhsWzIjG6yruabU2xx9RvW5XchBhLrG7lKmX2kr0DCR3Zr6ZvfziYfB1ySELZi3egEDqSww1Yqv3rvYFY4t6NyUwyM=
Received: from SN7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::15)
 by MN2PR02MB6269.namprd02.prod.outlook.com (2603:10b6:208:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 10:21:40 +0000
Received: from SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:124:cafe::f8) by SN7P222CA0017.outlook.office365.com
 (2603:10b6:806:124::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 10:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0060.mail.protection.outlook.com (10.97.4.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 10:21:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 02:21:37 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 02:21:37 -0800
Envelope-to: git@xilinx.com,
 r.willenberg@hs-mannheim.de,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.254.241.49] (port=53034)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mo11V-0003Xr-1y; Fri, 19 Nov 2021 02:21:37 -0800
Message-ID: <74bba210-dcf9-233b-e700-ffb61f9b5b22@xilinx.com>
Date:   Fri, 19 Nov 2021 11:21:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
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
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <e01371cd-de45-cf9d-191a-c088df43566a@hs-mannheim.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dc05f82-43c6-493a-e6a6-08d9ab465f4b
X-MS-TrafficTypeDiagnostic: MN2PR02MB6269:
X-Microsoft-Antispam-PRVS: <MN2PR02MB62699411AA9199FE78486981C69C9@MN2PR02MB6269.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7cnRp+93zhIxgpQxTlIIcMbg6W/alvUSpsY0IActlsImCdL1TbGsUGQaOTuUc74E4w0L8puLM4zidxTB3OYCkAzX4RZtJj8y/3uRWP40kvoyfK8j9W5BaMLovRdAB9gHWlT5YrLLFO8QK3dOFGLO0dYcYWbJ6/hVVccIG4vfsy3Yv8M3GtAapcdZIZa81Y+7LrM+YxTQHQmp3/to1IEZsihx/Tot9qQXLUma2pHKx+9/w8WWU09T9KkfdYjivfUFVCN2Ci9TpIdtcS90pHz4YhHyobaCIXD/wAJVkxTj3WydjXMYbIlkpiyVg3pKAnT+NDaermD8nep/Dv6JJcSl2tiYU4kPXFDXklkqfBgXQlvUy9WdiBu035oGXT4VAlwASXVVXmHsfPsKhHo9BJXduB9XFg9e3QcZnWOZbuwUOExyImeyKtzWAFzq22Oo7ge+X5ckJ4Kli81cMweHOZFX+JFYcIbDqDQJ0Xxa1xAnN1SleX1TvDX4Y+GsNUB85OhfeDEdiL7m+gvSE1807+71xYNuMJNZm40nZNjIqikMVV1TkwAXB4AywRHTaQMAGvU3MtqlSTcAlDD3ds6WcimnTDMU3UT50k/jLnEMOwRQSQzocj8pj30KNHSwTUTu/gbEN3B8JAhBQSmnWV6ebP2w3EfwfOyGEPgHS5TIvjCP8e/sSehjDb9rX0WU62ep6pBoSt4qm5uCtTLp9RLGPD4ys4GqzNGn/fy6ybrBitX4Yf0jvWZvM3CYzbBnHJaSnjMlfQZOx4coAJdsQT5xufxPw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(82310400003)(36756003)(7636003)(356005)(70586007)(36860700001)(70206006)(8936002)(4326008)(47076005)(26005)(83380400001)(186003)(8676002)(44832011)(31686004)(15650500001)(2906002)(336012)(316002)(54906003)(53546011)(36906005)(5660300002)(426003)(110136005)(31696002)(2616005)(9786002)(508600001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:21:38.3706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc05f82-43c6-493a-e6a6-08d9ab465f4b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6269
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/18/21 22:21, Ruediger Willenberg wrote:
> Am 18.11.2021 um 09:45 schrieb Michal Simek:
>> On 11/17/21 10:53, Ruediger Willenberg wrote:
>>> Am 17.11.2021 um 06:16 schrieb Shubhrajyoti Datta:
>>>> "The uartlite is used by FPGAs that support a basically unlimited 
>>>> number
>>>> of uarts so limiting it at 16 dosn't make sense as users might need 
>>>> more
>>>> than that."
>>>> the commit also said that number should be unlimited. However it set 
>>>> the
>>>> default to 1 instead of 16.The original 16 written in driver should be
>>>>   quite reasonable default to cover most of the cases.
>>>>
>>>> So change the default number of uarts back to 16.
>>>
>>> The DTG should number devices for each driver separately from 0;
>>> serial_core.c checks for (0 <= uart_port->line < NR_UART_PORTS). As a
>>> consequence, when a Zynq system has both a PS-UART and a Uartlite,
>>> setting SERIAL_UARTLITE_NR_UARTS explicitly to 1 in Kconfig means
>>> probing the uartlite fails, which is confusing to the unsuspecting
>>> KConfig user. Setting the default to 16 just kicks the can down the
>>> road because it will fail for more than 15 Uartlites (or less, if there
>>> are more PS-UARTs or AXI 16550A UARTs).
>>
>> I have no problem with your patch and it is correct (I would prefer a 
>> message to show for this option). But it doesn't mean that default 1 
>> was correct value to setup especially when range was setup by Sam from 
>> 1-256. And originally number 16 was used.
> 
>> That's why I think this patch is still valid. If you don't like 
>> description it can be changed because definitely people are using 
>> systems with more then one uartlite and 1 is not reasonable default.
>> We can also take a look at default for others serial drivers
>> and none of them is using 1 as default. IIRC discussion about UARTPS 
>> it was said if number is not 
> 
> 
> Clarification: I support changing the default up to 16. It will avoid 
> problems for most cases where
> a) there are only a few Uartlites in the system
> AND
> b) the Kconfig user doesn't explictly specify SERIAL_UARTLITE_NR_UARTS
> 
> I just wanted to point out that trouble ensues when
> a) somebody wants 16 Uartlites in a system when there is also a PS UART 
> (basically any Zynq)
> OR
> b) somebody explicitly sets the SERIAL_UARTLITE_NR_UARTS to the number 
> she built into a Zynq system
> (when the Uartlite driver is activated in menuconfig, the NR parameters 
> pops right up, so it's mighty tempting to actually set it to the 
> accurate number)
> 
> Moving the default up should just not be a band-aid for the cases where 
> a single Uartlite can not be assigned, when really there is a 
> fundamental inconsistency between how serial_core.c has limited line 
> numbering since Kernel 2.6 (0 <= line_id < NR_UARTs) and what Xilinx DTG 
> does with UARTs.
> 
> 
>  > And using aliases for serial id identification is around for a while 
> and Xilinx DTG is aligned with
>  > it because via current dt you can't describe cases where you will 
> have stable numbers for different
>  > tty names like
>  > ttyS0, ttyUL0, ttyPS0, ttyAMA0, etc.
>  > That's why DTG generates it per all serial IDs.
> 
> Sincere apologies, I do not quite understand this explanation/argument. 
> Would you be so kind to rephrase?
> 
> (As I'm a newbie to this list, I'm not sure how much back-and-forth is 
> appropriate about a topic. Since my issue here is about the Xilinx DTG, 
> not Linux kernel code per se, I'd also be fine to continue emailing 
> off-list. There does not seem to be a similar list for device-tree-xlnx)

A lot of drivers are calling of_alias_get_id() which returns you ID from 
aliases list. If you don't use it or ID is more then your amount of 
allocates ports you are choosing different logic how to find proper number.

In for example arch/arm/boot/dts/at91-kizbox3_common.dtsi
you can see

  24         aliases {
  25                 serial0 = &uart0;
  26                 serial1 = &uart1;
  27                 serial2 = &uart2;
  28                 serial3 = &uart3;
  29                 serial4 = &uart4;
  30                 serial5 = &uart5;
  31                 serial6 = &uart8;
  32         };

It means uart0 should become ttyX0 uart1 should become ttyX1, etc
If you have all uarts the same type then everything is fine.

But on systems like FPGAs you have different types of uart and via DT 
you can't really describe things like this
	aliases {
             serial0 = &ps_uart; // to become ttyPS0
             serial0 = &uartlite; // to become ttyUL0
             serial0 = &uart16550; // to become ttyS0
             serial0 = &uartAMA; // to become ttyAMA0
	    ...
	}

This is not allowed in DT. You can have only one alias with the same ID.
And if you don't use aliases order depends on probe order which doesn't 
need to be stable.
If you have only one instance of IP then you will get just id 0 but if 
you have multiple instances of the same IP type then order is 
unpredictable. And you really don't want to assigned console to data 
uart channel and vice-versa or mix channels, etc.

That's why Xilinx DTG assigns number to every IP to be stable and 
predictable. A lot of people think that what you get from DTG doesn't 
need to be changed but that's not intention of DTG at all. DTG just does 
the best to describe the system. It is up to user to do whatever changes 
are required for their system. If you don't like it feel free to 
change/fix it.

And in past port-number property was in spec but it not supported by all 
drivers.
mpc52xx_uart dt binding used it (mpc5200-psc-uart v2.6.20)
ucc_uart and uartlite.
I think we have also generated it for 16550 xilinx uart in past.

Thanks,
Michal
