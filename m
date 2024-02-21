Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8A47A52
	for <linux-serial@vger.kernel.org>; Wed, 21 Feb 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516407; cv=fail; b=IvHV+yxDGQiddovkRMWuao+A2BPQRFUd9HQHFKrxPNzWfOG504vb0cIjS3QXGR+7s92isdQWZA7ZsQ8yK8ym/M9zgPpX/VKrKzBnYQJGJiuXYaLpVvTEv55yvIuUDCrquNsHR5obZtvoEraLceU3fXya64cZYYIc1t3J9WuIOQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516407; c=relaxed/simple;
	bh=Q4HNJqPZLxJQvT4VzB9jOa8YFof9dXX3U/3WOsjj1N0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fBP1g5HpL9bUPey/Ns+iKJHhV9z7WKy0I34CXYv0SGuH90EHoRzSfLATGgZ3cFsbpJoDxdMSr1PBNAotUXdj5FSGOgFQkMx80JlDyf/NWVB2uL2TNjDX5WjEjJ/6G2J+KWv3lrVyni8gF1Q4lAKkF3VJ0nEBEmsbD4CBydAhdr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Ifd5Tw+y; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Ifd5Tw+y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWhJiMmiKWd7oMbW8chihWs4i+NVW5iC0VMcXEFnD+2ins238LVoaRgV0VX9ZykbxlVarcwbfhgRh7dD/24OwGU84HcdSkl2L07gqBFhyTjzhn1jtpAtl0kcOki8LffpUUTjth8ho6OQ7BhJHnHYR5zH8Rlx0lAYBxHul8etcTVrR6/lH08Yb/ZVrGBoat7aOfUrKlD3/UKhtYt8rmoAW1iFylWNHbD0xSJYfqTsDTFMw9X0wpovoq/kgO9BGXx8YjNW49+wOqkXCnGWaNyQQ9VmDKvFQDwKjIOyliKdI5C0UAN4XHdChqIKDH+Cq54i9NISOMr2RCXzaRoPjorwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkfXO2Z4TFdhqfYFeMm2E5yO6xfODS5bKPHwKCP8Vq8=;
 b=hlUOvQ5SLikg0dCsV0KHjvgqybIxE1LyUw1FFlu5/hfxT3asjcZ4nspD0IZSzGrOBPo6zbTAYjzJr+ZAT7+/w8YiLCMp5HclSNMu/kF4ceBGj01/vjCD4g76xtG8FOhdRg8sRlSA9buDjb5a246AQAjFhQ4iaKvZZA664CEexWktPnUDddehJhaX1tUI3GF1HATKSXw7Twkh8udrZS/ILB+bZuytNNvZztUnP6ZRR0m+vtta5ODhm+vzvvx4Qx21LDgoaGBy7Sver33TPcEqMAMPqU3Ne723mnyVFR3WJEjTIovNr1H/X5H2Bf+GQluLRv5BHFXQGKq0aL+Kw4o9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkfXO2Z4TFdhqfYFeMm2E5yO6xfODS5bKPHwKCP8Vq8=;
 b=Ifd5Tw+yoyu0bDcVp5kDCzxhjwXg8gheBQXgjjVlo8jUqBehv4AkHDtkDPuBaK4VDtEJQUvOINfIOycEm/dikK7CvEGYOChpyHPo/ms4K9VeAowiVYDBaz/nRIyHfkoFV9ac9EWLDhdNFJYtIPW3fAzdT6GtUAIV2LuVzF5DRmU=
Received: from DB9PR02CA0009.eurprd02.prod.outlook.com (2603:10a6:10:1d9::14)
 by PA4PR02MB6768.eurprd02.prod.outlook.com (2603:10a6:102:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 11:53:21 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::aa) by DB9PR02CA0009.outlook.office365.com
 (2603:10a6:10:1d9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Wed, 21 Feb 2024 11:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 11:53:20 +0000
Received: from pc50632-2232.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Feb
 2024 12:53:20 +0100
From: Rickard Andersson <rickaran@axis.com>
To: <linux-serial@vger.kernel.org>, <rickard314.andersson@gmail.com>,
	<gregkh@linuxfoundation.org>, <shawnguo@kernel.org>,
	<s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<linux-imx@nxp.com>, <martin.fuzzey@flowbird.group>, <marex@denx.de>,
	<cniedermaier@dh-electronics.com>
CC: <rickaran@axis.com>, <kernel@axis.com>
Subject: [PATCH v3] tty: serial: imx: Fix broken RS485
Date: Wed, 21 Feb 2024 12:53:04 +0100
Message-ID: <20240221115304.509811-1-rickaran@axis.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|PA4PR02MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8513c6-c2a2-4e2b-0db0-08dc32d3b368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7a5so78x7dCIzoauggi8ximqCisuoQmqvetqWcuun12diVNOayLlju8G6LxYI1zfX2I6oAjsn+8BX5JC1RGfFQcdc9nvKbNtiyIJSWHRspdRYoJFzMK6+z1OlJeeCrwqEm9nbpIubArElBxGBwwLWGgCh0F0G2XqTYR772pXn+vbmcKl/F0rURFdSM+536UbJjnAJnL3RkuF/tEO5h7rAmyPcz/4xLIfSnefEDfqBJsUbmWsGpnSxy8MtbXjFp73AD1oEuJazDYXw9NAhTmS3d13mwBcw+NPpSRB6ug/ndbkhDPj5MfsaDzSOO6M9jn2grrqiPwA+cayUz2yMmsOLBXEFtV474ZTCmTCfV3Hb6HUDuYj1Xj0R3RI9GGOJXTJ94SI/NGeSqQRd2WpA4Vnnw8AmAN2eoDY4Tr+ZokZ34bxKiY92uortdMDqORuWCaXBe+4tfFEN/ikFg+7oKryefUZhnRJRQULNU9/J7PmlcHRdVm0jsvjxpRaFKhRd8PGgfr/2yue9DNo+UedBW7XDqcMnm+x0HmyIPlDq82vfkwOC+1mLmOAQlb+9o8pv0wDmGxeEe00M0U/x4w/u9THvpj4UTmlMVbFJ0WMQZzx3CayCQHSqQHuL1ZnEA1xY7yV7X0S33K4maseAkJRWDBsrEDmZNj0QmxZPhnjwTaSVo8=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 11:53:20.8415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8513c6-c2a2-4e2b-0db0-08dc32d3b368
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6768

From: Rickard x Andersson <rickaran@axis.com>

When about to transmit the function imx_uart_start_tx is called and in
some RS485 configurations this function will call imx_uart_stop_rx. The
problem is that imx_uart_stop_rx will enable loopback in order to
release the RS485 bus, but when loopback is enabled transmitted data
will just be looped to RX.

This patch fixes the above problem by not enabling loopback when about
to transmit.

This driver now works well when used for RS485 half duplex master
configurations.

Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
Signed-off-by: Rickard x Andersson <rickaran@axis.com>
---
V2 -> V3: Added wrapper function
V1 -> V2: Added fixes tag
 drivers/tty/serial/imx.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4aa72d5aeafb..e14813250616 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -462,8 +462,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	}
 }
 
-/* called with port.lock taken and irqs off */
-static void imx_uart_stop_rx(struct uart_port *port)
+static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, bool loopback)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr1, ucr2, ucr4, uts;
@@ -485,7 +484,7 @@ static void imx_uart_stop_rx(struct uart_port *port)
 	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
 	if (port->rs485.flags & SER_RS485_ENABLED &&
 	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
-	    sport->have_rtscts && !sport->have_rtsgpio) {
+	    sport->have_rtscts && !sport->have_rtsgpio && loopback) {
 		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
 		uts |= UTS_LOOP;
 		imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
@@ -497,6 +496,16 @@ static void imx_uart_stop_rx(struct uart_port *port)
 	imx_uart_writel(sport, ucr2, UCR2);
 }
 
+/* called with port.lock taken and irqs off */
+static void imx_uart_stop_rx(struct uart_port *port)
+{
+	/*
+	 * Stop RX and enable loopback in order to make sure RS485 bus
+	 * is not blocked. Se comment in imx_uart_probe().
+	 */
+	imx_uart_stop_rx_with_loopback_ctrl(port, true);
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_enable_ms(struct uart_port *port)
 {
@@ -682,9 +691,14 @@ static void imx_uart_start_tx(struct uart_port *port)
 				imx_uart_rts_inactive(sport, &ucr2);
 			imx_uart_writel(sport, ucr2, UCR2);
 
+			/*
+			 * Since we are about to transmit we can not stop RX
+			 * with loopback enabled because that will make our
+			 * transmitted data being just looped to RX.
+			 */
 			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
 			    !port->rs485_rx_during_tx_gpio)
-				imx_uart_stop_rx(port);
+				imx_uart_stop_rx_with_loopback_ctrl(port, false);
 
 			sport->tx_state = WAIT_AFTER_RTS;
 
-- 
2.30.2

