Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445858203
	for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087603; cv=fail; b=Z7xdUKdL0UYuBcQgKBKWkSmltsK5PdqbemOpLXgEnd6nK58HuRFF8iR+v32IH6VHREbmzw2I4DCN9+JFnITXv41Pt+vEWrbRfXwAChkzffKDGZMpHgEQ8Jh+I3WJpoJ9TJOBbp/z5PdHvEfFcP6VBOKvKve8qi6b8m1LJpU6yKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087603; c=relaxed/simple;
	bh=Jtmz2aIM8WXqv59qITcN8MkIyVTJnkr3OI5Zxfd2XF0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBH+rbCQDix9s5D12x42o9dVi/TCRoxcvchwKKy3lAV7oEN55djbVGQ7wx31bXfFx17gqVYfqr1xL+tDZfRIyQFz7WqIJT2NeQ1or/Nlo7sOx8E9xHVECTbr4HmXq0r2N/BvJWkf3KHFsORbnRnq19S7LGeo+5NrIeLFZodJruo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qQdyObua; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qQdyObua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwQwg+yW8A/E7WqFpqIkCWzPt914GTtTyHvGBRbbm+O/l0dBZUdL/2kizECh8oHCLSN+cXYRKYD+S5MCWK1hpJL2GiDJhM3z5JoM76lbltaMlPuLUUCjjpnBw8vJptdEouXWKm/gf9D8QlBBRCiig/1jzxHnXvj8PBakeSilhbaZEC2qcqOpl3kejECucubv9kMPKwRn67E3mlcNAYvwwSyZ2qbbrzgCRkPLhDDvYTXHOHkPsTamEcOrtRPW1aTMlyFxz/+zMybIwjCdAvIqnWDyy8JISWMzN9APia+ztQ+zXHExVmOJH6Sg1gIO69FlOKhZDsMWCjdPvfxJYjoufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d4pvLMIl5kNBn1IfIzRGvdA/G4/YelmBEveMAylRJg=;
 b=e38WImJU66D6JRPS1F6rBdd/ebuVxA6x4zeBm36mhZ+70n/xBDsL+W60AFun+ly9Y2apSuU6GnVm9ls/UAJsJ2fvHZSxs+er2sYs3ItjcpuujiIb3e9LdCKPdg6WQLgfcBk5Pm8OatjHczQberNiwz5XhYUHllC0ZI8ebrcEwzUmeZX2Aq4BCtIHwSv+srjspJLh4aykj9a5Cf/ugYxpsJC1I82JYFD4XwVKsYffBqyBrIRTon0pvNReqnbDvQckV/4kSlqA+hfHY3ry7ul/DEjKAIw9T2SJLqdKkefDUPaco8Fwl4Z3wECUK/FdodyzuEU5uAII1Dfjx0Un/6bOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d4pvLMIl5kNBn1IfIzRGvdA/G4/YelmBEveMAylRJg=;
 b=qQdyObuaHhdD8C5FLFJ4cuyoCl5MiPB9BMRyZBRe13f3xpuXHiOOuCaWNg1uV7B0iyTFWTlri2o6oIh2k4go+TRbfTSQxs7DRMM3OPJ9c0GXEy01rkpCgSXcGAfqqr0tC4w++jrAM3G5U54yAZooW0RyqZgl49jjfE7bhZtLViE=
Received: from DU7PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::21) by DU2PR02MB10130.eurprd02.prod.outlook.com
 (2603:10a6:10:49d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 12:46:37 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::69) by DU7PR01CA0014.outlook.office365.com
 (2603:10a6:10:50f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Fri, 16 Feb 2024 12:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 12:46:37 +0000
Received: from pc50632-2232.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 16 Feb
 2024 13:46:36 +0100
From: Rickard Andersson <rickaran@axis.com>
To: <linux-serial@vger.kernel.org>, <rickard314.andersson@gmail.com>,
	<gregkh@linuxfoundation.org>, <shawnguo@kernel.org>,
	<s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<linux-imx@nxp.com>, <martin.fuzzey@flowbird.group>, <marex@denx.de>
CC: <rickaran@axis.com>, <kernel@axis.com>
Subject: [PATCH] tty: serial: imx: Fix broken RS485
Date: Fri, 16 Feb 2024 13:46:01 +0100
Message-ID: <20240216124601.3752039-1-rickaran@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|DU2PR02MB10130:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a287e5-1b5d-4ca4-7224-08dc2eed5093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qqdeLPf34+fvq4gzd8t7RAGs3F7aMgEuznG9MriHr22cV2ZE8ogV/9j5UZ8LPMK5JS9L8LGkoYZaDc0DRjT+35oRJ9Ut/cCmCTB1QBo2SXftTDZy985vvcRdOwaZwLmSEb1v34N5RFXPtqK2RAhf+6yMGQR4J3LKlFn53Hnl3ihKp1ZpNU4qzGUuCvTa/7+3tJzt3YLbBMhdXqq7+4KOTlqwplMFNBpeGXDoG2LchAlJdN5WuUCvqC0bmwSZDUNNT9IkEY3PSJwJRPbAEU0tz/2NGnEJD1RiKxXK8USRTLkgCCY1AdFXszA7F9OAXL4QMZ1ZuJ9w7mQXy8cMEL4i40AzlBl/60sjCATSpc1S24Gd2tSYwslbRMoLc/0tOEJ/z8DngBG1ZKIauD3abnZkjhDL45EN7hdDK8RN3Hr63iF68XlDlyHjEGG3Hk+ykSmUY/bX47T2vDSExCHElNVW8fmQo++xsb3UTC9OrLZKT9mJTcr3raG1Y7NmrXoASOQxLaBNY7mfNSQY9XUNOVo59JHKz0lJMIBTrAImtLvD6RXg3nMQHun2ZVL8X+NukdJDCx+1gTaR7l9M7OQAmqU8zO28v9FwkGF7q3yLOrHaplRBWGY94K7NoxgdCI9zJoeQSfi/uIlyBm9yYE4rXJNrpwsnwqbA60akUEY4D6YllPk=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(346002)(376002)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(1800799012)(186009)(36860700004)(46966006)(40470700004)(83380400001)(2906002)(356005)(81166007)(110136005)(82740400003)(8936002)(316002)(8676002)(54906003)(6666004)(4326008)(7696005)(478600001)(70206006)(70586007)(26005)(16526019)(2616005)(41300700001)(107886003)(1076003)(336012)(426003)(7416002)(921011)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 12:46:37.3109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a287e5-1b5d-4ca4-7224-08dc2eed5093
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10130

From: Rickard x Andersson <rickaran@axis.com>

When about to transmit the function imx_uart_start_tx is called and in
some RS485 configurations this function will call imx_uart_stop_rx. The
problem is that imx_uart_stop_rx will enable loopback and when loopback
is enabled transmitted data will just be looped to RX.

This patch fixes the above problem by explicitly disabling loopback in
the case described above.

Signed-off-by: Rickard x Andersson <rickaran@axis.com>
---
 drivers/tty/serial/imx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4aa72d5aeafb..899e331bdfc8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -683,8 +683,15 @@ static void imx_uart_start_tx(struct uart_port *port)
 			imx_uart_writel(sport, ucr2, UCR2);
 
 			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
-			    !port->rs485_rx_during_tx_gpio)
+			    !port->rs485_rx_during_tx_gpio) {
 				imx_uart_stop_rx(port);
+				/*
+				 * The function imx_uart_stop_rx right above
+				 * will enable loopback, but since we are just
+				 * about to transmit then disable loopback.
+				 */
+				imx_uart_disable_loopback_rs485(sport);
+			}
 
 			sport->tx_state = WAIT_AFTER_RTS;
 
-- 
2.30.2

