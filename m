Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020112.outbound.protection.outlook.com [52.101.84.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE540B0E1;
	Wed, 16 Sep 2026 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542695; cv=fail; b=PTcVUkE7VSNNiGFzq4WXwJ/j6Q130RXBAzvYIy/2/TCLbNY0KD7iMAZCcy2g9vIKfhjVyWqvQdCSc4vk4a1yJdL0wW6Tb2/CIhYsYNn8eUqACumNSwUWS9uWcurLM3/G4CO4pkTO4CBbEkmMOpfSfM4fjThjz5l9HF9t/5BNfqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542695; c=relaxed/simple;
	bh=xc57Vu4uZNqGaLEKYtohZc+d1qZffY+Yg5+fvJgLlLo=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=Nbqlm76XXW2P224FSCnuxTBO5GBmtL7wBg2Ge0XZLMNeMzmBWYtravdXXrsVlTLJLIe4Ucs/JFQzIbTpHF1JOAaj/tAoUX1pnYOS737Kwd+XC47y1ZHjKnp0WZT/5J0fwegwkGWQAHwViTCFeT55VvrUnEZHWQRr3Z0qbsBoQpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=OPwTmI1S; arc=fail smtp.client-ip=52.101.84.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="OPwTmI1S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0VWdmACL60DoHVOJCYLUnlvyep74JNfsFydaZesvbRrxf+mwhMsv75V+W6lLkSVt6LVCuWc8CvhYZxwu02q+3v8WmglxgjThAF8C63OHGefr704+SG5dweEDPNkPrpp5oL2ywFdnZXdznhyFz7K9G/5zzBlFITb9tK75+XSAnTzDpt6cP7oiuyd2uqPd7gZ10cFPtq6Qn8BEB83T+5C/yHILl8vG/iDFMifTjVo9tTWh75OM4Q8lzLi8rmg1h0kNH9YG6g7eXapqmUbzPxY0yfCM5LNPMUNYcj+nCCU3h27YWTAY4h3dwujylaJ3FHFkG6/paifpHF2vM6Fv8CMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Xj7ITXjbvu5PirLGiOWeYrq1MDyWTsyivbmv6lj8jg=;
 b=yfJeTapQMsYDvAm3u9pUKzfCTrK+5ttFcT8jiztWlCTDtkln+t5xiwcT/e7sBbIo931/afd51RwJzpTRjscV3z86poseLPg+HPJjSRQkJYuJeBh0SXDEVhyHGU+zwnOTW6mN/6PS3y9tCKPlWLXSPqxRd2EGoqnFikHnRsLaeiG+poUeBwzftkt8XvdXB7/ygA0ZyrxOo2Uis1ymBVm12AxayoEUIqFxqqUq64uzW+hBocXKXD9yUf+XjQRGylBylb+V8BgxqtgE8BNcwDLVNaANKG8YrQsd4t3t5nvr0um5E1V/BLlbvvTe6F211gAP2dCjAhH66IJt2wJFyiFWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Xj7ITXjbvu5PirLGiOWeYrq1MDyWTsyivbmv6lj8jg=;
 b=OPwTmI1SNJUEZqskuHaJwX1QUzEiyyrl8e8P8hUb4ZLlt3TB5XiSII0knJm8wzgJ0rtbBzZ8JVBIiJROFuU/p+7aRMDl0O8pqp1ZpFDLTCUNST+l0GArrrGEvJQWBX3BEIRf5ZDrVuwlt/BS4Em4RyjV1ya83clZ3rMlolGylRYEJifsFhSLrRx79JrQZK0p+a+jnfaW8HlmTR7VE4uZdASJQouj3fBRO+x4xeSHAHKGWJ5axvy3pCnc5wdIP+LQhNlUWG+uvFe6/SxHMOmJFnjUiTOPnR0qOyCNy6+5gaFgTIZpdjrboP85CFAynCkWHoETjGhf/OBgffzEnYhiuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by MI7PR06MB200238.eurprd06.prod.outlook.com (2603:10a6:290:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 07:11:02 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%3]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 07:11:02 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 16 Sep 2026 07:10:54 +0000
Subject: [PATCH v4] serial: max310x: drive RTS in software when hardware
 delays are too short
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-max310x-rs485-sw-delay-v4-1-d37a694342cf@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAP1AqmoC/3XNwW7CMAyA4VdBOZMptpMm4cR7TDuYJkAkoCiZs
 lao777ADtWEKp9+S/78ECXmFIvYbR4ix5pKGm4t9HYj+jPfTlGm0Fqgwk4ZIHnlkUCNMhftjCw
 /MsQLT5JJdcE6Cga9aMf3HI9pfMGfX63PqXwPeXr9qfDc/pFW+TWyggSpjeYe1MGT5X3lVPjCH
 /1wFU+04gI5gFUIGxRJoyNUxjr/DtECeTCrEDXIBlSs2xwM/ofmef4Fdp4nOVABAAA=
X-Change-ID: 20260513-max310x-rs485-sw-delay-a306d783d529
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789542661; l=30023;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=xc57Vu4uZNqGaLEKYtohZc+d1qZffY+Yg5+fvJgLlLo=;
 b=zj93SLLRyZk17Lry2UIt0TtLIiusuSL3be6M4/IHBabchCKgeFvDzZI22lrkPv4GZ4v58PeYj
 +VQhRmQ5xHwCVmGzfUjGw1Ew0M2UDt0HB8wiR3AjODBSi/Xge/Ii+kV
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: BE1P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::13) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|MI7PR06MB200238:EE_
X-MS-Office365-Filtering-Correlation-Id: 700b1f77-b5de-4dca-255a-08df13c1aaa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|6133799003|5023799004|56012099006|11063799006|3023799007|18002099003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	E1Aq8no7IA2N8oXheCAPxilyERN+PzlMAI1a+LVviUt4bekga7FoyogvdX4B2EX7lNiWdRNItEwSujYtFpKq81NjINQ4FVeSB+L0jLP7nkhFDpiqRY/ZPeK6qg9b2Lsh4ZcFWZsCZe0aEBfelywuqsHIn6z8wpUOViqk5RBK6F+L+37MW/HRVtvKxCU20bMN6+ydp4oZWmqFKDAndzUZS7f+kxhlcgOcHMkydWeRjxRHh5mWh0+RsWP2/IkMMJSmHxsnn9GFHq4l0DANXdja1zM+68Etl792HsMoiAehJ+gCmJQKnh1yEGRW0J2KkTN7Tno34TCyjd2znhNu/k10ud7NrqaL1gUVHpX2gofm/GX6nDwxdw5xRNYYGuEyW8Q0Jgfi3fRX2NLDnCgFp5GnXXVUnr0aw3FgLfXvW8xldKMaLJO5otflwvHOWM6CS6u4WKYAmrsMFGBsSpraO1Oaxmahoy2YSA4Tl27zDV9PaCa/kNpOPKrboSwLosyYSCViKxLb9MvfENZPDdPqK4uMnWsvVy902MqCn0L5Qn44wPRvkCzTuGRoLd0NswCVLPK+QuVyTRHKqBSTRJ+X+3GS8YXNyqXci5VC4Yx77pCeE/mZWvrYFbgUATBDfXVpilDBSVyZ+Vukl+X6H34aEwvBgvaszAVXVKwtPw17xH8UaenO5grx/EztbBbbxdkDr6cGqn6kcMsSvttMcbx7C1KAysImtl3SijPO7G2sTTFJQaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(6133799003)(5023799004)(56012099006)(11063799006)(3023799007)(18002099003)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d25LZThXZVBHOVE1TFBnY2E5akpZcmxHVytrZGpwRytjT0VmeWxJcE5oeWg0?=
 =?utf-8?B?N2dNbzFQOGhzS0JwTlgxVXBCc2ppeGZaS3IzL3p6YnhrUjk1YUNQOS9PM2dt?=
 =?utf-8?B?ZkRHbnNxeG5hNzMvazl4OHdtWlVKOW1Dd1RydjRqdDM5ODVHa1BRZDIrMkpG?=
 =?utf-8?B?anMzYTRnN2psdnhwTXNlWUw0OEJkb3R0OEhjOTljS1ViSU9ucjBJSW5ocERO?=
 =?utf-8?B?MVVNclpRQTY2NjVabjhUTUI5blZqbEl5L0lPM09ZTjdXaU9vSzFVV0p2TndQ?=
 =?utf-8?B?ZnRtYnliV1IwYVNXTnR2VmJEV0VaNDlMVUxJWVJUdVZnMjFubXNlMTEycG5E?=
 =?utf-8?B?YmhnKzZPcUp1SGpWbGxTWXNFYnVhQ2d3QUREWE5yQWgwelFHU2t6WDVYL0pB?=
 =?utf-8?B?M2ZxZGh6VVYxSE5HVzUvNk9PcmVBQkhDNFM1YjRYSnhzZFdZWG9zL2F6SzJQ?=
 =?utf-8?B?MWI4REEzMkxaNmFCYmJhOUtENnZHbWtQYjZlV3A5NDdkZUJaS0dLb09kM2w4?=
 =?utf-8?B?NWFqdGVlRCtNTnNpdzg3RmJZUWNZZEdydWhUazBYbHNZY2gwMWZOaVFEYTJQ?=
 =?utf-8?B?THdQZUd2azNPazB0TmE5cFlkWDRHQ3NiNlpoOFdvS3ZTWmtHVEFZT205WW1x?=
 =?utf-8?B?Q3luZUJwTCtlN2dvWlJOaWlxZS8yZmE2MTRRQnR2R3YxQUl2L3NXOUpyTTE1?=
 =?utf-8?B?b09uaCtOZzdtWUo0dzRSYlRGM3JkeGcrWkQ1SEI1UXZ4VHgvZlUxeDlDYWhy?=
 =?utf-8?B?bmRUUmFidjNBb0QvU3JoOHgvOWdxZ1RrVS9uYm9UaTlNaEEvbEZSekNudmdL?=
 =?utf-8?B?dXZUVkpBMDcrRVBqUXBvUmRWeDEvYzhyVk1UZnlDMm1zZWVUdUt1STgrMldj?=
 =?utf-8?B?bXlUU05LRkxjQlg5S2FrdjRtSVRSbTE5eTZKaXlQcGkrSzgxRkVud1k2cE8r?=
 =?utf-8?B?UFNqQ0RuSTZxRU9CdFhRbVQyM2N2K093am5OeDE0NDZIMDJ6YVlwdVhwRlVa?=
 =?utf-8?B?WTZjUmlmdjMrYUJwZk5CVDFnS2JQTnFDQXdnU2YvQys4QTRCa1J3dVBORXVv?=
 =?utf-8?B?Z2Z5R2xvVWYrcG92dEZ1eGROeW5aYUhQRkY5M1FUa3p1elYwY1BtVTRiTnpB?=
 =?utf-8?B?bHVjaElvUks5emxCMEllK01jTFJ6aXdhRVg5ckMrbzlnMFFYMXU0dVdscWNR?=
 =?utf-8?B?RXJDU1JNSG5CSEtBNDYrWWRrZUhLVko0a3Z3Mm5VR241c09iM3IyNWFNSlFK?=
 =?utf-8?B?VEs5VVpPV1pPVVpJdXlVRDJ3S2RxSktWcHBEeHNiYmwzdi92UjdKMHJJK3Z2?=
 =?utf-8?B?dllCeks1c0xRMlhGMG10aG01dEhwbTVIYXQzV1BTRkNHT1hPR0VLRGF2NDN6?=
 =?utf-8?B?ZUpPRWxUUys4NGhtOHhCTTgvNXBEUmE2eHF5U003M0IvakRNaURFZFgzTlQ3?=
 =?utf-8?B?ZmlQcEhPQ1VSaEI3RkZuVkRJMUFwb0V5NXB1NkowRjkzTWpwOThkMUphRkQ3?=
 =?utf-8?B?blE5U1Jta3JDU2FSclh1dkQvTzNnK0sxa1VxRmtKL1FQT2p0NUhpMHFvMjNN?=
 =?utf-8?B?SVZOeWJwUXd4SkJMWGYvSll1VDlJaFZlZ0dhRkF6SGs2WDJFbnJoSk1ieG14?=
 =?utf-8?B?TjA0alc5RVAvTHZzWkYvV3pxOE1TUkpLNzlKdzRxWG96TEFUeTVFRVI2VjF6?=
 =?utf-8?B?ZG96SktRMFc4SjZoZHJNRERzVjdnczZxQ0psL05tdytSeGRsNzBaUC84dWd6?=
 =?utf-8?B?SHUwRk96eGg2Ny9uQWlncjJZL2NZSmRxOVJpOHQ1REl2RlU1Njd5VGRMbWxh?=
 =?utf-8?B?ZDZReGkrNHV5S3VORFJJaHNGOTdTb1BZeUJUaFZ1VmVOSTM0TjNVcG5RU2lw?=
 =?utf-8?B?VjhJQkJGRmphbmp5RHVZU0VhZnpqN3pKYy9Wc2cvd1M0d1FjSHlSMTV4bEF4?=
 =?utf-8?B?QUxDMzl1bjhzUlRxSENoQ2pXajhuVVg2Z1I0QzhITTFuQlE4UzJSMlI0Tmo2?=
 =?utf-8?B?NERseGRVU0NjQjNFWngxbURkS3RneVlJaGIrNzFTQk5JNm84VU9TbzFGQjFE?=
 =?utf-8?B?UElVS3BwZVd1b01RVVdOeVhSd054MmRiYS9PcHJDcGp5aUVZRlVmUEt2OXU1?=
 =?utf-8?B?bjdsSENYR3ViUzlIOTFVWWc1aHdUZUFyeGViZTFlY0N6L2NqaWNlMlZFRERy?=
 =?utf-8?B?N2xhR280NWRDMExLVVFTTTRrZ1Z6dlZ0WVNuQlNsemM1NUsydVhPMzdPeWRs?=
 =?utf-8?B?S0xnYmJIeXFHRE43L05nQVQ5QWxLd2VTaFpLcnlNUU93UEw1QjNQOFdzb0Jp?=
 =?utf-8?B?THZJNnNhNzBubHhIY1BNMk9QU0wzTFhkRGpOdjd0VlZ4VFBpaFQxWW53cE9x?=
 =?utf-8?Q?Lrszu9BnJQWXOsYM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700b1f77-b5de-4dca-255a-08df13c1aaa8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 07:11:02.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msOh2/9NcET28IbM3xawaHmBXQ/RYBiqc78kORuog25ph0rljkZCnGwI2P+xkxCIkDdCsH0B80Z7JEPMwmZwDaG9ntMnyL0TU3ZkKuYhb7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR06MB200238

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
    releases RTS. The hold is armed only while tx_state is
    MAX310X_TX_SEND, re-checked under port->lock because
    max310x_handle_tx() runs from a worker that does not hold it and the
    port can be shut down in the meantime. Using one timer and one
    rts_work keeps the before-
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
    port could be powered down mid-character. The delay timer and
    rts_work are then cancelled unconditionally: the software/hardware
    decision is recomputed on every reconfigure, so a TIOCSRS485 can
    clear sw_rts_during_tx while an envelope is still in flight, and
    neither may outlive the port. That flag is published in a single
    store for the same reason.
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
Changes in v4:
- max310x_shutdown() cancels the delay timer and rts_work
  unconditionally. The software/hardware decision is recomputed on every
  reconfigure, so a TIOCSRS485 can clear sw_rts_during_tx while an
  envelope is still in flight; gating the cancellation on that flag left
  the timer armed against a port that was about to be powered down.
- max310x_delayed_stop_tx() re-checks under port->lock and arms the
  after-send hold only while tx_state is MAX310X_TX_SEND. It runs from a
  worker that does not hold the lock, and it cleared cancel_tx_delay_tmr
  unconditionally and tested tx_state != MAX310X_TX_WAIT_BEFORE_SEND,
  which is also true for MAX310X_TX_OFF, so it could resurrect an
  envelope that shutdown() had just cancelled.
- sw_rts_during_tx is computed into a local and published in a single
  store, and read with READ_ONCE(). It was assigned false and only then
  recomputed, so any concurrent reader could observe a transient false.
- Triage of the review findings that prompted the above:
  https://lore.kernel.org/r/c15330e4-25e0-4c50-9f48-dbb8d51f5823@vaisala.com
- Link to v3: https://lore.kernel.org/r/20260915-max310x-rs485-sw-delay-v3-1-7d20a4a4ab52@vaisala.com

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
 drivers/tty/serial/max310x.c | 408 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 372 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 022502986c5fcf1ff4de9328746ddc71677be730..c217857f5d32a85728f82ad52e02c3a9075eb0da 100644
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
@@ -776,6 +835,67 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
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
@@ -787,8 +907,13 @@ static void max310x_handle_tx(struct uart_port *port)
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
@@ -813,11 +938,48 @@ static void max310x_handle_tx(struct uart_port *port)
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
+		}
+
+		max310x_delayed_start_tx(port);
+	} else {
+		schedule_work(&one->tx_work);
+	}
 }
 
 static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
@@ -843,7 +1005,7 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
 		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
-			max310x_start_tx(port);
+			schedule_work(&s->p[portno].tx_work);
 	} while (1);
 
 	return res;
@@ -927,15 +1089,113 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
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
+	if (READ_ONCE(one->sw_rts_during_tx)) {
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
+	bool sw_rts = false;
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
+		sw_rts = true;
+
+	if (sw_rts) {
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
+	/* Assign once; a transient false would be seen by other readers. */
+	WRITE_ONCE(one->sw_rts_during_tx, sw_rts);
+
+	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
+			   MAX310X_HDPIXDELAY_SETUP(setup) |
+			   MAX310X_HDPIXDELAY_HOLD(hold));
+
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		if (sw_rts) {
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
 
@@ -969,8 +1229,12 @@ static void max310x_set_termios(struct uart_port *port,
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
@@ -1042,38 +1306,55 @@ static void max310x_set_termios(struct uart_port *port,
 
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
+			uart_port_unlock(port);
+			hrtimer_cancel(&one->tx_delay_tmr);
+			uart_port_lock(port);
+		}
+		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+	}
 
 	port->rs485 = *rs485;
 
@@ -1084,6 +1365,7 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
 
 static int max310x_startup(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val;
 
 	max310x_power(port, 1);
@@ -1098,21 +1380,20 @@ static int max310x_startup(struct uart_port *port)
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
@@ -1134,9 +1415,56 @@ static int max310x_startup(struct uart_port *port)
 
 static void max310x_shutdown(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
+
+	/*
+	 * Drain any in-flight software-timed RTS envelope before the port is
+	 * powered down, so the last character and its after-send hold complete
+	 * - close() can reach shutdown with data still queued and a before-send
+	 * delay pending. The loop ends when the envelope does (tx_state == OFF);
+	 * the bound is just a worst-case safety cap.
+	 */
+	if (READ_ONCE(one->sw_rts_during_tx)) {
+		unsigned int loops = port->rs485.delay_rts_before_send +
+			    port->rs485.delay_rts_after_send +
+			    DIV_ROUND_UP_ULL((kfifo_len(&port->state->port.xmit_fifo) +
+					      port->fifosize) *
+					     ktime_to_us(one->one_character_duration),
+					     USEC_PER_MSEC);
+
+		while (READ_ONCE(one->tx_state) != MAX310X_TX_OFF && loops-- > 0)
+			fsleep(USEC_PER_MSEC);
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
+	/*
+	 * Cancel unconditionally: sw_rts_during_tx can have turned false while
+	 * an envelope was in flight, and neither may outlive the port.
+	 */
+	one->cancel_tx_delay_tmr = true;
+	hrtimer_cancel(&one->tx_delay_tmr);
+	cancel_work_sync(&one->rts_work);
+	WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+
 	/* Disable all interrupts */
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 
+	if (READ_ONCE(one->sw_rts_during_tx))
+		max310x_rts_ctl(port, max310x_rts_level(port, false));
+
 	max310x_power(port, 0);
 }
 
@@ -1291,7 +1619,8 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static const struct serial_rs485 max310x_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
 };
@@ -1425,6 +1754,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
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
@@ -1535,6 +1869,8 @@ static void max310x_remove(struct device *dev)
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

