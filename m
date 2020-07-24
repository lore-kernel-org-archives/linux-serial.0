Return-Path: <SRS0=jxo+=BD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A2C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 08:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2399920674
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 08:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="T+nPSWHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXInQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:43:16 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:43233
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbgGXInQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jul 2020 04:43:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjB3dJZAVO8u44yXbfYqhILMskH4zK36bFkmaqjXR1G+EkDckaYSsT/2iic5Szouomi4SpCvVCDVQGsCJ9v8FEKtk1ZFc8sqYEDBlwjdfKzrC7W/bdmLCaaYfKmIEzinZVYfDKRO5CjXSlajhGZxBBoim12rrhIctGlFjIKf4fslulU2eMrLWYzpzYyVdEPWSqlSxQ5lUyz2DIpiwlLpT1RExtW0wSk29K0Ih7YIdo1+no/TgQjjAsauVHDgAWU7WyH4XcNNNlwytz61iYQusq6xpJ61uz82oWzf8paupQSTk+k9bqMWWAq2FjgDxNpH7F4QYtQG99CW1wolEXM9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/R0Lop24sW1nSXgYqEbBwiWiuGa26Nzjk3EmYxXWgX0=;
 b=RzxGOjWi9iUYw6DQDLJuXHEW4R2JBeORmsxVYoQnklue4TIiacyEK58UAutowoyLF7xNBqneWhpTP6PQQ0+Bi6t7AzC8oRuupeIrr2hESKx6b3porHMphrBM2hn+a5Gsz7ljJjUXOsMXXVnd0GXuWqpBrr34xP+VCCzkn8qThSKBUmm00RLPXMJUsOiS+/epbVVAJXVHPoimlZDv26WvvQ27SIHjIyH2hsOFkZfh8DDtGDgvp6sbY+7acyeoc+bkVv2tM9trNg36khDbo36xjd4jpqrU7uG5EGvwwNos6+87nNlmeuODlBZifvrIudhRvMcH0oaDCiHgp3fBzg+g7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/R0Lop24sW1nSXgYqEbBwiWiuGa26Nzjk3EmYxXWgX0=;
 b=T+nPSWHlSXEvLPokvkq0mRPdO3EsrbYuLJ65QexM4Q1U8uXJpFg1jogFbPjqGaO6SmOD054aTBgHsJTAfMhUWs4tgtry4hbxETmqfJg3jTflDzeeLkRQtidjIeGcGuEZFGNygRiQGePiW3mGD1q9Fwc3T2nsSviDq0yZcAILw74=
Received: from SN4PR0601CA0021.namprd06.prod.outlook.com
 (2603:10b6:803:2f::31) by BL0PR02MB4851.namprd02.prod.outlook.com
 (2603:10b6:208:5b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 24 Jul
 2020 08:43:12 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::1c) by SN4PR0601CA0021.outlook.office365.com
 (2603:10b6:803:2f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 08:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 08:43:12
 +0000
Received: from [149.199.38.66] (port=38384 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jytGX-00087X-4E; Fri, 24 Jul 2020 01:41:17 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jytIO-0000x4-5j; Fri, 24 Jul 2020 01:43:12 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jytIL-0000wj-P9; Fri, 24 Jul 2020 01:43:10 -0700
Subject: Re: [PATCH] tty: xilinx_uartps: Really fix id assignment
To:     Helmut Grohne <helmut.grohne@intenta.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jan Kiszka <jan.kiszka@web.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
 <20200709074849.GA28968@laureti-dev>
 <a3b9df28-8142-fc04-317f-44d65a24f38e@xilinx.com>
 <20200713071123.GA1994@laureti-dev>
 <e7b766ab-8c99-d30c-2352-6d7b09033537@xilinx.com>
 <20200713121019.GA6920@laureti-dev>
 <7fea9efe-f439-33a3-966f-4215681ec4c8@xilinx.com>
 <20200723095030.GA23929@laureti-dev>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <2a3ad292-0c43-ec49-0d2d-ae1342e5e1e7@xilinx.com>
Date:   Fri, 24 Jul 2020 10:43:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723095030.GA23929@laureti-dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19249e9d-f3b6-4920-fdd7-08d82fad998a
X-MS-TrafficTypeDiagnostic: BL0PR02MB4851:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4851F535B98682A712E9C181C6770@BL0PR02MB4851.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mg/hRlWqyJGhYCvA5KMB+/eqHz1K7OnOXz4ixfmrUyF+mc/ZpMuBNzzplO96P8gnEd9jL8dAa9qSR19kIIcyPg7tezXhfsMJqPVq5IIM18/2aQ2RcVHrGqkpYCPfJ4E+/ClEFp9bkl2yfv8MNaoUVXj6FHqFlZ3dPmDKVHFXkgiHAI0NpqOp3a2xe+gpPD+WJBJe/CYayNJN0aUVSy92TqJy2G8Ms1XcxapIk300LJ3HaAaz7iSJyRFJGC8Iy2BT0r+tjUpLEUKUoMmgXnyZ6xygFebSEPlar23IOzx6w0phJAA4ZL27/hBhA0+E4GIrkGrBizkwQp2Rp4TIG0Yc/jtwJQj9gXc04f6wFAWtxzaNayaRe5JcK/PJX9SDk176hQqgP8wEc3sfZBYntzNF0CWgKPSKHPuhvtC538Dlush6CTf2bOjiPjJqzDdxfeo
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(346002)(136003)(46966005)(4326008)(83380400001)(356005)(5660300002)(478600001)(47076004)(336012)(82310400002)(81166007)(36756003)(82740400003)(426003)(2616005)(44832011)(2906002)(31686004)(70586007)(316002)(6666004)(26005)(8676002)(31696002)(110136005)(54906003)(186003)(70206006)(8936002)(9786002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:12.4715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19249e9d-f3b6-4920-fdd7-08d82fad998a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4851
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 23. 07. 20 11:50, Helmut Grohne wrote:
> Hi Michal,
> 
> On Wed, Jul 22, 2020 at 09:14:40AM +0200, Michal Simek wrote:
>> On 13. 07. 20 14:10, Helmut Grohne wrote:
>>> Can we maybe trim down the matrix somehow? In my context, the need for
>>> swapping the serial aliases arises from a limitation in u-boot-xlnx and
>>> the desire to use one dtb for both linux and u-boot. It requires that
>>> the serial0 alias is the console. Are there other reasons to swap them?
>>> If not, maybe fixing u-boot would be an option?
>>
>> I am not aware about any limitation in u-boot in this space. U-Boot is
>> working with aliases and also with stdout-patch selection.
>> Can you please elaborate more on this?
> 
> I have retested this (with more recent versions than earlier).
> 
> I confirm that u-boot correctly deals with aliases and
> chosen/stdout-path. Using linear aliases and assigning stdout to serial1
> works.
> 
> I also confirm that having ttyPS1 without having ttyPS0 works (only
> tested with this patch applied). I questioned this earlier.

Thanks for confirmation.

> 
> So it seems that the need for reversing these aliases is less strong
> now. If I remember correctly, Jan Kiszka was also using reversed
> aliases, but I don't know why.

ultra96 is using both uarts. Where physical uart0 is connected to
bt/wifi TI chip which requires flow control which needs to be done via
PL (really just wires in PL). Physical uart1 is used for console.
That's why I have decided when I was describing this DT to use aliases
that ttyPS0 will be console and ttyPS1 will be connection to bt/wifi chip.

It is more convenient to have console named as ttyPS0.
I think I have seen that some SoCs are simply not changing orders for
IPs and all the time uart0 is serial0, etc. and it would also make sense.
But I have never start to use it and mostly for historical reason Xilinx
SW didn't handle consoles on ttyPS1 properly that's why console were all
the time pointed by ttyPS0 no matter which serial IP was used.

Thanks,
Michal

