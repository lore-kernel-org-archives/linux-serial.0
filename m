Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023133.outbound.protection.outlook.com [52.101.83.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9001A6803;
	Sun,  4 Oct 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791111414; cv=fail; b=ujzz4RrjjLdtU8lzkLLVEXDCjvx4LUyN31s7UMDytyRIIIClSIjcpoJ6hqe75CFE6PYL/SWvnba1LDwLi02VG/HgA1tWUm5xFgDuhzUxIFLj2djzk4fYD15aI6Qy/43uHgxhb9+AwhLM48msKU8Ux3vnpfFTvHnbpm0v41ND+VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791111414; c=relaxed/simple;
	bh=ih64jrM8ZZL/8acd3lbrgi7fnMoXC3Q8UxNIuq+HW5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aOFmse3Tm/fO4jcpKN+bizApel4sn/RmuYZO49WohiO1PeJh2GecWk0FT6Ux2DwDtuiPRQDMA92Oad9GIJnxx+siAeBuoY1KqF0vdOsu+qHVu0CNesDET/glSYiu8YmWoWaGtVT0aGGRISfA87wD0ARRnIio022jXltx3qzBwMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=O3HhvBbG; arc=fail smtp.client-ip=52.101.83.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="O3HhvBbG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1VH5VHgiMb2pDxzMUKUy48tz54RFFifNJfOPGP2xTuuoHSvMmnXhQZEFjdHbIfulCsETK1uICiJ0MI2+bYBk0ipbvPDF/HXJyAxm7BIjgidG79OWmflZ8sO4ETn+1yrORsnp+k9VO1O1bHQ5h6H3Z1iTF6pynScTN/Ds7Axe96FYpzwMprhBrRrrZgn0AYKgz9GHz3g5mT/jYKsuHmurmwLKA3LthPokqFz11L4iIlthJpK0KZiUFBE/vPJ6+2m+DkwK+IE6+v2+mdnmgfCSN0z7SmeQ88DEbfqPI/HoD+BLvHMz0tPATY7gKaXC2LaISDjWcEAgbpb9VDs2cuo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8gy1lDJKTj3jZJSwgmUot6QfSbV3q5tJ7+ASxpbfT4=;
 b=RyQ7MPGf8aa9rphMS55vJ94bWtJkwteXJvYn6nqXRrBktmEGZjK1e8qm6zZUR/oYnW4kof7u44pk38ouKR2YU/bW60nEs8p4Xiu9e+1NmG/YJ7Yy4ZWX3lLHAqwRAfzg9NXUi2K8DlaOjsJ9/3fcupjMPs1c8mraX7Dtj+yaol6/Wx//8KBgtUYCqqqBgVBCQPWp2xvcyFr1wIzzMcTIeJp+E0lb380qOrsL9yl0Zgy2YZzUzGr/uBWS4q3CgexfHG3GPt89zsIYmQNDXmP9lJShZoGVfEGNZOXbrhrJ6Y9/Vn+T3RNn/HGFFT9tTZiov163EEj/kb47BL/tAY6UyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8gy1lDJKTj3jZJSwgmUot6QfSbV3q5tJ7+ASxpbfT4=;
 b=O3HhvBbGp49gvwWkGqA3UAZP+EiyV+DHdpeIbonYX5tsLw4EwdM5HBM2xz3kPSEiilggmGWgOSQHRWOzkDMGAAqxg3bAPnz2OEk6w3cXxG+y8wYp59kl4joXJ9kxSjjfoZlZsov9Kn0vTIEtTKDkBUcnQBz1o9cCGo+BbT5yKtj8wrrffG6nwzjIYruaUXD1zUGe4UUirZ0DdEvdyp2bjfghYBTB+eueOItaM1N+oku6DmYTisQfBNNl8OIUg+5M306j2HfFQ76U7h5o3aXiTHEpo5Ef7GVq+fZDbmT619H1YGvamAF2eyWPm2glBR4dSHskHvWMhvFUixsVcjCzbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by AM9PR06MB7987.eurprd06.prod.outlook.com (2603:10a6:20b:3a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 10:56:44 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 10:56:44 +0000
Message-ID: <9fc04933-a0ad-4642-a697-323ade121616@vaisala.com>
Date: Sun, 4 Oct 2026 13:56:42 +0300
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
 <e1c4b08c-8e91-4368-8fde-6deb989995e9@vaisala.com>
 <20261002110127.cb172b3f28d20aa5330990c4@hugovil.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261002110127.cb172b3f28d20aa5330990c4@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DC0B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::274) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|AM9PR06MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b6a74e-f428-42ce-5b82-08df22062dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xqTt+MtWv36Nej5YceE2/ILt714jXFF3phVdZPITkTyhnPbOAXmg87Y5G8clUkHZxZdIX3QETXdOmuave4075xsdI54GAxkiP5sEHbFIAbwVenvBQcNp1AAK4vmbU2JGo8ka+z9TGSXlE8Do8uVAR4Ob8c5Wiu/pM/NF5rpFZ/gpMrxBm0aKKuVnW4AblR8Pt6+7hT3L05DTGoyR1P4zZWsOzn8InEKUHeZZQZK+1foL630NmMJKkxPSz+yXbAgLOUEfV+DPpYNdrcxP9L4ZujyWMsL9BrNR+/H1Bv1/9kozgLy9jYR3ZB+oGpFon88Wvu5Hc6rwnU0PYSDX5+ZXJIKk5xzs5rnhHzBJKQ23Yg/C4cvPf/8hCPErkZQlsk9F4QPtrFhVMJV4kprDsGqV6qNUf4mqRYnDGRSLZ5n2N2HfFJ2feS8Oc5A8C9pT+HcH1qkQfQ1XPR0LP/5QV34U/IiMoOgFyFL0QaoATZbmBo2FMp+TrhMXL/yYVp3JW5qVlhUB6PRVYa+e+PylVIfSCfpP7X2j+5vuqZeOptU1Z5KzvduNkGXV01PCxEcva0zOAc6G6e7xk9rgIwbTLSJAUPqqh2beky54g/R86uv0vMs29c/pkbF2ECVelFvMMd5iJiFdjrxjmjiyPPEIRdO7KuHkyv0MVJ7cIh0kKZ7D788=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEU3Z1JVdkt4eGxBOWRYZTcrR1k5R0JZZEZBdnUwTnRLVXIyc3RMNENHeDBV?=
 =?utf-8?B?cHMrRi9OL0p3cmdXeFlRSFdHbU1sTGE2NDB2K1FYakpObS9hVjh5OGpvNjNv?=
 =?utf-8?B?MzJNekhqRWgycHJaWVVjZzdMVWttRDRNSlBIcm5VbFYwYlY1WUxxcVdRczBZ?=
 =?utf-8?B?WENPY2VxajZKRVNibzhIdWh6U0kxRXE3d2QzWXJzSHZ6T3hwcmNwMlFKZjll?=
 =?utf-8?B?R2E3VjlYKzZPNjFjakQ1TWsrK245dFk1TGxyTmxQdTFtaUhtUFNEeVVyMUlu?=
 =?utf-8?B?b1pzZWIzZElKdHprTEZIMi9pL05leTZ6d1hFUHJzSCtlMjA2TStKRUpuM2U0?=
 =?utf-8?B?ZUh4RjVNVFdaNnZZT3FZSmw5TUVVay8vS3E4VWw3c0E4ZnVjUHIveXFXYjh1?=
 =?utf-8?B?RElvMlJFdkN2QkdyZkJXcnV3ajBzOG9LeVNJOXdxeWhWU1picW5ESFFhaWtz?=
 =?utf-8?B?M1hOT3lVNE1QMjhhU1BadmpDNTFxZXFYciswZzhVYmJhMUN2Y0NMak9ndS9o?=
 =?utf-8?B?aGZuUW5veTMyUXZTYnlOQmxFMlFDc0xTNXMxZlBEbCtYRFBGT3ZQTitSb0F6?=
 =?utf-8?B?dGxKR3RDdzN4djE0a1pnRlYvcnRDTFNEOG1XLzJEK3lUZmV0ZUlBcFRKZDd0?=
 =?utf-8?B?KzVvaGpuem5Gd01uYUdLU000ZDhZYUlocnF4UFNpNURTZnpidWl6MS9HSWFo?=
 =?utf-8?B?OHhLUWNKQXJNc1paU2Zsc0NVOUNIMmlLL2swLzhpS1BFUUY3ZEpmRFdSVkcv?=
 =?utf-8?B?SWlzaXMzRDVYTldZQ0pnZ2lQZS9pSEVCL29qbGFGNDFwZVpMdmhsNjhYQ3RD?=
 =?utf-8?B?OE1oYkgweElrNDNrdUZMYXhMRTZNNGNwNFBaYUR6dnczNHp5aHNLQnRlbUYz?=
 =?utf-8?B?WFFaNTNYVUh4TXA3eFpCWFBob0ZTL2ZYeEJDZCsxZzRJbkYwV1l5T0NTOVlk?=
 =?utf-8?B?eWZhYUUwdGZITUVaczR5Y1hyRGZUQnpZUGsvMXU1MDdJaG9UOHN3VHREWmJT?=
 =?utf-8?B?UW9JQ3dvaDBybm8vcFdHVjJ4UkVUdUQ4VGVSTHFzeVNrbVFVUkJ5TFhxNC9m?=
 =?utf-8?B?c1pob0F2YlNBcFlEcFY5YjhqUzRDM2x3M0dhKzJYZVZRbWdsaksvSjB1MGd0?=
 =?utf-8?B?dk10OEdOdCttTWR4dnlvN0hhdWQ2ZU9YZndsT1U4U2RDOGw0RWdSNlNtUXgw?=
 =?utf-8?B?am9XZ3Q5OVh2Z2Q2VVIyT0hiY3Q5aTRSUmo0WHoxejRXMjArUlMxUVpFc3Z1?=
 =?utf-8?B?U3FXdW0zYnZNaTVZWDl2ZlYzZWlQT1lTaW51bFhFVzRycUcyNHpsYVdPQ0k1?=
 =?utf-8?B?NzBjTXQzakY5L05PYy94bWxUT0FrR0VYekRyMVBxNlloTTR1eHozSG1Md3RK?=
 =?utf-8?B?Zkg3NzlOMTFqd1loZ0tKclhwK2s1WFdaZHlKQkRNaW9TY2dvOFZ3Qy9yRTVl?=
 =?utf-8?B?bmN4eEhoelA1aElYZkljdUt0Z3JqVWJqK2hpdCtLSVF2RnBGSzZSZ0ZoTVhX?=
 =?utf-8?B?eGVVcitqdUxtVS9FaDlyTmFqQjRZaXlwT2RCUlN0VEJyMlBFbzlTSFczZDFk?=
 =?utf-8?B?aU92VHFiZEp5Z2dCa0l3TStlbElvb0dKTEUyTVU4VTBXNExMWHIvUW5oZCtX?=
 =?utf-8?B?NEZ4dnNOdERpdTNNd3RqRmxPa2ttQVVVcDVaNjFVZWU4dG1XTHNIOGdPd0N4?=
 =?utf-8?B?MGF1ZXRsc044ekU1SzdEUkNCV1JLYWJuWTkwOXRVNFNwajNjOWM3T0NsSE8z?=
 =?utf-8?B?TVpKTC94eE5udzJwcDhwdzRuRWVOSXIvajYyMFZNaWhkM0dlcmdJb2NWSnJW?=
 =?utf-8?B?WmZVemhRUW9WeGpjeERrUCtKZEdPVzZzRFJpSWFUQUNGWk1oRmRuY1JSN2Qr?=
 =?utf-8?B?VXVXMFFuby84QU9FSm0veVBsMnVraDMvTzZoY0tBSXFnSXdoM3N6UzF1emRa?=
 =?utf-8?B?eEpjZ2R4SmxMU1cyR0NHVlIvZzdkQVpTWDhFcEhtVE4vZVFyUFkvMmpzQTgz?=
 =?utf-8?B?bThqb3d6UU92UmxZT3lQcDVBeEZPbnR5YVEzekFuRmJob2hQSTNDZ0xleThW?=
 =?utf-8?B?NjFmc29ITFRUMXRBdXgrZ3c1THNvMWVEWW5aRlZpUWVaOUFFaHI1eWdLSVNo?=
 =?utf-8?B?UnJVRGszZVZ6RmErb0I0YWtTQkRBN0tNSDFWSVJKMUhIcHc0c0NCVnVsOW1J?=
 =?utf-8?B?TklRWGNpdTRRRVBGVDE0NUdRdzUwVzcrNnY1WVY2YmdjVlhRMjFCRkl6b0l0?=
 =?utf-8?B?MFFkT0xScUxGNVhvdVh0UDFkSzJ0bU42TDViUVJpRkJRS2VMazhXOTlRenN0?=
 =?utf-8?B?TW1ibDZ1RTBPRk1XeUZ4c1o1WUdlWFFJQVRrRE1MMlNVMGRidmVkcTEzcnBH?=
 =?utf-8?Q?UbK7F5PMCA8xzgQY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b6a74e-f428-42ce-5b82-08df22062dcf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 10:56:44.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBUr+cRGWekTwsfjTDhpTRcaVPCTT987A2T1C4nqf0lgw++KGl+gPOPBoa5ctB3y5UgyjAzsrx7A2X/2NsfElffHcZoQctIC5AYLOEC2oZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7987

Hi Hugo,

On 10/2/26 18:01, Hugo Villeneuve wrote:
> I meant only these two lines:
>     to_max310x_port(port)->one_char_duration_us =
> 	DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
Understood - but as of v6 even those cannot move below the call: the
helper can arm the after-send hold itself (the mid-transfer takeover
fix), and that hold is computed from the character time, so it must be
current before the call. I will extend the comment above the pair so
it says why both values are cached first.

> Its unfortunate that you trimmed some parts of the original email so
> we
> no longer see the relevant code...
>
> But maybe you should reword/improve your comments then?

Fair point on both counts. v6 will state the reason in the comment
itself: the tty layer's wait-until-sent is bounded by closing_wait,
which can be configured to none, and hangup reaches shutdown() with no
wait at all, so shutdown() cannot assume the FIFO is empty.

> So at 115200, this could mean 128 reads each ~90-100 us?
>
> Could using the interrupt to detect tx empty could improve
> efficiency and reduce load on I2C/SPI bus?

Yes, 128 reads is the worst case - but they are spread over the ~11 ms
the remaining data itself needs at that rate, only on the close/hangup
path, and the loop stops at the first empty read. I did consider the
interrupt: shutdown() is also the path that quiesces the port's
interrupt handling, so waiting on TXEMPTY there needs a completion
ordered against the teardown interlocks, and TXEMPTY fires when the
FIFO empties - one character before the transmitter is idle - so the
final one-character wait remains either way. The bounded poll keeps
the teardown path simple; the bus it loads belongs to a port being
closed.

Tapio
