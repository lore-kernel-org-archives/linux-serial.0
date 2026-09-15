Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021073.outbound.protection.outlook.com [40.107.130.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14518486E51;
	Tue, 15 Sep 2026 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470500; cv=fail; b=grvbzoefjAlx6CCFfGR7PE1IT82bYI9nK3E+BxPaOAGYobN+q6QSFLTrRozr0IOLZYahmjNoObSBdlczbat7gUrgTwvkbrOSt1u5IZp5w/9X4iAZfoaJ60wz+hxpbL7OqqirU9PuewvbvACB/C1NmeeeBVNdmSTn6BXLd+4BM2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470500; c=relaxed/simple;
	bh=MwvVSi7VesGBZt7T0mEy0yAFqC5/HtkCgL4FmGESYkA=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=W5x/xav+L7ouQQu2DqWBTLM+DU9ob6LdJbjYg0Yt9wTWHmJA85SFAorvE8MsISUp+Iem6YiTFBv+Pm55T3GmtLw1Z/Mv+FS9Lvas86bmaPjx2axRtfqbQrjzy0C2QueVDbssNg5xvHcLxCCQhnLxAgtorViGYMSpd94SqiLwhGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=w4T0qoEh; arc=fail smtp.client-ip=40.107.130.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="w4T0qoEh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEW+X7u5riYoNSlqBBDRUJ0+SUGH9XEVtDjfFFjZ/TElsTiJUrmFAlf5J/p3v0UOfqpCZpCqyE3xjX0XYnmh7OReBZ/cpCbS473exT3VxtOElJ0ChUluRMmKg+m9HWWSBm8xPzUs08XW5jN+Ta+r/xh6GPiNeBmfzhLgAHNOkgD0IQLoy357G6lTN6Pza+DbLuS7cw0eiiKYn615L1EtUE1fJqRFfOrbFfdkaHqaPJ3++6IE3GH96G9h3y6fi09Us7QUBa3i4v4Rc5Yt52JL6Sry9a/WwTV2DpsiXwYladKUjb5Rb47rY+G0I6Iw1jP82xbcPrkD0bT5JZZ0/C62kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/0rdvqUprgG13o9873JJ4sFFeY77dRZHO0JsfcARcI=;
 b=b2zufn+X49yhHxknBC2gVcy8ErrwGXdE78MaeGPF8RGFllnQQX1x3LtN9jLyu+AXOSDya4NJWXgbo4GQBhK2fiVUAyM0iWFfn0LvcdpF3wV6QMqyfpwUhmqvKooK15GKm54iyhqTrDGQkA6SY+OuJvlWocmO6DlfKExBHBNo5ua6iyZ8WWPUIJ6LLFZ3MaULn9KhLP/1DNppm8rsPQbGmCB5QMLxdnGDpMRh6TEW3GCaGaDCziYKthahdxExd7M/+UXSZBtlizIomqq/VpQVFMxznonxZ66m7BQEDhA4DU4sRT4oCx5aRqlfvM5/KN37NwoL6loDCCq7W2Miki2rcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/0rdvqUprgG13o9873JJ4sFFeY77dRZHO0JsfcARcI=;
 b=w4T0qoEhxcilxHnE/nmSokRd2BFpmiQCiNTzPKV86Oxq0oDuVN0RKd12ZIt7Hkb/ggD89AHwXix9U1BQU4T24DzWIQ9dxSuG6wkJPiy/2Jrx5TNAw2PvuSJTpfOmU+zxBHSLNE+Nz5OztamPEg9/u/w0ps66JHHaveK6wMeEEXnrrPECUiDCenRGwh0RaykATDICe7Jw7pXTHkHvP7vYrux8PdWGXfI9cc4UR+AKfE8CVCcHSMT5PNtNu8t3drgJMLJ6yY3BpZDPlOjnPmI/j5RCctbZdQWr+8aCKhobm+kDC4+6iunWvhXAhtTUmk1oYk/rMRrS0fu+YSW62VvV2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI1PR06MB6511.eurprd06.prod.outlook.com (2603:10a6:800:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 11:08:02 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%3]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 11:08:02 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 15 Sep 2026 11:07:55 +0000
Subject: [PATCH v3] serial: max310x: drive RTS in software when hardware
 delays are too short
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-max310x-rs485-sw-delay-v3-1-7d20a4a4ab52@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAAonqWoC/3XNTQ7CIBCG4as0rMUAA4W68h7GxVjQkvTHgME2T
 e8urQvjosv3S+aZmUQXvIvkVMwkuOSjH/occChI3WD/cNTb3EQwUTLFgXY4AmcjDVEaReObWtf
 iRBFYabUBq0RF8vEzuLsfN/hyzd34+BrCtP1JfF2/pGbVHpk45VQqiTVntwo0nhP6iC0e66EjK
 5rEDzKc70IiQw6kMCCY0qb6h5Zl+QDzFWCIBwEAAA==
X-Change-ID: 20260513-max310x-rs485-sw-delay-a306d783d529
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789470481; l=28379;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=MwvVSi7VesGBZt7T0mEy0yAFqC5/HtkCgL4FmGESYkA=;
 b=9F5h+JzMMrG3bD2rn1QpLPM64be4SIq7zO1Y5gPB9htziEwqoBJsEHvAdDHSCukZFyDgRWtvi
 cYged0zjiHvBe4SYbrV/jHmSvmgt6/D/MJpf9RJQjBt9LFGTPQWZJ0z
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVYP280CA0041.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::25) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|VI1PR06MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd183a3-6f05-4cf2-baf2-08df13199c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|23010399003|376014|1800799024|38350700014|5023799004|11063799006|56012099006|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TIvsxKULUfL95YKKSbduhSBARoU5WYp2FTM2QJT7LKSY2o8kPtELCytk6kzuTxrMkowX8ONBjhrSLkwBY0C743JaY47JF5xXjPG6YHcwSmFYAUim0dKlecViYKTkVBD2XtAboiw+9LbkXE8wzKcMfxTJJ3qaCCUzdSzNaYAwmZAq7vQj4SrkOafq+E77gbYi4od8BVQBd2Tb0kYe79SiCkltlmAuz0hJEC9mwZwMwejXP+oCnVGlvYzwjvRLUYETnyRyUgNAzNllTzdCqVTKCId7HcWSM12873IALF91m1P+mrSPo+wNOj975jbngoam/nf27KU4cfOJdN4AxNqcZm/gRA4yH33N9sXk5zIY0GhvbQUX4REAcdfIdCMnS5aSZwFvUEPacDpSvK1+oqOIa+D4nEIzbqNgTj6FECAkOQDPgARkOTiwKOlHck6jZ/wqTyQXGkH0umzdPVmS55H2pI9zxxseg3TcmV4FpC52r/4Sz1Abag4iPQ/u7l6o4HfBdSmiGs9OQrNB28T2d4LlifS+0axMHzeovgahb4hI7Gh/CBZQTuHRfDmEBeDc8rrQ7CD1QSU8BvdjxgZG/BQ2Fxzn7apUSNg5M65Kvz0IpEZdqac7DNPsfbzicfk1iLEhJXY3OwHXNn9e5EdVSlixVrEvVO6DcyulWESuuogWmCv/DSMU94kOT3hHlrsTGmeHjfFTwMcWeksnfEZzmKwOUawPhYVxXGeyMveyQn/ICV0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(23010399003)(376014)(1800799024)(38350700014)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFpkRmNYTHFLZHdmbk9NOGpTdFBESnJoUS9reWJYRkordmUxZDlDQVc3SDRD?=
 =?utf-8?B?aHhGS1NaSEZzRW1SbTVpTHJaNG0yRVI5WTNjZ2dxeGpnMnRYdHdPQUt2aW44?=
 =?utf-8?B?TmowdHd2VkdVTW5ab2VDcGp6czBubGlSMUlXYkFQcmhLbTZkREduRzVPTUl6?=
 =?utf-8?B?WHJjU3B5OUY5ZWZEM0lSUllER1FrUEVGNitrWG0wSERtb1RodVJCL2RHME1V?=
 =?utf-8?B?SDJscU51dC80MUh6alNPYjN5Mkc3Z1hlTzVwQU1CYnQ3NVNwcTNlUkpWZVlP?=
 =?utf-8?B?V01oL1M2RDBud2cwajI4akNoa1JrRTUrY2JGUWdxcUs1YkljZjQrUXdwemhO?=
 =?utf-8?B?d3orTVozY3J1eGF1ODdORGNtZTRIT0ZtQXpydGxKNzE3ZlA1NXZUQ3JOWm5m?=
 =?utf-8?B?bGVCbGZKdXN2QmlRTnJPVHMzenNnSWQzWSttaG8vVU42OFBtN3ZUdXljRVBH?=
 =?utf-8?B?SFJHVFZZc05RRzM0TUVyU1hnZGR6ZUlrM1Bnckw0WUx1azRsaUJpeTRCWU1o?=
 =?utf-8?B?VlBvQXdheEx4dmhBelF6VUNYb2tSYU1SdVRyMlF4bnF1NXVVc3E4SDNQTHlE?=
 =?utf-8?B?QjVyQTAzMVROc2hvQnJQWFZHMXg4cUx3dCtvWVdtWEd1RnEvRUlySEt3ZmRs?=
 =?utf-8?B?c1RaTDQxNFdxemdNYWlWbXlNL3JKWk9BRlFjM3JFNUNrSXNENUxySTVkQ0hM?=
 =?utf-8?B?TUlncEdDbVZJNkF4bktNSklyWjFBcHUyMUxEWExpY2N4TTV3T0ZJVGE2OFdh?=
 =?utf-8?B?UjJmZElyYjJsVmdaYXhrQTRlRnFtckcwT0ZnY094N0R2L05BVzdjZDVJVXhJ?=
 =?utf-8?B?dEtyRG4yZjg5aC9WZmFzZGZKeU03aDNxbmo3MHBkclNPYjIzWGpQWXJldkdo?=
 =?utf-8?B?YXp6QmQxZGNOdmMzaGlRTGx5clVEZ2h3Yll0RGNLMW9pRCtVcG85bmJaR1B5?=
 =?utf-8?B?WFEzdUNDUlErK1F0cTBTMHRJZzJhbGpuNDcxK1hwWEp2MnFRY0czNG1hQVAw?=
 =?utf-8?B?a3pMckRsRnczUWNOdC82MEJxaGlRcE9mNHMyRlRtNXhwMGJ0UmNCQk5UcHBK?=
 =?utf-8?B?VlZHT29OdGNydXlpanRpQVFRZXMvVDI0M0dRaDd0NG84Wko5Um9BY1I1cmpa?=
 =?utf-8?B?aEtKNzhreUpwcVhMelBPRFRCbFVLQkNZWEFqMVhOSVpaM3NlRjBzUTU1U3F6?=
 =?utf-8?B?bCtYd2w4WVhMU2RIVC9sNG5aRHJldE9TQ1dKRGMxWTJqbWxPb0FRY1ZvYWFm?=
 =?utf-8?B?R0hQbGxhVEtCc0hXb3hxSHZzelRrbVJQQkVpeU9EOFF0WG8rTlpnc0R1T2FX?=
 =?utf-8?B?R3Z4T2l3SUhNS1A1amhlUTFPZlZ1T1dzamVLOS8ybW15QUNyZGlERVBqWmpZ?=
 =?utf-8?B?K2pqMmh1c0pWOHQxR1dUclA3SHdNRnNacGxiakI3QWhsMGpFUmhFMUlHdW5L?=
 =?utf-8?B?VDZKYVhDUjB3TEdwV1BQZjVPV0JnaWZTYVhYdEpxa2s2dTZuUEVxb3pWZHFr?=
 =?utf-8?B?VU5FdEhWVGM2NVhWVmVPdHM2NlBxSUVSWUZ5cVNOS2pVc3JwdjF0R3NFYnVW?=
 =?utf-8?B?cUlIcEZNbHpUNzdXUFRzT20zdUluOCs2RlNXck1vLzhOU0VVcGR2Z0ZDcVV3?=
 =?utf-8?B?Y0toWEdoSENCOHRSSFFPazRINS9reWtxOVVxK3ZQWlZ6U3hPVVE2UmIvdXl1?=
 =?utf-8?B?Yzh4T3JlNTdVSXFqWVRlTitLcDdjalVUUkxlbWorOHVTMVZTUWVGOWJkZi9R?=
 =?utf-8?B?M3Q4MnQrYkMwZWE5SnRnTklsNVVrZ2UwaEVhems4UElmaHdZTWh1TVdsWTYy?=
 =?utf-8?B?M3JSbkJ3SWt1aG10Um9WVW9sYUtHV2w2T0J3d1BWdmFycWVEc0J3RnBnYkxx?=
 =?utf-8?B?MTFvcUROV1d0NVRZZzNSR29FV0JsSU5nRFBKbm93S2RFU2RTMjVZMzVvcENU?=
 =?utf-8?B?clgxR3c0NGNFcHJLa1ZOVTFKMzV0UnVUbno2MlUvUk9mUm1Xc2xjZUgwNWR6?=
 =?utf-8?B?NWdXNE5NTGU5bHREZWVUK2laZ0k1Z1BlNC9GaHBPcDFUTDNRR1BkWlF0NzRl?=
 =?utf-8?B?WGZFeDliOWp2YXNyM0dYTjhXZHF5Y2xENE9ndlNqTTZpQXV3MjdjcWYreVdJ?=
 =?utf-8?B?RFExM2Y3QzdISWN3d1lpeEU1SHhGY3FqeS81YXAvY0NxWmgyQlRLd2RBaWpk?=
 =?utf-8?B?K0lBMTk1SHo5M3g5R20vREZuMDBUVmxER2E0M050THRqR08ydnh2Unhwek01?=
 =?utf-8?B?cW1vRFRpamxVMzVSMjVXOUpiQ1kwZUROd2syNDRKbkJaU1VkSldaNHZPOEFV?=
 =?utf-8?B?azFTMW9ibUNJWXVBbDFPc25jUzQ1aUZrUUNzTllqODNEbHUzbXlCUGw3VnJS?=
 =?utf-8?Q?6vF+z1jxltdvaBO8=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd183a3-6f05-4cf2-baf2-08df13199c01
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:08:02.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SL2bLPEkVXb+cEdmC6Fdo831maZQREMRY8WKW0Tpph1/FZcDqdDoEWysWRI50APvGJk77rJ9OZt2/jornWg+qZ72hBjDt3Gt+YNLJjHM1Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6511

max310x_rs485_config() rejected delay_rts_before_send and
delay_rts_after_send values larger than 0x0f with -ERANGE, which made
the UART core wipe port->rs485 in uart_rs485_config() and silently
disable RS485. The HDPIXDELAY register holds the setup and hold
delays in 4-bit-per-direction bit-times, so even values inside that
range only encode a fraction of a millisecond at typical baud rates
and the chip's hardware auto-RTS path cannot cover the millisecond
range the kernel UART layer expresses.

Add a software-driven RTS path that takes over whenever the hardware
cannot represent the requested timing:

  * Cache the current baud rate and the per-character on-the-wire
    duration in max310x_set_termios() so the decision below can use
    them.
  * max310x_set_rts_ctl_params() picks software or hardware timing:
      - software if delay_rts_before_send or delay_rts_after_send in
        milliseconds exceeds what 15 bit-times can encode at the
        current baud, or if the requested RTS polarity cannot be
        produced by the chip's auto-RTS engine;
      - hardware otherwise, converting the millisecond delays to
        bit-times (rounded up, capped at 15) and programming
        MODE1.TRNSCVCTRL plus IRDA.RTSINVERT to drive RTS with the
        requested polarity. RTS is left deasserted at idle; the chip's
        auto-RTS engine owns the transceiver during transmission.
  * When software timing is selected the RTS envelope is driven by a
    single hrtimer, re-used for the before- and after-send phases (the
    phase is tracked in tx_state), plus a single rts_work that toggles
    RTS. max310x_start_tx() queues rts_work to assert RTS; rts_work
    arms the timer for the before-send delay only after the RTS edge is
    on the wire, so data is never shifted before RTS is asserted. The
    timer expiry kicks tx_work to fill the chip FIFO; once that FIFO is
    empty (max310x_handle_tx()) the same timer is re-armed for one
    character duration plus the after-send delay, after which rts_work
    releases RTS. Using one timer and one rts_work keeps the before-
    and after-send phases mutually exclusive and the RTS toggles
    ordered, which matters for back-to-back writes and on SMP.
  * The LCR register carries the TX break and RTS bits next to the
    termios bits, so max310x_set_termios() updates only the bits it owns
    instead of writing the register absolutely, and
    max310x_set_rts_ctl_params() settles RTS to the idle level only
    while tx_state is MAX310X_TX_OFF. Both can run while a software
    timed envelope is in flight - serial_core calls ->set_termios()
    without port->lock, and max310x_rs485_config() schedules a
    reconfigure on every TIOCSRS485 - and would otherwise release the
    transceiver mid-character.
  * max310x_shutdown() waits for transmission to finish before powering
    the port down, so close() cannot truncate the final byte.
    On the software path it waits out any in-flight RTS envelope
    (bounded) so the last character and its after-send hold complete.
    On the hardware path it lets the chip FIFO drain and the last
    character clock out of the shift register: tx_empty only reports
    the TX FIFO empty, not the shift register, so without this the
    port could be powered down mid-character.
  * max310x_rs485_config() now clamps the delays to the UART core's
    RS485_MAX_RTS_DELAY (100 ms) instead of rejecting them, and
    cancels the pending delay timer when RS485 is disabled.
  * max310x_break_ctl() drives RTS manually for the break duration. The
    chip's auto-RTS only asserts the transceiver while FIFO data is
    shifting out, and a break is not FIFO data, so on the hardware path
    it also disables auto-RTS for the break and restores it when the
    break ends. The software path drives the configured RS485 RTS
    polarity; on the hardware path IRDA.RTSINVERT already inverts the
    RTS_ output stage, so break_state is driven as it is.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v3:
- max310x_set_termios() updates only the termios-owned LCR bits instead
  of writing LCR absolutely. TX break and the software-timed RS485 RTS
  live in the same register, and serial_core calls ->set_termios()
  without port->lock, so a tcsetattr() concurrent with an in-flight
  envelope released the transceiver mid-character.
- max310x_set_rts_ctl_params() only settles RTS to the idle level while
  tx_state is MAX310X_TX_OFF. It runs from rs_work, which
  max310x_rs485_config() schedules on every TIOCSRS485, and forcing the
  idle level there unconditionally had the same mid-character effect.
- max310x_break_ctl() applies the configured RTS polarity on the
  software path; a port with rs485-rts-active-low drove the wrong level
  during a break. The hardware path keeps driving break_state as it is:
  IRDA.RTSINVERT inverts the RTS_ output stage itself (MAX14830
  datasheet, IrDA register bit 2), so both polarities already come out
  right there.
- Add max310x_rts_level() for the flag-to-level selection, which is now
  needed at four sites.
- Use uart_port_unlock()/uart_port_lock() at the two sites that drop
  port->lock around hrtimer_cancel().
- Not done, although I said I would: skipping the before-send re-arm
  when tx_state is already MAX310X_TX_SEND. Returning early there also
  removes the interlock that keeps max310x_delayed_stop_tx() from arming
  the after-send hold while a fresh write is still queued, which can
  release RTS mid-character. The txlvl == 0 gate in
  max310x_delayed_stop_tx() already keeps the timing correct; the cost
  of leaving it alone is one spurious before-send delay mid-stream.
- Review that prompted the above, on the v2 resend:
  https://lore.kernel.org/r/20260914-max310x-rs485-sw-delay-v2-1-9a7b681e64ce@vaisala.com
- Link to v2: https://lore.kernel.org/r/20260811-max310x-rs485-sw-delay-v2-1-e34283205789@vaisala.com

Changes in v2:
- Use tty_get_frame_size() instead of open-coding the frame size
  (Jiri Slaby). The helper was left with a single expression and one
  caller, so it is dropped and the calculation now lives in
  max310x_set_termios(). tty_get_frame_size() additionally accounts for
  ADDRB, which the open-coded version ignored.
- Use guard(spinlock_irqsave) instead of spin_lock_irqsave() and
  spin_unlock_irqrestore() (Jiri Slaby), in max310x_rts_work_proc(),
  max310x_tmr_tx() and max310x_delayed_stop_tx(). The bare
  spin_lock()/spin_unlock() pairs in max310x_start_tx() and
  max310x_rs485_config() are left alone: both are called with port->lock
  held by the caller and only drop it around hrtimer_cancel(), which
  guard() cannot express.
- Link to v1: https://lore.kernel.org/r/20260709-max310x-rs485-sw-delay-v1-1-454ac10b937a@vaisala.com
---
 drivers/tty/serial/max310x.c | 407 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 371 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 022502986c5fcf1ff4de9328746ddc71677be730..e8612c5c95550e0dc47564ccf60906b68cca639a 100644
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
@@ -158,10 +159,17 @@
 #define MAX310X_LCR_FORCEPARITY_BIT	(1 << 5) /* 9-bit multidrop parity */
 #define MAX310X_LCR_TXBREAK_BIT		(1 << 6) /* TX break enable */
 #define MAX310X_LCR_RTS_BIT		(1 << 7) /* RTS pin control */
+/* LCR bits owned by termios; TX break and RTS are driven elsewhere */
+#define MAX310X_LCR_TERMIOS_MASK	GENMASK(5, 0)
 
 /* IRDA register bits */
 #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
 #define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
+#define MAX310X_IRDA_RTSINVERT_BIT	(1 << 2) /* Invert RTS output */
+
+/* HDPIXDELAY accessor macros */
+#define MAX310X_HDPIXDELAY_SETUP(val)	(((val) & 0x0f) << 4)
+#define MAX310X_HDPIXDELAY_HOLD(val)	((val) & 0x0f)
 
 /* Flow control trigger level register masks */
 #define MAX310X_FLOWLVL_HALT_MASK	GENMASK(3, 0) /* Flow control halt level */
@@ -290,12 +298,27 @@ struct max310x_devtype {
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
+	ktime_t			one_character_duration;
+	unsigned int		baud;
+	bool			sw_rts_during_tx;
+	bool			cancel_tx_delay_tmr;
+	enum max310x_tx_state	tx_state;
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
@@ -680,6 +703,42 @@ static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int l
 	regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
 }
 
+static void max310x_rts_ctl(struct uart_port *port, bool rts_state)
+{
+	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_RTS_BIT,
+			    rts_state ? MAX310X_LCR_RTS_BIT : 0);
+}
+
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
@@ -776,6 +835,71 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
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
+	 * Runs from the tx_work worker, which does not hold port->lock. Take it
+	 * here so cancel_tx_delay_tmr, tx_state and the timer are updated
+	 * atomically against start_tx() and the timer callback.
+	 */
+	guard(spinlock_irqsave)(&one->port.lock);
+	one->cancel_tx_delay_tmr = false;
+	/*
+	 * Do not arm the after-send hold if a before-send phase is pending: a
+	 * new burst's start_tx() may have set WAIT_BEFORE_SEND while its timer is
+	 * not yet armed (max310x_rts_work_proc() arms it after the RTS edge).
+	 * That burst owns the line and runs its own envelope.
+	 */
+	if (READ_ONCE(one->tx_state) != MAX310X_TX_WAIT_BEFORE_SEND &&
+	    !hrtimer_active(&one->tx_delay_tmr)) {
+		/*
+		 * Add one character for the byte still in the shift register -
+		 * TX-empty fires as it enters, not as it leaves.
+		 */
+		ktime_t delay = ktime_add_ms(one->one_character_duration,
+					     port->rs485.delay_rts_after_send);
+
+		WRITE_ONCE(one->tx_state, MAX310X_TX_WAIT_AFTER_SEND);
+		hrtimer_start(&one->tx_delay_tmr, delay, HRTIMER_MODE_REL);
+	}
+}
+
 static void max310x_handle_tx(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
@@ -787,8 +911,13 @@ static void max310x_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
+	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
+		struct max310x_one *one = to_max310x_port(port);
+
+		if (one->sw_rts_during_tx)
+			max310x_delayed_stop_tx(port);
 		return;
+	}
 
 	/*
 	 * It's a circ buffer -- wrap around.
@@ -813,11 +942,48 @@ static void max310x_handle_tx(struct uart_port *port)
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
+	if (one->sw_rts_during_tx) {
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
+		}
+
+		max310x_delayed_start_tx(port);
+	} else {
+		schedule_work(&one->tx_work);
+	}
 }
 
 static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
@@ -843,7 +1009,7 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
 		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
-			max310x_start_tx(port);
+			schedule_work(&s->p[portno].tx_work);
 	} while (1);
 
 	return res;
@@ -927,15 +1093,111 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void max310x_break_ctl(struct uart_port *port, int break_state)
 {
+	struct max310x_one *one = to_max310x_port(port);
+
 	max310x_port_update(port, MAX310X_LCR_REG,
 			    MAX310X_LCR_TXBREAK_BIT,
 			    break_state ? MAX310X_LCR_TXBREAK_BIT : 0);
+
+	if (!(port->rs485.flags & SER_RS485_ENABLED))
+		return;
+
+	/*
+	 * Drive RTS manually for the break duration. HW auto-RTS only asserts
+	 * the transceiver while FIFO data is shifting out, and a break is not
+	 * FIFO data, so on the HW path also disable auto-RTS for the break and
+	 * restore it when the break ends. There IRDA.RTSINVERT already inverts
+	 * the pin for an active-low RTS, so break_state is driven as it is;
+	 * the software path applies the polarity itself.
+	 */
+	if (one->sw_rts_during_tx) {
+		max310x_rts_ctl(port, max310x_rts_level(port, break_state));
+	} else {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT,
+				    break_state ? 0 : MAX310X_MODE1_TRNSCVCTRL_BIT);
+		max310x_rts_ctl(port, break_state);
+	}
+}
+
+/*
+ * Pick hardware or software RTS timing for the current port. The chip can
+ * deliver up to 15 bit-times of setup/hold delay via HDPIXDELAY; anything
+ * longer (or any RTS polarity the chip cannot produce automatically) must
+ * be driven by software via tx_delay_tmr and rts_work.
+ */
+static void max310x_set_rts_ctl_params(struct max310x_one *one)
+{
+	const unsigned int max_bit_dly = 15;
+	struct uart_port *port = &one->port;
+	unsigned long max_hw_delay_ns = 0;
+	unsigned int setup = 0, hold = 0;
+	u8 mode1 = 0, irda = 0;
+
+	one->sw_rts_during_tx = false;
+
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
+		one->sw_rts_during_tx = true;
+
+	if (one->sw_rts_during_tx) {
+		setup = 0;
+		hold  = 0;
+		goto out;
+	}
+
+	/* Convert milliseconds to bit-times, rounding up. */
+	setup = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_before_send,
+			     MSEC_PER_SEC);
+	hold  = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_after_send,
+			     MSEC_PER_SEC);
+	setup = min(setup, max_bit_dly);
+	hold  = min(hold,  max_bit_dly);
+
+out:
+	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
+			   MAX310X_HDPIXDELAY_SETUP(setup) |
+			   MAX310X_HDPIXDELAY_HOLD(hold));
+
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		if (one->sw_rts_during_tx) {
+			/*
+			 * Only settle RTS at idle when no transmission owns it.
+			 * A reconfigure while one is in flight - rs_work runs
+			 * on every TIOCSRS485 - would otherwise release the
+			 * transceiver mid-character.
+			 */
+			if (READ_ONCE(one->tx_state) == MAX310X_TX_OFF)
+				max310x_rts_ctl(port,
+						max310x_rts_level(port, false));
+		} else {
+			mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+			if (!(port->rs485.flags & SER_RS485_RTS_ON_SEND))
+				irda = MAX310X_IRDA_RTSINVERT_BIT;
+		}
+	} else {
+		max310x_rts_ctl(port, 0);
+	}
+
+	max310x_port_update(port, MAX310X_MODE1_REG,
+			    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
+	max310x_port_update(port, MAX310X_IRDA_REG,
+			    MAX310X_IRDA_RTSINVERT_BIT, irda);
 }
 
 static void max310x_set_termios(struct uart_port *port,
 				struct ktermios *termios,
 				const struct ktermios *old)
 {
+	unsigned int frame_bits = tty_get_frame_size(termios->c_cflag);
 	unsigned int lcr = 0, flow = 0;
 	int baud;
 
@@ -969,8 +1231,12 @@ static void max310x_set_termios(struct uart_port *port,
 	if (termios->c_cflag & CSTOPB)
 		lcr |= MAX310X_LCR_STOPLEN_BIT; /* 2 stops */
 
-	/* Update LCR register */
-	max310x_port_write(port, MAX310X_LCR_REG, lcr);
+	/*
+	 * Update LCR register. Leave the TX break and RTS bits alone: they are
+	 * driven by break_ctl() and by the software-timed RS485 RTS, and an
+	 * absolute write here would release the transceiver mid-character.
+	 */
+	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TERMIOS_MASK, lcr);
 
 	/* Set read status mask */
 	port->read_status_mask = MAX310X_LSR_RXOVR_BIT;
@@ -1042,38 +1308,55 @@ static void max310x_set_termios(struct uart_port *port,
 
 	/* Update timeout according to new baud rate */
 	uart_update_timeout(port, termios->c_cflag, baud);
+
+	/*
+	 * Cache the new baud rate and the time it takes to clock out one
+	 * character so the RTS-timing decision in max310x_set_rts_ctl_params()
+	 * and the post-TX delay in max310x_delayed_stop_tx() can use them.
+	 */
+	to_max310x_port(port)->baud = baud;
+	to_max310x_port(port)->one_character_duration =
+		us_to_ktime(DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud));
+	max310x_set_rts_ctl_params(to_max310x_port(port));
 }
 
 static void max310x_rs_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, rs_work);
-	unsigned int delay, mode1 = 0, mode2 = 0;
-
-	delay = (one->port.rs485.delay_rts_before_send << 4) |
-		one->port.rs485.delay_rts_after_send;
-	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, delay);
+	unsigned int mode2 = 0;
 
-	if (one->port.rs485.flags & SER_RS485_ENABLED) {
-		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+	max310x_set_rts_ctl_params(one);
 
-		if (!(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
-			mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
-	}
+	if (one->port.rs485.flags & SER_RS485_ENABLED &&
+	    !(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
 
-	max310x_port_update(&one->port, MAX310X_MODE1_REG,
-			MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
 	max310x_port_update(&one->port, MAX310X_MODE2_REG,
-			MAX310X_MODE2_ECHOSUPR_BIT, mode2);
+			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
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
+		one->cancel_tx_delay_tmr = true;
+		if (hrtimer_try_to_cancel(&one->tx_delay_tmr) == -1) {
+			uart_port_unlock(port);
+			hrtimer_cancel(&one->tx_delay_tmr);
+			uart_port_lock(port);
+		}
+		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+	}
 
 	port->rs485 = *rs485;
 
@@ -1084,6 +1367,7 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
 
 static int max310x_startup(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val;
 
 	max310x_power(port, 1);
@@ -1098,21 +1382,20 @@ static int max310x_startup(struct uart_port *port)
 	max310x_port_update(port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_FIFORST_BIT, 0);
 
-	/* Configure mode1/mode2 to have rs485/rs232 enabled at startup */
-	val = (clamp(port->rs485.delay_rts_before_send, 0U, 15U) << 4) |
-		clamp(port->rs485.delay_rts_after_send, 0U, 15U);
-	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, val);
-
-	if (port->rs485.flags & SER_RS485_ENABLED) {
-		max310x_port_update(port, MAX310X_MODE1_REG,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT);
+	/*
+	 * Configure RTS timing (HW auto-RTS vs software-driven) and the
+	 * RS485/RS232 mode bits. Don't hardcode HW auto-RTS here - let
+	 * max310x_set_rts_ctl_params() pick HW or SW per the configured
+	 * delays, otherwise the chip's auto-RTS would override the
+	 * software RTS hold and the after-send delay is lost.
+	 */
+	max310x_set_rts_ctl_params(one);
 
-		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
-			max310x_port_update(port, MAX310X_MODE2_REG,
-					    MAX310X_MODE2_ECHOSUPR_BIT,
-					    MAX310X_MODE2_ECHOSUPR_BIT);
-	}
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		max310x_port_update(port, MAX310X_MODE2_REG,
+				    MAX310X_MODE2_ECHOSUPR_BIT,
+				    MAX310X_MODE2_ECHOSUPR_BIT);
 
 	/*
 	 * Configure flow control levels:
@@ -1134,9 +1417,53 @@ static int max310x_startup(struct uart_port *port)
 
 static void max310x_shutdown(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
+
+	/*
+	 * Drain any in-flight software-timed RTS envelope before the port is
+	 * powered down, so the last character and its after-send hold complete
+	 * - close() can reach shutdown with data still queued and a before-send
+	 * delay pending. The loop ends when the envelope does (tx_state == OFF);
+	 * the bound is just a worst-case safety cap. Then stop the timer and work
+	 * so neither runs against a powered-off port.
+	 */
+	if (one->sw_rts_during_tx) {
+		unsigned int loops = port->rs485.delay_rts_before_send +
+			    port->rs485.delay_rts_after_send +
+			    DIV_ROUND_UP_ULL((kfifo_len(&port->state->port.xmit_fifo) +
+					      port->fifosize) *
+					     ktime_to_us(one->one_character_duration),
+					     USEC_PER_MSEC);
+
+		while (READ_ONCE(one->tx_state) != MAX310X_TX_OFF && loops-- > 0)
+			fsleep(USEC_PER_MSEC);
+
+		one->cancel_tx_delay_tmr = true;
+		hrtimer_cancel(&one->tx_delay_tmr);
+		cancel_work_sync(&one->rts_work);
+		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+	} else {
+		/*
+		 * HW auto-RTS path: the tty layer waits for tx_empty before
+		 * close(), but tx_empty only reflects the chip TX FIFO - the
+		 * last character may still be in the transmit shift register.
+		 * Let the FIFO drain and the final character clock out before
+		 * the port is powered down, otherwise close() truncates the last
+		 * byte on the wire as the chip auto-RTS turnaround clips it.
+		 */
+		unsigned int loops = port->fifosize + 1;
+
+		while (!max310x_tx_empty(port) && loops-- > 0)
+			fsleep(ktime_to_us(one->one_character_duration));
+		fsleep(ktime_to_us(one->one_character_duration));
+	}
+
 	/* Disable all interrupts */
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 
+	if (one->sw_rts_during_tx)
+		max310x_rts_ctl(port, max310x_rts_level(port, false));
+
 	max310x_power(port, 0);
 }
 
@@ -1291,7 +1618,8 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static const struct serial_rs485 max310x_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
 };
@@ -1425,6 +1753,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
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
@@ -1535,6 +1868,8 @@ static void max310x_remove(struct device *dev)
 	int i;
 
 	for (i = 0; i < s->devtype->nr; i++) {
+		hrtimer_cancel(&s->p[i].tx_delay_tmr);
+		cancel_work_sync(&s->p[i].rts_work);
 		cancel_work_sync(&s->p[i].tx_work);
 		cancel_work_sync(&s->p[i].md_work);
 		cancel_work_sync(&s->p[i].rs_work);

---
base-commit: 9505146e885b1a842118aa6410f737290c4a5a32
change-id: 20260513-max310x-rs485-sw-delay-a306d783d529

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

