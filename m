Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023142.outbound.protection.outlook.com [40.107.44.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDB27055D;
	Sun, 30 Nov 2025 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499400; cv=fail; b=LRFxuvpd/MFtczWYFavTqjYEoNwd2iUIxxR77PS7jd9lkUw8JY30EtvVnFaqrFR8r8k0O51vbFwaJR9sy2/qqT9Z/yRVf+BljqAsPgMmKFhWUfW7BiI1XO9RddsXdjtupDQ7pUoDYvSiHpq5iofi7Avrm1WH4fLhEFXFn+0wXpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499400; c=relaxed/simple;
	bh=A9KAuSuEvcIM3rb2FbkhO35JW+UFkS83+BOCkLa7Pcs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mD0yF58Y3kK6LPryC14HrFBW9IbhIc8lbvSKPDxDCdkmo/MuuQRJ/1m8C4GUw/wV5QV+cRHAS5VTKo1Dz5Yp6feJFKnghmMkxGNxq8PB9Y25gGqSiD/L26LkRdPEG0J01ortWWt5rzePqx/hblomjr5NBZzK5su5ta+M4rgqkrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=SAQgg9Yj; arc=fail smtp.client-ip=40.107.44.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="SAQgg9Yj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAWWV9ZzdHF4YV/YfCCW6jZKoFaQ5iuLr9e2mnpc6CqjEHX1mnsjbABP8QNcqOLuO1abRrfLU8ZDIBzCAPlOghnGRuMpdVuMjwjUZhav7JkovsJu1chT+HwFF45K1DtXn27avKVa2nxM5PLr4XYR798sKgGO1dYQFiCv91jgAQ//31GgbtCtw0EPziBrAhmiupEvvRdrO2VGEhRBEBXP96aSDcNCtdU80+H256xUyqjTc35RTxeX7dxnj8N+q5F2RE1wWM1/tZnlAdHLVUjRL7dBcZUOsPDpp0CVSGv/01UeS6mzXJjtGyCwl1MFABkTBiWyulHPQ5Wmi8tV8ORYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIUBtCSAu9R0TcXUbKZ8vWrYrGt6BNGL2p6jnJ7dPO8=;
 b=B8IN7dde1G7e7ezZXLcTu8i1tE+Bt//c50ywvn2SaCaas/I9a/2oaBjLOJRps5hhX3wtxgPgZ5f2FsItuuppsrJN2fWbBwSY2BkY8qPjbOD1uJTvc1Doa71O0yENMMVfFPze7vqWMgPFjTGPtXjOQQKx6s4FRrgTTdw1yDOgX9O+PBYyhT60YbRyT/LeIQSPfVqKmVqUxMnOckhxc+Zw5eUDJtnNm2RktchzTply6yAKhFttB7V+SUNZudsmaKt3b4s8DjdPKQuyh6yB4k/0nwmNqfkmscpPIdYX7l2ZMCstjOblVwrOTw86oHsrDmmmQCb0gOrx3sNAEjOs71fGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIUBtCSAu9R0TcXUbKZ8vWrYrGt6BNGL2p6jnJ7dPO8=;
 b=SAQgg9YjWmgdeia1tsaGeUyUk30PZJ0ka6UpcPxXAGkeq0tBWweWMCHxag+CI8ylAq2JHXGqmFitqcOah/9cGOsRli85FASpkuzfrlC+kIBoO8w/+P38YwD3FAGMl94n8tN3Tgd6fR//zlr14dAI7LWWakgMU9PG8PdYbhz78zM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:43:13 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:43:13 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 00/31] serial: 8250: consolidate Moxa UPCI/PCIe support under 8250 drivers
Date: Sun, 30 Nov 2025 18:41:51 +0800
Message-ID: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3625a3-d2a9-4e3b-ca26-08de2ffd42fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGZUbmRIQmhrRXQvOEtXVnFMOEVHdUJ4aEZmcThpcHdzY3FRWUtUY0tiZmg5?=
 =?utf-8?B?NWt1bEt4TFdkMHBVNWpreGVWbEY4eU10SlJyaWh4bE5GUXJibkRGR0JxN1Ro?=
 =?utf-8?B?SlN4eVJJWTRpZTNIdGdhcFdoUG5NaEY1ZVljWjdsVTJCUlNwSWdpbEFDS25k?=
 =?utf-8?B?NGZ5M2p5V3JGa1hoc1d0c25BQllnVnZCOUZjY2NYQ2o3bVMyM1ZrbVJlbkhG?=
 =?utf-8?B?QkMrSXVCYyswR3Z4RUVDeEsyeU1qcTlIeHdjay93VDBlUTRzVTNCNDBpTzBC?=
 =?utf-8?B?ODRDVDZ5dlM3alo0MWJsRkNZU1RKdkozU0k1UEpQTXBrZE9uUzFJcWpKUmZU?=
 =?utf-8?B?Q1QvTnhFVXk4YnVZbmNsZlk2N3NaSERKWXhNdnFlSVExNDliT3U2aDEvenBl?=
 =?utf-8?B?cDBUdEsvbVZqdE9IcUpIRklyRWx1RjgvWDNWNzJROWMzMVVUWVJPcDZIUnhm?=
 =?utf-8?B?ME9PZkFINE5rYjRrOWFwSmJDWlZIRW1PRUZLR2dETlRHRFlCd0ZXU2ZjTVNI?=
 =?utf-8?B?MDI4d1ZKcStIcTFLTUtseTJWdVg1dDloZGx2NzZFZGxtV2JjSzRxS0Q2Rk5s?=
 =?utf-8?B?WkRUTXRYbFc2WFhVTHZJN3oyRHU3ZklDdkZ6ekVtVkVVRis2SmE0UmxvT2Zj?=
 =?utf-8?B?THF1Zk5NLzNmRm5yVFpzMXZXRVZ3aFhqSjl4aHJ6UkxwL3N3aXBPNjg2d3hr?=
 =?utf-8?B?TmNzdHBMeXRWY3piTGtuWjczWXB4L0ZTdlBoNDJuREROUVJwREJvQlNpRW1F?=
 =?utf-8?B?dkJVU3hOWTFMOC9rQkovZW9EOTBHZXhCc1BwQmxrVlhoZlovYW9OQlkyNUdl?=
 =?utf-8?B?UlJYNG5XWFRucy9hQ0JTY0QvZ1hZT010bktYblk1dGhRRXNRSUpCTDJSQ0xz?=
 =?utf-8?B?WWVibnQ0aitsWFhpdW1EQTQrWjhIY3hKQ2MrSG1CbFQ3V0l2NlJYb29qWnVp?=
 =?utf-8?B?c3liaVdUUjFrSHlSY0hhUGtOU3JKdkE2b3liVGxhanVkM08vV3BKK0greXdo?=
 =?utf-8?B?ajhuZDhFRmJpcWVIVzQvTkt5NzR1QW94RzRtaDVZc1JRa3pjc1dVcFl6cFNZ?=
 =?utf-8?B?S2JoZXhiK1duY3JTcnRqcy9tSFlWVC9BQTVKUmVGUzBBQzlGbzI0RGYrcSt2?=
 =?utf-8?B?bVFYOTVJZEFLbXhHRk9YMFNnUHV2U296Nkt4Q2FkTGxHNHlieTU3OHhYT1gy?=
 =?utf-8?B?ck5RcEVJRWJoUVRTak8zdzZKTDJCYjc5UDFJejFPMHJsYmVPL0hFbW9WWnVs?=
 =?utf-8?B?dlpQclpXYVZzTHNCZUR3RTFNWWwyYjlHS1RFSVpyTG5MV1Y3emVzK3JScG5t?=
 =?utf-8?B?MVpLMlU0Qy9vd1Y5SGxsekgzRGNvcFlUUEFVS21YSGFkWFNpTGx0VG1mTXB1?=
 =?utf-8?B?TERsZGRqT05yWXlXVnJYOXB3N2xGN01jRmhwVGlmYzhvcHZzWGRCa1lpQzdr?=
 =?utf-8?B?dmNyeXoyTmdKYmhUN3NWTDRJNEFmbmxGZ0FLbm9rdUFNTW4xQXZDMVpJQzgv?=
 =?utf-8?B?YnBiY2lydjVTMWVtRU11dzRQK3gzaVpPejlCZnBJVHlERnk3TWZNWk10cGNs?=
 =?utf-8?B?QzRLejJsWkJsT0k1Mk1jNnhuTk11VDZsRHJxczhhSkphY3pRdDNGOTVGaXVX?=
 =?utf-8?B?eFdZZkJnZlpZTUtoK3BWNDliMW85eGlzbVNCdm1CYXJyZ1ZFUXZ4VEFPRXEy?=
 =?utf-8?B?VDNYMmp4Smk5Z0MwT0dEYjlWVjRnMWNoNU90eDVQT2JMcThBZUNxYXJJMzNl?=
 =?utf-8?B?UjFkK045dWU1YkxPbDREbUZxTjhtdDFJRWpqOWVzdTJ5K3FGc2NMcmo2dWQv?=
 =?utf-8?B?YWRIdTh0R3Y1MTZrNXg1YkRrNnpJbFE1SWJtNC9ZRTJzNTBEcTNpUExvK1Mr?=
 =?utf-8?B?a0ZlMm9Qc3hOYlNZVGJFOVJTWWtIdnJhakFKNE8ydjdXejNLRHFjbzRCUVpl?=
 =?utf-8?B?V3o5QWF5VW5BVmFjSDVFQmlvOGFYc0FvQkVrQUpFaWZ6U3pNSkoxRDhBbmRk?=
 =?utf-8?B?cERGTWRwZ3FQdjRWZUoyVVkySTc1WjJIZ05RdWcvRmVxdEZMUGdwbW0vYW11?=
 =?utf-8?Q?LYK3dh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0l0a2FKamwvZG14WTdzRWYxb2Yrb29BRVdPQlJ6N05JelZEeTZaYjhNcUhB?=
 =?utf-8?B?WmZxSnRMd2tORUJwaFJQV3FWZHF4ZUtoM1ZYU1lSZVZVS2ZoZmhWZ0l0cGs4?=
 =?utf-8?B?YWdnSmNGaTdzcFY1ZGNITnpwU082QUhlc01yZGs3bDV2eEttZUFBSUVsb1NT?=
 =?utf-8?B?aWhQakVYUXBPWVA3OG1iWElCcjB6a1IyN1hyQUtIQmpuR3MzMWgrVkxkSnhk?=
 =?utf-8?B?RzZjeWdFQ3BxajIxRERXdGxveTNCTDZXbnMrRW9pQ09zajQzRDcwaDVsNTQ5?=
 =?utf-8?B?Z1R0dHVTSlBQNGN6L0VCUUVZM0RqRTVwMHZOYlBlVUhzaEhzMFF3LzRQTWtC?=
 =?utf-8?B?NTh6RmxsQWVHdlVrdzdHNm9MeG9KQXl4OGZxZmdlcXZ6RVptb0dMNjhVVVZj?=
 =?utf-8?B?NXA2c2NVbHhCckp2MmJCcGRnU2tIbW1ISHhUS3I1cm1SMjZkM3NvS292ak1N?=
 =?utf-8?B?YVN6QzZQNGlKQ3czZlB5VDgzTFRkWUk2czU2U01XMTBLS2Ftb1dYbEdpak4x?=
 =?utf-8?B?Q01kai94akNHMGJBREJzSVFGVk5pbFNHcmlFdktId2F5NnVqVjdlZ3lBMnRQ?=
 =?utf-8?B?WStRVVZFbkZZVUViaWpDY2swWU0raWFzakkvVUZlVmNBZ0hBKzNOdXZUUlFV?=
 =?utf-8?B?cTNjWkJvQzdaUXhrbVRKazFQc3hRSVg3YUs0clVCNXFWQ3VIZWhxSmlCc21U?=
 =?utf-8?B?NGFrSU41QTFwalZmdWxZdEEySzFubW9Ic294U0FRR29xaWh1NmpJSGtZamZ6?=
 =?utf-8?B?YVE0TVNMeFBCS2NrY0s3aG9jYUJtT3RVQlptWXltVVgvN3RUeExXemZCTjRq?=
 =?utf-8?B?SXpKNXhaUlRNeU1pUWpFMGdZNjFkWmI4enJ4TEdTNGh2ZEw4VExoems5cFc1?=
 =?utf-8?B?NDNUZFF4OG9td25pL0ZDbnU2dUtVWEJqTDY1MHpVNnVhZU9uMzQyQWNDcEd5?=
 =?utf-8?B?NVVERkEvZEIzOUpvUFRQandRQkw2YktiTysvd0JhUjJxOGoyWURUTzBzcFRK?=
 =?utf-8?B?UGp2bEdQMHA0clpiK3VtckNiSFNLdFFUdnY0Nm1DakdLSzNpOWZLQSsvc1Nm?=
 =?utf-8?B?c1NrMHlYTTZoeDN5SitHTXlpT1dOYzJac0xzN3RNZGptTzQ4UytkUVVoamFZ?=
 =?utf-8?B?UHhzVGwrbFh3MThJdkFZMENDeU5GWEF1dGlKeWV3eWFxMVdlM21RVm9GVzB6?=
 =?utf-8?B?T3p0UW1TazZwU3luRGI5YmZDSFNHRGFQWU5WMnZnV1FTa3J4bHpZaWNXNFE0?=
 =?utf-8?B?amtoMDNqVXlZcUlBNVdKT2tnQXNCM3dBaHBObGlEcXA3dExIYmM1UzNRdXN3?=
 =?utf-8?B?aU56RXZ2RDZNdWVKd2tHSFBCckJScEhxYm15QWF5dkVXc1pITjR2Nlh4VTJ2?=
 =?utf-8?B?STJiUTdPc1dMRjltTnU3SXUveFBIL254TnVzZGdBeStWNEdFMi9NaHZHdzNy?=
 =?utf-8?B?SDhnSENzZUo3MmJERG0xaThJd0xzUWpPemt6M1BYbFBlUmwyZUNJTWk3YUNz?=
 =?utf-8?B?Q0ZJMEc0MVpBRjlzZDRKUHVvS3ZLbzdUZnZGR1grTXRMbytOWUs5V3JBdmhS?=
 =?utf-8?B?UTZWUUp3SVJyM1ZZWFZOcVgvMm5GZnVsMGVmZ050TEJORGIweW05Z0I4K2p4?=
 =?utf-8?B?UHVpN3VkNEZGTUprVHZxUlVlSXU4czVWRG83R1ZxemY4S3RlNzlkaDJmSXVX?=
 =?utf-8?B?UE82Zi8yQTZ6STE1eU1NakYxU2cyeVF3L1NKbC9YZThsbmxCLzFPTkVnVEpJ?=
 =?utf-8?B?VUkwRSt1amhGamhqNVJHdVczWGdITmR2Q2NFUU9RbFZSYkJaRENCbTY3K1h1?=
 =?utf-8?B?eUp3UDVidkMzR21iZCs1Y1I5bHlSYXJ6OTdHT1BVVDJFUlZNWndrSHEwN3Jj?=
 =?utf-8?B?WlNmQWxhT092Q0s3VS9VRmduSDdnck50RERvMWRBbEhHWjBoMnBTK0laWlZp?=
 =?utf-8?B?bkp1U1FLRk1nK2FIK0NFWHRTaHVlM1p0cVppd2Nyam1YdXpIenkreG1mRmVX?=
 =?utf-8?B?Vmd4RzJIWW5UWXcrcjBsR1Q3dE9SM0VaVkJwd1dUL04yRkVWeWFxWGlnd0xB?=
 =?utf-8?B?M2pXZlBaeFFSeGxtdWRKblVhUFYrUDAvRG1IUXBSUzhCR3BROVJOL01PbFZx?=
 =?utf-8?B?SjE4UWs0cThLeTAwVlUwZ0lHdStsMGw1RnNXeXN0ekdCK0FjSmFXUFBpTzND?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3625a3-d2a9-4e3b-ca26-08de2ffd42fe
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:43:13.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLHF2l972XNCHccmBj0ec0ta2hPaWuCPxZ32pQE6aqnKIYxtDhK/DoJ3j3GEz9Ke/Ai5jquM7YEqN+4XKjkOqcbu73DRZMxCrOBTuM/o9xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

There are currently two separate drivers supporting Moxa UPCI/PCIe
multiport serial boards: the legacy mxser driver and partial support in
8250_pci.  This patch series consolidates these implementations into two
dedicated 8250-based drivers, 8250_mxupci and 8250_mxpcie, in order to
remove duplicated code, improve consistency, and simplify long-term
maintenance.

In addition to the driver migration, the series also introduces several
hardware-specific improvements for Moxa UPCI/PCIe devices, including:

 - reworked and optimized ISR-based Tx/Rx paths
 - per-port FIFO trigger level support
 - break control under RS-485 modes
 - CPLD/GPIO-based line control for PCIe boards: terminator, pull-state,
   and one-shot RS-485-2W auto-tune

These changes restore full hardware functionality while aligning both
device families with the upstream 8250 serial framework.

Crescent Hsieh (31):
  tty: mxser: serial: 8250: replace mxser with 8250-based driver
  serial: 8250: add MU860 UART configuration
  serial: 8250_mxupci: enable enhanced mode and custom FIFO trigger
    levels
  serial: 8250_mxupci: enable auto RTS/CTS flow control
  serial: 8250_mxupci: enable on-chip software flow control
  serial: 8250_mxupci: add custom handle_irq()
  serial: 8250_mxupci: add GDL-based Rx routine for 8250_mxupci
  serial: 8250_mxupci: add custom Tx routine for 8250_mxupci
  serial: 8250: split 8250_mxpcie from 8250_pci
  serial: 8250: add MUEx50 UART configuration
  serial: 8250_mxpcie: enable enhanced mode and custom FIFO trigger
    levels
  serial: 8250_mxpcie: enable auto RTS/CTS flow control
  serial: 8250_mxpcie: enable on-chip software flow control
  serial: 8250_mxpcie: add custom handle_irq()
  serial: 8250_mxpcie: optimize Rx using memory-mapped FIFO access
  serial: 8250_mxpcie: optimize Tx using memory-mapped FIFO access
  serial: 8250_mxpcie: enable serial interface switching
  serial: 8250: allow low-level driver to override break_ctl()
  serial: 8250_mxpcie: add break signal support under RS485
  serial: 8250: add optional callbacks for rx_trig_bytes
  serial: 8250_mxpcie: implement rx_trig_bytes callbacks and persist
    per-port level
  serial: 8250_mxupci: implement rx_trig_bytes callbacks and persist
    per-port level
  serial: 8250_mxpcie: defer uart_write_wakeup to workqueue
  serial: 8250_mxupci: defer uart_write_wakeup to workqueue
  serial: 8250_mxpcie: add basic GPIO helper functions
  serial: 8250_mxpcie: add basic CPLD helper functions
  serial: 8250: Allow dynamic extension of uart_port attr_group
  serial: 8250_mxpcie: Track current serial interface for later feature
    gating
  serial: 8250_mxpcie: Add sysfs to control terminator
  serial: 8250_mxpcie: Add sysfs to control pull state via CPLD
  serial: 8250_mxpcie: add RS485-2W auto-adjust sysfs control

 drivers/tty/Kconfig                   |   13 -
 drivers/tty/Makefile                  |    1 -
 drivers/tty/mxser.c                   | 1934 -------------------------
 drivers/tty/serial/8250/8250_core.c   |   14 +
 drivers/tty/serial/8250/8250_mxpcie.c | 1482 +++++++++++++++++++
 drivers/tty/serial/8250/8250_mxupci.c |  495 +++++++
 drivers/tty/serial/8250/8250_pci.c    |  205 ---
 drivers/tty/serial/8250/8250_port.c   |   69 +-
 drivers/tty/serial/8250/Kconfig       |   22 +
 drivers/tty/serial/8250/Makefile      |    2 +
 include/linux/serial_8250.h           |    1 +
 include/linux/serial_core.h           |    4 +
 include/uapi/linux/serial_core.h      |    6 +
 13 files changed, 2090 insertions(+), 2158 deletions(-)
 delete mode 100644 drivers/tty/mxser.c
 create mode 100644 drivers/tty/serial/8250/8250_mxpcie.c
 create mode 100644 drivers/tty/serial/8250/8250_mxupci.c

-- 
2.45.2

