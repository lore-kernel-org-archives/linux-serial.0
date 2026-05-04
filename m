Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012028.outbound.protection.outlook.com [40.107.75.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721B3368A8;
	Mon,  4 May 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884593; cv=fail; b=iipXUEPHTupIlIpnSO9daJGtJbnVi0STKcjHnF4BeaWaXKgBRI5eWr4Q4h8jZkXqOl6l9zasWKUD0f8Lf96NxXsO0ZWccQghn2dIdB3+DhP4523cpj3flx0w2uKiPJ+jMO1MkwI78HotcV8wXovtXhpHUj8xGdtjBw4mp3i7DTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884593; c=relaxed/simple;
	bh=o0fxDdWHa2dYSme0oLN6xwJlQ2U1A7iqPvQJosZwaIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hRpGIHcHdlrwRrsiwsAr/04WO1UWVjUudgdL+ogSMtODtm6FL+7gl1Mk5C8RsixK8QFTbAkoF6siWFEbeRA+zULP17bQSADB4xIdURApwU2BWPVdXsZY4LT+9ug3dVqve69fPTkjf/L/XsAq1OzwYjc/peczD3JKPwyNzy0oSrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=eJRjBLxa; arc=fail smtp.client-ip=40.107.75.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="eJRjBLxa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCyjKTj9XLnyjfAiqbs3IM9/vBFVQdTKHrIV4EQEjedYDUI0BQ0qg7Q2r3r9Ck1GTOJ31J/FRb5zBSYQVTcCMIq97+3ika/5+9DwA6HSJq+m571EO+qk5F+DF9X8kMRPXsueCpw+pSB8puj+Liha/h/qpbuJNfqPHS+up8kuVIOKdXiQQmMWSCOUj7p+U/oMwDaqiIzWkCeXFzD6J7KghJxqNseANi6n1jeJZtIQBBc/DXhcKWmSjSKyMcUDEsQbPCcJ7+6LGLWvuXQ60eLVHRSmVC+7WDqcWXJVpeZDriaokjyJnu1IMX4NHjyUWSgXDzDxuio//sAMXgAq6VBMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU+ELC6mJKpkmKVyShEyNwAmQJr03MrIzhWo+RV8zLg=;
 b=rKKNczoT7UARW76FtbKtZT2PK6gwfNBAetcvzQoImETtrTCJjXWUK6dk0Q2xx+M1RHpqE+oXC8nD7bZ/g2u/fR9ZVG8l97Fh/hW3fE/t6STn+YCGxN8RwsipOqSLpY6zQDKVXuYYjIk6DUSefqUIl3VOTfhi3izwzhhks83uhvChO7q0k6wreliBjZLpSSMuk8ZjNCeVX3suqbtYcv4tpCQVeVc9GVN2vfwP9LmVtSSZVR9wD+Dj7KXvFWZXg7y9q3cjvrTXC/Am8iA28tg7t0eQAuesR6PvkW9fFCWjdfjfOBCH+V/61gop5rVMhtXbkA5TGB5xqyDTBgW0xBz9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU+ELC6mJKpkmKVyShEyNwAmQJr03MrIzhWo+RV8zLg=;
 b=eJRjBLxaI14iVexQzJLvpM1/Ecn0cdeDuXBQuYcfrhsaMytXnaeTQJBl3WXgDCmcc+oOXC8LKh1gcJ7Ff2i3CgPi+D0i1/hnNOvEiRn4cau4p8i9lYQPKHUr0p+GFSLHXwYuPjiRmpBMoORZfBaZ4ooa0uFYUhEZFv8YYCwIN7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by OSQPR01MB7823.apcprd01.prod.exchangelabs.com
 (2603:1096:604:425::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:49:50 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:49:50 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 02/15] serial: 8250: add Moxa MUEx50 UART port type
Date: Mon,  4 May 2026 16:48:47 +0800
Message-ID: <20260504084900.22380-3-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|OSQPR01MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 90370a26-6408-4747-a291-08dea9ba19f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	mrqv/DJoBlJSVb92Pr+g5LCMlDQY8FC43Yot9XJD678WAEMO97U5XOD639JFDMiAfJ53CZYM0DkulDZ/sdZCspI+mx29llEu0xMG0eUWSToE6oU4gZDHcik1yqXVPqNhS+aBIrGZFoj/Pw2aVD27uxwgDDfXZwcK2tGZ0yaTHUUYlyIKJVUF9wDGc2aVYa8GdytKnzNADqmYr9IYcqrZ7qvP6GU8665AEYRMKtTnPUsfDQ1sQ+mzh20NgVwrHCG6kOUlq3V9+UwPcNtgvFIHvl4JVqljZdVChjtBObGm2LmEBuF0/AqR8Z449JI1zEyEWuCSP20543qA9jZO8iPOgkv5a8csTqZTZT3IY0s7aNXn9vzS7QxkTD7Asp7kO0zSAH92wD7KDx9l9JJB4frTMkyeICA4mCeltCcvmGRiyqDPfAEz3bcVBPeNpfgYwjKRUjlTL7oSHognVBQhDk6DFpZ4hmmMG7itHYQdia8PldIOSeXA7evH2IB44rXoJUrRTLvroGF5qbnOQFwKfw6YR/U7Ksqi17uClmTJwY2sH2WJp0NHQ87prvCpMYmysjcTQA9dTdM1p7fsv8HFCQQZSKu+HImtvNBUJ0AnaHfwpzYe2u+tzYQZtLrn5vnTgVWDZhGUT8r9DK+5mIFxlKUHKHgQXhB7bv2sTbvxctBkkL2AbvJ4tB/+fM+fbS9ST6qlRDsx0L9M6PhU8ADwpfbiOJ2RaH62czwqqL+6onbzL3a4yItnVVBfLYACme92++o4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1JuHBaV278FNQe1xhrSTmP29SIIFlmksniMGj4QqA62V3WmJv9lLG1TmP68E?=
 =?us-ascii?Q?KgTLaVU4LYYZHYwYv9Eqk0ij5g0mXSuERGJpgtq19jdW6fwMsG2Tq7eLj/z4?=
 =?us-ascii?Q?NSym2YpAe0GJsDTjJigZL2tzqTHmYD7vDSzObl9Jaoqq5f9D1secI22+HiP+?=
 =?us-ascii?Q?/qVmbaDj7R8xEps8K3ZBdq2WBPI1Cuv3UJB3e0QfbX6u04C9T8sjtee3mX2G?=
 =?us-ascii?Q?ETDou1QiYYpE9YqOthaAr7Pb9b4XgN1xQKZEhRv85OA6cYrHr+neduf6yzEC?=
 =?us-ascii?Q?E3vHYIiGMDWHKp6FGS1huorutqmM84kmzf2WQDSm/yai5ZwzITlJwGOlhro7?=
 =?us-ascii?Q?6AU2colBCpAg/ZKCWgUHp+JeA7It5Eij7a1lREs4XuF9ka+BLRq1UCxlihtE?=
 =?us-ascii?Q?jI11OBQstu3j+aXO2kS7/Y04rMNld09KC3WZ9Y/9GOp3FWQ0AI+AVp/ZzGIx?=
 =?us-ascii?Q?T3upzMgDRjjShqEwx0PIQIY/OdFzszIWjxVjhu/ONOukLYlW6Q5lHl0vqMDF?=
 =?us-ascii?Q?cE2daw9Gar4oQ85pOWZ5V1ShiCgbGLtH+1TORbYr/4J8OMKqUqZXgp00qxYZ?=
 =?us-ascii?Q?fCvzpduDjhAfikZCKZDbgGohTzfwqMAMkc1vMNDAnL2kBbPHIiyHvb/6Jxe2?=
 =?us-ascii?Q?QVSxXarx5yyCUU2yLf3bayM5zNgUE6IZk1JoCXQW4tyjEAWWgvl+4ghXk8w8?=
 =?us-ascii?Q?UjUmV+RTMJuBdHtXU/ffFMM3ZGksqIBsIvWGL8Ajmye9Tp/Dxif887a9qZ/E?=
 =?us-ascii?Q?pTP+jGhVHwDfAjG75HDQQHkgmErtBJFtRFOwjL0d4y9RlEdsocDvHGHx91zC?=
 =?us-ascii?Q?d2Cczxf5bmWFY+UI4eqJ77PmIneieOkb0zArvRqSpMlsFkSwLLIlsYpF3s7K?=
 =?us-ascii?Q?UQiumxJ2tcK7381cV9BlJgRKH0slx65Uh4uNqOH/MwszpUUbyD+ZAyHD8O7s?=
 =?us-ascii?Q?hf1N7s6atUlNwtp12clOqZcb7elv0s01n1GuPt8kQA//HcVDos5PS2/6rxZa?=
 =?us-ascii?Q?xMDHKe8FJfMCoSmVWEzJqz2rL3FWt2lOUZ2HSIlpNtDEv8/C0lgJ+ntrPwY/?=
 =?us-ascii?Q?o7EVQrCfHay6HLbUjz/GwTFdEldSGfH80YFJ1cWR0HkmQzCcURmC9z1lglOQ?=
 =?us-ascii?Q?7MI9G7vgcGv57UlWs7P4ejcm7fHrq15AaZkNIJSAWz6eta2dam0XmOVRPf9A?=
 =?us-ascii?Q?x0sXXgjBPWd1M8QdZYHdz96c5DoQ3MrQZNv92OjXmNjurL9AbbBQP+vrr5Rk?=
 =?us-ascii?Q?ZNR6xl54sHMfoJ4ZW1Na7v/6y4+wVxsnE5u3Lehq4OW9bGgrrzzpNtNmAML1?=
 =?us-ascii?Q?FTjuzTJLHwDcAlkMV8AZyvnAsLfNeViwmFpYON95hHQ8sudeQHZgdNgcTvUl?=
 =?us-ascii?Q?/GnAU42kr9bF8uKjU2bHuclVkGY70WIuHiNlAT+oT5TSkTcSr/rpVCB31m4v?=
 =?us-ascii?Q?ZyQM0xz1uPtX683KHWwAuXlMy1y/IuT7m1rHB7B83gWvBdBIvudFU7v0OaOE?=
 =?us-ascii?Q?6qsiLDOxPIr635/XjaJRzzKoNmjMSxvI6eE6fn/w4mNM9NP+yVpB1N8HA2Ig?=
 =?us-ascii?Q?P1XNtDKSTBPRAey8Zdhnkh1Mh8cRTzpb2afOa8sCvJRWHYgEPLAKwR2xzUiP?=
 =?us-ascii?Q?CQTS2ITLvUUQ55Kg7Ooktra39l2GwLOdJBKPccVuWsOuxmvdsCDeCiBknJQ8?=
 =?us-ascii?Q?yiW6AW6bqfwMQ+xmAxSDKjYyzp8Bbo1M1xBacuoBPV539LHhxAgJ+qxnJ3be?=
 =?us-ascii?Q?waCDUSsbKcn1GOfr1FpisDwtXPvkUJ0=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90370a26-6408-4747-a291-08dea9ba19f6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:49:49.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrLAOPl//Rg5zZBN/xGPk9Zqkk6CCKHocDoaqHy1zsPscutjuP2uquiTh87KcKDcMjRpRTRnyRDq5opT+r8j46mV2f3irgxR82uxTjJs6ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB7823

Add a new 8250 port type for the Moxa MUEx50 UART and describe its basic
FIFO size and trigger characteristics in the 8250 port configuration
table.

The 8250_mxpcie driver sets UPF_FIXED_TYPE and uses PORT_MUEX50 so that
the generic 8250 core applies the correct defaults.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 3 ++-
 drivers/tty/serial/8250/8250_port.c   | 8 ++++++++
 include/uapi/linux/serial_core.h      | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index aa0afdbed791..ec91db1a3008 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -220,7 +220,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.dev = dev;
 	up.port.irq = pdev->irq;
 	up.port.uartclk = MOXA_PUART_BASE_BAUD * 16;
-	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	up.port.type = PORT_MUEX50;
 
 	up.port.iotype = UPIO_MEM;
 	up.port.iobase = 0;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..a17fdb5d68d2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -310,6 +310,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[PORT_MUEX50] = {
+		.name		= "Moxa MUEx50 UART",
+		.fifo_size	= 128,
+		.tx_loadsz	= 128,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.rxtrig_bytes	= {15, 31, 63, 111},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 9c007a106330..377884e3856a 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -100,6 +100,9 @@
 /* TXX9 type number */
 #define PORT_TXX9	64
 
+/* Moxa MUEx50 UART */
+#define PORT_MUEX50     65
+
 /*Digi jsm */
 #define PORT_JSM        69
 
-- 
2.43.0

