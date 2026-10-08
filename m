Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023089.outbound.protection.outlook.com [52.101.83.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A848FF86;
	Thu,  8 Oct 2026 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452970; cv=fail; b=Dus89EDSfDiXwvqqbmZY+/dAjZdWtOGImz8L5CUjyqfIqaLSvhqyiGLNaopswP2tPOad+C6cTT1UFVjj40XnkHCwXc3SK2xkP7a2n/4WVS3rQkjm93cqNYEhnaqMQ1UjsueJC/x1wnWjM8A50WdbbvbMvKyeDquPSMG1QqNkrUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452970; c=relaxed/simple;
	bh=lQORomXZKoGwUpS0uYWGQc8ez7WuXEQubVxg+21ik5w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Hn2fnypIooNu5XuEqjSauMShz01I3aM18Gvk49JEDvZYxEZXX16epHYX9yLgyfbuDEyaWjo9M6rizBCkm2Y+eLu590FWdZhnvltyKy4Fb4z7A2GYbOlyQf7n5uc7hfzu1geRCGfyEF7Zr+XpAdh2UKe338CBRYpkx42acmNcIdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=e1tI761V; arc=fail smtp.client-ip=52.101.83.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="e1tI761V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO9BB1GTNMn9XPZRelehbv0Uayuc+OmxrfNPAjQQAGbVh+33B9BPN2PNdL+U8/Vt5iAe6jl5lq+Sk1JzspghIQ7G+OO6oa5YdWOOchT+irBKoM/f8Y4ElfxNCmgZSv6SU7RgVpsf8h5x+Ic3sGj6QjcV7dLOo6Of2cF38ujZGDAwUcCH6WHjAVsLTxZVCeA6n6GkoNrjNUwxXgCEqDzTkqigGU1ZpHPOftU9mQGPRWHHJCLH549034ix7liYd4zxIL6zqGyUAUVbYZ2UJ6fdPZpir4vx5CLe2Y3rFcYw0/5Lhxc0vtr1Hs4OhV40i+nU0vR2GkFBQHHRAwXdPn46KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi8U9/Ow7qoyKIi4hrdBG2x7DbfukznxOlAaJQJDUis=;
 b=BqFWpaN4s9FrYLKxssFgFDBxXPP7ne19t36KYRoUIPKRXjk5C+PJLAZ7k8dyzksDKk6fZrClscOutAoQB/rs1P9DBQQHA6EINXXTmocFxRU1ByJFNugW88Nc/LsTje3MLKQ/Vw1URFIJwupcVvpqXD5EeVox6WkGBBOCpnTiO0DoCK5dg4lvSTLY6mJAX7Kt4JgcsghYTE9BRs3UlorF98rj2xa+N5JbHrWzioYQkI4wyuNQENhu1E5l19NQDPqSPDmfhn+AjjNxikICe8/B0HIXRJ0/x+UyeCkLgklZzSD6rn3c+kzfw6uOQL5JAqGNk3jnGEU63qQVNNxbJvQQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi8U9/Ow7qoyKIi4hrdBG2x7DbfukznxOlAaJQJDUis=;
 b=e1tI761V+VzQO5zYSHLdFF6PVQ1xYGQU5Y51KQ2pJTGWGD6P0tqSK2Xm+fcDcriT3fyG+BSfw2/PE257wIsZr5KK6E8TLmQTVcTvRtGEV4srS/tuQN+H040SKnqBJD5SYUIWn018nNftyBMa/VS9kG0qBZWTt/Hcz6+Taa/VoS2fvncUiJoOEjSzj9QbAoJDp/n1m18lvkVb6r4e4XwTxbWwkjx/4HyPzTBsIdzZFv5pSLHgaPTcY+UBON+n/pGakUE7AtvLfqwFrrOxmH0ah9MA8qff5H7rNU0Ht3Si5YzPQiWm08V6lTwGbUdo+sVIyW5XA7AMBPfjjmvYmrh9hg==
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
Date: Thu, 08 Oct 2026 09:48:31 +0000
Subject: [PATCH v8 8/9] serial: max310x: drive RTS in software when
 hardware delays are too short
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-max310x-rs485-sw-delay-v8-8-6ba881f81e1f@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791452935; l=32271;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=lQORomXZKoGwUpS0uYWGQc8ez7WuXEQubVxg+21ik5w=;
 b=qgj47ELPHedH7Ks2krHB+Lk3ov/02uRxroaUzThiyheXW8D5eMDxAaLOFBaQPVyj3XbLTskVa
 VLwQf1PcbfNDNldBFWGtmIPHm20BtW6/d3gT7PW6TFidIRY2XqUgX6m
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
X-MS-Office365-Filtering-Correlation-Id: 98f04632-f5e9-4cd5-7584-08df25216247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|260925021311599003|260925022911599003|260925021911599003|5023799004|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	K6tIRsNODFMQ6ZXS2qisSz0ApgxhFPE8tI04ICR1HlsXUnWmCGM0bwBHwzGZVdIVElsql26rd2QGjgnqhCoTZk0kEp0eG5NDD7ZO5KRAJoLyVwXmNZO3NSCxvHkLMdu3rQQLYIPJtc2jp9uAmasBwDbHlEpWXYHGE/quyMKhkmZfchSXgMMrzdQORaJed16t5YHE6Ko8wPdgIn5AKPrUXu8iLV0uZcQc+RWCB2jq1gSyje63nNvTg5GzW/u0rAxO6EdoCGnitRYPaJKfpVEYJUhpJADEcfDFIHFuuxaSPJo33nYGeqhJPyWHRlHgEFcrZW6bfLNMnkSg8A5B0QqiB5/KaGNf5N0orNUz9vXe3y4HS+3pnrXa0mI1YYnnvZe8gzjaqFBeTJj9U9jHsSEnQmV3ycG42r6ee+vtfATumLx78yhyfRpkIAl32mhbZRRuzH3uf9l2dWty6MYrXdhV249brptzP1xcPbMMq4D9on00xfI35bccGORv8htPVOmk8GyYC739uW8KTmNPI3l2Su6fo6vIoa7GgtnFp0d0RCb7pGUnlFlbeBIdFHNoYXt3Jqw5Gnwhh0KK0a5zy/HmSlSV59yBB7XZIFsjS1pUbHJ2pfuPig9asS4JvIpJhcsOEUBYtomMv6cwhOJZEmL1LPWvcuWK/jhcOKlGCY4tCBY9vWLS8TPDETCES8ZWejp0KOKDSfbr3KKkiQkAk2mT4RQpLFR7sOTNexxJyWAzdns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(5023799004)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUdpbSt4YlQ1ZFU5L0ZUbXZWU0UyL25hOEpSQjhjMCs3aGZLMldUTkFTcWNl?=
 =?utf-8?B?c2pPRm42MFdJcXU2ZnBKemZCUW9iOFlPRnArRXdYbEFjK1l1SlQzNzlQZVNE?=
 =?utf-8?B?dU85RXBOYnlwcno3RndEZHUweUZwblFZcVdRZi9PQmcwaDN6b0lodDJqU2pZ?=
 =?utf-8?B?aXE1U2FBWXNMaFJkcTVxTmlrdmlhOEVuYWpHQk9sUG5iZ1hKc3RENFNCdjNv?=
 =?utf-8?B?ZkhmMkdDdzVqRGx5SjEvdjA3UnluMFVONElxRk5KVklYeko3QmtnVDB6NWF2?=
 =?utf-8?B?b2JaVFZ0Y0lwb1I3WEZkOHc4ajkzUTNXSmZFZDFQVEdLRkd6VU5VM0NsQnlk?=
 =?utf-8?B?TDdvWFRHS2VuMzZLWnhCVFhrZlZUOC80cDRGdU1uRTBQbzkvdnRuQTBHMEU3?=
 =?utf-8?B?MWZqN2I3SEdKbktaVWFHbDRDUjZ1QjFoTEN6TUtxeitYaG9XckZucFlBYVlV?=
 =?utf-8?B?N3NtcUxVZjRXVHZoOXFET240YjFGamdaclNTam1YTEVrdE5mVnlPSGpIczN6?=
 =?utf-8?B?QW41R3lmWkQrdlVRT1BoajROL1JEZm10VUhnZ0U1TXFERmN6aWViaTJScWow?=
 =?utf-8?B?c1JBd2xKNHBBcVZ5M2poZDQ5dWZ4Z2JKMWVLcWZCbUJDWkRjbW92a0tiSmdK?=
 =?utf-8?B?aWJlSzJqK1lJUE9pTEpBY29yUnhvZk1NeDJMK3pJTE5LYmk0eVNwbzJCekQ0?=
 =?utf-8?B?S1A4L21ETmVpY1dkeVdqOU9XczQyWW9YUlBNd0IzSnh4MU5SZU93ZnFEK0I3?=
 =?utf-8?B?YjhWaGlDdzlNb2dLTTdYN2VvWTVQdUNmZTFPaUxDR0UvNGloL013VElNVjcy?=
 =?utf-8?B?eDlTTG5aenBHVG9FOEdKdTZ5Ym9vN0J1akg5Qk8xODdYazBKQURIZlprakY3?=
 =?utf-8?B?T2w3L25LNnVTcnlFc09VYVg1MCtNUVMwc0VwZWlScmlZREcyWkFJTmNwYXRU?=
 =?utf-8?B?bGtJeWNMWnllRVJLamUyR3ljUklhS3ZPREQvd251SWpIZkZnNlQycnVlQlR5?=
 =?utf-8?B?b1BQWE0wcjRhNGljRGhRWTF1Q1pjRXpXM1VjYXN2TWpzaFZ1ZWJZN2JpWGUz?=
 =?utf-8?B?WFJtemZkOVh3cVdVMHo0dnlwYnlxRTN3TWNLY2cvSmZkeWVaMHVlOEVmbHBs?=
 =?utf-8?B?eGZadmJpM0c3aS9Oald6bDMrdGRINDU3SlFqVEkrSkZUa2ZwM3dQbGFFM1ht?=
 =?utf-8?B?T05NU2FieFBkM3Zrak5UbWI1MlpNc1BzczEzT1kwWGJHZDRER3huQ1NwTmNr?=
 =?utf-8?B?Wkg4OGMzK2d5Yms2bEVnSUZQU2kwcXU0dVNLaUdDZmFLUHhyOGFGNVh1V3E2?=
 =?utf-8?B?eDBxN0ZCdWtxYzhVc0RpNy9GQjRrblRSajNjc0hLMnp2NUxyTnR4TzRmc3FB?=
 =?utf-8?B?OHFvVktXR2xBdGtaYVZPQmxRWHZ5ZnZiWGVkOHFURGNpYWVZN0VmcnBVSVVX?=
 =?utf-8?B?dGlHTU5vQ2pCYkFQT3BEU0RkQUtUaTVESTdNQ2pCWEc0dmw1K1VXRSszbGh5?=
 =?utf-8?B?ZnpCZEo5ZFgyNEExclQzS2tWbWJYNllBRzRXTHNXcitHK0FMZWQ1NXI3dmI4?=
 =?utf-8?B?cXNYbnNiUzNyV0xiQXdsWENRMHZ2TTRGSERCQlJ4d1lEc2hVdkNZVXpBeWVr?=
 =?utf-8?B?MHhHUHdJV3FEc1dkUHA2RmdqVDhIUk93VW5YRmdUMXhEb2I4YVJ1enJaQWRh?=
 =?utf-8?B?ODRXVkloUGJqZHpteklGd3VoZmFuTWFZbzI2a01xNWpDcUQ0Y21KckZqYjNS?=
 =?utf-8?B?YlcrcC9oK3ZCbURYRGZ5TVJoVGRydU16MjFlNHlvMnpXL0UxVjIrNzVqK1d4?=
 =?utf-8?B?Y3VZTmFjUzJZUEpJU2R5d0ZIR0F3eHpWbVJnc0FLbGNpLzRlSVp0cnZJbmZp?=
 =?utf-8?B?L2VyUFpBQXp5cFp6ZGVreHVoeUI5UWtveXFyR0I4Q3pYdndNcHB2QUV0eFZs?=
 =?utf-8?B?SnZCd2Q3Ym5TMkowQ2t1TmtsbFBtaXR5SG9ub0VSYnlnMDVITkJUVkQ3TzZO?=
 =?utf-8?B?NW1YMGVhYzVGZWZ4WVIycGYvUHlGRHJDd1JDc3FFeXVFT1c3SXZWSER0SjJT?=
 =?utf-8?B?UVR0WXl1d2xQUUEzOVYyNEl2VHcvWFFyZmFwazd4aTF0OUY4Q2tmTWtzanpS?=
 =?utf-8?B?TWl3ejE4Vlh3dzRMNEpLVURlRnZVSXZWSDNyVC84amNVWW8zN3JKTUo3NWJB?=
 =?utf-8?B?bHdIazdTanR1bjNheDJDUDFyeXRLVDE0Mkk4b1NoTnlVd0h0UktTd25sMndI?=
 =?utf-8?B?UytBc2R4MXl6UlhpcXU0SFpZSTZCdVFYQmdKSEtwcHZBcEJ5enI2OWtEUUdY?=
 =?utf-8?B?RCtHQStBRjIvTnorUjRteGRaL21Ea01oYTJvT3lNR3R3a1c4UVBQU3MzWlJi?=
 =?utf-8?Q?HOiliMVHVtYKMVus=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f04632-f5e9-4cd5-7584-08df25216247
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:49:02.5120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMHGungCYEymYRVrc6DbA6CurNa/vbVyJuw9yG+f4Fg4yA2uRfMzf2+mrDCIiU9Nf9dDc6XtfC+lv1r5otIVe3uGHbOv9mRTyaJVPq1QmFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7567

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
toggles ordered. A start_tx() landing while the envelope is already in
its send phase only pumps the new data: rewinding it to the
before-send phase would insert a spurious setup delay mid-stream.

Teardown is interlocked: shutdown() and an RS485-disabling
TIOCSRS485 set tx_teardown under port->lock before cancelling the
timer and works, and start_tx() checks it on entry and again after
the hrtimer_try_to_cancel(-1) path retakes the dropped lock -
otherwise a write racing the teardown could re-arm the timer or
queue rts_work against a port being shut down, leaving the
transceiver driving the bus after close. The rs485-disable path
additionally kicks tx_work afterwards, since a racing write may have
queued data with no envelope left to pump it, and shutdown() now also
cancels tx_work, which was previously cancelled only in remove(). The
interlock also fences the adoption path below, so a reconfigure racing
a teardown cannot re-enable the cancelled timer, and an RS485 disable
flushes a queued rts_work before the pin is settled: one already past
its tx_state read would re-assert RTS after the settle.

set_rts_ctl_params() publishes sw_rts_during_tx with a single store
and settles the RTS idle level only while tx_state is off, because
serial_core calls set_termios() without port->lock and rs485_config()
schedules a reconfigure on every TIOCSRS485 - either could otherwise
release the transceiver mid-envelope. The settle also re-checks
tx_state after its write and requeues rts_work if an envelope started
meanwhile: the state read and the register write are not atomic, and
rts_work re-derives the level from tx_state, so this converges without
locking. shutdown() gates first - the
interlock is set and the interrupts are masked before any wait, so
nothing can start a new envelope or requeue tx_work behind the cancels
- then honours a running after-send hold, bounded by the after-send
delay plus two character times (the transmitter is already stopped by
this point), and cancels the timer and works unconditionally: a
TIOCSRS485 can clear sw_rts_during_tx while an envelope is still in
flight, and neither may outlive the port. A hold that did not complete
within the bound is settled by the final release below regardless.
break_ctl() on the software path applies the
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

shutdown() gives its final RTS release one bit time, and at
least 100 us, to reach the pin before powering the port down. The
power-off stops the UART channel clock, and the RTS output stage is
clocked by it: a release written immediately before the clock stops
reaches the register but never moves the pin, which stays asserted
until the next startup restarts the clock - a close racing the
after-send hold expiry left the transceiver driving the bus, with the
register reading released and the pin high. The measured propagation
is about one tick of the 16x oversampling clock - below 50 us at
1200 baud - so one bit time keeps a 16x margin and scales with the
clock the output stage runs on; the floor covers rates where a bit is
shorter than the measured bound. Handing the pin to the
chip's auto-RTS engine instead was tried and rejected on the wire:
the pin level is RTSINVERT xor the selected source, so for an
active-low RTS every single-register step of that handover drives the
pin to the asserted level, and the same clock stop can freeze it
there.

Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 488 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 436 insertions(+), 52 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index c1fe4ad8878392613cbe4d7805eb8ecb454176d6..5fdb9dfca6027ff0a9284ed994000a5d7587408c 100644
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
@@ -829,11 +955,64 @@ static void max310x_handle_tx(struct uart_port *port)
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
+		/* Already sending: pump the new data, don't rewind. */
+		if (READ_ONCE(one->tx_state) == MAX310X_TX_SEND) {
+			schedule_work(&one->tx_work);
+			return;
+		}
+
+		max310x_delayed_start_tx(port);
+	} else {
+		schedule_work(&one->tx_work);
+	}
 }
 
 static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
@@ -946,10 +1125,39 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
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
+		if (one->tx_teardown)
+			return false;
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
@@ -957,25 +1165,35 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
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
@@ -983,12 +1201,66 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
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
@@ -1016,12 +1288,27 @@ static void max310x_break_ctl(struct uart_port *port, int break_state)
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
@@ -1063,9 +1350,10 @@ static void max310x_set_termios(struct uart_port *port,
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
 
@@ -1143,7 +1431,9 @@ static void max310x_set_termios(struct uart_port *port,
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
@@ -1163,6 +1453,10 @@ static void max310x_rs_proc(struct work_struct *ws)
 	 */
 	guard(mutex)(&one->port.state->port.mutex);
 
+	/* Flush an rts_work that read tx_state before the disable cleared it. */
+	if (!(one->port.rs485.flags & SER_RS485_ENABLED))
+		cancel_work_sync(&one->rts_work);
+
 	max310x_set_rts_ctl_params(one);
 
 	if (one->port.rs485.flags & SER_RS485_ENABLED &&
@@ -1173,14 +1467,37 @@ static void max310x_rs_proc(struct work_struct *ws)
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
 
@@ -1215,7 +1532,15 @@ static int max310x_startup(struct uart_port *port)
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
@@ -1246,7 +1571,15 @@ static void max310x_shutdown(struct uart_port *port)
 {
 	struct max310x_one *one = to_max310x_port(port);
 
-	/* Disable all interrupts */
+	/*
+	 * Gate new transmissions and interrupts first: a concurrent
+	 * start_tx() either sees the interlock or happens-before it, and
+	 * nothing below may start a new envelope. The timer and the works
+	 * stay live for now - they are what completes a running after-send
+	 * hold.
+	 */
+	scoped_guard(spinlock_irqsave, &port->lock)
+		one->tx_teardown = true;
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 
 	/*
@@ -1256,25 +1589,69 @@ static void max310x_shutdown(struct uart_port *port)
 	max310x_port_update(port, MAX310X_MODE1_REG,
 			    MAX310X_MODE1_TXDIS_BIT, MAX310X_MODE1_TXDIS_BIT);
 
+	if (READ_ONCE(one->sw_rts_during_tx)) {
+		/*
+		 * Honour a running after-send hold before the port is
+		 * powered down. The bound covers the final character -
+		 * tx_empty() cannot see the transmit shift register - plus
+		 * the hold itself. Data beyond that is abandoned: it is
+		 * only still queued when the tty layer was told not to
+		 * wait, and the release below drives RTS to idle
+		 * regardless.
+		 */
+		unsigned int tries = port->rs485.delay_rts_after_send +
+			2 * DIV_ROUND_UP(one->char_time_us, USEC_PER_MSEC);
+
+		while (READ_ONCE(one->tx_state) != MAX310X_TX_OFF && tries-- > 0)
+			fsleep(USEC_PER_MSEC);
+	} else {
+		/*
+		 * Let the character in flight finish (the chip has no
+		 * transmitter-idle status), then empty the FIFO: auto-RTS
+		 * releases only once the transmitter is empty, and the
+		 * power-off below would freeze an asserted pin until the
+		 * next open. The hold is at most 15 bit-times.
+		 */
+		fsleep(one->char_time_us);
+		max310x_port_update(port, MAX310X_MODE2_REG,
+				    MAX310X_MODE2_FIFORST_BIT,
+				    MAX310X_MODE2_FIFORST_BIT);
+		max310x_port_update(port, MAX310X_MODE2_REG,
+				    MAX310X_MODE2_FIFORST_BIT, 0);
+		if (port->rs485.flags & SER_RS485_ENABLED && one->baud) {
+			unsigned int hold = DIV_ROUND_UP(one->baud *
+					port->rs485.delay_rts_after_send,
+					MSEC_PER_SEC);
+
+			fsleep(max(DIV_ROUND_UP((hold + 1) * USEC_PER_SEC,
+						one->baud), 100U));
+		}
+	}
+
 	/*
-	 * Let the character in flight finish (the chip has no
-	 * transmitter-idle status), then empty the FIFO: auto-RTS releases
-	 * only once the transmitter is empty, and the power-off below
-	 * would freeze an asserted pin until the next open.
+	 * The wind-down is over: cancel unconditionally. The SW/HW decision
+	 * is recomputed on every reconfigure, so a TIOCSRS485 can clear
+	 * sw_rts_during_tx while an envelope is still in flight, and
+	 * neither the timer nor the works may outlive the port.
 	 */
-	fsleep(one->char_time_us);
-	max310x_port_update(port, MAX310X_MODE2_REG,
-			    MAX310X_MODE2_FIFORST_BIT,
-			    MAX310X_MODE2_FIFORST_BIT);
-	max310x_port_update(port, MAX310X_MODE2_REG,
-			    MAX310X_MODE2_FIFORST_BIT, 0);
-	if (port->rs485.flags & SER_RS485_ENABLED && one->baud) {
-		unsigned int hold = DIV_ROUND_UP(one->baud *
-				port->rs485.delay_rts_after_send,
-				MSEC_PER_SEC);
-
-		fsleep(max(DIV_ROUND_UP((hold + 1) * USEC_PER_SEC,
-					one->baud), 100U));
+	scoped_guard(spinlock_irqsave, &port->lock)
+		one->cancel_tx_delay_tmr = true;
+	cancel_work_sync(&one->tx_work);
+	hrtimer_cancel(&one->tx_delay_tmr);
+	cancel_work_sync(&one->rts_work);
+	WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+
+	if (READ_ONCE(one->sw_rts_during_tx)) {
+		max310x_rts_ctl(port, max310x_rts_level(port, false));
+		/*
+		 * The power-off below stops the UART clock that moves the
+		 * RTS pin: released too late, the write reaches the register
+		 * but the pin stays at its old level until the next startup
+		 * restarts the clock. Give the release one bit time (at
+		 * least 100 us) to reach the pin - the measured propagation
+		 * is about one tick of the 16x oversampling clock.
+		 */
+		fsleep(max(one->char_time_us / 10, 100U));
 	}
 
 	max310x_power(port, 0);
@@ -1566,6 +1943,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
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
@@ -1676,6 +2058,8 @@ static void max310x_remove(struct device *dev)
 	int i;
 
 	for (i = 0; i < s->devtype->nr; i++) {
+		hrtimer_cancel(&s->p[i].tx_delay_tmr);
+		cancel_work_sync(&s->p[i].rts_work);
 		cancel_work_sync(&s->p[i].tx_work);
 		cancel_work_sync(&s->p[i].md_work);
 		cancel_work_sync(&s->p[i].rs_work);

-- 
2.47.3

