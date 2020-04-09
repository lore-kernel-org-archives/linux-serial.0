Return-Path: <SRS0=pwFA=5Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E870FC2BB54
	for <linux-serial@archiver.kernel.org>; Thu,  9 Apr 2020 06:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CF92072F
	for <linux-serial@archiver.kernel.org>; Thu,  9 Apr 2020 06:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KeiGpunm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgDIG1F (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:27:05 -0400
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:25249
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbgDIG1F (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Apr 2020 02:27:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbEmVxRo2uLPkOhFq4SeDWAcxvgXHp2xggZIuPKOeSf5uW3FNF+nYWYmSZuPlwSzWM/qOcUc7xEZBPre8YrcXwbLsJFO7taC0liAg+dN5oHC+mO/AIc1cPtloSpS9Vfh/x2m9M3yxW2BbgMifW3PZ6D6s6n0YdVxNfe3QnMKu+J519x05fAdNKBEBiGiE9K3Yi1AIvrhxPXE5u/SoqaaUg+ss0B4TfHhOcvcZtZZpqUXd6P8xJpRK/4XEQ4LC91RoYBhAPPIVNaHRI9qCI3vm/Fj7pHe+W9q29ebnJ/s2fjEvnfG89TPS9q34O6AL+2soSciTjSwRn13AU9GSdd3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE4EPTUvwRkWpdok9e5fRR5hwdY6Vz7h0vKa9MyQC58=;
 b=Sw8+ft9VEqIheSIxOnx+chx2MwS/jhyRPKHQUvKM95uAaaLlW23gMzv5V76HeA+S1gNDpKv4x/SkGIME64OKVTgknlZKOVR60vbjKx1Yb/QGQaz1bDpquuDf5lsgESYxSxJF6dZmbqG7MOFoZ+EFY1isiSWevH8ocOHR0F14KtArbnns34ColGQ8ftMMfWeAY2l+IQ1gPVnVvZqdVdOfk/dUeB+albPLnEkbOoigmNWF0tSme3HUitcFE2c4w1PfToNKn/9dAQDbHymJ4xm/rRqjD4x4ceZJML0BzUqkkfFNMaq++GArp7NgK7eBMHQURxlSK7sM3k8NJFHmMh6uag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE4EPTUvwRkWpdok9e5fRR5hwdY6Vz7h0vKa9MyQC58=;
 b=KeiGpunmN3w/EviQO3BE6kuhiHbcyV6kctJfwyacylv/gdfBgMQLAD/PzzzV/l02s/PJx5ZnYESiu3cVMHNd8zmGLB8mvf3DE9COObZC0xWIHhgGLa8uwv/jJB3tDjmSTWmHLh6+CxZbvVUqiltlzgmGdK2DE2uDAMBBhl+juEc=
Received: from CY4PR08CA0035.namprd08.prod.outlook.com (2603:10b6:903:151::21)
 by DM5PR02MB3321.namprd02.prod.outlook.com (2603:10b6:4:6a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 06:27:03 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:151:cafe::e0) by CY4PR08CA0035.outlook.office365.com
 (2603:10b6:903:151::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 06:27:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 06:27:03
 +0000
Received: from [149.199.38.66] (port=46784 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jMQe6-000876-7Z; Wed, 08 Apr 2020 23:26:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jMQeV-0004bN-4n; Wed, 08 Apr 2020 23:27:03 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0396QqC8027519;
        Wed, 8 Apr 2020 23:26:52 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jMQeK-00046h-91; Wed, 08 Apr 2020 23:26:52 -0700
From:   Raviteja Narayanam <raviteja.narayanam@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Subject: [PATCH v2 2/2] serial: uartps: Use cdns_uart_tx_empty in console_write
Date:   Thu,  9 Apr 2020 11:56:03 +0530
Message-Id: <1586413563-29125-3-git-send-email-raviteja.narayanam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586413563-29125-1-git-send-email-raviteja.narayanam@xilinx.com>
References: <1586413563-29125-1-git-send-email-raviteja.narayanam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966005)(47076004)(70206006)(356004)(6666004)(8676002)(316002)(4326008)(36756003)(478600001)(44832011)(2906002)(186003)(107886003)(81166007)(81156014)(2616005)(5660300002)(82740400003)(4744005)(70586007)(336012)(9786002)(426003)(7696005)(6916009)(8936002)(26005);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a18bb384-b73b-4a9e-1681-08d7dc4f049e
X-MS-TrafficTypeDiagnostic: DM5PR02MB3321:
X-Microsoft-Antispam-PRVS: <DM5PR02MB33213F2E3DFC01F4E59DBA0DCAC10@DM5PR02MB3321.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:272;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8UDQdxZL2mu7BeS+H+mul1PCbHGmSSVXPoc3R8Aeuq+Ei3/s+winiK4/61h0HKJNtjtTYcWtHsYAfxhrtzkfjvlycvofoNfsogOFPFeu7f+Zhb1E65oYru8rMDBZv7M5QkJz1FMyVl2/2EBgrIqdsyw+7O9PToyCBej79VgZ/j0japPeX1plUO6Ph1zvPLI/3Q8HaryM9tkrplerew5W3gYkxrzBGr4ucZ4wagUXFHEAU3ayp3SW/Ny1XYj0NdIcziYteJ8umr+Kk1uydH8IfPvrK2/YlorEtnkj/ftzWr4v8lRBNitKj26mPfTCv6VR6EsZVJOhmyplU+LRpxvJpo5QdSzqZ9U9ZZCVZh49TcwsZaFU9BAPKW4Zj+orYnjDHsWasKJJFYpj1aWTax1cxN8pKkJ3RKHDpA+uCTcxNJB+vmXLOirfGNFCEgrkTzZ7XzVTCa+78KwMoa1yIIhQKv/LOl8J0XKRnqtejuvqgekGJbfC9BNmQpnXH5pOyob+tMzGOr6Gn9rKZMlI4Slkw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 06:27:03.4130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a18bb384-b73b-4a9e-1681-08d7dc4f049e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3321
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Instead of accessing the registers and checking for tx_empty,
use cdns_uart_tx_empty in cdns_uart_console_write function.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 0bf946b..042aa6f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1233,9 +1233,7 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 	writel(ctrl, port->membase + CDNS_UART_CR);
 
 	uart_console_write(port, s, count, cdns_uart_console_putchar);
-	while ((readl(port->membase + CDNS_UART_SR) &
-			(CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE)) !=
-			CDNS_UART_SR_TXEMPTY)
+	while (cdns_uart_tx_empty(port) != TIOCSER_TEMT)
 		cpu_relax();
 
 	/* restore interrupt state */
-- 
2.7.4

