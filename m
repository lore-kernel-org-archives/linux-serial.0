Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023094.outbound.protection.outlook.com [52.101.127.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D91A9FA4;
	Fri,  5 Dec 2025 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764912413; cv=fail; b=TYV9Jye5XlZiL8+ZD/EfEgHOqG5WB1wgWYnEwMOYqdmqEumVejkBpPppZzJBiHIvS0D2NFaALlTsB3867r5zDRveOFk5uHZqg3KlQ7Z7v66tffrrXqQnyM0xJU49do0EfJTw9MATpz8JN4sH/ib+nYeqPxdjdrE5pEcddzWNYDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764912413; c=relaxed/simple;
	bh=yTs9lDEvqjxD8tT+PDfAErH0IarJmviZNEOqdvZpSYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ejBowUT9/HesPjUQ3KCILiA13H099hmjSwg/bEUg1j+kuUknwNYQBSqe3oNORjMm9kmijJ02BaYf3FyOOHaEhqY9m7x5a2wGvGwAwQU4FBp5tQM4lc6v9dRvpVrGSPT6l3lnevireNcAgkQKbzJJc0cfJ/OH+PgX8TAcVtepNaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=aLbHybot; arc=fail smtp.client-ip=52.101.127.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="aLbHybot"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsVTAZb1l8yOl8DeR9TMwV6vI8OSOrEGoK7btQc62eiSIIFCeK79g1DOHYy5zZfifCZ8ggleabaOWYlTR0Q6K5YvdjTPhpPNjeQ7gvMZKvdrPSkx2kbw5L8N2pqTwHMlu3/O3ZQVcYNHqXIa94fJV8RFg93mmA0pZ0IOCwfvByUg5FqXYva4fPN3JOfbxmbCMXLRw9DCM3uBb0vHbyUXfw2J40uyW8EZI3GeEFklRdVTXzz+L6punsrWxcQ+AnYh2aPX2+VenKftLdpqzNKSHPA7IF2Pvj8K/H2dI9zK2n0hZJodr+rMFtSjSzsloD2CRxQmdf+rfrvRMcM79VHZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeMXwDGtPdYH9O94CRUYlTW3kfTIIyk10ICU3lEeA1c=;
 b=AW/x67KKy8Ql6pmX7KBJbmhM8WmKc54qCkD/lmFD9NenMUEJWiILXym80yPDaBGTX4QQum+JBqxt7UmeZ+5OhuJ9TpSkj3XSgFECB2cWNKS+U3+UV4vjMxqLw9ET5NWELIIPWcGHuwdUNwaYNFauKUxQebznIOSoA8mdPglbpV1y03z7DM1Qb5mdNRypFmSYc7o6VqxhwP4IoiO+rGIOJpoFESWHUs7ljjL/YNBjz5uSiytQ2izDmnCrZxONUjAA861LeA6VXMrszadHwuxrMvTLj1VTjwmsP8uK4squZTmRu/CjxhQloPokt4DRfF2rWbf99c5KXE04YT7WhTcgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeMXwDGtPdYH9O94CRUYlTW3kfTIIyk10ICU3lEeA1c=;
 b=aLbHybotxs9oqj8fwL8t79BokX4jxEAsZUQ64Okt/Gs177y8ZwfSxUPdc0qOmzRkLlX3PZH1nAWG5h6HJ13yXLFsZqJ0kgaRpZI93cw61zd/O0775rmp2dtyqAz4oBrQ2VUS+bfFEIL/7fOjJ9EFtGqmH05Pi52ywKm++89jsWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY1PPFFBB9DDCCB.apcprd01.prod.exchangelabs.com
 (2603:1096:408::362) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 05:26:45 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Fri, 5 Dec 2025
 05:26:45 +0000
Date: Fri, 5 Dec 2025 13:26:42 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 31/31] serial: 8250_mxpcie: add RS485-2W auto-adjust
 sysfs control
Message-ID: <aTJtEmUycXeGrYPJ@moxa-ThinkCentre-M90t>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
 <20251130104222.63077-32-crescentcy.hsieh@moxa.com>
 <CAHp75Vd4Fr9j3XF3Mxte8NDw_cE+_cyhWh=xs6YMQDTrmn=XnQ@mail.gmail.com>
 <aS-mugqHvS-OJvtU@moxa-ThinkCentre-M90t>
 <CAHp75Vfqi3Cqm+vMC=VXWCsVDP1926gpU+xxocHnVgZ6Y2fyEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vfqi3Cqm+vMC=VXWCsVDP1926gpU+xxocHnVgZ6Y2fyEw@mail.gmail.com>
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY1PPFFBB9DDCCB:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b8c839-01dc-4bb0-aedc-08de33bee165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M245eXFSR2hNaWFCdi92Y1RwbmR3V2pSbTE0RXVPc25iUUhHZDR2Z1NpeitU?=
 =?utf-8?B?ZTVCaDN5N3ZUMTR3WU9yTk1JUmFzampvYXhST3ErWFIrRTRiTWRWSXJ2aExF?=
 =?utf-8?B?U1FPRDNib29wbW9XRVNydFIrK2V3dW5aajFibGVUSG9oZ1hZV3hsTEJ4bnIy?=
 =?utf-8?B?NFhOYmg4RGRza0RoM3F2RzdjMThQT2FjOENXRHJra3Y5ckh5TGQzQlorUU5j?=
 =?utf-8?B?MGpJcVZxY3puTG13bC9QMmhkUC9qbVFrQy85WWE4L0VlR1grVG9sRFRxYXJG?=
 =?utf-8?B?cXFJZlA5TDJKWVdIMmcvanRXNkd3dklCTnBZR3ZBU3BqMVZMeElMLzJuM3FQ?=
 =?utf-8?B?cU02SHdtcWhuelB3SFlkRi8xcVBpMmFObGN0RElMeC9DMVF5c1NhUWl0M3cv?=
 =?utf-8?B?UEhNSlFPK295cFRmY2R2ZFVkamtqR0NSdWVMelBYSW5uSWhZdlBBYzhHdDJ6?=
 =?utf-8?B?UFRtcWR5OWRaOHlVNmc4QkNCV0c4VzRCbGZQbE1MZXI4dTBxR1RLM0NoOER3?=
 =?utf-8?B?WWZsdnh0bW1MOW5zRDBKT3lxS3J6eXNBUUU1OHNVMGNtZzdrSzhCREdPWW93?=
 =?utf-8?B?dlhJUmVBRTF1WWVwdEMwbURBKzFVUGcwaDlXSGQyL2FoWnh3RXdFR2E1TWRl?=
 =?utf-8?B?WHY0ZEhpMER5Y1FYQUhyQzVCanA0dWVEYXRCK0lzOUZnMFRUcHk0NXVja3VT?=
 =?utf-8?B?eGtsYlRiMXp6cjFqY3ZwWURqdjJNTk5tY3dZcGRBdzhIM0Z3Tmw4aG1XQkZY?=
 =?utf-8?B?cllEWWpWZ2QybGUvUGd3M0ZmdFA1cHJyc3J5NG9RZG01SDkyaUNBTHlqUEM5?=
 =?utf-8?B?WTVWVzd4MXFIZ3FJRUgzMy9sRWdHSkNQSWNQOW1MZkhjc1dTWU81YkdOcTIr?=
 =?utf-8?B?NXNWbU5YT2JHdFdhZXBFdWNHRUh2cHR5K2EzNExqWGVNR2orbThxa0lPUVRk?=
 =?utf-8?B?ZlIwTGNMZFo2MUp1eHdZclEzRVV2OFUzT3JrekJVYnJUY1YvMnpMNkhmTWl3?=
 =?utf-8?B?dG1Mckc5enNJS2Fzdko4TVBzekw3OTNDYzJjSE5MTzl4ZEszRkJJb0hpTDVz?=
 =?utf-8?B?WWNZL0lSZWpJS1hjVjZjSXVpb21TR0lmL3BWK012Z2Y3a3RxWENWK0MvQ2hM?=
 =?utf-8?B?QjJLK2hOWGorRlpWQ1FDci9VWEhhL3h0cUVBckN5UHF5RnBYS2E5Y0V5MnVN?=
 =?utf-8?B?WWJuK2M0aDlmMGpvN3R4QXJKZFZmYXZoaHhQckxsNUpFSlJTa280ekVQQmYy?=
 =?utf-8?B?Ly9CcGtaOFZzcGcwRGFPZ3BjR0VIOXljZlRRSlBKbnI2U0dwOGI5ekhOV1ds?=
 =?utf-8?B?NnFyN2psYjRxeTV2clZ2RStQTlJMT1hrNktEYXlMbHZFWDhlbVVjeHpGcGYw?=
 =?utf-8?B?QWcrSExsT2ZCN0sxLzhGb2l2eTQ4QWdKUmFTT2VDNXgxRlB3U3V3cytsTy8r?=
 =?utf-8?B?U2JnYS9RL09kVTdkelRqMExYeE95YWk1dFBwSW1lWmQvdU4vWVpaWlozSjZL?=
 =?utf-8?B?SDZQc1RFL096UE5UeHcxdUp2M2pqdXZ2bGYyYWR2eDV4Ri9DN0xEbGR1K3Ax?=
 =?utf-8?B?TUhOOVNucERNZFl2NHBwZ1d0Y25nUnFKOCtHcVN1TER2UTRVRHRGR3RhRWlq?=
 =?utf-8?B?cnJRNFFoVGUwQW12NlcxWEVzOEZNWE9vYkJ1b0NPU2xSdk5FNGpjL0tidFhp?=
 =?utf-8?B?elc2Ylp3elVLbWFWRi9BRDdtQ2tGenBUR2VTUWEvTkk2eEtCUzZUNmpzMEUx?=
 =?utf-8?B?ZG1iWEhJZXJqMVdCOHAxbEhaR21Vc1RjTXBGZ2NHaitBK29sd0llQlhBNitM?=
 =?utf-8?B?WnZ3Vzh6TkJRQ2M2TFlLY2pXcVI0WFg5UmVybUVuOUhYM2Q2NEFSQkZPalZJ?=
 =?utf-8?B?cXgvVVU3RjlsT0s2WERpRksxeTliZHg4UTYxWk43Y005RDJxZGRRbjI3QXAv?=
 =?utf-8?B?Ty9YTU9GNHpDam1QYzFBVmpYVWtJOUVsTGVmYUFmbGQwdU01Zjk5eFN0SXlW?=
 =?utf-8?B?Y0lJMUZwYzhRVVFiaVdLbWNmUHRIbTVpTUZ5dm1GKzdTUzRVbFNjWDhOQzJV?=
 =?utf-8?Q?in3XQi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THpsdlNFZUc0cXd4SldwUlBGYXNQbG9oVjNmVU5qdlJNSk15WEczclVMb2pV?=
 =?utf-8?B?UXk3YUdzTUZsVGJZeDhyK0YvOWJXaHVEZHgxK0hRZkVuMzZOSHNLd3d4Wkd1?=
 =?utf-8?B?SUFuWUFEckdsc3RpZ1ZaVnkwblM2N1d2Y0FFaWZnVFlXdy96cHZWOHVqOEVG?=
 =?utf-8?B?NVlqTXdaQUlPd3ZYRS9INXRuV3RoYkpieHFHTXBkd01seXluU2h0ZHNSSVpx?=
 =?utf-8?B?d1BrUjRKL25vVmZPMDc1QWlLZ09HSk5qSnFUK3Njbkhlckp3aGJRbEw1d2hl?=
 =?utf-8?B?RDNyRTFaUFdkWFlWcE9lSS9KUEkrWjZOd2FCOXhlMjYxZG9hRWhTa0lXSUZB?=
 =?utf-8?B?SEJsVVJ5YmtHTjJ2S2tHMXpnTkhFWlpqQXNPY2ZqQW9iNmRWcUhWT1dQVTVy?=
 =?utf-8?B?RGFUMjJFL1RsWXZXQlU0VkN3ditNVVlDVWcwejBKeXBZYms4amIzN3ZSRVdP?=
 =?utf-8?B?Q1dlMi9LOUovZGpENXpSOEhxSnhpUk45MlF1eW5HQWRlS2JSVWhWM2hKOHZJ?=
 =?utf-8?B?eWMrU0E0a2JPeElpT3BqemlvQlhydGpEcnA3UnhJZUhSUjJRcFZnbUNBcXow?=
 =?utf-8?B?d3ZTbjIyRGEvZW1CbkZoMW1WVnJKb2loNDdEd0l6b3Q1WUh5dzlwazlrN3hm?=
 =?utf-8?B?b1pRS204dktFM0JzYUF0MTFHN3ladGRMQzdvdFpwU3loRFR5dGwySno2eWZO?=
 =?utf-8?B?UkUyendYTEIzdEhvaHRHY0x4ZVVMa1c1SENxYnYvV0hPUHg5UHRZZ2FGZUV6?=
 =?utf-8?B?Uk9Hc2pLRWlLeEx5aUdBK3plOUZOZG1yWi9FeDBiYXl4OEQ2Snh4SGEyZ3RH?=
 =?utf-8?B?bE5VdEl4WmpsZTZRdzc4QXk1OUovWEVMQ1oxWi8rNXVhV2E3NWljN1ptVm1Z?=
 =?utf-8?B?ZTNLM3RLVGxEY1Z0N1U0MFBLZWFIeXZBVWV1M1owc0tNclhsU3l4M3dEcVg3?=
 =?utf-8?B?bVF5ZFoyeDJRV0h4OXd3ZFNtSEZSRjk4NlRjaGpOUjFrSnh6T3hEcFZhdGFW?=
 =?utf-8?B?K0RhdTVJSTlVemlIV2pMU1owTDY5Zy9hUmQ1d29qZmpWb0VmaXNWdlEyZHor?=
 =?utf-8?B?OHB0aGlCeDd1VFF0Ym9mR0xnZ21pWE5lSzNBWHpqdm5CUFZ2K0VyT0traEFW?=
 =?utf-8?B?OGNyQ01GNzRJWXNwVzRZSzhzb2g0b0UzQmkwNkVOaTh1ZStXVVplaGVoTUp0?=
 =?utf-8?B?TFM4T2RIcWh3ZGR2TUNBc3Y3dllmeG1pUUxTcUMvakpzUVNFMzhqRmVTSlVO?=
 =?utf-8?B?WlMyZCsxTUMxZ1R5QytENFdub1BhdysyVzdES3VrdGxYR0JIQWVxZlRFc3NE?=
 =?utf-8?B?Vi9iKzZJL2c5RC9NZi9QVXkzaHdiaVFnNEJYdzBYNmJOYjI2VzRGOUhOTXVu?=
 =?utf-8?B?M3Jod1FuZTVOM2tyV3hDR0VjTFptNFAxT1EzaTUvZ2Mrek9qNllDZDVFTlQ0?=
 =?utf-8?B?bTcvUW1TdWs0SnlNa3Jab2oxdDA0YVo5clJiWCt2S0ZKYm9GQVh0YXJvQ2V1?=
 =?utf-8?B?U3dYYW9rcXNnOUhXc1NYa3cwTjVmK3E5TkNqSy9YS0oxYkFaSUpPZERaSS9P?=
 =?utf-8?B?TExpcGIxWWpGR1JXZnFMVXRBbnhNSEZKdG5IRXAzVmxYTjN2M1NHcGV2RXJo?=
 =?utf-8?B?dDE3SEJmTzNCVG5wRFJqNEp4NDdyenZPTzBJaHJEeE84WFJDT3dTK3JHVm1F?=
 =?utf-8?B?dmNlcFVmWEJZUzBDN2ljUmhkMmp3YXY2SzFONGJRS3Q0ZHZVaVBoZmFXVDhO?=
 =?utf-8?B?UWkxU05yTTZzc2hBbmtIeEl0MEozQ0lZZ2xxTGZNeS9QZWdDWmRTK1V6elA5?=
 =?utf-8?B?UGlGOVNoUDk5eDZsUlF5RCszZWxkcWxXbEhabHlsS3lqck9OTzJtYUg1a2tq?=
 =?utf-8?B?OHZ3eDdWTXZCY0JWd3UrUzRIZ2ZoRlJQQkVPazZzTkhib0gxZVgxOVE5dnVU?=
 =?utf-8?B?elE1czd5Zjl4c2hTT0ZRQzNMRE5zWkpEcjcrVyt3L2FkTCtHNDUzaFdnOGV3?=
 =?utf-8?B?YnFwc3BKMHVUWVdIQzJGWG1wSmZEc01uRU5WY0h6RGFuOHVkdWY1QURKOTMr?=
 =?utf-8?B?UVk3bkVmR3JMZ3Q1Ri9BTEZ0Qy9SZnpwU3J0MVM1RSswYnY3YVVxUnBlQjZt?=
 =?utf-8?B?aVhYRXlLVGZJQ0RjZUhHSFAyd254dVhSQ0FTNGhCa3hPVnExV1Yzcmc5UEFL?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b8c839-01dc-4bb0-aedc-08de33bee165
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 05:26:45.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qab+UyTHXbG1/Ts6Ct05SX+Xn7u5lVLmq54T8MEVrFC7EYTmC0cLOLqjVqIHJXfG/Z1hBMvbzaj4s3F4otIOoZ07j5YAk260d4Es4lBb2dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFBB9DDCCB

On Wed, Dec 03, 2025 at 11:24:58AM +0200, Andy Shevchenko wrote:
> On Wed, Dec 3, 2025 at 4:56 AM Crescent Hsieh <crescentcy.hsieh@moxa.com> wrote:
> > On Mon, Dec 01, 2025 at 04:45:58AM +0200, Andy Shevchenko wrote:
> > > On Sun, Nov 30, 2025 at 12:46 PM Crescent Hsieh
> > > <crescentcy.hsieh@moxa.com> wrote:
> 
> ...
> 
> > > I'm not going to review this, the patch series is already quite big. I
> > > suggest you to start from the small things in a different series E.g.,
> > > the first series is just converting MOXA from custom to 8250-based
> > > (assuming all features are kept working while ABI is being broken,
> 
> In case you are wondering what I was talking about in the above, I
> meant move from /dev/ttyMIxx to /dev/ttySxx. This will break all the
> current kernel command lines and hence setups with the explicit
> mention of the /dev/ttyMIxx, such as console=.  There might be other
> breakages, but I leave it up to you to research and come up with a
> solution.

Just to clarify my intention: the in-tree UPCI serial driver (mxser) has
been unmaintained for years, and my goal is to replace it with a clean
8250-based implementation that preserves reasonable user expectations
while following the upstream serial framework. This will require some
analysis to reconcile the legacy behavior with what upstream expects.

I’d also like to ask about patch ordering. Since the PCIe serial driver
is much simpler to migrate and has minimal user impact, would it be
acceptable to upstream the PCIe conversion first, before the more
complex UPCI transition? I’m happy to follow whichever order makes
review easiest for you.

---
Sincerely,
Crescent Hsieh
