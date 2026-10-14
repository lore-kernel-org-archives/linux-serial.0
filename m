Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021118.outbound.protection.outlook.com [52.101.70.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08733955C7;
	Wed, 14 Oct 2026 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961724; cv=fail; b=lg7CozprccfLZR/nuPEL/JT86eyaoS2tu7EmNrAYPudWVZOTAyddcJGDerTAIZWaNqa+Qm4LLytRdNvP+6sWRdhUICulvGuxT+GD5qZhpu5IxnAeg3LhsX6A5U4/Zqhq4ePoN/OcwMFf2YKORIyqXMidT8yj33X2zCUyOuEqy4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961724; c=relaxed/simple;
	bh=bR+vvVcbaoB8r8ZuAntcYWaJ9r2jg3mN5azF7wqvWgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hkPdnv802mAR23uXazGqk1QajNPvkc6l2OJy9+KLvc/89YeyFMGxDWlpp6sRpvP6PqRtKG6pRDl10IvCVB/7XRILOkrmRAyTUUAUj/odi2qlON1Wcvf1p/mNAboxT8MKTD3QOLAwn+OoCWV7QRAiNJUALyFXjkr1jkk7mwCYJsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=GhCZqfMk; arc=fail smtp.client-ip=52.101.70.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="GhCZqfMk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdolrwfJ77U07kiWpkHXUTRvUb7+iP7LezD8XSdr8L81KNJkQlPYSXQDhmbXd3NKB4H89elzHKznAYq0OacNvTt/GBsnB8vW+1JWYr/WIOW2LubNF15fQLzn2d012VH4vRNmfyFg9mxWyrfTXGk2HaJmFvn/OOmN33x9VrJMzWGNxuft3234IycDUwOdAEdnn+kMq6FTRVZInoiQ+d47U2edgtemGcbBeRyhOT9pnPvW6ECJpSVHRvc/qrF+YwosWufRXW5iiACd//yGvd0+PVPr6hK7BbvVkMayWwD/GfD3Ntc8bZasVpVRkVt+joJVE+NWxhJRpa1XhsRPn6P/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR+vvVcbaoB8r8ZuAntcYWaJ9r2jg3mN5azF7wqvWgE=;
 b=N1I8YfEylFmQ90CD+QboJuOXieecm1LQ/EOL9qjr448uzzCjCoExYx36V6wcOC4zoAjdwB2vnV4nbGxlDseFXIs3b5Ie9uF3sh7YCtfLsj++AI4zs6QX0SBGzZk63W9iK7v9Ns1Unw6j7N6OAmXRJ0pvl4Wx10Ezx0eVyhFikQ/xbnCIMlRxIJaVCm5lSyj9CghIuEKWIdUNmFfk076QDAO5aNMEY9ZdYxHfzs62PoDqa7sh/USl93o2M0QCq93+ipPW1r4DA5vWcr3LmHToTfeQyFJHfZ7ZOC7CN04VKOCGaasgjMFteCm0EwESbVqLk1KLF+utQ/NQuMy+n3I9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR+vvVcbaoB8r8ZuAntcYWaJ9r2jg3mN5azF7wqvWgE=;
 b=GhCZqfMk3WpifTkTLQH4QbbXHeAYtOWYN7/fvpZFsGselPQlcS2u7SL4ghZYzSTHuvX5olPn2mPv8uPashmYie/ovftQmkII1Ur2jgd9dv3BABV+0vsOFj1nJLvuJpeT9U8YOTzSnAbxs0jpDHvshN9JnaZC34YNhnra60S313VYxb/RonIku2FMbvW/jM8wkaJPYSWUR8WFSXj0mLJzd/1o96KtQ7oESu8fjqVSeYSxzmQUz+WqpHXPnn1j5wPdE2Sa4NPJmaQDQZy4N9UCKNInVBfHeC6qEp0Scs3Z9/blEMh8+SMrYyG3A8Ng+L171dBl18QHl6I3PWMw1F4OfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PR3PR06MB7036.eurprd06.prod.outlook.com (2603:10a6:102:82::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 14 Oct
 2026 07:08:29 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 07:08:29 +0000
Message-ID: <bd7c4f23-c90e-4819-88d9-9ee12089efd0@vaisala.com>
Date: Wed, 14 Oct 2026 10:08:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] serial: max310x: schedule tx_work directly from
 the IRQ handler
To: sashiko-reviews@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-7-6ba881f81e1f@vaisala.com>
 <sashiko-outbox-163987@kernel.org>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <sashiko-outbox-163987@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::19) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|PR3PR06MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bf614e-9ce6-43fc-0d8e-08df29c1f2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|10067099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	eW+PLhD78zs4OXUPTSnOx63+/8prX8/8Cu/GSJ/Wu2tHjfx7GW8RUH1+71R7TlgTWb6hleQOXvGba1vcKSm6K4G+rj3pULsZatnCmKf03UsUfuhfHqCPDjNRTacJsTmxEJIZDFJs/y0ufp2LGFHFLLiTYZORwyBjaqpjBiqgB209O/BULMtQa2muZq9Jig2prapn1YVicg4LI0qi325FqbjUpAH3Jr3LwhnqHf+qz92m4wcgD6da+Y9gIKV01PFP6knvtNhYyWI8uglc6aNhkB57doVJGqsQnJARU69g5IXXWf9R1MV0u195HqVOZDD9AJeIgM4kY85+I39pSXswQRitBvDlhhjjfY5GzHnUQhSfCNbJUvMoaIY0a9upi7YncOwncBsnlsZMczPjUItXPY0ftb+gESMsNh2TEsjYYQWx7PuRZT3MWhxu154GWzkBCJ/00p0X4SBetUIpHJ0QNZ0VxU1d/7KuyI1dLzbbi+M3Gs8zzqEeJCjY7Z5ZII0KQtP4enT5iNs+QEx3aRZaMYFZ1ExusPZ3RJe7lvFsPbqfDdIITTN9ES6orX/zYRTa6I69Jom6u0EwfKnACbLJAnp+wEa9kVtMBkxyl0/jPpdOXW8Uy2969Ezbx8WmJbFKYpF9MVpeEdPTNCirDxnp4N0nNLor5Twn9rywNtnk/+E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(10067099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0QzU1ZSdE5tZS9OQmFnSlcrNUVWT2d6cVd0T3VsZUQ2TWtWeGYvRk41WXc3?=
 =?utf-8?B?UC9Kdjg1TW51WC93MHJreFV4YXRyR3F6d0tOR3VMNlZYbmU0bjhJMTluQXBQ?=
 =?utf-8?B?a0NTTnlWUkpoZkRqdmVUblhDaFA4ZFAwbWpHc2dBckFlVzUvdmxuM0I0OUJP?=
 =?utf-8?B?Z0syTFNHMTVrMkp3N3l6RFVNeDNYS1oxbnNXWHZIZ2RndUNQOXFsbUpDcGJk?=
 =?utf-8?B?d1g2eTR3TGk0dVQ4TDdLS3NuTk8zcS9OcjdUUTR5WjBwaUFFdFYwTU5wZDVS?=
 =?utf-8?B?cmo1Y1lpMVNiNCtFdFBKcjlPMllMUWp4Y1JLc2Y2ajZxTnJxa0VTQjR4RFQr?=
 =?utf-8?B?NmZEOUR2MVZieXQ5Zy9FK3lXN3JqS3pVenB0eWZobE1mL1hrTURieUpuNnpj?=
 =?utf-8?B?d2FuZm1YNEtZK3FzSmI4M0wxWlBSTXZPV1dUc24rdElaNzA3VTl3NW1Cd3or?=
 =?utf-8?B?aEEyT0I3ZmQ5aXFFOFB2ZUVyYVVPVXROUmM2SitiTXg2Mkc2eWd0cFVDYTFO?=
 =?utf-8?B?MEphN2xHRnQ2QVhybVA4czdyMHZTb2NyU1ZsOHZoMlIrV3pnamZ5SzJ2Um5G?=
 =?utf-8?B?a2gzZzVlZHAzY05BOXF2NjRBUjVFNXNQUEtCckU5NWgvT1h4dHBVUWs2Vkww?=
 =?utf-8?B?VzcxSjJOdURrSFhPazlzdm1BNTdxbWJMZzVVUElPV09OVUNqN1h1Zy9UeVJM?=
 =?utf-8?B?amZKR0F1VXNyMStlY1NWaEV4dU4xeHZHckpReSt2ZEVEaGFlUSs1S0RzQlNU?=
 =?utf-8?B?R0wxZkg3TDNXRmtSVlVGYXhvTUlaRllUZklXZmFDVkowbFBXY1VsekJBN1c1?=
 =?utf-8?B?Y3VFd1l4T3dlcldJaTJjcm1HT2o1aE9sMmdJMTQ0d1JxUDYzN1htTVU1enlC?=
 =?utf-8?B?WS8vaGVtOGtOanZpTUx4RzQyV3BUb2JTTWVqcThBZTNObGpDVWlBc1BIa3Fk?=
 =?utf-8?B?ekR0R2gvTlVlQkcrUFoyM0hkS3lXaEYzK2xZWmVKaWdoVlgwNEJSMG5wTlY3?=
 =?utf-8?B?YzN4am4yb0R6RUpNQmN6ZnFtcDNJVDB4ZXVJZndLbGxIMFU2ZW1xTmo1NkF4?=
 =?utf-8?B?bGhDRW9JUXRHTEtGOGZRN0RzR1hxZjc4anNDcy8xWVFuMkc3ekxDd1FGNnpI?=
 =?utf-8?B?c3BPYkhaUzJoYkVXNHFkd1p1QlpiQTY3WGxKUnArQ3FCNHhhV2kxNG94S0kv?=
 =?utf-8?B?ZjRVMndOQnkyV1FmNFVreGhNM0x5MUM4UHBsYlN6NEtzcUYxZmt1VkU3eWwr?=
 =?utf-8?B?SjNqZThmeE1nY0ZVTktEZnhCWlVUSThqWjNPUG5nb3UvL0QvTjRINGpvMUxN?=
 =?utf-8?B?d1lwNEVpMExhNk16VTYreDZGMjA5bDR4V1o2SVkrSW5tTWF2aThzbk02L0dY?=
 =?utf-8?B?Vk9sMjl4b1pzeWQ1QnVYUHNBT09vc1RDUjJYT09NbHc4aENiMk9LWFZBbmVs?=
 =?utf-8?B?ZkxHVlVJNVcrYnJSK1htWHZiaU1VQlY0c0lOanlVVEVPY0ZJdXI4b1gwQlA5?=
 =?utf-8?B?eTQ0M0pwMzZxSWI2NHN1NFhzMHAzZkZoWHQ2SWJ4dXpZSGFQMnFPc3dURWM4?=
 =?utf-8?B?YWZUaExmSGtCUmczZFVjdUFheFZSTWE3QlN0RDdJQlM5MnFXRnhIYTQyL1pP?=
 =?utf-8?B?dW1IZTRvTWRiNXhWak5UR1Z2MDVsMWpTYmNEREkvTEtZdk9Ybk1mSEJCaFV5?=
 =?utf-8?B?Q0drTkUvbmtTeEhNaEJuNHo2Z1ZiMi9yUFdTNVg1QThwTkpPbG0zbkdxUG9o?=
 =?utf-8?B?Z2d3RHhIZ2ZSSEsxZWtZcFRCYzN2dGdtVXRnY3dIN1pweUhXUUNtN1E0WEMw?=
 =?utf-8?B?a2tkVWZic2FuQzdaa29zdE9rMEY2VlQ1V212ZlpjelowdWNwcmR2d1RlZzU5?=
 =?utf-8?B?Q1MyS0pwQ2llcldnL0xIWW83czJCcjRsQjEweDlITitvMGZ4Z2pPdkt6ZDBt?=
 =?utf-8?B?aWJQTEM3dExMSUdlRnY2M2hWbko3S1FaQzh6S0ZIRUo0L1FkVXg0UUlQRXNj?=
 =?utf-8?B?T3c4aVVsaWJIaDVuN3ArY1d6cXNIa0Q2bVFLZ1JoQkVGTkpUUXFnUUtGMXpR?=
 =?utf-8?B?YStMTnRSSWxFT1N0cDI2bGUrbVM1bDhCaWEwZHZuN004aHVvT0l4WDgwUjJU?=
 =?utf-8?B?WTh0Z2xDZzFvbG52d2YyQmNGTk4vMGgxbWJmQXVUd2ZXZlhJeEV3UEo2Rk42?=
 =?utf-8?B?R0hRUTdqbTVIejZ4STFVUjFkbDBWQ3ZrRUVFTTloangvMVVqUllERDRWelI5?=
 =?utf-8?B?dWRERnJXbGh5K1VmS3RVVVhhN0JQUGNmZS9lZGtCSEhsMktnRmFXVDhDOXZ0?=
 =?utf-8?B?VWxjR05WK2tyQ0lVQzZCODRIQTcxQWg3RXNZTTRiZFNJVDFGZ2pGRlZCS1Nv?=
 =?utf-8?Q?aNKz3Cxd5XBeY0v8=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bf614e-9ce6-43fc-0d8e-08df29c1f2cf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:08:29.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7ZTdhdhBSeehPUGxqn6/UPnqeIESkGCnoW4Eoh/oczLbvg7ZGwfUgQdiHa5Jih+Lb83PgljYyR/Piwh5Cm85Hcss6whkkqwzdCRVtu6CHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7036

On 10/8/26 13:04, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] tty: max310x: Use-After-Free of workqueues in probe error path and remove
Pre-existing: max310x_remove() has cancelled the works before
unregistering the ports, and the probe error path has lacked the
cancels, since the works were introduced - this patch only moves the
ISR's direct handle_tx() call into the existing tx_work. The series'
teardown interlock narrows the window; reordering remove() and adding
the probe error path cancels is planned as a follow-up series, since
it is unrelated to the RS485 work here.

Tapio
