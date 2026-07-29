Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012063.outbound.protection.outlook.com [52.101.126.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB93019C8;
	Wed, 29 Jul 2026 06:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305192; cv=fail; b=YTto6hR3FVQbOBnWUNnqUfVR0udsEZZXHyWRN5vlE+V6R4YdUW1B3lzK9Myxr5oWm7b0ypzO4ydczT6XZgb/7myWx16fcG0kAchnjyiY5leT6KNdwYicwUR2JxsI+GUEIpoEJYgLwaRiLYEYYjySOrbcShNY2niv56HC9dqA6TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305192; c=relaxed/simple;
	bh=KIRogyknkec01GT8Zzf5iZg1TExnfMXiaBFCPHvvl9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oMJneGkt3ih3hsh/0aidceWGmOO+456HEHMDNP+v6KDMqurNmX8MxLMX+G3dpK4o4GSviNjV59NT1RbEQBJ1EA50qW461ZvBGNZtN96MkvFBdVfBm2F/wKOyJBhw/j2zZ67CedsUJAhBGKPl1SZvRKPOW3XrWV5rqX0GYXlujOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Jl+zK539; arc=fail smtp.client-ip=52.101.126.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Jl+zK539"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6wvpCiG9WtpiatgsnMetG2FBYIjPHfo2CNbv4vYJQ8SErLLC0W284jLGVvhdM0nKie1W2FwiQZ3c2JQUZJmqgLmKkQBSxW2D3nstz78dUdGeMMr+H/P1NIok39L4k7J6ef1k/FF8qeMRiJLbwWCtiLDTD0dhibrLcgwyFcg7mtgMQ5a3Fqlbnw3ZWiQtihN4k6g9r9M2bQD7j02351hDriAVzgpA2F1/QNLoU7d1cM2omvFmkwR8ez39j5N6R2sJFbjlGeo1Syn5dZLphhuYz/cKWbKmY60acj2ue3QX3kVVEEI3KZYgrJtE0ulbCy7PlQXknIqzs21sK4iG7jFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS1fjypzeCTYS/9Ujp4O2Ga5uhQ8ysTgBJ29vt1E2KY=;
 b=J584188e+vtxxfRYrSpXAldgZkNbeg++08VliggzJBQgCf3VUn06Q7vfQ32eUk2OKV9Cl5FGdnUhDQaluOZP/KA9N3Oxu9YOJcndpMnwFjtlJ6IBfpxAXex7ip3b9pHh6QyjveQSDxVj1LqjvjyqlnW8niK1XHafUy9WYI4SkE7GVJ4/NVHN6j1EfylGpHaZI292G4r6tjssuVMjxYkf0EuBkgueRy7BHRXtlHEam+GcE08H8mmddm0bgs6NHyoKZ98iX1pQsrZYYyFiSguREEHH2BlHdJFOjKCwR6tC7c4m3RwgwsRB8wbT0P1SQvnok5vEnd54orC0EhNXtGKS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS1fjypzeCTYS/9Ujp4O2Ga5uhQ8ysTgBJ29vt1E2KY=;
 b=Jl+zK539Z/fqeVLn59UDHfUncLWsNu7t/0OxdgyfyABZMwOY6yI2NYpXu0FpwNhwkwd2+PWhQjuEsFyzUr4MLFIgkNLZdUsHhbhSmNi6ZOPojR6yoEZJNDbJOMY3Rt744bICGLsrCdeVKwehQ+dqQw6ooSKdqXdX39ubTdeEBfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:25 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:25 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v4 02/14] serial: 8250: add Moxa MUEx50 UART port type
Date: Wed, 29 Jul 2026 14:05:50 +0800
Message-ID: <20260729060602.492430-3-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEL0PF4D55A38B9:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c052b02-e648-4940-14a5-08deed37855e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CYYlFvHRC4Q9JshdXDM72o7Tt299jbHqnaHsyh+BJOQOpU28jAwkuC0PiN6QZotD7SZeqSt5h1ieuw9VTRYfMa7BEWo1NXXI7Vro9YTCr6/L0mBWwpS6YfrM6rO465cVy07Kt869ThCEAaGo5pSCz5fpjUmwYfuGInmMy8wQg6D0/SYXGNVemtHgIm6sVfYQyrlBTIQPNPls3KTScgQzuIaNAaIGd98K5Xjw4ZoE8nMUR069+YrxUFAHRmAKqzRGzzDHA39XFzg3uW8gnkzEEb9S9ie5+/9H7V8RQq7x+oxGWClowZfFmrSMH0kUOS2qjqbgG1csmnsdrL1d82dONwo1m35KzFnFeeb/5unviXe0Ff1XJBP/lqexCoL93a73mgRdbeiYgxEhYHDHAgv5yN1JRHUD3JQVCLAtE3olwSPuycytrMOeDKOCZSn29bZEvF6MiGDiJYwdMuiGCwWJIt1uVyuL2pMYUcH/VsvMMDE8nbdSOBIEUtQ34DiTtmOoIxg/ZX194aXxYmW4CYms8Tx5ZxUGP8mqOjAUfd+cTM9E+1KTDZzet42sSf9w7ScOT2YCDgGQvDrwAavfrCYs0XvZ9PQz45qq9gl3kMOsPMxL1bkrbem1Bz8Q+KclAffe4/tewWpsCMR2iTcpjTkfpHESZWoh80eum78RnOSWN8Obzfq8Y4jLEeN9cJLLVYgIYQPjWyxwW+JwR2kevh3JnHy9N3fAhj/ComppXdXYdR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5MRAuIeFG2T9iY/PSTsRYFXS/81CCYbFwlZW+mb9dpMmvznq/KMmdirux3hN?=
 =?us-ascii?Q?kQbrni1tYoxTLgIVNkFRyAesDvCE5iP3qhkDB1pU4PPX3cxtYX2I2wdVnXxo?=
 =?us-ascii?Q?zmaSyt2aNsnFWZ5d2f816+s0goOxuo63K9k5e/1Bcl24wpH+YlAUdhHZeTId?=
 =?us-ascii?Q?neRb5GeKdBOQ0hcrzTcNEUjmpNYoGwwoe+J1F7E7Kh3a6uS6GCwsV9jbJ9T8?=
 =?us-ascii?Q?T792A2ycPoEueWLpRX7DcBIleeFQXJkRISIgu+De5fUn3b6cHVec7sVvm/bK?=
 =?us-ascii?Q?MixyFaniox7su6Hz1TjVIhmCyAyrhEULIPQGGytaPtrEiILvTnNC3uBQRNJf?=
 =?us-ascii?Q?awoe+sxhiSptqzIdHEXOeZ/r5DKPSzSbrVS3yFYmhHTyioX+10iSMUAI6QH7?=
 =?us-ascii?Q?oLYSgcU/hhUK/YOnVIZwPCGdRr40kQHEp52mVlJqm3aMMzVvxrTpTTSm2NDe?=
 =?us-ascii?Q?DBxEZbbSg3kZkYtEw4dYR9KtWG5irJWAEEc3ZTIgmlIAhLS3dRjGLjKd1zoE?=
 =?us-ascii?Q?1XFtdma5iwqhNiNY0+04hVud3SiWkBZ0iNhPRZmAvee8w57whbKGF6XPtuMz?=
 =?us-ascii?Q?fiRvKs10n+r/MZUbiV4eKD9rLglMPLK2DUHEH758Ng55G0eStcvjl5cw1ysZ?=
 =?us-ascii?Q?TO9M8gkU7Qu9JWzbaNcZz6U4HWWZqb0v6s1Ho65OhjSQokvKSWKVn5KTLrqV?=
 =?us-ascii?Q?ovsBfK0ZHkjMUgRfqb883rj8JbNzOLU6NrOgdBYKORqOc1n6wnEDloTOMKb9?=
 =?us-ascii?Q?AZERNnJ6D8yewixjXXs9enazUrFJj13oITwvLrxI02NbfiSrj130dPaQOayh?=
 =?us-ascii?Q?xp9vXdjjf9Xugi/1dwPfiKqlwxTcuCF/z39vcihXxo9HUhqwlEAvlIaqhtm5?=
 =?us-ascii?Q?CEVKMV12+YMr3eY2yxnPKDzjV47oqZUiE1v71ruv6pnse6Zt8F8cd11u4Fad?=
 =?us-ascii?Q?1ylsvT0yATILiSzsS6hwGH7k5ggQPHzy8EwYUsN7bodR8obCM8o4Nc75lB3e?=
 =?us-ascii?Q?asjmmzm/VSzIh6bLxxP2n4DOCbFc1Rk1+SCDt3bvE6oSi0EvHifjpMJ8HXEL?=
 =?us-ascii?Q?ip1fL3kV3SYqlOweNFBwKnpWpxeF0vnzeQh30FDLY2/7gPdT7qnQmWORR+OF?=
 =?us-ascii?Q?ajKD6UUCSWbakhBZq9MFyyQF406FBsnJOcGDKIzR5G5zJWBLw+w6hG2s1Yf1?=
 =?us-ascii?Q?W7WiGKsLZSbeNHXE6qRBsqHQrwAPP2Cal/MWBTMugX+K7bfkngNqDPCXd+Pj?=
 =?us-ascii?Q?xE4gIseKA2C4uiVtQZIFyqNk1EUIVy/uGtlcWTPEbotdOttc8Eapc8s8Fhpe?=
 =?us-ascii?Q?Ct2eh1cthAeej7sM7JTWUOPsyVZRh0uTmi/v159yxW4pz1vD0E9g0DNW8+7R?=
 =?us-ascii?Q?r/OXt0Lz/hyJccijQR5u4d19r/S7nY86K6zydH7Jw7x7tRBZDXGUQeUco6Wt?=
 =?us-ascii?Q?gDqq6A4MtSpEsJgpbverYwAWYn9GHX6KtQitDVUq3PXo0LsBE5z6TmRrDjUO?=
 =?us-ascii?Q?f6OUAKKToLwZSifPtnaiuMl3N0/dn7oPxuX8owKokss13Lb7lDfCxiYO/kqY?=
 =?us-ascii?Q?X6nPJPtfR6BcsZEfDzdXmDLgQAY/gJVed9+oybHcgxyV8HF63gcKKN/plc+x?=
 =?us-ascii?Q?RyirKCwwLkeXsf3BEErB/oeRKyI7gtoQRDLmOvyP5womDLe6ce9J0kUMGO+M?=
 =?us-ascii?Q?IDo5E+XwsO9ovEQOxu8P53gDqXDwC2yIYK41hDjNyzHxebOQbqBIDoPmGF/A?=
 =?us-ascii?Q?MkXvxyvGuSJdtJwqNF82QxPG1NyZEEk=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c052b02-e648-4940-14a5-08deed37855e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:25.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jcbAhsoKPsL34N/wFQQs4ak7N3XgOej7dSF46T/axRczkt6agQTybilz4EBeQ+5R9grb926i2VeHf9394q0ZkCrKANbIXSiRNOljd2ah1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

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
index 6947487f5169..7234740a760a 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -218,7 +218,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
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

