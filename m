Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021112.outbound.protection.outlook.com [40.107.130.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454449CF4D;
	Tue, 29 Sep 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674739; cv=fail; b=WAQk8MzwW3XueaFpSVJ/IJNn27wU5vdSU6tL7icCo+8x9eJslol6y7yh3yqyvoP7uwgRySbHEqiWGjCKibaWxZtZD5Nbe17UvonZDoo6L0gFNqiOIS8lL8GNKGuwBiCOwFKsgZ9K7ZNRVU40X3sbo2abuhu82eKPk4JQTeS7ygQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674739; c=relaxed/simple;
	bh=WXlpxSbiH+LK67PdcJ7w1VXYlMykU7peWZPwep0DwgE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hT6Y4EmwMkpI3poNj1DsDNQrcywhLKtkVo8uExroSdd0YuIg4tqwwrE6NIWyPDU/eqZoDRi1/vNIy+aRXvsZKSNPl6rZ6fq6HxqUj8HClha3N9KK1r7o1yE+s9Ej10lh0tYEeF/t2wj3Cuy2xRAGFdIvloqp5ZWjbzAukpi86Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=wClGP53y; arc=fail smtp.client-ip=40.107.130.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="wClGP53y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drpWoAICW0q7wnGR428N7QG12T1TmYgbr/VlpUim2B2pSXL2pLOh+oKZxd72ClHTKn6ZuAaTeA1XgO2JyYJbgFhnKD18AjiPG1oykSZW1062HxpQKEVbWnLKU3U9jExOuMcB9r/dbkS5YFMVddWxPJqxChaCR8BWN9B0ufZnNzG2wECTYmp8Z0gKfi3NBX5aJH5+6SRASFVWFT4qtkBstGRIOV97hynhe1s2XL+rWPxn6lDuDpgg2ENqJ4MLB5EBwEpi+AkCRa/Iy2nu+kZ0fDUp43n7jhWNK28Wslf8OzaGTwWd/eow6cBuYWxQgE7fhCiyPZm+ow3IRaf2Lh5qbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za7pKk3LDqc03hyRnO/yfOpwlbS9JIuBcjn9LEW3UH8=;
 b=tpfwd5FbyGY3YPtoUIC7lN5vr5c9HZ3OcUIYYglABHY5FRuVqePEDTDnd467OUII3ZlTZLUFxa8ksH6hd5eDslQi50ViVbnopjJaZZNse+XysvQCk6U/TTAhHlUM+T24PjRHaZo6ho4fi6wCPhYwGSv52POKShEjZT4dESToNnVzjTCiEOzLMCEp/jWRivNvJj+sj9W8iHC0Int5m8VKNuVZprYNFSjagwzL/RbkD2helRtWb68H56OU6sWBTsVCpkfsC7pCewvg2lXlR/IDjG/oNJ00YoSuYPngZYARZsL1R4wC2YVwA4Sg/0d6UdIf+IPEhl8o1dzn9TdFSLlkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za7pKk3LDqc03hyRnO/yfOpwlbS9JIuBcjn9LEW3UH8=;
 b=wClGP53yEr7V+9SCSaNLUBJTOhaMbax562dnLgpLRkDzOxrqDePKXPYpB4e/74kyBz7Kv7ndxP5VZM48sOv3tj7VZUoqN7B/8xu/XjFxsGr+iwQ3VeNM+/RL44nQ8QdqMLwSfT4ncjGr9R7LSq6AgiK5bgFjj3IVs4vIqT4PccbsZcZioez5y/ewtyL3HMQPEEjswE+uY/ujzGOhgkMsBuye6yVyK9tsz5tlLKZ8ZR7eRj3hv9DuinujqirD8bg+Xto5vCnkhbh+co5C/03uB0hjiwcr9ZuPHMp7UbKtf2GEvIuYrlN2V4EOCQyLEJ5cVqlW+W/gFcUPHAGicRYw6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PA1PR06MB9752.eurprd06.prod.outlook.com (2603:10a6:102:446::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 09:38:48 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 09:38:48 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 29 Sep 2026 09:37:59 +0000
Subject: [PATCH v5 5/8] serial: max310x: support active-low RTS on the
 hardware path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-max310x-rs485-sw-delay-v5-5-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790674682; l=3644;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=WXlpxSbiH+LK67PdcJ7w1VXYlMykU7peWZPwep0DwgE=;
 b=05WkChpRG0oQv+U6r0JKUH4Fn8m7bgkyINL1km+wUAqDC3+XKy6OYtYlCgDf0Tq8uy/ir6i/U
 X1ppprZiLJBBsbfWizqUkumQyqv4+ND47DGiLCMd/vxkj6j1hjKhNeW
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
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|PA1PR06MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 553418be-28a1-49f6-3dc4-08df1e0d5ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|366016|1800799024|38350700014|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZroR7tH4ViFJl7f6eno0wMuSNa6xnSr+/fOHhctSqJcGw0kTqX+sTi+gaQJZJa6eQTD/Nv2yhMR/I3tnORKuOkHeORaaoQb1C9EnF9LxMJwM0MelmP+kIiIn4CMFW6XxV2hFAU+uzSwli0PmOoWN5DTXzwN1CLluHvWrFj9WSrZMPA0TBDXrolx0ZvZGTbdtYIbEIGa9mM4e5ybDdaEaO0g4c8l8QJdoBp7mrWYLWf+oBhHk72gJunJM7ytqo95cRFqbJaiS9GgcY3meoGK7a7h06JWjUn9wpuMGl5zr4gWN5CVG98AwoPTPk0hWhjq3vIePxGh+23J0VeUlFAJ57x4janqyPbSRzRRboEf/qHT17Cu3LwfXXmWJcSRlrVZ4XKKJJ8y5iy5B7HbLNYBu7q6vrx4LHxD0dvWgT/N7LvdZA768fRpMgXSJbrVF3HcVeI0IWwtQ2XRsVo97spwbXemBrrs5m8zGLLeQtbFdTT0U5OLcN4K495PY8/d09syPmr8v0Ephv0FQz5z+NNWC2Of62U1TNotqV6XGZUO+kxesDY03Y2QX7eSSxeBdr4A1XIjbexQ/WFC8GxsRjYN5vRQnKvgBHdQIORfcp6a8G13LuZt0NvJ0f7n+OfHXXl8ce8G1hmngZbAVDw6ugWHEUgn7zRRqcNFCLbmNZf7+TIY0zfOjtknPtPT1Gj5rDX4SIPnU2OHH6bmsjYF69UJfxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(38350700014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnJqY0xLMm9YZUdqaGM0eFYwaFJ4TU0yMlJ5aU1EaHNOMGZqQlBrZDY1dW90?=
 =?utf-8?B?SzR5UENENUk4bmUvU1ovVWU5bXdKdDZKWHBzelBVU2srdE5pWkxXRDRwV3VH?=
 =?utf-8?B?N1Axdk9wOGRZR3F5TmNCbnVUYXN2Wmc4M2xLSUxRTll0allOeklKcFRnL1gr?=
 =?utf-8?B?VTY3UGpUaHFGOHAyRG9PeEZ2amhNaUVBNWlzbUJ0WFNoYWRVUWFhbzAyU2JL?=
 =?utf-8?B?c2hOS09WNFpjWmRsVTY2cDV5SWVoRWxyT3ZQWjRUa1lid095VHZQa3ppS2RW?=
 =?utf-8?B?cW1yZjM1RjhYTkNpZDFJRjZ4QnVUTUVHdVluelFaVUhuSm1DZzFvVXhZL2N2?=
 =?utf-8?B?bDdSVWZxUG0vNWNhelgzVGtvamNTNS8wcmE2TFFVNlJGdU8rL21SMTBCeEhW?=
 =?utf-8?B?K2VFQWVzNFN2bmI2ZVc4YnVneTNLSGdheG5PR3hLVWJCa0N1b0dWb24xeWEy?=
 =?utf-8?B?aW01bTZ6bytibzRzR0lyNkdvOGFaWWZTQWMrcGwzeU9OZFdQcmhmSzQyRFFU?=
 =?utf-8?B?czJVWFFoakV0SDFHRndxOUZzS3lTTURNQnUxRXk0dmhkYWtVWWk1Yis0TFlq?=
 =?utf-8?B?TkdYdGV3anBYRDF4UUZBSmJabVVZL01sb2pheXNGUTR0SnJEU0hIY0JFbll4?=
 =?utf-8?B?bXAyR2dMSWJFeEUzSkJ2djF1UHRDdTMrNjVjdHJPSkErQ1NGZytCSEhqenc0?=
 =?utf-8?B?clBIZEZ0dkViTTJnMXlWTzNJL2lmTTNxVGRqT21jTy90NEs5UFJEeGVNbGx0?=
 =?utf-8?B?eVYzeVhxOFhHUU9MR2szaHh2dlRKY3F6WHZDV0JwckM5UGJ2amV4Tm40bEV1?=
 =?utf-8?B?Tkd1NElxSXRMRDBLdnEvMTZ3S29WSmtaTXFYcUNPekZCK0pjOXZJclVCTFNp?=
 =?utf-8?B?bTFxclpabVh4Y3JsNkg4cjVhTFNTVHRCaEtsNWIwaVQ4S3FhOGNIdlJmTWtt?=
 =?utf-8?B?SjJ1a1JhK2ZKd250ZGF4bzNMMWdWTnlMT3d6S3NtNy9xTzJJZ3QwSmJEVGh1?=
 =?utf-8?B?QVNxcnFxL2o1MmhjdjRJSXVrNmYrd1pHL2NNeUsrRkVpNkdncTlKbk8wTWRM?=
 =?utf-8?B?SjFCdW1janVoRTl3WjllNE12UnIxVG5LOGtIaVBES1lqN3dXZGFBMzNjZ3Zy?=
 =?utf-8?B?ZTJvcGgxRzhrbXZrRVdPU2RvU0YzWWVrVzkwTFJzS3VwSWhUdmpMTlk3NFJu?=
 =?utf-8?B?TUpwQXFWNHVZbTNWclVQOTRCalQzQTBiWWJ4c053L2NiREROS2x5b09oR1BG?=
 =?utf-8?B?SUZ3dFVwYXFseSs0U0I5KzFFNEplWS9rYkkweForMWdTYzNUcm9KLzEwMnZh?=
 =?utf-8?B?ajR2NXhJZFdGUC9BSlVPMGNaeXdxcFJwSXE5TlU3MGhRVUM0OE1TKy9XK2R0?=
 =?utf-8?B?dnJTY3ZDUjFjZitMSXpuTVJXY2hwVEkxUGo4bXhjWU9hdURNMEFyNzI5RWYy?=
 =?utf-8?B?WEp1eEtlMDMyenkrSG5BbGQ2d2NEZUJxcVBHM3ZKU21SU3J6R3B4ODNna0Jk?=
 =?utf-8?B?V0ZlVEpsVEw3RVFIOFdRalBIdGs3UUF0bk5Bb0ZmNjRXVEdpZ2hMakpUOHI2?=
 =?utf-8?B?WjRESHE3VHFMSFI0WW83WWw5VThmM3dGeTJEdkhYUm9RcG54djh5ekFyQi9B?=
 =?utf-8?B?bk53YVQzT0xtb24rWWFLK1lvYTd2R2FWVzhMdjVDWnkvcDBhVEZPVHBsaUtD?=
 =?utf-8?B?bmFOOS9vMzM3T1JJdHN2MVpid0dPMjJrTkhOY3N3VUpwT0tteEpOSlZxRElH?=
 =?utf-8?B?bTNqdUhDY1g4dnR1QlRjVEQrVjgyYWdkYit6YVVTQk1LQTVSZlRPZ3N3Nk8w?=
 =?utf-8?B?Wnh0RXpvN0ovSmVwbkpiOXF3R0dIMFdweStlL0IyeUtsOS9iY29RRGZTb1Mv?=
 =?utf-8?B?WjFuWGMrWDZuS09LZGwzTWJvZ1F2RlB5T08vVlZTRldHUUswRHJyWnBObnNn?=
 =?utf-8?B?SU5oUzV3aWJjVjczYm9ZR3dDZlFTTU5UQWVGYmFhMUpnRmJWVTJ4MC9kcjJi?=
 =?utf-8?B?NmFsazNldFVkaDdVKytVL3gxODdMOHBPS1hxbndzZDB4a3J6MHRxSVBkSE5m?=
 =?utf-8?B?RDE3Ym1kQllKd2s4MmVzR21keWlLc3ljTTJaQlNCL3lRdkFhbTRiVWJJSjJi?=
 =?utf-8?B?ai9ETVhaN0x5ZkpCaUcwbmw4NU9ZbGNiU055dmMzL0ZVTkVVc0pSNkRhS2JF?=
 =?utf-8?B?VEVNVDZlS01rTDVySTZmM0psOE9FeDhnd1BETDVVYUwwWWlvaDVEVHhuV1dE?=
 =?utf-8?B?RGY2S2MxY0YwblhsNDUrZmJYb3NKS2FobzNBWHBJNTU3YitxRjRkSTZURFFM?=
 =?utf-8?B?c2UzQXhDU01BbVRTald3VDd0V2N1TFJoUTl2WllFMnNNZWFKT2xPU1c0Qzk2?=
 =?utf-8?Q?fshRYJHyXUzc1+5U=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553418be-28a1-49f6-3dc4-08df1e0d5ed1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:38:08.5566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9FW7fsY4VblieW8gM+moyt1MuAI4IARtC5czzD6URHQ2xg0XhIu9BnVkByyah62LrMGHG7x+VSp/l1civiKuorNhv35moFYCKCetpOzLqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9752

The chip's auto-RTS engine asserts the RTS_ pin high while data is
shifting out, so a transceiver with an active-low driver-enable could
not use the hardware RS485 path at all: SER_RS485_RTS_AFTER_SEND is
not in the supported flags and the core normalizes it away with
"invalid RTS setting, using RTS_ON_SEND instead".

The output stage is invertible: program IRDA.RTSINVERT when the
requested polarity is active-low and advertise SER_RS485_RTS_AFTER_SEND
in rs485_supported. A break already drives break_state onto the RTS
bit unadjusted, which remains correct because RTSINVERT inverts the
output stage itself, not the register value.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index cd3b1913aaadba94805f4728b5eba18e970e34c8..e07fb87f21f102cfa3fdae5275cb7810be1c3dbd 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -164,6 +164,7 @@
 /* IRDA register bits */
 #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
 #define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
+#define MAX310X_IRDA_RTSINVERT_BIT	(1 << 2) /* Invert RTS output */
 
 /* HDPIXDELAY accessor macros */
 #define MAX310X_HDPIXDELAY_SETUP(val)	(((val) & 0x0f) << 4)
@@ -951,7 +952,7 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
 	const unsigned int max_bit_dly = 15;
 	struct uart_port *port = &one->port;
 	unsigned int setup = 0, hold = 0;
-	u8 mode1 = 0;
+	u8 mode1 = 0, irda = 0;
 
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		/* Convert milliseconds to bit-times, rounding up. */
@@ -963,6 +964,12 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
 		hold  = min(hold,  max_bit_dly);
 
 		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+		/*
+		 * The auto-RTS engine asserts RTS high on send; for an
+		 * active-low RTS let IRDA.RTSINVERT invert the output stage.
+		 */
+		if (!(port->rs485.flags & SER_RS485_RTS_ON_SEND))
+			irda = MAX310X_IRDA_RTSINVERT_BIT;
 	}
 
 	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
@@ -980,6 +987,8 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
 
 	max310x_port_update(port, MAX310X_MODE1_REG,
 			    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
+	max310x_port_update(port, MAX310X_IRDA_REG,
+			    MAX310X_IRDA_RTSINVERT_BIT, irda);
 }
 
 static void max310x_break_ctl(struct uart_port *port, int break_state)
@@ -999,7 +1008,9 @@ static void max310x_break_ctl(struct uart_port *port, int break_state)
 	 * The chip's auto-RTS asserts the transceiver only while FIFO data is
 	 * shifting out, and a break is not FIFO data. Disable auto-RTS for the
 	 * break duration and drive RTS manually so the break reaches the wire;
-	 * restore auto-RTS when the break ends.
+	 * restore auto-RTS when the break ends. For an active-low RTS,
+	 * IRDA.RTSINVERT already inverts the RTS_ output stage, so break_state
+	 * is driven as it is.
 	 */
 	if (break_state) {
 		max310x_port_update(port, MAX310X_MODE1_REG,
@@ -1407,7 +1418,8 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static const struct serial_rs485 max310x_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
 };

-- 
2.47.3

