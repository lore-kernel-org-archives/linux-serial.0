Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023111.outbound.protection.outlook.com [52.101.83.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DFF3AA19B;
	Mon, 14 Sep 2026 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371486; cv=fail; b=onmTujqHIdkl+AvXX+EuU2F35QWSno8ba8nIcty8b6LxbLOVoPgDs1kgkNdtR5Ln+x++xtQwAbQEoevfw6/Yd907WrR72CnvOZRvk6SjxtdKi1HbGhHB6RSSikZa5Bo0/cokBoM1HIw/RADPc2YcpBatLu9J1BbmvbYuFLLrN+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371486; c=relaxed/simple;
	bh=M/kR3T4nQykEZ95QqRT/t6+mpBZerEkhyzERcdJTCMs=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=CLlja96E95GF+tFJWoJUiQfSID6kjqZ0PV8LrR9UstdjLJvmOppW/TR6RYPEHZZyDMJysA/w0zxvmFI5TJuXFnk1BM9elFu2Ycx4uRzy14I1Q0tGhu7KoBjAnjV6uHEx2S8srbjH0ZG85m+6BF/pYMj1FR4DsTCYP6FMjwtrYOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=QRz3zlC6; arc=fail smtp.client-ip=52.101.83.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="QRz3zlC6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7bvXihVxbB7/4ix6XfluLxckI/Mjy4v39U+6vbnkpncwUqRoRirVQ0XTlBfNoT9hWhbDUQeIAJDLRyFBrw2sqUwc1FlHd3oTh+hSg6tFID0nynXLCs8SKiM/37eF6h8nweK+e4IvuLrMPhGrauC9Sc4CgJzh5vnNdYuu0RsZV1/A07eSkX5CjF+LXBRl7m4TwNRCmTXvXGlhaDXb7FxaQ5c28oxrDhcNprtob2v866EdVjhsnIln9WRLE5MZSaraGmlJQp3DVXColYSLMpyhxN52ZxpFukV9RkyRpSqpyaaH6QfikCXDbQqyWF11jh7Iyl+yypGluN6BQYdYlWDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltqOH/FiZk0r8fqe6fDlJ51I8IvEXfDd8DbemtvkCt0=;
 b=SDkMtsByrvyNmtE3ltAFYWxcnZxZF09AaDXyjy4xr7y60C+WJq4w9mDj5a/4Wv/oE1TkLohGWr7nrqF5huzSkjhzvg1tgpOPYjB6ZoiHsWc3IpkIq+7LelIQ9HiE/zSBpv02Cnoms+ukZREF76Iz1uF+jIskE4/WmWHpXsEpclESorZj3s2oaeF1NfGlU8Jrb81OBfZWHNrMCrBwmp3a39QQI3RwrWIfW1yhz0nEYz4ULmAuDwauf8t2KBpjzzskqxTT3WEnVuHcAWnXalsrpeVciLXn8HXbWCyWwTaES30sNgd4Dde/b+H6SNQPqjZJlqjhjRgWlqJj3mnozkGSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltqOH/FiZk0r8fqe6fDlJ51I8IvEXfDd8DbemtvkCt0=;
 b=QRz3zlC6gKYWkUOOMkIKmbXmTMJZg1zxwZiDtL2iL7AT1ZBfJT/4UIwXg0lsNJueyCV6/GZK+sgaCT1ng6y42V9/qFr2dIPqr8L4zmltBngzM9AgUzLgcgFQSdo84CSobrDMxxcLci+4Reyu+N3CZlMR/SSQ6BovRrRXaHDchAYgaXR5smCUlulWM3RAR0vHhHRdwapTfny0Vm7fbBm4Cxks5/l34pUivReFc459IYrbJOI8OybbR+ZGL05QnWaN53rCsZwvyG6oPcEgXkrsgJJgpbInRWzWwZ45E/8ZMCba9Pi+yaakC6wlgfxcC+zPSGefAyq3URLsOBOKYxZgJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by GV1PR06MB9764.eurprd06.prod.outlook.com (2603:10a6:150:1cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 07:37:51 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 07:37:51 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 14 Sep 2026 07:37:42 +0000
Subject: [PATCH RESEND v2] serial: max310x: drive RTS in software when
 hardware delays are too short
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-max310x-rs485-sw-delay-v2-1-9a7b681e64ce@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789371470; l=24070;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=M/kR3T4nQykEZ95QqRT/t6+mpBZerEkhyzERcdJTCMs=;
 b=s2Mn2XtEU8WkW4IMX2ia6JhEA46I5XAgyf57pgC7t0xch/tzwyj6QSoN1mX1r/kt5CzO5LpOv
 o3CHWmaMPXwAbHgMvKiEbXZbZ0bS1pq2/4ZIPudaerbroYjtgJquGwl
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3PEPF0001DC16.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::270) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|GV1PR06MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: f1323d5c-d209-435d-c9d6-08df123314e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|23010399003|366016|18002099003|38350700014|56012099006|11063799006|5023799004|3023799007|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MexSxEJYK9djFl5G4lOpBT6DwgaKmR64e40JlLSnuMyMI407UBvflwHKM9qXVQCaWz+Kwe1tVbgIWTUu4rOxIkrxaXQeSDbqKlw6hELj5w3Cne3VYX3TXlJuqoNhzBUijqpx5NGGV+07nsyCwbTgmEhsGrOv7L1chmvAKpbp+o6tmfWJQ90Y5F0+1NuV+OTWHU1AIbE2U6JLKUWjNvlyGfIbHvXalUbrM+Y0vOr7uqNeUmgK6awuriohK8bmHJW5CXEI5S+EV76IrtVhwTSh8msMWmWwjIR9EzdLOTgEx5XwQOaWy+ShfJOGz3Y4WysWXXeFpaymb6qEZXT9yOBAMO9qw07w4pArK9hmyWyJcqWIqEFcoLz2+tuSdZwXYAyZjtm/bhBlHrlnxy6s5ItgYlesX5YUzqO/f9GjR0zWdl+CHM/hGd4m7okML7wNtYHSSU7MmKHAj4rBJu0FNrj8sC6H3Tck7j/zCcolhY1s1ghgdkzfi0cktd2TF2DzW2/kYz0w22uZiqcSqTfz//NZ/gPNeLg2kHv1q7tSAHAVR9NH8CXd143Ump1zPbkgkdG/iIQ8hwmiFa2nV579rwRB9/vT/+Av8CmfQs4A5vvzunuEuxwspT/r2XkOxBBoN2sMasXic3R4DziX6WMA68OEEp31NaQX9vua8qkpf7RN5/8LbkW+TjYzTCyUz1Boxv1uf/V+OyvCYHZ5RXkzgkdhHCOGejL+zTJJ0qXnnv0Oed4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(23010399003)(366016)(18002099003)(38350700014)(56012099006)(11063799006)(5023799004)(3023799007)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUtnR0xUQ0hld3BEbnR5clREZXoxbjJrYnNqeVZ3NEdMTjl4QmwrRkpCRE5C?=
 =?utf-8?B?Wjd4Z05nbzFuS0FOZlRiaFBLTHYzK0lUZ3M1U2ZESWtqTXVWSnA3ZzZPZzJU?=
 =?utf-8?B?Uk5xd2tPbE95a210cHhTYUdtZkRHLytLMVBEWlBvN1J2ZjY2Nng5ZG9TZVdH?=
 =?utf-8?B?RjNQMkF4NWtDdVhKRnFCZzNGLzNrcVQ5dHNwQTlOKzIzNUd5RW5TUVB6N3p4?=
 =?utf-8?B?SUVjZnNIL1dsZ2xYelU5SlYra3lTUko0L2tvVkFTUTJBaGwwbHNNbnBhbnRu?=
 =?utf-8?B?b1JubVNJa1BFTUlEUHdIWVdvRUppdzY3dS9DSm5GWlRyeC9DVVVOZUVsZjJS?=
 =?utf-8?B?T3NBSElDYkFxdUVuRUM1MFJmWmVxMzh0MGJOMzN0alQrbWRBU3NKZ1pFeWow?=
 =?utf-8?B?SnR3ZkpZYXNpTHdhOE5kT1VYdDdpdFVKU05JV3ZKcDBQQnY2dkxtOVhBay9x?=
 =?utf-8?B?YnZjNThiZEdvZGp5dWZLbW1uVHJ2cFpldGRzZVJZeEd2UkNlMSt4NmNORGJT?=
 =?utf-8?B?WnYzaXhCOFEzQVpiTFFQMTVLa1NqUzcvMHFsNFpLZFl2c3FBVWVrMllJTXFx?=
 =?utf-8?B?cUxQb0VOK2ZYL09lLzY5OTQrV2hwdXFibG1hamN4UWhvc2lkUHV5WWlWWFdu?=
 =?utf-8?B?QWE1TEtZZEJLQmJGTGlFWnVGQnlHTE0zWUFHU0k4a2duVVZMcmdUdis1dU1Y?=
 =?utf-8?B?enkvei83SWFJWXVqTEV3RWljYVZIaXp4cktFT2hGa0xTb3RGcDh0VEpac2xk?=
 =?utf-8?B?azdoY2EzWitLZFlDSnk3S20wcVRsTmFha3NYeFdKTnNVRUx0aXlUdFNhWmJZ?=
 =?utf-8?B?UWhyM1RnUG0vSy9vZnd3RXlyeUc0NENSdlU5d0RnaUZaUFVFWldXUmpFNGRD?=
 =?utf-8?B?REFBSzNjcXBodnBzSHUyQlZGSUc2WnpwWXRmbXlVQzkwVUk4VzdlQjFvQlJ1?=
 =?utf-8?B?NkVUUDVNa3ExanhIOTdZQjdsZWJNYk9aak1adUV4TFEwSkFONW53NGVoRURl?=
 =?utf-8?B?KzZoZUlQajBLNEw5bHNpdldtQmxsWEtDSkZaWjNMcTlsenB2S0lSNE9LclNl?=
 =?utf-8?B?M0VZOVFFZkEzQnVNRWluN0hNdW5JT2pCandnaXpkRWprR1B2UlNaM0FxNmVM?=
 =?utf-8?B?TEtLa1h1Qm9Ed2FlOFZSQnFCZEdpcWxiTkwyWklDeUx0VWVBS0ZIa2l0UC82?=
 =?utf-8?B?aXBnQ1JBcjZMTVRYeDJNUTVoMlJTcDJoWkxJQ2p2ZmdkUlFmNnJkdzhBcWti?=
 =?utf-8?B?V0VId1hrbmtYYUowczViSTdYVjEyRmVyaEhTT1puMzNjMEljemNiZ1RUOWUv?=
 =?utf-8?B?azJ0cFVtdzNQVStiZDYvTGFNNG9FWUZ3bUxVeHpIVnhDWjYyTTlqNmUxeWZX?=
 =?utf-8?B?VkFMRXA2YXZWMHJ4KzJNVW5jRU5yd0F4dkxrVnZ1aS9ORlhNZ01HdVBOS0V3?=
 =?utf-8?B?YzVheWtiL2YrZXphV2JLZFlXZDhOMGw2OHVtbGpWcWJIYk5YZkh0OEJNSi9M?=
 =?utf-8?B?OWlqWDl0V2hpdzFydFBWK2JOZVVCVXB3ZW9ZaHI4RXM3TGhRMDNMZnRwSUxD?=
 =?utf-8?B?aDIvRkVKYWFscjlBNTI2TVp0R0x2ZjBUeXQrVnphSzZWSW9EWjJVTlRmUGY2?=
 =?utf-8?B?alBXWlBzMkpLcmdiYnV5WnBPMnpqRWhOU2dLN3lSeGhPM1dsZDZyVU5QamY5?=
 =?utf-8?B?amo0a0dDaE9JdVRnei9JUi8zQ0lHcVV3cnI4RHlzT0hERXFrdkcxRTVHK29j?=
 =?utf-8?B?QjhseS9CZVRBd1I5RGQvMzlOZ1MzQnhPL2pXUThRTzRPc0tDZGR5eGlna3VG?=
 =?utf-8?B?TzNDU0dGNUpLWjROV0NDRGI4MXdLeG9MeGdWRkl5MXlIUUZHQzFiQWlnd2J6?=
 =?utf-8?B?K1RCaHFraDM5L204d09xTXdkMmlNVjdlNlBQNEpMSGlRTUVtdzVKMmFxWjZM?=
 =?utf-8?B?U3hDZWNkOVlFQTBSRmZ2eVVmdzZ0KzFUYjNCVTdCQ285TTh4L2FQNVBNeDRP?=
 =?utf-8?B?eFkzK3I2OGhkc3QxWHBzZ1B4OENOMGU1VTVDNEV4dXJBcGtaNHFQQ2JObDkv?=
 =?utf-8?B?R2Y0amhpSGs2RjdWUHRsTzhsYWNsdXRSb0VRUjlpVE1tOG5xZHF2cit3QVBa?=
 =?utf-8?B?QkZLZzc2Ty92ek9pNmRNc0tYMzhOaFE2UzlKTlRkc0pSRk52bGQveFhmZHps?=
 =?utf-8?B?Q2NjWjNzQ2crN0ZqNTZlU2RlT2Z0R0ExZTBxVTZkOW9jakxYRjJxMk5zaElS?=
 =?utf-8?B?bHB1K2YvU0Q0bUhqN0dmQUVSa2RKWDR3OG5PYjJPdzVsdUJjNnExZDJTcy9S?=
 =?utf-8?B?bGFOblY4UUpXRVY3NFd3a3VWL1ZoUE42ZFJ1Q2wyNmp1VmxZMzB6cEpPano5?=
 =?utf-8?Q?XMwyu5n9kThtg7Es=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1323d5c-d209-435d-c9d6-08df123314e6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 07:37:51.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgPlbvaxelnz+ooVGthQWEiLiZfQyyIBN317JadmhEhv5tVetJaEOQN3L79YbH5uoMC0WkbVYOkiG6J+7iOMXzHutips2d2iX/BoGnWMdt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9764

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
    break ends.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
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
 drivers/tty/serial/max310x.c | 383 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 349 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 022502986c5fcf1ff4de9328746ddc71677be730..453c4aca2f2d9901f410d1851c11d45c1403d309 100644
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
@@ -162,6 +163,11 @@
 /* IRDA register bits */
 #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
 #define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
+#define MAX310X_IRDA_RTSINVERT_BIT	(1 << 2) /* Invert auto RTS output */
+
+/* HDPIXDELAY accessor macros */
+#define MAX310X_HDPIXDELAY_SETUP(val)	(((val) & 0x0f) << 4)
+#define MAX310X_HDPIXDELAY_HOLD(val)	((val) & 0x0f)
 
 /* Flow control trigger level register masks */
 #define MAX310X_FLOWLVL_HALT_MASK	GENMASK(3, 0) /* Flow control halt level */
@@ -290,12 +296,27 @@ struct max310x_devtype {
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
@@ -680,6 +701,37 @@ static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int l
 	regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
 }
 
+static void max310x_rts_ctl(struct uart_port *port, bool rts_state)
+{
+	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_RTS_BIT,
+			    rts_state ? MAX310X_LCR_RTS_BIT : 0);
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
+	max310x_rts_ctl(port, rts_on ?
+			(port->rs485.flags & SER_RS485_RTS_ON_SEND) :
+			(port->rs485.flags & SER_RS485_RTS_AFTER_SEND));
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
@@ -776,6 +828,71 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
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
@@ -787,8 +904,13 @@ static void max310x_handle_tx(struct uart_port *port)
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
@@ -813,11 +935,48 @@ static void max310x_handle_tx(struct uart_port *port)
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
+			spin_unlock(&one->port.lock);
+			hrtimer_cancel(&one->tx_delay_tmr);
+			spin_lock(&one->port.lock);
+		}
+
+		max310x_delayed_start_tx(port);
+	} else {
+		schedule_work(&one->tx_work);
+	}
 }
 
 static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
@@ -843,7 +1002,7 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
 		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
-			max310x_start_tx(port);
+			schedule_work(&s->p[portno].tx_work);
 	} while (1);
 
 	return res;
@@ -927,15 +1086,101 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
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
+	 * restore it when the break ends.
+	 */
+	if (!one->sw_rts_during_tx)
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT,
+				    break_state ? 0 : MAX310X_MODE1_TRNSCVCTRL_BIT);
+
+	max310x_rts_ctl(port, break_state);
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
+			max310x_rts_ctl(port,
+					port->rs485.flags &
+					SER_RS485_RTS_AFTER_SEND);
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
 
@@ -1042,38 +1287,55 @@ static void max310x_set_termios(struct uart_port *port,
 
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
+	unsigned int mode2 = 0;
 
-	delay = (one->port.rs485.delay_rts_before_send << 4) |
-		one->port.rs485.delay_rts_after_send;
-	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, delay);
+	max310x_set_rts_ctl_params(one);
 
-	if (one->port.rs485.flags & SER_RS485_ENABLED) {
-		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+	if (one->port.rs485.flags & SER_RS485_ENABLED &&
+	    !(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
 
-		if (!(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
-			mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
-	}
-
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
+			spin_unlock(&port->lock);
+			hrtimer_cancel(&one->tx_delay_tmr);
+			spin_lock(&port->lock);
+		}
+		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+	}
 
 	port->rs485 = *rs485;
 
@@ -1084,6 +1346,7 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
 
 static int max310x_startup(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val;
 
 	max310x_power(port, 1);
@@ -1098,21 +1361,20 @@ static int max310x_startup(struct uart_port *port)
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
@@ -1134,9 +1396,54 @@ static int max310x_startup(struct uart_port *port)
 
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
+		max310x_rts_ctl(port,
+				port->rs485.flags & SER_RS485_RTS_AFTER_SEND);
+
 	max310x_power(port, 0);
 }
 
@@ -1291,7 +1598,8 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static const struct serial_rs485 max310x_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
 };
@@ -1425,6 +1733,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
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
@@ -1535,6 +1848,8 @@ static void max310x_remove(struct device *dev)
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

