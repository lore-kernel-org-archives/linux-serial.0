Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D237C6E6;
	Mon, 14 Oct 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917112; cv=fail; b=d8hAbu0wwIp3Wuf96a6yNXOWEEgztWtYW542TiL9pQ7LCsxyiJoBy1jRLZxVtlp4sLVfN/gRN4tP1/z81u1FrvcgO8e0g5IqoHWHwCkhDUS8Kd7xaMrSIYyYgfZq1w0IZ6eeLoo5Atiogo65c+xoNMkbmtBFV3N/C4xR5r3Nxaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917112; c=relaxed/simple;
	bh=Hbieep6HOA1BXpqkHWj1Kuqul8JShJPUEsHzo1B9Fts=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VKrSArtQikhnTHQE4FrOyydRiv8EWXk0rQu+E6tGzDD8CP+tyY/u+MviZBRkMaV2tJVwPzFdWE07I2Ju8JL/GywzobPHaBJroKltOqyBC+x+s1SVS7RIBMXKm9uCQCFLnhaQO3r4ukEEMm0GZNxzeyVeZDX48yeP7GAWGUGgcic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MqamQImQ; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MqamQImQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIP/bnpam62j/EJO/ZD7MuqfzcbUBtjwYQjScwOqgNmOFD6izBde6VwLmukzOdxwinx57wqZMCrnym/wmQ2Vuyjvm9dYL/wN0UkXiu0o7RBV1zgdJ+W43v5YJqEx+V/P7sgoESgyYo6wYunIeiVxAk2r4u/quNIfaYOXDFVXxq788is4OqPNHljT8/YjM+5OMoSxYwt9YFuKykGtElmfutkI5QLopa5PIMKULCFi8OwisYYCSzXPqP+7QHaX+/XMWgxCbK05R71PXkm/dvydQ8euBAb1WU499enRqxqYPEUgw7TL37EdksCjXsBCDYB5Q+eyYY1/7MTn9ssJOPwTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnRoIwI1Wl7Msu+AlgavNm69yp33C0DFCzbbuh606Do=;
 b=fQgwys3BD1H7CXHJxmcA/BCgYn5LNfYTQU1915BmONqHVhfkeUxlYXhmyIuRIRjzTyg8OoySiVCDU9wlmSZC5k29vH/wzXQKBw0FJEQFZfgz/0ngBhQHQhiTH3VNIcdAzdxKwM6N+hncpQPzuSyYnO+O9qWnrjCKc67EXFjQkU3Qy8Pu09fGkTNKddsQsY0eh9R8nGLaNaMdKEyvrqn2xVxJMx/wcVueUrK6hIdOoBZ6TTx5AHZ2mAhF8CWoDex1MxTcMEr9/D3x3LmltA6VtunoYQU7J940RnsZuJXis4CTT6IU+ntEg+hBSDT7aT//UKYInwxoO36rnJq99Ouxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnRoIwI1Wl7Msu+AlgavNm69yp33C0DFCzbbuh606Do=;
 b=MqamQImQ2sRb1p/vi8PapdF02ASv2UHso0IZKXkEEW1b70IMku8vedhR4ODYrYQ5MWePHcFlT3PeqJWjxuxDZ3hvl6mYBYuPo6CWMeyS+/NPWW/OJrNCjQxd6RHuD41R/0iLaQBhn98zRNrVctOP1PvyMHYWSR8iX1CO/qYvKsVsI4S0vT+RgnhcWjwtHoot3KaG/REw3I+H8kkHxffV2gQfKZi5OLH+PaM+uwrGYbOt/GNBC0R4gm22/gp9xjV8FfDoVEl6o5/RYkzeUvKBM5pgJWh5KPtxp41qYtrUW0nUTi6NPmMorgBbKnlwdKm3RHy0t9AiQKpKpBPAsxylDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 14:45:06 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 14:45:05 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2 0/2] add NXP LINFlexD UART clock support for S32G2/S32G3
Date: Mon, 14 Oct 2024 17:44:59 +0300
Message-ID: <20241014144501.388050-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0011.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::13) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GV1PR04MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ea343b-1db2-4a00-d2e0-08dcec5ecad7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGREU1VaeVNBUWxLYlZBZ0FwNG1SUnNmbGV5dFh2UXhKbjRqa1pBdndmUUh0?=
 =?utf-8?B?ZVBraS9sS0lkdVpDeHRmWk1rQzd3M3MwT2tmZDdVa1Y3ZTdLeVFnblBvVU56?=
 =?utf-8?B?azZFV2R0Tm1TM3FPb1N1ZzVyaW1yZC9EZWZYcHpRa0RQd3lCMThNb1JSZFVz?=
 =?utf-8?B?ZTZENFBqVG5NSXZNbEVpM09zcDh4amIwWjhjT1lFSk1CRkE2cmNRM3dBaDUv?=
 =?utf-8?B?dG15TzNNeGxXdEtqYWNMRGxuanBBdTYxYUZTZXU4ZXgzVzNtTkhhcGo3WkIx?=
 =?utf-8?B?OHo2TzY4NDRlSjA2dWYzRFAyVVNLTnN3WGlxNDd6amFCZ2Nsa0RkSWRQZitL?=
 =?utf-8?B?YTlxOXhHVytsTHRKOEliVWt3VXNBdGhXYVRtU1E1WnVHQ2xDeVlYazVtMkVi?=
 =?utf-8?B?OU5SYm9sZS83eWNGNzZpNDJHTzlac3F3ZGJTeHp4OFFBU3l3ZlJWZExvbWdY?=
 =?utf-8?B?aHRESG1pWUg5QzNHWnVsWTRUK3JjL29XdmdhWEtxNEZURG8veGZHMDlpeEo0?=
 =?utf-8?B?QUdaMDhqb3M3ajlOUkJkQWUwd3VVeHh0TjV0Z1JraWF0eUhha3pSZGpJSkR3?=
 =?utf-8?B?cVZZVCtyTEQwSDlVU05RTmdiTlpudlBCTFBGSENhU09EczFIT0NnWFhGT045?=
 =?utf-8?B?UElaUmIxaUtUQUZqaTE1eEVGNGJXanI4dUhETFRlcWZLZHN0dFo3Q2xaYXlM?=
 =?utf-8?B?bE1RTkt3VTNIZkQ3Y3l5Sk1nOEZyOU01cGFnbklYb2xReHhncjN1OFlkZytS?=
 =?utf-8?B?QkxEczRRRG9uY3lmVlNWSWN4OUdUcEtXN0pMMUFPYXFKYUQwUTV1eW9wMkgx?=
 =?utf-8?B?Yk1GaW0rYjFPVnliL0xrOHcxcEpyeS81YlRUVG9SY1Nyc1B3Z3I0NHRlVHJh?=
 =?utf-8?B?NjVsUThub1d1MTFSWnV6WS9xQlNtNjZhSkpOanlObFIwcEtlbXpJU282WTI1?=
 =?utf-8?B?SkdXbC9BR1JFSGNPNlVINEcwMHRiQ2xhVW1LdHNBbllMN29KVXlQeEJBbks2?=
 =?utf-8?B?dVN4NXhVNC9SK2tVZTU2L0lCU2hIUHdzT0N3SjQweWFoZVM3TG1yb2dMaGNU?=
 =?utf-8?B?RXJYTlZRenBhTDBKVUhFVzVmanB0NE5rcFFEeTgxYitGdmdRcERBQkh1YzlU?=
 =?utf-8?B?VzY3cVBHZnRpK1NRZFNjRVhxbG1PMm01NW1Ob216TUVsQmpidmJ6aWhEWU1o?=
 =?utf-8?B?WVNiTUd4YmxZRjZYdW9aV09CQXpZWWJHT1FkQzI4MkFqZnZqb3EwQyt2UG1s?=
 =?utf-8?B?S3M2WUdxOG1JMVQydTlFYndjUk1JcGE0c1NuTmROUU42bGdOajRIcWxlVUhC?=
 =?utf-8?B?d2pydzg4dzZYUzNBeGU1aGk2Qk9PVERCeG5DZEUydGpMb01tSmU0cG1YRndD?=
 =?utf-8?B?V1dvemdNcWdHemVBekhDZks0RE1TOU5McTNGb0VCWHYrWnF5TTErM0lvejBk?=
 =?utf-8?B?RVdIVFc0dk1QYmNkWThhY0dwMW11UjJCeFNGNVlNbGdyWEdZMDE0b3hzUEEx?=
 =?utf-8?B?QkZQd2Y1YVJOYnRsSW1DNFVoZjRKdm1pOWxhaVFienZ2K3hzWlhmbnlXYmlF?=
 =?utf-8?B?eDdDQmFQb25PdWtyeWNVczRUWU5BcStHTU1lY2JiYTEyZ3U0RDBXdlFLV1R2?=
 =?utf-8?B?Tjg0ZWozK3ZiMDhFTXZGRWgzMmFOQWhHL09neVovUkhuSmIxSmRxRm9ZK3Jv?=
 =?utf-8?B?ak9rbFlMRE5abUt2Wmswa1RzR0FITVpwczBrWVJ0bWI3a2psSWw3Um5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXVoN2wwNG1pdlVmVWhhamUyUU9La2t0d2pGUHF0enJwNGJuUlk0RWczU0F3?=
 =?utf-8?B?TnJPNjBNUXhrcHc4SW5OWGtteFl3RUpDbzhGN1ZOR1E2TytGM0pzbEt2SGE3?=
 =?utf-8?B?RkpXN1FGeGxlQmpsM25rWEUwYlphQ0dvaDB5M2VsZ3g0QWFDNmZVQWozOCt3?=
 =?utf-8?B?bEM1dDJ2QWJIb1lsa3JOK0VsdjZncFVVRDV5Sy90YlpkU0pUSXg2ZytGZzNG?=
 =?utf-8?B?aDcvbkVkWFJKdGpiYlo4dlk2TDhmZzlmUCtsZjVBSHFEYXhSSTRSRE1ON3I5?=
 =?utf-8?B?d05RTDdwRnpTTm10Q1B5L3R0V1M5NzB1bGUxZWVvMWNMSUs0QURpTnYwVDhR?=
 =?utf-8?B?ZytMNnVlOExQRldDRHBsajhDV256S2plSmNxYVpHSzljVFBzSUFWQVdJL2Zm?=
 =?utf-8?B?NDhsc3pGMnJSWjFaZWdzR0tOWk15WW9qNnQyNVBmem53OGpzMUk4aEVnaUFu?=
 =?utf-8?B?L3FyMjh4anlENWRmditESDdFcEQ3U25hbnZTNEU5MXkwa1lycVMzMlVzTU1s?=
 =?utf-8?B?clJNbUJrSk42anNFN0FIOEh0REw5M0kyUVptN1J1akkyL2VJZnBJUjduNlVk?=
 =?utf-8?B?bkhkMWZaaXBQK2Q1NzA0NFhpWjlxNm9MV0Zzbk1hTWx5S3d2aWxoUmVNaEFJ?=
 =?utf-8?B?V2hjK3hTNS8xWjZlbm1NelM2alJ1V3BPNFNJQzlUaTExTG1KWnpMSGFzOGw2?=
 =?utf-8?B?eWJwUUxFSGRPZ2hNeEFVdHN1WG9oV1p0Z2NVNmtERm1vVlJ6NUthNVNkQVI4?=
 =?utf-8?B?MStvTTZtVDBwM0lhRkFCWVlTVkhOcUpzQzZKWEltRml2amtoYWZhK3Z6YVhk?=
 =?utf-8?B?NEtVK29PdlFEVUNCbkNycmZzTVpTa2R2S2JYeVJESzRXTHh0YzZ4cFYyMk9p?=
 =?utf-8?B?VVF2dDkvQVpncWhST0lrcGtsMFp6UWsrZUdxN3FMRGZKWER4NXNndnViNVV3?=
 =?utf-8?B?OU9lZFFqMkVTMHB4UHl2cC9RYWY4Q0dwdjRuMTNXNThSeTNKWlRWSzV2amdD?=
 =?utf-8?B?Z2pWQjduRmRaTHlxalYrcEI5bURCRFRLM1d0eE5HL0t5YmkxY0hNMEpHYXBS?=
 =?utf-8?B?bXlLT0hsNHN1V3p4MThyRW9nT0RXQW8xTm84TDIvZHkzbVpoS003cnFrZ2dn?=
 =?utf-8?B?Q0hLMmFDa0lsc2VkenU0d1BYL0gyZkRUZUV0aCtib3ozOCszbTYzYUV1eTNr?=
 =?utf-8?B?bzdJYzBPaEhuVEhVZlNEMnBxMG5WWDFiVEpOdFJNbUpEOVlqaDVMRThwWldO?=
 =?utf-8?B?VFhsRGVzMWUvZjVyalcvYzVKSG1nejFMT1ZGR3RVOFk1MXlST3NPUVNBSW54?=
 =?utf-8?B?L3QyMVp5N2xwMEluYXlpVlFUWDlOU1dvM0RlWFZRb3ByUzhsczlYanFUYk9G?=
 =?utf-8?B?K3dCVUFuOWdOY09HSTFLV05OeExrU2RubERuUldEMU5OWGtiZWI3ck14SHRa?=
 =?utf-8?B?QzNrQ1lWK2JWRnZnQUV5dElnY2dpazdlclg3bjgvVWZSSnZIUVNXMWZzbElJ?=
 =?utf-8?B?eG1XOGdxYmRHc3htc3UxOHBsLzdjR0FndGtGQjRNby91YVhmM25CMWxLMlZ6?=
 =?utf-8?B?aEdOS05qMGJ1SVptZk1hWXF3a01Od1AwU3RnTkJvVlNOdFJQaFRnZ0pIbXE3?=
 =?utf-8?B?WmpzZGlNdVNCeXBMdkFmamxPcFFlZzdqMGZpV2UxdmYyNm9iKzRIVmVBaFNJ?=
 =?utf-8?B?bHQxTUZLVGQ4WE52VWovQlJZczA2ZDliUS9WT21uTUZOT0JPZTl5ZkRtVSto?=
 =?utf-8?B?NjVUS2I0VHNDRkxLUGpkaHg1cGwySVlnR2VhZ0hkVnd2RkU1U2FkZjFlTHlt?=
 =?utf-8?B?KzFCczRoZnpVSHg5WGxnMXNnNmRwQjNPWVVXNXg1aGxCUEtoaUswby9qRnND?=
 =?utf-8?B?RmFBRVQ1Nm9acy9LejhnRnphYmplOVVzLzd1UFJJMHUrVWg3NHN5ek15c2tv?=
 =?utf-8?B?cUVabm94eWVIdWFxcDhtNHNSdTlJUVBGR1laYlhaSER6WnljMXVKaXdsek9L?=
 =?utf-8?B?dkJzcllpZkh3Ky9ZYjVIWC9MRmFTZUd6TjF5YmRqaCtjMUpwNGxwU01WVGls?=
 =?utf-8?B?SWU3dXBTSXBQNWduNE5JZGFPcjVmd1MrWWxtSDNMSVZUeGZFZVR5dmJlcktN?=
 =?utf-8?B?WlN5WStzaGhVSEFsT0dxMnhyK3Z5WTkvWnUyQWFGd2VMODJlSzYxZUdBRFdj?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ea343b-1db2-4a00-d2e0-08dcec5ecad7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 14:45:05.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SlSiFxMV/5VXol/LSbDfa6eqfAzNhzpCw0iLQrLFbOTrHHgXZwaJ3JMRdUjZFhinC6vwendf89j+JGZLrR9gV28wEtQvABL9h6PiIQXJug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

LINFlexD UART driver is used by S32 SoC family.
Add clocking support as optional in order to not break
existing support for S32V234 SoC.

A separate patch adding clock definitions to
the S32G2/S32G3 based boards devicetree will be sent
for review.

Changes in V2:
- Updated bindings by adding more information related to
required LINFlexD clocks

Ciprian Marian Costea (2):
  dt-bindings: linflexuart: add clock definitions
  serial: fsl_linflexuart: add clock support

 .../bindings/serial/fsl,s32-linflexuart.yaml  | 27 ++++++++
 drivers/tty/serial/fsl_linflexuart.c          | 67 ++++++++++++++-----
 2 files changed, 78 insertions(+), 16 deletions(-)

-- 
2.45.2

