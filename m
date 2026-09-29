Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021112.outbound.protection.outlook.com [40.107.130.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5E4E5359;
	Tue, 29 Sep 2026 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674751; cv=fail; b=eYqR62FqxMwR5p4zi0WBseXf/XKkfy/FLviNdFvlVXiadXDDNprWf9Ntrg4qZv9ydH8k6gesu8YTDR+/rsX5/B2KBqrfnb88EaCUY4qnHuzeIi7nv3AnZKZywtkucScV4Z+6RaKlI1I+aqErZOl+xk3PKxvSAT6XxJSZhExUJkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674751; c=relaxed/simple;
	bh=u5YjLSThsAMjtPNVdGbu4Jh+ZaOZQ1xJywPF8YHFyBI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RY0AlcCXjb1ro0aMqn/GRRiXs/QpWu3ruAdK0mQ1j54GDpgWGjBRGh5y/YGsfFb7yMDP6O89ADE44GLDiO05MFdqHGR95SqN+kDKxd/1O0TeUTZEM0tfQrjgpAap27v+rY+nr/WR5uW/iZFnrAZUkJWrG4S1K5KPMECS9ruojbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=2MRlBsDw; arc=fail smtp.client-ip=40.107.130.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="2MRlBsDw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuqkKVhccaU2G6uaTxIfJmpecvfW4Lj9JZKZ6xhAAhg4hMjfsK50923VPxapTwb5wV6+5qNQRy+FQwX5E0RKB79xGGi74P1pbcUCtBb2Yxa6WkbPSPVLXecRQZ3REDbqv3buzqfAME5OzSuR+577dSAE3JxN0dfkFoB0i6pQbcBXDJSrE3MYMEaGvtpDaZfUXz1OWEq8F/pQ2nttTNK3Wcb1ANwDYgyi+ujsgpYxBvsuQnaBnPZjrfABmYs52DGp3FTJXcOzCWq7eN60hqVVdp5JcA9QbwmE5hJlEglYULHmQ5tBGee82d8Kic+fvJgEkQdWdpbGe+ytI2Ckf51MsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oY9m21V03SH8RPLTcaf+cNN5cTmPoGnfKQ17R+xJLA=;
 b=JULuqiTWuuhwKgXXnxZKvncMFOCx9ZJQ4p7/1q9wXYjt+RslFpCBT75Dqwh8BiBtmuZeVCPw+bmRyo9wjjwTr1aJLmys1eExBw11zqxr/4w4CHduyOBBTUEYICdjwMflTsvv0WTk6l6joo2zbrszs709FWbXAVNfHjTsWpqUG114MkX31/4aqWzjoOwX9bBNpi22adFtTVj5Y6xi4BP6WmbLcvobz27P4KKZvMSzIuJs5Ab/YvKKf4UDVgUbkadTQYD+AEr3IlWunqUYgxqgJvW4cnlkvee1kwk2WDkZZj2rV7/X9PgTJq6z5IIhvfpAZjXM5u2aSbojeiSNoUY3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oY9m21V03SH8RPLTcaf+cNN5cTmPoGnfKQ17R+xJLA=;
 b=2MRlBsDw1c0qOeFCtPxkpIQg5gLjsnNkR2R6+oySl/uRON7l5xRbdsg/+mtzVgW6QR4AE/EEgU0KpRtegwrKB4cjL5ImgknKxn7ycrBSo/GnP03VnGENNzN9iFctpisq3IMwA+w8j5ftfGFrLuNA+zEcgAFHIFd3bF+Auc2FipWqJehQwB9DnNHBaLYWB0RXcnNbDwUMLa7BIv7pK7pVSIbpm5wL1U88JysI8GmKNRmFlrdZa87LVaSM3BDEoIiyRdCqb6KJoyz/ygPeGkMD4NGjkqy+H2OiCvK2g3l7/eYKX5eo/B6v7uP5DCqo8qolPtIuWpqe8Z4OX4GR1MTCkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PA1PR06MB9752.eurprd06.prod.outlook.com (2603:10a6:102:446::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 09:38:49 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 09:38:49 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 29 Sep 2026 09:38:02 +0000
Subject: [PATCH v5 8/8] serial: max310x: don't transmit while an RS485
 reconfigure is pending
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-max310x-rs485-sw-delay-v5-8-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790674682; l=3940;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=u5YjLSThsAMjtPNVdGbu4Jh+ZaOZQ1xJywPF8YHFyBI=;
 b=zHReqll6P0cVoFUJ27a/Ropd3vqLU0w7xhCNiMbnI3rZLlZy683JOXqWbMIRAQNyzDqQh8Dng
 MquGRyP1YrJAF1Oe9uu+hFRvvqjFOzwzP13We2poMFgJ9xx5pbOGDgw
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
X-MS-Office365-Filtering-Correlation-Id: 1bd74b0b-ecbd-4279-9e55-08df1e0d60d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|366016|1800799024|38350700014|260925022911599003|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003|260925021311599003|6133799003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	dz9zie4/wiWq6fmGWIyOfscf/SdqfK+aKQwu7/K3JlftJ36IId5QKqkReMKESq+nKv41pA/piyci60D3hIRj87rkPLDzI/nPcY2AeXJ1EmJIHF+IRZ9ruK1Vr13/idqA9Mz5UdioJRIxzT/W69R7XTg3rSfpiFY0tUmsDn5tIY5UAbTj4tDihjC6DpocjRQPXXqYRX68eZTLOy8FVCGPmprWVbD3uWgPyDIp8uEANO6CraacoyCFk9hdOa+dydYbCYksLtKbqjpBaboaKapPpUDDRppc8JRmtEiMPdNcTDMzsTU64oZYD8t7ttiGDda6N2HDNfiiCZJHqGvkIHrFjV+aewY04yYbQ90+MG7syS+7kuwoYMatNTwUf9ZBg2XZFIOgJeJfOqvwtkrUhl1625PPiUyuLKJO0SO4fxMSdc4mjbnW4kkzLJP9xkqqOUG+Ma7odcfvI9xdcy0Nluv61IsR/w+IoM+y9AKgKJL7FSgL/lNXa4iRef1AD7UD+JJEMtY3DCS/Oy+7E+CYMyUyzaaRdA9x7uAHTf4AdyCJbwRE4/eDQSMwlD33QwcqOuMG5Q8tq5mnuoIApjpvIdl8lLUWQLHvzdTnfi5P8Zw85spkaS+sa0b7w7YLbp2rnF8Rnb1+7SyZ4blTaTX7Yi5Ep+TAay1r4dPjQiIF4ET4/ycyWG8ToSSpIAr/LIdZtDyviyOPXsrmnzBPpkTxuiAx9Oz4FWsIMytvgDOO96u6pfk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(38350700014)(260925022911599003)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003)(260925021311599003)(6133799003)(260925021911599003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDE3WU9pYXA2MjYvWVljMlJ4eVdNQlNsbmVVbGFIUk5FNXoycm9HUlVodmdq?=
 =?utf-8?B?NkdteEg2WWZVMU5DNGVEVjd4WDhkbjhRdkpPYXBiU0kvWnNrUkpjVUk1aEty?=
 =?utf-8?B?YWdRQm9ERU1pOUphVWtGZTFJUVArNHg4ZjQ4Um5Wbzh0UkVJa0tORzlBUTln?=
 =?utf-8?B?dU8yRTBKT0dUb1J2bUtQMERVY2JUVXlNN3dVeHQxVHZObW9tRnQzZjdEZitR?=
 =?utf-8?B?L1FFTlBEanExaWVPMnE1RklrV2VSYm1nbWJxaHFaK0x0aXJWdzIyUXFOZFZE?=
 =?utf-8?B?RVk0VE52TkpOdzFYYzREU1ZzMWw2S3A4SG42OVBPMnM1NXpkcEQ0WTFVSGls?=
 =?utf-8?B?blE3VFNEM0RNdWJmUGF6SUhmNkppSlcyT3pUem51QzEzN1JiNHBaL3c0Y0Mr?=
 =?utf-8?B?d2dDWTJFVjRTYnF6bmJFdUduUjJUZC9QbXZGKzNmTnlBeUxYUmRoZFFQbXUv?=
 =?utf-8?B?T095NEYxVldiR0IrY3d6azB1SWRSRFpBYVhYWGpySVVpTnpWVHZmdm04Nmhu?=
 =?utf-8?B?U0RkOU5zM1lxR3JSZ3AxU3hPSE1mQmtQNVZoQTROY0lnYi9uYzY2RU5IdGcw?=
 =?utf-8?B?VWtDWkxUQ3FqR2dyUjhZZnN4UTVsb1RMOFY5SWR0aEQyQVpBQU9mUy9DVVA1?=
 =?utf-8?B?eUNkNTBsWWxWWEplNUkwK2htTXBBWldYbDZkUzNWTS9kenZWN3pXVEdKdFdm?=
 =?utf-8?B?OExpZExVTWpyZVZKeDdQNGNkWTFJaStPeFBwcFpkbXp6em0zd2xJdlVOTHJl?=
 =?utf-8?B?a1V4eWVTdi92eXFrTXYrMklNTWtEaTBMYjE3VE5XUnRQdzFncVpHWlNaZ21i?=
 =?utf-8?B?b2J0dmlmc3NTNVhEU0ZvcmF4WjRyWUZwSkxzbjcwakRWbGgxM0tWdVJvaWh5?=
 =?utf-8?B?akUzZ24wVFVFYUxsZEZYUC8rVWtQL2hWZmllU0FvVFBiOG5lL09DUkNpOTQ0?=
 =?utf-8?B?VjFIbFhRL2t6UHhwS2haeEpRVk5YeWw2VHEzM1lvaHR2YVh2L1cyNFZNZ1pU?=
 =?utf-8?B?WUhuQnc2OXlqTk9qdEdQblU1MG9DWXdlbVluaEtpd3AzcDRtVHd1SFBEVjdB?=
 =?utf-8?B?VXhkV203RVNLaHZlRWF6dHM4dVZCb0lOeGVnZG9kT0dRRmhCbjFJajArU1Zl?=
 =?utf-8?B?bmxRRW1zMG9oTXpCMkkvVCtsWDdYTXFRTnVZL3Vxb2hjTHZOQkZJL3Q0RFMz?=
 =?utf-8?B?V2JCRnZnd2JxRWEwVEErK0VLMGsrZnBqN2NUSUw3UmI5NXRhL0h2ajdhd0cw?=
 =?utf-8?B?RmxKM0NhMDEwSWdYZ2FjVmFVUTk5bkE1cnFSdjJISG9KTHVGa0NmMmxxLzRt?=
 =?utf-8?B?MjdSb1NPalREcnpZQno1ZUxyY0lhVmlIZzZta2hqMHpwNkpHWm9WQ0hQenZS?=
 =?utf-8?B?U3p2VEdoVExhbTJkMGRNSzN5cHRlYkxWQ1VWdzJ5N0NCdXNNcTBKVVVyTmJD?=
 =?utf-8?B?YmZtUnlJb3E2VUppV2NidFBmVWVOMzBQMmkwSWZJUk5qZHliNkpwVjQ5T2NT?=
 =?utf-8?B?cXRRU1c5N0wwZFJEckFyRTllV2F2N1M5QllOdVEzSnpDd3Y2bWM3b2l1eS9V?=
 =?utf-8?B?UWFDd25qY24zTzBUVHhDclZzLzFTb2lUUElES1lvUGd6cUxzdER2UnYvUUE1?=
 =?utf-8?B?TWs4OE1NaXVEWGdMaTBxQUQvWU81UWpCQUFaOVZGNUpzelBlZm9BSVE1YkVX?=
 =?utf-8?B?SFAxZ1VXMW43MnB2UkxrSXFTQlNNVTh4eG1GWWZJY3pXVVVRZmRXMlVJV3Y5?=
 =?utf-8?B?Unh4Um81VVhCcXYzdmtHcDNJbTEvdVFJQUdhRjNPbkV0dEFubXNDMjdHQ3dv?=
 =?utf-8?B?bE1uSEhhSXllMzBIMmZGOHlxdGFCZk1zWVUvSW45MWpSZjhWdElIVUxUVGd5?=
 =?utf-8?B?b0h2TlJLbFJ4dVA0MFhRRWFlVVcxK2ZaMzdjZlUwUmNrY0RPbjZWSVFCTWY1?=
 =?utf-8?B?UjZlRDd3WUt0MXZObFRQbE9QMG9TMmZXcGpCY055WkRaeGpmb0dVeFJFa3Rw?=
 =?utf-8?B?U3p5alQ1OUhWZzc0QmFvMmZjMDYvZkNzcVRsU3ZCck1GSE5WeUhRVE5LQVYr?=
 =?utf-8?B?T1VEKzFOOW9zYlBnRm9HeWxpS1hBdnFUL2tPckU0OVIzMHVjU0pMWTJISDJo?=
 =?utf-8?B?bnR3MUhaZ25XR3lSMXhkV2hOSEIyU2VBQ2hJL0VDbG9CdWhJMWQ1bDQxMFFo?=
 =?utf-8?B?ZGYvZkNPc3VCVUd4Rlo4TmkvWUx6ZGVhVUo2RDhHQk0yVlBweGRneHlLRUhW?=
 =?utf-8?B?V2lnUGdLNEJOR09TQ2U5WDJXbUhXYXEzNnRaZEZzUlcvME83RVJXUE95aEFC?=
 =?utf-8?B?TllwK2lCUVI2VGF0ektLSlNQaGNBWHNKdzBvUXd1MVloNlBsNGRJYjk1Nm16?=
 =?utf-8?Q?2jlqCJFNMsFSBh88=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd74b0b-ecbd-4279-9e55-08df1e0d60d2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:38:11.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfp+DVzUHIWogogf2gqcy38rJvLxBikmy18zy6dZfKJQZe/MuJ/3pGr/uVq/l6/y3QhXOzrLYZWJ/2oVkYkYVLOy9tmcZdyi2YbBlq/Gdns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9752

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

Fixes: 5bdb48b501e8 ("serial: max310x: Fix RS485 handling")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 6ad27eb8a32586ec5719773e6eadf1249155bf19..7036710942a42ef096340a38a9cee87cb0c4efbf 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -319,6 +319,7 @@ struct max310x_one {
 	bool			sw_rts_during_tx;
 	bool			cancel_tx_delay_tmr;
 	bool			tx_teardown;	/* envelope being torn down */
+	bool			rs485_pending;	/* rs_work not yet applied */
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 	enum max310x_tx_state	tx_state;
 
@@ -965,6 +966,16 @@ static void max310x_start_tx(struct uart_port *port)
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
@@ -1395,6 +1406,16 @@ static void max310x_rs_proc(struct work_struct *ws)
 
 	max310x_port_update(&one->port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
+
+	/*
+	 * The configuration is applied: release any TX that start_tx()
+	 * deferred while the reconfigure was pending, now on the right path.
+	 */
+	scoped_guard(spinlock_irqsave, &one->port.lock) {
+		one->rs485_pending = false;
+		if (!kfifo_is_empty(&one->port.state->port.xmit_fifo))
+			max310x_start_tx(&one->port);
+	}
 }
 
 /* called with port.lock taken and irqs off */
@@ -1420,17 +1441,11 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
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

