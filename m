Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF25473E;
	Tue, 24 Sep 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191070; cv=fail; b=W6ocEePssJDbdkoCpBzm9xtW2n91Vs5Ib+OqCAQJ6fX6NQRQJM1hZf63PlYdL4TOWzplnJZB7kmSmqvZ1OLJGAKO/tNR3pScdA37QHONWOJz5iYV2qJNc9ww1s6fLF9fpXy8uQLs1z24HpF6+WMwOQYlnimLNR0p2o4jK4urqXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191070; c=relaxed/simple;
	bh=eMdzNZk3nb3IBmtExvpk9bsgqLDQr/62c7ZBok7GZ4s=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EFZPUuVJPqTqsCCHy4f6Zhw+HOPYXQqc2TTbKrR3h1ZLxlLRfOq7hEVBnU7nsLqHaSw5NsM2DWPJWzuJ95N6yGmXxbcBAg1KkakeG63QYh5YnzR64A3oC4Z4CT9swWRikwWUUkQUCO+o+KHXLK12kZ1ch/bgQywBjaiBe/jX/ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lj9tJSJs; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lj9tJSJs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWDDotcPw21tkuFJrHG3EcPMiOp46tDg6lsD1eTNdXi1OXGD8mM4JrNgFQANYhPvy+iWg0+wJwKhkk8AC8SU6ikeuEoS+6Q8TOgTkmBwBkf4rp62NSZ4vaggEkTw9o6ND7qH6qFun2FMN7d7EQSeb0G2fEfTE3C/4Tx5Jq/P0kqVU1JwUAT6BFv8K4xiQCcgNv8UCpQ/QX+Yo57gLM+pE+D8Qa+QpthChb+yvhA1NLczUEJyZdHicYBoZp5GvUNbcgEfWJ/umxqCFlkB5fyweqdjDvw1GXcidqLXzbmgojYAVcqyxLHI0JS2jZsGWqkMxmQa1o50uZM5ZxYJ5oo5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCGzklQXvLjaqawyHDSxQp9F9ReQLQRFCqa5F2ry9f4=;
 b=qppoYP4sayGN1jNWNdzeJ9eAnZABi44mwOm2dhGtnFZ7cZA6iNqTHiz680iZ76wIaCsCiUTPBcXeVn+RgaY4bAyshTsN84xfnI2ZXUk3f1jAIPSDLcAsNeRV1Ap8ZJp32QVJdBJZWZ1lQ0X96iP7hPKcLdpR6dj2j0hETIDtynhaTv50QH51lSqo9VSoXcfFOz+5dVpn/LyJiSokV2zb9GiTjucsbIPvWkB4s/Qswg+/QaUsb3DW1Ig3nXfkvYWI4Qi6UItePyUBEcP9MAQUZedm76FuQs6ZEAE4ZS49bDDrkIgC7bSL8rP/pVCdiXvg7xjWzEZEDmpBpVLwHOyCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCGzklQXvLjaqawyHDSxQp9F9ReQLQRFCqa5F2ry9f4=;
 b=lj9tJSJs1BFz6EpNkONU9+shJ3IsX517fJmm7v7ZvAM1F1JG8+UhzbavxxU6t71ETUCiwyG+WLYttKf7I32Ypajj8mSCUR38nHDYN+ECXDfkH+UKIYzNb07T/ID1PvktrcN0raI/2aKteDiZUEKsv/njkCM01nt60MvjzI1t4ve9Dod1DuKLhVjXPTyKiHV+keYC57g2R01TfVB7E0VFLb372lN32vH73Yo3yIg4wnqZB+M9TwSZeGyPDsg3BGScnyojQd0wMqpVB8jDnhtKZXxcxT875VvdD64/kN2srDgWwHlMf+Ya51We1RXqY7FnFC+zS/WgnldMKznmuhqDoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM8PR04MB7908.eurprd04.prod.outlook.com (2603:10a6:20b:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 15:17:40 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:17:40 +0000
Message-ID: <a043494e-0dd3-4db1-93c7-55f59dbe2d0f@oss.nxp.com>
Date: Tue, 24 Sep 2024 18:17:11 +0300
User-Agent: Mozilla Thunderbird
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: linflexuart: add clock definitions
To: Conor Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chester Lin <chester62515@gmail.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
 <20240924141247.132455-2-ciprianmarian.costea@oss.nxp.com>
 <20240924-twitch-embody-0ffb3ab7fd26@spud>
 <b8024c74-f5d7-4b56-96ea-dee5d8dd9a98@oss.nxp.com>
 <20240924-exposure-juiciness-c0e9a0c54854@spud>
Content-Language: en-US
In-Reply-To: <20240924-exposure-juiciness-c0e9a0c54854@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0033.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::20) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM8PR04MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a14c31-dcfd-4172-0c14-08dcdcac07a2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YndNR1pabDNmZm1PYTZPN3l6QVk1Z2xGUDExcGxLNEhnRC9jdjlCTzVCN3Nv?=
 =?utf-8?B?NkFCdUZNc3pYWi9oSFNMb1UvQ3Bza3QrWHBpaEtFaytKalpUNWdUM0NzSmp1?=
 =?utf-8?B?Vi9oaDEvL3BBVVNLakFWZXRiTkZaSy85ak1iVVhPWERsZG5IK2NsZmVOTzdH?=
 =?utf-8?B?NHpGeXJacDUrdFFkMGU3WEJMYk1UNFpkMGlXS2tidEcvVWlPdjRhUjVsWWt4?=
 =?utf-8?B?NnFWZERjOXJZSEROaGprcVBwQitoL2szdWFRbVNXamplZTVNTmxjYUNzM3Za?=
 =?utf-8?B?UUM3Y01rbW5McjQrdnFqVC9qei9VNWlzeDUwK3JzMHBtbW9oVWZvZEZFbnZ0?=
 =?utf-8?B?cDE0MTFBYTA3ayswSzQ3WERpTDFOcVhEUEMwcS9yaWhuVkRSakEzYXYvWG5C?=
 =?utf-8?B?UXZzaVpzTllpNVdTZG4wUVFtWWIxOWZLOEQzeE0yYmlnYVhndnVEamJKY0ZZ?=
 =?utf-8?B?ZGE4YmFEckhWR0w2UjhXVXJOV2dPczBZV1pzYlFLOU5PQ09YNGlGMktKYnYw?=
 =?utf-8?B?UmtpeGNaV24wUlBhS2NlUGdpeFUrS3p3dXFYUEJkdldkOWlKMUhCanpaQk4w?=
 =?utf-8?B?L3B6VjdsWEIxZ0hhRGhVeHIvTldGVXc3Rytka3BZTnhDanU0RGZCbmN1K1Jp?=
 =?utf-8?B?S1UxRXRBQVFVb0JtZ2xNYTdQMm5Ebkw0Z1V3N3FHeHFPY1MvdE1uZGVENysw?=
 =?utf-8?B?VlBpMlc4M2dvRTVSQzNCL0Q5YTJoVWpyMUNkRWFzalhPN1NrN0ZMT0ZDdFBj?=
 =?utf-8?B?SEdPQXFZUnc5RWtGOTd4Y2hBUHJtNnZZeWlqWFJNSjlwbjl1NDFPWCtjR25x?=
 =?utf-8?B?WmtmTnMveFRqU1BVcHdsbjM0ZlBvclRUNHNmdEpkZDZFRnpsM1N4S1VMc29l?=
 =?utf-8?B?bzkwYkxRN2pBY3YwTUVkUWlqWEtDMWR3cUFzcWpHSkhxUzI5a2d6T3NsRkZI?=
 =?utf-8?B?RVlmQ0c2VEo5endzUGhZeWNvOXc4QlBleUhLYUdaL0tyUERXSmlvaFNabVFo?=
 =?utf-8?B?VHNaYlBUanNhUTY3bTB5bFRqM0V6ZzRJNGNqSUkrME9NYnBWSVVOY0w3RERn?=
 =?utf-8?B?RkNLNmxtL0N3N3FOMzE0ZzlNa1FYVUN3ZEtGUWx2U1FTVDVueVU2UlpvRnhm?=
 =?utf-8?B?cHdtNzVoSEN4dW0xRC9VYzFIN3VlZkpWWGVoVkRSTnlRbnpya09zeDJlOHVX?=
 =?utf-8?B?b0JIaGsxQWFyOVdzRXlQUCtEcWQ3UUhzYWtuVTdBK05qYmZsU3ZRRC9PRjY2?=
 =?utf-8?B?NE5MZllMMjFjb0NaU3lpdnFTdW81aklxenYrZU9uY2d1T0xXRmZlcEpZNnht?=
 =?utf-8?B?NTB0Q2FqTDZSRmZqZ05yRVdaVHNvU0UzRmpuNDNyUnc3THNsTDdKN2tLMWlp?=
 =?utf-8?B?N2VRbm5oZWpROXFFR1pjUHkrQVZaMGFWbHQ1OHNUU1AxUEdZcGlEYkZ2VWRu?=
 =?utf-8?B?SDBLMU5zcEt5N1dPdXFYRVVlZjNvMFF3bWR5V2lteW5OMDFJUjNSdHUydFla?=
 =?utf-8?B?aEorSmpzOFkxdHFJSy8zR3hXN2t1djk0aHRiME5oOGgyeGdkMjh2Y3JGZExH?=
 =?utf-8?B?eWdKMi9RZHV0RFJXdUc0OGZianp3cFJYQ3YyMFB2eW9wbzdlRTA1dFh6L0NG?=
 =?utf-8?B?UGp5YzRDUEJHUldmdmVkbkZNTGZEYlYyK3l6SjNnejQ4YU1rYmE4L05RaTl0?=
 =?utf-8?B?Z2Q3N251UC9KYzJ2ZURUbWZ4YzZhbjZTc0F1MWVHYURvb2luZ3k2NXRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm1VMUU0MVBJNkZ5NzNOZ2VKekV6ZGx3bCtIR2xONzlBbHM4RDZId0xxOFdD?=
 =?utf-8?B?Y3hSa1ZBbkhvdkl3T1FLN0V1ajVPaEVvc1N6SGFDNElTdTQ5Zzh2RWg0ZUl6?=
 =?utf-8?B?eEVyRXViRlhKS0xHSVNqY0ZXblVVS00rcEhnNzlyd1pPMktackZVS2F6WG1E?=
 =?utf-8?B?QmJ4TGxTMURDZzBKdDR5UVhJOXRFbk5iYy9sQXVZNmxyZGc1R3J5K1E2Z25m?=
 =?utf-8?B?RlZMR1VwNEdXRWp0L0JDS3I4UCtRbkVwMnpLWGhIWnVJNjdGL1VTWWEvaWlq?=
 =?utf-8?B?ZkN6cWd0NktTUVM2UERiUW1hSVZySGVFd2R2RVdFdmRmdTlscjM0QWRHYUVn?=
 =?utf-8?B?OUZpWG80L0RtZjZKd3pjZ2R6d01zUUF3QUMxaWQ2UktHY1ZScGVlZWVaNVNN?=
 =?utf-8?B?YnZNa2Vjb1VYQTI5U3NHOEFueUIya2E0UkVvYnZwdytaZXVpNUUvN1A0T2t1?=
 =?utf-8?B?VGd1cGVESG5YRjlYY0E0SldWSHZOanNMTkoySHZCY2s2U3FFRUE0Ym1veStM?=
 =?utf-8?B?OHBQQmlPV2JLajliRFppelJYbkRMb3c5NjdlNGcyNFVjVGNvenlVTkMvcVlN?=
 =?utf-8?B?cW1CTXR2YXBZMjBnZ2dLNmk0RGVCSXYvVUs1aTBBbWJmZW13ZUJYazlLczla?=
 =?utf-8?B?a1VzbU1wNUk1ZFJuTXdrYnlxV1BFYVVJZk8yYlBZUHJ4TUxoRWhSUlRFckNG?=
 =?utf-8?B?V09TNVdaMklsRFpVTGZudXF5RFRKUFlDNVFGeWR4dHRnd09sOG9JN2d4ZDdV?=
 =?utf-8?B?a3V4RC8xVXRSRVJOcS9EUzRhbDRaRFF1Q1BPYkYyU1NjYUdOM3BzMXUwcXVw?=
 =?utf-8?B?aGRsK0lWVU93YmtYdU45bTBOb3FoZGZKenBxRDc1UkZkWFp4QlhKTXlHUyty?=
 =?utf-8?B?K25LUXhXNTUzT0JGT1J4MUtkL0RMTmc5bWQrejI0N2FRcW5yUUlXMWg5VE1a?=
 =?utf-8?B?SVVEeFBXaVZXYzBFb1JKSkpPNDVnaitTOFdjdWxrTlFqN1JVY1UwWDRTUHpn?=
 =?utf-8?B?L1FRcDIyZEVYazJLSDB3dUhOeHNNd2ZXVllrdERCS1dFcDNXL1ZhVktuNmNw?=
 =?utf-8?B?aDZ1di8waXlGR1BTYXkzckRBVkRKQlNKZ1JPT3ZxT3JlWGlJTlNqaVYydTNq?=
 =?utf-8?B?SVIrUFRjRVpMYlVGTHY0TWk5c1N2RHpOOEhOUHlia2RMTE5vMFJFN21Rd01M?=
 =?utf-8?B?SUJIdjd3UlYvb0RHRG1hRDN0TWNLT0JITUJkRHRkMDVlNnplOU5pQlVwQ0pD?=
 =?utf-8?B?TnhrTTZnSUMvTkhxSnVpK2VnMm9QRElaRlAyNE9LUGFFenhDaWJaZkZHZW1a?=
 =?utf-8?B?TnU4ZXp6OG9ocjRyb01iTm93a0lNRGNRaWZmbU9xbXI0L21EWkl4RmZ1cnFq?=
 =?utf-8?B?TnEvODdMZ1JHNjZGT1VnaEt3eDh4RHpWWDV3Ky9hdmF2cWpiK2M1ZmZPOWVp?=
 =?utf-8?B?VnZ1bFFOTGMvYWpPcnNXQ0x1dFIxQ2syTlNCMWxxYTllcHJ1aTg3Zy9Kb2wv?=
 =?utf-8?B?azNOK2l1ZmpEbitFNEIvWFhlcmY5dkhYMkR1UlZHWmYvdVBQNDVMa0o4alNk?=
 =?utf-8?B?bHFROEsrcTg2cU9OQjAwYWtmNXBJcGxDQXJPY1RkNGhsMnZKOXpVV2xUWW92?=
 =?utf-8?B?b2hkbzJIMXVMSXhSN3h5MnNsZFdVTzNFUVNWMTR4c3ZnVnFrTW82eERhWjda?=
 =?utf-8?B?ZkFaKzJBTUNxMVdhRDVsTGhMeXVFRldUcWhPVmRIU3pibU96UW1CNUp0MTB2?=
 =?utf-8?B?NjhZOFE4dEZjYnFlaUloNDFMZCtxWlFRS2Fvc25ScWk4QXBWMGp6T2JsMk5m?=
 =?utf-8?B?NGpZeEhwU3JFdWpydldsZjNnNFlTdGFkRHFQN0tZZUpDem5UcTREMEE2emxz?=
 =?utf-8?B?d1d4cGRjWmZVaGpwbUhzd29ta2JqZXJwU0FTYzRxSnJqWTF6N2Q2SUJENU1m?=
 =?utf-8?B?VGhvcnBjWmJSbjhQbTVkQTlNcEltZ1hYclFXKzk2TFBvZmdjMGpKUWNBa0tj?=
 =?utf-8?B?M1l1eEtUcG1SS2dKM2FuWUZrNEczZ1VncWYybVNMM2lOelZkTnA5dEhYT0dn?=
 =?utf-8?B?b05Zdm5GOVRTbjVBck5FeitCMW95NW1lNEhhWVpYenNQYkNXMFlDME5UejRB?=
 =?utf-8?B?NHJoNUJ1L1Z4Rjk2VHFzQXZqYkxxNUt0eEN3Ymh5R2NvbDVqNHZ6bXc4b3lR?=
 =?utf-8?Q?xq1Q5dCe5ZChRsdDJxbnaYs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a14c31-dcfd-4172-0c14-08dcdcac07a2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:17:40.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RE/h8uwYLuQ/Ttut6bB9DetaUoWuGsWDojTv+zN12nrqoWB0lsBHsfW9JQn0PIBtvK9RqCmn8gXKc3TC/md8IhmVI5umKrTzJGGqoiu2Gxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7908

On 9/24/2024 6:01 PM, Conor Dooley wrote:
> On Tue, Sep 24, 2024 at 05:52:13PM +0300, Ciprian Marian Costea wrote:
>> On 9/24/2024 5:24 PM, Conor Dooley wrote:
>>> On Tue, Sep 24, 2024 at 05:12:46PM +0300, Ciprian Costea wrote:
>>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>>
>>>> Add clock definitions for NXP LINFlexD UART bindings
>>>> and update the binding examples with S32G2 node.
>>>>
>>>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>> ---
>>>>    .../bindings/serial/fsl,s32-linflexuart.yaml  | 21 +++++++++++++++++++
>>>>    1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>>>> index 4171f524a928..45fcab9e186d 100644
>>>> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>>>> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>>>> @@ -34,6 +34,14 @@ properties:
>>>>      interrupts:
>>>>        maxItems: 1
>>>> +  clocks:
>>>> +    maxItems: 2
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: ipg
>>>> +      - const: lin
>>>
>>> Can all devices have 2 clocks, or just the s32g2?
>>>
>>
>> All devices (S32G2, S32G3 and S32V234) have 2 clocks for LINFlexD module.
> 
> I see. How come the driver is capable of working without them?
> 

The driver was working because the LINFlexD clocks were configured and 
kept enabled by the downstream bootloader (TF-A and U-Boot). This is not 
ideal since LINFlexD Linux driver should manage those clocks 
independently and not rely on a previous bootloader configuration (hence 
the need for this current patchset).

>> They are: "lin" which is the frequency of the baud clock and "ipg" which
>> drives the access to the LINFlexD iomapped registers.
> 
> It would be good to have an items list in the clocks property with that
> information.

Thanks for this suggestion. I would add such information in V2.



