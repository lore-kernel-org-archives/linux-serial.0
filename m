Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022095.outbound.protection.outlook.com [52.101.66.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8611E3772;
	Mon, 20 Jan 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388006; cv=fail; b=AWnLTIZasOXGMkNcYz0DlvuPzp79EKilMz0slRdONclKXYg+8WDcTtp4UCug5mu0MkpDna0m5Nbo63J6haHs+5U1grS96khxqpGLekl3OxSPYXTWMtACjSzE+M5pt9JkOE1F9FntmM1unqe7W5Btf8/YNZJGyREEN9X8qSBHyWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388006; c=relaxed/simple;
	bh=8iesvMu4kTvNmDAYKLcWL32himFZBpZWkXBv6CYEWs8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CfwlYwqpvWPvmt9+N4FFYVloTzK8pPqD+UXdS8MOW0SwBRBCtwf6pWsNSbKoAqLNyXydrlpzFmWjHeRcykurK1VZepGgvrERye+3q1eCADzpEIdJvTWO4SlRpMSJj+S62uIugghb3o3GiwlZBkwKCwg7sB3pk3XEJAo4kqa8At0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=MMaypbmw; arc=fail smtp.client-ip=52.101.66.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="MMaypbmw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrjkTGMHKdYxtk14J0Utdl/xXkHz9ZxTcn2FtOSGaZEmt/NFPC43u94gc9ldpOr7r6tXnJj1YghwOLP1HImSbH1U7GgRDtZUAOTV7uXYWCsmQGyCWJ/pX+Yx25bnIZwiF2ZkiElM3G8YN9MRJ3lPLw4H2ac/FB+axxXQJC8HLAgKBis/uupC5KY5nBsUq7g8LgJF1G9JPmL7O3bdRe22I1zHaxe/+CaF1Ss2iUR5Rquz9LERf3c5yv1BU0em6XNHl5O6JEsqlQxqvgndLvo4jS7lw56UHGQcGJnt2LlZ/hV3dq6A6BVhm0tETi+TY6jr0IRVoHkbZXkEiBvtkfWGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt69qVZqDTRVvL2GCuN/P+n9m2ZQPj7NCqUmHhuA078=;
 b=PdlUH0dBSNvN865+bcn/MRp6RdIXhGHyk+MDmIDLWSg28G34dXrcdQrsSC82j8p2hb1KeCsIMfmUICjwNQc4lukPcCy8LJ4lYZmogrXyzSe5ZK7+gEOjeXms7Sq4Cm28+Au+/ZCp+/EWOCwvYHvEJ0iTGcChYxmUviMgYI4VF6jy3QotbNiVZ8U9Kpl6561mguJAf5o64t/BtTlYWV+81AKC4SxLb/Jm2jyH+GzRhM4+PLfaSSZDucW0xpV7rssTqrFVAE/xtUKihdoJDAK1h8/SJwQoQIbs13qHuXPG8+G1fFcyx7G5Sw1246s2bo5eaORgBslduFd87z6HRxDLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt69qVZqDTRVvL2GCuN/P+n9m2ZQPj7NCqUmHhuA078=;
 b=MMaypbmw2/a9rNuvqMzdc7/f2IA34y0Je81o00Ickx7/TPiu+hDJtTU0OkATYMG0JPlhyWQp4P+2tpGri4AwHYbTSknS3Fr8KAAMgWTbyJFPCuhkt3GhmgolevoqoVsIo5/C0xz1PAcbPaNDtX3wCh/yjPoEKwOluxjQHc/sAR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by DB8PR08MB5435.eurprd08.prod.outlook.com (2603:10a6:10:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 15:46:38 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 15:46:38 +0000
Message-ID: <5d1d83b8-e3b6-4719-862f-3606d1783e73@genexis.eu>
Date: Mon, 20 Jan 2025 16:46:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 ansuelsmth@gmail.com, lorenzo@kernel.org, krzk+dt@kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20250119130105.2833517-1-benjamin.larsson@genexis.eu>
 <20250119130105.2833517-2-benjamin.larsson@genexis.eu>
 <20250120-flashy-nice-tody-afa2ae@krzk-bin>
 <ba4b0ad4-e8ad-4420-be10-520efeba0c84@genexis.eu>
 <b3dd5f39-357e-4714-80af-f5c6b5e8ba68@kernel.org>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <b3dd5f39-357e-4714-80af-f5c6b5e8ba68@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00006623.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3c9) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|DB8PR08MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: aac748f0-d3e9-4454-58ad-08dd3969a023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGVJdHREMVM1VkM2WEFLUy9ZOXFGUlpITHEya0VTeGV4Sk4yYlEyYzQ1S0NS?=
 =?utf-8?B?eDhaSWZTTFJXZmlNZEp2MUdxWFlQZVo1ZlJSZFI5bmFsMjJqTk5FbzBBN3I1?=
 =?utf-8?B?dkhrS0g1RDRrUWRMQkFjdUx3ZnVMZFFiQm9OaTNUR0VScUlUVU5BS3QxcldI?=
 =?utf-8?B?N3J1Z0V4cU1jVUhaYkpMTEdzUHdUU0lQRmovSnFteWo4L1B2NXA1T0owY0pR?=
 =?utf-8?B?TlJRSVFraEFIQ3ZLWTY5aWliYS9VREFIbjc1ZlFwOENGQzU1Snc1RnhTYlRL?=
 =?utf-8?B?aWpwTGM2UDZRbHJ0aElSUmxFUVJQR3ROQnJGdkRSSHZ2bXN3RERheURzbTB5?=
 =?utf-8?B?Q1YzZmRoL24yRTVuWEN4REdrUURwVXRzMHU1MEl4RW9jRTZvYXRCVkx3U2tE?=
 =?utf-8?B?cnk3QVhwOHUvUFdqQWFJSWNaTzBYRUIrRU1sb01zMS83T2FCSFdIcVdXV0FF?=
 =?utf-8?B?NUhWL3dpbDdtTWhTdGprYmtMN1FRNURtU3hVTzhFQnVsNFFjRXN4c1U5SGJV?=
 =?utf-8?B?WDRQUHZObFpsekNDQm9zakc4akNOMG1LVGh5dTBYVlcyOUlGTDJFTHZxUTdS?=
 =?utf-8?B?T2p6Q0VyczVTdHBwTXdFaEdUalFvN2paUFFMMWtRMENCTEhidm52VzMzRC9H?=
 =?utf-8?B?NVluVE56SjFjOHFXbjZHQS9SSHRWZnFLZlpIM1pyOThVUmN5dzFSOEQ3QXE5?=
 =?utf-8?B?Q3lMeDNvY3JXV3ZnVUVsMnArNVlhU3ZramxyZ2ZiS1RDSVVVTjZJZEZKYm1t?=
 =?utf-8?B?WTJvZFBiRDJWdWt5MUtBaGVxOFRCUmk1WFNYM09KemsrR210Qk9JTjljOXE2?=
 =?utf-8?B?QlRIeHdHNFVuUW1KVGdCMnVqamFlUStiUzNjZnhmRWM5SlNsOGRnV1l2elBE?=
 =?utf-8?B?K25iZEdRTzJqbUd0bGlGak5TaDNGeWZzVlpoQzlNTTczSTVUMTRtMTlGU0tj?=
 =?utf-8?B?cit0dmVZb29VRFFGRTUxcThkc2MyR0RyN1JmTndIa2tMM0g3YUNjcmtaTm1P?=
 =?utf-8?B?dFFvdTkxUjhkTE1rQVQ1S0g4cG8xS0kvNUFzQVpUclBmR0pQbHZaVXdudnRN?=
 =?utf-8?B?VTlUM0ZlbWZoa04yRzgxVkFWMHR1VTVyMWlIMk9JZys0SlhFYjhZUlplZUV3?=
 =?utf-8?B?VzdIVmpmOGRFcmlTMlRDbU1mTWxuM2lxWUJGaUE2RUVwdnRKTjVxR096SkNY?=
 =?utf-8?B?Z3Nqck1rc1ArTXNxNTluZmppaUI1YzAybXh5OVAxTHFFQXpPdUZRNFZjemxR?=
 =?utf-8?B?Skh5QjlaSnZKYkx4OTdoK1hoM3JwcFFTMVlSb3RUdk1ValMzYm1pOEdmMTVi?=
 =?utf-8?B?ZVV0OE5vb3l0YXNXdXRIVDAraGQ0K1pmdHRHaHQzRGdnZzFRcldWOSt6Szda?=
 =?utf-8?B?N2ZXZzRqRjJiV3UzOW1IRUduZm9UV2lYYjBieHZvNmRZYzE4QlpPSXl3aUdv?=
 =?utf-8?B?T2ljSGk4RllxYUVOMmM1aGpodVQ1bEdWb1laSng2aXUvUldnU00yZzBtelli?=
 =?utf-8?B?Vm5nNHlIV0hLMU5oeVFVKytJN2tya1JpRTFMaE1YbVlxQ3BKTnZlaU9IbnZH?=
 =?utf-8?B?SEVEVU05RkduTUtGNnA4c2lWaVJObkJhVkgyd05MM0FNMEdoUDgwVTVNcmlv?=
 =?utf-8?B?Q0lMU0JNVlkrcUo2R1FoWisyejdEOUVUTEFaQlNYWitJQUhZMWlsMWxUZ2hr?=
 =?utf-8?B?QkRJZmxPOGF2MnYrR2VwK1k5UEdlZmxUWlcwNXZKTWRFTDVyS2p4RlpLcXNM?=
 =?utf-8?B?cWhFLzRtSTNwVnFPTEg3Ky84NnJEVDlqY01xVDRRckNaUGRwVGJBQ1Rkc1g3?=
 =?utf-8?B?SFpTRmgyeVA1VDhwOGZLL25wVDFjdmZlek42ekUvbEZKYVRZQjhJRGJPQllE?=
 =?utf-8?Q?k4xT+ryVjd00t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGZLQ3RQdnByb0xVMzIvVE9PVnNyR21KOGc5RGNmTW45cHJESEFqMTFPQmgr?=
 =?utf-8?B?L1RQdXZmaTFCdTJpWWhjRHhuMDhPS2JibElPNXJkazF5NGlvV0FBaGpCRVFP?=
 =?utf-8?B?NENCcnFvVCthL2RLUk9XYUtOeU5HU0tBV2VqSW5zeVQwZUpLRjZVWFUzckl3?=
 =?utf-8?B?UzZRR3prVTVHWlpDdWlINmtMcXg3TVczcXZPd1JFT1RiVUpsREdNMnZjYWJi?=
 =?utf-8?B?aGt2Ylp6STIwM3pNNjZVZGpXaitsRDFHRkdzRjhSdnZ1NHFQeWJ5OUlVaksw?=
 =?utf-8?B?MjFoeHFVQnRPL1dCMTFFdDh2NnRLQXBOcWNqeDRncVdLWmtXTHZ4SXpyUjR2?=
 =?utf-8?B?YkI1bm1LaXFnZjQwQ3FUdlZnTHpxTjJHMTlCd296Rm02TjlZdHNmZVFzeUx5?=
 =?utf-8?B?NThZNnBSMldySTJOUFVBYVo4VkhPMU5YUFJ0UkxLY2hXOG02RW95MTBmaCtM?=
 =?utf-8?B?QklLcGRabU44WGMxK04yTDNxaFV2RHpRSGZhdmYzZCs3WHNUN1A1VTNWa0wy?=
 =?utf-8?B?dzA1SHBLTHBvN29nOWNuMHpNc0F3c1prTEo5S0w1T3Q0SUtabzg5Y092cndv?=
 =?utf-8?B?L3Z1MWpGcEgxbktFZU14dEJxY3lmdkdDNUl5VmlmUndFK0hPbXdiUHhhQ0th?=
 =?utf-8?B?SkdmejREaUNoazNUZ3ZoUHAraGdNWnZScWhnTFo2aFNrRTFBOXFObWNKaTRN?=
 =?utf-8?B?U1c2NHlLWXMrVEo5aHQrcW5GUHBjNWQ0b3pJeUVva3hFeDJJYUxGOGQxTkZu?=
 =?utf-8?B?eHZJZEJ0d05ML09KcWRRNGd1R3U4RktrbEF4WDhpZkpKV01DUnRmaWRpSXFw?=
 =?utf-8?B?VkVNNFNHMjRWeWczRUtmWHZVVzY4b2lpV2U2M3p6cDI4MXMwZjNVSkNPMG1s?=
 =?utf-8?B?ZHVxSGlDTVVud2p1U0I5dWthU1d0ZU1RTTBPeGN6cm1wVGtyYVlwQy82QWRQ?=
 =?utf-8?B?YXVvS0QzejBCVmZvdkpUM0ZjWWl3TTBNcTRuc1NLUDIyWDZqa0QxYWxZV08x?=
 =?utf-8?B?V1g0a0VLWG9tUVFtcitDTzdadkNvc1BCNHZUeEdnd2I4c0RFM3NieXdMNjF2?=
 =?utf-8?B?bWFVVGphTm9TbGkwWXJkN21reVp5Z1JlaUNWZ05lNXZ1K0Y5L25ONGxtL1hO?=
 =?utf-8?B?RWduTmtObFQrREJQVS9HTEhBTFhQeVFtaXdIZkRZcUtVRFk4Q3pxV01oRnZG?=
 =?utf-8?B?b1FLc0RRMi9xSFRMRjhyTnJZY2laeEZRSFVtMjBscUhNQUVCZU12M0FaQW9N?=
 =?utf-8?B?d0tOS09BV1ZBNGsyMHNnTDRDbHpteFJld2hEOUdaMTRHWlFZbEhBRWZ3VG5Q?=
 =?utf-8?B?cXVnR2tIZzhQMXBZbVFWUXhlSXYreVIvbG9XZE91NVlxOW93d0hIc0FPWjh2?=
 =?utf-8?B?VlhTZ25oOEwvUUJHR3dTanRrMEluM3ExOExSSVFxK0s2K1lRT01nNm80Z0tJ?=
 =?utf-8?B?d09Bc2JpSkoydjJTRkZOcWJLTk9ZVDFqVFVEcjhCank1Yk1qenJoeGpmekt1?=
 =?utf-8?B?UDdtME5nOFhaNVVlaDV2NkVUYk9FS1hmaVFYUkkyaWY3TzUrS0ljb0pRbzN4?=
 =?utf-8?B?SGoyS0xHMU1CQnJnZUNlVlVsekY0eDA0aTBhWlZSL0hhd2lUZUx0SDZBQjBp?=
 =?utf-8?B?emhjSzBBVm9KVTBZeDdmUGMwYUVkVUlQNFl2S1ZxVVpmUTdRbTFjK1ZVN0Rv?=
 =?utf-8?B?dG41b1p0b05VeTFSQzFSem10aXdUNFZZREJ4MXh4ZlBEWjhRRzNRSDRTV2dh?=
 =?utf-8?B?VjRidDlOK2tYQjdZVitIN1NBaVE1YkFsOFZIWW5NWi92anhXOGVNNlNmeXo0?=
 =?utf-8?B?SXFxU3Z5ME4vT1hvTFV1eWNiZ25nRmovZnFTTEVLR3BLSHBiRVEzbHRWemZn?=
 =?utf-8?B?RGF3RnFmMmNQR0l4YlhZRkVYbkJZUVRQV08ySVdXQXNxQkJNNTJHdmRJNnF4?=
 =?utf-8?B?a29oSXdMNXJ4KzhPU0FQMDNXSVM4SXFZOVppbjd0ZVJGU2IyTWlXbW4ydnI0?=
 =?utf-8?B?N2NxYkY3RGxla3laa3BpMm1CU1JKcHN6WnRsNXpNTDdkU1NLZ1ovSzd6VnB3?=
 =?utf-8?B?UXFXdXAwMlRmeEc0TjZLQWJkNk1MYUx0Q0tmVEhka0hFdCtORk05eCtCVDMv?=
 =?utf-8?B?Rm1sMEhVSTdEcDJKR25IRVB0T0dndWZveVNuVmhRWG9EcytWNVdRaWNITlQr?=
 =?utf-8?B?bkpHZDU3RWJHSzJxSG1wSE05Rmk1T3hsQmhsbjEwNFdLQ1Y2akc2eS9KRGYw?=
 =?utf-8?B?TktuSW93WHFCSFlnRk1ROFphM2FnPT0=?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: aac748f0-d3e9-4454-58ad-08dd3969a023
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:46:37.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LrglO5kJkEvVlwHYjReST6UwinIy2fusjmbM42nF0ltjlOwrY4olH2Jz7kaq2MUGKgZOvF44TdgcVhrtxCJL3TfcWXERMyIUHH+IMdTyNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5435

On 2025-01-20 16:03, Krzysztof Kozlowski wrote:
> On 20/01/2025 13:59, Benjamin Larsson wrote:
>> On 2025-01-20 08:57, Krzysztof Kozlowski wrote:
>>> On Sun, Jan 19, 2025 at 02:01:04PM +0100, Benjamin Larsson wrote:
>>>> The Airoha SoC family have a mostly 16550-compatible UART
>>>> and High-Speed UART hardware with the exception of custom
>>>> baud rate settings register.
>>>>
>>>> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
>>>> ---
>>>>    Documentation/devicetree/bindings/serial/8250.yaml | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
>>>> index 692aa05500fd..2fbb972e5460 100644
>>>> --- a/Documentation/devicetree/bindings/serial/8250.yaml
>>>> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
>>>> @@ -63,6 +63,8 @@ properties:
>>>>          - const: mrvl,pxa-uart
>>>>          - const: nuvoton,wpcm450-uart
>>>>          - const: nuvoton,npcm750-uart
>>>> +      - const: airoha,airoha-uart
>>>> +      - const: airoha,airoha-hsuart
>>> I assume you placed it matching existing order (kind of alphabetical for
>>> compatibles with vendors)?
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Hi, I placed it after nuvoton that was the most recent addition to the
>> serial8250_config uart_config[] table that was also added to the
> But wasn't nuvoton placed in specific, ordered place?

Well not really as wpcm450-uart is placed before npcm750-uart in 
8250.yaml. But I will move the entries to below ns16850 in the next 
revision to keep the vendor list in alphabetical order.


>
>> 8250.yaml binding. IIRC I noted that there was no clear order in the
>> binding list. So the placement could be considered as random. If another
>> place is better I can move it for the next version of the patch.
> Entries with vendor look to me fully ordered by name.
>
> Best regards,
> Krzysztof

MvH

Benjamin Larsson

