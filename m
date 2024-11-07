Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4F212D2F;
	Thu,  7 Nov 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993980; cv=fail; b=g82OoHKw6fAD3BEtej7OftRbPzHrZUrFfBBQzKHSXWn8RwsPDjUPAzn62b7lM3ipiZeToVvbEomIGzrHbxLdbK1UAjzHEYAojLKHb4wiODmlIKgwwwfOjDbYkOlBPX6kRCGrEl388jvk2T7T1BIaaIwWeEEFo9XqI/ZO7xE1V0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993980; c=relaxed/simple;
	bh=7j5P1xGogcIcUl6Fq8ApFxuADb4Bed+pXOL4rhjcNQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j2uKhkbTPfC5IHaACEXu+YXTKU7wqw4i6qWofaC4v8HCM1itqda1FyWgX8n5bNmsjXzPS0+glPLSSKct5UNAp3xvXPh1jk9JwXbJIBUKJzaRkXgdZGf/sO3XdE1pe2h3QQllaJwtEFHhYBRIdFTMcLnNSdGUjfPy9TgQaM43BMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cLBfLwN2; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cLBfLwN2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cemg6WoWZPyEctu/SB0+KklAzda6JFjS3b+MZh0A7zWZ5jI8SIeXo7BEwRoQJqj0I/1GnjYgx+vuvxD45ckQZO9/4kkHtEPFhHUDgfndGtmZI1r118lBf99TOOjXe0BYCP8Mttce1uq1/rpLOFKxjEEZc3IP0uNFCkEN41mOiKldp9EfwYBqLcJ6Dquf9tGFgQcOFlx+DKMpLhx7IrgsIGWzSnu8u41RKJsSbN8SOtxN46bcv/wWxEQFJl9Ip4mwAHFKA88QSkqyCIgIhfxfUYdZW5IbKE7xbdVWxPHhg3uo6s8faRsbA8n2urygdbjv+cf7LqLPuId2bjM/I3jU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIBNwOxJRHPHDG0vlFDdG47+afw9IX6N7JGvX8qGzpE=;
 b=JETNRoue1qgXPU2KeD/BUt7pNF30z5vnGrkW/TN00Y1OSqNTeip12Le+ydw9XpVvT1jYJUsZ+is0eLhhTBPVH5QbvM+I7cW8lry8p5/sKdx/HSnJpV5Qf0F3oEUAia6y8+wnsTgc13h1QBhZ8BiuDjuOv2CGv9tQGNcRZba4i0F0LS7L4vBhgRg05rnopsOGtLPqkNTLVfTTod9KirBzDCXM1jWg+Frp/skCXqUmIK7pMClBcZWwd9LeBFe9AEosQ74iqxeLNAfKfFoeL/Cwn2VAd72C73O0k9+f2lsjtj5ku9zgJl1qQPqXkZgMuMLHS58LS+ZSVlmUkN3O1HxAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIBNwOxJRHPHDG0vlFDdG47+afw9IX6N7JGvX8qGzpE=;
 b=cLBfLwN2SayWMSO2LgCFmNF54X2s44FowbNfOT4IKT/g7bzF6YIFAET6Zn3frXbBELLBZp6Q+SOV8lvD2iRVbP+8qB7zEnf+L6s2jEXKKXv+pabvUo6t3+UzRvH1Zk+sSOtbB9EMaVRuCD4Cf4UN+4bQhdGwbnxx+quA4nf9MclPSXSGUL4Msp0atqcsrJxxw30gASPO09eFE2gv3i5bKXP4h6yko/xAmZ1EcnZQ2QvQDwcqHt86kOZ2HvnHaESyaHdN1bkn2rB1ABz3UP6NhdLlCGgwg/EyYW50UFEiCnWRj3To8++nuerXAD2rSjyesUUriisnI003Rq42FGnPjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB9925.eurprd04.prod.outlook.com (2603:10a6:150:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 15:39:32 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 15:39:31 +0000
Message-ID: <8ff82818-8922-4aab-a0b9-31a5510d54ee@oss.nxp.com>
Date: Thu, 7 Nov 2024 17:39:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] serial: fsl_linflexuart: add clock support
To: Frank Li <Frank.li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chester Lin <chester62515@gmail.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>,
 imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241107114611.758433-1-ciprianmarian.costea@oss.nxp.com>
 <20241107114611.758433-3-ciprianmarian.costea@oss.nxp.com>
 <ZyzaZtBTW4Gd6k2X@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <ZyzaZtBTW4Gd6k2X@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::15) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GVXPR04MB9925:EE_
X-MS-Office365-Filtering-Correlation-Id: 90542e39-42bc-4a3a-b770-08dcff425f83
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDNyZE1sSGVROHE5eVRRNGx4YnoyNmlGT0h1TTJEV3NLVEV1Uk8yOG1ub0Qr?=
 =?utf-8?B?elhpQ0Zoek5CdnZVekErSVpVNDZIN3JrUDZ5VGtIeWZwOElUeGpKK0xJZnh1?=
 =?utf-8?B?ZnZmV2xnSVpVVDNUOEMxWGZiYUxjRmZSZWpUazRCNmJNRHUwdStxNENpS3RK?=
 =?utf-8?B?b1ZoMVRXdG5qNTRKeFlsLy9XREpPbTVBd1JGVU5qMlJoTm0xcE9DeXFGc3FS?=
 =?utf-8?B?L25JWnNkcDZvZFpsWHc0TjhpcUF1cHdJMW5RSDJNWlU4MkxJY2NsclliRm5J?=
 =?utf-8?B?VVJYNVdhdXpWWm8rUmQ2b2lzUnFkK3orWVdRYkhtL2prTklVMTRIZ09JQmlr?=
 =?utf-8?B?WjNPdndFMHJpZzVybkF6ODlXSEw2eXVtSWxsZWUrdk1iNVNrM2ROZngvTE1K?=
 =?utf-8?B?cGFMZ3p0ekpnb3BvT2ZGQzlGb010eEYxVVJCZmVWWGkwcTBIR1hvRTBpd0o1?=
 =?utf-8?B?dE80Q0dDS01ueGlrQzlza1NoSk84TGVQOGVZcnA1Q2xhMXhyV0VQV2t0NUVN?=
 =?utf-8?B?ZVJCOE82by9TNy9Fdm1wWWRtUHFneEw5NkQ5Q2trR3dkTUhjTmlRRFZZWXdl?=
 =?utf-8?B?Mkl1ZTJMd1pXc1R4eHNDbUxYU1dpYVJoY0FKNEswNVRWampDTkdvNU41UXVr?=
 =?utf-8?B?dmFCUFZZczQ5aFlqQUlaTy9rTDF5TkowN0dpTzRNOXVGN3kxWFVUaXZIVHUw?=
 =?utf-8?B?UnV3d1p1ZTVSdldySGJtSEZmSTZKVFZSZmZTV1o1b2lNQ1FENDBBNDNBK2sy?=
 =?utf-8?B?RFV5aWF3QU5vcWZPUUVNYmhCbURMRWZ2YStUZ1NJZ3hSbXNIQ2lWVXU2cWl4?=
 =?utf-8?B?UFcva2FoYmRKM0FHWWJLVmJLMXBTalIrZ2dobmx0ZTlVSk1maEx6SjBzOHAy?=
 =?utf-8?B?em9abW5wSTNjdkZWa0VyY1EvcDlXckJmZnR4NjJKT2lZYksxMzdLOC9OUDla?=
 =?utf-8?B?cmQ4ZlJCV2Q1VXpWdTY0Myt3L09qNndjeDYwYUw4ZW1HaTQ2VTRnTlEwdXpX?=
 =?utf-8?B?RE1pNHV4LzVKTWRhdUVLN2drOERlWERVMzRDZlN6SGVlelJ0L1ZjWlpSa0Fk?=
 =?utf-8?B?djlvektGcTRMVWxRTWdSSUlLTEZQaENXbTBjS01US1RGSGdEbjF1b0VYMk5o?=
 =?utf-8?B?dURXME9WMUFjY2IySTFuaVJKMUFGblRxcUJmaE5lSnJielR2Umxsbis2cGJw?=
 =?utf-8?B?Z1BSS3BYQm5nMGd6OFNlSEpMdkFpNXFPVzhMdWRBNXhNcWFDaStqUmRucDlY?=
 =?utf-8?B?emZaY1o4dEZRZHJ3eUZORjNKOU9vSkZabjd3eFVVeU1wb3lkY1BiYzkxa0Rv?=
 =?utf-8?B?K1JjU1lQdGtEbVB6NW5LUVB1aVZlaWQ3cVFqSk1LejhnSnBITW96RGxsRXFQ?=
 =?utf-8?B?dUlmOUpmSW44RWRXQnVNZmlscEdVSTVDS3JYcDdldlUwajEzd2ppYVBXcEhU?=
 =?utf-8?B?U0tYbVpBd1dBcEdoSkFqaHk2WUxidlc4amFHcms3MFBaQm0yOVplZmZzd2lT?=
 =?utf-8?B?S2k3Nm5XZjN6N1dkVFRUTlptMUFZZnlaQUl6bnE2d1ZaSEYrT3RlRU80Ky9H?=
 =?utf-8?B?VXFoOUxpK2NTREVlWWFxVUtvVGk3T2lYV2hIUXR4ek5mOVdpN1IxM0o0NWh3?=
 =?utf-8?B?SVFQQ1ZzejBCZnZEanpzcnRFUStjdTVqQUpUTXBFeEk2c0tpaVNrSlQ1K2FZ?=
 =?utf-8?B?eUpoRWlVbjhKaDdBQWViZnNPVU5KQU41TmVLSTR2eE16bktUcDV1aktWTjRm?=
 =?utf-8?Q?I9sfv6NVd72JD4Fju3gzCejfXqzp0xX4FwN56qj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFjcjBZRjVGTHArNDhNVi9idVB4VDdhQVdqbFJ0bE94MVYrRnVzUUxYZDRH?=
 =?utf-8?B?d25scVAvSWNUajU5RmtjK2NiZjBLTXgxbm1mMTFvWGFHWTlCQ2NoeWZHR3I1?=
 =?utf-8?B?S3Y2R1c2UG1vazMwYy9JV0loaERoM0pUaEh3cVpXNEVvUXNUam1nZkJEYUdV?=
 =?utf-8?B?WlNIV3FDTlVjcWxlSUliemRZUEhHNm9mQVVGOWp4SGE5UmtFM09XNW5VRzF4?=
 =?utf-8?B?WkJ6bUloSHVDQnZpYXVuTWtXdEc4QkR0U3luUDllNXRIK0ZqWW85SWw3bGJI?=
 =?utf-8?B?SWIraUY0MFc2d2VtdVRkbUNnR2tJdWRkUzJvTTA1aHkwOGE3RmtDeVNSWVhT?=
 =?utf-8?B?SE4rb01sczBodisrMjJxeFFuNlVhS0R4MUNxZ1htczE3Tkhpc1h3V0pRb3BS?=
 =?utf-8?B?Ulg5T04zekJNUW9ZRGcxUUxOaU1IMDZLb1JsaG5Jdk9Gc3F4VGo1YlU1cGZ3?=
 =?utf-8?B?TUI3S1QzTHpBaVdRWkk5RFJDd3Bid2htZDhJa3pPYzNPM3JjQWUyTjd5ekNr?=
 =?utf-8?B?bmRPYm5hcEZrNE84WEN1NGwwSXpJWmtlUjlqUHhuNXE0WFc4Wm04cWZKY1Zo?=
 =?utf-8?B?M2lTbTVhckRrQjdMY0R5Yk5mRFdHelpjMlpmaUV0clJ1YVdud3llV0Y5M1R1?=
 =?utf-8?B?cFNjZEwvdE41d3F0QklQUDk1VHFTWDZkekIybWpXUzN4Z0hKZmJaeUJ3T1pH?=
 =?utf-8?B?czNVWlMyWXRFSGVaR0VsNlZBR3VINzYvd1FJdzBzTDlITFpzNDFYTzJZWVIr?=
 =?utf-8?B?N1VCVE5YR3hxcjZDR2lTaXpJLzlDT0tmVVQ4TTJramFDVWdBRnpCbHRvRVNm?=
 =?utf-8?B?TDBMYm5mWTMrdVZvSWQ4M09LM3Bvck11TFVGWmJQZFpYQ29oSHpDU096bjZY?=
 =?utf-8?B?bjdVNDA5RDJvdXJGckpjVHI1cThsWEJrb1p3NlZKeVJya0VRdGNmbCtkby9t?=
 =?utf-8?B?Qy9OYVNmcUdQZTZUWHBOZExDM2V2TFpEQkt3ZG9QRmJqWTYxcHBUMlFkNUtM?=
 =?utf-8?B?RDF6NFZ5L2hldGJFV3BpU3l1ZDFHcXo4bjhuK25Fd3JGMDNrRnFBS3ZtVlRO?=
 =?utf-8?B?cTNrZmJiRUw3NlZLeXdqZnlTNFpaeGx6STY5eFVFbW5jaExud1ROaVlvSjZj?=
 =?utf-8?B?dGs4WUN5bmZnWlk2RWN6eVVBTWFSdHBseFZYTEc1RjhmNS9oc29GRFZCMU82?=
 =?utf-8?B?VEhRazdWKzY1bi9mSzE0RURrdFVKUXVFdVh3RXN5ckQxbnJKZTd3czl2NzFk?=
 =?utf-8?B?cHUwNllpMzAwQnh0eFBOMWlWa080VDBheUVyNkF4MEFudGNva3ZwdTJYREdW?=
 =?utf-8?B?YitGN3ZYQWczdmNqNUJENGdmU1VzZ0FVRDUzNjRxZTlGQi9LbmJWbGF6SWh6?=
 =?utf-8?B?aVRhczNaQUxhcXE0RE5iS1YrbjdSUGJ4ZStodGtlRzJNcHM2NDhGVjhvV3o3?=
 =?utf-8?B?NEY1aElqR2E1RzNWVFR2RDEwUzQ3WmVxMjlPVDZRMi8yYmpqZGRkVkQzRWUx?=
 =?utf-8?B?UmZhZWtvVzlKWXVTRUdaQWVJU3J1YWVtanZFQWZwcXI2dEZFcHgyTExYblZp?=
 =?utf-8?B?K0VmUUFvRmVveExDNmJhTGxrVmI4Q01QczRNMVcxVGs4ZDhSb3Z4TTVsZlVD?=
 =?utf-8?B?WEVvUFBxVEZDck9abnoxWUNPcXF1NnBiTzVHbHoreGpSZjNjWFYreXFGZHdn?=
 =?utf-8?B?V3pvZlZTY2grakFMaloveGhNelNlckk1RVByOXZMSURjWUswZDR2V2Rodzdu?=
 =?utf-8?B?VjhKL1ZRazZ1WnRqM3ZOVmdFNHYraEhVWnpCN1VwckJUUWZBSCtOMnFIa0c1?=
 =?utf-8?B?VUVSSDViTEFCRnJFcmk1T1o4UlAyeStVeHNUYnE2SVowVUpXZC9tMTJ1Z3Rs?=
 =?utf-8?B?SDd3dk5acnVDYUR4b3JUMTd0cFdNYUlST0xtZFNmcmkxd3FKTWUycFdaK2RP?=
 =?utf-8?B?MXMxZ3BHVVVtc3pIN1ZYYVh0TDBlUmFxZWswMUgxTjdYV0hMV2djOVdVMStI?=
 =?utf-8?B?a1ljSlVwNGl4RVZtbHNUMGRrcFVWalZnREQ2WUhZYWxHVEtHbXZ1VWVHM2o4?=
 =?utf-8?B?K0ZMdEMzNTYyTkhiUkYrMmh3YnN0T0xLYXpqc3JxTjdYSmpFMUd5a2ZGTmRO?=
 =?utf-8?B?elkweUdVdmpOa1kySSszOC8rZEtYemFIRm9odk56YmV2QzhKYmFxOFVpS1JW?=
 =?utf-8?Q?otwf2i4Vzmizfwn9FwM/d3o=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90542e39-42bc-4a3a-b770-08dcff425f83
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 15:39:31.8052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYXIJ6F3NWUjvddY2YOMeKR3QyHRELSiDHjWL+ZI/hwl9R5MnLyMSvVDhxdhlNo65jlRjXQ/mXLjoUXaBhr1l3NVMTUXkHYFsRdnI93DIx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9925

On 11/7/2024 5:19 PM, Frank Li wrote:

Hello Frank,

Thank your for your review.

> On Thu, Nov 07, 2024 at 01:46:11PM +0200, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add clocking support to the NXP LINFlexD UART driver.
>> It is used by S32G2 and S32G3 SoCs.
>> Clocking support is added as optional in order to not break
>> existing support for S32V234 SoC.
> 
> wrap at 75 char.
> 
> Add optional clock 'lin' and 'ipg' support to NXP LINFlexD UART driver,
> which used by S22G2 and S32G3.
>
I will address this in V4.

>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/tty/serial/fsl_linflexuart.c | 67 +++++++++++++++++++++-------
>>   1 file changed, 51 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
>> index e972df4b188d..23aed3bbff6c 100644
>> --- a/drivers/tty/serial/fsl_linflexuart.c
>> +++ b/drivers/tty/serial/fsl_linflexuart.c
>> @@ -3,9 +3,10 @@
>>    * Freescale LINFlexD UART serial port driver
>>    *
>>    * Copyright 2012-2016 Freescale Semiconductor, Inc.
>> - * Copyright 2017-2019 NXP
>> + * Copyright 2017-2019, 2024 NXP
>>    */
>>
>> +#include <linux/clk.h>
>>   #include <linux/console.h>
>>   #include <linux/io.h>
>>   #include <linux/irq.h>
>> @@ -120,6 +121,12 @@
>>
>>   #define PREINIT_DELAY			2000 /* us */
>>
>> +struct linflex_port {
>> +	struct uart_port port;
>> +	struct clk *clk_lin;
>> +	struct clk *clk_ipg;
> 
> Please clk bulk
> 

Thank you for this suggestion. I will switch to 'clk bulk' api usage in V4.

>> +};
>> +
>>   static const struct of_device_id linflex_dt_ids[] = {
>>   	{
>>   		.compatible = "fsl,s32v234-linflexuart",
>> @@ -807,12 +814,13 @@ static struct uart_driver linflex_reg = {
>>   static int linflex_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node *np = pdev->dev.of_node;
>> +	struct linflex_port *lfport;
>>   	struct uart_port *sport;
>>   	struct resource *res;
>>   	int ret;
>>
>> -	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
>> -	if (!sport)
>> +	lfport = devm_kzalloc(&pdev->dev, sizeof(*lfport), GFP_KERNEL);
>> +	if (!lfport)
>>   		return -ENOMEM;
>>
>>   	ret = of_alias_get_id(np, "serial");
>> @@ -826,6 +834,7 @@ static int linflex_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   	}
>>
>> +	sport = &lfport->port;
>>   	sport->line = ret;
>>
>>   	sport->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> @@ -844,39 +853,65 @@ static int linflex_probe(struct platform_device *pdev)
>>   	sport->flags = UPF_BOOT_AUTOCONF;
>>   	sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
>>
>> -	linflex_ports[sport->line] = sport;
>> +	lfport->clk_lin = devm_clk_get_optional_enabled(&pdev->dev, "lin");
>> +	if (IS_ERR(lfport->clk_lin))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(lfport->clk_lin),
>> +				"Failed to get linflexuart clk\n");
>>
>> -	platform_set_drvdata(pdev, sport);
>> +	lfport->clk_ipg = devm_clk_get_optional_enabled(&pdev->dev, "ipg");
>> +	if (IS_ERR(lfport->clk_ipg))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(lfport->clk_ipg),
>> +				"Failed to get linflexuart ipg clk\n");
>> +
> 
> use clk bulk API to simple code. >

Thanks. I will switch to 'clk_bulk' in V4.

>> +	linflex_ports[sport->line] = sport;
>> +	platform_set_drvdata(pdev, lfport);
>>
>>   	return uart_add_one_port(&linflex_reg, sport);
>>   }
>>
>>   static void linflex_remove(struct platform_device *pdev)
>>   {
>> -	struct uart_port *sport = platform_get_drvdata(pdev);
>> +	struct linflex_port *lfport = platform_get_drvdata(pdev);
>>
>> -	uart_remove_one_port(&linflex_reg, sport);
>> +	uart_remove_one_port(&linflex_reg, &lfport->port);
>>   }
>>
>> -#ifdef CONFIG_PM_SLEEP
> 
> Not related change. If change CONFIG_PM, please use sperate patch.
> Please ref
> https://lore.kernel.org/imx/1713848917-13380-1-git-send-email-shengjiu.wang@nxp.com/
> 

Ok. I will consider not making any PM cosmetic changes/refactor in this 
patchset.

>> -static int linflex_suspend(struct device *dev)
>> +static int __maybe_unused linflex_suspend(struct device *dev)
>>   {
>> -	struct uart_port *sport = dev_get_drvdata(dev);
>> +	struct linflex_port *lfport = dev_get_drvdata(dev);
>> +
>> +	uart_suspend_port(&linflex_reg, &lfport->port);
>>
>> -	uart_suspend_port(&linflex_reg, sport);
>> +	clk_disable_unprepare(lfport->clk_lin);
>> +	clk_disable_unprepare(lfport->clk_ipg);
>>
>>   	return 0;
>>   }
>>
>> -static int linflex_resume(struct device *dev)
>> +static int __maybe_unused linflex_resume(struct device *dev)
>>   {
>> -	struct uart_port *sport = dev_get_drvdata(dev);
>> +	struct linflex_port *lfport = dev_get_drvdata(dev);
>> +	int ret;
>>
>> -	uart_resume_port(&linflex_reg, sport);
>> +	if (lfport->clk_lin) {
>> +		ret = clk_prepare_enable(lfport->clk_lin);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable linflexuart clk: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>>
>> -	return 0;
>> +	if (lfport->clk_ipg) {
>> +		ret = clk_prepare_enable(lfport->clk_ipg);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable linflexuart ipg clk: %d\n", ret);
>> +			clk_disable_unprepare(lfport->clk_lin);
>> +			return ret;
>> +		}
>> +	}
> 
> use clk bulk api.

Yes, I will update accordingly in V4.

Best Regards,
Ciprian

> 
>> +
>> +	return uart_resume_port(&linflex_reg, &lfport->port);
>>   }
>> -#endif
>>
>>   static SIMPLE_DEV_PM_OPS(linflex_pm_ops, linflex_suspend, linflex_resume);
>>
>> --
>> 2.45.2
>>

