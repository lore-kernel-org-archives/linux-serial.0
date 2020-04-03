Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA7FC43331
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A512073B
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qaEaPaM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgDCJvn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:51:43 -0400
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:54624
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727835AbgDCJvn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 05:51:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV5jL+Stacgv8bqHquAYmQ64fuRLz6wnQxhYy8br+j5qwxo+Lj8MY280C15sFedi/yD40GxLLMhCDfpMezuhJPQJnJ5cItTUv10PR/pW6g/moMNZ6b8MIJA1zJXaSUZ1q552aDbDYQeHdiPfJM/Epv9PmNLwbWFaLWH9KPne9vjZWpECXkR4SggYXvMGKt2h80LPCyMyLW8fw2qEMm391DhVxsMqB9E9Iu5ozTsWvzs2MWE+fTbR+DAmVZSnmshtAvuCvcIk3L1y0/H6HIucdUYFPgd7euW1cXm9FnoB7lv3Ak5ajDdFgwL0Zn46vVyzKBPcLiBSqmxc3+aVRxfROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8CxC9CysvUax91ITEi83DhusciphVmW+/GOmc9TvWE=;
 b=Ec7/YzrFq32f/NFB/LaOC0T+rfzfNBMgwHPSZdd0LjBuhWMIAYpp43TdJ6x+7O3EzAsaylLTDmwVYnhVLVfSywpBKOettFW4ugSXEoMfa51uUlTuu8foner8IfL02Wx4evYmDnfoSOGi2j2WPIMCCCp5pluDWEa1HFfsvHng9rjqh5rtRfV95KXYxZuZO++6FMlc1vZf7tz8mceAk6XxV+6A8G6a4GAm+JquqLv1WZu68sw1G0H93gbHQBSjOAc/Gpv7VxupMbfY5UBATxSlwUpdpppCluzjOc71/fI7Wxqf3PwssrBIihACsK/K61ENOPhOV1jnH4YVZIGi1hD9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8CxC9CysvUax91ITEi83DhusciphVmW+/GOmc9TvWE=;
 b=qaEaPaM55RixSZqMrRaU/bphfnSHi884bZxBrRX3CMUVYqFGuobGsr5QoiUS9So7UE6cAYDy8HczYDS5h1SOfonYIhAFHeNHG67hqpm07XQVL+JYAP0jIzQZS6myTGrK5XTbY+HFu7ATjP0pu3VWBquXLs1chsm5YCEwYeSRX7E=
Received: from CY4PR15CA0020.namprd15.prod.outlook.com (2603:10b6:910:14::30)
 by BN6PR02MB2529.namprd02.prod.outlook.com (2603:10b6:404:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 09:51:40 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:14:cafe::9a) by CY4PR15CA0020.outlook.office365.com
 (2603:10b6:910:14::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 09:51:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server id 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 09:51:39
 +0000
Received: from [149.199.38.66] (port=35329 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jKIz5-0005cn-FB; Fri, 03 Apr 2020 02:51:31 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jKIzD-0004DE-F1; Fri, 03 Apr 2020 02:51:39 -0700
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jKIz8-000450-VY; Fri, 03 Apr 2020 02:51:35 -0700
Subject: Re: [PATCH 0/7] serial: uartps: Revert dynamic port allocation
To:     Greg KH <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     johan@kernel.org, linux-kernel@vger.kernel.org, monstr@monstr.eu,
        git@xilinx.com, Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <cover.1585905873.git.michal.simek@xilinx.com>
 <20200403093216.GA3746303@kroah.com>
 <d9598635-a8ef-eff2-22e8-4fa37f8390b3@xilinx.com>
 <20200403094427.GA3754220@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2983dbe2-16e6-4b7b-73a6-49d8c3d70510@xilinx.com>
Date:   Fri, 3 Apr 2020 11:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403094427.GA3754220@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966005)(47076004)(44832011)(31686004)(966005)(26005)(186003)(478600001)(81156014)(8936002)(426003)(2616005)(336012)(8676002)(5660300002)(6666004)(81166006)(82740400003)(9786002)(70206006)(70586007)(316002)(110136005)(31696002)(36756003)(356004)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2505e8d-d011-4d54-2839-08d7d7b49b68
X-MS-TrafficTypeDiagnostic: BN6PR02MB2529:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR02MB2529BBF402084DE7DA248B71C6C70@BN6PR02MB2529.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0362BF9FDB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WlbnwymdSicHLFSRUgkXD23Y7EVSPPtzs0ok0HqXJFJPKrvXxCVQa8xoxdZF2ujwRNefBY6Zn0JAlBZEswv0OUnqomPN03paF1GdJUG+XSVEohm8ipry/E3lKVUWk54KPKcALqmhDVF0pKsF2pAS+EAXQNZgedQ92YdKZ8Fy2ROqTTEA0owGrRzW+g/DQL0+d8aOnxyFJRo1DojD/T+RxstbLpwE+lUwy9BKzrmBCJJZu/Pl7eABAF8KxK+zekSnlu6KzmfQe8hpOHuGnplAL1XD/d98FBrbkhPQUrBGk5C9GCdb1/EyLhlPb/hQPI/dg73F58W/U6hUmDsL1DlAlZ+zeKGhe6WbfAb1k2kB/p6w58r3gEJq2AxXsxMSWEEyB4PugEEvWDwA4Ff7iA6/VcBIDO2YxU+WN9pMnfD68WzQMooJPNtldI/6363x/XWgCWKisbIA5gykV79NfJggHkdH3thFeH4K3n/X4ZCLY9nLdfHC9sK8cJcN5rEsXt68A4Zo6JmAoC8/Ilr3Ud8ABTJb0HkIB+XdX5/q8LNCo6LR2xDIbkgLXOspkvPq1KPrrwa/Pd2q1jZefTB3B4Ryg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 09:51:39.7484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2505e8d-d011-4d54-2839-08d7d7b49b68
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2529
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 03. 04. 20 11:44, Greg KH wrote:
> On Fri, Apr 03, 2020 at 11:37:46AM +0200, Michal Simek wrote:
>> On 03. 04. 20 11:32, Greg KH wrote:
>>> On Fri, Apr 03, 2020 at 11:24:29AM +0200, Michal Simek wrote:
>>>> Hi,
>>>>
>>>> there were several changes done in past in uartps drivers which have been
>>>> also done in uartlite driver.
>>>> Here is the thread about it
>>>> https://lore.kernel.org/linux-serial/20191203152738.GF10631@localhost/
>>>>
>>>> This series reverts all patches which enabled dynamic port allocation and
>>>> returning driver to the previous state. There were added some features in
>>>> meantime which are not affected by this series.
>>>
>>> Should this go into 5.7-final as it's causing problems now, and
>>> backported as well?  Or can it wait until 5.8-rc1?
>>
>> These patches have been added to v4.20. It means all version from that
>> are affected.
>>
>> The issue I am aware of is when you setup stdout-path =
>> "serialX:115200n8" where X is not 0.
>>
>> But as was discussed the concept is based on Johan wrong that's why it
>> can be consider as bug fix.
> 
> Ok, I'll queue these up after 5.7-rc1 is out, for inclusion in
> 5.7-final, and cc: for stable, as I agree, they should all be reverted.
> Thanks for doing the work.

Thanks. I am definitely interested to hear more how this could be done
differently because that hardcoded limits are painful.
On FPGAs you can have a lot of uarts for whatever reason and users are
using DT aliases to have consistent naming.
Specifically on Xilinx devices we are using uartps which is ttyPS,
uartlite which is ttyUL, ns16500 which is ttyS and also pl011 which is
ttyAMA.
Only ttyAMA or ttyPS on one chip are possible.

And right now you can't have serial0 alias pointed ttyPS0 and another
serial0 pointed to ttyUL0 or ttyS0. That's why others are shifted and we
can reach that hardcoded NR_UART limit easily.
And this was the reason why I have done these patches in past to remove
any limit from these drivers and if user asks for serial100 alias you
simply get ttyPS100 node.

Johan mentioned any solution use in USB stack but I haven't really had a
time to take a look at it how feasible it is to bring back to all drivers.

Thanks,
Michal


