Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021104.outbound.protection.outlook.com [52.101.70.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35041A502;
	Fri,  2 Oct 2026 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926146; cv=fail; b=Oc91ipFJKd+EvHbOU5RxYbAD68saZBJ3Mek7nJ+w8KkHWFhF5b8Pze5XgLtmVI5HTLkFdiHTbqAD+7rOXHQxVWrybX8JK+tVkwgJYIuoh1solVx0w9cKNlROB4wVB1rE5cqaINVtBJDMgHqhXh9vWTYgChNKDXEyzFmuv746rvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926146; c=relaxed/simple;
	bh=zeY4oYwJ3xnn0b5JpPE3OKTtna0Q4k9/uWwU58hQVkk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n/KtQmgsvLwHi7vqRJOvsz1+0XLj4U3CWFilpkTe9I1enR/Tu+Z+XgHWCUdHbCoD3ccA1Qw2NVRmhkMrq/NvPmkQirnnUC56/wq893nOeX2TY+enhpWozsJitZ0JsM4EN5w6WGjQu42Z2YTY1V8Ja/0QRmsi5VZdPDOSPuHbbsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=OFJczCTb; arc=fail smtp.client-ip=52.101.70.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="OFJczCTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaaxkAe9QUT4sYa3KXkH2B5zv1lZEiHAFYQMlT17qk8rgmj47Dxc7xkxx90t6khmQRXRlaNE4RVtVWxPWaWkr7hXUbvHy/HZzxGcEy0JNCprDNHBVwOW+swrChcESaRUWyvga/xDz//s2BdTnrZj1oVGMyimP0u5taUbUyDewm5R1pP3cj0ofo66/XKNd25o8Ql8kG+hLDHTWBSBEufgRxSvWWSuUdMJ+GAVx9yGk5a8BkBw98DDwiS2kygtEeniPd0u7+YkjHuXmzTp+u2kf2FKUmij9CLBZKiAlnuKAH6tFO+6Wehz+BJsH6yo0ItNXpSl8QE3jsI4kUlCYVqoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuGfgiSETLHSay6xnR7xLLijTKUrUXDo9gwzm27Aqyk=;
 b=R3Z4Y704okN36EXecAw1pNzkOmfcG5Qwc0QETKc6XJfr/XH23Ij2TEys5qZhgQC7Ck5yP/lcLagojGxJsXx3GYd811XvdML5bWEGVTozo136vvpwy1Jt4VJRk1dEzUU8HIsnOiKaVOgydgsiDQyJM1EpuT3bwmhN+MiQN2sVyucXVYtny+IDW2yyMxtDZpO8DgK8ooliIryqYf3Lh3ldTHum+s8cwPI0qYAn00E2kU1P7vn3Ztxps8ssIXJiZ0lvDbNhOhWnqC47DgK5K2mkJM26NAhnnj/5N63rYaAR3WQ/ADxSFCFqnLdseM98jkGWnxUZ5Duws1vepAnhekVLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuGfgiSETLHSay6xnR7xLLijTKUrUXDo9gwzm27Aqyk=;
 b=OFJczCTbnhG7DK/s8jBrCG/+U7A8V/CKX6k6d/We5HfQOUkwL0jbHEfaU1o0dVjCt6A0AB5APpdH7FGI7Kg5ZpRJ/kRNaoKIKU0Yjj6QeMcb4OJnoaqY+MZl+MHPKx6s6cHwNXvdlicvxnJtkBiW9x1ucLdGfDm0XPq9wy9Q7I6i8bXwKu5pujMvoZEG2MiZB7rSwReSU5y5h23ekNufQeoXOY2akrTsmqqebRL1C5mXCzfDiuE/IBjPa0PYWLeDptMF+RJ91GFFD6fLglMHTrAtqohPgl4+UvyvCVGAPbyzHJkj++Pql6f+fXFvVwiQxx7Gun941DqcQDWR/wwFWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by AM0PR06MB751761.eurprd06.prod.outlook.com (2603:10a6:20b:7f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 07:29:00 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 07:29:00 +0000
Message-ID: <e1c4b08c-8e91-4368-8fde-6deb989995e9@vaisala.com>
Date: Fri, 2 Oct 2026 10:28:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] serial: max310x: wait for TX to drain before
 powering down in shutdown
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-4-ae46afa583f2@vaisala.com>
 <20261001160020.5ba190a2b747f0c66f8b30d7@hugovil.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261001160020.5ba190a2b747f0c66f8b30d7@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::11) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|AM0PR06MB751761:EE_
X-MS-Office365-Filtering-Correlation-Id: d175c346-4e52-4635-eadc-08df2056d3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|5023799004|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cwupcKKTXtxhV92ROuPnTvjB6ewp1liUTWyB4iq7peXAYft3Egnc2hOWrnN1oEz+j0QTWo3dh+/CE0qJbkoYXzKLdaMe1QrS6YgU4Hm3jb33os+WRO3/eY8agU7u7wmjn6uSGPSXUyiijzunzQKroGSdBp2Yy0pGVDcjKLkqtQaxGb+kC6uEbJ+Sp6iqxOpvPSoslekBSq7iRXMO6PwPQpP7R1Zn0nJMjxSXpdJsS/f4W/DSAnGyX/aLd/lMwNPzyIq8oxkKjP13bMO7mny2gd0WqbW4TD47cIWIr7yjiAjfmzhE4IyayTXx4miCF658nIi7viwqn5viVaVSdD73X44nF78Y9ZwpTydjCLIN+JyzfdP7DByArTUU9zE0mQ0BAL69K0CLDihDD2KmlhXHxX5tWEKgi92WRVpg+8YkttVZ1TVhBT9+UGZQ56515kLHXzdQ4f66t+N8qaj5bYjfrlA5BPFjz/9LXaa6mJiwjD7OBE6ndbYPlBY14xjyE3YgnIdFswSE7i/sJ/IovJTfj8l1y+yOe2i/Oe9GnICX+k4FbUdOa924WEDL2of0zLN5mrXmWUBuFaJwvifpgcMFMzcPN8jgNlM7PL+VhrUrYPxqF4WN/n/5L7WoVxM1hIToHi7VdDzIiNikHZAUeihFaAWsTx0F3GcymEbssYuXO9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXl0YzJNcUlCWW9NcStmVFZiMjkwZ25uMXU5bE51elF3V3RpbzVhT1JBZnZr?=
 =?utf-8?B?U0dRVU8wZWZab3NsYzNTL1Z3YXBNUVlQY09pdEdnOFBkc1ZUb0ZIQ2RoeE9n?=
 =?utf-8?B?Y21MaHE5ekE0OE1XMHRoc1F5MFhZckJmYm5qR1hENTBMbFc2R3dHUDBxa2gz?=
 =?utf-8?B?MitWWVlaNVhxYis2bXdDd3c5d0Jhb2liYml2ejhCaEk5RVg5UDh3UVhkN1FR?=
 =?utf-8?B?NkMyVlhwYXhLajZnbWtzbDg5YjdKWDJkWTlnZ0xkRGlWdnlEdUtPSVdRNEg4?=
 =?utf-8?B?TjFwY1VPYi9qdytLdEMrZEVURHJ5NGxMT2hZVk5lWDY0SGlJT3IxLzBsVkli?=
 =?utf-8?B?RzliZzFxWWpGeFdMbnlwNzlUMThRZkNsRnJLa04zNEpvUzZubnRTMEpSTFh3?=
 =?utf-8?B?TEVLOHN0VE9UczdMVEF1V3JLNDRHUk9xYm1Ha3RKdTMzSnhYeDNYM01EU0dG?=
 =?utf-8?B?YTcvN0k1U3BPeVM0Y3RFUWFTRElpTlFrZWZLL1hXcFlMaXNtdjAvaytwU2JR?=
 =?utf-8?B?Vm1IN3AvMVQ3dUIwQ3FDemFDaERKSDFDYXZzbFRVYVMycWRZMlNmTjJ1bFZo?=
 =?utf-8?B?ODh1YTdLZVBxTGNVQVBtRzBpb3dGQzhOaHVIOHozc1N4L0l5dHBrZDJJTTdZ?=
 =?utf-8?B?M0ptelZ3YzlUeTlCOVhnOUdOWlcrOVlqQ3VlejJGa0VORitkQ0t2dDE2R09V?=
 =?utf-8?B?UDU1N0Y0TnhOZkJrTmJDbUhRTWJkQUZoeHE3STl1a1FlUU1VTm15YmJpMUFD?=
 =?utf-8?B?SVhlMjd2dGVydmtyeDI3ekV0WCtSM05FTDFkVHBXVEs1NzdkTzdIRDVoTVFW?=
 =?utf-8?B?a1BDRWRZYno2TjQyVTZkZHpHSjhhZWFSWllFdXk0Um0rb1huNGd1akZBdUlt?=
 =?utf-8?B?ZlVTeGVmVGp1UmR5TEx1M1Q5SENma1IvY0tldXV5QVJqZWZTdUFVZlVnd3or?=
 =?utf-8?B?YlBGZXVCQkN3THRKNHJOaWVSU2lwaEhIZXV1N3piOXZ1bGFCNFFFanZtSXF2?=
 =?utf-8?B?M2cvZFF1RnVydGw0Vnp3SEphSENrTXA3a2ttNE5pTVhZbU4yRDA2cy9jTkh6?=
 =?utf-8?B?ckcvYTAzU1YyamtLclNrVVRiYkRQWVBUa1JnV3E4MEZqRFZhL0kySjZjU0Jw?=
 =?utf-8?B?MW8xK0F6ZjBwRmlBQ1RPR2FkZnRNMnYyakx3Q2NrYXp3U1ArSkhEcGVCU21H?=
 =?utf-8?B?WEtYeVhmMm5DVFdLRXRiSmRYNUFyS2tHZzJmSHVZbm56eWNUTkVZNFhQNFAw?=
 =?utf-8?B?UUtQVjhaQStoVnEra1ZQa3dxWVRSaHZjRWNBTUxaeXJOY2VBK0IwWldyWjVY?=
 =?utf-8?B?bXhubFZ3eTE3RklDNDhNM3pIbFBacG0xU25mYzNhY2ltelJtZHFaYWVPQmJM?=
 =?utf-8?B?S1QzR0UrZ09EL0tEWXNZOGpJZHhmNFZZaVhvM01sS3JLTmFUTkxnd2NMSXdh?=
 =?utf-8?B?UExheE5aUk13VldyOFVybGlmSmJzbzZnRXg5N0dJM3lSdmhWZ1o1ZThOZ1lq?=
 =?utf-8?B?Z1lJNjFtZmlpYkxic011TS9qYzA5MHk5YmpvRDRTWG1PaFdHV09rMlNJTHZ6?=
 =?utf-8?B?bUhtNnE4SVRraFZYeWw2SnpGSTNRNkczb2VneG5CSFNqV0tLWkgzUTR1dis5?=
 =?utf-8?B?RzJHbVJaRzhsOGJuZ3RibDVjY2pWYmoweElqYmpIMDdUQmE5SGhzWTBpRUNJ?=
 =?utf-8?B?QzlPTC9PdEFudittZVlMd0U3YWVra0d2THRvSWNoU0NQMndQa1BmQjVYcnJS?=
 =?utf-8?B?ZGM3NGhFN1E5Z3ZuMStKZEtpWWRzQ2VBOE5UcnVsS0s4TkY4TVdPanFWYnZs?=
 =?utf-8?B?ZWhKSzI0bnZPeXVqWjRuc1l4VkVBa3o3Qlh0eHhaVm81L1dVVThFcG1yMmJY?=
 =?utf-8?B?Vk53MkU2SThtWFBTcnFLMStJOEV4dnBSWm5rbklPUlc3Z3psa0xjaHo1RnpT?=
 =?utf-8?B?Zkc5SGtUUjEyRGZETWxsbk16NHI4WFNlNGlCRE1XdmNXSTIzWWNLYkJ0OXMv?=
 =?utf-8?B?Yk13KzZuZFltTTNOYVl2YXNXL1Jkd2UyVkdvZkFkNkVzR0M1UTJNSWkzcElD?=
 =?utf-8?B?eWhtSVFNUEVnTWtTMFliQ2liaGlRT0VRMTlHeTNmN3BvZnI5VjZxajRySnNx?=
 =?utf-8?B?UlBRRGthM3lwTWlsZUcrOHROSVhqemovUUtnQVgzbVBuQUk0M3hvS0dUejlJ?=
 =?utf-8?B?TmJHMVJkSXQxM0NId1FWNUJzWEpLcjZFNU1XSHpOdk9QOUVaTWpNSW5TZWdM?=
 =?utf-8?B?eHB6WkFhamRTRTU5eGxUZ0V5bVZySi9XTU5UV3lsMXJrQUo5WmRJQ2M5L05y?=
 =?utf-8?B?T29oeUY5UnFZeDBMTWtScStWR0p6a1ZMSCtTNXdYdVM4aC9pd09SZGVVaFFL?=
 =?utf-8?Q?IAcvdgwQszLcr2Yw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d175c346-4e52-4635-eadc-08df2056d3fa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:29:00.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeUErQgS+08Z8MtCS8m8wMLdt1t+tpLqFAwYqz2Vmnwb6CR1Olpi+dW2kypPeYfjutaQK8BQt0u74TL+PDiFAfePOONaoHv1v4FnYfGm9O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB751761

Hi Hugo,

On Thu, 1 Oct 2026 16:00:20 -0400, Hugo Villeneuve wrote:
> > +	unsigned int		one_char_duration_us;
>
> char_time_us?

Renamed in v6.

> > +	to_max310x_port(port)->baud = baud;
> > +	to_max310x_port(port)->one_char_duration_us =
> > +		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
>
> Would it be a good idea to if you moved these two lines after
> max310x_set_rts_ctl_params(), then you could probably leave the
> original comments and simply add a new comment to indicate "Compute
> time it takes to clock out one character", simplifying the diff
> (review) and readability?

I would prefer not to move them: the helper consumes both values.
The baud is what the millisecond-to-bit-time conversion divides by,
so it must be cached before the call. And as of v6 the helper can
also arm the after-send hold directly - v6 adds a fix for the case
where a reconfigure moves the port off the hardware RTS path while a
transmission is still in flight, and the takeover computes the hold
from char_time_us - so the character time has to be current at that
point as well.

> > +	unsigned int loops = port->fifosize + 1;
>
> tries?

Renamed in v6.

> Based on these comments, does it mean that the FIFO has already been
> validated empty at this point by the tty layer, so you don't need the
> loop at all, just the unconditional last fsleep()?

No - that wait is not guaranteed. uart_wait_until_sent() runs only on
the close path and is bounded by closing_wait, which can be configured
to none, and hangup reaches shutdown() with no wait at all. In
testing, a vhangup issued mid-transfer entered shutdown() with the
chip FIFO still holding over a hundred characters; this loop is what
drained them before power-down.

> For certain combinations of large fifo_sizes and high-baud rates,
> that could mean a lot of I2C/SPI transactions?

It is bounded at one FIFO-level read per character time, at most
fifosize + 1 of them, only on the close/hangup path, and it stops as
soon as the FIFO reads empty - in total no longer than the remaining
transmit time of the data itself. At high baud rates the character
time shrinks, so the polls get more frequent but the window they can
occupy shrinks with it.

Tapio

