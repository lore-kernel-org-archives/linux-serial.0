Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022072.outbound.protection.outlook.com [52.101.66.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DCF43F4A1;
	Sun,  4 Oct 2026 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116213; cv=fail; b=Byskr86xUzjOK7r/ZgR7ODkDpkb0N0OxJLPBNlG/OhfEjc1LFaG95PYECwLThDkIXtXpf+6PzwCmpB+iBIciOub3BAAXWSBwquBE/xcr7P67ni1AClnLqC7O1r412cqJ8bj/5yAGIQBITSIQ6XG489DMgRMBj25ggYK+BCSKZro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116213; c=relaxed/simple;
	bh=tjab8rk1GF2KRIZ6mvfttcplCL0dmuOlpX1Ssvr3B7Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=S8FSn3ZKyiFwmymMrq2Ah71qA8SCfoG0f+4Qsfy78yLsIrxc5M8/kpCD0Xxg2ntnYWWmiCquI6UMzV/h8KaFrjFP305decZYiz3HjUmCinBtPvgIwJ2lw5ig1qB2vwD2+dYBl/he+hYCfxsuwjkFZGXQOJMaPGduI6glC5U60kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=uNIMttqe; arc=fail smtp.client-ip=52.101.66.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="uNIMttqe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GX0+RDOcnjH3SL0zTFfwp2xvwRO/0buc8AkTf9V+8tze2sJ3pvmu6k+8k4m1D/AY/xzO5gUYPaTMopD1nqbi315RRERl/BdkkWKyxJiC5TE3S5qU5KlOPEhbkzmn19TtTO8D/+93HqyZZEJVt5JSuR8ayLSxZb3Jq8xTs3tRCAHpwybX/iTU3q0oxiPuKrpoQjXPTwmndvooqAznHjYKGg8mK3jylcXEwtRXfr5jvNx21AHwQ8yx+1uBii2kUjkw01D3fflfRVfQ5J5NDi8ciMcKUdXsUVbK10jvqDaqFHY42ezc7Jl1q6U8H9BE7Nc6fxfWYjYaiLFc7jdLKKNCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou8hgb/bqfUfAVLy+GOax9GzxuXWauaAWTRU7DTWsZ0=;
 b=a5RrXQ71EFB9Yj4ZmX4xDFBcbNSsUF4CConiDv9Fk5P1nwTlU7TuXCp0WB0zFS+uf8hJFv6eZxZX77mu13QY9pS7We0brY5DJ2VPtFGA/rAI7nR72GiywX/WzON/iq2/ad1khbcS7ahMu29MsmWO7Q08sVzzJSHIiVK4f6f7e5naZDQWiCzgJa92QaChLIFVcohLMX1/av0SszH2ttMlvpr5dZL2vtPzb6oVqvWABfHWZ7LBfAJJB8e8YK+Xwl44X/OztzV6eEM0uIce7tEfdrGZjezleHOBSnhdZVgTWUoJo0XraYGVd1BmQDjvcWZmUxZPqn/CElN1gVxhKlacgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou8hgb/bqfUfAVLy+GOax9GzxuXWauaAWTRU7DTWsZ0=;
 b=uNIMttqeQ+S8xyQdblZUVTVQNbJIozbCvzwl9/mdNvfYfJhvcOQVidwJ1cDVr6mgI9SIh011N4afxHawmQx/3Hwelvee9epPte5aBzeABn64b7CgQr5/fZEOTbMw6NqYtzhMEeBhr2svPwIvuiymsIFxvofk4XWSndp7lHbvwSO7Dg+apMwhpAkNGLJaelWPbJDAtVaYz+X+pCajCrOLfBXb2bhJGZepMwgKgFXYIsk/rZz9DDDAoZvZ+vfgLYdvl8ntAZZL4QFrZ9WdtuiaRCvbWcQsFDS2soY8sGnbg3Myo0jSdBW7P1B5zIzfLvaYkF3pOs7RHGDC/XMlbxIN6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10218.eurprd06.prod.outlook.com (2603:10a6:10:623::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:16:40 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:16:39 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Sun, 04 Oct 2026 12:16:28 +0000
Subject: [PATCH v6 8/9] serial: max310x: drive RTS in software when
 hardware delays are too short
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-max310x-rs485-sw-delay-v6-8-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791116192; l=30259;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=tjab8rk1GF2KRIZ6mvfttcplCL0dmuOlpX1Ssvr3B7Q=;
 b=IaGJukyvtyJEYdeWt/+nS/o8b/jNg3hQN35Y2LGfxg38Qe+k2MoFjNHzNUtcXPMsaYiVcv1ui
 iBATWQ4sfw5Dx4APL8j9PYysHHxZeMX0531D5QE19rxDqPPjag3hni4
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
X-MS-Office365-Filtering-Correlation-Id: a17091f8-c1d5-4886-db30-08df2211580f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|52116014|376014|22082099003|18002099003|38350700014|6133799003|3023799007|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	+7pSHeJOgisqz3PXVJpdY2XWfAjW++FL5194+JDrtvQrvay982SkvVfmjYAhgSrzy8XAq4d2BoU04Ejvk7lsVR4aIOiVdoubqWHnWAjYB8g1/9FLUL2IylWYYRBze8ds+kmGVa59ghbdbTTEHGA8HiYvgih1s1h2DYfg86u5T32MFHColWa0htpJZTHQnEepLc6pxMJtANtJEbXOnLW/1JLtl6ztqFc5akWkjW6Onji0rGao+AAyRhLg+PQlW+U6CqEIUJZKDkd6A+O0xvKN0chQ9rnU5vjeN+TLRoNRQPXTf038Nq6f5gqoYBbOv5hH99NIcC0cObQZqvTBVrDyWzWG3JeSzkDLsdHRyBGhViP0pV7RRgGIHPab5YDwSbnKDf+Wqe7cZ5YdfuJvMsRXHHm5dkQFKAq20oQ6EVY0nDEhsGIp64GZ6W+hsPW/WC+ryHahyW2sVpkN651AI08Ps1qCTesHIa+avrb434iNT16M+sAPQf+fsn8Bvt5TrPPbLJfA18/tEFWX62JRKgmGt9uHfBx9GarA43is2AE5T1R0cdr0vjQDA639pS6n3vo6AFu29s2bPn+F5xhuzcb1m6DJ7hdhMm173PWrROZl40IB73hOCcmQcriDfhIowPttFNHtlakD1oKLLOJS1VcteZ78pudK7Q52kpvfPn792JSCRv1T6Nyhu8W4McRMsdayHpnp6N6ZhhjMIBnTJaYYaU2gAVog6P6DXU9VUW4zg1A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(376014)(22082099003)(18002099003)(38350700014)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWY1MkpNNEM4bGgxTldWTzd2TEpKcHVST3dRVUdpRkY4NnhRYmJkNE9Wdmho?=
 =?utf-8?B?U3NKSWYwTUFyUlh0ZlIvVWlWYmRuL0N6Uk1NeDhFbk9QdndiSG85TGY5bXFO?=
 =?utf-8?B?dXVmeFY5Y3h1NHdqTGI0L1FrTE1MTmJ6aUVqR0RmZXVRMW9Sam1xZlpCQ0Jz?=
 =?utf-8?B?SU1PMFptR1gyK0FsbVQ5dmZxZlZJVk9qRW5IOCsvNUhtbjNrLy8xV2pncE9s?=
 =?utf-8?B?WjRHeXJsbjJzZVh5aCtmKzdKYm00U3NjZjNQRGRDV0d0QVNXdVVVZTBSYmhJ?=
 =?utf-8?B?VHZ3Ry8yUVlIK2FrUnIzSFBlRjV1cmNZWUE4WkJFaTFjU3R5YVRFNnpyM0Qy?=
 =?utf-8?B?QnBYdDArbDJra2xNSnlCOU10eGZhNVlUU1pieXRoeHB5K3U2aFZ6RDAzSDND?=
 =?utf-8?B?ZTVGeHBKeTZpSkI3VkVudnlkdDdHRlZsTkgvdys1T01oQUtoaFg3Zi9KaFZ2?=
 =?utf-8?B?NDNpRFJzVUdJdUVKTnRNMlhjK3lsV3I0VkllZTRxa2t4T3NMdGgycmM2M1Z2?=
 =?utf-8?B?clkvbXFzQlhYaGJ4L0Rxd3lHMWNlZ3lkdnB5a0FQWm5HejFucERZNVdzQStS?=
 =?utf-8?B?dVhSY2ZpWVpKU3pyRTFIbUowdHM5c0d6VjNqVXlicG9BZEN6OGZMVU5UZUZY?=
 =?utf-8?B?YUZKWGo0OUtXVVdaNm1MUGhpOUFtY1ZQRndTSlZoendnZUYxQ0hBWmZlSmlU?=
 =?utf-8?B?c3NNY0VWQSt4b1Yzd01ibFlWaHlJcjVkRlI1M3NNOFNUUktBTWpZV3NrMFg3?=
 =?utf-8?B?QW81WjF3MmtSQVNYTlRNakNVRWM0QjJEQzhPUm1rMXE4VHExb2JhOEFTeTd2?=
 =?utf-8?B?eGs0SWpGZWUrbURBRTZ1R2gyMy84dms0dUJBRUFtOU9zcnk4M0h1aEN0Vld5?=
 =?utf-8?B?Ti91NTV1VHNuRWplKzMrZUJRRjlRNEN1UnpMYWtBLzlWekIvdC9uazhVVzZG?=
 =?utf-8?B?NzBsMjJ5SFo2TmpMZTZnR29TM2VnSEdQdkJpUlc3LytpcWlNa1pDNG15YVRi?=
 =?utf-8?B?alE3bXpoYkszMlhrVEt0MnBiZytxNU9Mak50RUx0RGJlZ0F2VW1nQXJuQkhV?=
 =?utf-8?B?a3Z3eTdiNGQwQUhzTGtIUC9iTTMxUGE0VkdTdzFYNWRkWlNjaW5uSzQ2ZzJL?=
 =?utf-8?B?WFlzVllsWDZibDNjdWpMS1hNQ0FhR3EySDgvMlh3MEkyL3M5LzVlWmNraVAz?=
 =?utf-8?B?endHMGlLRG44c1M3S3hKVUQ3T215NWN2Y05WdGdFTmNmYk5Za0ZuNEtUc0Fq?=
 =?utf-8?B?S2tyOTlhWVEvd1BVQ2VQNk1GbDh6ZldkZFFESHU3SkU2K0VZdVdPc3VsRHJ4?=
 =?utf-8?B?YWtYOUI3ekdkbFB4MVF4cmJselc2eFZYWFdTWUxaenhwYzhOMXNOWW5rV3Nv?=
 =?utf-8?B?YjF2WjBtcm44eDdzU1JaZC9hZGZYWkdocDZqMDFFOEN5VVRhbElFTkhWT1RK?=
 =?utf-8?B?eG9Nb1JpL0s2TC9TWFkrK0R0R09FSnFMYjN6R3YxTWQxOTJzeXV5TWt4M1Ny?=
 =?utf-8?B?YzhjYldUSlBDMGlMNjlOUnJ3YU03VG1sQXF5QldtWXFIOGVjdkxES0VEdWNn?=
 =?utf-8?B?bWVIRlV4bkFlTE9PZkZzb0ExYU1FbERHQjRBN0YyS0R4RkZKOC8wY0d1d1hB?=
 =?utf-8?B?NytFWUdTcDJuVzVWLzFDQ3VzZ1VhME95ZHNEOFlGeHhKUXd3a25qd3JKazd5?=
 =?utf-8?B?cHpZVmp2SzVNTUpaRWxKZ2tlWXB2eWhZVUJ4YStreHpDR0txMDJRaEtSeUxn?=
 =?utf-8?B?QldvdU9mZnVlZld2dkRyUVNlaVc4OWJBNllzU1dVYUFScWxGOUVYY3hVZnBn?=
 =?utf-8?B?U1R0WEpUbGxMWGhPcmhBOGhQaEoyZkdHZk8xUHEycGw0emllUHN4ajZaUjJj?=
 =?utf-8?B?RlU3anFkNjNxNHhXY2xLa0dBOFZDWlFpVVAxTnZSeGxSblpDMXVFQm9hUVli?=
 =?utf-8?B?WVp4c3F6bFNVTFpWVzVPd1p6cVgvQ3hoTWFXc3dkTjEzblRnQTc5aVIyT3VV?=
 =?utf-8?B?cGNlOTMvNjN1U3F6c3laMHlPc1poR2lrNG55YWt1OHJNSWZHK2x3aWFmZFVw?=
 =?utf-8?B?d1pWdlVlaGdmY0RBNUx2dHEvRng3QlRUNUNWU0JNa3hmYXFpMkNNSTE5QkZ4?=
 =?utf-8?B?ajJqWUs1U3hZa1FWa2RZUDdRS1RrVitzOXBMbW8vQkFHT1hmNCtuWW9wcVRB?=
 =?utf-8?B?NE1EaTYxbTRmc0xFU0Y3SjgyNzkzZHI5bUpmRThTWE1JTFhrSjZOV0dTOXFE?=
 =?utf-8?B?Sk1JTUE3QUpXTEQ0a2V5SWtkMHJYUnVpUkpnZzRIajhCR2FEV1o0M2J4MlU2?=
 =?utf-8?B?ODRoeVI4aWJjRUNHM2VxQmtZQS9odnA5ZTRKeEo3VHM0T1ZDbGlHWFlXU0lp?=
 =?utf-8?Q?UNLTz3E1SyVVKUsY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17091f8-c1d5-4886-db30-08df2211580f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:16:39.8411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvdzLrkKGK+cFVcGsB5PGXOQy1PxyA2c1Zv9pFW3rDKHkPTgWv3Gxj3UVSwJ4288a0xomwDTPE4HK6UiZuMHIP7fpqceJ/8zAp/MjM9PnyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10218

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

A reconfigure can also move the port off the hardware path while the
chip's auto-RTS still owns a transmission in flight - a termios change
or TIOCSRS485 pushing a delay above what the hardware can time at the
new rate. Such transfers are invisible to tx_state, so the idle settle
would release RTS and the MODE1 write would disable auto-RTS
mid-transfer, shifting the rest of the data out with the transceiver
released and no error reported anywhere. Adopt the transfer instead
when the chip TX FIFO or the xmit buffer is not empty: enter
MAX310X_TX_SEND and drive RTS manually before auto-RTS is disabled, so
the pin is never released across the handover, and the normal drain
path arms the after-send hold - or the adoption arms it directly if
the FIFO drained while this raced the TX-empty worker. A transfer
whose last character has already left the FIFO for the transmit shift
register is still invisible and keeps the old behavior: at most one
character of early release.

The reverse move strands state instead: a reconfigure onto the
hardware path mid-envelope left tx_state set, because nothing reset it
in that direction and the TX-empty hold arming only ran while the
software path was selected. A later reconfigure back off the hardware
path then trusted the stale tx_state, skipped both the adoption and
the idle settle, and disabled auto-RTS with the RTS register released
- the rest of the transfer in flight shifted out with the transceiver
off, again with no error reported (hit twice in 79 in-flight
reconfigures under a multi-process stress test). The TX-empty unwind
now runs regardless of the selected path - it is a no-op outside an
envelope - and the reconfigure asserts RTS for any transfer it
believes exists, stale or live, before auto-RTS is disabled. The hold
is armed only once no transmittable data remains, so that assert
cannot cut a burst short when it lands in a FIFO refill window;
output that is stopped still releases through the hold.

rts_work also derives the level from tx_break: a break can begin while
the previous envelope's after-send hold is still armed - TIOCSBRK waits
for the output to drain, which lands the break exactly there - and the
expiring hold would otherwise release the transceiver mid-break. With
break ownership in the derivation the hold expiry becomes an idempotent
re-assert, and break-off restores the idle state as it already does.

shutdown() gives its final RTS release one character time, and at
least 100 us, to reach the pin before powering the port down. The
power-off stops the UART channel clock, and the RTS output stage is
clocked by it: a release written immediately before the clock stops
reaches the register but never moves the pin, which stays asserted
until the next startup restarts the clock - a close racing the
after-send hold expiry left the transceiver driving the bus, with the
register reading released and the pin high. The measured propagation
is below 50 us at 1200 baud; one character time scales with the baud
clock the output stage runs on, and the floor covers rates where a
character is shorter than the measured bound. Handing the pin to the
chip's auto-RTS engine instead was tried and rejected on the wire:
the pin level is RTSINVERT xor the selected source, so for an
active-low RTS every single-register step of that handover drives the
pin to the asserted level, and the same clock stop can freeze it
there.

Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 462 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 417 insertions(+), 45 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index baa499c16cc6a7651d804e8af07390b50ae66367..eb1d2e3bc870e9097d649eadb1e6e8703033fc94 100644
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
 	unsigned int		char_time_us;
 	unsigned int		baud;
+	bool			sw_rts_during_tx;
+	bool			cancel_tx_delay_tmr;
+	bool			tx_teardown;	/* envelope being torn down */
 	bool			tx_break;	/* break_ctl() owns the transceiver */
+	enum max310x_tx_state	tx_state;
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
@@ -696,6 +711,38 @@ static void max310x_rts_ctl(struct uart_port *port, bool rts_state)
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
+ * Drive the RS485 RTS line to match the current tx_state and break
+ * ownership. This is the only place that touches RTS, and it reads the
+ * state rather than a fixed assert/deassert intent, so a newer assert is
+ * never clobbered by a stale release and an expiring after-send hold never
+ * releases a break in progress. It also arms the before-send timer once the
+ * RTS edge is on the wire, so data is never shifted before RTS is asserted.
+ */
+static void max310x_rts_work_proc(struct work_struct *ws)
+{
+	struct max310x_one *one = container_of(ws, struct max310x_one, rts_work);
+	struct uart_port *port = &one->port;
+	bool rts_on = READ_ONCE(one->tx_state) != MAX310X_TX_OFF ||
+		      READ_ONCE(one->tx_break);
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
@@ -792,6 +839,77 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
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
+	 * Data still queued for transmission defers the hold: a refill is
+	 * coming and the envelope is not over. Stopped output does not
+	 * count - it drains nowhere, and the envelope must end.
+	 */
+	if (!kfifo_is_empty(&port->state->port.xmit_fifo) &&
+	    !uart_tx_stopped(port))
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
+		ktime_t delay = us_to_ktime(one->char_time_us +
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
@@ -803,8 +921,16 @@ static void max310x_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
+	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
+		/*
+		 * Unwind the envelope even if a reconfigure has moved the
+		 * port to the hardware path mid-envelope: a stranded
+		 * tx_state would make a later reconfigure believe a
+		 * software envelope still owns RTS.
+		 */
+		max310x_delayed_stop_tx(port);
 		return;
+	}
 
 	/*
 	 * It's a circ buffer -- wrap around.
@@ -829,11 +955,58 @@ static void max310x_handle_tx(struct uart_port *port)
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
@@ -946,10 +1119,37 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 }
 
 /*
- * Program the chip's RS485 RTS timing. The HDPIXDELAY setup and hold fields
- * count bit-times, four bits per direction, while the uapi expresses the
- * delays in milliseconds: convert at the current baud rate, rounding up, and
- * cap at the field maximum.
+ * A reconfigure can move the port off the hardware RTS path while the chip's
+ * auto-RTS still owns a transmission in flight; tx_state does not track
+ * those. Take such a transfer over before auto-RTS is disabled: enter
+ * MAX310X_TX_SEND, so the caller keeps RTS driven across the handover and
+ * the normal drain path arms the after-send hold. Returns true when a
+ * transmission owns RTS - adopted here or started concurrently - and false
+ * when the line is really idle.
+ */
+static bool max310x_adopt_hw_tx(struct max310x_one *one)
+{
+	struct uart_port *port = &one->port;
+
+	if (!max310x_port_read(port, MAX310X_TXFIFOLVL_REG) &&
+	    kfifo_is_empty(&port->state->port.xmit_fifo))
+		return false;
+
+	scoped_guard(spinlock_irqsave, &port->lock) {
+		if (READ_ONCE(one->tx_state) != MAX310X_TX_OFF)
+			return true;
+		WRITE_ONCE(one->tx_state, MAX310X_TX_SEND);
+		one->cancel_tx_delay_tmr = false;
+	}
+
+	return true;
+}
+
+/*
+ * Pick hardware or software RTS timing for the current port. The chip can
+ * deliver up to 15 bit-times of setup/hold delay via HDPIXDELAY; anything
+ * longer (or any RTS polarity the chip cannot produce automatically) must
+ * be driven by software via tx_delay_tmr and rts_work.
  */
 static void max310x_set_rts_ctl_params(struct max310x_one *one)
 {
@@ -957,25 +1157,35 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
 	struct uart_port *port = &one->port;
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
+	/* Convert milliseconds to bit-times, rounding up. */
+	setup = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_before_send,
+			     MSEC_PER_SEC);
+	hold  = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_after_send,
+			     MSEC_PER_SEC);
+
+	/*
+	 * Compare in bit-times: a delay of exactly max_bit_dly bit-times
+	 * must stay on the hardware path, which a nanosecond ceiling
+	 * computed from the truncated per-bit time would reject. Without
+	 * a baud rate the conversion is meaningless - use software.
+	 */
+	if (!one->baud || setup > max_bit_dly || hold > max_bit_dly ||
+	    !!(port->rs485.flags & SER_RS485_RTS_ON_SEND) ==
+	    !!(port->rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
+		sw_rts = true;
+		setup = 0;
+		hold  = 0;
 	}
 
+out:
+	/* Assign once; a transient false would be seen by other readers. */
+	WRITE_ONCE(one->sw_rts_during_tx, sw_rts);
+
 	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
 			   MAX310X_HDPIXDELAY_SETUP(setup) |
 			   MAX310X_HDPIXDELAY_HOLD(hold));
@@ -983,12 +1193,66 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
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
+			 * transceiver mid-character. A transfer the hardware
+			 * path owns is invisible to tx_state - adopt it
+			 * instead of settling. The reverse strand also
+			 * exists: an envelope the hardware path inherited
+			 * mid-envelope leaves tx_state set with nothing
+			 * driving the pin.
+			 */
+			if (READ_ONCE(one->tx_state) != MAX310X_TX_OFF ||
+			    max310x_adopt_hw_tx(one)) {
+				/*
+				 * The transfer may be running under auto-RTS:
+				 * assert before auto-RTS is disabled below so
+				 * the pin is never released under it, and arm
+				 * the after-send hold - with the chip FIFO
+				 * already drained no TX-empty interrupt
+				 * arrives to arm it.
+				 */
+				max310x_rts_ctl(port,
+						max310x_rts_level(port, true));
+				max310x_delayed_stop_tx(port);
+			} else {
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
@@ -1016,12 +1280,27 @@ static void max310x_break_ctl(struct uart_port *port, int break_state)
 	if (break_state) {
 		if (!(port->rs485.flags & SER_RS485_ENABLED))
 			return;
-		max310x_port_update(port, MAX310X_MODE1_REG,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
+		if (READ_ONCE(one->sw_rts_during_tx)) {
+			max310x_rts_ctl(port, max310x_rts_level(port, 1));
+		} else {
+			max310x_port_update(port, MAX310X_MODE1_REG,
+					    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
+			max310x_rts_ctl(port, 1);
+		}
 	} else {
+		/*
+		 * Reapply the current configuration: a reconfigure that
+		 * arrived during the break was deferred by the tx_break
+		 * guard, and RS485 may have been disabled outright - the
+		 * manually driven RTS must not leak past the break. On the
+		 * software path the helper also settles the idle level; on
+		 * the hardware path release the manual RTS - auto-RTS owns
+		 * the pin again.
+		 */
 		max310x_set_rts_ctl_params(one);
+		if (!READ_ONCE(one->sw_rts_during_tx))
+			max310x_rts_ctl(port, 0);
 	}
-	max310x_rts_ctl(port, break_state);
 }
 
 static void max310x_set_termios(struct uart_port *port,
@@ -1063,9 +1342,10 @@ static void max310x_set_termios(struct uart_port *port,
 		lcr |= MAX310X_LCR_STOPLEN_BIT; /* 2 stops */
 
 	/*
-	 * Update LCR register. Leave the TX break bit alone: it is driven by
-	 * break_ctl(), and a whole-register write here would end a break in
-	 * progress.
+	 * Update LCR register. Leave the TX break and RTS bits alone: they are
+	 * driven by break_ctl() and by the software-timed RS485 RTS, and a
+	 * whole-register write here would end a break in progress or release
+	 * the transceiver mid-character.
 	 */
 	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TERMIOS_MASK, lcr);
 
@@ -1143,7 +1423,9 @@ static void max310x_set_termios(struct uart_port *port,
 	/*
 	 * Cache the new baud rate and the time it takes to clock out one
 	 * character before reprogramming the RS485 RTS delays: the
-	 * millisecond-to-bit-time conversion divides by the baud rate.
+	 * millisecond-to-bit-time conversion divides by the baud rate, and
+	 * taking over an in-flight transfer arms the after-send hold from
+	 * the character time.
 	 */
 	to_max310x_port(port)->baud = baud;
 	to_max310x_port(port)->char_time_us =
@@ -1173,14 +1455,37 @@ static void max310x_rs_proc(struct work_struct *ws)
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
 
@@ -1214,7 +1519,15 @@ static int max310x_startup(struct uart_port *port)
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
@@ -1244,24 +1557,76 @@ static int max310x_startup(struct uart_port *port)
 static void max310x_shutdown(struct uart_port *port)
 {
 	struct max310x_one *one = to_max310x_port(port);
-	unsigned int tries = port->fifosize + 1;
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
+		unsigned int tries = port->rs485.delay_rts_before_send +
+			port->rs485.delay_rts_after_send +
+			DIV_ROUND_UP_ULL((u64)(kfifo_len(&port->state->port.xmit_fifo) +
+					       port->fifosize) *
+					 one->char_time_us,
+					 USEC_PER_MSEC);
+
+		while (READ_ONCE(one->tx_state) != MAX310X_TX_OFF && tries-- > 0)
+			fsleep(USEC_PER_MSEC);
+	} else {
+		/*
+		 * The tty layer's wait-until-sent is bounded by
+		 * closing_wait, which can be configured to none, and a
+		 * hangup reaches here with no wait at all, so the FIFO may
+		 * still hold anything up to its full size. tx_empty() also
+		 * only reflects the chip TX FIFO - the last character may
+		 * still be in the transmit shift register. Let the FIFO
+		 * drain and the final character clock out before the port
+		 * is powered down, otherwise the transfer is truncated on
+		 * the wire.
+		 */
+		unsigned int tries = port->fifosize + 1;
+
+		while (!max310x_tx_empty(port) && tries-- > 0)
+			fsleep(one->char_time_us);
+		fsleep(one->char_time_us);
+	}
 
 	/*
-	 * The tty layer's wait-until-sent is bounded by closing_wait, which
-	 * can be configured to none, and a hangup reaches here with no wait
-	 * at all, so the FIFO may still hold anything up to its full size.
-	 * tx_empty() also only reflects the chip TX FIFO - the last character
-	 * may still be in the transmit shift register. Let the FIFO drain and
-	 * the final character clock out before the port is powered down,
-	 * otherwise the transfer is truncated on the wire.
+	 * Set the teardown interlock under port->lock, so a concurrent
+	 * start_tx() either sees it or happens-before the cancellations
+	 * below. Then cancel unconditionally: the SW/HW decision is
+	 * recomputed on every reconfigure, so a TIOCSRS485 can clear
+	 * sw_rts_during_tx while an envelope is still in flight, and
+	 * neither the timer nor the works may outlive the port.
 	 */
-	while (!max310x_tx_empty(port) && tries-- > 0)
-		fsleep(one->char_time_us);
-	fsleep(one->char_time_us);
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
 
+	if (READ_ONCE(one->sw_rts_during_tx)) {
+		max310x_rts_ctl(port, max310x_rts_level(port, false));
+		/*
+		 * The power-off below stops the UART clock that moves the
+		 * RTS pin: released too late, the write reaches the register
+		 * but the pin stays at its old level until the next startup
+		 * restarts the clock. Give the release one character time
+		 * (at least 100 us) to reach the pin.
+		 */
+		fsleep(max(one->char_time_us, 100U));
+	}
+
 	max310x_power(port, 0);
 }
 
@@ -1551,6 +1916,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
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
@@ -1661,6 +2031,8 @@ static void max310x_remove(struct device *dev)
 	int i;
 
 	for (i = 0; i < s->devtype->nr; i++) {
+		hrtimer_cancel(&s->p[i].tx_delay_tmr);
+		cancel_work_sync(&s->p[i].rts_work);
 		cancel_work_sync(&s->p[i].tx_work);
 		cancel_work_sync(&s->p[i].md_work);
 		cancel_work_sync(&s->p[i].rs_work);

-- 
2.47.3

