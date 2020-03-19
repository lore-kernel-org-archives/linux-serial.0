Return-Path: <SRS0=NQQO=5E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4758FC4332D
	for <linux-serial@archiver.kernel.org>; Thu, 19 Mar 2020 09:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC3720724
	for <linux-serial@archiver.kernel.org>; Thu, 19 Mar 2020 09:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OC+Bl6B3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCSJpM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:45:12 -0400
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com ([40.107.94.60]:54336
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726188AbgCSJpM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Mar 2020 05:45:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsTjg3EU9kQOIPX6k5Ago00TbeMw+d2HO/ErgMRmeXno0cq024xwBTLWhF488WsCvWfRUn9B3vRqaFWfKIu276euFpVCxuFLOpu645oha2j6B0+62mFnh6LRQ2Hf4OoX6rT8HsB9u2ICm3GHohh6cZzl4FC9OwwXrFLq0NH85vDlOy8C/XnlnO5F/JWlgV0A1ZXrlbvjYxcftSHNLJWXdYbEnYxiNmDQGPAePMtByARdb97EGM/TVtDgtdShhdITlNueSDBB0/xgEXNJcktpWkONTbzbXepMHagpEz1sitHajpTRr1UKVZqyuMpgwl3jizRKHiyfE3pRofsI60DC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tl6o7xNQmLpO0cUbEkP69auTjrihKMgti8Eay4yrsQ=;
 b=GVn2eZsj++cPOwRUal9inMZbFXvMQpVUBXqXX7rInAnxxSFgWDJWp3j1ZcLPNDKcTE88x/EABF/WouA36mylkeUSF/6tYJMlkBuftFNR2WFXy7ObfTTTdp7v7dON9IeNaAcE05A3KeyaXDZyqCQf6nCpNYZ7XUsNkDB5Mn61NVuGcdXIYLcuJVCsCI71+D0qZPpf/B3+75oITriapWMDZpzZ9XnnxpMoHyd3CGmf3H677YWi/oTv19WrirNeNkNAhKH+otxdSTlJTk+eYOJCRkV6LNRFJnDfLZ30RtENCBQdf65yLwckWdt8HFR7q2hbuBmyLtuy+kpUQqTqZyMBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tl6o7xNQmLpO0cUbEkP69auTjrihKMgti8Eay4yrsQ=;
 b=OC+Bl6B3ZWdIKH90OUzNUOCsAkpQjicTMsPcpDzPuE30DF+Vih8RJJCDMUuu/KCvzVIKFELbeH0ghJVZ+KDVzKZNsAvOGc/0F4uDADATGXl4wEd8ktMsF92crEwE7NyTFHoWiYQcc126GFba6k++fzIW+ru7VRjvvTydN3O3bz4=
Received: from MN2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:208:23c::7)
 by DM6PR02MB5931.namprd02.prod.outlook.com (2603:10b6:5:156::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Thu, 19 Mar
 2020 09:45:09 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23c:cafe::d9) by MN2PR18CA0002.outlook.office365.com
 (2603:10b6:208:23c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Thu, 19 Mar 2020 09:45:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2814.13
 via Frontend Transport; Thu, 19 Mar 2020 09:45:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jErjg-0002Y7-A2; Thu, 19 Mar 2020 02:45:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jErjb-0008W2-6T; Thu, 19 Mar 2020 02:45:03 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 02J9isr7018582;
        Thu, 19 Mar 2020 02:44:55 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jErjS-0008NZ-CA; Thu, 19 Mar 2020 02:44:54 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v4 0/2] serial: uartps: Add TACTIVE check
Date:   Thu, 19 Mar 2020 15:14:49 +0530
Message-Id: <cover.1584610774.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(199004)(46966005)(81156014)(6916009)(81166006)(478600001)(107886003)(5660300002)(8936002)(36756003)(4326008)(7696005)(316002)(426003)(70586007)(47076004)(4744005)(8676002)(2906002)(26005)(9786002)(356004)(44832011)(336012)(2616005)(186003)(70206006)(6666004)(136400200001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5931;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebc13ffd-eb66-413f-33e7-08d7cbea364e
X-MS-TrafficTypeDiagnostic: DM6PR02MB5931:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5931EFA2CDF747CED72043BDAAF40@DM6PR02MB5931.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0347410860
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3gjR+P5eAVZGJFtfrQrxIeiR0BEW6Apvk6WTZAVR+r7zFF7tsfI+8JHNqMvqq81juvP30P82GZwMAJFOWF3w6ENA6au/mEA+ouqSKr9dyhxTTJ7Ueo6/jDCr4kACEEbHHpP2kMzRuFTX8KmVkVbM4XJwdz2YYdf9pH0RGQD8/C+BS6dt4nuPf3nJTMOWyB2F3BQ7di4Df7wDn3Rz8Vh3cxfJZhV7avDdkHXAu3twstO0dkGLeiVMwvfjwqROwba2e6ePPLHhoLlEAv/w9TDc+klgDdR22wCUvZdMQUAnYHyciIIKdlT7W4ycHTyUd1JZarN/XtOMtfKx5quaVvEXIMJyOpH1oDwATI1Q+naxlUTp3Ch4kUogkDH9FIwpyo4lj8qzJK1G77Lhsgzucsj5E42/EYmHOak7tPnd/ufFq80EgTKofINnvvTzgPCXspLsVWNcPPzxBBo3DwItwSi9HfCV+NGrRfjuK8r/HDx7N5vsUo8xi/uIt170Nw/lA5qhxG72CqQ6IQp1UJD1xYEL4OCqkJpAdminKZd8kNTdMKn6q3gYhanfSRIJoyzZtrB
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 09:45:08.8353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc13ffd-eb66-413f-33e7-08d7cbea364e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5931
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


The cdns_uart_tx_empty function is currently checking oly for tx_empty
bit of SR. In some environments, it is leading to a corruption in log
because tx_empty does not gaurantee that all the bytes are transmitted
out of the FIFO. So, add TACTIVE bit in the check.

This patch series does the following:
-Remove unconditional wait for tx_empty inside set_termios function
-Add TACTIVE check in cdns_uart_tx_empty function

Changes in v4:
-Split into two patches as suggested by Johan

Raviteja Narayanam (2):
  serial: uartps: Remove unconditional wait inside set_termios
  serial: uartps: Add TACTIVE check in cdns_uart_tx_empty function

 drivers/tty/serial/xilinx_uartps.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

-- 
2.1.1

