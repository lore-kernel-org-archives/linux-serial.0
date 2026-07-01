Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012036.outbound.protection.outlook.com [40.107.75.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F2368D7B;
	Wed,  1 Jul 2026 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877421; cv=fail; b=gHziy4gp47zjyOTEU6/MbmQiiFwbBBJa6C6nKzCv66PYfAe4cGZ9rUXj0j+OI7k9rCWQeDApdFPbfRjS9JZcaetsWKKIqQcpHsJ0qFDDJisj1qx04p49d8/kwQMLCWilHaQnbiQR/g+ARGjrc6DBF+Pgkz43QT4xKTt/aKPIFsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877421; c=relaxed/simple;
	bh=ZpREM5FtpAbVZhHIO0h7HMNoM2+QCJWqmgcx7z0eSHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atNp2A6ubPxF8+CjHu4MjF/CukMexELmgcqcRudv+vQPt4o2fQQjrNgUTIPtwdiaeBx1aAXXny4z/1McDWephOlrDGHtSRWCPu8vJQV897ZgKxDztoqC7/Yk6GWCX7+0cRejijfv0m8wTKvTdOmmZdeJhQudOOHZZkQ4NBzQT/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=K3zmXNvi; arc=fail smtp.client-ip=40.107.75.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="K3zmXNvi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV1cPMHofNd2e6kS5xEF/UIWazg/DhB5lGrjpzIOV+3NaE+StTwWalagSzYkS6R3hN2y05xGQWFrIvEZoyTZgdyW/d6C6RcmC84sAo17hUSDKrqxn+75ZffrKwN+6DIP4gezqLjYGhe/54NUCogCyi+ooWXOR2aXEyFyyULJpOizFx7KYqcsq0BaltP4FgWsypuPdp91U9CA6SqqXjC7lkgC2a6OR7rhKVAMB3wGLOhaq+UjWdMQyrpEmtHcS66faaFfGfhNxW1PeiaEDWTnZrW6M4PMQLpA2SErWveWlpP9CDX8iRsUFqIjtpFxJaL0j9I4W4SKlk9UMp1ROkOknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dni4am7fYcd9bzsDQYdC/RYIvdBVlNVdxOEGtsV1ZRs=;
 b=tbBpxnkvAToeXk2zYWmMZ8Htk9u7tJBEYQRTVC5Go2ngxOIW2qafd3N0wcArJA2b3hloFe8UuEC/xzfmfDsdXeo6eSUY3I3MLFRl/ABrY+WF75JV4R78xHAyDVtZbSo1SUNn7m6rl2/VZv/xgG6D660Aa27g8px7kiXouWr061dazXWILXyhyC0EIp3LETYrCR3KHUhxIO9QpsGvCMs/MelTvOqFeB0qYFKC/mTuieMM4Nv6eC/YXP9CkIHH+6JC36sopKlfauAMrGDygiw21ZZP0k5/fR73HgnZ/FQA0FED40VQEWhOw4aOJuxEcku1XvVKImUP9mkrjqHBckKAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dni4am7fYcd9bzsDQYdC/RYIvdBVlNVdxOEGtsV1ZRs=;
 b=K3zmXNviz8vi+/mSEjmO8FkXZXrBpuDniuYmXeiYuGMDvJ98ihg2a3UqVKRLj+d3V2uVxzBD4F5fM36vUlBfcbQ9pRNc6OBBkqGMBAuHzR3wQffg36UAE+eevXF/upG/CiQ+gSh1Kq+tujXnQM+BC1UGyKFV3o01GQycrbblcOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:43:36 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:43:36 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 02/15] serial: 8250: add Moxa MUEx50 UART port type
Date: Wed,  1 Jul 2026 11:41:15 +0800
Message-ID: <20260701034128.218569-3-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KUXPR01MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 853be127-5b98-4090-4b29-08ded722ee9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|6133799003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	fEscJFFo5skz8NbuaHeP+eyE0x/zmE9o2QpTFbAVRpniZo5pKiqO9nWnBCXJI6MF45gXdeWYQzwpdZJc2s+tObSh+ZzkwY1enkeByvQvOHGz5Akg0jWa0vmP7sPzCqDDrvJkIq7zXzD7mmpaF9OxL/hnQ+DEvgIDDUOwmh16FVXCkIV9Cmbji1iOV88rQUAL9NmNr7TbWXmfSqMKjyzCebDRUcpfbf0aGFTvUElAj+8Gi71ssCXv26SiwHrRxQsk6Q/2vPNqVGKRT752u4EHxIb8ZiMGKAZKlbbXEgSIVWbw65v7SOlA8H5JUmloHR3fyROju4JXrECGBwJ4c0yAaEqrOr7UWVsjGOcZB0SdESyjAZffBDvyQz6d2/q0lXLyAbjM2x1Tk9csBgDqr5DJe3W3z7/C25LiGOz31iYRUCEFayRR9BgaYNkyrAUVuu7ToyANEWz/90UlU/7mYM8lMEb5ZvxbMHOYfnSCWgEsfthqxKsUbiBDaO6rvcqx3p6/r7M8J/QYSZggWThDdqDHqQqg1UoXP2D5Ep3XmX9Iujn2E5+ljhjeVUXaYpHNRgqGWszsYLbdALAb7kpWSjKLiB86OVlDe3yfUpI6aq+nJRRkEjyrrOm2DIIOZ5CWrfDj1X5IR7MM0d3cZzO09P03vbAuhZuqNAd1tytxpsQC4rfDLoTos4S2ZRU+kqbn7Ffp+jpsTSvhA9AVnOkJKuvPztpXuHVbz8raCJoHfigCFwI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(6133799003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0aHS1T4j/By7NMCOdstodsUPV9T6tY9xuVJy2qFK7JEC1qkIMWxC0Dr/WZE?=
 =?us-ascii?Q?YlGRq5HstNaUArlJcdjzIJI1otNX44ziY3y3bNJflfEFlqIi0BlJ1+b1zEPa?=
 =?us-ascii?Q?hx73St+yoU1kW91eucYGToHGDv+Bt6orQqHl2fI6HplJziBqTjGHTRvgz/96?=
 =?us-ascii?Q?hS3qAIcYTmpB6KhYGv0L7WZQaL3iU+BzJ8K51ahfLSguu5CQQwZD9QlKcCJf?=
 =?us-ascii?Q?f34SqtGXgulJwycjYE9vtVGNHT7o2oSIXgMoQI+5q3Sah49Z9YgBWCuJ82eK?=
 =?us-ascii?Q?gD7cRVH8eQcKUkdcrqeiFdJwoqxUUMq4graMwkhIIl6LTR4fSnrUPVbZ+K6Z?=
 =?us-ascii?Q?iUu2cpxcdOrBqaX+8gywMWI7AKXIqbPISxp2Z5k/UQtLhIajLqw+CJinyDST?=
 =?us-ascii?Q?HOGfhws00MU+KMZDRS4Yspe7eIFtXC8zJjVwGaBJMAIUu2XKGovP+UwbooIt?=
 =?us-ascii?Q?3vJBIGzWFvnt9S0b84ot+GgxuE0UUm+GWLdgxWwL0VEtlpp1cU31IdgWKsPf?=
 =?us-ascii?Q?cx/vabDZ4JXs+GiThFVx7pqkwb+olTKlO5bVraQPoGRT1cd1P5CFcDyVTZXv?=
 =?us-ascii?Q?/UgyosSa9ax0Jx8rdhkfNbRj3xJ39K+o6PIaj5TsBD54blsbcGDOC2g5B3du?=
 =?us-ascii?Q?omE+laYbkonMMYjCK9R/0jPn6jyGml0GPziiCu2ZVG82BNMsMlJ1IAQFQbr8?=
 =?us-ascii?Q?StQz7bJUhC/GG3ksbAJTbYNac51upl18jH2edHjqiVrq5R+NS35xUnQg3S2e?=
 =?us-ascii?Q?BDzFUwef7ZmIMp72/E2oHgw3QULsB5logwuqoGJ0RlRetzNUJyN1B6g0JO4Q?=
 =?us-ascii?Q?8lXG6zkBWIj8la/YSmOs6Bw2yoZm5AxHpksKvRCotEvYphJGvY2SO8Qt9JxW?=
 =?us-ascii?Q?ediP6iYEXlVijMlVSAI/XObo3b32suH12n4yRyPQz+nmf+A5cMZcLrw/jmHF?=
 =?us-ascii?Q?6FGC7/DbZQcRbkR+qE21vhYSzZoDQWAsbGt+xCik8F8mXBvdUsFYiYYVBkku?=
 =?us-ascii?Q?cqZTpFdpYtEIrNnyij48V9yYBrnZ3ipNZtqWlFkbxfKskNQR35wApUg7ur5k?=
 =?us-ascii?Q?fkoatpCeIY+gYIOVMBFD48vqjOkwO/uIWLhvlNYsNKlu5oQktlYgJR0g4Hbi?=
 =?us-ascii?Q?7QWfXbZXX0PCnaysm5c/FhriyXustZJuVA8LLNegyFG1WSsiDdkfZC9HnggT?=
 =?us-ascii?Q?jp8xEMvD/KFJDbs8hdyYztDZLgPkkmH8EshGAt7hn3jjrdD89Ae2qmfLgYQz?=
 =?us-ascii?Q?SFIQUDijX7RYWcLyua/F52AuEnctTLckzesmvmUQmU5PacvfC06QeDepjiAY?=
 =?us-ascii?Q?aXfJynlJNV7TT4A2hXG9kwaQL89AioiSuWxIyx3C1jWil4vRfJNmgoa2Ugoq?=
 =?us-ascii?Q?7hwv09Xmhd4FmqHRe0Jaywm4rmPpPhKy//SOLd0OZv/3BbXX+1NqzZ8O5md6?=
 =?us-ascii?Q?VvZgCUWeTA2rG6+EJq60ZD75v/y8PD/P9npbg7mcHo8sK9EXKP7xXDDRac7p?=
 =?us-ascii?Q?xgQ38yaLLoUbzAKgDfhFomimmVVuKbiw330f4kNWXauK/5N8MC2oEsKntKNU?=
 =?us-ascii?Q?1B+Y84KPJZacSLzcNv7d5osya47GVWNOdtjrzxyHKRrkw/K75ElomK0zzLyZ?=
 =?us-ascii?Q?ioQ1BP42jR8s9gWBF0OMDHHBNfNvgG5kxXD2QkfU29cJdXR7ap1PcIZNS7BU?=
 =?us-ascii?Q?m+Ja0a0v1jq44IvvvolTXvZa8c3BA326og7bMK5s9sH40gs2BY52z0CL5MlT?=
 =?us-ascii?Q?QyKw58X3zKXFIdIjBXxjkk1T5wN1TgY=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853be127-5b98-4090-4b29-08ded722ee9b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:43:36.6672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3TbQQxiCS8U+XqOawwpRFtNLX9oStkA4WxIBAg+5nnXnkyJt0VJI/aCrReI50RwxbpKUGhoQ1vV34PQlnLc00KG1jvCxgbeYGBGQafAV/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

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

