Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705E6C00144
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 11:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiG2LsM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jul 2022 07:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiG2LsL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jul 2022 07:48:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2AE74787
        for <linux-serial@vger.kernel.org>; Fri, 29 Jul 2022 04:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bARtszk/xXYIuOVP/pIvkLxOAHrUNRtHUldHsVExgqRBOmHWypvYlCySYTzcs4TawOUKG+17t59gOkn2FVBlbIMTLFwGIyxKklQDkr0L87qqwCgMkvrA/E1JMLk7HTs3rjX8P/HA+Mu8TfIZJw1ZKMvz/5tgBUPgdy2YqZWDX7Is9nWvQpkYCgMqBVmEC3E/3tuLMN9m1xJT+a59Tt8t/gZkPDPYne68DhjnJ544jvdwhSzWwjbTAAf2GnyDGMTc5gPqsNDy7znhaBrc8Ry29/QkxdSRFtcJJmagaVWYPookGrHR9Y+MROqZCxuA0NHKEIufcMiIVLPeGyi2D6UtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KMFHFQHY2SDs+LqxCOfEMhB5rOovpZ5xZsr7WYKp3k=;
 b=QUxQk3rSs+cTGIEOcjaD4PyAvVaUjKnsgrb6wsT8+y9s+IPMA1o5Gr1y44h0OGpLbTEYzmInDYDDyY+pgyQPkMh0eljnafgXxPW1MJwd1rI6FbFSiHHyJDqRJ//YUDNKg7GAsV4pjnbUrRttrHfqWBkcEeCz1zdjGJcbk9qpzdpSjDP/V7QBHNqWY28yeiiOMkIilG1+cMFIrWkaBpG06Ezs/xPmYKqFjk9medxqMYhlL3oagOp4P/q39Yfjf54p8NLy6XWoF62ww5R4ptxE5u6VOnSiylRQfBunBkWM3Qq/XuwSNXVkbUotj17SBj67HCGnsVpIURCAn/8yj5EPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KMFHFQHY2SDs+LqxCOfEMhB5rOovpZ5xZsr7WYKp3k=;
 b=oLjrcdO5jzem5GjL26lg42dWKL99vlYfsfRnsyDdH4VnpihJTtOV/kEuvBJUPE8TDm3w/WxMTe2ayXnLQWLEdy7Duga7IlXzOvAdNykru3jlt/h2dshO/zzi9bEOjwDdPPFULC8IG66nAOZLKjyO4agvfiGtK7DzMl2o6oHMTio=
Received: from DM6PR11CA0051.namprd11.prod.outlook.com (2603:10b6:5:14c::28)
 by SJ0PR02MB7120.namprd02.prod.outlook.com (2603:10b6:a03:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 11:48:08 +0000
Received: from DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::6b) by DM6PR11CA0051.outlook.office365.com
 (2603:10b6:5:14c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20 via Frontend
 Transport; Fri, 29 Jul 2022 11:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT056.mail.protection.outlook.com (10.13.4.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 11:48:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Jul 2022 04:48:07 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Jul 2022 04:48:07 -0700
Envelope-to: linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 shubhrajyoti.datta@gmail.com,
 git@amd.com
Received: from [10.140.6.18] (port=57946 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oHOTO-000DJo-HK; Fri, 29 Jul 2022 04:48:06 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>, <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 5/7] tty: xilinx_uartps: Prevent writes when the controller is disabled
Date:   Fri, 29 Jul 2022 17:17:46 +0530
Message-ID: <20220729114748.18332-6-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
References: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9b57b2f-b95e-4c08-b44d-08da715834b6
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7120:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lEcNdzpC94E4UAhfFN5U3QWtyKXfw57gxainxycxM/WNJ8BoJW4HRt3abiE9jNpDvTHzCydRifLfsJdCOrQfUe/go6HI+gfg5lnIkuVVHPRzO9C57A4UVoglBASwt1HG2wm9m9ZZLfukTi1k0tfM2sGg47HrA2Dj80Sl3j3V55bW0sJ77FqXc//OUV0ji5g+jxrsHs8cZh3vqVJLdvmVRg2B1r7OPiTKcgpOR4K547yDHf4A1yK9xMV4zg6EPsAcjPs/Qg7C166uSB7KX5i4fLGqNPBVijLGheRXNbKTwWuKw55zNAkYJ/qRQDtOh9ibkcUm0VuX3Sj9hmJbzaxieOQLe3Xe2hzl+B6SQ7m5ETdxSOblYT6HF1H1QrlqrrI4WtiWv1D44JnUV5RtkyjrSbWAvDovWb6JzArDqoS3SmGmN/tNDhyuMKvhsum/Rz6tC1JTJ1GsvNH8phZpMIFoECGS+mBpRTaXoZhAY0Hq15gED+UjzHX1jn29leaW3DTb8nuv0HigiyJhGCqg5h0bJAPlg6wu0SvACh/DGZdrCoDtwpuGYa7Y/C6+XX0+Egbc+vUuZtRZS+1+hPQzrEC1kHICQJyRvld0OTdlpXHbh2Zla5NB6EAvOo3L/89cpJV1a4CY49OnOPt3JMpOjMvc4tO2axoPowJ8Y27GAzU+Cvrh1v62/CxDgtbyTPLq4FhEC+7uD3EO8jaInJPvYUDH+VGl7zbYWP64tNo3TuYhWU3S7XjyITYr1/8rOIqMnvFURcl2b+m33xVaj2zQSji0igVoE6N34chrHEn6blM/uO8f3yxN3UjqGqPJ48iyCJ7xBcmhhJgp8dlmeiTnWLU6A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(40470700004)(82740400003)(6666004)(186003)(41300700001)(47076005)(8676002)(70206006)(70586007)(26005)(4326008)(107886003)(1076003)(7696005)(356005)(2616005)(40460700003)(6916009)(54906003)(426003)(478600001)(336012)(7636003)(316002)(40480700001)(36860700001)(2906002)(36756003)(8936002)(5660300002)(9786002)(83380400001)(44832011)(82310400005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 11:48:08.0858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b57b2f-b95e-4c08-b44d-08da715834b6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7120
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Prevent writing to the fifo if the controller is disabled.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
Add atimeout

 drivers/tty/serial/xilinx_uartps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index ae99e1164f0c..e119da69e190 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1132,6 +1132,21 @@ static struct uart_driver cdns_uart_uart_driver;
  */
 static void cdns_uart_console_putchar(struct uart_port *port, unsigned char ch)
 {
+	unsigned int ctrl_reg;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (1) {
+		ctrl_reg = readl(port->membase + CDNS_UART_CR);
+		if (!(ctrl_reg & CDNS_UART_CR_TX_DIS))
+			break;
+		if (time_after(jiffies, timeout)) {
+			dev_warn(port->dev,
+				 "timeout waiting for Enable\n");
+			return;
+		}
+		cpu_relax();
+	}
 	while (readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)
 		cpu_relax();
 	writel(ch, port->membase + CDNS_UART_FIFO);
-- 
2.25.1

