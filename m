Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023131.outbound.protection.outlook.com [40.107.162.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C594F30DA;
	Tue, 29 Sep 2026 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674754; cv=fail; b=GPin6OQqgHixcXcttkle/adx3tT7QYDhM8q5wLTvjHQiKPondNPm6rndz5U7O3QlhDLEJYs6K7vDCGzYFDXFGzVFg9YTS/ag0dyStWgK0AYSyP82PE+ewoPrENdmS5Wv86izgyaMaguf/ZapiN42tFnjNQRzCjeE7iyoy/aPEfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674754; c=relaxed/simple;
	bh=agqVedhpLL0zbEa2x3Ze8F0t4wuYqNrqiU6AEOn8LXo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aYeoxAIVWCzve3Y2YAnkv3kEcc4qPEmATYxw6GOeT3aC1jBrSItNBeXpL/crobHZjWuA41Vu304ZFchUvx2O6rXYakAZ8GWUrTGhk9LDtQ4WnpW4/fqXQEvXOKeHmnnCY7xVHQl0gDzch6JYT0TExcVZAp52xQs57E20XygRYac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=fS+lD3uy; arc=fail smtp.client-ip=40.107.162.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="fS+lD3uy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdQmg6L2VZ9WgPUWds6j3HPkHBWNtl3ajHshZXX8dB8DiwRizoymqoWTLeSf/PLFYHS30Vb1wE4/fRZtF2YVyTxv5nLa0Xbt+myb2NruZYTtaxkAZDhAdzQwKwgd0+/8Z3uJ0z244aFn2Vl3v8ALL5ZRA8RxPQEAyVW03v2m27FdWeKkJ7WbNCFT5ooSHsTcepb/UUqY68DzaSgK17fXPLvfjnSHE6Xqw0j/OdytvB9cj7NHphD1Hf/vwV7YIcFQT6d/xj0aJcmTIrhC4aVy0PELiBGthF6a6GazNK9gxCWsC2BThbI1UyfdKXZ+APxVB62cIyqC94HZpi5X6nIrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEqq40DwX+k3sqf4M5+ChndEoNZKldk7THFQoNoaB2E=;
 b=vl837UEY7lT0PpTSrnaVsRXT+C3s3A2RyoMlr1r2Eq6vkNH4k6mXWcGuuQ5LnKJrsiUpivMiUCU+WYDgmHIkDWpcshawOpsZoWMza4PnG04o7H3qXFKXPGBAwD6++a4pQID8h2UHatnoj1bQ7VAZf0f4Fuo3utsFowJDl5ZRCrvCT/3msMVBMOUFdHARBZyaVp+PZdQEvdTbbvtjimjyBv8gHQt8NIC2NlV0irgR8+49f9BPmrFr7fRgI4QpPF7Tt8E29KvORqUWqyD+zgjzjD8Yf1AUj6I0kt7NW8XtoGRIEyfTvd8QrQwMgG20ekfaNRF+QDrVR4gVWvFYk+FhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEqq40DwX+k3sqf4M5+ChndEoNZKldk7THFQoNoaB2E=;
 b=fS+lD3uyEsWRWyK3ApPcoG5sHN94HQolWhKW08Psw5afUBX3XoCBjoO+MFOFCSigBbCf3Pga+7fockCyF8y4lpmtVtmzjvcBHF2KKFJzSsFRkeZUXG2Ru2l8KC73/QlSlt+CjDjj1xixAwUcrGncGN9C70p/h8G7McegP8tRrKFrofV8Rjg4U+n1hYtSet6JrPw/CQ8VOypZaeJZ0untHF+dhksd4ubDO2lm5lNSd7OPrOt0wPiyekS3PedRlABZ2a4UcfObMtt8jODBNaDVo+oPS7AE8IZyTrrsjqyt47eMPOXFi2WMc2fw01r0gOaGvJHyGbjZLBSGQdgYNCDQbw==
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
Date: Tue, 29 Sep 2026 09:38:01 +0000
Subject: [PATCH v5 7/8] serial: max310x: drive RTS in software when
 hardware delays are too short
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-max310x-rs485-sw-delay-v5-7-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790674682; l=23190;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=agqVedhpLL0zbEa2x3Ze8F0t4wuYqNrqiU6AEOn8LXo=;
 b=EwglyHx2qW686CurGwuqLhB7b3tyw7vnujIiEiEF4KgMfXcPc/SkOw5cS5oDHQ0VgkPU2apkH
 D1k748tAWVBDmExMDQQ9VLQsPkBmmRZ3pXNJG4lPaTDTMCZWou7aDMv
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
X-MS-Office365-Filtering-Correlation-Id: f54b95ea-1028-4ce2-4bd9-08df1e0d6002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|366016|1800799024|38350700014|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZELWAnKACVAq7BYfUb8ZOdDyF8dijKwAIxIbzkOciyAlT6EWrRA04fVMJBEaX84QwRf8p82T5m5JPvnmU73Bg2t0s7I86b3a8ANwfj66Akc9lZxb2mdyvXgIbitEQH8EjPtTNBkYn1WGAr5Wxfo5kwurf5nCeHI9HXQgd6LLAE9sQMmIi4Ii8UZQPhbZ7tkT9pJJjJffFEzbQFTt0JwtqJwwbo0Z1p3zBa5F+MFAlnzxR8LsszntxL8L4yU/0pBV6JWLNsf6CyFa5VrC7P/LenQAGxvY3Zcmncpm/3Vu8dwy/+Cq4QSR8vZimx8pVAnN/r6a06Wczzv2rt31ELbyiTXAvMdXayX2Ui96qLgPEq6DdDbqx/dt4CD4NBIWCq6wB8dD1xq8rH+YtTCoKeTPxljDLpUHWsKE3crvm2rlUSUcZ3/yj/3wX/g0Ipx6+t25iWgKCphNNyhct/Tpx5xIVDV3xOt4EXGXC2HBlOrVKOeoMpnHOQK0XUKUI71wiNQGjOFca3r/puzoileX/CvTAVXyptrEoB6I47YFD1BsDhb/ud06YVJ+yjAqWAxIlc5W+8Syhe8mUkljc7vbMqjik/1UX93UCLE40k82MNJfVPwPh8C+QPoDJq6//z5dCQN8Kr4q38NPzscL4NnMrDy4TmFvN/33m00oOl5t6Rm8C07x/qos825kwfwl3+QRVUlwoATcOSBLSjVZtHaHeoJVVQzO/1fuceI3Mi9RzrwKy+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(38350700014)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTJnQm9GQU9TeDBiSlBSTWhnM1QwOUpVSWlLRC85RDBVSWVzWEcyY2xIQSt1?=
 =?utf-8?B?TVU4VzI4MXFTSjlsU1dEVWdqOWRDamVvOGJKMmJNTFVONmdtMWxyRUMxV3F5?=
 =?utf-8?B?VGxhZ1IzQTBJRkhUZDBPY0lseFRGUlN6QVZhdm1seWN6QUxCd0FZS3dDbGpt?=
 =?utf-8?B?blR3MzgvSU5RWjU3S25zbkR1TW1LZnVyWmpnMW41Z283UnVBZ2wzRDZMUTlu?=
 =?utf-8?B?S1dOdWRYTjhySHE2YWhMRDNpSGdsdCtFS09LdmZzSStTaTU2SlZBcFRWbHEx?=
 =?utf-8?B?S1h4dUF4bndMQjdMNFFpNHF6RzRYYy93U3FRdmJmWlQrSlBlVXVaVDc4d3Qx?=
 =?utf-8?B?QmlRNGYxWFE2L2EzQnZYdzFmYk5HSHdaaWhCby82WDBxRWFSdStjVG1HbGhn?=
 =?utf-8?B?SXU4ajk2SWdhaUt1NUpsSmZRL0JrbW1LcXhidXhLNlE5M1U4NUxNdVd0Ym5E?=
 =?utf-8?B?b1R2WkJhenN6NVA4OFRWcVg3TkJvbnZGNE9aK1REc0pCbjZURDZTUWZFdTcv?=
 =?utf-8?B?bGhtZWE2TW9KVnVsZnFOT1JiVmhyMVBGVWgydUtjREQ4cmE0eHI0Y09zM2tX?=
 =?utf-8?B?VVMwZ2NMeG1sZUpTeEYzbjVwOUpDSytTTlUxWnJ6S2hwbVZqNU9kbkN1UTJK?=
 =?utf-8?B?ZGNBN3UxUDd3UmI5c3lJRTBaMEp2QVo0cEUzUjY3cmlweFkrT3F2NTRIeVVT?=
 =?utf-8?B?TlhwM1JFZ2JMOWU4Q3RZcGxVNWFWOVE5NnQ0WXhpbWFhNE5GOVN4QUthL1FL?=
 =?utf-8?B?eEcvNUtkdDNwS0RJYkRZejNsWFlZaTRkZEtNRUVDOUo3T09lY0NLYXNiOUx1?=
 =?utf-8?B?WWJYTDRmRW5wSkhBTTZnbFIyZ0dkMXhXK0pMU2lJYWRrbWxFa21pTXpaR1Mv?=
 =?utf-8?B?UTR6NlF2Y3E5Y2FZVUY1SzNuVlBsV1pjZ2VlLzR0U0JNVE0yOG50MVMwVnFr?=
 =?utf-8?B?VWN6eGdBK0R4MWM5WGNpUzY1RXRPeWV3L25KTGQzd3huWWJRRDZuL1RFTkRv?=
 =?utf-8?B?bHNjM0lxNG1aRXB0eEM1TVZISGwzSkl1WkZTYmZmUzdjMUJBeDhITjlLTFpM?=
 =?utf-8?B?Q09GcUhnM09XMzQ5cVo3dEZ5anRjTFR6N0tsYUpOMFBOUUR4NWpZcG5yazRz?=
 =?utf-8?B?Zm5PV09KM1p5ano2ZU9hN2pCMXV4c3lxbFVVMGx2dG9qSzNyZzdadkZTeUhj?=
 =?utf-8?B?b0g4R1VkcEZMZHpvdlFSNTl0Z08wZk56TWlaWTE4NS9Fd1FvWXovdGg4ZXpB?=
 =?utf-8?B?TXB1aWthOEpUZjIzdFEwdS9WWG5wNXdMZFZQOUtHYTNEMlVZRC9ZbUVEbDVu?=
 =?utf-8?B?L0J6NmJyL1B5cWUxLzdFSU9sa0Z0a2ZxSTBaK2VVMDNURmdOU0YzMWFlNW9p?=
 =?utf-8?B?OEJ1MTJoNnVrWXRWQXlERWFCbTJ2a3JIeUZGbHUwckpTL2tSMXdlWDUzLzdY?=
 =?utf-8?B?TkJGYStaeGhIa2lLWnNiTDBnb3psbFZuZ2oyL3dYeDQxZlZlSmFZRzNnVll5?=
 =?utf-8?B?ZUFLYmw5a1RHekQySlRoS1luZEltNGxoZEtaMkJWMTlzbUtDYlk1VEl1RGlL?=
 =?utf-8?B?UnFnb2swTUNWc3MvNWR5Q0QvSTJHOVo2UURUb290QTlxK0pRM0FLODA1a0tN?=
 =?utf-8?B?TXNsdEJDQkNqOEZ1NWU1RnppaCtUT25LeXVJZVBQRktXUDFPNEg4eWsvVy9E?=
 =?utf-8?B?ZlhCQ3NNaG5EY3Q0c2RYRWRJd2Ryam5Jc2pid25mc3A5NE84WTdzVXlxc0JS?=
 =?utf-8?B?UjRCOTNFRmI2QzhDckZmRUtFdHBXaStlTllTSHNPemVudEo3ZzcyVVFsYThz?=
 =?utf-8?B?cy9HS1hFZExZcGl3elFzYnBmSmhmQi8vWEQ5OGRpZExrVmlheW5iVWRCWm1O?=
 =?utf-8?B?M1pQL1VCVWVBV01uUmVFVExVZURleVVYS1I3K2FSN2Z5QlJIM2FHVzZ6b1V0?=
 =?utf-8?B?M04vdllnNFl1Z3VFMUR1WVFiOFRySk41d0lJWmw0bG0zenBZS1VIcXJzNVZI?=
 =?utf-8?B?VVVrQ2NMS3poY1kwRUQvVERNY25BalArb1dwMUxBOVNLN3hueWoxbTNQWWcr?=
 =?utf-8?B?eGtoOE1KUzl3bUo5S0RSd29Od3RQWlNGNERMbk1LZEZkdWYzY2lLZEwrVUZo?=
 =?utf-8?B?bUxJbGFSTXBndVp0VWMva3FKWmJaQnFlTEpMblU3eC9LQXU1aGxBYXI4VmJW?=
 =?utf-8?B?bzlHQVp5S0pRZE9oaitxUXEvRHFsRnZaQ3oxbng4SzBxUXFOUFdyNTZUZThC?=
 =?utf-8?B?U1pMcGNta0xscEo2UTV5Q0ZBcVc1N1cwL0ZKcWg2MHdZVmttKzNDbXFEVEZ4?=
 =?utf-8?B?SGJtNG1hYit1TkI5Rk04T1FINlFCcUc0L3I1Nm5OYWR3dGlsK3h4ZTltN21n?=
 =?utf-8?Q?ZZBscIEaDZd39s/w=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54b95ea-1028-4ce2-4bd9-08df1e0d6002
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:38:10.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1ZBFe2turw3ovw6x8vWacCFGmYs6YAmdBd1qICEQ5+I+YYYY40PRjrFl//PzL6JvXPS2zmZczenb+LraTjkjyVP9XMQD/PpbdtoHoT92kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9752

The chip's auto-RTS path can express at most 15 bit-times of RTS setup
and hold delay - a fraction of a millisecond at typical baud rates -
while the uapi expresses the delays in milliseconds up to the UART
core's RS485_MAX_RTS_DELAY. Requests beyond the field were rejected
with -ERANGE, which makes the core silently wipe port->rs485 and
disable RS485; a device tree asking for a 20 ms setup delay ends up
with no RS485 at all and an unusable bus.

Add a software-driven RTS path that takes over whenever the hardware
cannot represent the requested timing, and clamp the delays to
RS485_MAX_RTS_DELAY instead of rejecting them.

max310x_set_rts_ctl_params() picks the path: software if either delay
exceeds what 15 bit-times encode at the current baud rate, or if the
requested RTS polarity combination cannot be produced by the auto-RTS
engine; hardware otherwise, as before.

On the software path the RTS envelope is driven by a single hrtimer,
re-used for the before- and after-send phases (tracked in tx_state),
plus a single rts_work that toggles RTS. start_tx() begins the
envelope; rts_work asserts RTS and only then arms the before-send
timer, so data is never shifted before RTS is on the wire. The timer
expiry kicks tx_work; once the chip FIFO drains, the same timer is
re-armed for one character (the byte still in the shift register)
plus the after-send delay, after which rts_work releases RTS. One
timer and one work keep the phases mutually exclusive and the RTS
toggles ordered.

Teardown is interlocked: shutdown() and an RS485-disabling
TIOCSRS485 set tx_teardown under port->lock before cancelling the
timer and works, and start_tx() checks it on entry and again after
the hrtimer_try_to_cancel(-1) path retakes the dropped lock -
otherwise a write racing the teardown could re-arm the timer or
queue rts_work against a port being shut down, leaving the
transceiver driving the bus after close. The rs485-disable path
additionally kicks tx_work afterwards, since a racing write may have
queued data with no envelope left to pump it, and shutdown() now also
cancels tx_work, which was previously cancelled only in remove().

set_rts_ctl_params() publishes sw_rts_during_tx with a single store
and settles the RTS idle level only while tx_state is off, because
serial_core calls set_termios() without port->lock and rs485_config()
schedules a reconfigure on every TIOCSRS485 - either could otherwise
release the transceiver mid-envelope. The settle also re-checks
tx_state after its write and requeues rts_work if an envelope started
meanwhile: the state read and the register write are not atomic, and
rts_work re-derives the level from tx_state, so this converges without
locking. shutdown() waits out an
in-flight envelope (bounded) before powering down, and cancels the
timer and works unconditionally: a TIOCSRS485 can clear
sw_rts_during_tx while an envelope is still in flight, and neither
may outlive the port. break_ctl() on the software path applies the
configured RTS polarity itself.

Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 386 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 341 insertions(+), 45 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 8f8817b127c891f18af52bd3d24efb269db78211..6ad27eb8a32586ec5719773e6eadf1249155bf19 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
+#include <linux/hrtimer.h>
 #include <linux/i2c.h>
 #include <linux/kconfig.h>
 #include <linux/module.h>
@@ -297,15 +298,29 @@ struct max310x_devtype {
 	u8	power_bit; /* Bit for sleep or power-off mode (active high). */
 };
 
+/* Software-timed RS485 RTS envelope phase */
+enum max310x_tx_state {
+	MAX310X_TX_OFF,			/* idle, RTS released */
+	MAX310X_TX_WAIT_BEFORE_SEND,	/* RTS asserted, before-send delay */
+	MAX310X_TX_SEND,		/* data in flight, awaiting TX-empty */
+	MAX310X_TX_WAIT_AFTER_SEND,	/* data drained, after-send hold */
+};
+
 struct max310x_one {
 	struct uart_port	port;
 	struct work_struct	tx_work;
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
+	struct work_struct	rts_work;
+	struct hrtimer		tx_delay_tmr;
 	struct regmap		*regmap;
 	unsigned int		one_char_duration_us;
 	unsigned int		baud;
+	bool			sw_rts_during_tx;
+	bool			cancel_tx_delay_tmr;
+	bool			tx_teardown;	/* envelope being torn down */
 	bool			tx_break;	/* break_ctl() owns the transceiver */
+	enum max310x_tx_state	tx_state;
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
@@ -696,6 +711,36 @@ static void max310x_rts_ctl(struct uart_port *port, bool rts_state)
 			    rts_state ? MAX310X_LCR_RTS_BIT : 0);
 }
 
+/* RTS level for the transmitting or the idle phase of an RS485 envelope */
+static bool max310x_rts_level(struct uart_port *port, bool active)
+{
+	return active ? (port->rs485.flags & SER_RS485_RTS_ON_SEND) :
+			(port->rs485.flags & SER_RS485_RTS_AFTER_SEND);
+}
+
+/*
+ * Drive the RS485 RTS line to match the current tx_state. This is the only
+ * place that touches RTS, and it reads tx_state rather than a fixed
+ * assert/deassert intent, so a newer assert is never clobbered by a stale
+ * release. It also arms the before-send timer once the RTS edge is on the wire,
+ * so data is never shifted before RTS is asserted.
+ */
+static void max310x_rts_work_proc(struct work_struct *ws)
+{
+	struct max310x_one *one = container_of(ws, struct max310x_one, rts_work);
+	struct uart_port *port = &one->port;
+	bool rts_on = READ_ONCE(one->tx_state) != MAX310X_TX_OFF;
+
+	max310x_rts_ctl(port, max310x_rts_level(port, rts_on));
+
+	guard(spinlock_irqsave)(&port->lock);
+	if (READ_ONCE(one->tx_state) == MAX310X_TX_WAIT_BEFORE_SEND &&
+	    !one->cancel_tx_delay_tmr && !hrtimer_active(&one->tx_delay_tmr))
+		hrtimer_start(&one->tx_delay_tmr,
+			      ms_to_ktime(port->rs485.delay_rts_before_send),
+			      HRTIMER_MODE_REL);
+}
+
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 {
 	struct max310x_one *one = to_max310x_port(port);
@@ -792,6 +837,68 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static enum hrtimer_restart max310x_tmr_tx(struct hrtimer *timer)
+{
+	struct max310x_one *one = container_of(timer, struct max310x_one,
+					       tx_delay_tmr);
+
+	guard(spinlock_irqsave)(&one->port.lock);
+	if (!one->cancel_tx_delay_tmr) {
+		if (READ_ONCE(one->tx_state) == MAX310X_TX_WAIT_AFTER_SEND) {
+			/* After-send hold elapsed: drop RTS via the rts worker. */
+			WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+			schedule_work(&one->rts_work);
+		} else {
+			WRITE_ONCE(one->tx_state, MAX310X_TX_SEND);
+			schedule_work(&one->tx_work);
+		}
+	}
+
+	return HRTIMER_NORESTART;
+}
+
+static void max310x_delayed_stop_tx(struct uart_port *port)
+{
+	struct max310x_one *one = to_max310x_port(port);
+	unsigned int txlvl;
+
+	if (READ_ONCE(one->tx_state) == MAX310X_TX_OFF)
+		return;
+
+	/*
+	 * The kfifo can be empty while the chip TX FIFO is still draining, so arm
+	 * the after-send hold only once the chip FIFO is empty too - the TX-empty
+	 * interrupt re-invokes us then. Otherwise the hold starts early and RTS
+	 * drops mid-character, clipping the last byte(s).
+	 */
+	txlvl = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
+	if (txlvl)
+		return;
+
+	/*
+	 * Runs from tx_work without port->lock, so re-check the state under it:
+	 * shutdown() may have cancelled the envelope meanwhile. Only
+	 * MAX310X_TX_SEND may arm the hold.
+	 */
+	guard(spinlock_irqsave)(&one->port.lock);
+	if (one->cancel_tx_delay_tmr ||
+	    READ_ONCE(one->tx_state) != MAX310X_TX_SEND)
+		return;
+
+	if (!hrtimer_active(&one->tx_delay_tmr)) {
+		/*
+		 * Add one character for the byte still in the shift register -
+		 * TX-empty fires as it enters, not as it leaves.
+		 */
+		ktime_t delay = us_to_ktime(one->one_char_duration_us +
+					    port->rs485.delay_rts_after_send *
+					    USEC_PER_MSEC);
+
+		WRITE_ONCE(one->tx_state, MAX310X_TX_WAIT_AFTER_SEND);
+		hrtimer_start(&one->tx_delay_tmr, delay, HRTIMER_MODE_REL);
+	}
+}
+
 static void max310x_handle_tx(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
@@ -803,8 +910,13 @@ static void max310x_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
+	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
+		struct max310x_one *one = to_max310x_port(port);
+
+		if (READ_ONCE(one->sw_rts_during_tx))
+			max310x_delayed_stop_tx(port);
 		return;
+	}
 
 	/*
 	 * It's a circ buffer -- wrap around.
@@ -829,11 +941,58 @@ static void max310x_handle_tx(struct uart_port *port)
 		uart_write_wakeup(port);
 }
 
+/*
+ * Begin a software-timed RTS envelope: set the before-send phase and queue the
+ * rts worker to assert RTS. tx_state is set synchronously here (start_tx() holds
+ * port.lock) so close()/shutdown can see an envelope is in flight; rts_work then
+ * asserts RTS and arms the before-send timer (see there).
+ */
+static void max310x_delayed_start_tx(struct uart_port *port)
+{
+	struct max310x_one *one = to_max310x_port(port);
+
+	WRITE_ONCE(one->tx_state, MAX310X_TX_WAIT_BEFORE_SEND);
+	one->cancel_tx_delay_tmr = false;
+	schedule_work(&one->rts_work);
+}
+
+/* called with port.lock taken and irqs off */
 static void max310x_start_tx(struct uart_port *port)
 {
 	struct max310x_one *one = to_max310x_port(port);
 
-	schedule_work(&one->tx_work);
+	/* A teardown is in progress; nothing may start an envelope or TX. */
+	if (one->tx_teardown)
+		return;
+
+	if (READ_ONCE(one->sw_rts_during_tx)) {
+		/*
+		 * The before- and after-send phases share one delay timer. If an
+		 * after-send release is pending, cancel it before starting a new
+		 * TX so the just-asserted RTS is not yanked; re-arming the timer
+		 * for the before-send phase then supersedes the release.
+		 */
+		int res = 0;
+
+		if (READ_ONCE(one->tx_state) == MAX310X_TX_WAIT_AFTER_SEND)
+			res = hrtimer_try_to_cancel(&one->tx_delay_tmr);
+		if (unlikely(res == -1)) {
+			one->cancel_tx_delay_tmr = true;
+			uart_port_unlock(port);
+			hrtimer_cancel(&one->tx_delay_tmr);
+			uart_port_lock(port);
+			/*
+			 * The lock was dropped: a teardown may have run to
+			 * completion meanwhile. Re-check before starting.
+			 */
+			if (one->tx_teardown)
+				return;
+		}
+
+		max310x_delayed_start_tx(port);
+	} else {
+		schedule_work(&one->tx_work);
+	}
 }
 
 static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
@@ -946,36 +1105,50 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 }
 
 /*
- * Program the chip's RS485 RTS timing. The HDPIXDELAY setup and hold fields
- * count bit-times, four bits per direction, while the uapi expresses the
- * delays in milliseconds: convert at the current baud rate, rounding up, and
- * cap at the field maximum.
+ * Pick hardware or software RTS timing for the current port. The chip can
+ * deliver up to 15 bit-times of setup/hold delay via HDPIXDELAY; anything
+ * longer (or any RTS polarity the chip cannot produce automatically) must
+ * be driven by software via tx_delay_tmr and rts_work.
  */
 static void max310x_set_rts_ctl_params(struct max310x_one *one)
 {
 	const unsigned int max_bit_dly = 15;
 	struct uart_port *port = &one->port;
+	u64 max_hw_delay_ns = 0;
 	unsigned int setup = 0, hold = 0;
 	u8 mode1 = 0, irda = 0;
+	bool sw_rts = false;
 
-	if (port->rs485.flags & SER_RS485_ENABLED) {
-		/* Convert milliseconds to bit-times, rounding up. */
-		setup = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_before_send,
-				     MSEC_PER_SEC);
-		hold  = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_after_send,
-				     MSEC_PER_SEC);
-		setup = min(setup, max_bit_dly);
-		hold  = min(hold,  max_bit_dly);
-
-		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
-		/*
-		 * The auto-RTS engine asserts RTS high on send; for an
-		 * active-low RTS let IRDA.RTSINVERT invert the output stage.
-		 */
-		if (!(port->rs485.flags & SER_RS485_RTS_ON_SEND))
-			irda = MAX310X_IRDA_RTSINVERT_BIT;
+	if (!(port->rs485.flags & SER_RS485_ENABLED))
+		goto out;
+
+	if (one->baud)
+		max_hw_delay_ns = NSEC_PER_SEC / one->baud * max_bit_dly;
+
+	if ((u64)port->rs485.delay_rts_before_send * NSEC_PER_MSEC > max_hw_delay_ns ||
+	    (u64)port->rs485.delay_rts_after_send  * NSEC_PER_MSEC > max_hw_delay_ns ||
+	    !!(port->rs485.flags & SER_RS485_RTS_ON_SEND) ==
+	    !!(port->rs485.flags & SER_RS485_RTS_AFTER_SEND))
+		sw_rts = true;
+
+	if (sw_rts) {
+		setup = 0;
+		hold  = 0;
+		goto out;
 	}
 
+	/* Convert milliseconds to bit-times, rounding up. */
+	setup = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_before_send,
+			     MSEC_PER_SEC);
+	hold  = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_after_send,
+			     MSEC_PER_SEC);
+	setup = min(setup, max_bit_dly);
+	hold  = min(hold,  max_bit_dly);
+
+out:
+	/* Assign once; a transient false would be seen by other readers. */
+	WRITE_ONCE(one->sw_rts_during_tx, sw_rts);
+
 	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
 			   MAX310X_HDPIXDELAY_SETUP(setup) |
 			   MAX310X_HDPIXDELAY_HOLD(hold));
@@ -983,12 +1156,48 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
 	/*
 	 * A break owns the transceiver: break_ctl() disabled auto-RTS and
 	 * drives RTS manually, and restores it from the current
-	 * configuration when the break ends. Touching MODE1 here would
+	 * configuration when the break ends. Touching them here would
 	 * release the transceiver mid-break.
 	 */
 	if (one->tx_break)
 		return;
 
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		if (sw_rts) {
+			/*
+			 * Only settle RTS at idle when no transmission owns it.
+			 * A reconfigure while one is in flight - rs_work runs
+			 * on every TIOCSRS485 - would otherwise release the
+			 * transceiver mid-character.
+			 */
+			if (READ_ONCE(one->tx_state) == MAX310X_TX_OFF) {
+				max310x_rts_ctl(port,
+						max310x_rts_level(port, false));
+				/*
+				 * serial_core calls set_termios() without
+				 * port->lock, so an envelope may have started
+				 * while the idle level was written and the
+				 * settle can land after its RTS assert.
+				 * rts_work re-derives the level from
+				 * tx_state; requeue it to converge.
+				 */
+				if (READ_ONCE(one->tx_state) != MAX310X_TX_OFF)
+					schedule_work(&one->rts_work);
+			}
+		} else {
+			mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+			/*
+			 * The auto-RTS engine asserts RTS high on send; for an
+			 * active-low RTS let IRDA.RTSINVERT invert the output
+			 * stage.
+			 */
+			if (!(port->rs485.flags & SER_RS485_RTS_ON_SEND))
+				irda = MAX310X_IRDA_RTSINVERT_BIT;
+		}
+	} else {
+		max310x_rts_ctl(port, 0);
+	}
+
 	max310x_port_update(port, MAX310X_MODE1_REG,
 			    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
 	max310x_port_update(port, MAX310X_IRDA_REG,
@@ -1017,18 +1226,24 @@ static void max310x_break_ctl(struct uart_port *port, int break_state)
 	 * is driven as it is.
 	 */
 	if (break_state) {
-		max310x_port_update(port, MAX310X_MODE1_REG,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
-		max310x_rts_ctl(port, 1);
+		if (READ_ONCE(one->sw_rts_during_tx)) {
+			max310x_rts_ctl(port, max310x_rts_level(port, 1));
+		} else {
+			max310x_port_update(port, MAX310X_MODE1_REG,
+					    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
+			max310x_rts_ctl(port, 1);
+		}
 	} else {
 		/*
 		 * Reapply the current configuration: a reconfigure that
 		 * arrived during the break was deferred by the tx_break
-		 * guard. Then release the manual RTS - auto-RTS owns the
-		 * pin again.
+		 * guard. On the software path the helper also settles the
+		 * idle level; on the hardware path release the manual RTS -
+		 * auto-RTS owns the pin again.
 		 */
 		max310x_set_rts_ctl_params(one);
-		max310x_rts_ctl(port, 0);
+		if (!READ_ONCE(one->sw_rts_during_tx))
+			max310x_rts_ctl(port, 0);
 	}
 }
 
@@ -1071,9 +1286,10 @@ static void max310x_set_termios(struct uart_port *port,
 		lcr |= MAX310X_LCR_STOPLEN_BIT; /* 2 stops */
 
 	/*
-	 * Update LCR register. Leave the TX break bit alone: it is driven by
-	 * break_ctl(), and an absolute write here would end a break in
-	 * progress.
+	 * Update LCR register. Leave the TX break and RTS bits alone: they are
+	 * driven by break_ctl() and by the software-timed RS485 RTS, and an
+	 * absolute write here would end a break in progress or release the
+	 * transceiver mid-character.
 	 */
 	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TERMIOS_MASK, lcr);
 
@@ -1181,14 +1397,37 @@ static void max310x_rs_proc(struct work_struct *ws)
 			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
 }
 
+/* called with port.lock taken and irqs off */
 static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios,
 				struct serial_rs485 *rs485)
 {
 	struct max310x_one *one = to_max310x_port(port);
 
-	if ((rs485->delay_rts_before_send > 0x0f) ||
-	    (rs485->delay_rts_after_send > 0x0f))
-		return -ERANGE;
+	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
+	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send,  100U);
+
+	/*
+	 * Make sure no SW-timed RTS toggle survives an RS485 disable, even
+	 * if the delay timer happens to be running right now.
+	 */
+	if (!(rs485->flags & SER_RS485_ENABLED)) {
+		one->tx_teardown = true;
+		one->cancel_tx_delay_tmr = true;
+		if (hrtimer_try_to_cancel(&one->tx_delay_tmr) == -1) {
+			uart_port_unlock(port);
+			hrtimer_cancel(&one->tx_delay_tmr);
+			uart_port_lock(port);
+		}
+		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+		one->tx_teardown = false;
+		/*
+		 * The port stays alive, and a write that raced the teardown
+		 * may have left data queued with no envelope left to pump it.
+		 * Kick tx_work; RS485 is disabled, so the plain path is right.
+		 */
+		if (!kfifo_is_empty(&port->state->port.xmit_fifo))
+			schedule_work(&one->tx_work);
+	}
 
 	port->rs485 = *rs485;
 
@@ -1222,7 +1461,15 @@ static int max310x_startup(struct uart_port *port)
 	max310x_port_update(port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_FIFORST_BIT, 0);
 
-	/* Configure the RS485 RTS timing and the RS485/RS232 mode bits. */
+	one->tx_teardown = false;
+
+	/*
+	 * Configure the RS485 RTS timing (HW auto-RTS vs software-driven) and
+	 * the RS485/RS232 mode bits. Don't hardcode HW auto-RTS here - let
+	 * max310x_set_rts_ctl_params() pick HW or SW per the configured
+	 * delays, otherwise the chip's auto-RTS would override the software
+	 * RTS hold and the after-send delay is lost.
+	 */
 	max310x_set_rts_ctl_params(one);
 
 	if (port->rs485.flags & SER_RS485_ENABLED &&
@@ -1252,22 +1499,64 @@ static int max310x_startup(struct uart_port *port)
 static void max310x_shutdown(struct uart_port *port)
 {
 	struct max310x_one *one = to_max310x_port(port);
-	unsigned int loops = port->fifosize + 1;
+
+	if (READ_ONCE(one->sw_rts_during_tx)) {
+		/*
+		 * Drain any in-flight software-timed RTS envelope before the
+		 * port is powered down, so the last character and its
+		 * after-send hold complete - close() can reach shutdown with
+		 * data still queued and a before-send delay pending. The loop
+		 * ends when the envelope does (tx_state == OFF); the bound is
+		 * just a worst-case safety cap.
+		 */
+		unsigned int loops = port->rs485.delay_rts_before_send +
+			port->rs485.delay_rts_after_send +
+			DIV_ROUND_UP_ULL((u64)(kfifo_len(&port->state->port.xmit_fifo) +
+					       port->fifosize) *
+					 one->one_char_duration_us,
+					 USEC_PER_MSEC);
+
+		while (READ_ONCE(one->tx_state) != MAX310X_TX_OFF && loops-- > 0)
+			fsleep(USEC_PER_MSEC);
+	} else {
+		/*
+		 * The tty layer waits for tx_empty() before close(), but
+		 * tx_empty() only reflects the chip TX FIFO - the last
+		 * character may still be in the transmit shift register. Let
+		 * the FIFO drain and the final character clock out before the
+		 * port is powered down, otherwise close() truncates the last
+		 * byte on the wire.
+		 */
+		unsigned int loops = port->fifosize + 1;
+
+		while (!max310x_tx_empty(port) && loops-- > 0)
+			fsleep(one->one_char_duration_us);
+		fsleep(one->one_char_duration_us);
+	}
 
 	/*
-	 * The tty layer waits for tx_empty() before close(), but tx_empty()
-	 * only reflects the chip TX FIFO - the last character may still be in
-	 * the transmit shift register. Let the FIFO drain and the final
-	 * character clock out before the port is powered down, otherwise
-	 * close() truncates the last byte on the wire.
+	 * Set the teardown interlock under port->lock, so a concurrent
+	 * start_tx() either sees it or happens-before the cancellations
+	 * below. Then cancel unconditionally: the SW/HW decision is
+	 * recomputed on every reconfigure, so a TIOCSRS485 can clear
+	 * sw_rts_during_tx while an envelope is still in flight, and
+	 * neither the timer nor the works may outlive the port.
 	 */
-	while (!max310x_tx_empty(port) && loops-- > 0)
-		fsleep(one->one_char_duration_us);
-	fsleep(one->one_char_duration_us);
+	scoped_guard(spinlock_irqsave, &port->lock) {
+		one->tx_teardown = true;
+		one->cancel_tx_delay_tmr = true;
+	}
+	cancel_work_sync(&one->tx_work);
+	hrtimer_cancel(&one->tx_delay_tmr);
+	cancel_work_sync(&one->rts_work);
+	WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
 
 	/* Disable all interrupts */
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 
+	if (READ_ONCE(one->sw_rts_during_tx))
+		max310x_rts_ctl(port, max310x_rts_level(port, false));
+
 	max310x_power(port, 0);
 }
 
@@ -1557,6 +1846,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
 		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
+		/* Initialize queue for software-driven RTS toggling */
+		INIT_WORK(&s->p[i].rts_work, max310x_rts_work_proc);
+		hrtimer_setup(&s->p[i].tx_delay_tmr, max310x_tmr_tx,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		s->p[i].tx_state = MAX310X_TX_OFF;
 	}
 
 #ifdef CONFIG_GPIOLIB
@@ -1667,6 +1961,8 @@ static void max310x_remove(struct device *dev)
 	int i;
 
 	for (i = 0; i < s->devtype->nr; i++) {
+		hrtimer_cancel(&s->p[i].tx_delay_tmr);
+		cancel_work_sync(&s->p[i].rts_work);
 		cancel_work_sync(&s->p[i].tx_work);
 		cancel_work_sync(&s->p[i].md_work);
 		cancel_work_sync(&s->p[i].rs_work);

-- 
2.47.3

