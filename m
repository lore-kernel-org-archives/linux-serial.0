Return-Path: <SRS0=VfF8=BB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EBBC433E8
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 07:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167A0207BB
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 07:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ym+5dVn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgGVHSm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:18:42 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:43713
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728338AbgGVHSm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jul 2020 03:18:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2Jup5SeEUjflR5/yFvlKfHziEPvj68SBrgCOwZItZGv9cDmeM+1whd+YVFEU0UE5H5Q4OdZ5FGSTrUWbEKj5gMiRDV8XZxWWPbi2eubcfQ7glunEzhGPKs/zyzTrNDTofWTp2QtJPLgYB7acoGCyGTgwx9MYTKz2fLvYMn+yeMPQ4EChB8T6zVbDo8KZXCskR9M4a6uJA0qEYl6tr9/13eJvy8mLqTc1QX6zyfER2tHPkdIsmrHbEvaI6hQ3IMNLj8jBCcrjyLO08TTeS6qHFkGutP/vDAWHMvTGreRX967TxZuqHNUyo1d4JKf+HQCmTgmJARLyn/pfHycn8RRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9ib/z0N6Z3PIK6fsHGLX+OcD5O/e1gONd3C+xn3i34=;
 b=QA/GZW3+s7la/YgfFSxOEIXopbZxE9Bh/sIJN2mnvDGQBCHm5vL8R7Y57rWQ+gZ1vi9AE8DyTEtipqRdZDQLUvltV9YP9gD7AssYoOIlZAGdYy8/QLnQR9DN5MebvC7kvFiych126/SwMMvPSnaaieUUhFlMNHgDLzYM60DyFkAgfKtLyy2v2m3CHfA/doaE20jc/xGahaTb1NuLcNZpCFDZOZu0yVOlrnZlzCG1HVzrxAO1PeMoJdziZIRKQtpI9QDab44z+YR8D+VxalfYu5f+V7NP6BlvU1lNjxJ9N38mmSi0j0wnlDZYS1S30K+9isi7Of7jTklHJVY/PuJaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vanmierlo.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9ib/z0N6Z3PIK6fsHGLX+OcD5O/e1gONd3C+xn3i34=;
 b=Ym+5dVn9uFdpRWJbxe+HZ75L0aCDCYP3a/X8x3yNqZfn2qBAsErrKd52XBWIKvjrSOqa8Pl+zq1MhMEdq1l7ATkVb8pLuK2ctXa6fryaLm933IpI4EmsmdLYNW8r1GcPzwZ2/IiyyZIdxSjbRP+BRcq9/P3JUWNrODBrFddGT1s=
Received: from SN4PR0801CA0024.namprd08.prod.outlook.com
 (2603:10b6:803:29::34) by BN7PR02MB5284.namprd02.prod.outlook.com
 (2603:10b6:408:32::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Wed, 22 Jul
 2020 07:18:38 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::5a) by SN4PR0801CA0024.outlook.office365.com
 (2603:10b6:803:29::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Wed, 22 Jul 2020 07:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vanmierlo.com; dkim=none (message not signed)
 header.d=none;vanmierlo.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 07:18:37
 +0000
Received: from [149.199.38.66] (port=47579 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jy8zd-0002SX-5Y; Wed, 22 Jul 2020 00:16:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jy91R-0004V2-Ax; Wed, 22 Jul 2020 00:18:37 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06M7IY11017762;
        Wed, 22 Jul 2020 00:18:34 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jy91N-0004Tc-RZ; Wed, 22 Jul 2020 00:18:34 -0700
Subject: Re: [PATCH] tty: xilinx_uartps: Really fix id assignment
To:     Maarten Brock <m.brock@vanmierlo.com>,
        Helmut Grohne <helmut.grohne@intenta.de>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jan Kiszka <jan.kiszka@web.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-serial-owner@vger.kernel.org
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
 <20200709074849.GA28968@laureti-dev>
 <a3b9df28-8142-fc04-317f-44d65a24f38e@xilinx.com>
 <20200713071123.GA1994@laureti-dev>
 <e7b766ab-8c99-d30c-2352-6d7b09033537@xilinx.com>
 <20200713121019.GA6920@laureti-dev>
 <2db78149ae9ffb205f02ca4919b50d88@vanmierlo.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <c652674b-97c1-c333-0d75-ae40c3c7de49@xilinx.com>
Date:   Wed, 22 Jul 2020 09:18:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2db78149ae9ffb205f02ca4919b50d88@vanmierlo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(376002)(396003)(136003)(46966005)(316002)(31686004)(53546011)(54906003)(26005)(81166007)(47076004)(8676002)(8936002)(82740400003)(4326008)(9786002)(356005)(110136005)(36756003)(2906002)(336012)(5660300002)(478600001)(6666004)(70206006)(31696002)(44832011)(426003)(2616005)(186003)(70586007)(82310400002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfc2c0bb-1fe5-4381-828d-08d82e0f73dd
X-MS-TrafficTypeDiagnostic: BN7PR02MB5284:
X-Microsoft-Antispam-PRVS: <BN7PR02MB52841654701CF244221A4C2BC6790@BN7PR02MB5284.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/nxSxsuAPJEtzh3rMiaF61fCetZ3exDHI3wDpNZET9tbW3V6UikyufqMWNCJgLT3TbikQW6vJTi0JyGP21ee81vzaM/LsAokpw+G09K4H1TGhjw+6iwOcNfa8bk138igqBb/J3VXoRnZbiOvPezKU+Lj0i9ecofd68x7b8zB5ZskLDqzSzR5UJc4EilyTlwmFj5tgPKiFjWbHO8phU0mC1rWXaTDbEFq9qBmSPQc1CsrpgNWb6HbV/OCR6Q/SnH22ajrPh7SRKy6/UXPFPBMBpP20pGmwBPr1zRipZwM2LC9nhFzJ1BPsKBwHAH7mZoFcwJu/ttiYCJc0+Tk+9U9zxwD/w/N6K4yfP4lcqGbgwrGOr+0CSQRRRI7nms/JFI8Hqn8uvCua7cYwvCNSUUklH8qMOZzaDbvPiP3VE+N9eE36KpKM4w+hsLRT3f1Gpb
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 07:18:37.6079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc2c0bb-1fe5-4381-828d-08d82e0f73dd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5284
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 13. 07. 20 18:08, Maarten Brock wrote:
> On 2020-07-13 14:10, Helmut Grohne wrote:
>> Hi Michal,
>>
>> On Mon, Jul 13, 2020 at 01:49:38PM +0200, Michal Simek wrote:
>>> On 13. 07. 20 9:11, Helmut Grohne wrote:
>>> > Let me try to enumerate those I know:
>>> >
>>> > uart0    | uart1    | console | remark
>>> > ---------+----------+---------+----------
>>> > serial0  | serial1  | ttyPS0  | regular case
>>> > serial0  | serial1  | ttyPS1  | normal assignment, second console
>>> > serial1  | serial0  | ttyPS0  | -> Jan Kiszka, broken since revert
>>> > disabled | serial0  | ttyPS0  | use only uart1 as serial0
>>> > serial0  | disabled | ttyPS0  | regular case with uart1 disabled
>>> >
>>> > Out of these, I'm actively using configurations 3 and 4.
>>> >
>>> > Which of these scenarios do you test already?
>>>
>>> For above we are missing also others
>>> serial1 | serial0 | ttyPS1
>>> disabled| serial1 | ttyPS1
>>
>> Is it actually possible to have ttyPS1, but no ttyPS0? I think I tried
>> doing that earlier and it resulted in there being ttyPS0, but no ttyPS1.
> 
> What if you also have a 16550 (in the PL) and give it the serial0 alias?
> Or a UARTlite? The serialN alias is inappropriate to set the number for
> ttyPSn. How are you supposed to create all of ttyPS0, ttyS0 and ttyUL0
> using a single serial0 alias?

yes this combination is not possible and I don't think this is xilinx
specific issue.
I expect the same problem you have with ttyAMA, ttyS and others.


>>> serial1 | disables | ttyPS0
>>
>> I'm not sure what this is supposed to mean. When there is no serial0
>> alias, I'd expect ttyPS0 to be missing. However as indicated above that
>> is not what happens in practice. So either of these two configurations
>> seems invalid to me.
>>
>>> All of these above are just not setting any console= on bootargs.
>>
>> We usually set the console= assignment on bootargs.
>>
>>> It means mix of these combinations is tested regularly but not all of
>>> them. Do you see any other combination which is not supported?
>>
>> I'm not aware of further relevant combinations.
>>
>> Can we maybe trim down the matrix somehow? In my context, the need for
>> swapping the serial aliases arises from a limitation in u-boot-xlnx and
>> the desire to use one dtb for both linux and u-boot. It requires that
>> the serial0 alias is the console. Are there other reasons to swap them?
>> If not, maybe fixing u-boot would be an option?
>>
>> Helmut
> 
> I think that it would be better if u-boot used a "console" alias.

console is defined in bootargs which is OS specific feature. U-Boot has
no idea what ttyPS, ttyS, etc means. That's why I don't think there is
something wrong in this in u-boot. But please elaborate more on this
because I am not aware about any issue on u-boot configuration.

Thanks,
Michal

