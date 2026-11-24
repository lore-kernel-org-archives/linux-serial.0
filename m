Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795502897;
	b=oAqHHS2uuS36rAQ5pP/wp0DDze5fwISZNr77pB3pUUoK4IG0wVtJu0MIOhke+qr2opSl
	 qdOk06fLON0hhxOa6mwdrX3V6bPDK2vVBiD1hxlZGc/j/L6xsUIflFdPA/Ld2takVS21k
	 oCa90gmvXDHIB8ROxmSo0753XgT4Wkr8SuxRoEd2zJnjjmYHwEK2QI7bZdZ8M7y7Ti7MF
	 b5tUKsFRyXpITxiOTHyrNoAbcS+G63QwBMiRxB80BwqnprORTXT7Qtks8gNs2Z+0FPF2W
	 FjhaFlh7TuvzClSyimnax66VPKyH5hzhdgjvDtU0H/rsykeuG5QurnYnMl4L53f3kZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502897;
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
	bh=Nssj8QqbsOYnDHwWMRG+DIDvawrgRVJtmaVqL2SMfpw=;
	b=n8tOh9wvzmPUgkUmqRb3f+YR6qZxFCNmPXN41M8qkBc/TVhfHEV6KzOAzHSIcbiXkPRk
	 sL3ckLZWDoVIWXpXN05F+5UalcFrXZJ4IwtHLQ/CQ6wcY7KqQA1cVwjoUcHmG+do/TDLI
	 25W3D3VKIYx9M0MUzKls0GyF1zUmU8jv49BVqvbcm3Mf+I58vPTM/npG7vrPo4650bJtR
	 9YPOU3tqPshhnt08L+QhgPVFniEh0WppkopfF/Sh/cHjWkEojZp7/gO9IrbpIBToOIlvV
	 ZtCdyCCUS88vjGCnca0CXiHGBFJ7mMSJ9jdo9BB77qYRcJLOdF1WYP5pzq3B4vLOxSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=DchGC4Oy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.98
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021098.outbound.protection.outlook.com [52.101.70.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26B606A321;
	Tue, 24 Nov 2026 06:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E26B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=DchGC4Oy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCCWV0SDufaqI0kMm6qsQLbZ4FuaMb8wC3TqdIR9ndP94GQSTpnLIPxw1JhBnXcz6NlEtUDjzukmZeBkGuEPqpLdQCv5Mpl/cRr5/rNu0QS8h5twiopPe8lYZjs1AgSzucWHtER7k/rNEQXoXxqCmmca9b2OZU7qY2GOPVYtVyzh3QpH3Imr06Xp2wf7iLkXJX4poB0UDfY+ipYEgxpPecGzjE53ECP30ZTy16WSRH+Ojk5gsbYRMGngBi5z/KI83ti60u/nWa1KZFFfWr8Vhtg1RCtM0Y6vvF2rzEZPmjKA8cwQK2gDj5Cvx4OCMv57PsP5kGOC0dFNZ/R9e31IXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nssj8QqbsOYnDHwWMRG+DIDvawrgRVJtmaVqL2SMfpw=;
 b=aYEqHI+6ThN7hr4ks4pME8f7czbyZuNxo1q/b4bAyDwNrMCUwK7+WUgcL0yf33FgI6Pmuf3o4EpS14flqfBuWIvTwsjzCiqTC1PVURlRefvjJxPNUHyJIYjB5/DyyLmLa4REOYbLR/EVlipuiNajWOcVub/mPw693B9+gBB18x/YbwYOjJbZ35/3wX5tYsR1VhxOlNqoAT+5FpyTWlIuOOfqQTuI2EqFbAXDBGxvdlDQEpIJADcgjvApF3eJGnGxz277At/x3qDXYfDla5QiyLkx7MGKAWYM80TTS3F3OHEzlvWvltEvbL/7+RwrqQuRatyJmqobafq6shbWmTGwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nssj8QqbsOYnDHwWMRG+DIDvawrgRVJtmaVqL2SMfpw=;
 b=DchGC4Oy9opVpreM5vprIW1XnxhsRT75hH2FBH6/CWPEmY58C/3ZsEfONu+CgL2nDYgLkR3lOGXe6e/bGD4mL5qylSl/qvTTwXV+OYytoFqapcY3A2KzfJQyvaeteb2vj1q7YTGRA//1/V0nXQd0iYAyRiDiMnBAzUuT5vEUrXOTZUIwz/RzU7ywnWeELcioyIVQSpTZJJ0cnKGyM3+H3KgqqUA2p4AjcoeBO374TVYF51J9wjLSp6ScFfqxcDrF4erQWsq6wF/dAImE6LRUvEzVTBBxV3BviOGiNYQozqW8W5vNk9I9q412fRKeXlpOT9T/Lk6a6zYSOimu671NxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS8PR06MB7333.eurprd06.prod.outlook.com (2603:10a6:20b:256::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 06:48:09 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 06:48:09 +0000
Message-ID: <f00b7050-ac43-4c50-b702-575d37c26d7e@vaisala.com>
Date: Tue, 24 Nov 2026 08:48:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] dt-bindings: serial: Add the line transceiver enable
 GPIO
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
 <20261111-serial-transceiver-supply-v1-2-40bad0f912f2@vaisala.com>
 <20261123-transparent-coucal-of-persistence-8cfbdd@quoll>
 <9a659dc6-2ba0-4f97-86b4-ded8a48ac7e0@kernel.org>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <9a659dc6-2ba0-4f97-86b4-ded8a48ac7e0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF000467A1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::20f) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS8PR06MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 502d1c50-a2c7-4bab-3562-08df49f6e689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003|261102123227099003|261028144727099003|261009223027099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Bk/9dus3RAUY7uAQ1i0bqTa+G+pmR3VKklPIffC9gv4KGZEpArBva3L02jCYLIsBih42Avh7uW50oHnXpbvmqsPTwwlTnTta3p875aU8dWWXlRSJf2/1SxrsZLSW1OYTfxA7m2G12o16eYLYf7QW9fLt3gnnxxsc6s3FxPCEx/mUhjZsSniUxW1wVEYVjD+kDXf/mnaKYWfFo+23/SGbOa5IMyVNhVoiXo+9hdUQG4EqzWG1abjDDKzx0zQwKYeBEzb49WHEECtGWeDZWjMce6hg9JQrx0H/3IrIw2xqlpd9ZqHxTrFIWLpDupfUnWh3C2kHI9PBYviGK4JcIq/eMFh38Kss4kVAVEvzcCUBKgL5GGxXORNHcvw6PlTMg6hvlPMnwrBP/87g8byRn/OXUGOCZ1R1qM+pNtsaE9sR7NmiuVNOwS1YMTI1I6gHvkETCRR5M65NXoMomLQ2tiPGBVlwie2cqDcFaTS+YHIpPWUeLgwhN8X9n3cS+iQdX5Uxz08apWLDMKfJK9LoVYNx5qL98nzP7Mf5ivbjFMNXCVJNewntPl7V48meHc9InLazvLkWSKiHxpScroMELd5C3FPkOIgo4N6Bb++/tS68qLkODLxM8p/5rxqajpgSkIr6WnR1WWS06yNe5gRQpx4LaMqoh4RFwbrI1R30K++yRUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003)(261102123227099003)(261028144727099003)(261009223027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3pqZ0xpNCtWdjBsU0JFRk5GL0FYMFpvSkF4cThCbUhOT2pJeDE0K0RVbHNR?=
 =?utf-8?B?SE9DR29KUll0NGNLR0JPb3FGS1g5bUF5aFpKbERXQ0NKRVhPMnNKODJicmNw?=
 =?utf-8?B?cTEvbUg2Nm9sTXBTRlRKb0dLQ2pBRG9UdzZ5NHFUeUJqVkloVXJoaXViQWNW?=
 =?utf-8?B?RnFzc29UZ21TOERudkp6WGViSllCUmpRSCtsdktFejRRT3BDSk41OFV5RUtx?=
 =?utf-8?B?ajgreDNDT0hUYXpQY2NjOWdtYjFtajZzM0dHMkNJdHpUNkhOVVpFOGtQdU9P?=
 =?utf-8?B?T0oydlpJQ2ZSRThoR2g0cXJ2anZweHNDaklyK2VCejVWOW5pbWdUdlBaNVU0?=
 =?utf-8?B?L0hxeW5nRXljOTNSaG5HaEJwMUlMRkFrd3YwWjZ0d2NmTW1PYXdhVDl3a0Y1?=
 =?utf-8?B?S2xPUzBBVzZmcGFMVGJLMTJLQjRyOVBNN0Y0bFhSYW1iS3k3NGdoOHVJYjFK?=
 =?utf-8?B?MHNRdjAzdTRzT1FUYU1RZ2lRemxOeUc1Yi9nU2ZSYjhyRWdiVms2YVArY0Yw?=
 =?utf-8?B?THNUL05jY2ZkMzhEL3grRG9SRHBUVWx2RlFqcXAzaWJzK2o2d2pkcDB2VWZP?=
 =?utf-8?B?d2lmQWRhUGFYZ3FuQm5QWkxXOXphQXlta1FWSmlpMk5wM0xyNEYva3hGNHF0?=
 =?utf-8?B?OG9jS0VYb1R2bGRBYUJWRUJrQlpYNVQ1UDdSbHRZM1BNdDQ0YWtlOTJWTVp5?=
 =?utf-8?B?VG5penZ3SURwSkdVWVZMSHVvSGFXNUYzWnJSQXJ2Y3lBVXptRnU0ck52U0tw?=
 =?utf-8?B?N3VPNzdGc3llZDQwOUNwaVRzZ0pPSTRkV05GUGtyMExmK1g1OW5VaDdOUXB3?=
 =?utf-8?B?VUVRZ0l0TnYvV2pBVlhjQ2ZCYWFzcUkzbkRQR0xYZzRna3Z4MzZkMzJIaUgz?=
 =?utf-8?B?am8ra3JBSG4yZVpFT1B2QzhxZzNOK1phUG5DL1EycTRLbnVsNHg2NFhhQ2x2?=
 =?utf-8?B?dXpwaTRyZkZBbG1SaStwSnBRV1Z2ZE1mMDc5d1NwNngrZGlaOXRuaXJxbHNz?=
 =?utf-8?B?c2IrRUdzMVZJbWNXNk0rNzFvdUJkR3hmQ3U3bGl5NlZodmNPaytVczQ1cHhs?=
 =?utf-8?B?c1ZnNG9UTWVDSlFKeW90SVFRRzRvNHpYSlYvdmtaNFhQcGhtWGdLYkRWRXVh?=
 =?utf-8?B?WDk2UjgyNXhCWW0xbUFjaU9VNE5YYnRWMTdvU0RmL1ZZUko3ZjE2YTc1OUlt?=
 =?utf-8?B?NVdHTXFyeWVHbytKUjY1c0JxMmQ0YjBWdGZ5NXlwbW9LazJ2dkwzS21FakdW?=
 =?utf-8?B?dGo3ajdlcDdPZGFUQ0phb2pGQVlmYTJYYm1KZTFIOTU3WGVkamlYOC8zdjAr?=
 =?utf-8?B?am1sY0dCZEdBaXkwSkFOL1o4U1QwQVF0UHZEMitJL2FRZEYxRHR1c0xXOXYr?=
 =?utf-8?B?Qm4rZjdGOFJacVdOWGgxQkRaa052OW1DU2c1bW5KaHpuY3NXM1N2OVlYckpu?=
 =?utf-8?B?dnpnV0I0c1ZuemR4aXR3ZkhBb0FOOUx4bkpqQ09UM09EVFcvMVp2K3ZYNjZs?=
 =?utf-8?B?b0xEV3c0cVg4YmlwNHNNNCsralRsN2E2UXh0YmkzaHI0L1QwSGVpTUJrUng5?=
 =?utf-8?B?Uk5YaHlxTEMxWi84dUkvSXVWRDJ6dEx2ZU9OY3RjS3Iwbmt6L1J3K1M5bEhm?=
 =?utf-8?B?OVUycGZSOVp4MEJkR3Z1K3hKTzRJTHR3a3NnbG5sYmNVUDR3bVB0T1loMlNm?=
 =?utf-8?B?WVZOVmxObFZVd3ZCOG9veGxIYmRWeHdMR2NzQTV1dFJmanRrQ2srVTVyQWox?=
 =?utf-8?B?RzdDTW1DSjczaEQvNjNwUmJJQm9QMU9YSDJHY2xJYk5EbUg5aGZma3A3TDNT?=
 =?utf-8?B?dnlFa01VUmJYdURONmtrTTc3cDJsc1NzZDNQVy9aam40TWFKSUV0cGlSVmxn?=
 =?utf-8?B?d00zb291NlJmSUZPakdyOHNjQWU2QkltNTdRalNoWGhlb1A4VlpYZkUxVWdR?=
 =?utf-8?B?cjlPWHdFMENxbi9uOVNRTGc4dzBobTdsYnNaZ3diZVhyWmF3UFVGaStMTWx3?=
 =?utf-8?B?UFBadi9FZTdyaWdIVW92blRCVjlYNjAzWit2ZWxBajZxL0QvdDJRS1RvbWtR?=
 =?utf-8?B?MUg1VkVnV1BZUDE1WnJPM201UnEzVkhMWUFCcUc1ampCeHFyZ1J6OUducWk5?=
 =?utf-8?B?UkRSUUZpSnJ2K21COUZEZkhIU2JnU2lML1p1WU1sY2JxaDg1aXRoWm85MGZO?=
 =?utf-8?B?OHN3a0pwNllXMWl3Z0F0UmExWWxOYmI4dUZVdUt4ZVZaaGJTWWhZU1dNN2Vv?=
 =?utf-8?B?UkJqVE9LdVgwdzBaRWM4SHpXWmNsYzNpaXZKVFVBNUwrNERuUko3WnJ4cUkx?=
 =?utf-8?B?OWVMaml1UUVrM0I2d255OWY0c3hia0xxRlVmUVIvWjlmVGYrZDJsT2k2Wnd6?=
 =?utf-8?Q?UEVKxlG5fRnM7Q/4=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502d1c50-a2c7-4bab-3562-08df49f6e689
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:48:09.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hs7it64sa1JJNnWYgcPjkBg8i40H5sIqm7LBvsEOPQSVL3Uls8g4qIfZdmc7w7ZuiToA/MJSDVMOSgeNT4jHQvb8gMDLdMsVcIryA+iAfQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7333



On 11/23/26 10:08, Krzysztof Kozlowski wrote:
> On 23/11/2026 09:03, Krzysztof Kozlowski wrote:
>> On Wed, Nov 11, 2026 at 12:28:01PM +0000, Tapio Reijonen wrote:
>>> A UART's line transceiver (RS-232, RS-485, an isolated or a
>>> multiprotocol part) is a dumb device with no node of its own, yet on
>>> many boards it is the largest consumer behind the port and can be
>>> switched off, through a shutdown input of the part or a switch in its
>>> supply. Device trees have no way to say so, and the transceiver stays
>>> powered for as long as the system is up, whether or not the port is
>>> open.
>>
>> To me transceiver is part of the UART device node, so this should be
>> handled by device schema. Commit msg lacks actual hardware names
>> justifying the change.
> 
> Feel free to reference at least two devices/schematics etc showing they
> have separate transceiver pin for that...
Thanks for the review. Boards that are already in the tree:

- Toradex Iris carrier board (Colibri modules). The published V2.0
  schematics show two MAX3243 RS-232 transceivers; FORCEOFF# of the
  first (UART_A) is on module pin SODIMM 102 and FORCEOFF# of the
  second (UART_B and UART_C) on SODIMM 104, each with a pull-up.
  arch/arm/boot/dts/nxp/imx/imx6dl-colibri-iris.dts has the pin groups
  uart1_forceoff and uart23_forceoff and two hogs that hold the lines
  high. The comment there says that to turn the transceiver off the
  hog has to be deleted and the GPIO handled in userspace.
  vf-colibri-iris.dtsi, imx6ull-colibri-iris.dtsi and
  imx7-colibri-iris.dtsi do the same.

- Toradex Ixora carrier board (Apalis modules). In the published
  V1.2 schematics the transceiver for UART2 and UART3 is an
  SN65C3243 (a MAX3243 from V1.3 on), with FORCEOFF# on the signal
  UART2/3_RS232_FOFF#, module pin MXM3 180. That is the line
  imx6q-apalis-ixora-v1.2.dts hogs high, with the same kind of
  comment, and UART24-FORCEOFF in imx8-apalis-ixora-v1.2.dtsi.

- Sierra Wireless mangOH Green. In the DV4 schematic the RS-232
  transceiver of the console port (U700) has FORCEON and FORCEOFF on
  the signal RS232_Enable, which is output 15 of the SX1509 GPIO
  expander in qcom-mdm9615-wp8548-mangoh-green.dts. The vendor's
  developer guide lists it as "Enable/disable console port". The
  devicetree only names that output in a comment and leaves it
  unused, so the transceiver stays on through the board's pull-up.

In all of them the pin is a board signal next to the transceiver, and
today it can only be kept "on", with a hog or a pull-up. I can put
these into the commit message.

On the device schema: the transceiver sits behind an i.MX UART on the
i.MX Colibri and Apalis boards, behind an LPUART on the Vybrid Colibri
and behind a MAX14830 on my board. In each case it is a transceiver
with a shutdown input. That is why I put the property into
serial.yaml, next to where rs485.yaml already has rs485-term-gpios and
rs485-rx-during-tx-gpios for the same class of board signals. Would
the property be acceptable there with the hardware named in the commit
message, or do you want it in the bindings of the individual UARTs?

Best regards,
Tapio
