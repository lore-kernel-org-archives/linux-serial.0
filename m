Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022072.outbound.protection.outlook.com [52.101.66.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270943CE4C;
	Sun,  4 Oct 2026 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116207; cv=fail; b=lbx3/nca0xJJXzs/rbU8twuSgF4sw2MRP3YJOz4rXnglb5l+e6oMlHXmE3Lg8ptRiXgcjsXrSkBjT5lKay489tFaYNikDOyRfpPpGOBomzdVanD4RtW8F33H0BD07S00MTIHrCb/CInT/7/Lfrs5U/yzyb/nEz+D0NJ/cHSnZ+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116207; c=relaxed/simple;
	bh=U+8OgfZ6RIV7tIEYuByc4NclpScM1q1WHc5XcOjMBeg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=J7SB2de9N2wtnk5QMJWJnLXpdoV4ZTKzgZ8LbXC3b5sqZsF00pU5YTmqHVGQgoxmcqUeGLlYn7Vht4Nz5XUc3lYBcqVIUTV/NuaLBd2/O4fa06NxzRRSljT+EG9m/A7SNAmz0IrnpH2h/U4sxuumHBccbuNmg50ShTs4HfCQCrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=dEfp3aWb; arc=fail smtp.client-ip=52.101.66.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="dEfp3aWb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4rpoJLhRSIRbGJdHVD4Mnzpy3auPfdE67sJ4m3LtNPwwArDTvkIH8EPM6iZlDbhmZ+aki5PqI006V1aQjLsCHmCjvAgpVyMREvNxQtHpVqOcEIU7Nt/5MFEyg/WLgZpUtNEjr2ivKPTMpgTmeC+RniSmObimxRGA+yn6KdUvjWisg5QuU1yzwSE5Z/nQ9EB7oe3zOnMslOZUAQdE8ucgoSG7gzkLHXaynes4WVwbv3Mzbd2K+w1GwYRd/S4EuVppNtIwAii+gVb4pnyEQXXHr2fKaZWS45qMn4m5TJyLQFE/wL1LgOgT5AXYTLF1QJZEM1yC8o+qX9it09juP5UHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJPIDHmyMM1UMSRGiWJpwwAJ5CXfyNYypB3w/H2OQo0=;
 b=qH4eOstdVDReaJ81cz27xdTz3kBWfI85Efbl0Y6cryJjGOXgLQ0787vGZYrJCCyNuWSQkzecOrSqtSo+4hiGj5JBLPVAWhWauVWAv0zc6Ekd/b8j/SY3okkeNbGCaG+IigkvBo4WkWIzH/5+pmzLbcCzaI/B7j4z3+D4Iwvjou1bG3JDo6ZWJvOCoiHvAAFZAHwu09wFfhz6jcbnxHxAmikv8X2+B60UbFDyHWlEDj9fNjzL+mPSiqjBoRh3F0TKutxCJI/SVx/xw0WE2rKlri/Er/LhyJ+MAkFsHpBEEIkuGRIYzSKP81w4rMgfPraSf7dywF2RIoIc4+d5UTkj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJPIDHmyMM1UMSRGiWJpwwAJ5CXfyNYypB3w/H2OQo0=;
 b=dEfp3aWbFvXZuUW9z80OsXXqsRqdOb81nYjJ9NIoV8WCgl63QQ4NVRMqBFIqxhJeTgUNBKT39uITDHSMbZrLir9I/sQKhnUdyV2VJJ925E+mvEcDGZf6TPcxDg0UVi5EcbuwOHYOVbhsEWCVd2WVO+BaRk1WuHoS6banKWWVVGyn47wnCQyGLeGoYuY5K9Ub812feLN56wPKFDPugkUXAaKpfcvOC+bquj4HY2dXTU9A/m6p6U1Vfn0wpTLFH3hCwkEyJKw87QAzIS4Ij7eM/Uqi/BstYXGii8aGudAo4qO0dgfamUqro+9UB647fC+Bj7A7dPC+6eECsa1AVkf1uA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10218.eurprd06.prod.outlook.com (2603:10a6:10:623::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:16:41 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:16:40 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Sun, 04 Oct 2026 12:16:29 +0000
Subject: [PATCH v6 9/9] serial: max310x: don't transmit while an RS485
 reconfigure is pending
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-max310x-rs485-sw-delay-v6-9-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791116192; l=4985;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=U+8OgfZ6RIV7tIEYuByc4NclpScM1q1WHc5XcOjMBeg=;
 b=oViaERkCWGIZB0K/0XeyXLxUWXPqp4mKyjmr1EtbW3kf/Y/wMRmjBOlkhoSOYf/euNsTdyoI2
 9Hj6k5O1V1XDcx6pU+l5gjPeVJg6cwGdDbFUvq7bZwXvneRUkwHy93d
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
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DU4PR06MB10218:EE_
X-MS-Office365-Filtering-Correlation-Id: 531179c7-37a4-4cf0-685f-08df22115893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|52116014|376014|22082099003|18002099003|38350700014|6133799003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	ICJLNw4+muG7W1klAHQWpa87VMV0Xz1YR6qeI6ExRdjGKLiKZVVGwAc4W+GmwNYCf0PBBt6HUZNy2MULu2YOZxY2uD2VwcaEE9KjhCrHhQFqUBimp3+xN5dEpHDNDCu3/Si7M7SpbX3umfnW0ZSUTe9+A4uhvWtNHSfvBzpI6q0P1NYQckpbWukSZ2SC09P4Rcy2MOdVzb72VuysmsbsTFY/LZBvoUTYkXn2v85ROdkhsVEScSk6WeINovfR5p3/xlfWtEnHdnGf5Ok6yvGFNFTbrFKfKX8vXOHxkBTVapKwerUJg3+YWcxrsPk+KDsas6LQsvubsvi4VF1LvS5VTf3n8eV8Hbs/XgyRc0F8F6Km3W+VsaQmIRF137/WiGCflSgmthaN9vqW9YFp0Okd4MdbnUSn5tQ16KhzMRFydyM/e3o37gZ90oySK6FuJhjKiNrilcUsiLqiQQxwZZNbf2lpW6ycOGZ05GKhTXoBXmdaoh5pTl0r/Lf2HL/eZir7TqmbZlZWMTLYqsJBqaFrIsgRj92FopK8R09arY01SYoatJrOne31Ttkqrt5FvkYK1l/o6NnB566rAhl6twdg8JIlm4aR6RFpR/TudGHq5uS+ZN/EKAH3zyH1UklKzzSAXRP+VLPn3y1X74dyz/xpheUDh0XU2/RhFqMGFvY2cfGShkbL6kzf4h8XlDfjD9bppFOQFs8OYGesIiB1ZFe8QbBq4QpRMEYHlPIljwTyXTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(376014)(22082099003)(18002099003)(38350700014)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlFRQ0pmVWZaYUNUWEdOT2NhaldkZmRXVkVERnhqeTB0a2xHczJJWjFiOGRl?=
 =?utf-8?B?NjBFNkwzRThNQ0JWOC9XOUZ3alpRUDI1TlVaaUIvVkdmTTFtWlBtTVZjb1dY?=
 =?utf-8?B?LzliQ1J4VklvMjJvQU9mei9RRm5mQ0k5STZKS1VKTkhDQS9CdjErdGEvVVhE?=
 =?utf-8?B?UGphOVcySExTMlpTaktJQndGblBJYWdUL3lDYy9XUDc0TFZ2RjVuYi9SNk9H?=
 =?utf-8?B?MWt1c2hHSWswcnoxNFdHa1Z2V3pMSHJTN1RSSyt0YklGRmp5ZUlzTVVZN0kx?=
 =?utf-8?B?bGZBRFpLam1NWmN2dGZpQlIwVTcxQTZXZlJtQUNyRlkrV2ZvbFNSNVFIa1lZ?=
 =?utf-8?B?VDlUTkFvUUUxaHZjNnphK1VLbFE1VDIwaWgwKzc5MjFiUElneEUzM3Q3UUVt?=
 =?utf-8?B?T0twb0x2K0JiTjVueHBrVitHS3pLQWlWdDBFRFBEcHk0NnRNVzE4Q1IraVhh?=
 =?utf-8?B?b0Ftb0RJUkdUeVBRTnYrRXdoM3FxeVBIMFp5Rm8zVk1hb0swcUhPL2d2Nkkx?=
 =?utf-8?B?NjA5b1k2andJeTVoNGQ4UVZoblpBNDYwL28rK244a1pHaVVuODJJUWdrRlFI?=
 =?utf-8?B?Sml1SFNXbTNDVlNhenMzWXpqY1RNczFvVWZGbmdnNCtrVEl3Tzdic1E0MDNQ?=
 =?utf-8?B?K1FyZHVnYzVLWGE2VVFsVHhtM2xmU0RWdlNFd28ralY4OW9NZFBVV3dLL0Q4?=
 =?utf-8?B?bWZGMUhVamZLOEw1Smh1bWpycEFCYS8yamlsT3hUU2Rsem94L0MydVMwR1dC?=
 =?utf-8?B?aURHUWJGdi9kbVRpSXdqNUpVNlo1V1FsNnZvN094bU1kdTFQeWJRK2RUeUFZ?=
 =?utf-8?B?bW9YMk03bG9OTkJmQTluTlA4UE9rUWVCeTB0RGZPRGhCMGZpdlYvSVVRVEx6?=
 =?utf-8?B?L2Z2RjVnSXRaaXRXNDVxYnZiM25kcHhITXd4dmNrdW9mTGFpTnJ1RzdIN1c1?=
 =?utf-8?B?N01nRDJBZjFFMU5WMFdwVk1JY3FTMWk0NkRnL2tZdTN5dU4yUWpGN00ySGlP?=
 =?utf-8?B?S3Rmc2VtSjJsaWZGUUlIM2RkalRJeEJzRnV0cm10Vm5jdzYvazkzcmxjUUtH?=
 =?utf-8?B?aWJXSS9ZZ3RaUFBVZ3V6cFdkNW1PeHhZb1AyakxVOGl5aHNNSUxFakhFM05H?=
 =?utf-8?B?WTNRTVN6dlBEVmFGaGVwSVk1dUtDRk5XVWNUcC9YM1ZLZGRrVnViaVkxNUJK?=
 =?utf-8?B?R0UyS0xBNUlIZVhkdGZJSzFUYTRIQVRvTldtYy9GM2NXS3kveVdOMWJlbTlo?=
 =?utf-8?B?ZTFHUTYrSUFFVExrdkxlOENUdnlhS3BBRVY0SmZIVWhsd21BbmFzTFdPS0J6?=
 =?utf-8?B?SHZZVkhOUUFaSWt6SjdxdkxqVnRxMW1Bb1htcGROU0dMMUMzbXI4bncyNmVB?=
 =?utf-8?B?M2dCL0lSWjRXS1djQ21zZ3FCMlRURC9jYWFoWkVEVXNQVXgrUXR1TG9zSkZp?=
 =?utf-8?B?Mzl3L3dZNW1tNnRYN2ZQM1RxaU10MkkveWxSanIxblR1Z25tZVFabFl0OEor?=
 =?utf-8?B?SENZQU96UEJPZk5WNFpXZmpxWkc1Y0Nib21jK3ZJWjcrMGxDcnY2T05kL3hw?=
 =?utf-8?B?Zm1JWGY1eGpkUlI1ZDdSOFhYbDZwcTBkMEtWV0dKSFczcU9HNlBDbThIRXY1?=
 =?utf-8?B?T2tqM0wrcE90M1JJT1RyZ1Y5NXFEZVY1QVR5NTZ1L0szbWZ6S3ozbXdRRjZq?=
 =?utf-8?B?aUU4VUJ3RGlIU2srcmpzM0FpdXpGeEwvWnRHcDRTbVhKK1hGK20rVzZjeE9h?=
 =?utf-8?B?MFBrcnpFV1VuOXAwckx2Tk1SYXdsNWYrYkMrWWM2LzNGZDBFeXp0TFVpZW5j?=
 =?utf-8?B?NzVqTllYOWprcXd5TUZsT2NTL255U2oreXFIMGdpUlJad3VHc3UzVW1mRnBt?=
 =?utf-8?B?bGw4bi9HSFRzVk5TTUZ1ck4yTHNLR0pkOEVORFIzY0NvOU1WaCtubTNmRWI1?=
 =?utf-8?B?aE52RWxBYmpvUGduTDE2Z09XaEZLeXQ3Sm9WVGl2bHJZWFo0alA3M0kwMTRO?=
 =?utf-8?B?cVEwaWdaNFk1Nm15c0JkemRxd2NPdTJWM0ltUzZtczJ2U05MbjQ1RlVRZDBp?=
 =?utf-8?B?OXpzQmlHb0RabEUxQjRGSlRjckR6UkkwemwwWGMxSkZmSDFSTFVRWDNkVzJt?=
 =?utf-8?B?QTZYazZUMEVETEFtQW51dkt3RFJTaVhIOEs0ekFnUjdGRTNSQ0luK3oxWnlS?=
 =?utf-8?B?bHlVNC9sQ2NPNnlVR2V4dUlZZW5rODZMcmJweW1mdUpIRFNnS3E1R044WHUy?=
 =?utf-8?B?eTczdWRjTUozUUxwYXJVb2lLZktpRWQ2L1BiZVl5RDZoSlEzQlBBTEk4ZWI3?=
 =?utf-8?B?dnhUTlFTcFo5QklCc0ZHM28xd0xvaEF3NFNOT1VONVBZOUNnK29pbTJSMmR1?=
 =?utf-8?Q?WJ+OQ5CsndbvmVlM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531179c7-37a4-4cf0-685f-08df22115893
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:16:40.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdydthz7hkskBj4R8cGvMNUTnccVcLpCxrI/FkgRROXNx/u8TZKc9Rl5F0LpwTksz8HP2vfw2uC3nePXSKBv/38WDVlefbPM3GyxnGoHTGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10218

TIOCSRS485 applies its register changes asynchronously: rs485_config()
stores the new configuration and schedules rs_work, which programs
HDPIXDELAY, MODE1.TRNSCVCTRL and the RTS path. A write() issued right
after the ioctl therefore transmits against the old, half-switched
state. On a single core the ordering is even deterministic: start_tx()
picks the stale path first, then rs_work reprograms the chip, then
tx_work pumps the data - with the transceiver already released. A
TIOCSRS485 switching from the hardware to the software RTS path
followed immediately by a write puts the whole transfer on the wire
with the transceiver disabled: nothing reaches the bus and no error is
reported anywhere. The inverse direction is as old as the asynchronous
reconfigure itself: enabling RS485 and writing immediately shifts the
first bytes out before rs_work has enabled the chip's auto-RTS.

Defer instead: rs485_config() marks the reconfigure pending under
port->lock, start_tx() leaves the data in the kfifo while the mark is
set, and rs_work restarts the transmission itself once the new
configuration is fully applied. The rs485-disable path's direct
tx_work kick is replaced by the same mechanism, which also orders that
flush after the reconfigure instead of before it.

The restart kick also checks port->x_char: uart_send_xchar() reaches
start_tx() too, and a lone x_char deferred by the pending gate leaves
the kfifo empty, so the kick would otherwise skip it and nothing else
would ever send it - an idle chip FIFO raises no TXEMPTY interrupt.
And start_tx() re-checks the pending mark after the
hrtimer_try_to_cancel(-1) path retakes the dropped lock, mirroring the
tx_teardown re-check there: a TIOCSRS485 posted inside that window
would otherwise let the transmission proceed on the stale path.

Fixes: 5bdb48b501e8 ("serial: max310x: Fix RS485 handling")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index eb1d2e3bc870e9097d649eadb1e6e8703033fc94..f8247cf0358ba74c7d1979e64be2990feb5e2627 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -319,6 +319,7 @@ struct max310x_one {
 	bool			sw_rts_during_tx;
 	bool			cancel_tx_delay_tmr;
 	bool			tx_teardown;	/* envelope being torn down */
+	bool			rs485_pending;	/* rs_work not yet applied */
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 	enum max310x_tx_state	tx_state;
 
@@ -979,6 +980,16 @@ static void max310x_start_tx(struct uart_port *port)
 	if (one->tx_teardown)
 		return;
 
+	/*
+	 * An RS485 reconfigure is scheduled but not applied yet: transmitting
+	 * now would use the old path against half-programmed registers - a
+	 * TIOCSRS485 switching paths followed immediately by a write puts the
+	 * data on the wire with the transceiver released. Leave the data in
+	 * the kfifo; rs_work restarts TX once the configuration is applied.
+	 */
+	if (one->rs485_pending)
+		return;
+
 	if (READ_ONCE(one->sw_rts_during_tx)) {
 		/*
 		 * The before- and after-send phases share one delay timer. If an
@@ -997,9 +1008,10 @@ static void max310x_start_tx(struct uart_port *port)
 			uart_port_lock(port);
 			/*
 			 * The lock was dropped: a teardown may have run to
-			 * completion meanwhile. Re-check before starting.
+			 * completion or a reconfigure may have been posted
+			 * meanwhile. Re-check before starting.
 			 */
-			if (one->tx_teardown)
+			if (one->tx_teardown || one->rs485_pending)
 				return;
 		}
 
@@ -1453,6 +1465,17 @@ static void max310x_rs_proc(struct work_struct *ws)
 
 	max310x_port_update(&one->port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
+
+	/*
+	 * The configuration is applied: release any TX that start_tx()
+	 * deferred while the reconfigure was pending, now on the right path.
+	 */
+	scoped_guard(spinlock_irqsave, &one->port.lock) {
+		one->rs485_pending = false;
+		if (one->port.x_char ||
+		    !kfifo_is_empty(&one->port.state->port.xmit_fifo))
+			max310x_start_tx(&one->port);
+	}
 }
 
 /* called with port.lock taken and irqs off */
@@ -1478,17 +1501,11 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
 		}
 		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
 		one->tx_teardown = false;
-		/*
-		 * The port stays alive, and a write that raced the teardown
-		 * may have left data queued with no envelope left to pump it.
-		 * Kick tx_work; RS485 is disabled, so the plain path is right.
-		 */
-		if (!kfifo_is_empty(&port->state->port.xmit_fifo))
-			schedule_work(&one->tx_work);
 	}
 
 	port->rs485 = *rs485;
 
+	one->rs485_pending = true;
 	schedule_work(&one->rs_work);
 
 	return 0;

-- 
2.47.3

