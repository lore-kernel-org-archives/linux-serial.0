Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792663590;
	b=Z+5dv2PxNHaYQJuBqZJ8KYVS9JHJljOJuoQeafcTdWbMKV+tJqpWstHCkZ/znghMtKFa
	 3h0Fm1YXOylUQtIGB5gdOVfWdTLfunwS1fVHkON642nqQ1V4dMoqQA321oidwwedhZo++
	 zos1ty9obGbnvfUuuNAXQeHSzb2SgDtV6Tg66V1YHe4NP1CJPYjkvLvBMAfa8msON1yUu
	 nCTxrBmOtgIybhZ+2BMw28d4bOTEvTc9v4yztJvm4jxdbj/lS+7iy6UIsGJ5NocQ3H3rV
	 aSdtwRF1sfW9/SBNInGmTavgRn2G1pDwjsKY4ujti+iNnggcDgfSUaEtdEpCk4G7/Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663590;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=noLkfI1i0GtYQwfbbS+wG3diQbBD6shC7ACKQcK6p1k=;
	b=PjR0/U14xnnTtFNkM5ozxxH7eQUzyj5j5pt7AmkJQdbjmo/pxqnAxZWSbR+YaENbsUnd
	 pPU5LebIUH78raiH2m0TPozuAOBeswksllzBnkfX5hcWURKOIhG31++V6p4Nekt3OeboL
	 Qdk4zkaqOhhoeCsIQNo2dipE1crFoh49HWT2FZJPZAJ0xhnjDjE+H/VGgAFQMYMpas3Tv
	 Zim6Lijf5R2o+YfWtjJfBG6Jv0q3Fn/vDNaadOFDfuHc5Gp+T8hUZkbEstP63oaHCI92z
	 OVkF7XDYqCUUx9UiwoiRUlBF7dLkfy4ShakEqxnQTiezoTbc/W71AyPRayi5h7sWIJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jcpxWEGT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.57
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F5606A31A;
	Thu, 22 Oct 2026 10:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 590F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jcpxWEGT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVNk1srLLxVKh0LbNut3cv991ENO6oawteKsyIT++bFJgJDMhkQOuVMkQpLHe1jDy+xv9l9v5OVRKePA2MGOLFugjzrvqVFvc+dRjsgbEfUeQmvd+VZdy0edoyi1z1HVsJwr4BkhS15RKlLXhD82vjsr1ZutQfLDikcMC9iN658bZbw/jRIBOYe5eN7PcFm5WodZFbw/pEVAYasJgR7MwPTENZjG7VRxvgcWonvjG6xr3Xu2waOXYob83lm23PMY7jx3StiUjXgSND2jxZdnAT9UG21a0MfinMqikqGCPWIoQgzFN8GlZwK/q1HqrjknD9CpwU/MLHpOp1k0ICariA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noLkfI1i0GtYQwfbbS+wG3diQbBD6shC7ACKQcK6p1k=;
 b=jH3TylsOFB23BXYPP/MUBrTBgbMFq75u7zu0cy3KTvhn0YjhZUY44arfeQc6/XcZxBj5NqQeu2rtOcZxciKzWuQ7s2i9tRBNNOuM3xwb7FHEA4tI3THdqftOODzX3Bso+RyntH1WEymISGFPSI7SOHAupReppcXcjNnGMtSdUvbiYkRtx/R2fdBLTU71tGz2q0sbAosy9bTSR/p0v18vNWopwLXrMQmkGCr1edbCDip4eldGE7JvSjQomqFSPsu7m14ppFgVB0je5hvtL02Kqarwy5PyKZS1bI/WVvUWhB2kqsKrFy43uW2YNXApzv+Ti/2qDWWXbTlT2780ga8EZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noLkfI1i0GtYQwfbbS+wG3diQbBD6shC7ACKQcK6p1k=;
 b=jcpxWEGT1j+shCsH531soGS1p1DFaFIjnUAWFpjd6GPhCCQNW1NaOcTJtRmEkz+ClnG3zrbbJHfw4lSW7DIgBZPCW2wcG4IL4MMaWPluwrikKAPBFX/VJtjT+ktKzPL4A0Bd8pawlicFIjVkKRugac0+zzbjQq6vpV8HkBcD7YkE1kpjIFUM5ACou0uVKcCCHUDRExycDcexsqFOCyelW07ppu1VFYxQCFpVuHDefDEht6gJebSPYUSXXGTfn22vQG52UqH+0c9My2L/E7dnuD5iHlI846+X/0r3JbN7SY9YLfPqdQvZoZXToCCl1IsE18tdsU0sEp5nBWeYCYwTSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM8PR04MB7954.eurprd04.prod.outlook.com (2603:10a6:20b:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 10:06:23 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 10:06:22 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Date: Thu, 22 Oct 2026 18:08:59 +0800
Subject: [PATCH] tty: serial: core: fix synchronous external abort in
 uart_tiocmget() for runtime-suspended ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-b4-serial_uart_tiocmget-v1-1-9608a5e4bb10@nxp.com>
X-B4-Tracking: v=1; b=H4sIALrg2WoC/x3MTQqAIBBA4avErBN0kBZdJUKsxhroj9EiiO6et
 XyL790QSZgi1MUNQidH3tYcpiygn/w6kuIhN6DGymhE1Vn1ET+7w0tyibd+GSkpxEBeUzVYGyD
 rXSjw9Z+b9nleQSjeXWkAAAA=
X-Change-ID: 20261022-b4-serial_uart_tiocmget-22fea0e6d44f
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Alan Cox <alan@linux.intel.com>, Florian Eckert <fe@dev.tdt.de>, 
 Lee Jones <lee@kernel.org>, Maarten Brock <m.brock@vanmierlo.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, sherry.sun@nxp.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792663752; l=3550;
 i=sherry.sun@nxp.com; s=20260723; h=from:subject:message-id;
 bh=Nqr32+auMbZlche2USrO1xSax+p6qxa6eNN++gwgU3U=;
 b=A1dUYODJ5TR0QB0f6EKSrPny8yiQXA8eEplOwyuBfC10yjTGv9RN+pD3r7inDWGkUW/boGGiN
 /k/+SU17Jf0C46ufMjRsGhyfw7Ea4eeXjrX0MpIxkFNfJmIS/JYWgBv
X-Developer-Key: i=sherry.sun@nxp.com; a=ed25519;
 pk=YnYnIFJ2l+5v951x9shBVfHhminNi+3LTfFa3PxSdnI=
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
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
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM8PR04MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: ffab5eca-f70f-49a9-27dc-08df30242008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|23010399003|6133799003|10067099003|18002099003|261021121427099003|261021123027099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	e63gm9zr5TzwGc//3rOIz50xyXF4tMN1K6KnB4rLVby9npWNMMoIN9j6Af5wLVl8xweHyCxKnOeWYYVdjG2s9LczDXLw/WPDSO4aS5zRJiDik/iNeVBOV5xcmn6TQg4QdXQOQqu2YR8cwp7Y9xSrtDOWh3KqaX2WLAyKu3c31q8UJCfewItqlf0vMjpkwbspwvXiMzOFDClUfDahAPna1RRreJKkm6xj3AIU51VS3RL5PFtBF5KqxKSherIvitMT86bOxcSJN6irYJSOxPPAw6w80xK9SDbIYhBCD4IgVnkaDjW9dVq48Ad5/zckJT/rBCaI6gDS9cErCMDNiUgEhVwCavNXl0DjW+MBtSEqGMF/HDu9ryOTrPGGen04TbrHkIOg2yBh6BfAlO1VOXpTPx1ZrSF79ztcqYp1qmh5ooaq6XlsFIdgMVUz7/vmu2D0zZ+tlPdG/C7jkDe1r7/s4TOzqtiEYQicdAGsOhHrm73obSWNVTJMuxiFbfMbxwyCWeDuNJ/eZh16H51tLFQmCYL7LafvX7GUASp7V/6ChYLTcCGrjOpXPuJ4OR1DBtboji86U7OG0lPa14lWwY2zmN5huzGuorPan/nXO69z4wtasQeqY6+SIGxJG/Ho0LCKNCRyLtRSAtCujJZyNPdKlnYPqatnFFctDD76sQZyUJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(261021121427099003)(261021123027099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU15Q1JmdVlURXZ2L08xWU9WUXpRL245alp4N2dDdTh6Mjd6Q2VGVGRHUFAw?=
 =?utf-8?B?eTBLNDQvM3FtaHI1Z0c2L09SaklYelNNYUd0dWp4RUpPRU9HcVkwY2RBMWcr?=
 =?utf-8?B?WDlsbW5Eb2ZOQmI2Z3BlM0g0YitFaTVSeFZCQjJhOXhJZkROaEdPU1B0KzdJ?=
 =?utf-8?B?TStBa2NUbXFVa2M5bXY0dEpLdGVCWE14VWxqeUgvUzc4SWNGQmdHTGZmNWQ4?=
 =?utf-8?B?YXZrTFNYODBVdXNrTUtjU1ByUHlsUGoxbG1PQlQ3RjMxZkZHbHI2TFZTMXFP?=
 =?utf-8?B?alI4THVDKzNoMWJHbUV2TnJRRXFmb1NZRkVucXZ1dTgvMEdKeWUxajArNWFh?=
 =?utf-8?B?RWlPODlHeG14T1FhVFpaVHNzdFViaGNCTVYvTkh3aFF4Z0oxWnB2R2NUZyt6?=
 =?utf-8?B?N3MxU05tb2FUVHNGODM2T2lxeHd1aFFnb3h3VU1paDR1NEJ5M0haWGhPajJv?=
 =?utf-8?B?RzEwVXBZMnJlMTdGV2w3NzdyNEhVVUdQWklFVFpGVzFXVGg0VkxWL3NxNnpS?=
 =?utf-8?B?QmVtZm1qc1lJbGExWWxiYUlZOXRIQTNHZmJyK29QdkxnUDRpR2J5aVB4d3dm?=
 =?utf-8?B?Rk1mL1JiaThzRlFDVVdkMUFZeCtHUk1taFdhQjBYZXhrRjRITWEyMURRRTdH?=
 =?utf-8?B?ZzFaQnhObG9jTlJDbWhtM1FtZXNpYVRtNWZDVGVFWVcxSEcybGxiSkxXQmNR?=
 =?utf-8?B?VkUzdWkzMUNHNzF1VEY1dWEyWEVMdENXOGRFTUlidDRxcjNORVNSWjJPRDd4?=
 =?utf-8?B?eWo3bnJqb3JGYkFZNEFabDE3SlY5YVNKTHdVeGRVUkNCL0FMaS8vN054cnh5?=
 =?utf-8?B?bUtEeEpLVVNDaDBESTljOXdNQTZzeDZKWTlpWnJHa3VMR3RJTzVTYnpXN3J1?=
 =?utf-8?B?U0lnZjZOdzlIYnhIbGFoK0lEVnZCQ1VMeUNGUGI4dUpUY2xWZjNsYVRPWGxr?=
 =?utf-8?B?N1lBZkp2VFc3dE50UUVsWFRndW1rdlN2Y01XMjdCTlZSdDlTQnVsbTVhRzZy?=
 =?utf-8?B?Ymgza3ZWSXB4NkJjTFNQYVhjZDVjNEJQWEJ0cVpjdlYzWmdQVGJxMmZKYTZC?=
 =?utf-8?B?ZGNPUUF1UkFoTTU0eitUQytma3BrUTQ4MDBoVlBTOGd2MHVLRk1XOTRrbmp2?=
 =?utf-8?B?YnN0eTFBSXUvdmFiWGR5cFRYaHRkVUo1b3c4ZlUwdnR3cXM1YTIzVERBRFRN?=
 =?utf-8?B?VHVSLzR2MTc4eTJhb0kwa1hjU0x5M29KbjZpREY4SkhQZlJzVHdrMWVheTRp?=
 =?utf-8?B?OHdLV0RsVUM2U1BrODNMMzlGZENEanppWER4NmtxN1VzZmRFZTFkYXozWHRw?=
 =?utf-8?B?a1R3OFdjb214MCswTTZnbGNwUmtROE9YWEdURGdqbmZRdGFwaTE2NDNyUlUr?=
 =?utf-8?B?dTNJM0VoYUhEL3dwT0JQMXBIRTByaCtic2hjR25RbEF4czB2TG9Ha1hUV1Jr?=
 =?utf-8?B?T01kbjNtT3VsRXZ5KytQUGthK1BTR2FycUhWYWJEaXh4Z2QvZmpHTGpnck8r?=
 =?utf-8?B?TEFkYmhvc1hoZ0owWUFUb3pwR3VYRlJpeXVva2trRXI4Tkt6K2hnSTdtSGtp?=
 =?utf-8?B?MDBuUlJudmhUTjZ5TGx6SjBJeDkxTU9DbkFEZm1QK3VOT3B0c2pQcVNKcThh?=
 =?utf-8?B?Zm1Sclg1RjFvbUtpU3VHaE1JS2RXajhoS043WGQ0VE5jZXZleEQ1S3p2SWxt?=
 =?utf-8?B?ZzhnWVpPeWt3ODl6eU1UNVB0M05ITUZFQXhydm1xd3hPT0pLOWlzaFlxMTJz?=
 =?utf-8?B?R1RiaEJNbHdiZDNQcWVnRjlsRXRFQWRKS2hTMXU5OUljQ0wzdXM2NUV3TXIz?=
 =?utf-8?B?UG5mNWdJWjNiRTR0VzBiSSt0Mit1cll0cTFvZHJmanRzWXM0WWlXZ1JQcU9J?=
 =?utf-8?B?UngvMEc1elhYanRmWFJxdTVtd3pTcU0wbVI3M2wyUm5XUFNoNVJTRThCbU44?=
 =?utf-8?B?TlMrRDFMY1pvRlo4NEdIcjhPZE1SRm9PczF0aGpsNDRUeWxoOTFCdHJUUk9B?=
 =?utf-8?B?QkE3Ky83VW9aMml0Q1pMTVFFRFgwblJFYW1RTmNKOTV2aXlCREo1VXFNK1pF?=
 =?utf-8?B?SkF5SnFacTNSdCsvRnArK3hkTlpkRXpva080NklIb0pvMzFZWmpQN1NXL1o4?=
 =?utf-8?B?WWwwNjcyekNFcWF3Nmg4dy9OWXRicGtRYkpoNk9YM01aTmhNa3lJbWtmN2Ey?=
 =?utf-8?B?WEdENXpsWXpoYlZrYUhDVEJHa3B1V0wxRGVMcjYrbkcxOG9YUXhLSGp0RmJQ?=
 =?utf-8?B?ajAzWXZMaGR6WHg4K2E4Uzh6aWw1dVZvaFg0bStCa2RQUFlxNjFVOStUaDBB?=
 =?utf-8?B?NW1TcjZuYS91Qm1qSHViRlRJeDRBNnZQbU9BNDNaM3hGT1pvUDFtRS9qdWdt?=
 =?utf-8?Q?bi1oNUNKExVMdU49h0o1SfajN8pgC6VuRuAWs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffab5eca-f70f-49a9-27dc-08df30242008
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:06:22.6627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HvScN0JGksNG7Gx9z3aH+KRgeccjRNKsI8ttLie1ziGy8tdRfv1JyPEChor9qJ5EVlbBvqE8cjpIdDiz79sHAVFHIyIK1P3QuUzCCwDNxf/oNWOvyJijfotogxoAHMG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7954

From: Sherry Sun <sherry.sun@nxp.com>

uart_tiocmget() reads the hardware through ops->get_mctrl(), and the
only check it does first is whether TTY_IO_ERROR is set. That is not
enough to know the port is powered.

On last close, tty_port_close() calls tty_port_shutdown(), which runs
uart_tty_port_shutdown() under port->mutex and powers the port down
with uart_change_pm(UART_PM_STATE_OFF). port->mutex is then dropped,
and only after that does tty_port_close() set TTY_IO_ERROR. A caller
waiting for port->mutex in uart_tiocmget() gets the mutex in between,
sees TTY_IO_ERROR still clear and reads a register of a port that has
already been powered down.

A TIOCMGET ioctl from userspace cannot get there, as it needs an open
file and the file being closed is the last one. But an in-kernel user
that holds the tty through tty_kopen_shared() can, because
tty_kopen_shared() only takes a reference to the tty and does not open
it. ledtrig-tty does this and polls the modem control lines every
~100ms:

  ledtrig_tty_work() -> tty_get_tiocm() -> uart_tiocmget()
    -> ops->get_mctrl() -> register read

On i.MX93 with fsl_lpuart, opening and closing the port in a loop while
the LED trigger is attached to it makes the trigger hit this window
after the LPUART clocks have been gated. The register read in
lpuart32_get_mctrl() then causes a synchronous external abort:

  Internal error: synchronous external abort: 0000000096000010 [#1]  SMP
  Workqueue: events ledtrig_tty_work
  pc : lpuart32_get_mctrl+0x4c/0x64
  Call trace:
   lpuart32_get_mctrl+0x4c/0x64 (P)
   tty_get_tiocm+0x1c/0x30
   ledtrig_tty_work+0x48/0x2dc

Fix this by also checking state->pm_state in uart_tiocmget() and
returning -EIO unless the port is powered on. pm_state is the serial
core record of the port power state. It is only changed under
port->mutex, which uart_tiocmget() already holds, and on close it is
set to UART_PM_STATE_OFF in the same critical section that powers the
port down, before port->mutex is dropped.

Callers that have the port open, such as userspace TIOCMGET and serdev,
are not affected, as pm_state stays UART_PM_STATE_ON while the port is
open. The only exception is system suspend, where uart_suspend_port()
powers the port down and uart_tiocmget() now returns -EIO instead of
touching the hardware.

Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Fixes: 6dec659896b4 ("leds: ledtrig-tty: Add additional line state evaluation")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/serial_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af4..272feae690ce 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1088,7 +1088,13 @@ static int uart_tiocmget(struct tty_struct *tty)
 	guard(mutex)(&port->mutex);
 
 	uport = uart_port_check(state);
-	if (!uport || tty_io_error(tty))
+	/*
+	 * TTY_IO_ERROR alone does not tell whether the hardware can be
+	 * accessed: on last close it is set only after the port has been
+	 * powered down and port->mutex dropped. Check the power state too.
+	 */
+	if (!uport || tty_io_error(tty) ||
+	    state->pm_state != UART_PM_STATE_ON)
 		return -EIO;
 
 	guard(uart_port_lock_irq)(uport);

---
base-commit: 9a482184d910775cf648863148944945b74e2815
change-id: 20261022-b4-serial_uart_tiocmget-22fea0e6d44f

Best regards,
-- 
Sherry Sun <sherry.sun@nxp.com>

