Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021074.outbound.protection.outlook.com [40.107.130.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7D48820D;
	Mon,  5 Oct 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206508; cv=fail; b=ugEu2PYZ9E1C+JpE8mGPRw04h64rpFVVn8eyNc1KedCwHoADjGkPfmo1euLlOsgI6oUUfh3Og4V2kaseRSsXWWkNu5Y2CVrkjWJLH2SVmTSq1LQ196eL6/SYYitGlTIaUNZ0a6swqyqnWdFYctA1nVSmOWSB+W50OWEFCGwF1Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206508; c=relaxed/simple;
	bh=ZN1PzGRg7AKs6qAUSYGCsyVCs7kJavpDmjjDn9/TIFc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G3zHoYR/W/98VLG3u5JEcPfjFsOfH5T4HQ2FjMWNvj6quiR7ae9JVbZao06cj2j9wKmGsjHIYPz9bXbQ2x8uvfIQqCa0cRufXNusAbZ8Nc58AhFJ9e2lhVRZUjnnVkfxuMwwg07wNex9QwN4sep113g6/WIedIhq0EDNtCAQM14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=NaZ8h3sP; arc=fail smtp.client-ip=40.107.130.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="NaZ8h3sP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgTAHrhDG4IM2a1jPsIscDLy/MyY7eIJjPkw1arlmu94ZcwCjubvf8tDrXEtLnYOxFDkeVzzNyOsq/dKP7CGgenh64doio8EHFxtCSCsf1hKX+vXvSpqbYYcBpfMYIFduKmvdt2xWslK4tF5w6vrWXmM70p53GaVS517L7SOOTfgbtU7my/FJqE8H3W91JA0H1eQmVjyKxp+vIWSve1upB+HQXEDPoDV9YmdRJI5p9fbSx7d5InpKV578rxsK2RpmU1NquHg1e1Bc1uSL10resMQHhDfzERxuGp4ohOWCkihyu806laXZVOeWmMQ+MZT49nMAGzWE8My4wFPLk0BiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EX0Ou+P1DrT2pLKDmiAUxivCnZDDFRA3rjsStmQyUxs=;
 b=sh2O+DByIYpViRsFQG3urWTE12CpqDFLzFqQXNsq7IZ+KPsfVcITVOAmA19gqBZ1YF1aNK5OEI9oYKN3gDLMWPa66L+SUS4TVDsn2SUTlK729+J40tvRvpwDxtfa/LBb+PWVsD+6K2wAasH6amVw+sG/MnjwIwb7bySxu9+qlH5G3MnuEbKvJ9NioRWlfSm2+UHHlG2Z35jiAHauRcNaDljimFFhLOXpP5wBF0mF/hqWBS15ZeNqFp/pca7mcufQsOd6OgAxJqZV3KXmyir5Qlcu+UpcLv/eAYzkd+w06s5Ng6a086YhAgwY8X2idHL31d6tPI98fa2NZzODHOHMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX0Ou+P1DrT2pLKDmiAUxivCnZDDFRA3rjsStmQyUxs=;
 b=NaZ8h3sP2+KdmRGc+W5hxsPn0YzpyYE3PF2RXO/oxqHkYeGjYw3v8KvvHCiJ94QKA0Lg7m6gRmdqdqR7QCD5fO8P3YvYALiL0B/qiusniUAtxz3skHcvG+2miQX1PoKFeHr/rTkduJiuWjXvm4IpWAxyFqU3bxSFTjNl8vzOQJ68mSc+JbZ/NlZKYmq60f5XSvxvHw1dO97y8fef8jXUZBXwECX01V3Ug7mBqnv6uTt9/yLMTMkpxUZ0+UL+2Jb5k+aTFhchM4QTb4wgCOhwfXWZWFL0QQawKi9mcqGG4RRJmnBNbvFeq2ZgFRVaeCP9Cyg5vbJazOFMmaIjzmWABA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10187.eurprd06.prod.outlook.com (2603:10a6:10:622::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:20:00 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 13:20:00 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 05 Oct 2026 13:19:40 +0000
Subject: [PATCH v7 9/9] serial: max310x: don't transmit while an RS485
 reconfigure is pending
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-max310x-rs485-sw-delay-v7-9-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206394; l=6588;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ZN1PzGRg7AKs6qAUSYGCsyVCs7kJavpDmjjDn9/TIFc=;
 b=Hsa0XLwTlTszlS9bbV6+sR1W4rkY6DTPQUeOn0qR8lR3yE3YVs1CmyMa2gOViGAgoAwuWD3A1
 XoqOJZTD3+pDbVfVOT81e6uwLZ1GwxdZdq1DRAYwXMUaSv8PITbOAA2
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::16) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DU4PR06MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0ac49d-a9ea-4a42-8d10-08df22e35bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|22082099003|18002099003|38350700014|6133799003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	PN4C/3Yp7I9HPz7KgUyFAT9325+s/ORqT9ismJBOZowMh9YD6Yh+edAh3tgF0GlDBsk0e5sTo/L22JHjvQ7ZHvZ59J6Squ9GX9jom/1UFxvH1U4DQtlrdPiw2XkCEU9pTIgQ6UpukLwTLZky/gdud+ZEmKgy7isXAg+0hsipTAUsuJSIE4l9vwos17d7Fa1PEFyeUHHu2PmbqsdoAPNaS1UJE+kpRncQFD7JX/wHwlnZhzKWt+cdFkVkKXXssXDM0J/QYQbVcQVts8SFTpX4LnztyDcgrVTn5yj79Rf5G4rFnPJ0eeF/ss7E4DfR+SEsEJaA3V0oTrRAjyK+BhNJG6zOGc4EUaDXYl92pkDRYetZ/n0UWHF7tiPn4YxoPN+kDo8uo3FHebZVWncPle5epV7LJZLNz0XK+gzIBH4VbAjiJPEiCIb138QEm+oqo0mD85LsqJgjrlSJRqL4Uk2Dgz+8DfE5d3ToRzIh+DryVpscIIdOmxi0a+Asrbm5HzMf7AXh49ixxPPLlG5RhO4QIHghpO1ucxEkbk5ALM2zmmVBPuhTwS0JV0mEpR0os4m+K/BvPWjGVNSpnilgC3mFGh2r7KtLYRWfPjbdGIvnJY7Q8MxP7hebetazOPAU9KgHRmcIoz6D0WW0w71bspbTkLeZlITjkaYGA2TIl91fkA20BT+wUFxoAQsRrKg7XJUIPZJBRISFhO0HBbfS21xkALLxJf12gfSslTo6dCnzEcc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(22082099003)(18002099003)(38350700014)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmRmWm9NdTRENkpGOEdvRk9POUgvdDB5alVpTFdad1B4NlQyb0JiamZxQ2Np?=
 =?utf-8?B?MG53S2l3NXhjWTRTY0hzS0h3OTI0S0psOGNhMG9uOWtlUTN2ak1BMERmRWhV?=
 =?utf-8?B?eTFtUy85eHpGZnprQUhDSU5EbXBuaEtha2FCR3RKNXYwZGRvL2VIejdMKzRY?=
 =?utf-8?B?Z0Y2YnNHZStXN2ZEc0c2bnIxNnA2VE1HYys1T3lIOVAwL3BMdHA2cVJndTVR?=
 =?utf-8?B?ZmxUUzdVRWQyTFRnaW1vcnNDZFdXaXJ3MzlNODhIUVNaRm1oVmFmWkx5WkQ2?=
 =?utf-8?B?a0NyTUM0c2dlWXdOd2pnQ1NObDByOWNJSHBzRTRNS0NibzU4cGhQbFB5SEc2?=
 =?utf-8?B?ekY2N1BPQ0FpeWd3S2RXUGJZMFFIdFJUdDZoT1lVRE1haUI2dkM1VkF6aktt?=
 =?utf-8?B?L0RMdUtpU0NjY0gwQy9GL2VFZm9lNzhXeGVPWWxUSHZZSWJnM3JOS0xmUlhq?=
 =?utf-8?B?RmJYbzQxOTBERWg0dDN0NUtaS0lYbW8rNi9OSTNLSnBtN2VRWDJCbjUydzZY?=
 =?utf-8?B?aDd3UklZYVRyVVR3TVFNVzlYNWJxVXo1dXdYYkl2c3NCTStNWUVWRnFjWDhT?=
 =?utf-8?B?Z3BZb0s4SWpQMnYwTlo2OXRCZzA2cXlxSzNXeUErZFBhOHlDZ2kvODlJdXZT?=
 =?utf-8?B?MlhMUHlqVkJMeUdhWkVvU0J4d241dkJQYTRZd0FIYlkrL2xneXBBbGNmOVMw?=
 =?utf-8?B?d1B0WE9XZE04WDdNdXlTRW1ZaWFDRU9vcllUK1N0dXhwR3p6Mm5CaVJobCtE?=
 =?utf-8?B?SzlOTkNDdzd4L05lYU0vVXlRbkErNEo2dlhqRVZsU1lJNG5idTBVdmludTRC?=
 =?utf-8?B?MThJK29lSmFkY2luUkorT3Q2dEQ5SzF3VDdZSUsrelJhSW5PQTMrZ0R6bENz?=
 =?utf-8?B?YmFHdW1EYWx6SWJSUWhSTnIyQldZdklqa0FyYnY5Y1RJM0RmVStWbTh4bUlu?=
 =?utf-8?B?ekw2S1A2OHBBVkpNczR0bEdYUnpwVmsyQzlzSjg4SG1pT3BmUERiZFQ3OXRB?=
 =?utf-8?B?L3dUNSszd0lYc1ZQM2JKdzNnRmlDRmVUdzU4SExldkY1bkg1NDBHU3pBZTdj?=
 =?utf-8?B?QUxPWUFXK1hEdkJKRzhXbkZNS0paRVQzQ0R6S0hNcm51TWV2bk5takZnMnYr?=
 =?utf-8?B?K3BQK0FiZ296R3FybXU0Z1UzcC9OVm5HRi9iQjJoOFdZTVp6enNrRVpYWFlT?=
 =?utf-8?B?bERWT245djBKTGJLNUdqRE1USXJMY0RBVzdmNVpaVlA3TG44azU3aFJUSnB5?=
 =?utf-8?B?VkRvais2MmRrYUFhSDd5enpsSFJWdk1xMEc3MlNtTHgvNzdEeExEcm91eCsy?=
 =?utf-8?B?clNvMExCMkZhd0RQeWp2SlkxMG9Cc1BCbEZPZVVxdEN1ZVhDb05qdnFWZjR1?=
 =?utf-8?B?TTQ5SXF4eEpaNEI4YU1Zb1NHeGcyM3hqUWx2cURMWVJjbUNYMU1NaWg0bHJB?=
 =?utf-8?B?YkN4WnJaRFVWNDVRcXNBTGJJS0lURGRkTXV5bzdNOVI1VU1xNitrQUFhZkUy?=
 =?utf-8?B?QlpXbm9QYmJSM1NCeG83VEdYK0ZmeGErYzc1T3dDajMvUEFhUjVyWWtOQjZR?=
 =?utf-8?B?aEpkRnVrNTdETmtLVWRUTTl4MlYvKzZTaTVEenNLQjNtZmI2VmIxcS83clFK?=
 =?utf-8?B?UkZ5MUFGOFJRWGt3Wmt3QThRTkhMQVI0ZXB4L2xIZlhLNnBnL3E5QXBsZHA2?=
 =?utf-8?B?KzlKU2V2cU5XUmNtNGdBbWR5OGFrKy9HRDBRcnZPMUY0TGxuQ09aZGhOLzkw?=
 =?utf-8?B?a0pqVXphcU5iOTVRY0ZnZFRUYnd3Q1VYenFNUVo0NVJ0VTFuQkFhZ3QxYjJE?=
 =?utf-8?B?U2dvcTIyUW41aGNJcXZscXBtNnBlU01hU3FCa1h6Q3JRUGUrZ1Z0Y21IWmJ3?=
 =?utf-8?B?aUozUEErcXVzSjkzR1FsMitiSERuYVFDQWxZczVHYlM5ejlSYlhML0REc2tk?=
 =?utf-8?B?UndvNE9wZGpIL0p0NVE0S3VXMnZEcnA1YlRZUGJTakY2bnd5ZGdEYzVCblQr?=
 =?utf-8?B?UlFEMU5wdUJTc0xld3RUUnpZTDRsbDJhSmhtRmtXK2dCRitqN0VhakZ3UkZI?=
 =?utf-8?B?VkNlbUlEUkNhRGIrNnl5REhhWjUvWlJoanRrV3pqWUJKM0k5UjdwREswekFr?=
 =?utf-8?B?NU5XWDhtdHRHVlAvanB0dWZFek4xajRZMjlXeU1FMkJDZEtyREI3cWY3Y1Q4?=
 =?utf-8?B?OFkrZ2ZvbWE5bHhKcDhDc3NFSzFSblhHK3MxTmVmSkRxU2M1UWNIdTR2ME5T?=
 =?utf-8?B?Sm9ISDUwM2VIOUx0eTZkUTZvWXluL1JQSy9HaVdKWTJxUFpjNVE1WFVZUzE5?=
 =?utf-8?B?NnNvUWFxZnBidDNoZXUzR1EzZHdjNlZwdWt0Uk5UZzUrWTdSd2lOS2ZYVzJh?=
 =?utf-8?Q?bDuL2Pk6++ZkFKjw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0ac49d-a9ea-4a42-8d10-08df22e35bfa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:20:00.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bhxOh3ikTXWNhIcYU4fhwUFa/tPnV3ZU3u8TUbmox+vnshOPtMjqQgkTmudLxaSp4VrskYFsjzaw32EI1rhMAlDiCRRrtgIa/lFb+ooqBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10187

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

rs_work takes port->lock for that restart through
uart_port_lock_irqsave(): start_tx() may drop and retake the lock
through the uart_port API on its hrtimer_try_to_cancel(-1) path, and a
raw spinlock guard around the call would unbalance the nbcon console
handling underneath.

The restart also rewinds a send state adopted for the deferred write
itself: set_rts_ctl_params() cannot tell data the pending gate
deferred apart from an in-flight transfer's refill by the xmit buffer
alone, and a deferred write pumped in the adopted send phase would
skip the configured before-send delay. With the chip FIFO empty the
adopted state can only be the deferred write: rewind it and let the
restart run the full envelope.

Fixes: 5bdb48b501e8 ("serial: max310x: Fix RS485 handling")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 51 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5fdb9dfca6027ff0a9284ed994000a5d7587408c..833ab4d461235d89438b1a7c84c46609fff64453 100644
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
 
@@ -1445,6 +1457,8 @@ static void max310x_rs_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, rs_work);
 	unsigned int mode2 = 0;
+	unsigned long flags;
+	bool chip_tx_empty;
 
 	/*
 	 * Serialize against break_ctl() and set_termios(), which run under
@@ -1465,6 +1479,31 @@ static void max310x_rs_proc(struct work_struct *ws)
 
 	max310x_port_update(&one->port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
+
+	/*
+	 * The configuration is applied: release any TX that start_tx()
+	 * deferred while the reconfigure was pending, now on the right
+	 * path. start_tx() can drop and retake the lock through the
+	 * uart_port API - a raw spinlock guard here would unbalance it.
+	 */
+	chip_tx_empty = !max310x_port_read(&one->port,
+					   MAX310X_TXFIFOLVL_REG);
+
+	uart_port_lock_irqsave(&one->port, &flags);
+	one->rs485_pending = false;
+	if (one->port.x_char ||
+	    !kfifo_is_empty(&one->port.state->port.xmit_fifo)) {
+		/*
+		 * A send state adopted without chip data is the deferred
+		 * write itself: restart it as a fresh envelope so the
+		 * before-send delay is honoured.
+		 */
+		if (chip_tx_empty &&
+		    READ_ONCE(one->tx_state) == MAX310X_TX_SEND)
+			WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+		max310x_start_tx(&one->port);
+	}
+	uart_port_unlock_irqrestore(&one->port, flags);
 }
 
 /* called with port.lock taken and irqs off */
@@ -1490,17 +1529,11 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
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

