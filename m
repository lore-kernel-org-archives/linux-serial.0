Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023090.outbound.protection.outlook.com [52.101.83.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553DC4E73AA;
	Tue, 29 Sep 2026 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674746; cv=fail; b=FPiVXnJlPorsSHaI6GzSbDPK+vqC0zYnNOPeQxwXx75ji8b+HCeJpAoSKIwh2ExHJEedntCV9BWWkmyaIIeWNDYw9eNyJB8nCu8nTa1vDHR4EJN9LRCRZOwFKPsVAcQTmj4LRy8BbIN10FFuzEcrwNIABZ3vlIdWj6+t8/LCZgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674746; c=relaxed/simple;
	bh=5c+p/jU92+tgWBa+Q4hPP38+C2DNp+oPXeEZLPEDXVY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oFCKiXmYvVncU6bPdRDKqgtsYCZkkyfE6aatosHTTU6x1riHO5C4+vNaONjd3SjJveJo53Vnwm9ggSgRc5mkrS3FeuJMNVwrDAohw7sQPy+7eXS1zvBxptcxeBw67XOhFwgEnyrdLnQlrN0mo6tEs1apdXRdshYnc3LEvvp2PJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=r22EdCb9; arc=fail smtp.client-ip=52.101.83.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="r22EdCb9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D85gkvtUnC7vCo1+jySyo9PBxM1+in30nr7lqVW3gZnXki5MdQY2XNwNUcKLa+jam4gtKLoycBqjRRXEEma1CxkDCywQv7v9WPr7CA4Qs5Mjt/vfnPIo+RBnsaJ2n47MC64SWt/u+4m2JUCvGBPISiaAyoqlIaEQCZdA0QNvtnmKlJcepZT9FYmhJB/nDy2JbmbmQ8QogBHUB5w7crNQii0azrwNAsX+DgSqCt32xq40/nSFQHdPBbGAGphDm7jfmuGh9Ok4mr1itNfDZZZ0CUwE+3ITOVjIE62O0IhF5ZbFMIKyw4DiZJ2cOz+3lXUk+4K880jKLtnbuRbzxVwwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WlmnVv7W5zzYMuiEXNA/PX+PI77LwibLamudSV2lHo=;
 b=FdOfDpa4T3Rhdsl2i2fWJIlk4h4xcldV7DcH2VuCCQtu843EdDWWrREYW61ckoQ5L+YVDDv4mh0JDVXG/A0YtDd7AVCKCm62SpTvnVoNvpainA7TMbAClCYAXP4ut/w7qkOrU0tw3HHEQ8ZkVWzKQRXruecNVtbH3vgYCl+kiiMHx0E+OTZnHduT+zl0K8358u0mXHtg1uFuBrKdypO+3oi2DkwHLiayHlgknJHiWPdsfbvTtNAfOQ9+nXaQG3BPpqfoAzcMN2fleN4zHF7ilLp9z9IdUrHPkhG1xuQvUD10vC6bN+4jM1nOmoJ7zu6hR6sga3VHpTxWfNHWLxPnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WlmnVv7W5zzYMuiEXNA/PX+PI77LwibLamudSV2lHo=;
 b=r22EdCb9vnmJTKb5goR/Ys04kkhXZf8Ko0JH3hEtawvs+G2T4MBhZjlZvlju3MoI5RdiVj2jNoQ1RnxNYHaMMmtwthA8pu0C70dUKzViX+I80zVvT4nhwVFQHvmzLi+VIurdkuQXtqYQCWFS5XBFJGd/YIpf8r8sDnMyim3BrH8CH6Xe7PztyP2TpYcKPn1bJynNegfjdQbr19advGjXzNxx4RVoc1xjv1puNQi0VuSo/e0X0hmBGu1O6HMfikL5ayZ+HtXu8+0Yj4sRhtY73IQ2q/6gsU4sOfj2liSQnhBUuw63/tmnltvVZWJL7xZQvgQ/+aBc6XL59ED/yLsU/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by AS8PR06MB8258.eurprd06.prod.outlook.com (2603:10a6:20b:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 09:38:15 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 09:38:04 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 29 Sep 2026 09:37:55 +0000
Subject: [PATCH v5 1/8] serial: max310x: don't clobber the TX break bit in
 set_termios
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-max310x-rs485-sw-delay-v5-1-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790674682; l=2712;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=5c+p/jU92+tgWBa+Q4hPP38+C2DNp+oPXeEZLPEDXVY=;
 b=/L7D22ZiLXdZHw1x86pVZeIO9F8bUq2UDc8aerZU4JDNRrjseGGdShG2mVdRsouj8E6YKIxXh
 a3Zdf4KsncuC7oLg4WVeYs08lbhMCexxNMtR3EqG9Ex1m60W9Mxc5Th
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: OS6P279CA0089.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3e::11) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|AS8PR06MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 42820977-bfb3-495b-b562-08df1e0d5c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|52116014|376014|18002099003|22082099003|38350700014|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	wzpdXWFoeUAy1bAoCJFEY+l5vMHJViTYIhNjqp+JVQ1FpwhJxO1GuwEk/xCcFMbww40Ww4AZcSILPZTxm1/c/4j2/pWjQfS9g9BXsELBUPHxxMJyxwcZVGW6A0z2lZ3LXfsey6vv9QOCAla29UmB4KHakZa2MEZTJJDoG6QWbYGb05WaFfpDDmuTYR7wLKwMziD19f3S5kdSfoBOIa/n1qIg6dz+1E+kdh635UbFp5Y3+RmQsC6wCdhRErMn9CnHcECq3KGQNIJSdbGy2A24BjK0vzPHVTxW5gC4qUZUy6aHXmKqQOO8YtCRbZPabNPZh7jFP45+HwO7Y3NvHAdK/IGbDRhXKYsR6BWlTfliaGV9gndbDET9GZP5sDReVkhwj704lBQtWFo5+SeOM3swG2CiYK3DI7jJfVjGpbcvMDkydwCeMiYgFO6ORFPdDhfUivt2EwWWaIYEvyIrLdQzc0jNjl9XRjlNufJUAY3yJC18e0u4ystKpeJoZnakrrDgA2Xy9u4L/aMyo4eG2CnBqvHt/+l7pGe4SrgLfjVV+Ku7+8j+gde4xNJQOCJL/x/UXmTEFpNt9jjYJ0IVRS4c3TOjKwYruVep4AvQUMwebivvQ0yhhJ9NrTf8jHBeBQ33S1l8qqrmK4JiFDAOh4/2rCgxCNIAaI/NUgyGetQhjl61T/oY4Fu9aE9FLHK6BNAhCEdf5dOBv4bMXbU7tWdvJR74mlXM+vdghWb5mUu+vxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(376014)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUZhNThtN0wwdlp6cDdrNFB4OW9nSk9aTlhOdHNtZngyejVLQUJnOG5xRUF1?=
 =?utf-8?B?eUYvZ25zN2xFM1RaOEJJOEtSM2hSK3hyZk1JV1FNQUx6cTd6RWNoanA2WnpF?=
 =?utf-8?B?RFdUMTVxTTlNM21iWktwd245bDduMmhsVHZNQld5b3llMXJpWU1pZjV4SHB1?=
 =?utf-8?B?RUFvTzdLZ2NZM1puNk9vUjVLeVk5bWNpSVJqTHVidmFxN2J5dVBJMk5DU2Ro?=
 =?utf-8?B?SElySUcyVFNUdjhrRDIyVVo1NDhmWDNsRWl0TE1lL0g0YUpaMTJMQ0krRk9a?=
 =?utf-8?B?YU83d0FnajgzTUVVSGxCSnZGaW5IOGx6bGtzREEwemUxcWJOVzBsbnMwY3lE?=
 =?utf-8?B?Nm1tT0tJcUN2eWt1Z3pjSEUxM3dpVGx5ZEdTMGFoZW80Z013UzYrdUY0WkVp?=
 =?utf-8?B?bG1ucHN3K2sybG5hTXMzS2NBT29rRk15dTVkaWdUTERsQU1Sd3BKUUpuQUpP?=
 =?utf-8?B?UkkrMmt1T1AyYXJEM09qVk03VFRuckNOY3UvK2paVTdoZk9mMkNJUkhQM24y?=
 =?utf-8?B?MDlHLzIwRVI2eFpYRUR5cTZncW9QUE1ac25uU1JMWnF5K1lhOGg5K3M3MDFt?=
 =?utf-8?B?aDU2eEx5djZTZVQ1S09vbUpabXovQ2xKU1cwNjRzSWNmb3Q3U3pNa25LRXpt?=
 =?utf-8?B?M2pQbmc0MDBnS2p5TFRyT2twUmFYa1pra21maXhxQlBhMENtK3VoZGNkWEpL?=
 =?utf-8?B?MFdiVFBpOFIyQTQ0ZXF0dSsxcWFLejBDdEZNWVNKM0ZJYVpYd1Zhemd0Rkg4?=
 =?utf-8?B?VE1iMHJWNVoyajhpYWtpelhOcjRpcVNrekVBZXBNQUoxNVF6UFBTaVVoYjcx?=
 =?utf-8?B?NURGbHlRTHpZZ3dKdG01bnJGOHF6UGNGZXREQktDUjh2SnQyeHVNVEJDTnhO?=
 =?utf-8?B?VG1KVDUzeWFtMTNqbzUxRlRQc0NETzJZR2tRUGltTFluODVRSS9FWm95Ymtn?=
 =?utf-8?B?cFFEYlpFd1R0TGMxaG5mZ3Z0dXAzVHVKWHpFa1JtWXVHQmE1MlF2K25MaTAv?=
 =?utf-8?B?V21qbXBCWjN0K0dlOVFEa2FNZUU0RWwwS0F5U1E3UkZ5UVhmNERvSHFsbGdD?=
 =?utf-8?B?bW14TnVjb1o5YUgzQS9EUVFsY2QzU3dGV1Vvbm84THhaVWRjMEZxNE14U1p6?=
 =?utf-8?B?Q2U1Wm83dTFnMnRaUTZOVUc0NUZpOHpLNTg0cmpZOVE0SiswQXRsbjBuYUdy?=
 =?utf-8?B?ZHRsdHkzMTNmdmM0NElKMnk3NSs3UWd4RGJYVXQzdWY3Wm9aUm5FRzIzRWtV?=
 =?utf-8?B?ODBJMXNzckhWSWtaTEVZUHlQY1lpbmN3elhuUE55S0wwZSsweU1pWXZCMnF6?=
 =?utf-8?B?ZUxnNDlXSzUwc1d2eG9mMzRIbG0zYjV5ZW03Vk9SWVkzckVXN0JMNTFNSDdr?=
 =?utf-8?B?anBWU2NRU2s1Wjc4K3YzQTVoL3RSY21CSkhTbENCMmlxWk9vSVp0c1k5MHVh?=
 =?utf-8?B?TG5GVWptMEJPaXRsb1lqVVlKN0xFNEpCNGcvL0w5azFQMmptangvbTJyOEp5?=
 =?utf-8?B?RUNwZWlkZDFmcGdiU20zVGVHR2Zka2ZVSXgybzZJKzlyZHpOQmx3NWNmZUZl?=
 =?utf-8?B?TkJWZmg1MmJXcW5ENHFMM3VsOGxkOXFpcENPQzdwTFZ2bmdFMkt1aFF6akRh?=
 =?utf-8?B?bkt3cEc4dFFCWHQzZkNXZUdwU3hWekNxc0RLbDMzZU5aV0NwVzk0T0JEaTVU?=
 =?utf-8?B?a0tBbzNmUFk3dFUyN1Q5TU9TQkVUamZSZEZ1eUkybytQS0F5My9VUHpqTjht?=
 =?utf-8?B?SWFmT1ZwZzE1NlZqd0p6blhkOGxNS016VGNPOTMvenczTy9iVUpyWThSMU5B?=
 =?utf-8?B?MlAxMjhjbG9PUzBvMWNwK3Bsc2pKaUNoTCtqdW9GM3FGTFNTTDhqM2wxRlBm?=
 =?utf-8?B?V0tCaXovVDRzYURydWE3VEQ1cHRRRlRzTE81VXFHVkRWTS9IVDV6YlZNNlBz?=
 =?utf-8?B?eWdma2lHbllGZlFrZVFpN2RWeGI5b1NyaG9PTGU2OG1PQVVmVmdUUlNmYm5U?=
 =?utf-8?B?RWR4Z2lHa0FDNFc1ZHlrVTBia3R4Wkt6aThNSUJHR0Z2Si9ESVBlaFRubDVB?=
 =?utf-8?B?TlF0V2Z4NjdHVnBtWUhzcUM3cWRhZURwY1VnOFZpTUZvOHcyM0JwK0NnMVA4?=
 =?utf-8?B?VFg2R3Rhc05IV3l1c2RlTjZoNGp3VC92cEJzRlhnZkZkR3Ribk1FbDJWaENp?=
 =?utf-8?B?MWVGN3Q2WGxQMktrZUxjYis3elErK1NrcE9wWTVNLzZ6Q1dPNW9UdTU5TUpO?=
 =?utf-8?B?MWZ4R3hpQjAvQlp5WXVuSHpwL3c1cVl1dWVIS0lYM0xwT0kzTFQ2S0FKOW1s?=
 =?utf-8?B?WEUzb0c3Rk9VN0FIdVNBRTErT21RMnNDa2ttRENUZEIwRkIrTWVWWEJjcXcv?=
 =?utf-8?Q?Pg0/7PQwNJYPwnXc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42820977-bfb3-495b-b562-08df1e0d5c70
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:38:04.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ricZyiOTc5MuVosmN28wG/9jzD/6GOV18Zsngfo1A1+chFrlhide+2bXSSnVvLNUNeQ9zZR+oVWIGLaUQDrHFfWbqWmmX4STEvfNHxHGI78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8258

max310x_set_termios() writes the LCR register absolutely, but LCR also
carries the TX break bit that max310x_break_ctl() drives. A break is a
state, not an event: TIOCSBRK sets the bit and it must stay set until
TIOCCBRK. Any termios change in between - no concurrency required -
rewrites LCR from the termios bits alone and silently ends the break
early.

Update only the LCR bits that are derived from termios and leave the
TX break and RTS pin control bits untouched. Since nothing clears a
break when a port is closed with the break still asserted - the tty
core sends no break-off on release, and the absolute write here was
the accidental recovery - clear TXBREAK in startup(), the same way
8250 does.

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 022502986c5fcf1ff4de9328746ddc71677be730..4c1e10e0765f45a51e0c74ca965588f39872efd5 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -158,6 +158,8 @@
 #define MAX310X_LCR_FORCEPARITY_BIT	(1 << 5) /* 9-bit multidrop parity */
 #define MAX310X_LCR_TXBREAK_BIT		(1 << 6) /* TX break enable */
 #define MAX310X_LCR_RTS_BIT		(1 << 7) /* RTS pin control */
+/* LCR bits owned by termios; TX break and RTS are driven elsewhere */
+#define MAX310X_LCR_TERMIOS_MASK	GENMASK(5, 0)
 
 /* IRDA register bits */
 #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
@@ -969,8 +971,12 @@ static void max310x_set_termios(struct uart_port *port,
 	if (termios->c_cflag & CSTOPB)
 		lcr |= MAX310X_LCR_STOPLEN_BIT; /* 2 stops */
 
-	/* Update LCR register */
-	max310x_port_write(port, MAX310X_LCR_REG, lcr);
+	/*
+	 * Update LCR register. Leave the TX break bit alone: it is driven by
+	 * break_ctl(), and an absolute write here would end a break in
+	 * progress.
+	 */
+	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TERMIOS_MASK, lcr);
 
 	/* Set read status mask */
 	port->read_status_mask = MAX310X_LSR_RXOVR_BIT;
@@ -1088,6 +1094,13 @@ static int max310x_startup(struct uart_port *port)
 
 	max310x_power(port, 1);
 
+	/*
+	 * Clear a latched break: nothing clears TXBREAK when a port is
+	 * closed with a break still asserted, and set_termios() no longer
+	 * rewrites it.
+	 */
+	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TXBREAK_BIT, 0);
+
 	/* Configure MODE1 register */
 	max310x_port_update(port, MAX310X_MODE1_REG,
 			    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);

-- 
2.47.3

