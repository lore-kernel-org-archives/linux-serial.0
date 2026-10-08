Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022084.outbound.protection.outlook.com [52.101.66.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172F48A2BF;
	Thu,  8 Oct 2026 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452962; cv=fail; b=WMOSJ1mngfdnHTX0xaGSE4ArATalMoNQs0dWsInrE2eHg5BBQiEQRPyBTW2PeIBZXyxtnYSQSPLDuLViJNzOKauvvn1BNjfo+OT3Q5J7F2fy5jXI766raiovt3z8G0JUaNZ1EsPbA5A44A0xc4+1eoqtY9obLUniP//EQzToXGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452962; c=relaxed/simple;
	bh=ws/Wiv0Goo0U3u8+4SLD72tMKtjYct7l7Vhnt1v0cw8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LhC15KmVrdEnz7R5fgz/nU9s3LMrR8qJAgjjHWG6euWBn8Lia6HiQsrqtj7Q4ipLDlfujCh0qXn8E0mGt4tsQQowYoDZKzPW8Z/yWplnKxyU1gpJZUniEyRTUANsvEkiRBXdPNCJTR2mLdrkEYRHi5XWe0txLm9DpoE238GTYY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=jI4YOP2k; arc=fail smtp.client-ip=52.101.66.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="jI4YOP2k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xf7r8sL0D28wcX2On+fxulsWPJTHl6b+C81/YX+CEFVxQhf1gjQm2l2QmWt/FM6BJSoosoOqWBugbe34WH04aY/oErUhXJ9QPTlRqsOcqoXYjqjPMME3w3rDaraNGJ1ESJwq98CitSLqPx0mfefxfr5x+xmvdUPbrOlxpXZ4XQuZBShymJ5NZLVAVgRBiqkze11EE+O2jek0hXS2EOGnOKpiP+jSiPrNdANaIqjT283GRH5NLkyMufbbL17IliTt+q6ObrxAPZKglpoLyXXk+pcm+EfDFTmOwuD+/rHzCHiNhyoPWa2diiEhvlh/oxXQgMEdO7awkODVRSBU4c+z6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDiVwI1/MnCrjVLx+HA5+Dx2IXUBMy/J9bz03Poh56Y=;
 b=wU3FsTrPfVeO5TmleYjVIty1wSezpkN792O/sv9Jf+TlAyxmwjFLhbU6byrdn2cSn7JhFcJsPtR18viDhxlxnwnQYKJ19U8QvmSrLEBMMg5ZpHFme7LygXtOGdqF8crjBAMagaNeo9wQIjg0120D8nNW9ewbXt32kjGMLM2H8rYIlAMEqJ4zBRWiGTZoZzzRvuQs4rDzemfhiVRenGMr6Tegd15bwSJtNvApmEZ68lVNcxGcYKWIfJU3ZKANmdhoCXHm7sdKbOuSKYFrIXCCIvNUtLpLyvIw4D9KPabH+VJEEpPO5Qo0m00GqbrZkFjb4WCUEavJ6R5rg8Auo8fswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDiVwI1/MnCrjVLx+HA5+Dx2IXUBMy/J9bz03Poh56Y=;
 b=jI4YOP2kmxoU7pFuc+3Vj9daNhxiVYaUCDwjgr7hH+uTCmQdapPct6LRag8TBtNdRbXduR2iKbTw0WFjN5t6CvneDzVXy8Kp3OiAdOUM4quZqf5Mc5J7h2UMMPtY4YcVctjpJRwwTOPeZP0BxUzVHb0mVDvFkcXy+yg2rYl/XxhtgteAVlwivcRQZ0C7L0GCexEGSNBYu9OQ1oG0ydpzGPYf69lL/gnOZmeUf7x//ykAJ5uYcVOnmdLs5/Zyv5ZKKsSj4+cHcIUOdYFxWLH/akxrhygBocV1pZr9oZxqJWJuB1AXfoJ2+wmSNGv55fjwDESCMrYeN9DXjUsNndKQJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PAXPR06MB7567.eurprd06.prod.outlook.com (2603:10a6:102:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:49:09 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:49:09 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 08 Oct 2026 09:48:27 +0000
Subject: [PATCH v8 4/9] serial: max310x: fix RS485 delays being programmed
 as bit-times
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-max310x-rs485-sw-delay-v8-4-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Maarten Brock <Maarten.Brock@sttls.nl>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791452935; l=4609;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ws/Wiv0Goo0U3u8+4SLD72tMKtjYct7l7Vhnt1v0cw8=;
 b=HEj0laVPhWHAJRaraJvKUcoZ2HAigobp/bpuMJPxw+VO4vvPBouZ9J7tFGWHImxBf9fRd9RJN
 GiQ51lO+XPdAkQE+X0yNZYYPrSSt+3UhSV9g0D7fvaXZj/2t2RT6Xen
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: OS6P279CA0138.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3a::15) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|PAXPR06MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 637ef113-0a5a-4499-7553-08df25216032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|10067099003|11063799006|260925021311599003|260925022911599003|260925021911599003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	ljHOryHXNrRiIFQU9H8EWne60oZMOOec7ON3gskN5pDNvTFNkcYL91uodK2sbOYZ4CZCFRR8vxKt1YN8rwvq6s30gleFOFimvTQ9pNJYb2no22oj8uw15xYGmpg7VUUIJSa+26r7gYo8YsQHUpbPJ3XX1IOcusikNjGlRQ3PokQjHf95iRCDHwoit+w/exP9+4eEEKrPrnhiUxpuokJn0KoIPRzzWH/iWlcYeZVI7XTsSvQdxjrw6Ie+ZwizCiyKIkR99JrixUqPpypqsi/3cjHlC0OVTRD0CJWiJ4GtJ+RrACmQwNqxicWuNsZKySwgiCQDohftVc3z6EFveNjD3QxIefynTrwm9lI6JBww2zY5bCDqnC/Tj8CHD97iYAXCQGLEWKhBtdfzyWmaK2Z3mkq06/1eaXal1GCK+te5onQGaWxOUFNPVqiRJyaKII1x5e0fWBLT0+xZ/meUkhyPYz32H0wzl0PXegShOY4BYZ7B/yX3NiP26DMT4DFT3xH4CSBhKx9kR39PUP2Bj+gNX0V8Ez5c2Nkv9T5qD7KXZuHDWNAl4qVZTcpG0WI+6Se8qhVSgw15lA25qgoS9dOGnlZLKMyvUAgkdGPNDnee2Otzhods4ErOCsbCun4LQzGDDoGhPxT636eR/82VT33eOQUe7ahj/GoiCoq54ZRvqLZ2oTbmVh7n+uK8UqmVI4aVT0ZM4SrXLdY/eU3HEF4o+xWZp947UnKfN69LLEgYXss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0t2UTdZVUdFbWdqU2VvOGNmVERYQWNITm1pTEtldmJrT2U0cUZwOUF6ZmFW?=
 =?utf-8?B?VXgyTVUrTjE1Ky9TRUNudGwzTlFGV3h1VXhsdExwZzFXaVQvWDFEMHJtNUNz?=
 =?utf-8?B?UkErRlF5UkpyUkIxNmJrWDE0V0tCVlRwYUpVRDJYRnNBR2FBTHpjMXQveXhN?=
 =?utf-8?B?a1kxcnJGY1VVZExpVlZrSnl5azNodVRDVWR4OU1Ra3lFYS9YNG5TOEZaNEYx?=
 =?utf-8?B?YUdNY0FTOGlHZ2dwZE50ajkzOHNlc2tlbThFVEplS3dsUHRPOENqbGRza3RM?=
 =?utf-8?B?dm85TGl1QmREZE10VFlCT3NjYnBLTzFublMvUHJINnl1TUxsR2pSeVA1MnBO?=
 =?utf-8?B?NitucVQ0a2V5NEFsMWxSNW5UM1FkQU45RDJBYWxLd20vMmhPSjRaNzc4UnpM?=
 =?utf-8?B?WkdxbDU5NzhFZGNiVmlnYTFzWVBLNUdwNE1IaUFMRTVOeVk2bHBSWHYxT0pL?=
 =?utf-8?B?a05KdTk0MWZ0cEczR3A2dmVkMVFXZXpabE5oLy9EdElzdjdRSEJRQmlPQmsr?=
 =?utf-8?B?L2FPeFhEcGtqeUt6Uy8vRE03OFRLYVJJR3c5NndmZExlVmF6aUg5MHpiRTgx?=
 =?utf-8?B?NGgrM2lHejdVeVJuNXpVaFJyVHRFTWErazl2NWdlM3R3R3M4Y2wxQ21IVHRp?=
 =?utf-8?B?TVZGc0xZenBndCtvWjhSVTRwRlE0cGZ1Vjh3WGdBYkFJNGNNQ05IMFdOVnVN?=
 =?utf-8?B?b2J6TTFXNWp6dEErcndEb1dJRXE4N3hSUitaUEFBZ0tTUTZDeG9ETTd0U1Zw?=
 =?utf-8?B?cVIvV29oL3FQbFJNRm51eGpJTXlwQ2xZdlcxSmRRb2ZGZzFqNStRT1FMUGFF?=
 =?utf-8?B?ckhnM1JmVFN5bEtRZ2Q1ckFHcW51V3hsVVdzZGFseUdpOVE3N0trSThHYVNy?=
 =?utf-8?B?WVBPV21HdU4zNjVxMVRacnVDMkNYbmlWMy9ua3Zxa1F2ZFZFU2hLZkZ2OWFR?=
 =?utf-8?B?SERYWENPblVSWjZ5dVI3a1dlMWtKRnYzazA5bUxROS9DTjlXb0NUQ0RxNkww?=
 =?utf-8?B?dVpERXc2Z0xucTRWY1RGb1YxL002L3JnOFB3NWkrbUQxSzVjOW1udEVXSzZU?=
 =?utf-8?B?OWIvendUK3VsbGMwR0labmFwWThjRjArbWQ1TmgyZjZpWVFPL0dCbXNKNEI2?=
 =?utf-8?B?TXFISDZuOFpWakR2ays5U0doMnRveG5QUUtVdkJmY3lubGpZWm1GWnpvWlBo?=
 =?utf-8?B?TmlaMW5nSHFGR3E1MEgxUnAvZStaMUtnZnRBV2hzUURzOS9hNTd3Z2kzRjJW?=
 =?utf-8?B?T29ESU5RSUU3bGNCZVlIbFAxS1I3ME5ZdEpmQi8waVpkUkg5T0VuTXNDWVhD?=
 =?utf-8?B?bWhnY1RRZTBHQzI2aExpV21yZk84Z0JMejliQXEvM1IvbENKanhtZU1Cd2xC?=
 =?utf-8?B?RHg5NHR6R2Q0QkNlTWVBUCsraHljbWV3TmJ3anFIamllblFua2d5OVhJZFVK?=
 =?utf-8?B?NkYwei8va2hBaEpuaFJ2RzI5VjEvRXVPdTBRazhqeWh3bWZucTdKSFdCTktZ?=
 =?utf-8?B?Z3ZuU0orMEpyY1M2TDRMYjBmbHZoQzd6blRhMy9TQWgyaFZuWEFPUTlySEtv?=
 =?utf-8?B?NnMzZlhycVpCWm9lek5KNTZwU1hBWUNoZzZqTnRhNnRjQ1prNjhQa2RTVVJK?=
 =?utf-8?B?S1hEQ0lUVkZibnBlK1RNVzEzTWJvcmtSNDdTUkdKSVRURlJKbk91NkdvYUIz?=
 =?utf-8?B?c3hZMTZtb25BSG9wMWQ0Sk15QnRpdG1zejNsL3l4bTJRNDRjRU0yQnVqMGZZ?=
 =?utf-8?B?cFZiR2tFUFQzQnp1dE11K212OTZyQ0FZNkx2RTk4Vmw5UWhZcmN3U0xxV3Zo?=
 =?utf-8?B?YmI5MnhGWGpDVWVOaWMzdTBuY3BUYmlCZzZ1SGpnSmJBVkkzWjdmVlJWRmV2?=
 =?utf-8?B?OURvQm1JN3B6c2lUNEFYY21kaXFkQjI3RkQzTEVmT1JoZ0VMQTlXN2JyU2ZR?=
 =?utf-8?B?NnV1YmRWVUNFT2grL0cvdXk2ZUhKUFRQVng0cTZJd3JJNi8vaCtCd0Q2dmZV?=
 =?utf-8?B?LzBEeG90djIxZFFteTVoMGNSMERhWFF5bHZXNzFzS3RidTU3bGJuQkZ1Nkwv?=
 =?utf-8?B?SzlTMVZkRE9EUlhLdW9TZlVLayt1LzFheWtkTVNaRXJCL2M0ZFN4MEpTUW5U?=
 =?utf-8?B?MlRPQlA2NmQ4dzluekUzckJjMnhvMGYxOFJvK3ZxYisrNEo2NlZNT0RiYzRy?=
 =?utf-8?B?ZEhoT3VSblFxK2kzS1FyakNGM2JaekYxS2taVkxIc05FQWpGb3dyeGpaZmVY?=
 =?utf-8?B?SFRNVmg3QldPN0Rld0FzQ1BWSE13a2tna2p0Y05XenR3NFpYVFdaazdnQkhC?=
 =?utf-8?B?Ymt6UHdhRzBrcVN0Wk9UckVTMHZ3anFZWWsxSUpacklBSTRKa2lYYkh5d2N3?=
 =?utf-8?Q?IFaM+sD1LmN7anfk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637ef113-0a5a-4499-7553-08df25216032
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:48:58.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nE/Px3y47LHzHEJ450x5SLmdbjBYQVCePC5QjnNz2ISiyjmlupHt+nunDPpZ8qlehs/LjwxgT3IH+FPrZNIktLo+EN0ime9AxLeKUMZK3Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7567

The HDPIXDELAY register counts the RTS setup and hold delays in
bit-times, four bits per direction, but the driver has been writing the
struct serial_rs485 delay_rts_before_send/delay_rts_after_send values
into it unconverted - and the uapi expresses those in milliseconds. A
requested 9 ms setup delay is programmed as 9 bit-times, which at 9600
baud is 0.94 ms, roughly a tenth of what userspace asked for; the error
grows with the baud rate.

Cache the baud rate in set_termios() and convert the delays to
bit-times at the current rate, rounding up so the delay on the wire is
never shorter than requested, and capping at the 15 bit-times the
4-bit field can hold. The conversion lives in
max310x_set_rts_ctl_params(); set_termios() now calls it as well,
since the conversion depends on the baud rate.

The delays a 4-bit bit-time field can represent still fall well short
of the milliseconds the uapi can express; requests beyond 15 bit-times
are capped, and the -ERANGE rejection of values above 15 ms remains in
place for now.

Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 85353401e09b1481996142432b1279f44fefff1d..2456a2af891f5296cfec833d6406916073d2865f 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -165,6 +165,10 @@
 #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
 #define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
 
+/* HDPIXDELAY accessor macros */
+#define MAX310X_HDPIXDELAY_SETUP(val)	(((val) & 0x0f) << 4)
+#define MAX310X_HDPIXDELAY_HOLD(val)	((val) & 0x0f)
+
 /* Flow control trigger level register masks */
 #define MAX310X_FLOWLVL_HALT_MASK	GENMASK(3, 0) /* Flow control halt level */
 #define MAX310X_FLOWLVL_RES_MASK	GENMASK(7, 4) /* Flow control resume level */
@@ -298,6 +302,7 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 	struct regmap		*regmap;
+	unsigned int		baud;
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
@@ -935,23 +940,33 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 }
 
 /*
- * Program the chip's RS485 RTS timing (HDPIXDELAY) and the auto
- * transceiver control (MODE1) from the current configuration. The
- * rs485-config worker, startup() and break_ctl()'s break-off restore
- * each carried their own copy of this sequence.
+ * Program the chip's RS485 RTS timing. The HDPIXDELAY setup and hold fields
+ * count bit-times, four bits per direction, while the uapi expresses the
+ * delays in milliseconds: convert at the current baud rate, rounding up, and
+ * cap at the field maximum.
  */
 static void max310x_set_rts_ctl_params(struct max310x_one *one)
 {
+	const unsigned int max_bit_dly = 15;
 	struct uart_port *port = &one->port;
-	unsigned int delay;
+	unsigned int setup = 0, hold = 0;
 	u8 mode1 = 0;
 
-	delay = (clamp(port->rs485.delay_rts_before_send, 0U, 15U) << 4) |
-		clamp(port->rs485.delay_rts_after_send, 0U, 15U);
-	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, delay);
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		/* Convert milliseconds to bit-times, rounding up. */
+		setup = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_before_send,
+				     MSEC_PER_SEC);
+		hold  = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_after_send,
+				     MSEC_PER_SEC);
+		setup = min(setup, max_bit_dly);
+		hold  = min(hold,  max_bit_dly);
 
-	if (port->rs485.flags & SER_RS485_ENABLED)
 		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+	}
+
+	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
+			   MAX310X_HDPIXDELAY_SETUP(setup) |
+			   MAX310X_HDPIXDELAY_HOLD(hold));
 
 	/*
 	 * A break owns the transceiver: break_ctl() disabled auto-RTS and
@@ -1107,6 +1122,13 @@ static void max310x_set_termios(struct uart_port *port,
 
 	/* Update timeout according to new baud rate */
 	uart_update_timeout(port, termios->c_cflag, baud);
+
+	/*
+	 * Cache the new baud rate and reprogram the RS485 RTS delays, whose
+	 * millisecond-to-bit-time conversion depends on it.
+	 */
+	to_max310x_port(port)->baud = baud;
+	max310x_set_rts_ctl_params(to_max310x_port(port));
 }
 
 static void max310x_rs_proc(struct work_struct *ws)

-- 
2.47.3

