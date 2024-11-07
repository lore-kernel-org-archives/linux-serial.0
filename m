Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5F1D47B3;
	Thu,  7 Nov 2024 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980886; cv=fail; b=sflw0XyKPlCKP41xXROzwqRWAGfaS/lp9Dvg5kRcvdeqZIktdsrHftfvRnEcIO49sbXL3cO9rFT2EDa9Yylo7ixTejFy6+DbW+0XxgF52zsp0V4SbeZqEbZc9pEQa3oV89t4ewMXueTLUgA1VQR468qMOoF/5Uq/juIeu15lJBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980886; c=relaxed/simple;
	bh=3u7FvAJkEr4jxBZswqjfEzCZNzXtHesefZVFlFN2lA8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TF2IetLgd+IZHtY2dS+nlWNbPqibrfDSkGf5036eIhH4MgOFWh2hZvoAweQBG59mb2UhITV2tIcevX8E0Rn0ql2LeXhlp1mtgwOIr0+x4iZ0HdDNFmJiHXuaW7G8TqpIutPNfvjEJi4PKkNnTRvxWvSNyqhtY7ZwvPYx/t0QcSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=s7wsbe1E; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s7wsbe1E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooJi6DfvhrDSxj91/hv3LyEcfRC9jQdiQf+nFgGFjQ4qQJFRWJcRAYr4k8IcIQBMJaWv1eBQT0DlomBNGggN6iQDvtrlbA0EwsQotx1l4CI5vjg9bJv1eOA/IZcs5Y2cyI5kpTMF5gsDX6iZUFO9rCYCB2ZkmQUOFnDcPhUclGtj0q05w7k21Wc7CoLoUx6FafMH7HFdi5yTfSTL1Rq1nyXJtWhGZueoVgnqkbILS0ceDuAgiMcSS62L+iWb4uGaLhGJBrj+bEfHZPdXciVaFcYowfecM7UjgFRUfHDWo3AVGDhi3up6HrbPbJpN28tBErIH4BLT7vacgnGLJRPj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP/d0hru0suNzP5S19Y6sKKldXAJYvW898mYZ+3NH0Y=;
 b=yLkG5UiEyY3STgfWo1H0cN4kECTBJNUcooob6xORMqLRQLHbsOV989kJVaq2Bng8292DzhmV1Zp01p50UR37OIHMvW5S8JU65Tv/zvLeoBZnFQTYTjUQOhGQJCz3OyP5KSeyI7oEpLOKOPe/7D+2PzUa/9N4HhxCymWmlpMhfACjgdDGrWttrOYBEOrRSIUnfIRk9AziUnWGw466bL+dEdWSGu7cFDvmBHA7xX2Aeas8oWMpCddjdxnrfPItTF1KVhuT1wZqmJlzktsPQvmu4SlnCNoPBpsKiWEuiXWo/pU770oOxhJ+ks7aNRokzczG16s6Snggm7wcVh9+FtUv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP/d0hru0suNzP5S19Y6sKKldXAJYvW898mYZ+3NH0Y=;
 b=s7wsbe1EMthnTK51apABmL76wWsT8NhclmaeMVnKGucM5cyg0vRTi2KG3hb2eVEu36Oy/WAvcYDhZtyHUhnoKSqsY5hVlFX3VbZOruOw0jr34ElgwCl82NkVHhUl3Kk013soEEMjhnld1Xj3z8vSk5yHnbh2mOJBb1IZSm93ttQQ/9TH4Kft3ZXEz90Kd0ysEao/xKk11J5PuY3IqpgyXDhbUdKv0T7EGZtLdsiCxUZcrvrBKUgr7Ei1r5NS3l/CuGenCvhQj1Ym+Acbp3MsF2ePA4v2WgaeZfjF+2+z846rIPB/LSzQIgFzH4WZozd0gfxPY0OgNbU54Fx/YP1sdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 12:01:20 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 12:01:20 +0000
Message-ID: <5235d325-c33c-40cc-8304-b041b612e0e9@oss.nxp.com>
Date: Thu, 7 Nov 2024 14:00:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: linflexuart: add clock definitions
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chester Lin <chester62515@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>,
 imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241107114611.758433-1-ciprianmarian.costea@oss.nxp.com>
 <20241107114611.758433-2-ciprianmarian.costea@oss.nxp.com>
 <f16771dc-533d-43b9-8c04-6470191fd191@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <f16771dc-533d-43b9-8c04-6470191fd191@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0060.eurprd04.prod.outlook.com
 (2603:10a6:208:1::37) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf0fe90-87d5-4bf5-8f65-08dcff23e472
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3J4Znl6bm1SUEtrV3hpOHBKMWZGVmNMS05SR2hrM3VjZ0I2RWJiNjJkdjlD?=
 =?utf-8?B?UDBFcmZjSHFtQ2k1Y2NMc2ZsZ0ZLVWtvT3NjbkFmQTZlUkVwQzkvcnR0ODRW?=
 =?utf-8?B?TTVjMTE0alB5RlptZ1lPQ0xBQm5RTjFTc2RVRXBMYmxaS0c5d21EVVFQaXd5?=
 =?utf-8?B?cE1YOElSNFNKSFZJZjAwTTQ4Rk8yT0JDeTFwdEVHM3NBR2dtVE1MZGNMempS?=
 =?utf-8?B?aHFtUzRDUjJET0FWUGdrTmlxUC92RURhaGFZS0pUQ0VLZklIOE9xK1RiTmVK?=
 =?utf-8?B?bHVDSWlxL3l2Y1ppdVdiWEFoUXNRUy9DcnBydWdzR2FLdmpGenlSWFJ0WWNW?=
 =?utf-8?B?aUk2bFZ0Qmo4MGVXeVgvWHRKYzFzWFM0My9GZXNsOFFmRGt6akNLM2N5a3JB?=
 =?utf-8?B?S1FDNVBJc2JKOFd3a2t4bmtWUGhMTldTbFk5azJPS2JwdUd3cVZpV1RaRGNx?=
 =?utf-8?B?SGNkd2RzVnpyOUNHWFBuRm83OXAvd0ZtNi9xNkREWGpEd0QwNmQ3UmdLazhq?=
 =?utf-8?B?VVBYL3hIV3ROYkczckNuWG81ODNRWmRKb3h1QW56bm5pZUE5TEFyUXA4Mldq?=
 =?utf-8?B?TXR3eElkSUtJZkJMOG9CdmFlSWhOdDVSQXNWZGE0NXljQ2d3Q3pCdmF6SWNM?=
 =?utf-8?B?dHpybm1TcCtBa3YyN1p5OTJqMWUxRFNpcHBjZ3NxV3ZFRnUrZGN4K1VnZHJn?=
 =?utf-8?B?Q2l2aGlNTnE0dlNjcHN2R0Q2anVvSWs0cFllTGhCSUsrQ1NnNFk4VVRNazhL?=
 =?utf-8?B?eGw2Qkw1OUtqRHJUVlBRK3VjYmgzSHo5WWYyRjN0cVJ3c1kyYnlCdHY1QnMv?=
 =?utf-8?B?SmlrQThjSkRmU3ErTWE4NnZIY05HZFFVRVhZbDF0bEJBdnU3MkdROHUzTHoz?=
 =?utf-8?B?RkluREl1bjlkYzdCeHIwd1B5eU9qMzRVQjFQZGdDaVJJMnU4SDJqWE90SGFy?=
 =?utf-8?B?dExxNm90UndUWHlvREJXcWZnWGdMRFAwbGp3akpRVVhWSmRMcUxGTU03ek01?=
 =?utf-8?B?dEp5ZSsrbnpQUlArbVpyMkdrYUovMUROMkphb05tYnJQb0VsbFZ1YllEM203?=
 =?utf-8?B?NUxIUm11NHFnOWYvYjhBSk12enVtOFJ1UUFPQjdseW5nZ2dDdWRpM1dHNmZO?=
 =?utf-8?B?RFc0cEVlNjNNbUJiK0FnWkJJWGU1WG4vbk5XWUVOUlZISmJxZzNsZFBrTUF6?=
 =?utf-8?B?SDJsSWJhR0JXdUJ2UlFlcHlIUEpFUElNUlo2SzhzUXoyT2ZrbExPdHpuL2lG?=
 =?utf-8?B?c1RRSmQwQnBld0hhSzRBRlZ4ZHJRVTZRVGQzYnpNZi9PQ2tBN0hhMTYyVUNj?=
 =?utf-8?B?TFkzaUg1ZmhzZ0x0Tnlyd2k2bHlPWkpnOXFlV2Z1Y3VJMXpGa3ZPQXFoZXFp?=
 =?utf-8?B?SmxERDRGR0h5VXZZM2lGV3pvSGs4TTFsUzBBMUlaTldwbjh1ZDFBanJ2Vys3?=
 =?utf-8?B?OW83RnVYUzVEWHdLZExBZWhkLzdvM0RsVWM1a3RWTDloSCtoVGhITytsTTh3?=
 =?utf-8?B?eW5YbmVyU2JRc1lVa2JaUllJTTJzSmZ4RlpFQlI4WlZldHN1NjgzSERFYTZU?=
 =?utf-8?B?eHJRMVNsby9OM2lQY05qUTFkWHQyZVBySjhZYkd4WGRVUXJHM3ZOWDdUOERn?=
 =?utf-8?B?NTE1Y0twT1lUL3dmMExha29NbDZGWE53dk5RVUduenprdlF3VVBJT2cyL1ky?=
 =?utf-8?B?c0M4T25MR0NzYWRFN3pOMkNwS3JTYWg4RStHbnBmVm56NUZDb3JTSDVJNDdx?=
 =?utf-8?Q?uH8XQYtIFEBgLu9N0Uk/uSvPfOz7u++KFw3wHNj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFAzN0llUVdiMVdMOTdHNHRSSEQvL1M3TXpuUkZLOTV3ZjllaWJ1bkJVT2th?=
 =?utf-8?B?MEZsdjl6L29CRGdGOGVsOTBaQzlGUHhjTmcyOGl6Z2NXWWRhOStIN2FqQ2o5?=
 =?utf-8?B?Q2FaNUxZUUNqWmhPZnh6aDhOMlVQTVJvMUpPNmlkSmJueWU0ZERmQ2NUZlha?=
 =?utf-8?B?b2ZsQTZuR0NTc1dSbjlkOHoxc3h0RlNNZ2FZMDN4TXdZZHZrcUZOK2tHNm5y?=
 =?utf-8?B?Y0E0bzBRMmNxYlFkNTFkVHVxTjNZMC9uVVZpcHNiN0EzTmh2b1E3Sm9lT3Uy?=
 =?utf-8?B?RGlKTjlPLytTN25EdTFPZGw1VDUvL2xOcUovUHlNVWhGU3NpKzcyd0ZPYTNF?=
 =?utf-8?B?YnlrY1REQ1RldTZlaHRBMVZGejNVTzRHcGFaSElYaVJlUkxkVjFib1RTUEpX?=
 =?utf-8?B?YlRXTHVQZG5FNnBvc3R1ZzhhbkpMd0ppZGZiR1hoMjNoSFJ3bnpWSndiTkVC?=
 =?utf-8?B?VnM3QWdwaFViOVh3VnJlYjNlUWRVRmVWMkFvdjlLamRiU0Q1T0w3akxsY25U?=
 =?utf-8?B?NjVqaWZOSTRzZkc0UW40L1dxQXFVc25GYXhTamJBUnF6WGJEREZIVnZ1Mm8y?=
 =?utf-8?B?aHlFVDUwbkJTZmd0Y3JtS1F2TG5GYW92cEVNdGphd1MzdzU4Mk9tQWJLNnFT?=
 =?utf-8?B?VXBtYVgwbW1JdFZVUFhQTythaDlCeC9JT052SXc2U213ejhLdUdsYUxuMk5t?=
 =?utf-8?B?YkcwKzRVWlJiNlViaE5URTRMUXM5UG42dnZ3d0NiY0dkVGdPL2FYcWh3ZVJR?=
 =?utf-8?B?dFFNQUZiQk92VDdabkhwUlNlWStQdmZWM3RWZC9jSVVLb3VCK3ZLeCsvQW1w?=
 =?utf-8?B?THRYc1hIRDdOOEhaUm15Q1kzb3htcVZKMk5OcDFtdUpHd1BSUFRReXVXT1hN?=
 =?utf-8?B?NXNPRTk0OERpZ0E1a1c3TVVFWlN2RHlla2g3RVVTV1RoWWtXczdhdFBZa2x5?=
 =?utf-8?B?cmZnSVpvS3ZxeXNyZDRNWTBSL2hMSzBSVDdSOWl0WVpSN2x1Q1NtcjNvdGtm?=
 =?utf-8?B?aVgxZVFJeUFqU3ZoK3phRWlieDA0dzROSWdoMmRzTk1haFFlYlp4Q3YvMUY0?=
 =?utf-8?B?NCs2Z2xpaFRCUHRISm9od2ExOHpYcE9YMVNIY3pFZTl3b2hyaVZBczI3YzQz?=
 =?utf-8?B?SXQwRXd3Q0Q3YXJEWi83MmYwa2xUTTFFRTFKMno0enY5OXh3dDNtR0xUb3Nj?=
 =?utf-8?B?cjMxa1RiQmR1UmFqSlJwenJPMTFMVGxYekwxOU52N0VKV0lwSno2THdpR2Ft?=
 =?utf-8?B?N3EwNUpDOGlGL0hXK2xjOW02c2tIaWxwNkZOdFA1Wk8wSXp2d3dtR2hBa2VT?=
 =?utf-8?B?NjNsQmttVGZ6UlMyZDREOVJ3eCsrUUxSSHZhMEtXdWxUa3FZUkJsRjFlbWpF?=
 =?utf-8?B?R0xwUGlhUU5YMzZENENTcjd1ejhLa3dCeGZBcSthMzRJQXhhL3dJZm9uakln?=
 =?utf-8?B?MGhmeUI1eHNrdUs4V2hPUGlJSHJkTVlrVmRGenRST0RkK29Sc29qeGhaVkNL?=
 =?utf-8?B?Rm4yNHpCbHlNTGdVRk1SNEhYVXJ5U0hxejFwcWtqcG9YZitxMzB4SVFZSzJ0?=
 =?utf-8?B?czU4MHp5M3oxYkhGZkhyaXhETXZlNUNsREhlUUVSOXdJUENrV2d4MVRHejJY?=
 =?utf-8?B?SmcrazU2VWc1WUhwWENXeW9uU0xidDRQK2dJb2p5VkptK2NhaHFOQVZscmxV?=
 =?utf-8?B?cHRlWTFIdzl2REJidWlEdmFNcnptK0RWL01jQVU4NFFYZ1ZmN3VmM2FKTlBK?=
 =?utf-8?B?aUZuOXpubmxlS1dmODV2V2J3QmdjVkRMNkVhazRFYlNDOXNnNGVMV01qM3Z1?=
 =?utf-8?B?cGl3U1JWZUFLczJmSkRmNW51c08yT3JkSjRkVXZhZVV1eXlGTXRKVGRVREJl?=
 =?utf-8?B?RkFZRVFBeXpZcmdpa1hvT0Y2dTVMUS9Qa0Q3ZmwwcE9VdkFsWklxOUJrSjZl?=
 =?utf-8?B?bDhjSXVPMzRSemN0eWdaUHlqM2ZlYndvQXlmNDhVblhyb2lySGxnRmR3Q1pr?=
 =?utf-8?B?ZjZaa2hycmp0VE5JK3NrNHZPTHgvQ2QwWGZDK202U092ZmFpd2ZydmF0bDlX?=
 =?utf-8?B?MVoxdW5INWlTRk83MlFmVmRXRVpleDNyZ1pMMHMzSlpUMmNpZEErRGF2bmZq?=
 =?utf-8?B?eDZCN25GTWMvdGtxOURCejVTWkhQUWh0dmY2YVFleFprSG05SzFZYVBuc0Vi?=
 =?utf-8?Q?Gvh4xA/VBU9p+UV/n7NOPrE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf0fe90-87d5-4bf5-8f65-08dcff23e472
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:01:20.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjrxZeQZB5oKW7oDFBWLtQ2R8Frax62PvVWhq3IJWx0c2CRXXMvBghTx6hi360iiUKLLSCh2NwYgTmj94eTeKvoJMrfrd19MvEcNWUC4jqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8412

On 11/7/2024 1:53 PM, Krzysztof Kozlowski wrote:
> On 07/11/2024 12:46, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add clock definitions for NXP LINFlexD UART bindings
>> and update the binding examples with S32G2 node.
> 
> Why?
> 
> What you are doing we see easily from the diff. I do not see why. Your
> commit msg must explain this.
> 
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> Missing serial prefix and final is fsl,s32-linflexuart, not linflexuart
> 

Hello Krzysztof,

Thank you for your remarks. I will try to address them/add more context 
for these changes in V4.

Regards,
Ciprian

>> ---
>>   .../bindings/serial/fsl,s32-linflexuart.yaml  | 29 +++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>> index 4171f524a928..2716a9cd6c22 100644
>> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>> @@ -34,10 +34,24 @@ properties:
>>     interrupts:
>>       maxItems: 1
>>   
>> +  clocks:
>> +    items:
>> +      - description:
>> +          ipg clock drives the access to the LINFlexD
>> +          iomapped registers
>> +      - description: lin is the frequency of the baud clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ipg
>> +      - const: lin
>> +
>>   required:
>>     - compatible
>>     - reg
>>     - interrupts
>> +  - clocks
>> +  - clock-names
>>   
>>   unevaluatedProperties: false
>>   
>> @@ -47,4 +61,19 @@ examples:
>>           compatible = "fsl,s32v234-linflexuart";
>>           reg = <0x40053000 0x1000>;
>>           interrupts = <0 59 4>;
>> +        clocks = <&clks 132>, <&clks 131>;
>> +        clock-names = "ipg", "lin";
>> +    };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    serial@401c8000 {
>> +        compatible = "nxp,s32g2-linflexuart",
>> +                     "fsl,s32v234-linflexuart";
>> +        reg = <0x401c8000 0x3000>;
>> +        interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
>> +        clocks = <&clks 13>, <&clks 14>;
> 
> Nope, drop the example. Not explained why you need it and really no point.
> 
> Best regards,
> Krzysztof
> 

