Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022080.outbound.protection.outlook.com [52.101.66.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07135488D95;
	Mon,  5 Oct 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206428; cv=fail; b=Adc1xUNi+yRlPNc3B6nM4uKQ10Ms35sLm6JCZ80MCsnKxBbl1SzsVrzCOhhiL0+3oHiYtDZl0xgu2jHUfhf3iU9GNOSq7DhtuPU+I5G/DH2O073StozxRkJecHB4oq9ZZpNzhQjoKcuVB1C5NbtkevvIQOgAiVz4hRl0jtxSmR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206428; c=relaxed/simple;
	bh=JVqBido9Y7eUmijTMCub909FETHemdv54Yqb/mA5S5M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JwJM3I+d29Z35uLB+BL9/pqj10IlL3BuKIfsxIbkzLCgbzaq0hL4RddQmku6IUrtd0uOIXB3WPhQk7vAHIbyrkTULxOEjuL1tkA3ZjO+2kDvkrGki5GE6GpqC7AMpY51IYF6Nq4T/uzhEg7IlLjh3XEYSaetmc50dVeT1WIvLDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ZEQj6Vb9; arc=fail smtp.client-ip=52.101.66.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ZEQj6Vb9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnkxXagiiBkqw670ve2ZehLKMK/py/yd/051Teo4bxPgE8DD373OqKS8TpdCtyVi7VhmbiUudK3sVQZy/+5WL/JNO0YRMqCSpvlFfeIEVU4B05zMSkZbgEdeWH1z6Zgkh4XkqYLlbffwi3n0tuNd5azNAVHMP36wrxFXUvi3/T6sT4/hZcwdVmIAVVq+754tncgtygQDu1wfvE6d64B3gFJjaWTZdSh50wmfbtuKw/onTPswy80GfkBl+tMKAlAJgsCABO4gcmrPH4DRz9C+bjdbeEI2jOZdU/9BX+kVIAXIbIKxJs7SceHVc/B4tRKnttqFZU/Q9FTD++Zlm5xtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7DiIjsND3CPxAfQjOEpyZn6uj0R/Qrbpzt25Oopw2o=;
 b=Qf5C+brn/WHd2C6zlnD0nvzuM3oT8/i5HcTC3Yct9iEYlj7HWCFNvQWyVPhYOEFbHcEFx2DIbbK0KSh2rrNZeWutO3vBS5QnkoBC4GwpZYID7gLG2pD2246wVeJzhShPBCbLt7U3eZiWco7BcVi5kQ8tmqqrj2yv8YvM2zPpPWhIy7gg32TQiAIddiAGVF0bG0gI3UbxEUby3w7TS93LOumMo/eZV4GDpjPGwDCkwlp1PrnG2F71m3NSR9IMfMDw7rlowkV/AcyI1SdspPxAg3JW0Dm7x8wRQsxeQmkR6oYDKU9EDER1Vx2HMqu2RqnZENrJNsWX6/3ukD+dVOcMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7DiIjsND3CPxAfQjOEpyZn6uj0R/Qrbpzt25Oopw2o=;
 b=ZEQj6Vb9PXG3dAD0p07RiLML5eLFFXFbxeDnDR1C6/lnCXVDgUDcCgpk6MFM9h6cl39zmqvkaVl33MCutcdiiFyvr/Sy/jN5yihJ3HAa25hInlzsjGnZt2WZUbJGeIBpsjWGYZNcd5XHarUTqdSAte0BAlIDQBaCZ2JwNhpzfLZc1/3QDe1xpMXo1fZZxbQJj8qs7agshZAK01PkuYnLTsu0bFyYE8DQ600LTPplqxKu8ZRmNKH4Aj9dUDvVAlRkZIz118h0zNVfjgoICg31oj6AjM68yFOW8gddu/axrKHI798JLO6plANAUvuFG0VAe3svyONLP1CUSlnyo8pong==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10187.eurprd06.prod.outlook.com (2603:10a6:10:622::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:19:56 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 13:19:56 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 05 Oct 2026 13:19:32 +0000
Subject: [PATCH v7 1/9] serial: max310x: don't clobber the TX break bit in
 set_termios
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-max310x-rs485-sw-delay-v7-1-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206394; l=2757;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=JVqBido9Y7eUmijTMCub909FETHemdv54Yqb/mA5S5M=;
 b=BjCKe25oCby94Wiw8MfZ+JtBcgfG1NqiWHDPoIB747mucbCmMUVyRCIZMou6SQcEYntH7reA0
 +fdLEEomZdJAgtABRqEYo+SbVfHoiaR2ooV1T72txu34umBaHQHgwiC
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::16) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DU4PR06MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 06605321-f765-41d6-3da1-08df22e358ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|22082099003|18002099003|38350700014|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	fBSWb3yKGer/r/8J7GOKA6+XsUj0inSAkk9e2KS/xx1kz1/C5JSGKNqjDV7DKhDRZC6TolOD+CuAMqqrNSBN2ufRwFPs3GcyKQ+FRA4qaNEfHuydaYTbvR+DV8bckJ/8gkbl97bM6F8uS9GW6uVSTh8ufhg6W2P2Yk7uW1ej4I74rg9D6hAp8rh0gG16DexN0mH2aWtpwzdZeDVfje2jd1ZAQGzGrFq+EpsQWZVN1q++kwwS5o2dJ3e1WR6Ip00gc7WZd9meYnIWA1ST79cwnLV8RnPzZSwQzFZT9BYZwTD8vYxpYjZt8r2dpA0e/pDFisQZNxhQl2jAZkOjraJ/Nzxb3DadM0PSX/f3eGTrh8I69zPPYDdUuXe7ePhxVFQwu13/GsdtVWWuqEVCgHyUetExCNPtOZmFTvA7QKj0v6SeYnV3+BlllfL9nATkk6eqPzXTR6XQO/N3d7Id+WFLIbLTQHdn9h1hSNO2eeJY/YTwbBW1qjKFV3eplzuaXe2yPdb2stv0qmLA3ZRwbcjC4iSCoc7eUr3ZnZnuc1dYW9R5fiQKPyGSJWwIg9q4MirNRLVYGL/I8/ARJ6Glyzp9FuecOm2m/314JG5LA17Pf8tIKpLRHlvRJYJ2vT92OyaHDrHjslHglpn2q4h5Y2cyGJVIua8AJBAUEEe6Dz6fXLttLL8HMIGhb1qNvII68E7sPg+UcsTB6MpudGvlRFQ0/vjP8WoRoM1+zzFoX2TXCFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(22082099003)(18002099003)(38350700014)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUlja3hRQmhFeXcrUHBEOWxZdGJQQms3MjhGMElPMXc3WXR2OFM1bzJtV3lN?=
 =?utf-8?B?c2VqNnFYVldzSnJ1NnFTa0N0SDhNYmplSXdQSEh6WGV5OXNNT3I4bDZHUy8w?=
 =?utf-8?B?d0YraGJ4K0UvK1ZJelJrZkUxYnNPbFg1ZXNzNmJISUdvMFpTcFYwQXcrTks3?=
 =?utf-8?B?N28zUFJHd3F6dGJIY3lYZjJkWlhuZCtYbVZXMnRJODhySTNqYW1SMkx2Tkhx?=
 =?utf-8?B?eXY0NU95d1FDT1FYVHAwZDdHbEVKZTdReDlNQkllS0dGbUEzNVFhencySlFC?=
 =?utf-8?B?NFlhcWJla0VsaVU3MDJTdW9paXR0VXE1RUJRcmhLZTFYZmxvRXRJTUkxaVNY?=
 =?utf-8?B?SkYwYzlHclM5ckVOMkkwTy9qWXlOQ3E5QjQ0TnBiZ3YzSGI0eWV3R2JCRWtI?=
 =?utf-8?B?UkphN1dxbG5JMWxob2J1WmczT0psRUwxay9SWExiOEpOc2JjU2xQOTdXS2g5?=
 =?utf-8?B?Uk5vU0lORklRd2ZpQXhNTmN1OXRGQWVSMWEyZE1iUnlhNVV4MHB3Z1oyY2sv?=
 =?utf-8?B?MVBzc3BZR2U4VWRPT1JSbHVLYXJDVWtvVWpXaGloY0tjWWMwR2pEWXZSNGxx?=
 =?utf-8?B?THZCdWhhTGROSnpwbEU5VzFJWkdwcElKSDlyMktPZjU3ZmhsOWJPWlo2Rm1s?=
 =?utf-8?B?N0h1bFpzeDljY1VkQnZhRzU1dGdiNC9uYmJSMkRVNFplWHBPeFNsWGlRQ0xS?=
 =?utf-8?B?WG51UWhwWjlVQTFuOWxRS2ZDSnF2UUZxcWl2b3BtREF4bm13RFU5U3lMb3Qy?=
 =?utf-8?B?dHBNVG4wNlh6TVlNSWovTXJIL29IcHdmd1ZwL1k0c3kvNzBZRUlOek9qOGQ1?=
 =?utf-8?B?SGRVUkpmR1R4R0lKZ3ZsNWQweDNoVUZNeFB2dzBFZTVGS1Z1ZW9sMEN1VU9k?=
 =?utf-8?B?MjMzM2JlMU91WmEvSGFWRm1rL0p2YlE5WXp3anB1QVBnU2tLZE5xclQxTUJj?=
 =?utf-8?B?VnB0dFFNczFlWEViM2tQalNUck5LMTMrbnBHRXNyWm1oSTdoOE1jTFBXQTJp?=
 =?utf-8?B?RnlHaTMwSmVZdHpDNFZmdFRxeTJ1dGJMMEI5cjFEbjh3akJUSGQ5bGNHSDRt?=
 =?utf-8?B?ZkQraEJiYzBBZGR3RlF5Y2RyZXNETHZmb211UlpBZkZrbDMxdlpTeVR2b0Fi?=
 =?utf-8?B?MUh6ZTFjL0ZBWkppMkVPK05XS1ppRVRSVUUzVDFQcFFUOExKVUFsY0hQTi9k?=
 =?utf-8?B?Y2FlR2ZyVzN6bnlzemNTdlcvYTBUcml4MEl6dm1OSEs3dHhtNE16akRpVzlw?=
 =?utf-8?B?VE42NmdFc0ErdnB2NUVyYTdvandGekpINktTSTc3YUlMMHZENWhDVHhxZnYr?=
 =?utf-8?B?Z2VVcDduTTFERUQzVEIvaDdpWkV2TndMRXMyM0t6Yi9naHU4TjVPQi9yaVRy?=
 =?utf-8?B?ajNEL25QbzhPRzlQb1BBcThKUm5IME5uelJQYk5qRGl2L1NSR3FHSHR1Y29K?=
 =?utf-8?B?Sk9SZkwzV2xSRFZpS1JVY3pmZnBaS21vbnV6YzBTYVg5QWpZbVIvMVM0cjZk?=
 =?utf-8?B?RkxBa09nNjBYdUZIZXJreG5rdWJET0JuMHR0TnBqKzU3dnEreG01b3JseHRV?=
 =?utf-8?B?c1pSQWVZTEJMbVpqUm95Nm93ZndhYmVEckVRdmM1alVVZUJOYjRJR2Frc0Vx?=
 =?utf-8?B?NW1tVnhLVzBEeklSenl2cGxmTnFzSVI4V2NhdU15M1NBRjI5bWQ0Vkg5MWtV?=
 =?utf-8?B?VFRrRlNVTWk2d0g3Y0p2ZVBNVkttWFVGeG02TytOZWI3aldKSFE0Z1VBRFd5?=
 =?utf-8?B?R0ZqNU5xRzJaQVhnQ2JvREV4ZmpjRTV3a2VHUkprYmlqdytwQjZyZHRRWjRa?=
 =?utf-8?B?dzNheXMyaVIyVm5rSXV0MlZ4S0kxcDFWQlFLQlg2SGNWL3kzbHhzRnN2cktX?=
 =?utf-8?B?UDJJUE9Kb2F3NWdGRldGT3NGSWhEdlZYVk1GUy90UkpXZ2lNeDVoT3gxYTIy?=
 =?utf-8?B?eUxLQ1htNDU0UFl4bzByV3M0bDQ3bGk3VFZsY0lhUEw1c0YvYUU5TjVsUFBj?=
 =?utf-8?B?N2VVZ1hDVGJSdWJWUThWR1dPTXBuQWVHSWdYczdubU8rVTc4Y3dmWCtrZEdw?=
 =?utf-8?B?cjN3NDNhbDNCN3d5TXFRQldzMTZHVEg4K0Q5dDFYSFppZDJFWkR3T2paS2xn?=
 =?utf-8?B?cFlxTjY0WkhDNC9nTmhqT1hJL2hhYVl0ZENTZjUvODFJQnRLV2NuNGc1R3d3?=
 =?utf-8?B?MDVOM2VIU0VQbVk1Vk5Tc0l0RGNTNGllRHZmVmlxT0ZEdlpVWVJTdUZFSnNG?=
 =?utf-8?B?NWYvTDI1Q3dMeStsNGh0anh4Q3lDdW8wcEtsa3NLc1JlczdDcDdlcVBUZG12?=
 =?utf-8?B?eERaNXE5RmJhMnJqUDBSZ0tDT1JJYXptL0xtd3FXV0Qxem42bzhVY3pxZDZl?=
 =?utf-8?Q?7DfG6b39IIPTSEvQ=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06605321-f765-41d6-3da1-08df22e358ea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:19:55.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AI3fiNypzAqlex5omH/ciHqfttGxeWE4pkc4SizyVqzUUv4xhjH42n/eO/ZGiH8x8zit4/D7aotNMajSAMgMsmHNhk6sJkc4JYPHnbA1Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10187

max310x_set_termios() overwrites the whole LCR register, but LCR
also carries the TX break bit that max310x_break_ctl() drives. A break
is a state, not an event: TIOCSBRK sets the bit and it must stay set
until TIOCCBRK. Any termios change in between - no concurrency
required - rewrites LCR from the termios bits alone and silently ends
the break early.

Update only the LCR bits that are derived from termios and leave the
TX break and RTS pin control bits untouched. Since nothing clears a
break when a port is closed with the break still asserted - the tty
core sends no break-off on release, and the unconditional write here
was the accidental recovery - clear TXBREAK in startup(), the same way
8250 does.

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 022502986c5fcf1ff4de9328746ddc71677be730..fead9c51163d8372d1b609ee9cd5b87faa917fc1 100644
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
+	 * break_ctl(), and a whole-register write here would end a break in
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

