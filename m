Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021112.outbound.protection.outlook.com [40.107.130.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D44E535D;
	Tue, 29 Sep 2026 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674743; cv=fail; b=dO++vw84GjJiBx/ORevtI3kT0qtSLv8xamrKi5npxn4i7/2WANvR6LFBRSdN8mOny2QdLHOQa+JYO1SITe3XoDD9vlMVnx2e1yIMJzx4trvSf87KjdDBCC9JpVq+A3vDh9y9r+BBm9DAF+Khrk+G3vGEvWdjGnDMmlcbBY7zz+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674743; c=relaxed/simple;
	bh=nkXMXlbWuRoj1J3ZnQK4rmDLCQpGkevJtlNpZJOAE4g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y4Ou3ZVXC+VS/EJ8GCuXcvLIzeEfkcQRH9gJsXBl8b+9t7g6+gXX3vqzbJqz4snow3BySCaEKgtbG5MzpAneUq88UiIO4AAb+DgZi3vosVIlfOue1osgupn1TZNoiFbphgP+nqs2p+9MQ3jHd0DToeEWYTgNxYDgbY2L1qXoGzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=a9ETMu9F; arc=fail smtp.client-ip=40.107.130.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="a9ETMu9F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1ENMdWsE9wIo7N5Iit+7MWgRLSJisjfWo6QDfcqEDnn+Ao4Ytlzn+h2BxGTLkne8IpAzwww08JuQCmSDJCAc0iEyUpd1xGIQQTBgOwLF4HNm4qq382i7uuBxff9Ji+cosctevq3eu245tAP/nDtn1N58yQmkIZkemy07ukHzhwvVipeqr6GpMdllKUZBe/IGyl7ZAdw4fD7fg2KEvg7aFGHfewXejrHG4TAguLMf21mAsrtSMMHWdUtEjt3NyIGI1bebCd41s/E9nF8cu/9gA2t0jX5Sa1mbIkhwRt9LG6ZviehTan/aJZ7CG1smJMY1rcnWHO9OhBFB5y4qkZkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni+hkFRWrtg3EQ9TxMLG1Mrz4YwvAKXxTwMSlisX1So=;
 b=XnGnLluf2bU6xfx9dmuMPHChLvDFQ9K8rV3l+PBpTNt00Ho11ZS7OIqwUOiSk+h+/8dYqTphF6mwgnJT8Jar60Fgu7RHctRT290wR3RFbX2ltvxS0fK6N73VmglBPyjdhEmQkqTAFeotfejzy0z8w2YNscint1V8hY7/EFjNeL3qdQPWB3YbPJf0PEcoj6UTE0sCJTrc530kt/l9oSk6wQI73G6tagWrCXj/cVffb2tO2cYoxYiCLBZZIXzWyjNw0/Axfb+TTQ2/IcRXVlmRxRcc8P769MQJkKR8Gy5nmwmR9SUwOt8ePGIx7xcdUELZpoCAWB3sro2YWVazcnsQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni+hkFRWrtg3EQ9TxMLG1Mrz4YwvAKXxTwMSlisX1So=;
 b=a9ETMu9FJwiKEXhWQWy8HAEvn3VRfDb0PtPvUo+CcFFqytVaMlB1IsT0zKhwD/UPWMa/EE52XKgf6bJL0V+NTnzGlHIkbyyW18u1pkpUUPUikiCspyyko6ooxxEYfKiMkfriGTpPjXjKUTxbnfUqdsgwaF3FqDFsM8c0pdts9FlyKQC3+k2tBhpvVINGYX0mvE9BrgZ3tvq12EDU0i0B5kyB2JKSrohovR0Yq6CggHxlHWa89IEHmHfiviDmTJbg7SJpHY9Yq4+PerZROzJC9guHS1fgCdC4BGDS6qCUi7GkA/JpV8oM6DhIB21wybXUV9NIrXBAkHxmzG1KyQJzsQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PA1PR06MB9752.eurprd06.prod.outlook.com (2603:10a6:102:446::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 09:38:47 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 09:38:47 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 29 Sep 2026 09:37:58 +0000
Subject: [PATCH v5 4/8] serial: max310x: wait for TX to drain before
 powering down in shutdown
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-max310x-rs485-sw-delay-v5-4-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790674682; l=3299;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=nkXMXlbWuRoj1J3ZnQK4rmDLCQpGkevJtlNpZJOAE4g=;
 b=W10r2dQTbVYOBN60U+74zRgj9uWTiBbNxgVOCvSIt60hfILMI4xcbnSgNxh+M63ZpiQEtpDti
 HPlVocB5/5+BJ4WTN9gTd1y2VdPXuT2mUy2GY/6E1aMPOljlhTEobps
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
X-MS-Office365-Filtering-Correlation-Id: dd500637-62af-4276-2dae-08df1e0d5e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|366016|1800799024|38350700014|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AkwO9+MzOqEy8s4dQSAyZZCokvXAn1yUbD3F6DXLnxuxaaE3WgdHZUw2WTDk0w04nj7W0RX1PKcNfEy1+nOr8Q/P7h15wH6f1ng5eOmV5+aLG/gWlhw5Ng/t/oTQtVo8GFIVKIB0kWbMiT6xwKwUwbE71TmASAwcOnJCw/nWt473QYEU9WN7ntizNQA91LycssB1zV1qiK0vuYaC9UD6I+TmUEO3TzgQ9/z+1+x2o8vq/u+A/P9qSp0ipDQPvRHhsyJn+hGNvSdFd3mfRDL8RjMAONwXnQ1DgQgDHkH9G9kNbJtnBLrGUuY06fMd24TuaoNFcG3Kp064Z5gMZIj7+3Bo28JIm4/ggkz7ibJPPJqWAXO9xmZBpeTh8niKfIp7HUkJAsFmBdVG9aXcDakyZSuFhCgOW01gtu+OT3kKgLLSBN3d6MwiX/EHtVjZ17+VNlLmElElgT8eBTVDWwJlojj4N8ppR/Dd6GrGxqzraPoeumrTTlccdxo+oYVmYMhM47BPsR7IJKhaiOhK+DQUU+HrDQ9kLHXlarg9AbIF+yohNFPiXmPGp2AwE285Zh56w4jpSqD6uf745VgJm8Wps7XVRE6A8MQMOCIZshRQXYPfjjtVnhuKQkv+G0IJFdEk9aTDdeNT42j0P9pTwYEenQ/4b7N5X2iwCOLu/4PJ5Cs4JWoh77r4ylovgKuDLYJEA1qr32r0VsAusNGUrlKXXKXM5KyhIddvw+aHuI3/nwg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(38350700014)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW9IL01NeGVzWDN3aE4yRmxUazdQOUxWSDhmU084eTFsVGhDT0lhWDFRREU3?=
 =?utf-8?B?WGNpY0k4Rmlaa1BiL2JSRkw1b0JQMWcxeVZ4VnZQSU5Xd3R2NXBrK1F1Ykkv?=
 =?utf-8?B?bThPdFJsK2hlZnVPbHVMaVpMVkdnRGJiMExTczlOTnFOQW5EOUQvSTREVDR6?=
 =?utf-8?B?SitzMGZHNDR2ZDFpVVhMc0MreEJzUlozYnJVQlZkQ2xZeTR4dG54b1NEWEJp?=
 =?utf-8?B?VmhJSHpHNk50VFM0K1RBZk41TjFRYm51ZFRYUGhySVY0citwekR5WWZZUE9V?=
 =?utf-8?B?MFNTRDFjam8rdGd4VmdFMHpQWTJWSnRvbWxjTmM4TDZaTnAyZmlzbEg2TjBr?=
 =?utf-8?B?djlPd2J3blVpenZRVmgzUTI3NlJxdUhNUHRqbVpHSlpVUkI1MWZ6TkIxbndF?=
 =?utf-8?B?Q2pXYjlaWXVXWFpDc2ljbnIvWlVsQmMwaWJ1UUFXUURiTlgvSTExZnNhR2tw?=
 =?utf-8?B?bnViTC9sbkRYUUxDRVdPLzdiZGkxQytwY1VmM21mQTh3dDZUUzNKMDlqbEVW?=
 =?utf-8?B?cDFkdFpnM2MrVkdWR3B0QUxoQ25hckNBakFiUG1uQXpORU92eFhRdzJZcTcr?=
 =?utf-8?B?MThFZlBTOHFDVzhHUCtoQWtqdnBJZEcwU0d2RFBZQVBNQm9ja2FDeFNTRGtJ?=
 =?utf-8?B?d0MxTVVFcDdPZ2RpWThRbDRDeHJYVmtrQU92bVpzSXN1dHlUcmREenkzb2dI?=
 =?utf-8?B?TFdhbS8xcXdTY1pKb05yWDNGYkZHQVBtSlgyeHUxRkw5aGFWK0RlQmMxYnY3?=
 =?utf-8?B?M2FhUlF1Vk1YbVQ1ZGhFR2ZtQTloOXpienNaeEZUcW03bVpmbW5CUFBtaStR?=
 =?utf-8?B?SUtTdEE4UFVEbmdRV3p2UnpIWFZDc2JpZU1MeTNQdGxFRG9LcmlZRG5GNWRB?=
 =?utf-8?B?QWFsSjJjUzExUTlhTHJibEs2ZTlkaUErNWNna2hkZW5uVjVwSFdGaEF4V09n?=
 =?utf-8?B?dkpWaXhXNFpqYVBoRStlTDh4RStpSURuQW94WHVXcGdMZXBURm95V1RBbVRG?=
 =?utf-8?B?cXdwWjVFV0l0RURHRW5OMHZSWVo3d1lpK3F3YkIvcUV1Rll0WXNHUWMrWW80?=
 =?utf-8?B?QmNCbTZxVVYyYTNJZ1ZLdzNhZnc0YmRBQ29EODdzOGVKbjJzYWhhd2U5VjdK?=
 =?utf-8?B?ZkpEODViRVpqREl1bmc2NzN5aVlzc2U4VzhFeVZLcEdYZmhJcWlxS2kxNVdF?=
 =?utf-8?B?Yjd1c3RZUWljWldlY3pqdXNYRlFROVdyWlhHSk1MQXUxMkdQS1NXeXJDU2xl?=
 =?utf-8?B?VEpTMzZmMFEza2ZqVlhFaVAyVFAreTVCNTVJb0s5RkI2RDRGaFRGdk1Sa1ZP?=
 =?utf-8?B?NnpaVmJDSll1c2wySWRtaGt1NzY2SGdYS2FhK1QvWWwvUHJVNTVUeFI5dEJS?=
 =?utf-8?B?cDA3TTRvZXIwNHBjaUgwZ3cyMmNRY3hvVG5WTWRtMTBBK21zaXU0emtaVlZD?=
 =?utf-8?B?Z2I0a1M1bHpnQUcrRXZNOU80bGJWaC9abEE5blhZOTZmSmUxcjl5dnMxcjcw?=
 =?utf-8?B?bmE3THkrY2F6eVN0TXI1UlhCQWRCdlVVL0ovbjVENy9pUzBrM3JxeStjSUFv?=
 =?utf-8?B?U0lzWGtvTUNEV0dzVUhiQldSS3R6Zlk1M293aXJXaklhckJlWk8yaFdnUldW?=
 =?utf-8?B?czFhcG8wY2RYVmZnUmZNUmNlUFhURTVZaTlPWXlFbTA0NEh3Y0tIRFJSd1Zj?=
 =?utf-8?B?aVJMNnVHNFNkWWYyNGxnOEFmOU13ekxvdmlucHZMMjFXM3laUFd1aDhPdDZr?=
 =?utf-8?B?Um56dE9RbzJvTGQ2RXBIVnhyd29pcFdVWHhRVXVSZ3lNeXZON3N1bzN2ell0?=
 =?utf-8?B?ZWJiQXN3dGljY1c4b0VtcG9BNVprQjc2Zkk4K2pJUFFMVWJLSXRMeklaU2Rj?=
 =?utf-8?B?WVZkL0Z0cTFudEgyeWsxenVDQWlDWVFMREZxZkpYZmc1WEh5VXdveGN1eWtl?=
 =?utf-8?B?NXRuUkN3VGFjUFhLd2paSURpRHZiVkltRnRCeVFLRWJzN29ueXJNREJvVmw1?=
 =?utf-8?B?Y1lVcTdlYlp4RGxhc0RxVkR1bXhTMTEyRGZMYnhna3BEU0VYTHNwZE1lTGVk?=
 =?utf-8?B?QUR3UHhNdktZdWFENHRGM0hOV01hK2x3dWZRZlZUbEkyL0VZUUljcTVaMnBN?=
 =?utf-8?B?bmwwMFIxU3VINjFlakFYSWx5M2ZBckd1cGg3RVFnOW54NDVSK1dxQ21qQlVn?=
 =?utf-8?B?dVFCWUs0ekdDYldQR3o3ZkwrWGo5aHVCSDJFUDRoblRhTk9FdUVzaXNnVmdU?=
 =?utf-8?B?WDlLeFFpejFpVCtXN2Y0M0tQRTlzMFF3azJSQVhQUkNCVEZuQVVRVWhxVnkv?=
 =?utf-8?B?QjhncG5yeW96dEc1dEwzdVk0dDIxcEVoR0wxQUJqQ3hrWFZXeFlNdnM2d2Ir?=
 =?utf-8?Q?HRT/oMKUiZeupCRw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd500637-62af-4276-2dae-08df1e0d5e46
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:38:07.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfR4WQPh3hFtA11QBwuZ5R8Xy20L9VhaDUlMkUQL75mSpaVGgObiiTNT32QtcNw4LYcYxl61YNZPc1s1JNqT97HOQlwyLfw+eAzp73QKUiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9752

max310x_tx_empty() reports the chip TX FIFO level and nothing else, so
both tcdrain() and the tty layer's wait-until-sent on close() return
while the final character is still clocking out of the transmit shift
register. max310x_shutdown() then powers the port down mid-character
and the last byte is truncated on the wire. At 9600 baud the ~1 ms
window is easy to miss; at 1200 baud a write()-then-close() reliably
corrupts the final byte (observed on the wire: 0x24 transmitted as a
0x04 frame with a framing error).

Wait in shutdown() for the FIFO to drain, bounded by one character
duration per FIFO word, plus one more character for the byte in the
shift register, before powering the port down. The per-character
duration is computed in set_termios() from the frame size and baud
rate.

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index f8dad37d017afe5c0b1d36d6239ba05fc5e7aff0..cd3b1913aaadba94805f4728b5eba18e970e34c8 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -302,6 +302,7 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 	struct regmap		*regmap;
+	unsigned int		one_char_duration_us;
 	unsigned int		baud;
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 
@@ -1020,6 +1021,7 @@ static void max310x_set_termios(struct uart_port *port,
 				struct ktermios *termios,
 				const struct ktermios *old)
 {
+	unsigned int frame_bits = tty_get_frame_size(termios->c_cflag);
 	unsigned int lcr = 0, flow = 0;
 	int baud;
 
@@ -1132,10 +1134,13 @@ static void max310x_set_termios(struct uart_port *port,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/*
-	 * Cache the new baud rate and reprogram the RS485 RTS delays, whose
-	 * millisecond-to-bit-time conversion depends on it.
+	 * Cache the new baud rate and the time it takes to clock out one
+	 * character, then reprogram the RS485 RTS delays, whose
+	 * millisecond-to-bit-time conversion depends on the baud rate.
 	 */
 	to_max310x_port(port)->baud = baud;
+	to_max310x_port(port)->one_char_duration_us =
+		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
 	max310x_set_rts_ctl_params(to_max310x_port(port));
 }
 
@@ -1231,6 +1236,20 @@ static int max310x_startup(struct uart_port *port)
 
 static void max310x_shutdown(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
+	unsigned int loops = port->fifosize + 1;
+
+	/*
+	 * The tty layer waits for tx_empty() before close(), but tx_empty()
+	 * only reflects the chip TX FIFO - the last character may still be in
+	 * the transmit shift register. Let the FIFO drain and the final
+	 * character clock out before the port is powered down, otherwise
+	 * close() truncates the last byte on the wire.
+	 */
+	while (!max310x_tx_empty(port) && loops-- > 0)
+		fsleep(one->one_char_duration_us);
+	fsleep(one->one_char_duration_us);
+
 	/* Disable all interrupts */
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 

-- 
2.47.3

