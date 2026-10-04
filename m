Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023073.outbound.protection.outlook.com [52.101.83.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CECA44065D;
	Sun,  4 Oct 2026 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116217; cv=fail; b=oLSEOEM8mtMNF3jp1/R9NISthaGZSxjtwSQDDZ6e8SqtIs+8uxwhTT9poUyvRmK9KAOLMcoI+IuANiQYemlxYRl7G1K+bYj21AofUwYJ2/0bF5CXl3XaY3tFN0Wj5iIZzErU446AWfgfR6s73WohxcyZrAYkqlCuCp3Qtb8yqcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116217; c=relaxed/simple;
	bh=ws/Wiv0Goo0U3u8+4SLD72tMKtjYct7l7Vhnt1v0cw8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gTIghHkBsA8NS46J3z6jSk/gXc4qrndS90+jUuXk7/3hvinZpLqu32SQ8JAAUh01tNrTb2qU8EGKe7u+HZpQF3m5paCA9FuqmuWIwExI8f7+7tbidc/Rxuq0E7CMNKI9PFKt03ukB9RtAsWko24gR3GwoprC62tDR4taARI6PNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=B+fzTlYj; arc=fail smtp.client-ip=52.101.83.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="B+fzTlYj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9g5j/Re8+U+23gHTnoXg0S7e00hKWhvWXVnO74rRLaKOuIdEASaV6YpHaHp7Qdgt7wO8Q3In/5EPas6YLLFwWvAOIgdMarmUqNVBm7WuJst6+9Nwk1u8CQJX+3J0pyPkXgF6tfMl6qx1yfyaFjWZKVG8rBJLwyQXDzRINAidjHv2J149VF7sDlk7owsAj2zCElj28AI8dzkdYUp7juo4bkNALhXnrFqFJLUmKNf7w3t0pqePkgstUjWUQwKS80zWTxNpOweC/Xs2hvHq7oUykrSUyZcFB3wffEup7A2Fia5n03R4gxSzURzIjM0zv3GIyD3CRSdP5xqNXVl9qXxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDiVwI1/MnCrjVLx+HA5+Dx2IXUBMy/J9bz03Poh56Y=;
 b=wA9MMjPi933fdI+INuzrDcKHzoOzIwl1PEiVpf8c3yQvL1bgn+KcDaFWVN58jQpMbiu4pTkdZyAHCejB3dwkioPxskmICOYbz3sOCLU2Uj33IBIC18SLEb8Yx9gLNV/wHD64OrnS7cKWXi/zMbZbXE9PvK1JIurcUeOwOUbrfUg3hhm8N1xrefMZI4CCU36I9hspxWM1nHks6+pkX+Jn9lUAQr1PhGIkHDMY591xagHcng7hkm915s16IGFU56NGWCGZh0EkeW/fCbdlurT5i2kAbFmwoHh98mSGnpZHDF0FjiaEYHgnN+hUQ+6FgBbRLr7qj0sUVl/f9sWWNV0K2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDiVwI1/MnCrjVLx+HA5+Dx2IXUBMy/J9bz03Poh56Y=;
 b=B+fzTlYjE5R6kd/TaOoIpP47xmmS0Drvm1AnAiEoNYF+m76HZX+J2qQPUj5BCygYlAzOamUHAguOYgXtwrrmImZvo/PJTlVoeism3aPRUU/KkBcG0/13HAHOnV4kcM1mih8xCZQCpZFgdKZ/2whaO9hv+PuUeJD6hj9hV4IV2vnbpeFr1CHlhx+dUXJzbvI+5abahNt8zkk6h1emlKrZBrT4KXNHSR1ehquX30vkZOTycwBr1KJLUvDQsB1KrcEll3KQT38uz4vNPVavbkzdRWXKYrI2fNQat53NJt/MYtkAB+g7bzA1xq+IypBBbDI2DdFFZmhKxoL9fYKtinV+Kw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI2PR06MB9239.eurprd06.prod.outlook.com (2603:10a6:800:221::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:16:36 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:16:36 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Sun, 04 Oct 2026 12:16:24 +0000
Subject: [PATCH v6 4/9] serial: max310x: convert RS485 delays from
 milliseconds to bit-times
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-max310x-rs485-sw-delay-v6-4-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791116192; l=4609;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ws/Wiv0Goo0U3u8+4SLD72tMKtjYct7l7Vhnt1v0cw8=;
 b=pnpCT/J67Wy/ntjicjSXohomIUzq4IXdYlJUqSee7CniSK7D3FVLT8RlgpS/EFOT+xzCoRMpC
 DYeuc+og1v4APMsow9pX92onFkOagyfgHc6m+Wr14poq+xQ5MAaCisZ
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
X-MS-Office365-Filtering-Correlation-Id: b4aaac08-9b46-43f6-f5f7-08df2211561c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|52116014|6133799003|18002099003|22082099003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info:
	RUsDni4k5RgipkxrFO685QsURvNI5EX4JnpSKIjFZEENc/UplDxpUibuiCBNee7vqSd9yK77eT5QrgENNYNuujYbx55xGk2LqYYVEpmzE8qBW7PbYSx2O/qYpa3os0/Toxu6OJbO/mCUBiDXTfbal9efn15EHbHWyz3uyIz6SVrzBgphCjpgUAkanYolaBWoOaICtpdMFqi/9/icKM2GnqVw1zfcj1JUrWX4jTdXvm1TbSWNvmm9cdA9/KtLFeiOourSIpVFB6wcsP5JE/WxKgvHimjoAgnR3lMDHlqQy/QB3yt3AYAugV84euwUXqlDZEQ1TL/wB0aO3AHnxmq9YFscXddTJwPHfb7OhKp0zsvxKMkgvZGpssGdxQEtKqvJF5oA69VXGkuFgCOUbaToM2BaCdg62THD059x++7fmpPCzrX7BBJdeh6rWqivwOQbSTCU5UIdBkRiMioJhpFxMuDkbxly1jsRkvARu7cAvD6X8Y93qrTChUcQgD0GFxB8n1jHkEUHfbsvGQsy0Z/pHpk4HUqCchqWcLcxGGanjqBPAH/JW0+kFO9Ic7gAvvKuYss98BwyOELjV6+eGrPFAgEfSm4p7tpv33apo2kvOawVpqHsgUxRvxngraXmmOmubu3p0qzEHXnvoWcgtOVBQG5ZqFoINoRNfS2SvuEczRkgT0OPyNi85rxFo93Bn1X3u/dC6n3uh9UHcWh01+Vb+tFf3Ib5JbsAT0Nn84KPHs8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(52116014)(6133799003)(18002099003)(22082099003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(38350700014)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2tpVlErbTg0ZUE3L0xEZTVYOG13YTZoam80ZytrUDJQajFrZmZhclMxdmhI?=
 =?utf-8?B?OVBxSjI5dlV5SmJubVpOT3owNGJ2M3RaTnBOQ1FQcnhTOTFtK2dNR3k5Q3k4?=
 =?utf-8?B?cVljQytrWG5xbUgvMjdTeXRnc2hGa3gyZ0g2MHZNRnMxQzNQL1dzdWhZbmsz?=
 =?utf-8?B?SXkydWhIdXBFTzQ3UThLZHkyeFhvaEZRWENMRkM3UW5nNjdYdzhuM3YxN2U4?=
 =?utf-8?B?SDZ1cjZWME1wVEpIYVcralo3c1M1VW1UM3duU0sra0pMOThuVmRwanJRNUh4?=
 =?utf-8?B?SkVnTWpyMDdXTWJad2pzWVJWd05sUmt6NzJiY3g4bXNIekVJUU0yLy9rbHRo?=
 =?utf-8?B?b2I3d2J4ZHdFa1NzNzRLUXdxcFlZZXhqcjhqOHg1OEV5VGxPUXNxd0ZoY3pO?=
 =?utf-8?B?N0d1QTQ2RkFUUHFSNlpScWFXYzRhQncvVloydTVxODVqemtDQXRSTTI0RGFG?=
 =?utf-8?B?ejczMDl0WWRNUSt4eEE2dDRnbmlqZnNmZE9xYVZ2TmtWYjBVM3dVY1JkMFc3?=
 =?utf-8?B?RlNXUE83QnJ0cGh6cDVHMUpEdDkxUEFZTzNOWWxVdWx3bUs1L2FhYlIvcVhI?=
 =?utf-8?B?b21hL1AvSjdDekc0UzRsUFJ1Um9ZMUE1UFNOQkV4Q0gyVzhTOFNtM0d5eTlW?=
 =?utf-8?B?Rk40N2dNSEpEZXBqalRsc051SFNkaVNoQXNOSDV3WThoa1cwc0QwYjlXaW9D?=
 =?utf-8?B?YTZYczJYek1UZ3YyVjdXVnJlTFJFWFJBVmQwKy9RVzMxbml3dTBkZkJtMWFk?=
 =?utf-8?B?bElPaXJ0aEVZYzE5a3R4aDRVQUdkek5lK2JLK010emRjUHBaYVJDdXRrWm1K?=
 =?utf-8?B?Ym9jdWFNSVVJZzc0NTVwc2wvak50c2ljVUVEVDBKM3ZPaXpIdmR1L01oa0Vo?=
 =?utf-8?B?em9NajhZOStQRmNLRzZSdE8vL0lkMWNwTlh1QnJUM1k5ZWFLdGVEZkU3bk5S?=
 =?utf-8?B?QllNWWtwalVlajBoTXhqeExMTjdVZWQ2bFBFb3BVakRJaHAwY29VYWlOOHd5?=
 =?utf-8?B?TkIzSWZ3SEdlS0twVzB3MEJxMlAwU2JNbEs1eitDci9QQVpjZzRtK09KSG9E?=
 =?utf-8?B?cW85VExic29sZGNja1RTQ0RYZnV4UkZ2QW04djRsTm5mT04zUi9pdUlWbWVw?=
 =?utf-8?B?cXRUY3RwbmJ3UStQUG1BUjBLeGxiUmJLdnYxVTkrVGlJNTBhalQvY2JhcW1T?=
 =?utf-8?B?ZDBuUjR5TDhhbllRK2ZneDBRdWZCYXhVa2NUd0JranFVbTBZeTAyNnByMGM1?=
 =?utf-8?B?ZEFLMGE1M3FYUmJwNm5qZlFLdmZ5b0pjNkFuUXYwZ3JMdi9zLzJZd2lFVWRF?=
 =?utf-8?B?QWRoUkdqNjRuWEtKd2h2R2dZcERJWi9qV2VnY2VsMUIxKzJTUFdpSE14blQr?=
 =?utf-8?B?VlU3anVjZDFERXRZZEVleG9vbXN4SVNKdE9nTUhmOTE5MFVzWEh3bndpSHNO?=
 =?utf-8?B?QUhpSUQ2TmF5VzJFemVvcnE1TTNYeStiblBxUmkwcVlEUTJtdHliN0tSTzJy?=
 =?utf-8?B?M3h5dk5wdyt6WnhWMnpHUk9ocFh3dGNoamZsSlI2eHJ2NXhGNkZxcFRNWUtr?=
 =?utf-8?B?WFR2YzRORkh5VUhoMFRwN2Q5Y2VOVU5oMGZZdjYrWCsrWUQ1WUZacGhid2JD?=
 =?utf-8?B?a2w2elU0cUVFL09YQ2c4b1dJQkQ0RVZabzY3bEE1dFM1bFpVK0xtb2grdXV1?=
 =?utf-8?B?TlFpbVZlSmZJcUNRZWhsOFpuWjdKdHVhdko0TzBNSDJsSE9jS0NwMlZSTFB1?=
 =?utf-8?B?V1hKVnRpMi9NbjE2RTVQaVQ4blVsYTJhZXMwZHZEeHVyZHhzZS9RVTVaRzY5?=
 =?utf-8?B?VzZGMHlGYngrckhZSTRZRUdaQ0s5YmFsL1ZoUjRCV2daT0NvYkFESTdxUDVh?=
 =?utf-8?B?bVZmTFFCaFNoRjRVZlUzZUpxaklHdWw5NXBMRStqcmdnbHhWT2RmVlg5SGdP?=
 =?utf-8?B?aTJiZGNSOUNRK0tpcVcwZENNYW1VemZyS3krbGNTdjBpQURJNXVZTks3RDJR?=
 =?utf-8?B?UU5Ra3NCc21SbjF2L1k5WS9XNTR5MFhkTmRaYkRiTy90ampTUWhQL3I3OUVQ?=
 =?utf-8?B?cmtOeEZScUFObVdySURyVU9MRm0vazBQSWVmaE16dzlwMy9hK0hZRlp6aE5T?=
 =?utf-8?B?WThnZFdXSFl2ZGdQSGxuUHUyZElIeitqMDlQQk9yZmlhUExIY0R4clFOWWZU?=
 =?utf-8?B?V0MwQ0Jnd0lYbGJRZkg3TG12dGZCWjFmZmNmOFVQNmtjL0x2Z3R1SVczNkdN?=
 =?utf-8?B?Ymp5WC9yZmY1d2dteDNRNGU1aXNPZkt6bHZFZVI2bEhFb0Z5KzZOUDB2K2Zq?=
 =?utf-8?B?bTljQjRES2dHbXRrcmRleUtnVS9tZEdtVmxEUVQxL01qTjg4azFnK0trVjBo?=
 =?utf-8?Q?nZS4/4Pee0ciy+NM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4aaac08-9b46-43f6-f5f7-08df2211561c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:16:36.5181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sV4otoQdQ2LQ6y1jYUgHK4616M7rcLU/diRmieAi8tzgnBssbfmTCH2Piv5Ol9eoFMgiCeCirLjzy5MGxjx0t0WCcVvuMcMhTmaGVdO4RCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9239

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

