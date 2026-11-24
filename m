Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.114
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795503399;
	b=Tw42W51dn5R97rK8M3xoyEvdBHKpkorsi4cZ9dZfHrMQ2DHoklPSCNr7lOh+ZYLdZJjv
	 00ePF7xibS5jQoect+pPqi0MD4MQA9MX+vvRqCH4/adEQ/A6ipEptUzJ2chdnApwEHnx5
	 5H5NRIps+nzBL5HFLxgzjcd2gyXg5WJFyFKL37YplgS7rnxpiRgC3z0PTUH49Bgel2AKX
	 Ikz24lbhGoRHpuCN6ocOKv82r3GXqwT4UAdA/tAntUCo5xzfOMUKJS62pflOlRUQLb9mx
	 15tOCCzajfjXDx0VXACELgBAmTAafb5RGnpZnF9H/1t2O+twmYu5y1nWNVsvcWSn/tA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503399;
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
	bh=iHDheXX2YMXwiKW8fCxjVml5NwQseru++87KH/0ZxFM=;
	b=1K1RzZq6M0mUuATY8dI8Jy7PZOt+fPNSc5hNDTxv003jGS9bQLtXW4Fsd008Hu/SNxay
	 QrraKw8490jHaRsAlw7GOZaMvsFowJZ+ITSucPWRdO+5mBc5Fp2ZtBdVmLbtQUEZeCt3c
	 f9QBb8gRGSQ7a1fxA+fFiO3+XsKD+TkQYiMaOfVaJZ3BAoN2er6R6psTj4qXuOl5LMFbb
	 htEkJpOxKsxpVUxI0V6KTUPzCdm45n/+fpzxDYVAjI6yjWaSI6EA/7kXTDDwVJHUkEnDP
	 Z9A5avHhIQRX5Pfs7mehOXf5N+RUQa/RL3+TQkhviITQqzcTKpcp2AB+D6SFWhVXU/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=twtAQq52;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.114
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023114.outbound.protection.outlook.com [52.101.83.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A4606A31E;
	Tue, 24 Nov 2026 06:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F24A4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=twtAQq52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdDZ0gDPlZctLsALVztJQM1UMDsO6AOwH1VD5jmVlMpDab9int20kIqs/AYc6VlK5CFdZxpwuoIlc6d0uzAhhGQTe14kkpssX83xu6Vqc1n8Cs3WvwzfiK9h9Qq/gKqBj5ClxEtu3rEq2kEAjoQ3nchvo2bBbDMU+r36BMFBk1McmNautcfcydfP9I6TEoFbwuQ8Lc2pxYH9yqxB8zbBttUaknuz5yI4zJ4m3LWyGZDfCay78rIZgyA4FLN1XWF2mL3VR5yhCj4N6/DG29kKwh/pC+NkVS6AcTZN7IMkq3+lgEvuEQlU3fG59hadXxVxyo+Vy+7Xb382d1bfRqGHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHDheXX2YMXwiKW8fCxjVml5NwQseru++87KH/0ZxFM=;
 b=SRjttrvhgV3pXlq+z24ndwF0/ZIEoPzVp/YAltfecss3SRs1yq0tDk7iEAk2/IN1+1r29q9Nsok6MrqoORKSUsigNM9GaFLbSFDOnouvRV6/Amu3v/Lk1T4ZwA3fQzRE7Oeg79wUNK8/TueyIxXau4ByeASgq1WmloGWuh+5vMwJuJwhBhev+XJbd1xM46u8NSQv8uj0QnG0lv0lc9ppRqPNrwLaNrinSlF/AiG7avdZBhheQa1gN6/Xy557mPbZ3EEPHI0ejK+8kSqPn7+kX8dcKIc5Yo3ewHGF43DT6RPuCw6I9/fDH7H4p7GvsTlBEMPGOM9dcq4kAhSNQA6wGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHDheXX2YMXwiKW8fCxjVml5NwQseru++87KH/0ZxFM=;
 b=twtAQq52GAWLNxjATcKvhfwGQkcG2SPwcZmKfTm8+DjXe1GJ3qA6FUDvHkszSBly6QzYaD3rnpZC0+Ou+VT3hvdEVPJ20kYGQGCAFChjciDw00Qui8ttSxcRk90kGp6300hVet43sp+M+rLYg2gyXTPRsqrvsDL4qbNGJN8ZwmNdSrri+EpBYxm2G0oPZX0VNkoOTq+Og3hEzeNa4SgeewUu5HXGvLGNjmiS7FmV9EsDlCMp4SUIJOdFgWeh/hP2XFPw/pMBFn5iitga8BBOXG4jnJe3fNM5BpwaXX7miCivdju0awt98VDCoczPfq3E30XmG+LGbUceUme8drd4rg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS8PR06MB8085.eurprd06.prod.outlook.com (2603:10a6:20b:3cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 06:56:32 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 06:56:32 +0000
Message-ID: <c7bf36b9-494b-477e-9def-0a36c803b891@vaisala.com>
Date: Tue, 24 Nov 2026 08:56:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] dt-bindings: serial: sc16is7xx: Disallow transceiver
 GPIO on dual parts
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
 <20261111-serial-transceiver-supply-v1-3-40bad0f912f2@vaisala.com>
 <20261123-outrageous-narwhal-of-refinement-b1bf8d@quoll>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261123-outrageous-narwhal-of-refinement-b1bf8d@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0004679F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::20d) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS8PR06MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 5438481c-20c4-42ab-8b54-08df49f812dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|18002099003|22082099003|261009223027099003|3023799007|261026140227099003|261022105027099003|261022075727099003|261028144727099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	b4iy4JVLhuLwGM5qLQ6p/+Y6ZvIvSq1J3T8hjdVKAa2r63oXqroRtH5ovOxLyzTtgM74INRZ3Bn4sm7y1lt5oaAb5wSPXTw0m/AANIC0wYmBLMAwh4TcfOspuQ7ytQE69yv1HRlG/EOoTjQt3ULSEU5Yo6AVlFDAsUFGRIyfFJAgyo/XKb7ZERA2cYJUime3X0B2lG2lG+jHN8eP36ywT6WD/TIsczg8XsH6aBzRJdeN8excylMv+//uHpHBJihyJIOseBiBAZATws79oqvFrx1knxkg94ggQUl/v0WmgxlviNiJ9oAv5c6QZl/9LYNbdsLaz+IDKfEn7W5iUyqdcTwOUWyHRYZU/+TxH7eNFKcfyHlRorT5NnGLkEYIFJ1fjpUW5oSnXz7E0/JA2WU4w7DuMc2kROk9jQpOi+rd36sdkFIqzgLw9xOEeEY1vRO7C1H025Hpb6dDkcb1/8AfMlomTFv1pirnG67zSYLEcqUrp1Mvw5UbGrYZzuuAzyXYtMFHQcIxOm8N8tj0/q+uy5ndTXrxURKbzD3em9xeCcWYSMt3mpfOhujKtQYk53s7Ux1WrKCRLoRwGuiHYIDA0SsjGEFBTipDcsz4+5AfMJxuJxhjEfCaNtsXqgJeIOqCoXKaRmFBQ2A4lqTvY54W5AjCwi5bSwfNRLOYpRXUQ4Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(3023799007)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFZpUzBWMVhLZkl0RHBNSEh1bG4rem9xMTlITndLV1BKcldMT29Qdm92SU1o?=
 =?utf-8?B?VkxLejBoRy8vV2dUNm1pNkFyNEZkaWwwV21JMlBZeGc5amhNd3c0c0MrUWRk?=
 =?utf-8?B?aGt0dUJwNC9JZGUyeEpZeU01STBrcURWZXZZUmFRWmdyeHpvbGpVVXRueW11?=
 =?utf-8?B?d3d2UDBEWUVyQ0svNEVRYUNiNUFOUFBRSUhwYWVKeTFXSHpqTEVsTWxZMGJ0?=
 =?utf-8?B?MDNYN2dtSDBXZU84WDV4SEpzQXhFTzRWVWtuK0FHUEZqL05tdW9VNzh0SDBM?=
 =?utf-8?B?S3RqTlVOZVNRRXJ0L1U5SGdDTm40OTZJZ3RhMWo3MGU5TThLRjVmS1J5bnpI?=
 =?utf-8?B?d0Nuc2pwZFEwaHRNdExSaXRSQ0Y2ZTRqcFlwbkxIcXhGN0Y0eXV6RENnTXJp?=
 =?utf-8?B?ZUJhS2FpSytKV05BWkU1YjgyaW50L1ZEUjFKSmxwd0RRTll5VHU5SEhDMDJ4?=
 =?utf-8?B?WVAwcUU2ajRjby9Fb3JpZzJBMlpTV2hreldibG1UNzdCbzMrNUF6Vy9FSkJP?=
 =?utf-8?B?QXNDWC83YW5JMlkyNHFLbHJ5aGlka28xS1dOQWl1RHk5U1dLWWxtMWRVaTNa?=
 =?utf-8?B?OSs2ckp5THliK0ZyNDNkTnIrSitXRC9PdGdCS09HcGtrY3BCTVlLSnRsOTZ1?=
 =?utf-8?B?dmhOaFliR0NDN3UxeHZJN1huaGUveEkvdE5KRkNPOEk0VWNOQ2VNWTkyYXdh?=
 =?utf-8?B?OHk3Nm1abml0MEJrSGxMdzA1RUpDT0R0QjVURG91NTJyTkJhVlNCSXZOeVBp?=
 =?utf-8?B?VVFlZHdPSXM5Z2RKL1JKbzhnMDlwc3JXNVZYcmV1U2svNWhHMUd1QjV1bXpS?=
 =?utf-8?B?S2lNMU1YMnpzTnNkbnZkbXpWUVlKQkRYVXhsQ1RLTlduWFFDWEhWSWFyYVdI?=
 =?utf-8?B?VHdzU1Y0WFFsZ05ZbFpndWFIN3k3V0NGbVd0eFdyL2d2QXBORmRLZVptY0gr?=
 =?utf-8?B?RzlVTXg0emxDWm1SdXhjTHRDNzBkbHNmYm4xZi8xRkRSbGNQc1hEcFhSanhP?=
 =?utf-8?B?bzFKNjFlU3FObGQ4TTlsdGxvSVVaL3NqbmsxQ0s3WXl3TnhuT2pTRUpDNEFM?=
 =?utf-8?B?VnAwWUZFREpJODZhVE1KSVpjT3RMaWJkdVd6cWlSTjFiZW5vK1FFSDFOeUdq?=
 =?utf-8?B?Q1BtM3g3bnhaNzZQTytsQ1hyZ3NPZGwrcHQ5dXJVLzBGeUlub1lYOUpDUFRN?=
 =?utf-8?B?VzhBLy8rRm1aYXM3ckpienZuUFcwaCtyUzVOWk5HdmxqQW85RDNiS0Z4dkF0?=
 =?utf-8?B?M0gxYXZWZEs4YmFLTTFTbEthWno1cnZHTWdYbnlsY0J6OFZoV0dyZkFmdVNF?=
 =?utf-8?B?MGJtd3paYm56SExHbW5jelZ4cmVMZHNSdzR3dXNFRnFFdXdHbXlMK1BTb2pk?=
 =?utf-8?B?aXpWOXlXKzNLRVEwcS9TeWdoTjdQS3ZTMG9KNkxmVVlZT3hxZ3ZmZ0tjNTNv?=
 =?utf-8?B?YU1CT1lBd2grRmdoVWR5c3F3bnVHTFhWbUdLWE1CMUN0ZGpXK0M5STVrS00z?=
 =?utf-8?B?MndRN0tab0NxUSs0RnFIekZiZUpTUGFkQzViTWQ3V1lGTkJock53Qjhac2M1?=
 =?utf-8?B?bGNaV2Z4WmhsdHFCUXhON2x2YVAxWnJJRVZtSWQyUzZhVUJtOFRKeVg1dFI3?=
 =?utf-8?B?TjNibitIbE9IMHMyUjhVSy9GWDRhTlpIQllCQ3VLdng4QTdoajBxLzhlcm5U?=
 =?utf-8?B?S25hdGxuZjRuYVdBa0NNUDdkN0E0TUg4NVNmYktUb3VrRlNKMEw4YytUampH?=
 =?utf-8?B?UC9kWE9Fb29ONGF5YVdwSkpmNUJic3FoT2hTVWFwU3FqeE1nY1hwY2JlMjRo?=
 =?utf-8?B?SFo3aEN5TlExK3QzazFZWGgzb2dJQlB2OFdxVDJ6KzIxbnZiczNjSlQzZ1Jz?=
 =?utf-8?B?NEJiZExsMVJaZkIwc25PVm80ZmwzUTBwejlYR0xzRys5WjA5VWxXVDBobFVx?=
 =?utf-8?B?M3FhbXdiSk1nK2MvMnRLWDIza1U5Nk9VdE5jWkJjWXRVMXpwQ2tHeGFOV2NO?=
 =?utf-8?B?U2VsMjg1U0dIczNWKzNkamlOMk9qT0pWZTZwVkgxUHROd0JaRk9lekNTbGFl?=
 =?utf-8?B?NHpnUHpDSmNvZFFSVFY4dVRVWjkrNHpmS01YeE5HYUJmMkhlb2hpMUZERUU2?=
 =?utf-8?B?ekJLUTNYaXA5UjdublBidit4ZUxWdUdMVG9LbFZkajBQNjJkVU5tMFd6WURu?=
 =?utf-8?B?czJmVnduMUhRSHZvWWROemZpMTNjTGZ5ekNLbWZLOXN4bjJWc1Q1Nk91TDM1?=
 =?utf-8?B?WXB2MmQyai9LeG9vLzZFSHlvOTFHaXE0elNuL00rVmJ3c2tNcEwwais4dW1T?=
 =?utf-8?B?Z3BLNGE1cm9oVm04YW9lcFV0RSthNllPcnlTVFphcDcyRDhhNzhDNWYwZlVN?=
 =?utf-8?Q?me9MDq/CfmMbVvUc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5438481c-20c4-42ab-8b54-08df49f812dd
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:56:32.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mh7EcB5VBKqdDCYe021K02J7+4f/K5P9VZGmXqMEu0jGBj724d4RMYS7UIomQHSjaAr4By8V0LTe5lOa3NTqvTrwg34b0FZ84L3WXyvaVxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8085

On 11/23/26 10:00, Krzysztof Kozlowski wrote:
> On Wed, Nov 11, 2026 at 12:28:02PM +0000, Tapio Reijonen wrote:
>> The SC16IS752 and SC16IS762 describe both of their channels in the one
>> node that references serial.yaml, so transceiver-enable-gpios validates
>> on it, while the GPIO belongs to one port: the driver gives both ports
>> the same device, serial core requests the line once per port, and the
>> second request fails with -EBUSY, which fails the probe of the whole
> 
> Which line? If you mean GPIO, then use consistent naming to make it easy
> to understand and then that's Linux GPIO limitation which is being
> fixed, thus no need for bindings change.

Yes, the GPIO; "line" was a poor choice of word next to a serial line.

The second request is one reason. The other is in the binding itself:
the dual parts describe both channels in one node, so a single
transceiver-enable-gpios there cannot say which channel's transceiver
it switches. If that is not a reason for a schema restriction either,
I drop this patch in v2.

Best regards,
Tapio
