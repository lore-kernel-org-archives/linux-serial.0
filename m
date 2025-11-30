Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023118.outbound.protection.outlook.com [52.101.127.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5727B4FA;
	Sun, 30 Nov 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499456; cv=fail; b=EXPF7NwQw92dsafSlaG8TvlhS5wrcZ+KYFNkepu1ajTt8TSqCv20i5BVjLD4ygojjtExgPdLt7VrpA7tnatP9KKpwlP2LmK0zu4eo8OsO43QS1q51hggjdildBI2yG2rBQZX+tzWiJV6arKSU/p/Fz7Uwq6DwopH/TxrdEXWG4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499456; c=relaxed/simple;
	bh=DEbxYPU+GhquzYHyONUv/s/jGY/LdKTRVZBpII6qVn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMNifJ4wL+N/aZOa/5kltlrOvk25VxMK5+v8M/jh2sbt0pVxhF+NgCJBJ6sVla4fe3z4fDuzOmYrz2jxojjUnkc9yMGGuIzN/gSemkJsOj8cJG1CYdtx3fGxM0tNCeuCiu7DAze35p4ejmPGl7UBIofHksunHHFdeU6uFvZAtHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=OgbMkzWa; arc=fail smtp.client-ip=52.101.127.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="OgbMkzWa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktdmR2Vu09xf4QRnr8prHfYQi/IiEWaNWlUZSGFm+/2pKe29Gy8h7CP2bNGk0Do7jhnC9qs1QUxPHt2/V9WRaFAgDZ+9mZmpW//9TdtjjqJKGubqvJC14mPQPAX4C0pSSnVe5TAvM+MpaURQ3EDmGllGtnQ0iR4xlVvmf+aArn84v0acYIT3azzdWmdd+DM8FaE8g67WtaRzrnQnOx2TqDr+m2CtLl06NyuxReEdgt0kuy0IlYiNFpAXTKwSN4h/YuB3+IALD/id0XFGSt6ZYZoT1gAEy41021EE/Vhp3pY1JUAuIk0ikwjq8laEv3lYxmMYFRRmChjWOoxU0NtWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fehd1IhITRgiIYMlYfvUuv9L5JSm7UiF/E8zJF2ihTc=;
 b=ThU9NLZjGVI1aSk95QJXgXT3cLhwplAQpjEpnhvG+5QqVkpbGjiot8WBsG8n9aKNf4KDchOYTff7maIaUp9eSvQer7xhn2RxpDFmYguNmwgJ0UgG45Or/kT5fH75US8/6XACmMtk//c+zqRyURF53Vt/Frcx36BS/o/1X873FoYorbbENG964s9YxMKKFqE0GBvucuzZK3L/RwSltOZ/bPATUkGQRSgT3ihxxC9LphGdwEO6jnzMrhsOWuTqrm9j7G8DIXXO6MBcWpOjrAz3Mky/IaSPD/NFlpUEWdZltXrFOZo2AAV8zIY4XM6xlhdEQhdhX7BcyHiUXe2PRgWt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fehd1IhITRgiIYMlYfvUuv9L5JSm7UiF/E8zJF2ihTc=;
 b=OgbMkzWac648aY9nPH2ZjEa0j68qrD6f9m0jAxcW9xySVuXuuaKJw7BpEXSH669ecYx/pO4LtCjUSnFJqRKWJVdIE33c4u26KHZemoS5the1Lh8AzOzHSrYeFAn4huSh5QTcFFtV+oCSBFvM5ussld/OIYGSaGvO4CZ28J9R+F0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:44:10 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:44:10 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 10/31] serial: 8250: add MUEx50 UART configuration
Date: Sun, 30 Nov 2025 18:42:01 +0800
Message-ID: <20251130104222.63077-11-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: f884f50f-f14e-4d15-9370-08de2ffd653b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KkOtcIiQawAbIFBbjrLLD+YGS3lempEFQhgqw28Ad88vTZiJe4oA2WKI0cR0?=
 =?us-ascii?Q?S/89A14EvC4Ndr+/iKi9FNpp2jt43dWqWW0ww1SdzF0L8xwHqOU3fDEeNm6n?=
 =?us-ascii?Q?j7ftPTHtmD9NVD4a5t1zAmhGckLVRqsxe6BAbrwYVf1N4PNbKVhozrMTnCvT?=
 =?us-ascii?Q?HZi2UMlgFlrQbs4HJq1kwai4y4aCawW+ZPCbApmg3TsPdJQFSE+oVbZPdxjX?=
 =?us-ascii?Q?ka3kiIJsM+rkKZu9inaR3owtM74mFeTMrx7Tv9E9U9IE8sTUMx7f2QMYph8X?=
 =?us-ascii?Q?sDuZb4T4Ek4Rjo710bE/SS3FWE2SIJt93yiBylyd/JaO/ZCEVpseXbZr30qe?=
 =?us-ascii?Q?QHxgggatqNsaj/a8HpXXsih665vT+aucQ17IZ70k9OP+OuF5WdPeHgZ557gA?=
 =?us-ascii?Q?dZM7qEguzZr5XJyCSLvA9e4jb763RapUPkr6sd6Mkq8RT3KOj5Pd88DIKlpj?=
 =?us-ascii?Q?ffD83aFoIHKvInMISfh/vp4Igi07+EuCy2J3CPhyHkKcl9Gs0nbx/5aY4/4x?=
 =?us-ascii?Q?ulAr56RPMsK81qc2cVHuw8Kpo1CqG5c1SSik4+YNywty5luitKREd/JqTZtH?=
 =?us-ascii?Q?mVRRcQTjZpcVfGkaRdZN9dQgI+X/irY3E5GUrYN2m7StWrwTMgQVyAgthXlH?=
 =?us-ascii?Q?WAnuxdtfhFnjHhddiYRuIu24wsxo1rwBjrOnVlq+Keq7x0NzsS7OSIdpYEdW?=
 =?us-ascii?Q?lwb9OXnnepz3GVD9JZ0kpQsNXekYM3zAxPicZoKMzCl5EUaVCDlm+kjW6PPI?=
 =?us-ascii?Q?xEPN5oUEa+O3qguHLARuuic2jM7NeIx9cMOdoA1352kx2wrQOE6PLY6TiVUt?=
 =?us-ascii?Q?Da/EIXj1T+wab+iC6v/LiERYyBsGHUNQB9SfhBLTzLU29Ousz3VO0k/10Gul?=
 =?us-ascii?Q?+HcVhBlfk3Z4z+qZGHalVKBWJVUXeO9+cxP/BQtLHmDiUOzBrMv69y9c9PaU?=
 =?us-ascii?Q?q7KGxMfvHNZ8YU1eVpk3/n7VsZPpdJr+hyd5AubPdECzQPN5vwAjKGqtMtnL?=
 =?us-ascii?Q?r9QkBKhs/Y+6nqIKYGGKDyBMUN0eJn9FbHBz3aPfyaJDTpX7YuZuNQ5yWQq4?=
 =?us-ascii?Q?ivOrsaV1kNhGHqkXFPlYiYyWVMIMaSgXxmZZhWLPslLYmSDttpC9hnfhcUti?=
 =?us-ascii?Q?VmF6nQGbapzODRQf+469I89yDzL5/432G8pIKws+UxLkB++rdVeN8CIcrNu9?=
 =?us-ascii?Q?AjF7cEI7qmpnpwZkLOWkGCpnsX3ZHwSe6QscHD5b7Oe01Fe76w8FwHRTrqQ7?=
 =?us-ascii?Q?v8gba0aJZLYNBNwK54rEkGuOx3Q1SQUO2VIH60H+lhU1elA8gSm7zuL2u74A?=
 =?us-ascii?Q?gIDXUIL+vZWnKkDyFDogqpXd8WJJW1CtZm3zhDQR2KJeLusDc7o5WE9/mmn0?=
 =?us-ascii?Q?+1BAEvwk2WxlXMwxlCry/1Qi5c+6N1KZr0YHGlCImFWpfiAkqqeAOeB8/Mhe?=
 =?us-ascii?Q?L/1mZ61cThSaNutmMUyZaSXGpmXtHtf2ao4o23cyCVYi/Mw96WoKHxZ8vKsh?=
 =?us-ascii?Q?unhVFHacGVRrgh0wRBaQaR1H91zCHpVJK4io?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/tGshnQYO/QIrdiDJ3YR+38IyQnepMhffD63sn4F1455dItvGlNXSbwcpDV?=
 =?us-ascii?Q?H2GMXOEkXhgvDppF7euUjvZcdcXh9K9ZjrNcrN94fJG5nxBkrNGQJ0VynTgj?=
 =?us-ascii?Q?d+xera2aQwXKNa5UnvuVO11fQBymMq7RYBZzfuWbjPpFkWMFCTEslTUuR1O7?=
 =?us-ascii?Q?mm+3Wss9ua/MJqRXkmiKfs1eJrFXWuaCq3l+iEFQdjAG2BUGyn/QQ5ynwemK?=
 =?us-ascii?Q?V0E/Hf1vNceAUlPRUKPlVOYXEwRSs5aoLyafO/RRHtJwY905Uk1487B4ZSlP?=
 =?us-ascii?Q?JJFJSNGyylf8c8T2x27jjF50e/lsZdo3xc/Mk3XgnnaFmyQZq9siNrqgwNE+?=
 =?us-ascii?Q?+w8GxyMiwI0QMpZmpBPsHGYQDPI03/CV7cpeeuNUr07XpBHYjSyhxKVCP9ga?=
 =?us-ascii?Q?uLPV9395/i3t97BfZzqLn9Ckefo8iNvcoKqoQOXz6YCj02rmFIt9ppm3pgQd?=
 =?us-ascii?Q?hE9F53ls9RJF3rQpm53LIPjOlAbai3UrYwOW1HSc4RqNBOFbYwjyIf+DzqMU?=
 =?us-ascii?Q?/hw53cYey7uaLaMYN7ftaseGJfz4EK2weMYahjsgSbk3rOpb74Q09PKXypzg?=
 =?us-ascii?Q?qvMA/+kdiIvvMV+k8k5ICSxG+jOY0T2cRJI+e99CW3hX4txtKcnrOim/nhmS?=
 =?us-ascii?Q?xuRpAO0FcAF9PQVcBWgttEYMM66MyRj/MRc/D37IINogySMthT5MNXdq7Wgf?=
 =?us-ascii?Q?IWlB2TNzyiX/PD3FJP8fDZ+3C+61hEBUvrTNw4MCYjhu2XGeatWgXFYe8dix?=
 =?us-ascii?Q?Mq+XuK0Zg5eIG/IR96KXDawfSvyLwdzdELY6bSx709canlbeHe/eZBz2GEA4?=
 =?us-ascii?Q?rIRpr/GtdDOINB5/yVW2gu0vm5t2W+5887V1qzgRdblcUDjOlGYMdnW/Blit?=
 =?us-ascii?Q?09qx04E+GfElfZiyxX536dAIUbg9OU0BOoKc3xdGh4zO1AJcq9fPoBrI0yb/?=
 =?us-ascii?Q?h5osoVYy6UMttT3wMyZ1mGEsekquVXGKTd6cCNMTdOuntFSu+QFcNKK1PmW1?=
 =?us-ascii?Q?2JzIY4af3FslEjLRqkdXj+Z4nX2rkGz0Peuo1MZ5XCkpGJbfILPo33YlhCBo?=
 =?us-ascii?Q?njhuyAIiZA98WxnIOmCI/v3HEGdwKtBdI/sJNbzemGAsrfyTCTtD9y3vUM5o?=
 =?us-ascii?Q?W9hdJiTsiSlrejQKFM/UL+DVhYTCOO7oO0Hjfq6JG+34eqqs6UW6TCjxUZP3?=
 =?us-ascii?Q?G63KJJBcWAC5SpiTE7ax88G5Tc00ZnzufsMg3ipXTg4G4mKQ/VZII/c1Tr+b?=
 =?us-ascii?Q?Rt5CN2WaEoNhTzYB/tZHTY3ct2VKoUNRxeVilDG/CbMwtHBCF2WIZVI8UXDP?=
 =?us-ascii?Q?wLSTL+3Om1cYQdEHW/9M5eSJxCyO6d+0sB3DTYKNYeLml7/9lSMuEkVKbcUK?=
 =?us-ascii?Q?LPabJ/dWtuX/dWHQ9b7bxrsZ/WsdfQqhHJUMnGUclIw8SAnR1CJm+qjLruuN?=
 =?us-ascii?Q?T54gaba0leELu4/LpNJU54FxEFAQki5cj0x/66me/Wus+l82gyT+aVhl1jwB?=
 =?us-ascii?Q?r0il0UXR/rm2IjfZJMJhCXv+s84KVUMCQBxP64NMboiJ8aTaLZG6IcbIh+rN?=
 =?us-ascii?Q?E8qO2YYeg/BNYHIjmVFbLZ0ZvxNLDmga7ggfIWQxMwQ/11qrJN7NJ4NeqDUp?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f884f50f-f14e-4d15-9370-08de2ffd653b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:44:10.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDzNPV035UubhT2E1YsVCelCyQX5pqdbu6mw0aSfDbip8INo/YFZyRWVg/m/iVg/9zMDyD84k5JxRHnW/jVMa6wKRkvLLa51ZIcIaUrredA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

The MUEx50 UART does not fully conform to PORT_16550A or other standard
UART configurations.

This patch introduces a new UART configuration to accurately represent
the MUEx50 hardware capabilities and applies it to Moxa PCIe serial
boards.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>

s
---
 drivers/tty/serial/8250/8250_mxpcie.c | 3 ++-
 drivers/tty/serial/8250/8250_port.c   | 8 ++++++++
 include/uapi/linux/serial_core.h      | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 2e26307a9fee..f38684d11a90 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -207,7 +207,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.dev = &pdev->dev;
 	up.port.irq = pdev->irq;
 	up.port.uartclk = MOXA_PUART_BASE_BAUD * 16;
-	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	up.port.type = PORT_MUEX50;
 
 	for (i = 0; i < num_ports; i++) {
 		if (mxpcie8250_setup(pdev, priv, &up, i))
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7d022315b3aa..38825bb80749 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -327,6 +327,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
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
index 49c2fcb2e24c..9410402721e4 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -103,6 +103,9 @@
 /* Moxa MU860 UART */
 #define PORT_MU860      65
 
+/* Moxa MUEx50 UART */
+#define PORT_MUEX50     66
+
 /*Digi jsm */
 #define PORT_JSM        69
 
-- 
2.45.2

