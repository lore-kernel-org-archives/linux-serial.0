Return-Path: <SRS0=Up7l=ZR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C0C432C0
	for <linux-serial@archiver.kernel.org>; Mon, 25 Nov 2019 13:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524C02086A
	for <linux-serial@archiver.kernel.org>; Mon, 25 Nov 2019 13:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NIat9wkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfKYNIb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:08:31 -0500
Received: from mail-eopbgr820077.outbound.protection.outlook.com ([40.107.82.77]:34030
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727506AbfKYNIb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Nov 2019 08:08:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoEz+sDeV8qnzrKf1lhylPaA5a6sMmzKB0c6bV+9z/jkShNFEBiOzIG/NEd9vMvNuo8lYBWRMPxeWwIO7LzKnGL4bbocr/Nl63Vs62AXpucrdu04n0LyE0tBSoBHcSmx+SSycyAGY6LiV27wwxZsVhflqUk9Zdqj43qpNdmjsmeaWsaEGWkCeny60K9bgMrY02Q2W8cHLQxgulG7MORlDec3kwkMcSc0wwOxAymeoXqfIpQGDoszzbOBdHSR5/l7rCx73raSWBrtr/qXWGx4TePxpPm25wLBQWvBz4JtMTj3Z3gKIe5IQDiY1D8fR4mApssVgSDzl16ua0ukiZ59tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYNZgRjeWP2TkftRtrakI3t+jVvtOtMFzIrNZWStBNk=;
 b=DVmZIUjllLbdOuHWoLSDOz/yJGzOqilxOR3v9uNXFfc/faLpZii8SiOFL46OWP2CjoAhTm+o5GMWWzM/IB07CBtBLiG4M59upg7MAeNVMIgc7Nds4xHgkyYBHuio+C4wGEEdqrc/xZw9Z4JwDgRnvaY5FSFxr5N2EXH+WjU7CgAAAqRMyGF00c/3ubK9cf3aApO8tae561qsKXhXl9AHWTSuXPaztylJ99x8QCXE9bjmXJgh3ac8GNltIM9gTpnO0I+Q82KPltmu80BYcamNhbR7hKt2FbhOIuYDVI4UMfrUQSxuxJt357LwNRof740e67W5s/bCNmrZ2cKrZ8MQjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYNZgRjeWP2TkftRtrakI3t+jVvtOtMFzIrNZWStBNk=;
 b=NIat9wkOEcBNlWwgEf8B6kxPGGsPyLd9DwrKAB8yJG+qDRHCDG6mBLFBZx920S/XXPO4sIOXocvL18JM4Pb7ssIDydQrvFQxWDDWDWZznnbraD0j9aEJAt+QppCNsh+SX+7k3kVW7ac6HwljHVaxDYi0gK9+A0WY1rvOKPqHsIk=
Received: from CY4PR02CA0012.namprd02.prod.outlook.com (2603:10b6:903:18::22)
 by DM5PR02MB2746.namprd02.prod.outlook.com (2603:10b6:3:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Mon, 25 Nov
 2019 13:08:27 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CY4PR02CA0012.outlook.office365.com
 (2603:10b6:903:18::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18 via Frontend
 Transport; Mon, 25 Nov 2019 13:08:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 13:08:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iZE6M-0008CM-90; Mon, 25 Nov 2019 05:08:26 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iZE6G-0000w6-RF; Mon, 25 Nov 2019 05:08:20 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAPD8EVh016627;
        Mon, 25 Nov 2019 05:08:14 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iZE69-0000vO-VY; Mon, 25 Nov 2019 05:08:14 -0800
Subject: Re: [PATCHv5] serial-uartlite: Remove ULITE_NR_PORTS macro
To:     Michal Simek <michals@xilinx.com>, Johan Hovold <johan@kernel.org>,
        shubhrajyoti.datta@gmail.com
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, git@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <1573646408-392094-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <20191113153846.GW11035@localhost>
 <fbfa424b-6730-fae9-14bf-bf666e93ad28@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <379afb94-7155-aca0-b07e-86d6c4f9952a@xilinx.com>
Date:   Mon, 25 Nov 2019 14:08:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fbfa424b-6730-fae9-14bf-bf666e93ad28@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(11346002)(76176011)(50466002)(23676004)(2486003)(31696002)(58126008)(110136005)(36386004)(229853002)(4326008)(5660300002)(31686004)(70206006)(70586007)(356004)(6666004)(107886003)(426003)(47776003)(65806001)(65956001)(44832011)(6306002)(6246003)(336012)(2616005)(36756003)(230700001)(316002)(966005)(305945005)(9786002)(8936002)(81166006)(8676002)(2906002)(81156014)(446003)(54906003)(186003)(106002)(26005)(478600001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2746;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc8a9d0-7e2b-4c85-3f56-08d771a88f3c
X-MS-TrafficTypeDiagnostic: DM5PR02MB2746:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR02MB2746CC7133C6E23646DC0B5AC64A0@DM5PR02MB2746.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0232B30BBC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eH5pOaTMYP9Us05WJpcPnRwVb2PXPd4auc0lGtPpLdNvARNsS6nLVdKSo99Gxz07Wr1+cT+6tY+vAG0EXcKw+zWmRKySdbxO7VFTcSZEgO7s8VX/6WI9c/QOuFoGMgftAucZOiaQ1+S8vPlgHU9esGUl5p6mYShqQkMv+q9dmoL9M4y4T9QoaBpvRZ99ZpfTuCYNgbUeVzYdqb9Pgf9sRwCQJkPjvVxToZ4L52K2u8iYrkNzxDTCcbr/926SfTS2bRlJAdi9YQQaJFl3Cven91h1V3wWkQbvtoN6jjGhNtqe/ChI/lVOdU2HnHJmjQRGUI6Wrnhcccc6fMC+dO2hes7tMHSt1Q2RQg4vlFXoGne/aKOIXTLXG7nz/BI7ZTD3HwPDHsg+udTcSdrQTbGfkuO1HgJXOSsg6zOswRM4Q3WZQT8I+KCaNMQ/jBrH/3Me+raO6XeKPXuMwoQWMJCQh6lrBLERjw86Q7MlcHgDS/w=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 13:08:26.6628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc8a9d0-7e2b-4c85-3f56-08d771a88f3c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2746
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On 15. 11. 19 9:21, Michal Simek wrote:
> Hi Johan,
> 
> On 13. 11. 19 16:38, Johan Hovold wrote:
>> On Wed, Nov 13, 2019 at 12:00:08PM +0000, shubhrajyoti.datta@gmail.com wrote:
>>> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>>
>>> This patch is removing ULITE_NR_PORTS macro which limits number of
>>> ports which can be used. Every instance is registering own struct
>>> uart_driver with minor number which corresponds to alias ID (or 0 now).
>>> and with 1 uart port. The same alias ID is saved to
>>> tty_driver->name_base which is key field for creating ttyULX name.
>>>
>>> Because name_base and minor number are setup already there is no need to
>>> setup any port->line number because 0 is the right value.
>>>
>>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>> v4: patch addition
>>> v5: Merge the patch so that all the patches compile
>>
>> Greg, 
>>
>> Please do not merge this. This is a hack which really needs to be
>> reconsidered as I've pointed before
>>
>> 	 https://lkml.kernel.org/r/20190523091839.GC568@localhost
> 
> I think it is quite a good time to start to talk about it.
> Over the time I am aware about only one issue related to one way how to
> handle console which came recently. I was looking at it 2 weeks before
> ELCE but I need to get back on this.
> Anyway I am ready for discussion about it.
> What was said so far is that we shouldn't add Kconfig option for number
> of uarts. We could maybe hardcode any big number in the driver as is
> done for pl011 but still it is limitation and wasting of space for
> allocation structures which none will use.
> Then I have done this concept and it was merged where struct uart_driver
> is allocated for every instance separately and I really tried to get
> feedback on this as we discussed some time ago.
> 
> Anyway we are where we are and if this needs to be fixed then please
> tell me how you think that this should be solved.

any comment?

M
