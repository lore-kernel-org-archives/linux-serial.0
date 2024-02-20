Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DF58AA5
	for <linux-serial@vger.kernel.org>; Tue, 20 Feb 2024 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409586; cv=fail; b=XQX9vSrdDP+Ssd+5LzJkXBY+8uj4hqzzrB2H2eRm0ttBoGcZWk9e69sDTMuqRQTiKwz0ad1grk5A4gFj2X5dyv47lXCsQaA67NAKkLyUCnHJMSIJKbUN8EuJFu9tP+ExhxnXq38DhVmK/H8vh7BT/DeMStL3fEqpoH69rHbxuT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409586; c=relaxed/simple;
	bh=G/Ra16o1OAyP96yg44efM02Xgw8SL03kJ8pcci1WTm0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T4GMcKyRy7d96YCfaohopDk3HgBd0yOMlkBJIQHdD7C3p6LUJ5gN0f6RDAyPJm0nmsCvgUD+4lWg0iGgR6dvfI8V43ZjKkY495RsX7qkB3UrFxY0DPF9IW44hxDwtbkWOCYw3IhyiVGFJ4fQ+MOjVJg7/blHJHzE0Cbt/irhE2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ORnBdSMT; arc=fail smtp.client-ip=40.107.249.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ORnBdSMT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR7qLVquHYkfdfg0CostWzlsOgiI0GefYIwHsccOT0yfKQ4VtNt+BFHi0D1p2MGYjkmrfVX3G3zgwZa0fIT40R3PDKmnnKbZ2haD6wO9VOoFrKBjwR0VuieH7u/EqB+dfo63zrUBLj7x/0fAw5oD2DQ8SpRENkkvlvPHNfRQAAg6+lpYNENRlBoZjAVEQoSmIMycv/PPvl0xNA1CNsT8Dqg7SNqsp6ciFHw2wWc45dwE7qbunP9j2atDhPUNRAd9DPudqcLtjMHpGnzRcCFYnvmdUt30nEewcx4kGu5GPoY9G9VRjWcg6bTSOuw3RaMLib+BMG537W1e3kFJ5vGpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZxBKhWzkfFDwrT6l00egUNL1s8M8dwXPB9pisgOYr4=;
 b=fNoLzI9lbkhvBKQJ+Hi9iVxtjE5GBpXjsmnQX8B1S7YcZ1iMr2THiBE+b34wAaOugJGAiUAw6hR9iD0h03cgqpzA8zL4A/E+4nuIBNEuZbzu68fxlq2T/VVKIw1AsgqsHJSjuipbhXKoIB8/IRSqjHgrxlb2oCXFMMTgQl3ja8PNEZgENgYV/9ylPpHTW5gY6aIpER20CXjaL8c8bKrlyNrXts8tvNUUVmsjefP1JXXq9lLzNZxyNXhXxG/cj9egK2U/M6FvVRNOqWPg76I79mgfmazqX01Yle26Hyj8z6N5BU8oYUQ7JFICV1nQuXlnYes9jzko+DWon9fjkplXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZxBKhWzkfFDwrT6l00egUNL1s8M8dwXPB9pisgOYr4=;
 b=ORnBdSMTzovyZBiMwui54deEJtAt3KIrGClSpClQyzqeyQnuwfcElvd1WpWcQKWFbTiTHe5SBA/dtPjsRlpu+TB4LOuPgr4KQWdIauCxBW2k3pZvXDNXeefvLWjz+ndK5S20SDem2m+CWjmZeaW3bDK3KExDzSHDB85V6vkCGzg=
Received: from AS9PR0301CA0022.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::18) by AM9PR02MB6929.eurprd02.prod.outlook.com
 (2603:10a6:20b:263::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Tue, 20 Feb
 2024 06:13:02 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:468:cafe::38) by AS9PR0301CA0022.outlook.office365.com
 (2603:10a6:20b:468::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Tue, 20 Feb 2024 06:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 06:13:01 +0000
Received: from pc50632-2232.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Feb
 2024 07:13:01 +0100
From: Rickard Andersson <rickaran@axis.com>
To: <linux-serial@vger.kernel.org>, <rickard314.andersson@gmail.com>,
	<gregkh@linuxfoundation.org>, <shawnguo@kernel.org>,
	<s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<linux-imx@nxp.com>, <martin.fuzzey@flowbird.group>, <marex@denx.de>
CC: <rickaran@axis.com>, <kernel@axis.com>
Subject: [PATCH v2] tty: serial: imx: Fix broken RS485
Date: Tue, 20 Feb 2024 07:12:43 +0100
Message-ID: <20240220061243.4169045-1-rickaran@axis.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|AM9PR02MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e5ccc4-7d42-4b6a-de5b-08dc31dafe39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	neqpS+Ii2MA56aXHzuNv6UHLDXUnpbAGCDcic4oQFGmtMp28slP+uL2d7T9Uj8QTjiP4V1mcGomrBJHB67ZkI/JEAV5Z9WGWdnHUJdXAzOq9i7tUtStmaHy/7DIgcRdDbKfVJP7gijtsv904P/NgINAylDMYDGww/FcCjHUIxk1w8+6aQjBmeoZBeAMUzjZJHrQXi0TkJusMNC7z/8gM0aBLBi68pFwN8eTUwTc0ZQe1jedViOdvY8XmiEf5WtizGB/1JlylfMkpZgkVoIFhjR0VAmSCoicHpn2bNYO3k6fvTXEsH3J8QCZI+hl8+/eAQqKEnKpYDF0x/rpAgRwqjeNT1/b0S1ldqypmmAr1eQydXEzs+SjWWjIDoQ93h2DqMgS/rxBSOlZ3FSXs7GXm+Y+IS1jLNDd9ZaIlGY36YD/EHQFifpDwm9obXouKQw758G/gzdMSrm/J87Lztn5tYd6ZecHVnQiJg4dQPdBX3pqW6m9WwmicbOl5ZLxfxwxTMPc8shW081ITDqRW+ZPUJ20WWoGrfQ9TuPZFGBQJPDNi2SKnHDWlUjvWMYla1Iv6CRrfatQg7EFX0HHxD+Mi3DeSA9Uxwansa/hpV6b3jEGgWAPvg/Ixpw45mg42+Clp12VJ/eIqQBgaOZqUxVr55u7lobw44bDqgIsVn9LP+TA=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:13:01.7292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e5ccc4-7d42-4b6a-de5b-08dc31dafe39
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6929

From: Rickard x Andersson <rickaran@axis.com>

When about to transmit the function imx_uart_start_tx is called and in
some RS485 configurations this function will call imx_uart_stop_rx. The
problem is that imx_uart_stop_rx will enable loopback and when loopback
is enabled transmitted data will just be looped to RX.

This patch fixes the above problem by explicitly disabling loopback in
the case described above.

Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
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

