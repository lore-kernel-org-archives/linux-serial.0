Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795504078;
	b=Z4HXuhl10YaoaLM9FJdEPVm0s5k5DQ+dgKHeuG1cov6qo8tkCawK/kruHgnmXK5iDCaj
	 6gLPsiLAE9n+vJG9RHGiIk+H0lxl9FL3sjbCqPwQw6qWHgjWI6x7ZUFb2oenU/jkEej9a
	 /Pwq+UFRnxMtoW5L033837MSoIb3ntFxPp51nbUn4NALmDVvx4ck0mltHt99Kwk5yrUwD
	 9RxB2bUg4Ywuz619VBtS70vWexgUPOUCwufRAMQUL9CK7A779K8O1jBvWltPmGlsSh+Kv
	 ixt5HNmwpL2gcMoqBylSKwLqjfuy9jB+LGr0kxxmAl4Z5cqZDAeaFGFSzLVcFeZCSig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504078;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FcMu9NiQcNERfj42wG/r6tV+1kt7ar/AFm4H1wpJ1B0=;
	b=YjJ3G5y3nh6osrQSZQZQEriKcCHwqXL73mOPbxPWp3Yl0TG7Q5dcRPa06W/mYh26c0nd
	 3Y43Gx+phvKaaETaVGECoAwt7S3IQGuE4sqZSL8JP9jT0LN8KgzAu0qVM1pZm5nkWqjVh
	 olG2o6Od5q3ms8FL6K/v1XCrRlLcr31vBNaBUeL9lzojsLengJP1avZLPRvRhFV/j9cAo
	 0fv9lJ20upwsPqCP73ng2rKsuIXAGJdK7gUoCNyhKywrELlii2eGagV1Z7U6hkVcfJaSD
	 0vymp71ShSe7udtnBLCQL/R7uREYQIiBVnPoHIy8R/ZP8HvNorMiBYLwuXJm5uwzsBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=2uzyxAqu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.120
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023120.outbound.protection.outlook.com [40.107.159.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0A606A31E;
	Tue, 24 Nov 2026 07:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00D0A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=2uzyxAqu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qELZBZF210wwi+LQOw3Ekjc3PZ0SAuvunupxhV8XIVc7d7HdONG3zimMBqgb8nRkibVNUpJci2pOA7CoG/PDl1fjmFyS4dhZglp+PfeDSKueDB/HqBN7NGjv/acj5a9qxuHMhk4mFzQX7fN5OTGUcthcvNLj/6nbBxPun8EO2TwJFnugteJL4KoA1pqFlGW+xQGqQV8OHotE+ejHn6lZXmMZ0DMQMVyJDI+ydD8lIYCAGfgrm3xi5Rt4bcyJjKzh1KMmgwlaUUKY8U+z94UgIuurNwKNpJT67Z7mQpsqvijV4ojqIKhnErKYgUWoYaFAnr871TrX/5/YDzPbp+IjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcMu9NiQcNERfj42wG/r6tV+1kt7ar/AFm4H1wpJ1B0=;
 b=nQZ6eqRE73N370wCJczE9z+f8TxZcuYRzMftg08h7S7u9D38wp/bKgKWfAx7RpEgBjD7UYX82Cp2VIJa5XrHek3cdFKyqE2iWLKOc9W6TIeWAadIszBUxy9mPIPBMYk+aFlVgbaZQs4XrqkadUY5W98qeGvAfHyRFr3Zm7TxJ4PGl03C6uzrc574hnPUQDhPPSv/CKGJMopFEhF10oTmwoEErm018ur0TVT3Osw8f36CsFtFU0IPoqy1tqRaHYM0EvqNcEfGVf3dF3zasrDDhaHFrnV4np2hCXJHmYi9fH5EMv8G2R4mhkYAYNcNKi/Av8vMwfhVJs8XZdGXjpo+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcMu9NiQcNERfj42wG/r6tV+1kt7ar/AFm4H1wpJ1B0=;
 b=2uzyxAquUuxk6FavT2Mo9tj+dHAcGxBxG465p4lA1rpAVSASl6wY6C0lakvnkFP1yAIkRQdsFg4DrJvF6efZafi1v4SkjO1UwQkPel43um5gYP03QvoC3c1Qitby9tszwrM7wrkluk2nfDERzh84AJS6eK0oCPkuCdylxg5B0ZWLpQOKVBA2rB9klJAs9IEHUE+5mJFHVGsqk+DiKaIoXFxIYwlSynW7JnYbgeEm6YdMMZ2/XUtg6MSCLj1gQbV+96Ul3+hUv0o4OXFu8cAI+zkHVx9dcyfSxNOylGKWLRxvnY0AZnWiEWyzkx7nShXu98lI8lOstof+49SxfA8iiA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by PAXPR06MB7550.eurprd06.prod.outlook.com (2603:10a6:102:12e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 07:07:51 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 07:07:51 +0000
Message-ID: <158b633e-ae90-4113-a8ee-3976b1d1bf8e@vaisala.com>
Date: Tue, 24 Nov 2026 09:07:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] dt-bindings: serial: max310x: Add
 maxim,tristate-when-closed
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Markus Probst <markus.probst@posteo.de>,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-6-40bad0f912f2@vaisala.com>
 <20261123-tacky-hospitable-wasp-ff6ac6@quoll>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261123-tacky-hospitable-wasp-ff6ac6@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0075.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::24) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|PAXPR06MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: e324c70a-4b8d-4a0f-1d97-08df49f9a777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|3023799007|4143699003|56012099006|11063799006|5023799004|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261026121527099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jq5GbbFldoAH5vytkuwRPqnuZS9YAwehfkgnHY4NfQeTWyuJyJX0rtLq83nEeCCRjOcyGXbVmqjAcVQ1ecvfwLY11c3GIvvuB6lphVGbi8TcaFQMqlNXp+mJu3o2MGs7eYQnKt/rmYjVgv/kACjk7o/KRfxVN+8mndsm2/aukCLkS8W7efZlC8glGkr1dQT0nd9DeCS/27Nz2H9wQj4DQIjvpjJO+WmS6voH4HNy5subB17ChrRXkMiS07dpneNnO6C5tLvXUkE1I4Apk1R8zj17bRFYLAxkmaL5gqbCi9x0HiyCsJ+oUvTs6DxSfQWTi2sQaYoWpViSyQ2WXcjKqG5bTc9FmYtJXIYH59Q0Mspk8VIHl6EUQnBZWzUJsUkoYyUXhiwO33LA7WBwo3zAtZNh0eDd641VEyBRKeeWwQIyzSxXxQ96ZvjqsKhqQOqBP/Cbf5OmnkdjloikhGHu9LHVpQpNLhJKjNp0RznM7lbCfA6I6fczQdnWWz7Kxd8HK+xyxPCAa+Io55d3c8PvOfJ7x129hD+3VU47GyMMx9J2ZZPpJkiUYS4hbZWDdWAb4Vyb4DaifSxLKRab5BrMXLLShzIcXvDwRduzTGoarnpSgmXmLsHBWRMPhMZoImPx0swqzhvmc3zWrjnWD5/dswjLU3JgTAn2M236Vf4x+Mw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(11063799006)(5023799004)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXNKb1JCMWYwZVhQUmhpNHRPM0lGenFVZFRtM0tESkNsVnNzR1ZoR2h1cWVs?=
 =?utf-8?B?RzlHeWk1cUhINDQwK0ZxREM1elFSM2RJYnZQaS9abmJoTko3MkFCaXRRd3Uy?=
 =?utf-8?B?VnZqZGRMRFVtREhBUndZOXhYcEw2bXV0TDE0N3FvdmF1SGQrSStPUUo3ZWlt?=
 =?utf-8?B?cnJZZW0rKzNwUjVqWjI2Yzk4TTUzcmZ6aHA5WG1tMDUxZjJETkY0SElpRitq?=
 =?utf-8?B?ZkR1Q1dvMERFMi9kSUlxM3UwM29Uc2JZNk4vaUY5NDJhdnlMYzlsWGZ6SkFX?=
 =?utf-8?B?SGQzOTErekxlMzlxanVpdTNoMUs1QWlRRmZ2ZUtuRlJsalpSNW5SaG5qVTdN?=
 =?utf-8?B?WUxHZDRaOG1NcFI5eDdPUm1FUmdpcm45N2dUSzJLUXhXNHY3WFdmMGlIOWtn?=
 =?utf-8?B?cDNPa3hkeWJrcHFaR2REOWV3cDRuZ1ZFdlJackN3T2piTHlvY2dBdlExMm9Y?=
 =?utf-8?B?S1BUcElGcGF4VDNzS1lkNlJnUUhXQllram1lcEhmcDJLQTQ4N0ZxNjVSWVJH?=
 =?utf-8?B?RWVoQWVURHVJcXJ5WXJUTzZaQUpRUXdVVG01ODF6WUt6UGd0dk1oWTJFUys4?=
 =?utf-8?B?djc3aEdJR0R5NXpmalpIc0xNdHV6Y1BiY09qN2x4M1lnVXNOSVQrb1M5azFY?=
 =?utf-8?B?Uk9WUWdhbERWeENjTGdYUFUrV3JweitWbm5MT3lqUjEzaUkzUlNaQkR0Q1Av?=
 =?utf-8?B?VTRhMTc5aGtaSFpCVThmV3JZV1lzRE5BUW51Uy9MSzhPdDZEZ0dLZ0lMOG9M?=
 =?utf-8?B?TmUxNVhTVnJnaDAvRjFOUDRFWG9MdS9KVC9IRnhrR1dCS2pRTlRmZ0tFQ3ZL?=
 =?utf-8?B?QVVPY1lnL0NGTU45aTQ5QlhIc1llSGhrYXdqZkFIemJxV2tVYTJDVDVsLzhY?=
 =?utf-8?B?UExKaHZOVTNLKytMSTFZYXdWQ2JuQW81OExvWHNpQzZuNXFTd1NybmlLeThT?=
 =?utf-8?B?ZXhtUGIwQS9pWlJiQ1JRK1EzdTBKVHNMOVdnY0h0QVhPVVE0djZJb1dUWXJM?=
 =?utf-8?B?L3ZFRnB1a2g3dkFYblB0UG5vRVdNNmJpNHlHRk1kTWtNeVFiZkc5eno1eEt6?=
 =?utf-8?B?b2crZjZLZkZEQklWbUljdFU0akE5UU10S21QMjJ6NW5DMUQybm5WUUs2MEhp?=
 =?utf-8?B?cEJGdkNqV1Z2cGRJRDAxcTMrd3VwbzBqMEQrNUZQNFlaeEEyOWk3QWlWaEU0?=
 =?utf-8?B?bW00SmdXY2tjMnNGMjZMeTFMNTVUcDFZaEtsSGFSWTVHVnRLUlQ0ajhmK2Q1?=
 =?utf-8?B?WFI4ZWNxTjFyUWZIZ3pqcHp6LzNhYUVRMmlya1c3VVNUaW9od2NVVzBVVFhi?=
 =?utf-8?B?VTBwbFNXVGhCdUVyMVBJOWljeFZWRjlibS9LclJvOGNNRTdrY3VpajNST2Er?=
 =?utf-8?B?andXZGdHWllhc0h4eWMrMjRvdDY1KzhDU0pCMXRLZ3lWdWE0NVUwK3ZRS1B4?=
 =?utf-8?B?ZzRXeXpyOGFWOFJaNmQxei84amliNzQ1VWwvWVZ3R3IySG40N0FqUmpaMTh0?=
 =?utf-8?B?SVl1ZmFmYWltQnRJOXVDREhaWjcrRURKVFhjMUlwd2NRLzg0aExXc0puNjBP?=
 =?utf-8?B?ZHpCa3k5dHl5YVV2a2RnQU1aMTIzWmpOTFJjaExwUnc5MXdrb0x4ZlBNL2xT?=
 =?utf-8?B?cWs0RUd1eWU4SEkwTTREdTRiaTBLU2h5Sjg2K2tzeUxFelhCSDJhRkF4aWlJ?=
 =?utf-8?B?UDlNNUY4ZXhsOVU1cFJPSWgzZFZqdExRR1daQkZOTmJZUlhOeklhQ011YVZi?=
 =?utf-8?B?c3RMN1dCZjJxVXVXTVZsQm5WQkxqazVQQ0ZqQ3FFa0p4YXMyaTM2QmtSTHNs?=
 =?utf-8?B?U2lTME5wSWpSV20rcVRkVGh4VSs2Mm9LRVhTUlA3SFJ1ZzRBbEZsV1MzZ0dk?=
 =?utf-8?B?bFlVS0JhK1YvV0x1MEJNdkhaY0duUkZvczZqZGJ5LzVMUHlPZzhqVU5Na1h4?=
 =?utf-8?B?b3o2Mm41VC9TOVN4N3R1MksvSzUzaDI3Vk9yRDdGeTROTmh1WS9Fbldlcjl3?=
 =?utf-8?B?bk1nNjh3ZzBhQ0Y0cVgwaFJYTkUxVmJQUDB2OUVsVTNORW1wSXdsNjg0WXpK?=
 =?utf-8?B?UFdsWHYrTG9tTWlDZTZ5N1lsU21aRUVldld3S3ZDQ1oxcDQzMW9RaXRXTGlO?=
 =?utf-8?B?VjIrV0x3NkY4MzM5VGV6Tkl1L2pIZXZha2luLzhPN0R4TUtrVldMZDB0NzNJ?=
 =?utf-8?B?SG5VN3gyOXp5YlVoczd4YUQ2N0llbjJrNGk2R0U3Z212UjdUWXBVZnArdnJn?=
 =?utf-8?B?bGs5anVlUWVrK1U4UFRzMVVLcmtnWVk4Z0RlREs3bnFqcWRrVUxBaEhobVBh?=
 =?utf-8?B?VytYN0o0Q1ZRaUViTEVNWGw5WWtlVDBhTUozN0dpY0FlSDFERktMVlQwemYy?=
 =?utf-8?Q?wov2swOAvQC86DKE=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e324c70a-4b8d-4a0f-1d97-08df49f9a777
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:07:51.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVkvicH61P61u+9DZ16eXX00Rtt6KGCvscvNiCzRhi7q92Y5LT6y4bImgatqzXh69+u5DkFk67Won8xnKHuu5UgRGh7oP/7IYDr05+kkzj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7550

On 23/11/2026 09:05, Krzysztof Kozlowski wrote:
>> +  Three-state the channel's TX and RTS outputs whenever the port is
>> +  not open, from probe until the first open and after each close.
>
> Property name and description should reflect hardware characteristic,
> not what OS should do.

Understood. The hardware fact is that the channel's TX and RTS outputs
go to a part that can be unpowered, or to a line that another device
can drive, so the UART must not drive them while the channel is unused.

Would this be acceptable:

  maxim,outputs-high-impedance-when-unused:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      The TX and RTS outputs of this channel are connected to a part
      that can be unpowered, or to a line that another device can
      drive. The outputs have to be high impedance whenever the
      channel is not in use.

Best regards,
Tapio
