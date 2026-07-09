Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A163A8FF7;
	Thu,  9 Jul 2026 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575240; cv=fail; b=CtnF0nu1YBKIL9oBoz+eJDceWFU/HqsSislXFp0vt0CtijSBvZiYnoXebVEitgzy4YkFLvvvfuZt/8hYKoeQwLDp6fnp74y/tg+RCVDosaQbKdR0V4C7WIzuVeL+WX8/XMTfitPdBoXnmXSUiSIZ5cfrzJUidoL1n66y51Z8czM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575240; c=relaxed/simple;
	bh=ZpREM5FtpAbVZhHIO0h7HMNoM2+QCJWqmgcx7z0eSHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZw1mxW3xrnrzytFQISkmdfcU0WhBafSGZS69PJ1am3kQKgeg6Az+VTbb6vYmphAZRW4IqWwwMDL7ovIKdQl5jl1JgVbDbWcdazIVKk1G8I3IfxfdiTx7DIyrOj/DgCvqL8mMCHKfkxu7CfH031B2bf5xiR8eNept+iXlxgpf2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=RKoe9LTh; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="RKoe9LTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DatxGOvxEPOleElsjXP/oHFeig4JnyMejnJSglmrrziI4070PA9atC2oWfj3a5tABypuxtmCi2lKbEHBXJ+EuZrtGACtvpJf0IFK9pUBz2vYHd0AzcaxN7uxsMxU+j158gbKTmJxlGoUaBSr89E/eRQZjviu/jKQdoIjn6OK/wpWZt66NtcGtAAYM8ITyS7WjeVt3gOSgMOn7N5Yap1aM7TmCFW7yXH0zelMQZcyekXWvcYkKIN7wCrbIhVyFDboOMIi1Vu06XFWr9OfmJj2kapnIC8Q1CMAWPyHQ/nEzgQmQGMxLsrY3yyPJzrRkKVm7H0t60fbsWz5VdJGd0fpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dni4am7fYcd9bzsDQYdC/RYIvdBVlNVdxOEGtsV1ZRs=;
 b=lDLZGapJ+jDkya/vEafzhHKVadu+vhOeGUCDZ2XXEwHDjDxFlnZchNe01TEdEUCf9HSViXWzYFi1mlFSNz1Il6t5Ea83kkN/hQYuWnCXmGRSkZY8o6ZkgacxS+8SF4cabxjuAyd1Fao0oEloC6GcOPZ4jjN/mvYbisDxLhMWcYrN+pa9rOfjLW5uH9VbmSNDB42j9nEGyWPDYjhLndNhA24WFpr6S6Vt04zMfO+imJ1UfjHbMl0hv0TGnJionYTwj8ssf72ACuDalo8BBktrtXNn6IKG0uy0pbBgF1FIWI4Jxd85paPqVb+c7gn1xZH13sn4/S5h4BxqR2uFUCCXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dni4am7fYcd9bzsDQYdC/RYIvdBVlNVdxOEGtsV1ZRs=;
 b=RKoe9LThfl7KLIlXjeZgHC7S4tHXikM7RCJ1iWd7sV42YXojwsnYZK6IRzRju89DiKgP3hOjcA4dMJUG9ZRCq2egKM/ILEi5netwKjMHG3tL5+KmXnk8NqhZSho+MhuTI+dno13bo78sRLk/DFVXOoDA1cSBZFDwaNkOb3unQK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:53 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:53 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 02/15] serial: 8250: add Moxa MUEx50 UART port type
Date: Thu,  9 Jul 2026 13:33:01 +0800
Message-ID: <20260709053314.435629-3-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dd3a19-cec9-408b-5eb2-08dedd7ba8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Mu3+jLMfLTbAXs8BbT4a+XhWt8QxaeckoJZIO5NNPKc9ykt2zHoN2Om21RdSlNc7chHlRnfRZhUxfbtYBRGf0a7cqfosYQdV6mufuYIfWcwcA7bF111pg3BddSl9b9CQU5X1k9PQjwPs+KDNONAyOnLYaXcx/iHM/UfiQD574mos1iEW03pdiFoSKDhhX7ZYbEwZ4cnQdAItz1WlLGZy3xSKOA8jX1Uw1pP//jJ9AfsY+km+jrxrVuBARnFGyVfaEBqvbviJO+lxIzmaVFm67WU81N/cwA4q39RWx1XaiLmHB/xF7WERRz31D2qxdU1jSSXnEAQ1vFYiI8Rs1C5QWMGqZ/LxW/rSR8/SxmOpTD0KNHORZGOIfpIX+cJUH2WPuFg0sLQxZ+Gkydkcvs8XKWXn8sVkGFUnXWMsmwCcGGog6eUYC299ISNcqJRB4YYNuYVYKvKnTcEkiG+sFn4CprkcUj3LGS2PMUI6QPu9FtLOTLXSVU8UgPzwota59OfNND+TH0gvrNT8IG7h7WDrM4OwOBeYtNc8h3LKb8KSVIQmbtjay+czKPrTLd0eRavEod+2Eak7e3FFfYg+0KmPuXoaTLbHxsAdYcE9eMrzt4vLw8uck/y1B7v5/mDhTT4R0XBSknnKU06IxD/Nn0/MBXxHZoD/b4DuGO3uSyAkqTd4IpRAgdWviIvtwi5IUj7IyzfotECaz4VwhbscE6qjdBJ4DMQJ9uNdhD7yFEyQmoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vcb0rmwgfu0a709wXS+4WuhULv67hUq5LnDXHsHqtj5fIyL7KmUv+qEFRTOj?=
 =?us-ascii?Q?qFXW9IxjboR9HvpuOr0jtjPkx99mPywZDgGOhBqptMDnMkROqYtYBPT3ydcC?=
 =?us-ascii?Q?Pe2QyzAMZqKw67Dl98dYyJTR1/LISF3oirYQBiwsug+ttTsiW0h6hvsqH3Yx?=
 =?us-ascii?Q?hPVaTqk/mH+/iGXt1pxjgPRxmkPxsi1u9r129P2gBplNgbOPvcQQ3tkE0i8v?=
 =?us-ascii?Q?lriupCHuVz4xLPin2aYqc2YpFNcttfTy7xoCBFpzhjkoMWTyKT9ahC6k4Cp1?=
 =?us-ascii?Q?R1bCSXBjAMVwk9zDTdhZO+ZZE4fn3YL2l9mpDTXgJvmuzWTuSDpGCpVYSUjM?=
 =?us-ascii?Q?tfgjIqu10iYb4pFBCMG0XZjCxG3AK8QETVNY3sJsLcUuXV+0nPxLSPgO7Gg8?=
 =?us-ascii?Q?gPKgP1tL3XcnG60jT43QZyTMudV5/iMjKZ6/aUx/9v8BC2uwds4JXla0TFDm?=
 =?us-ascii?Q?rugePDorVzc73c20AxcXRkYPXUUO6jRSSt0ifs6JIhGDMcI+EWhtirIk2Xxt?=
 =?us-ascii?Q?pLwZRymaC66HxiV7mB5bFaXAwVV7/UnB/S8N7/y+0WWG/sxF+tFvdf1MelLr?=
 =?us-ascii?Q?fcfS/6u7ulRndgz+qjf6x+cR0ot+61vIohAzFgehcbNag6ZTniu6fzXr4iuj?=
 =?us-ascii?Q?1RRb9Ntp7jehEEhvHmzeeRvI/V5g0wXgHoV6usO/dcN0EQMZyf6GXedqgk/Q?=
 =?us-ascii?Q?u4r4RnVb6cSXPqk6xkBGmUFWAZuzLkIVn4o/rCdumxU7zJNlkOJOH5qp+7Jq?=
 =?us-ascii?Q?OpO7TEOlHOI5BKWv03NRJdHtBMj64gZx0z2oitBxRSigDK4cKDfKs1vTjcJR?=
 =?us-ascii?Q?XyqBW2NbyPhi7Am9+Vieh7Xdm63mVRA3n95dsKha3yj1qoQS6fn/ILjGXgPP?=
 =?us-ascii?Q?9V0HarB/17LiPUYwCfrHFAOK+QyxS1JftET4jp2CRvQAAA2hGvxACHjQ+AV2?=
 =?us-ascii?Q?WBdecoGGGkq/jeGENgNI7STYQk+HSNofyb0zhBa8FK/R2VnUxN/oAAJ9fUi+?=
 =?us-ascii?Q?F1Wy71EPnz+FZGr/ym4An6erl6IaHfEbbE46NpOBFkgtb58PhDDh1P6IcFXH?=
 =?us-ascii?Q?AMtpe1sW/2aLT2YURE1cdZy7cA9Fc5xaORkjiUYB41djo1UmAm2HEjH4ZyNF?=
 =?us-ascii?Q?5bIhm0E2+DZIF8fz2JZKpISQbyRW73CyWjqDpuIYWbWZaFcq+oh/HoYfivyX?=
 =?us-ascii?Q?gBxjb/hNhQt9cCHRI4O5xaRuPj3o7nT2G44OmzdjIu/kVcpDJXotrm4atjHx?=
 =?us-ascii?Q?NDQMnNEkqYOh1goeSbiDutj+CzbyC14DsH6lUIETTPemVcNLujcCW0Zdxzk+?=
 =?us-ascii?Q?zyo+9+8M2+KdHQStamBxgErALnZIpz2vYUuVRJnKC2onELxPV9alVigYvAq3?=
 =?us-ascii?Q?46j+/o9/9qpRohRlv45oVRiQhVZror/wHaTPHUUaOfcVydPS2h6muLQfdO2u?=
 =?us-ascii?Q?Fb5/aRd13CK5mZeYIG0xX7Narp2ge8TsGBPXgQz/aEQNDlQU7GeDxW3e/nVi?=
 =?us-ascii?Q?xt8p7Zo07HteHZFRoRYCz2cRzYDlKLeGk6+/JpmwJbsSc7RMudeIfAhsgnxq?=
 =?us-ascii?Q?ZTQwVxfLo84DlDfoYU4EXpexehAidPDN3NkZaZgzxLaXi9p1tYJrWYFxvTCE?=
 =?us-ascii?Q?/cHj7acB+C6u0zrY71JL0i/2VfRMCqqD5KwMdgucShRpCqauAcW3t2evAVP4?=
 =?us-ascii?Q?bK1EZ0Hq5RQVN6bXgmwhlRGLMWGyssrgv+3vE/fS6gDI4KRKpVUzmeKkTkvt?=
 =?us-ascii?Q?UGT5DI6Fs++wUZ7PmzDs6Hrq0uwp0Hk=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dd3a19-cec9-408b-5eb2-08dedd7ba8a0
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:51.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/d002LRqIh2sngBmtpMchWOedPEYi4kJGNmica4ClRmPem8dDZlmZrhcwcv76mBJmQuZ/XKBfzAuxwgR5WvccfrzfmEWh2oJa+dT5hjl9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

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
index 7a509e0a2bd7..c82d3149a03d 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -219,7 +219,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
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
2.45.2

