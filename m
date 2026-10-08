Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022084.outbound.protection.outlook.com [52.101.66.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7548E0C8;
	Thu,  8 Oct 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452966; cv=fail; b=Ehf9sutcvyKSkJismFlD2ZZw/6XBgPNmIdRMFglyQF7XdD9NDjh7OVnJ1jcH/BHCkBbxmPL3wEohwGjs4jyyn3NHkA3MIXw7zvM/dezWi2JwhUSPxW8/I61yxUeXqaztC+wxBKixqyW1ICAR9VT/Icnh4nwawU9UzXNXx0YiF/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452966; c=relaxed/simple;
	bh=PdLOMwp6EK9w0jElHyf3mZq3J5zhzx9wDoD4vh3LIto=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oekPS9qVe8bBi145aZ110ZeEiSILKJtBpJHU0Kjq5fPJmt3Mp3MtFsK42q3aH7cH+qIUjXtauQLTn3D3155iiFWwKkG9jr5d97a6QOpQL3rH+qeBDrWcbnU2Nx+DjQ9uRUotWoWD3dFeAUWu1LKL4Xn/BU8FI2/zB7zIyV17PC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=D9F1JHrB; arc=fail smtp.client-ip=52.101.66.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="D9F1JHrB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cldnnAjfU8XIv5wRt2Yl/iuxUE2jFHqmJt9MkdlpHYJX7xnGrHFiSCYbmjEtySjXtkPkk1UcBon1e97jGhc5YQOTjWQTUlT4tMdZwtA49Cpova0fZcWjWipItQtwAErcoZrcX7FW5tfasMsx8CUZNYv4P/Ez9DNfDJ0V4OthCZAUXcSvqO+JSL8zQxYGdyZGKQVNlecM7EP3kpr5mnfkYZ+b+t31ERqdmrtNRZ6OpraTGjIAVjkCRgmlkf/PUtMPKjscbu7hvmhdpnDNq1V9TipISa5nKXNfGuXVIXJYHP2+C3v7ShyR/0LzicJK5xPHNpCU0qFvmp7mtM7OTmh9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnFy/d19nVKI2iDgW0YQnzZewt5hBOlU9FqKyol3LKA=;
 b=xRYx+5dAdefcModp9BS/JVHWnp6WAmHnBp6ft5PThCz+hqZYM3bYuGJZj8GuMP3+0u3c+8MWqbtP1VFG5sL4tBhYWZnYdVqzaErCll8H2sfVWF7pGy3BJCrXAWbtixtTURBeS19k+849qzAZFMSPeio3S7m2BLUYHeWtxq6h7/mbPtj0CyORo8VZlTH7j+WXiz0/0vdjATg1WMFZRz4UYV6PhRek1bJI6fyq1JZkZpp+NzXSifmfKgRkBdZuFAiq/ezW/GPH9ZEqw9oSVWNXhZsH2LXC9jrTQD4fK9Mjdzx5btcldfKiSSxYg0P0FX8+yP37NdiShVcVRO685BFHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnFy/d19nVKI2iDgW0YQnzZewt5hBOlU9FqKyol3LKA=;
 b=D9F1JHrBQjxsSW5RtVtiJ4cidZp8vVhVSCCuO4Ij/Ya0wJfn9kYE9T92Ue6InXONdH5Gh05ObqngyUdZJ4CTAuq/yXr7hxUhc2zg46c5wSg0zwBvClNBj7qmqgF2ojtdRREirv/CIFXY3xV3cHWvFrnv1IigpR5hVn3bZ5OnDxV8U3IWeKGafqvlVBBAL4IJqeAKyvltcIPoSIFwlQP0OBwb9UF3pNMt6rtJ3eDoNDCswYg9xO3m9ExKrhq5VXklqa59+erDd0eJjt9Y5ZVjcDA7yMRHl3YqI7Mk0rB7iHLX0/tGs1XBZxqUBPAvdMIcVq6FYG1jHtb+RLq7wUfVlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PAXPR06MB7567.eurprd06.prod.outlook.com (2603:10a6:102:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:49:10 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:49:10 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 08 Oct 2026 09:48:29 +0000
Subject: [PATCH v8 6/9] serial: max310x: support active-low RTS on the
 hardware path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-max310x-rs485-sw-delay-v8-6-6ba881f81e1f@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791452935; l=3681;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=PdLOMwp6EK9w0jElHyf3mZq3J5zhzx9wDoD4vh3LIto=;
 b=Zf0A+PKYQO+zyH9FW06gweRpph4I0MPxLhn3r/Zy6wckl2LPT5DYSsO1ocPmmtMWf9WZDc2R9
 sG+dkyGy/9wCm0nzn9k0coldMlaPtoTaoy7X6EOx2J33gJZPg1h29yl
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
X-MS-Office365-Filtering-Correlation-Id: 9fc34a97-e3ce-4775-e18c-08df2521614b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|18002099003|22082099003|10067099003|3023799007|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	PSLV83d4iKK+yJtZUU9Trv3RPjgzCfYZK1Z5qgeP4fUMQhMlW98djK59IY8DLVdaEiiMKlvY69S/VF24xjtIQwnfDNQpacNBlmsYvzOvcyHBfsBaPpT95GeAAovIDSqhiDHWBhLXVR1OnYL4dqhEom/WvhaF1pXAgVJq/PpEb/e2glb62jz4ZY4vpWg5exTqybRqUtsx3ILA9qi7djtmcOLMqKqK7fc8GLKP5BpksrwFbE7eoJ7FDtzNoRU0X11QJr2OobZ5c0jp48Af9pf/FSuL3l3091wB/SMqmcl4oSbqFDSCTYyEG90tTJN2oUsu0+XLZCLPJkBtpiiehNOdl401TcL1MDvTgss+LKPZnYBCplnEfj3kwF1QNIKlbTrso+SAAgvXL+rBZUaAbY/rkxWOZUdAtZ9b2ACwPT9cN1IvMT9H5neNLUJ7ldGOKG8A02Z7i6bPqa5woJfZYeEI9QdziUnosRphaoE+kDb88GOdWGYNcJzFZjdle3208+26Lvrkx+D2oHdmEnFmajx2vml3EpemuwzWGEQBLviH9zT0T72tr3CxJbIvfusFy5kgwOYOo6SvcR474f3/4RjCipI4XM7w5IVCawFr0VWgJLSiOIe/R98O007ngG5tQkE5lOVVnUKQYscgiVnRYN8dex5zwFFttVM5FiLkvE/NtL+9GFcsw9j13Pr6Jpvmq15HYhdWVEXpVQdRavWLv88oNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGZOR1dPTlNxYU9mNmd3N2lwTHBIK1NBZkljSVRYSktwL09MU0FTNVlnV2JI?=
 =?utf-8?B?YkhoWGg1TENVbVVvbkR5aVJWTVB5cVdCSVNicENIb1RjVTZSU2V4Ym16dUw0?=
 =?utf-8?B?WUZHdUFwWWxRWjNNMnpRSDA4Ujl4VTZyWVpaVU1wTkMyQzVndStKbk42MTg5?=
 =?utf-8?B?clJweU10bWY2UVFlSlNpTCs4UjRBQkI1aUU4NFBpSTFaeFJNRTZQckxXNVZ6?=
 =?utf-8?B?RFVSTjNRK0c2RndmUWk1UnlyaFV3MjNwS0N5aklKWHVWYnlWUFM3Z2RsQjFn?=
 =?utf-8?B?azJGQ1RYYkVJOElhM3gwc0s5ejlrSnNGUVkrVTlYWVJFUTJSN2tEMkNWb2pO?=
 =?utf-8?B?aWEyUlFKNVA3eDV4dEVJWGtSbk5UeEFpYUwyMDRyQXRnSnkxSzhybldTSGJZ?=
 =?utf-8?B?N3Z1aTB3TzlRRHlJdGd5MTJjOTh6S0FnVU9zUDNHenhabS9KakR1OHdpM0NE?=
 =?utf-8?B?TGFERndkT0h2MmxvUHh2T3JITjlPNzdybXVTWCsvU0lsMjhPUWcrTzZkVU40?=
 =?utf-8?B?elVOblVvenh4bjh6VTVFRlFRSmEvQ052YWp1T3BGZ3dEbDdreFdjWThKU2ti?=
 =?utf-8?B?ejZ1amVPYnQzUXpDeGtVVjZSajhMQ0pwZ01UNE9qTmFMcDdTQjhyQUR1clVq?=
 =?utf-8?B?bmp6N1J0MDRGejM3cDFoNjhkc1g2djF0MUZqMmUxZE5pUlB3T09RVEZTNmpP?=
 =?utf-8?B?Y1o5aDVHenpPc2tIR29iZzdUTU9rVmVidUJrM1o5NHA2dDJKWi9jSzVsUGdZ?=
 =?utf-8?B?RmE2am1DTnV5bWZYUTJad3kyMFRzUnJXbmRndXJYaHFTbEhGS25acUp5aCtQ?=
 =?utf-8?B?UDJqOUpYR1Q3T0hiRkorQk5QaTJVek5pMi9uZnZGNHdaSko0clVBaXA0b0Zk?=
 =?utf-8?B?NG5rdmJVa09tNnBLU0R6bnVoVE85WExKMHNMS3F5bkVVRDJ4aFlJOW55eWti?=
 =?utf-8?B?TXhza0lTYmRCdkRKQVIxTXAwa2w0QW5Vdi96eUhtS2V6Tmlic0lVaDZyN0gy?=
 =?utf-8?B?ZWc5T2ZtQzA3bG4ySUxvRnhpMTNxakxObno3ZmhVaTZ3SE0zUHNCQ3RnYTJ5?=
 =?utf-8?B?RGdEU294Zks5QVFRd2ZibkdlcUc3SUxrOUVCa0Q2a1BaTXNFWkloRVlZMnNH?=
 =?utf-8?B?MlZQRWxjVWFsekdCK3pPbmZMT0pBdUpHNDU4R2o4cjlQb2V4MlVMQWxwVWh2?=
 =?utf-8?B?SSs5bHBUdW9DQ0VjcEdJRmRXdmJ6K1lhMXhPbUJOcFhqQStYU0RvMStRWjNF?=
 =?utf-8?B?UUNBQ1BMaTY0TDdtRGFEbkFNTU85Rk80UTFqajllTzlGZkNmc1RwaExqSzJv?=
 =?utf-8?B?ZnFYWjZ4UFBmRVozaDh6NjhUOC9UTVNZSmZSQXFsQVBsQ0UxTlAxMmVZWEJs?=
 =?utf-8?B?UWFlMHdsOWpOdnRKUWdIcXMrQ0hhZkN1MlJxNThweVNYWmkwcDYyZUJUNGhG?=
 =?utf-8?B?Q2Fmb1B1blFWNHZKUmFjRjM5emc1d2J4U3pzZEovV0JtUVZVMHBiTG5oWjFo?=
 =?utf-8?B?WWFJaEdhemFBSVlwTlBSRllrQ29tQ0drVmdlbVoyNXJ1ZklYZXAxR3cxUU5M?=
 =?utf-8?B?UngyU3VDZXZLem1XWUwrOVJFbi9nSmYzVjV6UzRUS3dZeXVwS1ZEZ2p0TXJu?=
 =?utf-8?B?OXVWZ0RJTGxyb1EzU29uUTEwdW1kcTc4UFRZUWIva05EZ2k3TW5oYnU0ei9O?=
 =?utf-8?B?UUZ1NjVEc1Z3cmpFZUNlMXJJbUpDOFRxdXowU3QrQnc3VzFWcGtydXR3anFQ?=
 =?utf-8?B?YVNjblF3Y2VhTXV0Y0Q1bXhiMXJIZTh3YzFXTXRrL3E0WGp6clI2T2pudUR5?=
 =?utf-8?B?WFU3NFZTaEk4RXpUcHRCeWQ5aC9ySE1EYUxWcEI5dXdWS3I2WHZXLzJDb3JG?=
 =?utf-8?B?N2lyUFB3ekNPR0RLdFpIMWJRRXE1L2lqUENiejBYQlVNNGFkN0RUQWZ4L3BL?=
 =?utf-8?B?SEdRUTV0YnpOaTZYcWZHczNmdmNVaW41S1crTWVnN2RENzY5RWdLWnhIV0E2?=
 =?utf-8?B?TGwwME5xL2YrOFhuRGtnUW55SnY1c3BKRmJ3RklhZWxKeDdNK0ZyVnZQQzNI?=
 =?utf-8?B?clMwWjFKazFZbVU3NHJKMmI5WHQ5N2poYU1tQW1tVlZjR2RMNjNCUHlvOHpK?=
 =?utf-8?B?MU9rdmZLejhCSlU2ZTI4eGJkTkVucmUxUllBSTVvOWdidW1EcGczaGpLK2x5?=
 =?utf-8?B?bVRSMThNeEJONmRjWGQvYWRFem5Jdk0rckp0Rmc2N0xoUktjaTNIbitteDBs?=
 =?utf-8?B?STZ1OG5rayt1OWNxTXFqS25WY011Szd2QlNZSEtWNHN1aHBJK1ZMWW1XZ0V6?=
 =?utf-8?B?MWt2Z3RTLy9meTZ2V1UrQW5EanlndmlGRmFKaVIzZjgrMFN2dzVubWovQWdW?=
 =?utf-8?Q?xCzycVCMLhmEgQ9Q=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc34a97-e3ce-4775-e18c-08df2521614b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:49:00.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKJHVJ4PHLOd6N+sJgyhsEpoEqz4y2Zzz8tx+/vDb9/0019zho2/oVS2XvCm2+99hbFIrybeSEP8NsfQ0WkcTLcPIw/vDeGG1A8u2VPQyv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7567

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
index e08e506360d72a3ef4c0ebdca2e60d864973f909..0c40283f44ba1df712607218aef24cb642ba3918 100644
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
@@ -1416,7 +1427,8 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
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

