Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023073.outbound.protection.outlook.com [52.101.83.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832843F4A7;
	Sun,  4 Oct 2026 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116226; cv=fail; b=U6aGdEWTFIk1HXb8LNvW6YMd0feP44GcpYnv116ALa+Nlscm8dXz/1voaay5QLBCJ7bofHTqIPRun3DmVhCvNtIzjfgVlZC1Of7wA5+UH8yULlDOizEflFtd0oeq1UQLqOK/gp+46b4ElldDxUomvzRkSJp+YRz95T30DGPga1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116226; c=relaxed/simple;
	bh=UQ/U5TXKBSO6zGq9CfGLNzZtNCEKcPVpLfa84U+2e/E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kevIJ/d7Hdkq9IJNLsF0eJe2BmE46qN9uQhx1yDmVlDFype4i2sWSx2OTYgjLlgWQUKbusxrgc8nP9bI5Rxa65fgWmOkePQn1PsifNeGyX1MjdRUrihk9MxBxxNW+SwEl+BtuUP1JTO4wn9o7q0p1MHEZ6BbF3MsaIR3zp5Vm7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=bnTNIZr7; arc=fail smtp.client-ip=52.101.83.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="bnTNIZr7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFYUlj/UoBAb5O0of59U+j6gbLc2g3i08/tazqcuy/0ICTankaG3+t6YmKe9e764UTt1cZqkAoPOQmtS05ncXV/wcDCec5D+qwNOH0xT9I7DSMRWerSeL8R2iyv6GQmgGM1BJzk3e2EMh7Gf936FT/7kq5zx+pUQr9tdpRB3brdBtFzCHPi9iJPPmHE0Sj6V0FNyU49Yah3L7meGHp3Vh/oiI3ga+q2QLtEXzbr0STz/caVFUod0vptlJvKzB8fHIwGIyeNj14QsmjYqSzXJ/XU3HN2D3oFY7WYDEFfjfcd1N0UMjyvDMqYboGFxQw4o/6apN9CrXWxpA7w/kh30VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8E9/RnwrqpEBQB6wiYXOIOxDkpzALlyImh5fw0MR3+k=;
 b=xQ9XRUYui1bCwPqGjd/psBeVjW/Qhcecvu40yRN86KeAD4mjs6K9J0Jz2dXZFGCHn5sKDBp5qIoiJZfEZ1rXkb/l1F8yFgIut2HSJrGvlIjwnlC6A4g8K/B+pUxjcjKk4bunMi0YkAMZFcuDRaiF9lrhzWrPQmfXusMz3k8F3ooRgK6t4v6O8JbRvB+5BQPNvTvpDG65flD/GRtfioCZ5wkaA7Q3PjDyV9T1iTGAe8LDuhgGLTUWouP5i3orJphC/RCnSiQQICD31LLsB/Ua0zjz2tEns7IiqLdl9tMRrmCjkePfh6+b696fcJDyCeI+iX+edWFMMgEO1/3nJy764g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E9/RnwrqpEBQB6wiYXOIOxDkpzALlyImh5fw0MR3+k=;
 b=bnTNIZr7yELPubrzBbhmuzCL+yHuNgEOyPOAHrZbQ2sjlmyqctl7yYzzMB4gkkduEx1vSZhitAhWajPYr68gBv9j+MNE/vyuPaDtoeURTWMZVUm55K27potBQ5Ec0QsbWreK7tQw4Q350QD2os8hb8ydvOazcuavI4kTwJknkj811oV1HGSkQT2zRRYtGktEY5o7oCZ2XwrIi5hX9QLZP9yfF+FsWdkCTxCcIFBOmB5/HmnwFXbcdPcWgykPJN7Oqa8hJh8Tgpv5OEiq51r9JVCKXfny6ELnYKAw7bJFLjRsinG2dP5nSdRZX35G89qWpriFwZhbwh7jm9ErLLmpKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI2PR06MB9239.eurprd06.prod.outlook.com (2603:10a6:800:221::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:16:38 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:16:38 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Sun, 04 Oct 2026 12:16:26 +0000
Subject: [PATCH v6 6/9] serial: max310x: support active-low RTS on the
 hardware path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-max310x-rs485-sw-delay-v6-6-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791116192; l=3681;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=UQ/U5TXKBSO6zGq9CfGLNzZtNCEKcPVpLfa84U+2e/E=;
 b=J65tcxHo+iBeM5ZeNfQF80Sr+Pgf+V4WieL9xGWNv29cg/uz27+1d9H29f5gr3w8ybg3PLqJC
 33YooXbMQRwCt7tovvY/h2nhqEitVGwlOlL+PjlkW/RRPhH+nx2GvEL
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::6) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|VI2PR06MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: d91e1fe3-c1aa-427c-c730-08df22115719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|52116014|18002099003|22082099003|10067099003|3023799007|260925022911599003|260925021911599003|260925021311599003|56012099006|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info:
	wDsi26JXzpIN/JsiUbi5AgT/r5zn8WjaPB1NcPNyd8/RUqqtizghQ81LQwETrpDrFycATGSUantUu15B3BJAIKx9hVdwBJUwawoDrX9IWRHq3LHUit4G4s4rqVFo0pfUuZKjvbfTuCpwKHY1Lep4ZSMR3iTDQNkO0pYUlDPmbBZ02ZcXJX2RHdnsLURs+JfGuLEPqKoUdGc5AnYI53BdIbavBdp8CB6c8RBFDge+5oGugpqOzC+6Qhw9DC0dDCpzHtAD1n5NDhG6AyHFdHwSxs0gBZjUGgDreOhJJSddH0zfG+KcsvEiGcZSEm+lCryzDtNpROgKnO6W4TRxd877XGJ7oo6qyOchsZbWoD3/6XPGaziSnZTnpz5jz4iZAsmnGzLu/wg2SyBZwITOroBU6wWp7Fmb4Xh3mxTNyleydB8L8FebccwFIyW92vhQinOGJFFhGv8FQx1UoHDoG2v/od9dNqcp6JSmJmW9cb0HV2Fy8aoX5aUyXGLQDG7RxnbUyqXpFrUpRvRUM++BtiVfOnS3ma9mFfgJSvbf2RtOy3TlN1P5pfy0Slyod5jJ+75tdUQ84bEju1+pWXoaPQLqvSMp2wzCzSXhppop27H1EBlAVcYt+/HsOzzJtxefbPqdAC0rLKZ9jOJgYLHF7Mj6q+Fy+6LTkCHYq1PCbLkrWM9Uf8aY7HDO97dhtaMyjkKlourH5G0yVru4X8dT81QDpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(52116014)(18002099003)(22082099003)(10067099003)(3023799007)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(38350700014)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFl3QW9vUXNQVXRCaHUxTWZENmlGMkdlSjExOXNwU3lVdURaUE9oZVoyTWMr?=
 =?utf-8?B?SnpEM3hDUHRUUEV4MGVrTlFsOGFVOHZyZ25sRnRlM1Y4OTRRb1R1dVV0VStE?=
 =?utf-8?B?Y3RxK2RTMThtZzBWT0xqMnUwL0xiQ3ZERWhIVy9YLy9kNUhxUTd0eXBQZmh0?=
 =?utf-8?B?RVJ4d1YxMEo2WkxGMnVMUk9CWHAwT2tOR25RdTdmZGpBUjFzZW5pQmY0VmVT?=
 =?utf-8?B?Q0UvazN3bitNeEdQUjJzU3EyTWRKS1IrWkNOKytBYmpURi9kb29GYUVaNkk0?=
 =?utf-8?B?VzVEaXZITDNBTkNwTmhZQytNRHliajVKZ2ZLdEdtYjBWNW5JSnBSbjBWa2gz?=
 =?utf-8?B?L0FsM3FjUC9XeUp6Um1VM1VzUktscUVFTHJud2RINEdRZXdKUitDbjJRdzY2?=
 =?utf-8?B?ZnhMM01sdkZGV0YrcWI4T2IvazlDRkFWbmlTeW50c2djYlE3ZGlDc0VFb3A0?=
 =?utf-8?B?QkZHNEMwRzcwRTlnZDc1VDVPdFBScCtSeGhsNndKNXYrRmcwZTJwYVF5NG9k?=
 =?utf-8?B?RnlzNHdleWdhQWU3aVF4UmlVM3U0SFN0WnJPV3hPbERJUGlLTFpyRmc1NDds?=
 =?utf-8?B?ZU9FcGN6dWgxTXZDK2pES1dWMytQWmprMUNLMTljNGlJMVBuSmw3eStoSHdz?=
 =?utf-8?B?dkFlWnB1VkFWWDlFYkdEWmN3WE1ELzZuN215dmljTE9tZnNVWnlGUXdFUzBN?=
 =?utf-8?B?VjUrOTRRcnRmRHA3SWJOQ3JTSGZ2SXNYa00xNjNqTkc5aHhlbENUL08yZW1F?=
 =?utf-8?B?SktoaVh3cU9xSW14eTROMlBFcXBtZXlCRHJlTjl2OTBDa3lzTTgveVA4ZUli?=
 =?utf-8?B?Z2YvMzhhYWFOUnlVdzVMdElPMll6ejhlVFJLM1FDcElZMzJ4eHZRdFArY1Fq?=
 =?utf-8?B?KzNGdWQreGVxSkh4ckZkYWhvbXlyb0l4UkYwNXhYMm9aVTFudlVPVXJQSUg0?=
 =?utf-8?B?c0QwMmcrSzUrUGdwQlMrNzkvVnNVRHlXcTBVdEcxQXUrQUQ2YmRNcFRGcmZZ?=
 =?utf-8?B?dm1EZjJ4dW9QM1VIYU1PUmxQbWgySFdHZ2R3TFY5djlwZHhBNmtwUHJmNTl2?=
 =?utf-8?B?VUx3RHFsbWZybVlnMXBvTG1tS1hTa3VOK0FBck5SVkhDeTFLZ3ZZVHFhMTFq?=
 =?utf-8?B?U0dVSFJha3RKTFhqY1JKa3VLQ0k2R3NoS0tKQ2RSSUtDNjk3bEthSkx0dFMz?=
 =?utf-8?B?S0NCU3RpM0s3a2FaY0VuNnpCTWNNK29BZnVuYjN2a0xzSEc4WWkxSWNKR1Jm?=
 =?utf-8?B?VWIvaHNCUWZSR3RoNHNic1VpSzhrdTBiRUp0bVUxQ1JNWEJBNHAzL1ptWk4y?=
 =?utf-8?B?Q0MzS0Z5U3I4YVFmUU5WVXdQaGk3QnFJdGRDWkVlYnNXTVhoWDBTcU04MndP?=
 =?utf-8?B?LzNBTXNaOC8yekpQb1g1Z2s0MGk5MHpSSWw5dFZzVWVYZXJGeTFiMitiQ1ZH?=
 =?utf-8?B?bGVEd2JCYnJoRWRuWE9ZdXpUaHlSZTZpZlQ4RU1xMTJ0czN1c1NXK0huTFk5?=
 =?utf-8?B?Z0tSMk1kV1AyeGNVWVZmeDZqcWo5MWJyQ1dyNlZKdFZCV0xmOGN5aGlONnBs?=
 =?utf-8?B?MjBRZnlWWDFEVkN5NmVhSUh4blR6b29NQ1ZyRGU4R0Njb1RVbW1IYWdVaUZh?=
 =?utf-8?B?YXdPc09OdEc4QzJDWFJpL1dIWTlsWEJ3akptQ1lCWTZBaGw4OWpoMkx0QVkx?=
 =?utf-8?B?Mm00Tkp0RnZmSjFYaiszQ0tUU2duRUFIQXJtL3hpN3lEdlNpMDN4VUovcjE5?=
 =?utf-8?B?OEs2UUJ0eWtSSTdsbXNkelM5elY0QXNaS0lrVStQc0NwZk9nVlExbmlxRjJh?=
 =?utf-8?B?bmI3Rm5BMVhxbktQTlM5RzIrQ05NYXBndGttQTZhU0gyMEprSzM3WU5RMDdm?=
 =?utf-8?B?VXlLNzIvOEdEbytUbjkzT2R2UmZOVmJpb2lLNGZUSnQ2a2xKazFXOS8wZldh?=
 =?utf-8?B?Y29GZjdhczBCNXpBZUFpYWVlOFRmL1pWQUYrSkVJai9vTlQyb3lRZXZDZ1JO?=
 =?utf-8?B?cXk5WHNmaW1JcTlhb3ByeUsvOTQxWDdkaXBKY3N2dzU2VHBFSExPYmhlajJr?=
 =?utf-8?B?dDd4UXpvc3g3K3ZwRXF6cTE5TVhGTnJOVnRrSFBLN2gyMS81THhWRlhNcTBY?=
 =?utf-8?B?dFRtM21TWndLMStjaTJKTHFmSlVwN1N6dGo3Y0Uwd1p1MFVTejR6NXdQTWFS?=
 =?utf-8?B?RVJoRitwWW5ETXZ6QTl0bDJDYS9LeTFwTEw5dDhXc2IvaWRLbThlc04xMUth?=
 =?utf-8?B?Tm9pbWFwKzJ1azNWOWFweHJUOHF2TmJtbENtY0RRMjZyWDJxMSt0SWVBdFY5?=
 =?utf-8?B?c3FmODBLbzRMYWpVcHRFSVluVWtGQTdEeTcySWs1cHpDcGlWZENWRmxSbnhn?=
 =?utf-8?Q?kCSmeXcZOkPAGlus=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91e1fe3-c1aa-427c-c730-08df22115719
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:16:38.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cSl7zEiGcOWmRjNydr0l900L9kr+cqkV2J1pZr+0/LBQihAkZfDgopIxKaScotbugzsYRjavJJxxtRIGdEbauwq/5CM3Nhfch0AMGuTwYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9239

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

Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 9dcc817b9794537385aa9ca726cb1cc1b2af6b4c..810b749bfe9ad9b4d75a7b158ed8013a5a4f2078 100644
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
@@ -996,7 +1005,9 @@ static void max310x_break_ctl(struct uart_port *port, int break_state)
 	 * The chip's auto-RTS asserts the transceiver only while FIFO data is
 	 * shifting out, and a break is not FIFO data. Disable auto-RTS for the
 	 * break duration and drive RTS manually so the break reaches the wire;
-	 * restore auto-RTS when the break ends.
+	 * restore auto-RTS when the break ends. For an active-low RTS,
+	 * IRDA.RTSINVERT already inverts the RTS_ output stage, so break_state
+	 * is driven as it is.
 	 */
 	if (break_state) {
 		if (!(port->rs485.flags & SER_RS485_ENABLED))
@@ -1401,7 +1412,8 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
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

