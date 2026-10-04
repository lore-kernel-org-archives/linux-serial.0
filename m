Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021077.outbound.protection.outlook.com [40.107.130.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4543BDB8;
	Sun,  4 Oct 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116222; cv=fail; b=HdkYIw75wau4fMAfGQdf6if3brxXHMtOdaaVtBqTtusRuNFzEyDUz/4XNpP9wH0ump+OBiZFkBtVVLKY7ytgB5lRUBDy/F9HdztlsPd2594vWuu+AnQ3ttMft2h6iYE09GpbI4mMHcNWYghPkedoo3AwhGcTA59WWdOu6PiQakI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116222; c=relaxed/simple;
	bh=fNigHZk86TXz/sBDj1u7yo/xfiZQo4NczCcDnMnVIjQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ANiXy4EozbcNTDsSdb4QPxp0eftkz9xh7IFSbZ5PWbLAB7WedRIYiTUjiXTH1mmn/8CktTuIPwXr8776C10Q68auk4dWWcLWFDhpvF36Or9TVewGRBBW0IIVtFmy6wlGtqdbje3zYtaWRdITOnU4TZwZc42TCcfIsue7C8kHM1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=jpQsAvpT; arc=fail smtp.client-ip=40.107.130.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="jpQsAvpT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1lo7eHVKk7hJUu0E1VXwmgo8G/ulkiuMOUI33qK2Zz35icUv9hnVYBm4AbEBPcZLuH1E8YPf28aP5/Uw89wvI75BptCrKSavGBITdeWTXfxE0Lt2w4EuCA9VxrLw57ZOSeFjLDpzYQ7TNpjYGi2AwAnbCB2Xf1QqFfV65UjHNeOD1Z03WK+eNQKRdZkMrMtEU96Q9x2jDPJIiwX6pmb95BFti1iNbXAscvuA36J6cOpbZu4IHChqUyr7qozjlnWHiWyMxXqWdw0w1FT7opkdPXyCTBVEjEKXOG9H0vlKxrw6yQhsDDJFtprrD5Kk257+dJIm9wheTw/DPllK9ZKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTsfx2l8dT5/myLUIsLQsWYi8pmriOwis/PGar7DKo0=;
 b=OCooNYCPWhtqn4/KDlkkLT9kYOkgn0S4tuaJybM4/PRK+347S/MvDzluHzM/qeo7IZDlPTGNX3W/Ni1r1iymRPS1znjvlrJJRuhKQhSnZbu3/2/h+qOg5/gznPbzTds2/LGBBmyNGLEVkp5opTPNjmSZNoLp7X77XAE/nFh9ah8Jt5kt63UNK3bomw44jysxEaVSS6xOoaHfql7skGNwcMJ7wkcxche4uCg1Qxt/vHd+ahi4xJrNpXgwcCvWbB5IV6M0N0WIQoHuZRbULPCOVOBs3OCW5iVYz8WoDI/F3TBSzEgA6pLUvkEfWLbfX3dIEMDK6bB70IyFVEAsRnmXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTsfx2l8dT5/myLUIsLQsWYi8pmriOwis/PGar7DKo0=;
 b=jpQsAvpThvcODHSPJTZPkEx7hNufp867oghg0r2Z9Ml1/H0QNg2ogEFQ4AJ8qZcTX3x5CZEdUC74w9K6uTEVKpJmy1upYH9rd97QBCzqQqQH14eKrlW0U6HbugXku3LxQN2WqiEyGeVEq6k46H9jT/aIXrbgMAaKCJ+koP0YWtuAa+rCkeG6uGAc1qtGa3+Rsmdbm9IPIt2wdkOJH0EJ2aniUUD+3EHIKSmmw1hJgHLujT3Dr1UCqQGItb14ETRNHQlKjIRshzJJUBqDmo0y3W4iGf6U++IISWjXu8KymRLYVVqCmsoki8wOBX0KS+QK53sOuFjKYS2/mCt+I9JkoQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI2PR06MB9239.eurprd06.prod.outlook.com (2603:10a6:800:221::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:16:37 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:16:37 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Sun, 04 Oct 2026 12:16:25 +0000
Subject: [PATCH v6 5/9] serial: max310x: wait for TX to drain before
 powering down in shutdown
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-max310x-rs485-sw-delay-v6-5-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791116192; l=3461;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=fNigHZk86TXz/sBDj1u7yo/xfiZQo4NczCcDnMnVIjQ=;
 b=Ou0ZFVMEUr3Rmr5nkI6hikQ8TbqbraPzxI0oZg2PBK0GhP0UcUO1AkV4HNjTFpSzFE1BjqMT9
 NAIJjild4xYC8kGurHv6DiBk09Hxg1NltZU/o2dWe+12uNKdt1Ef69u
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
X-MS-Office365-Filtering-Correlation-Id: 7aa45a98-f93d-400b-c1fe-08df2211569a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|52116014|18002099003|22082099003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|38350700014|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	BBBf4hf8kr/tnAabR0y9hduf+5Mmq98pI7MoiNsFOB0lXUdVEFeFYoi153VbrjmOuk605AMF9twFgrWge+k9eDhMCZm2rvaYfwkMJ8d6T2JFOZjGEAUJWuxglYRMNu97rwISarbT421ksaeksSSibzsJICRd0mAMmWbanuNkRzmZn9ixTmtG71vfLAsXImq75q0I4zOQf39g+z/FQ3g10ecASQu3vsENleJ9I7vCO8zazTEOegLiMAroeqaGkU7rk+qcPivgThjcssOwaRCGCwl8CLuIZH+YS0qbhUasIkHPdouhGRsbf+B/lOX4HvfFILRUmcr7MuCIMkcU4e9XClFl2K6cUWn+Dl9Qhv+sb8bX0twTEicj9d83zDbvzN4KBBycqDyqC/XQXYzdwDM8GUb4XD2RWIxNc0UOwUZWxaAYqz9pa5kbT85ijJY63VM443ipU6+BI2IZbCJ5kk163BSvD/cApBRXAarTBF8SSoe6B325TacqWX+EWFXX2Lo73e6DI+mBtTk7pDSK+Jv5dMOIWbgQbhPPRkmuzbHb/wlkoH3P56gmargUHG7er2vQqEnQHtq+r+gZUJhwQqjAftkiLyyHqZqFsBpaFqut0yee1MTWsc07Nc2cLCoQyRKgCP3jDwzNuIOpybQl7tGE+n8k1C7kTmRfU1W3EFIrE+OtHj0yN/xQpA0u47nKua744HsNkNwBkEvKqOjkBOpumJhJ6kJeTo9z6hnK3YJVmYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(52116014)(18002099003)(22082099003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(38350700014)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGdCZSsrYnRQNXFrNEtoZWpnNWx1WDNYYzZ5aEZNbS84R1BMci8xc2hkRWlN?=
 =?utf-8?B?YzBLTlNqL2toRzhsd2pZRExOTnBjS1J0UFJXdjQ4QitjaGkveDlhd2lvZ0FS?=
 =?utf-8?B?NTBlU2xkUzZOMVdrZEtHdjhYUnpBbFNrU2FmbU9xbTdhT29kM2xWeFVWbWZo?=
 =?utf-8?B?SjdFREZnQ2poK0h0bDZVMlNNdEpuN2Eya3pqUTRISDQ1cHBQR1FIVjBRUVVN?=
 =?utf-8?B?NHdUbDdyaUZXZmhGVHlpWjNrWkRORjZNY1MvVHJwM1YwK25PeGlzN2UxN013?=
 =?utf-8?B?ME1NS0U2OFNiTlZ1TmoxY2dwUlVOZjJGNTE2V1QwUzkzeVg2SHRjK2FEcUNk?=
 =?utf-8?B?M3UyWnR3UGtsM05lYjNzQXJjbjdZQXQwaHpZRVF3Z2lsVU1uZ1JicGVmb0ts?=
 =?utf-8?B?S2N1NWlpZFpIbWpnSGc2Y29uc3ByaVltd1pPQmdaY1hHdXFvZWNPZHdyR2Np?=
 =?utf-8?B?bEIwaXNkR3lrWFd3QkZ0eXd5MDlwNVR5OXN1NnNCOFhUWUQ0dURHanU2MXpz?=
 =?utf-8?B?VmdtVUcyeEk4SUtUMnpsRHZJb2JnbUVBbnZHcUJGNUVOOVRYa0lNU3NpcHY3?=
 =?utf-8?B?YTJUVzRrdHJnYUs1NHFVYjVVWS9KWUwwK2Z6cUUxRlF1OGd6dkZ2YWo3bzJS?=
 =?utf-8?B?OEVRaitLbWZMTEhVWnpaQ2U1eXRDYVZDOFlyUWtqdTZjRjBoLzFWMWs1UG5x?=
 =?utf-8?B?SVBwZG54dzlhTWZBMnVaQW1kUUlzTklTaEFYck5tSTB3b3ZVbjF3UmZ5MW9w?=
 =?utf-8?B?VUZaWFBHcHBHUGlmbUF6eG43V3BBdVlINk50T29yS1FiclMwcWZPSXJhVitU?=
 =?utf-8?B?eDBaQVJNTlBlQVJqejM4emhBZUJDWjNyS1N6aGZOOXFpdmVSZ0Q1ek8rWUIv?=
 =?utf-8?B?ZmhIdk5mMmxXby91TEk0dUYvK010SnEyYjJLdHpSbkFSK0hyejJPdWlFMFNK?=
 =?utf-8?B?K1MrZDRiZkkxR2FmZU5DRUEwSjBLYjNMNlMyVDdzL1FreTYwVHhsZE5SMlRu?=
 =?utf-8?B?aFpQS0RHOVRES3owNG5KOVBZWXN2UDk2Q3k1QjIvWEN3MGNVblp4L3dQWlNC?=
 =?utf-8?B?UGV1WE1tclIwbTFFenJ0OTlhMnZ4ckhHeDlINlFtbUNWSjh4dXhwbklmNEd6?=
 =?utf-8?B?eGNkeVlmLzNzVlJDU2JBbnNrQjFWL3Ixa3ZHRkUxU09DNWFyeDZzMHBaMTlR?=
 =?utf-8?B?M3NndzF2U1dBT09rZklBZDJPcVdOTForVGJheEdMakFUd1hWamRjT0dYOWZm?=
 =?utf-8?B?aDhxaUMwQ2JQMGRpMUllQ3czKytsdWhvcW01b3k3bXcvK3FTRzFnSTRMbW01?=
 =?utf-8?B?bE9HYVhzeEUxYWJLb04xTisrdG85ZHVjZ1JxQ2NqRERNSE5mQktqQlRjTXYx?=
 =?utf-8?B?LzdJTGllYlU4dHkxYnlJdGJVNnZUaHAyVlRMaitMdDJBRnVrc2g0ajk1VElB?=
 =?utf-8?B?Y1dEWmJiMUI3aTlCdWZ6cUduV0xmWUFpQXl0NTdDd0xQbjN4OHMxbVg5WFd4?=
 =?utf-8?B?dWE5a1N5ZzRKRlhlWU9Ob3NpTE0xZ05UMWswTGhuYjFwOGdNOWFFeEJ4NU82?=
 =?utf-8?B?WTMyZHE5bmhFVC9ja1ZiYmRuM1ZEMnk2M1Q0a3ZNYTVQT3RlUjhndXJwOGlz?=
 =?utf-8?B?bHpzdmVkTm1xVWxVK2FjWTd0cFZpWS9yb29kZzI4a0tTVmpUb1FHU2pQTHFM?=
 =?utf-8?B?SVJ3SDdkTW1ZaDNZQlliR1IzMHFUdFJ4ZnJRZDFueFNIeGhFVFR1ZFJVY1Fu?=
 =?utf-8?B?UDBtQzN3MlJwZTZ6VWZEam8zbDFPODFrK25qZjlYeHdGUDRrbk5JZUwwb3pU?=
 =?utf-8?B?QTh0c2g1STMxRzBCb1owWHlaQkptSDh2bGFsQ0hJMktaMlVpa3BTQ2pCSmtL?=
 =?utf-8?B?bkFrRzdVaUZOUGdwNFBXK05qM3dOdkhkYmNRT3JlVmpiVnFEV0ZjcDUyV3ZN?=
 =?utf-8?B?RU9ITXRRaEdRNjFweWlGSGxVaFJKWnZJaFp3QUpoYkx4QjFjOC96U0oxZnBX?=
 =?utf-8?B?cXpzdTB1aFBlbEFDS3d5ZStzWHhhOG9UNjhJS1JWOEpnZkFGOStxVTZHTDVS?=
 =?utf-8?B?UURhUFhmckJGa0hKdzRzQ2JZaDhvM2RXZGwrSHMybnZnRHNYamVtajlIeEhX?=
 =?utf-8?B?NjhHb1FwSXRBSWRwSzB1aHl5VTh3Zi9Tb210U3MvNGpLb1ZDbnh2RmRuNzNE?=
 =?utf-8?B?b21ONE02UERKVjdUTjhWaDlhWSt4Z0VyQkc4b0EwRnl0b050YzNmczREdlNq?=
 =?utf-8?B?MFJMcHBSSWFFTmI4S00xUTZIeHNubzRKRit4enk5b2paNG5MK1pBdDlrRkY5?=
 =?utf-8?B?cXVqaDFHK25sNE4wdFFMN2ZBalNLSlJIaDR0Rm1KVDRJZ2IvWjE2d0VaSVV3?=
 =?utf-8?Q?O66xw0TLeGiaFY4o=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa45a98-f93d-400b-c1fe-08df2211569a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:16:37.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEVS3Afms3WykrWSiPGWZC1j/tc2nE0gF6j0kV5svbqzwhxj8P7VMZbTsD8dAwtr5AnSQhGRhSA5hNJBx99fxoHkvjMaR8x5Ce/T1GMGaB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9239

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
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 2456a2af891f5296cfec833d6406916073d2865f..9dcc817b9794537385aa9ca726cb1cc1b2af6b4c 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -302,6 +302,7 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 	struct regmap		*regmap;
+	unsigned int		char_time_us;
 	unsigned int		baud;
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 
@@ -1012,6 +1013,7 @@ static void max310x_set_termios(struct uart_port *port,
 				struct ktermios *termios,
 				const struct ktermios *old)
 {
+	unsigned int frame_bits = tty_get_frame_size(termios->c_cflag);
 	unsigned int lcr = 0, flow = 0;
 	int baud;
 
@@ -1124,10 +1126,13 @@ static void max310x_set_termios(struct uart_port *port,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/*
-	 * Cache the new baud rate and reprogram the RS485 RTS delays, whose
-	 * millisecond-to-bit-time conversion depends on it.
+	 * Cache the new baud rate and the time it takes to clock out one
+	 * character before reprogramming the RS485 RTS delays: the
+	 * millisecond-to-bit-time conversion divides by the baud rate.
 	 */
 	to_max310x_port(port)->baud = baud;
+	to_max310x_port(port)->char_time_us =
+		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
 	max310x_set_rts_ctl_params(to_max310x_port(port));
 }
 
@@ -1223,6 +1228,22 @@ static int max310x_startup(struct uart_port *port)
 
 static void max310x_shutdown(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
+	unsigned int tries = port->fifosize + 1;
+
+	/*
+	 * The tty layer's wait-until-sent is bounded by closing_wait, which
+	 * can be configured to none, and a hangup reaches here with no wait
+	 * at all, so the FIFO may still hold anything up to its full size.
+	 * tx_empty() also only reflects the chip TX FIFO - the last character
+	 * may still be in the transmit shift register. Let the FIFO drain and
+	 * the final character clock out before the port is powered down,
+	 * otherwise the transfer is truncated on the wire.
+	 */
+	while (!max310x_tx_empty(port) && tries-- > 0)
+		fsleep(one->char_time_us);
+	fsleep(one->char_time_us);
+
 	/* Disable all interrupts */
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 

-- 
2.47.3

