Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020127.outbound.protection.outlook.com [52.101.84.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B528B7D3;
	Wed, 16 Sep 2026 04:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789533992; cv=fail; b=pWOQMzvDYFzn3EUw9jB+ldDIG8TH8PS5kGwpBdy2a2hFxk4YBygI7Ujq3ZWY87QZ75kP6ZYg9gnoy886lWM0ID98YYvQP/MA2tevUZog0PtxbKTeV4SH2Q/F/VCR0/zwqt/s7j5ZViLRcU64ZCvngbJ1aVQcPsE91vJeoxw742o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789533992; c=relaxed/simple;
	bh=SG9Mn6QxFVSpBmGM0FcIjzPqdKwzCPmfsBng6XWx6qQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C9ZtnSKlLCqvJfvx4Rr5dYE15I64mbUxSikGv8eSGpJhkVDmvt7sckuRwYAziQe26x0emDrzKj6kDgUF9Q41WJYF9Gg/XGRCM7fZV72twd4N+E65TTvAijBwo7QWxoPqib2iv7hIgBGkMYuJyis3Ul8oekNegcaEZV1cSxY2SgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ZCeR80E6; arc=fail smtp.client-ip=52.101.84.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ZCeR80E6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA9YkxtkWrrrB+6RSWzFtm1KmtrdMnf1UjgmBsKEqOTyhGHxH2XQjMpXa/fb9OG7xuYRDN7t5HaFVH8XVdIyCh7EF5g0t84sY8KYd+4KH0pzNjPx2YVbo8vwRa3gDRlFAUAlc48nQvFVugoo6Tjr/qoylDuUM58xfr37YEidXLNZS+MeqcRq1tp2bwlY8IlqYi+El+ggMapC5xcEv2UwtSh5E6nuoy+dKgMjnjpeItOS8XMGZBAsici29+UtUiPEdHbaIfJr6Tju8H6TLrZlMln+K9luFF2RSUumseY/6T1O/Gl2Lk/2fJBFP5SQwi6vDAvQiMzhg+1v4U2KXBb/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zrw92iVffcEnjbByNUAtUvH6hoJSdLo2ls38oqgtNeg=;
 b=IGuGRB5MaBZa0rGmLNDLPI7vR9Lb7dc7X4P124z0WwT7oLsC3HEDeeSkdDzac1sOTx7EfYO1z6LcmJkBpmW1Y5gQjR+NW1kYnFDlcbPdu2ckwAPBQk5619D5P66TWx1EPhSLujQDKPLaXBv2o3uD8KQMf/L/MlXmnk42RX4TlCpck0ukkqK0eqFx+KcwelT/5U4oDZKhjykmZfXAKk9O1OOTG9QdHZwSW0QVY4g1BTxWFRItHQ7NZ9sHgt6UcLSfeyPz24AVML2UOp/HoTe1IC9o3holl7Mz+SWdSqxYSLmDVsPDAGE7nREpuC5eU9tm3jn1J+Ps2rw8ZP95Hk5NmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zrw92iVffcEnjbByNUAtUvH6hoJSdLo2ls38oqgtNeg=;
 b=ZCeR80E68On6Uin79frBypjwZzaSexyBcaR3meIgciUBRpcpVFFM+TfWyULpu+tnLzIeKUhrNLiA3p4+s88dm40diJtkj/4McA9aCf5Wx/mOXZk6FTEhTUwb7ShcBtSrciiTCDsCGGqsJXhK3sDFvoUSnTrAkxGgPhrpC9IhtFhf7sZylN3V/Yp9BbKlLN0xLdXFl9mW5I7x1t5p0oXZfaWP5RBIqUYOfuEjzw0BOUkmSvcUkXnTfE1P8lmYihy0wix0+4YwRf9HufUm+yTYsOW5aPVaeAFJaGQVCSBEKIdln6j3m4FVZleDQAV/Ugy6ZNCsBKGB+T/ZHwJF/vXHnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by GVXPR06MB10570.eurprd06.prod.outlook.com (2603:10a6:150:2bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 04:46:20 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%3]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 04:46:20 +0000
Message-ID: <c15330e4-25e0-4c50-9f48-dbb8d51f5823@vaisala.com>
Date: Wed, 16 Sep 2026 07:46:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: max310x: drive RTS in software when hardware
 delays are too short
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20260915-max310x-rs485-sw-delay-v3-1-7d20a4a4ab52@vaisala.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20260915-max310x-rs485-sw-delay-v3-1-7d20a4a4ab52@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBFB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::30d) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|GVXPR06MB10570:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5d8674-6899-47fb-6865-08df13ad7383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sElxh2QDe3/0kXOM2vk9QXh9fQ104natSPBJatlv+WNYxHnR3fKpTk3qQF0XGKNF4HRx4fwLuqyY1j1uj6FFv6y0ox44svm8g1LBUWL2nxrQ7IJHvLPiw0FA9bacIvmk1Wihj50WZsJ8X8r0ZPaNyS4nRUYSIHIGwZTgeUqemt28hhixY0azz4n0qhVgYzJU1QnBz2MKssnOUngKF2ktvCIR8QpniYc/Wiqdm5qGfsOQ0q74B02BTV5reCMEaY2hzTg2ndE9ic7Tb88ykbJOTBy70inuKPEF2gyzFOLgX7tROtTJRTMJBy8dqm7AZTcQh6ivIAkmf4ocrZ/bKEqC/UfagUhd7Kfxy98PSjh5/B1pOLAq2mBvJfgh5xD2FBTIZi3sS2Lcn8vDwsqijIilphVlLNMUISMC9H66HTwFHKKuvF6rryP8U53Brz2+5jKkS3kLa/fFeHkR7ImP+0fGaLpmWyn8a23jEYgbtCZSKAhwMgN99TbtbkI1e8T0MA6zNR7dGDFK+h7gkfhauYxrF3clFLJogBsZBMDX8Bxr8aGuaNXKsI7YzX9VlVs6kdLhT/aXSuIsPrE/la7k7+LPmPJsZnnSy9gNZLpPFEpkVjp39AdXxTCfKfoNEzU6TVbMv0mycjmXcE05V8/0Ux8cFdQujWiK3q9Og5nD0NCdEac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tml5RTh2LzljbTJ1ejhJT2FyTGVRRU1YV3RSM3dRUmtMZUFuR21lakNPb2hV?=
 =?utf-8?B?engxYmRMRzlZRmFSUmp0WkJCZlE5Zkc4dDB4NUFZZ2ZMSjlkTXBmZlVMdytq?=
 =?utf-8?B?NlRGRGo4WFNRU0lYU2VyN1Z3ZmI1ZlZXRXd3UVcwV0NQVnRJemxCakVlVTI0?=
 =?utf-8?B?a2dHd3BwVDI1Qm45NUJURUg1ai81RStBOFVwanVvQTYyVVIxUHlEYngrM0Jn?=
 =?utf-8?B?eTVpQkMwOXZnMkN0c0tnaVk3RnduMHllTzI5VHk2WnRSQlRHazlPQ2hzOVZi?=
 =?utf-8?B?WFBqT0JjQ3UvZk5wU3Z6WmpZeDBpUXZCOUpNRWthQjhKaXFFNGtmNWRaM2Ns?=
 =?utf-8?B?Y2EzSDlSNXZucUZtNmc3b2sraUh3RTQrQlU2ejhES1ozWXNqSThndi9xTk0r?=
 =?utf-8?B?TlMyUkg3a0VqMWlNbmROWm5VcTlaSUxvdjNMTnJLcE1RSWxjcWMvOStwM0ZH?=
 =?utf-8?B?cHJNV3N3WTFPK2RqQU0rMmhPcWNnZEhEeTdDZDN3UHlnTHRzMmxZd3BvWFJZ?=
 =?utf-8?B?dmtnZTVLM1lPM1pKZ1pUM2w5Rm9ubXpvUnVKYnYrbFkzT0gyaVdvNDg0SkVW?=
 =?utf-8?B?aWpvY1RXY045RmNZWFhSaW5JUDRaNWpxcXBNd3B0RDZGbGZxaERoRWszZjd5?=
 =?utf-8?B?c0JsR2NDRnZlMmRBNitHVUNCd3pCY2dzb25jU1c4ekdSTytmSWJQUTVMZ1Fy?=
 =?utf-8?B?Sm8zY1RhdkovdUpUVG91cCtuVVM3TDJteGhtMlk5akIrZ0Vnck9JcHZyWU9H?=
 =?utf-8?B?aldLUTI2V2dEeUhwQ0M3bWlRb0FUQmZ5WFQ3d2Z6NGpYRWVBVU9ZM0lyTDFq?=
 =?utf-8?B?Mlc4bXZob0lOWDhwT28rcDdLZW9yQVZHQzVIOFFvM0VQbUdySzg3alJKV0h6?=
 =?utf-8?B?ZVp2alVmdkJlaDJUZzFIcStzdk9EM3doNlpzR2JHdVhWd2h1TGpENml0bHR4?=
 =?utf-8?B?ZHpFY25FNW9oZ2MxVVVmbFZoazhjTVJMOG00ZmpSR0R2NDNvUG5kWUFrUnE5?=
 =?utf-8?B?S2hsZmE1bm41dlkySWdjcldnbGJLM01qcDB6TTZ3djBZREkwMVhOaHZjWmZT?=
 =?utf-8?B?K0VBTGVSYUhTMGlOY1lBNEJnR0RWeDJOSzJ4MzF2c0pSeG5yRU1LV09IL1h1?=
 =?utf-8?B?TkRBMngyU0toNEhXdlFGbnltMktSR3dlT3d2ME1kcVJFaTVWOEg0c0tUNXBF?=
 =?utf-8?B?Y0VQNDV3czRrVENFbC9lZm1YQVJKWlJrb3YxWkpOOEUyazZuK1RwSDBKL3dl?=
 =?utf-8?B?bnZPejRLQ2VrVGxoVnRtNkJqTlUyTnEvVlM4VmZpcWhTZTJ3QStKY1dBTHFa?=
 =?utf-8?B?MFlBTVRPb3hXKy8wVUVuTERJaU0wWDFlWkFkajJoL21TbHFTeGVReHZaZW9q?=
 =?utf-8?B?MkhuT0swNnNNb2JPWFEraFpIeFRmdVJtc09GaWFndlBoY05TT0dnblRSd3BN?=
 =?utf-8?B?aXFSTHhReDVzaGkvV3pVL1FLMGY1SEpNUnI2aUc5QkRkdUF6S3hJbjJnNmpK?=
 =?utf-8?B?TTJ1TXk2MjBSSkhzcnRnVzBUb1Q1NWpmS3lzbTE0cHFCSWxXQTZlb1ZCQ2Rv?=
 =?utf-8?B?d21wOFlCbHA0TXkvOE5mSEMzNENKUzd5NnJJMnVrUCt3Z0pMMWJjL21XUGls?=
 =?utf-8?B?dUIrM2ZuclMxZ04yMnpmR2tBcmNQRFZLM21nZVMwS0h4UjI4MHdYM3VzcWtX?=
 =?utf-8?B?RE9PdUtZYUJJeU9Kbk95NUE3ampsUkRscnY3S045WGo2bm9PWlhYc0FqcnVB?=
 =?utf-8?B?Rk1hT2NaNUdoSUV2R2pDbjN4S1E3aDNBSTRycjhuVy8vOWdqa09jeEllQlM4?=
 =?utf-8?B?TkhoTmlibTVncnB3Rjhwb3RJMzQyaUVCTnVLNUtFRjFoUWt3c2tQL01RWGNM?=
 =?utf-8?B?YVdNWFErbXhGM1dhekU3ejJmUlczVytyS2U2L0xrOE92bHVSaUVvOExZTXN0?=
 =?utf-8?B?QW9nVnQwcVMzUUVGVzI1Rm1ST1B4c2wrNXJEcEg2ckZMU1VmSmY3TThzSkt2?=
 =?utf-8?B?Q0MyWDBBaURSanltV240N0N6QzFjc0d6SlQydDZaSnJZSmIyNFhqTlQvVjVw?=
 =?utf-8?B?ekxMWVhCeGxIeDFFbXpRa0F3SHpYdU1PQ0hGdGVFVU1uT3VTQ1ZMZWFxRXR2?=
 =?utf-8?B?Q3V1b3JMYm91dEMxdWp2U0ZSTjFBS09HMGlBOEhGaCtJL3l3VXc3Z09iZ2pj?=
 =?utf-8?B?blVPSlpya2ZWNUZPUGpsTXJNaFl3UzBOSHVIRk1TTlBWWEVVZk05SXZpeUVZ?=
 =?utf-8?B?MDZGWCtLNENBS2dhTUs1SDhodjlZbFhuRW1XV0NONTlNK01iRkJtUWhDWEJu?=
 =?utf-8?B?WDdTUDdGSmw5b21wTDJaS1h3STNOU211TGllemNGWEpQc0IwT3UrSFNYN0Jz?=
 =?utf-8?Q?iI9wYVExdI3TB7zg=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5d8674-6899-47fb-6865-08df13ad7383
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 04:46:19.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1K9gBnhea1fpvgUfIHRBEp6vbFLzvwp/LHE/u+0P8Qcp0L5UZWDKuK8xGdfKRKvEcXVbWMWiQJEb+crqZBFGSCI/VQsItcPecJUEcOcxW5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB10570

> Sashiko AI review found 5 potential issue(s) to consider:
> - [High] serial: max310x: port lock dropped in serial core callbacks
>   breaks atomicity
> - [High] serial: max310x: lockless 64-bit ktime and state updates
>   cause torn reads
> - [High] serial: max310x: TOCTOU race in delayed_stop_tx resurrects
>   cancelled timer
> - [High] serial: max310x: race in rts_work_proc transmits data with
>   RTS disabled
> - [High] serial: max310x: shutdown bypasses timer cancellation if
>   sw_rts toggles

Three of these lead to changes in v4; two do not. Please do not apply
this version.

On "shutdown bypasses timer cancellation if sw_rts toggles":

Correct, and it is the one that does not even need a race. The hardware
path is selected per port from the current baud and delays, so a
TIOCSRS485 that moves a port from the software path to the hardware path
sets sw_rts_during_tx to false for good. If a software timed envelope
was in flight at that moment its timer stays armed, and
max310x_shutdown() then takes the branch that never calls
hrtimer_cancel() or cancel_work_sync(). The port is powered down with
the timer still pending, and rts_work runs an SPI write against it
afterwards. A write, a TIOCSRS485 and a close inside the before-send
delay reach this with no unusual scheduling at all.

v4 keeps the two drain loops in the conditional, since they legitimately
differ, and moves the cancellation out of it so it runs unconditionally.
On the hardware path that is a cancel of a timer that was never armed
and of work that was never queued.

On "TOCTOU race in delayed_stop_tx resurrects cancelled timer":

Correct. max310x_delayed_stop_tx() reads tx_state, then does an SPI read
of TXFIFOLVL, then takes the lock. Across that window
max310x_shutdown() can cancel the timer, set tx_state to
MAX310X_TX_OFF and power the port down. What resurrects the envelope is
that the code then clears cancel_tx_delay_tmr unconditionally and arms
on tx_state != MAX310X_TX_WAIT_BEFORE_SEND, which is also true for
MAX310X_TX_OFF.

v4 drops the clear, since that flag belongs to whoever set it and
max310x_delayed_start_tx() already clears it at the one point where a
new envelope legitimately begins, and re-checks under the lock with a
positive test: arm only while tx_state is MAX310X_TX_SEND. That is the
only state the after-send hold may be armed from, and it covers OFF,
WAIT_BEFORE_SEND and WAIT_AFTER_SEND in one condition.

On "lockless 64-bit ktime and state updates cause torn reads":

Half of this is real. max310x_set_rts_ctl_params() assigns
sw_rts_during_tx false and only then recomputes it, so every concurrent
reader can observe a spurious false, and the permanent case above comes
through the same field. v4 computes the decision into a local and
publishes it once.

The torn read of one_character_duration I do not think is reachable. It
holds one frame at the current baud, and the lowest baud selectable here
is uartclk / 16 / 0xffff, which is 42 on this part (uartclk 44.2 MHz).
One 12-bit frame at 42 baud is 286 ms. The upper word only becomes
non-zero past 4.3 s, which would need a baud below 3, so every value the
driver can hold has a zero upper word and a tear cannot change it.

On "port lock dropped in serial core callbacks breaks atomicity":

This one is deliberate and I do not plan to change it.
max310x_tmr_tx() takes port->lock, so calling hrtimer_cancel() while
holding it would deadlock against a callback already running on another
CPU. hrtimer_try_to_cancel() is tried first and the unlock only happens
on -1, which is exactly the case where that callback is spinning on the
lock being dropped; cancel_tx_delay_tmr is what makes the re-entry safe.
Several other serial drivers drop and retake the lock the same way. The
review's own dismissed-concerns section reaches the same conclusion,
and separately notes that uart_rs485_config() wraps the rs485_config()
call in scoped_guard(uart_port_lock_irqsave, port), so the lock state
on entry is what the code assumes.

On "race in rts_work_proc transmits data with RTS disabled":

I could not construct a reachable ordering for this one. If the worker
reads MAX310X_TX_OFF and max310x_start_tx() then sets
MAX310X_TX_WAIT_BEFORE_SEND, start_tx also schedules rts_work again, and
that run reads the new state and asserts RTS. The before-send delay the
first run arms is longer than 15 bit-times by construction, since that
is what selects the software path in the first place, so the second run
lands well inside it. The timer only schedules tx_work, which queues
behind the pending rts_work. If there is a concrete ordering where data
is shifted with RTS deasserted, I would like to see it.

On the three concerns in the web report that are not in the mail: I
agree with all three and with the preexisting flag on each. The
cancel-before-uart_remove_one_port() ordering in max310x_remove() and
the out_uart path are both unchanged from the base commit, which already
cancels the three original work items in that order, and the unlocked
xmit_fifo and icount access from tx_work is how this driver has always
transmitted. They are worth fixing; they are not this patch's to fix.

Tapio
