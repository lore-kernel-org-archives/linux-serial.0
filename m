Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023077.outbound.protection.outlook.com [52.101.72.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3C41A93A;
	Mon, 14 Sep 2026 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377070; cv=fail; b=XtpKeH7NJs/hJMKN/ow+egZrsNz8MaX2iLdQIs0HnLqNiJVBxyaKQQjEhGUK9YIxQgsGNA2N/AjZd9h2/gqHeNN41HUZzxsWPZiJKDZ3VVU3su3fpV1wqLlPIMLgnC+6/ax6e+3Tn+vA0jAECqQsOICuVpdZ+NIern3qAhyUuss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377070; c=relaxed/simple;
	bh=p9SUkw4M1m1sMlxikzevs1EmohbKilUg7fWcUtP1Lqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lYR2sZIS6qqH7v/74v6ekyurz82T4DoPUyLfxrvVFLQ3B/giFXCyOO2/002hYEidY17fTtFbyW4o5zgB0oqupaDs6bfRgfT7w8ClYN0KrqHwyorULD5syvtrx2/7K6tUr8VQj7x3FEStKtFthqtA6XwibTcb+37W6tW93wbMtPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=woVntTG+; arc=fail smtp.client-ip=52.101.72.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="woVntTG+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUInCcyL56AmZROHc3kRIwijAaFmbR6S984yvkOWPqMRA5uxZf/6XA1RiA/hKA5QztDEHbgZA2OakYvaBJocSEgFQlwxXPmoNLqB8Xf+01MBw2JuNwHNjk/s7Mh337HNRJSNTJK2ObaP+wUnIS9XqqY3htqjWj/St4W+iD97qNqoiN4L101a+18gX0rGFOvjqlsoTFLp3j04igbaEqSmRJRSG9jd9DFw8UWZezPQNEfkbsoFb9vaqvNen5EvljsMETzJS1n08S/YfM5COI6Q0Ubz6vCVK6QXuPDM89WiwAz94ifb32XHo5HE3AWBc1vLjiS+ZS1SkYEa/gA1JgznvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf79ZRRg3ZPY/mI45CX6zab+grlZux101fi0b+FYgus=;
 b=Z3KnyGb512vjOvH2ejBArBwb6WbM5MfLDbgkpZfJ5ksiuApviOJ5cd1+ozUCDKLP4ko02SC1N/o/R/km+zpZ1VlPgcfHCpvohWIyNGDEBtLkbCVdC/Yl+C6lEYWr5lEL6uOhve53QKc/SWEKQZHH6PL1LAO+IC8yqHS6H6FShrZePDBcO1xG0DdQhFc9FDW9AgKU9gnIMWBeGSAvz9TVlOocjA4k0Y73dY8lvfApiR1eHZ+5n4z1U6+73QOlETnaNST7SNsksJyRBwjOd8owS4006vFexj1zBBSDxWrNoHe8oWiAMU1F19kt6UChP0s3XI0IlJs0NhLh25lWybtIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf79ZRRg3ZPY/mI45CX6zab+grlZux101fi0b+FYgus=;
 b=woVntTG+RKqmIdaA3WJ/7EqN3y0mf4uI6h4GQDtKleVsvmAhqDniNSyg9TmD5v5/6RjdqcBKQ8a89mzX7+eQOdNWfMyLmNoCjzguysqdKgpEDIlDSqtcP6koa+xjPxTD3bZVmK19YTlMw3h8C7L8EjF5e1Zowgkp7NJQMlcRuMC+ktRapZxlclSaocaWpdqtrrcI6MObKRw8wmE602/gky8NmY7ufcMeQyEyewp0X2D8FWMPOGkbpglRYowny4JKGI4o6iuxcCliGbk6NfnCVMSFGdz7mbvbqagayw79TRIQr4D5gOEwDekIy43B2TdqbW+O1DZFp683x7qyWyF95w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DB9PR06MB7721.eurprd06.prod.outlook.com (2603:10a6:10:255::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:10:58 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:10:58 +0000
Message-ID: <9574741a-4daa-46b7-9f38-ee589c82e38a@vaisala.com>
Date: Mon, 14 Sep 2026 12:10:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] serial: max310x: drive RTS in software when
 hardware delays are too short
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20260914-max310x-rs485-sw-delay-v2-1-9a7b681e64ce@vaisala.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20260914-max310x-rs485-sw-delay-v2-1-9a7b681e64ce@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBC7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6b3) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DB9PR06MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 89abe9b2-a01a-44f0-8ffe-08df124016fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|5023799004|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	OtrZ2FT5s0OEboQzk1ZV039WIm5yv1xFgDhpix/tf2BgRGbEDplLtnd6g5zPNWk/S4k4c9hfsIxfTnMQlMcFu+mGKZ0OQbB8fzIuCcUnQlF+fu8UvuAsrtafHyTigFOAqEY/8sFM4gIF5O5yJe61BafPyB2BlhC/nzlIatcgGkb5Nq/Wa1FoU3sx429w6zmZYeH2FRlDwF/d3cWzm2+1UZ4zPagHxbvJQ/fe43dSoPM0TAJ7BrH5QQ1QV0QFkPP6aGfRp2TVdPyY8mwv+ibktEGw1zc0xrvoC5GZ5RnYiZPfzpQsGD+vgg/ub+i+iokmZ+hujsszf4lbiyhactKMRVxcyAWBYhxO7TbD4VNDdLZTHlQ3dK+irulD26bynbM44LLFwCpw74pBxZNCv9TuDGnPoxWdGX25Bbhmg7UGTHzhgtcAvyz93Y4yu7W2+2dYuLo+13E319rdW37Y0yb50Mn7uKTaP7MuTekmjwydP6mdBSapKmGU2NFJ7EOiyNnL8yz68bFdrK9TLAqlyjH2UpPbeKr8gFQiytTQHbABlOzMqWr3ZcRJj43keuyVs4T/AJ8Yv2vMXtSBYgJY7juxG3nRfO5MXcmVWC+tt5dVH/g7HqrcC7/zk2bfFqZ3Y7mfPOwI+bAmpzgJpq4eQAFfKWwFrAiM+RoJ8YRBj2tBVaQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clU5U0t0R3g1SXZTZkNWVHJzb3dLUmJpaDhyOEJIV1NiNUM4QmxRclRCd0p1?=
 =?utf-8?B?cG9SNFhyWGFsd2N0dVJZcUwyUmVJcmpSZUFnZ3lhZzd4NjhVR3NzWHpLcGdl?=
 =?utf-8?B?MmRjc3lqZHc1THpvSEMvUDgzRDdMcVhoV0pac2lSeWZNdmVjOTFsT25JUlN5?=
 =?utf-8?B?ZktISEtGSk1sUlZqZDJOa0tJbUJSSEFLbUZHaEpPZjdRZXI5aytDdGl0aVBL?=
 =?utf-8?B?OWVvTkNxQTZyc1p2Z0FrQkFmS2lBZFBrTzdaMzVoaXNITEkvcWl0S1FDZGRG?=
 =?utf-8?B?bmUxcHRqQVgwTUdrdGJyUWpCSDFIYmFQWkVPZ1VsWVVRQnN1TzNKelVURms2?=
 =?utf-8?B?NHBUbVlFMWZtOE1ZS0pPQkZwN09jT203ZUZWZFd2TGRiTzc1WHI1UWVNQS82?=
 =?utf-8?B?enllSk1DNTZGOVRPZDdIQ1BadzBKTXVITnBldmJPQXRhYWxtZjhCbkZpazZi?=
 =?utf-8?B?VzdXSHB2OXd3ZkgzU0t3cGF0b0tJcERZYmlKMWY3Ykw4SVpOTGlxdmsxSUV1?=
 =?utf-8?B?cTFubC9VQWdNNlMzbWtxellRY2l6UmxFb3FGOHd6TzIvZ29Mb0haU05RWmox?=
 =?utf-8?B?YzM2azhYNVJGSStvdGxrQnMxMVFheE9OdkpqamJwS0VHN3hqZ2QxVVp1b3lE?=
 =?utf-8?B?TTFOTzl0d1o1cmlWS1dJUFVnUEhsM3JSbHdhZGN6eFlCaDVsa3dRcHhwUm1p?=
 =?utf-8?B?a1dkVElXby84d0ZkeWRnaHNKczhRNlBndEoxcWprOXFLZVpDNUF1amFCWXhV?=
 =?utf-8?B?UjJuSXVUN051OWhhd3ViUXJTOFUxaEYrZTlsL2tlNTdBSGpNV2RJcHNpMVAr?=
 =?utf-8?B?WnJuUk0rRTNnaGxVbGNUOGtiRzcxczU1UzE5c2Q0eWkwMCt3M2NUbEdEQ3JN?=
 =?utf-8?B?MDd3QzVXbHJuSTkvb3h1RDE3TjJ4cGhUZmpKaXhocHlNRStPbzk5WDFtZEhv?=
 =?utf-8?B?WGxyME5YOWprWkErckJ5L2l0cWczNFBCdUpmRU5QN1VGeTRxQlNDL1hPbjZi?=
 =?utf-8?B?S3FCNGRZcXdZRXBwVGFGczE3ZWlpb3llVDFicFFsc0JXTDd0NnlqUE5qMy9Q?=
 =?utf-8?B?ckZjRjRPRm00UG1zVnNNWDBnYXNleHpNMHI0Mi9QSU5NS2RPZTFlT2o0TWtu?=
 =?utf-8?B?ZEs3ZFhMM2tESXpaU1B6Y1J0YXRmTTM5VHZMYm9zUTBoajZrQVphbFVaMmVD?=
 =?utf-8?B?cGNwMWI5eFY5dDJFekdlZG90MktNTm96eHZvZXp3NysyUDdlaFNhakxsQmtH?=
 =?utf-8?B?bDQ3WjU1L0J0a0t5RndYMFRoaWsrOERQaFZDZE9zcERwUlZGakY0MDdETElr?=
 =?utf-8?B?YWl0MEptNGNPWkdLald4djkrdFMvS1JhY3AxcFh4dW5YVDBnTlQxWEVBUHYr?=
 =?utf-8?B?amh0eVpWR2FXSzM1ZmE2MWd5aG9LSDFmYkM2ZEtaVmw0MmQ0KzlPN1V1TlF6?=
 =?utf-8?B?S1dyY2FZWUdEQ3RYM2dvUGJnV05GQ1NKOVdKc1NZWGljUXVCNHgwRStNRm80?=
 =?utf-8?B?S2ZLZWNocHlRSWxNV01Ea21tSUdQa21CTjlqM2Q5WHMyR3N1a3gwYnMyMkEx?=
 =?utf-8?B?M0ZSbHZRU21tbjc1czBUdWdDcXZqQlZVSUp5ZjVmUVVFT2lveDJnemVPZFBH?=
 =?utf-8?B?NHJBblF6d0VIMzJaNUwzU1VFdDV2b2UxSm12N3ExQnJ6M05zZnlvWWFVQlp1?=
 =?utf-8?B?bnBPUkhWQ3hYdWtZQUNGT3ltcE51b3NPV3NMVzdnQy8vT2JLc0hrMEI5MXJt?=
 =?utf-8?B?eDlEcjJWMkVGdmRPWEd4dnBHdXVFQUtzSmJEQjF0V1diZ2h1ZExSOTRHOWhM?=
 =?utf-8?B?U05xc05WMi9COVREMnlrWDU1anFtZTVjZjQyZHVvRXo1VmRPWXcyeUs3TjVm?=
 =?utf-8?B?dENBdkx6bzRwclczU2dWOFFkTzc2SFQyT2MzdVE5TTZmNEprclZlbUhPcmFZ?=
 =?utf-8?B?ZWJiRm45UkNORFhleCtLeXAweDZZeHlLSUxHRTdzbDJHZSsvZlQwankwbHkx?=
 =?utf-8?B?U2R4cXREMUVJV1BlRy9PTG1ib3R3aHVpUnJ2VFgxckVzcmdCVzZVRDhjWWxM?=
 =?utf-8?B?ZUZuOTdCSVNiN0U4TnZCLzRZNzBwSElBZzV1OVJQSkh2VWZwdmZPV3pqZllu?=
 =?utf-8?B?aGdDeUMvZG12T1JqcHBZdEd1REJuVW8vTXNzQTRDQitKQmxMMkIxSDJxS25J?=
 =?utf-8?B?U0x0VE5RN29CcTlkcW9aSjJia1RmU241aVZ6YWU3UjgwMkE5VG9yZytmdnhs?=
 =?utf-8?B?aytqdzhtTm5nUUpGWHhpWDNYREloenNZdTZXNnR1R091RjdTd3BFeDVKMWZj?=
 =?utf-8?B?SlZHSUJyVVBVczhab1BLT0phcTRQTkVLODhKVWRSd0EydCt3NnpQTFluWGlG?=
 =?utf-8?Q?zXWA4i3UL+CN3R/4=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89abe9b2-a01a-44f0-8ffe-08df124016fd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:10:58.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Oq9r4dKGZbZLJC3OOjrhrHbhGZwnOkh3QehHjcFQeAu+IGrlbax3AM+HdJx4Rs5l7c5RDJTAwydXJVqmLNnSV55RJqg2nKCVJjUwIEmX4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7721

> Sashiko AI review found 8 potential issue(s) to consider:
> - [Critical] Unprivileged Denial of Service (Hung Task Panic) via
>   unbounded uninterruptible sleep.
> - [High] Use-After-Free due to timer resurrection during teardown.
> - [High] Illegal drop of port->lock in UART callbacks, breaking core
>   serialization.
> - [High] RS485 data loss via software state machine bypass.
> - [High] Software RTS state and TX-break bits are wiped out by
>   absolute LCR write.
> - [High] Broken RS485 break signaling ignores transceiver polarity.
> - [High] Resource leak and Use-After-Free of timers/workqueues on
>   probe failure.
> - [Medium] Spurious before-send delays corrupt the RS485 timing
>   envelope.

Two of these are real. Please do not apply this version; a v3 follows.

5. Correct, and this patch is what creates it. MAX310X_LCR_RTS_BIT was
defined but never written before; the patch makes it the software RS485
RTS. That leaves two ways to clobber an envelope in flight:

  - max310x_set_termios() writes LCR absolutely, and the core calls
    ->set_termios() without port->lock (uart_change_line_settings()
    takes the lock only after the call), so a concurrent tcsetattr()
    clears RTS mid-character.
  - max310x_set_rts_ctl_params() drives RTS to the idle level
    unconditionally, and it also runs from rs_work, which
    max310x_rs485_config() schedules on every TIOCSRS485.

Either way the rest of the burst is shifted out with the transceiver
disabled. v3 will leave RTS alone while tx_state is not MAX310X_TX_OFF.
The TX-break half of your point is real too, but it predates this patch.

6. Correct. max310x_break_ctl() passes break_state straight to
max310x_rts_ctl(), while every other RTS write in the driver selects on
SER_RS485_RTS_ON_SEND / SER_RS485_RTS_AFTER_SEND, so an
rs485-rts-active-low port drives the wrong level for the break duration.
v3 will use the same polarity as the rest. On the hardware path
IRDA.RTSINVERT may invert the pin and mask it; I will confirm that
against the datasheet rather than assume it.

8. Correct, and known: a write landing while tx_state is MAX310X_TX_SEND
does reset the state to MAX310X_TX_WAIT_BEFORE_SEND and re-arm. The
txlvl == 0 gate in max310x_delayed_stop_tx() exists for exactly the
mid-drain call that results, so the envelope stays correct, but the data
does pay an extra before-send delay. I will skip the re-arm when the
state is already MAX310X_TX_SEND.

The rest I do not think are bugs:

1. Both loops are bounded - the software path by the computed loops
count, the hardware path by port->fifosize + 1. The hung task detector
also cannot fire here: it looks for a task whose switch count has not
changed across its timeout, and both loops sleep and wake every
iteration. The longest single sleep is one character duration at the
lowest baud the BRG can produce, well under the 120 s default.

2. max310x_delayed_stop_tx() returns early while tx_state is
MAX310X_TX_OFF, before it touches cancel_tx_delay_tmr, and
max310x_shutdown() sets that state before it returns, so a late tx_work
cannot re-arm the timer. tx_work has never been cancelled in shutdown,
including before this patch; it is cancelled in max310x_remove().

3. Dropping and retaking port->lock around hrtimer_cancel() is
deliberate: max310x_tmr_tx() takes port->lock, so cancelling while
holding it would deadlock. The timer is not soft, so
hrtimer_cancel_wait_running() only does cpu_relax() and nothing sleeps,
and several other serial drivers drop the lock the same way. I will
switch the two sites to uart_port_unlock()/uart_port_lock() in v3 for
consistency, although for this driver they are no-ops as it has no
console support.

4. I could not construct this one. max310x_handle_tx() does fill the
FIFO without consulting tx_state, but the TX-empty interrupt latches on
the FIFO going empty, so from idle there is no tx_work already pending
to run ahead of rts_work, and mid-stream RTS is still asserted by the
burst in progress. If you have a concrete ordering in mind, I would like
to see it.

7. hrtimer_setup() and INIT_WORK() only initialise; nothing is armed or
queued until a port is opened, and the out_uart path calls
uart_remove_one_port(), which hangs the tty up and runs ->shutdown(),
which cancels both. The pre-existing tx_work, md_work and rs_work have
the same shape.

Tapio
