Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE34BC43331
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D4A20737
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S89xbj3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgDCJiA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:38:00 -0400
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:11616
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727854AbgDCJiA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 05:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj2LfMQY7YCji7wq0psd0gpxZwW78A1aKOj/a7mHlh7OV/Yj0svF1JWewiTiMSckUWXcFgSjN4L13mW/s7Qjc4JK6EAqVWAP89jNPrQ773lOO55N8xBarJ+HRNF2TlwyThsQRqVyt29kOaVDUMibmd35OjX7lN6i6bS5qsELVsG8/YhHxhPUkgZX8GhfNMonObBtKqmTcI9FTNJ5Xbd0OdzK3WWw7lWhaGgV+QwrGD7tGYGvzSujUo9E9Aa5Ek14Hp/0r+ASBDecJ4X2gOTAoHTKrTkn5edREslCe7ucTFURoDGndupEG6BCRXfXatZKxD4eB5mPlTY3GYr2c0saPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuZ+3XK6s5VxjGccosAPOIstUPYkg5LiBkNqsVH9vgU=;
 b=VCbk92PCpRxiskZ711U5qGW31lQiF/waTqkXhx/sHPRis+HG0R+46rGjvUW7kdegWuQgzAUuDvrOUKP8d4dpjvVAZMX45Vh9e2C/71G6SWNQl05A8IRAwb8Z57iwr998NiqBGz/1V7+CK1WrBUqSMwEWKZBxQQUHKl5o0A51U10htwUd0WdidX9SN0u141hVRYOR8a5v6LWyKPQZ4aFRqVog0nthT8PRjm2MeVxDYHVM0siNZJhCtKneSW9QsU4qhsJ6Y/qAc9+pznvtzuTNcHayZ8irprmVoTwwwKLVrDR0XmqDmrCs11VgfhnL01iP+RrjUnRHlnWDUXA7774U3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuZ+3XK6s5VxjGccosAPOIstUPYkg5LiBkNqsVH9vgU=;
 b=S89xbj3EjMK9GoZ6nAiRtqRyA/oN80wywAD/SV+CoQRV9XmtYMErhAvv5LxpDVpJmJWOWoPI4opkJ4KOcNA4A9snruFSEbvc4XpOI2iHyiOs0CRHVfpLBCWfOhTfZYNScYerbEXT8tNVS4waoiottKY+DGPyf4gLh1MKdA+F3aY=
Received: from SN4PR0501CA0105.namprd05.prod.outlook.com
 (2603:10b6:803:42::22) by DM5PR0201MB3528.namprd02.prod.outlook.com
 (2603:10b6:4:7e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 09:37:57 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::aa) by SN4PR0501CA0105.outlook.office365.com
 (2603:10b6:803:42::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.5 via Frontend
 Transport; Fri, 3 Apr 2020 09:37:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server id 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 09:37:56
 +0000
Received: from [149.199.38.66] (port=57376 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jKIlo-0005Ec-Gp; Fri, 03 Apr 2020 02:37:48 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jKIlw-00065T-Fr; Fri, 03 Apr 2020 02:37:56 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0339bnFe012510;
        Fri, 3 Apr 2020 02:37:49 -0700
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jKIlo-00064W-P1; Fri, 03 Apr 2020 02:37:48 -0700
Subject: Re: [PATCH 0/7] serial: uartps: Revert dynamic port allocation
To:     Greg KH <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     johan@kernel.org, linux-kernel@vger.kernel.org, monstr@monstr.eu,
        git@xilinx.com, Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <cover.1585905873.git.michal.simek@xilinx.com>
 <20200403093216.GA3746303@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d9598635-a8ef-eff2-22e8-4fa37f8390b3@xilinx.com>
Date:   Fri, 3 Apr 2020 11:37:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403093216.GA3746303@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966005)(8936002)(336012)(110136005)(31686004)(31696002)(9786002)(36756003)(2616005)(426003)(82740400003)(8676002)(5660300002)(2906002)(47076004)(70206006)(478600001)(26005)(44832011)(4326008)(70586007)(316002)(356004)(81166006)(81156014)(966005)(4744005)(186003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8146496c-1f80-46e9-7300-08d7d7b2b0e2
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3528:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3528C6B78BFE934DEA28DF76C6C70@DM5PR0201MB3528.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0362BF9FDB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fh2SokYNmhk32TmFNu42CO+EwOyLk/kvRa2uiP0t6bc17XEOn2eAaym7HYtnyHCfYpBb8m3QrQHhRzdCrfTDsGmIvzoU6T6D7o9jnn0/zjDsBst8mCpGn9pHvu85N6P9IApF5FeBT9TC2SnDhlFTmVVUoV3dzKvbn+6fuNDj1zY1c5kT+gMurAs01+WXBf6MmjgVNVt5j5btaM0wG/TPa4uw7MeK6pe81awBCnWzSbgdze1ml7dli+D4Yi1BgPeYWF7JCMAjLkroSa2CLE/UamgxUguQz2DXKqzO/rTrREuDk9o8LylbArEbutzWPwUxOFYIRXXU27teHM2OA1GqjOsQz5wdW45nhr0yE7M60FF+9ttFNjSTVpZyGiRY890uqEOCYp1Xa4yZGQLl2X7DcM/Db/RPd3sPecjs6TMmjFKuzjUllcR9v16aDlfxNj+d5zWH+5B6ph/x/yyYM6hfE9nolg55LH8iSHtDOxEgIgV4e/YcG9likhCjQNT1RR4J3Usbfcz1cJ28SyJbBDgfOyBM6zoahpAOdlTfIUmPaoO43Py6tCpKySGFGsLWjvTHBvWkqqxAWgJ/D6QHQn6IIQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 09:37:56.7885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8146496c-1f80-46e9-7300-08d7d7b2b0e2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3528
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 03. 04. 20 11:32, Greg KH wrote:
> On Fri, Apr 03, 2020 at 11:24:29AM +0200, Michal Simek wrote:
>> Hi,
>>
>> there were several changes done in past in uartps drivers which have been
>> also done in uartlite driver.
>> Here is the thread about it
>> https://lore.kernel.org/linux-serial/20191203152738.GF10631@localhost/
>>
>> This series reverts all patches which enabled dynamic port allocation and
>> returning driver to the previous state. There were added some features in
>> meantime which are not affected by this series.
> 
> Should this go into 5.7-final as it's causing problems now, and
> backported as well?  Or can it wait until 5.8-rc1?

These patches have been added to v4.20. It means all version from that
are affected.

The issue I am aware of is when you setup stdout-path =
"serialX:115200n8" where X is not 0.

But as was discussed the concept is based on Johan wrong that's why it
can be consider as bug fix.

Thanks,
Michal

