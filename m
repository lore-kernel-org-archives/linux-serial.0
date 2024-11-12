Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D020968C;
	Tue, 12 Nov 2024 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433006; cv=fail; b=RcYVv36vDOjjS1mSKNCxGBFVlc30CKaHpMs4hW2gnNkuX3obdA0GwNi7HXkfJO0dXLGQvksio77+wvtPgxYLmx0UP+Q3/HpNOt7+PUo4HK+WfWteEHWSDwbZ8I5y4Gx6AB4PKQjiKKoDq+d8+umY1Js/Nsxx+4e6KN56YSLa/ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433006; c=relaxed/simple;
	bh=K+NiXQNO+6rkYO3f02cmmRDS1pI7yWDuO/hl+r+cOmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QQVirqKAGnR5ZYdPNcsRXa+PJZtER+snb7j0d51HZe6x224FJ0oafX2zqws0tFzYRzrPY6Ysx9lap5aJQXLaLqTXPl/yjjone7j5cGUmoMVHNq5Lyd77Hg1aSEo3QDzm+LCaFOKksTwCXLMeRnkeC1NWlSRzJWGNsHnuNLKO9tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=T6VRVWTa; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T6VRVWTa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+pPG6U0B40RvgHI8T85pY0IqTh2hkPMDWQ+tTKgRp00XCfQMbhe5Xt+gZ80kXZh1vibRzil9J5LKIcinFsPwuWNLhH5dW9/7mhqMl7771cXbLiiNr1HvFcf3DIyaFqgiRP4IsekVsg+s+jc70sVkLPwZsRvwxSJj/ixZWTtmMTvNGvcZNbKVhtIEBPISorKq3posK3kMX6AdexwBnX+Oj1o4OmpXj7PbdsuhzHhWN3gufjQDudU8kcut/Ddq4RQ1HztNYPDTy1xP1MLjN6aUXfccaQqcoUf0OBeRbemyTp7sDShVcbbRjMR3wdMUVUHvynR9bqNcQaXWgw60v96QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJteIlO79Y2rWFPXDocP4+6BR4BIfRzr/YKUuRAX+TA=;
 b=hDyPv0toobXSnRB25MDh66uqXzOs3vDhfS1XelUp0zDH6aYU7s+fdlUPDoNWI9XNQc+gVonbD8WQYUM+lwd8XsoxSrVT1z8w8vtnVPMW7qBVoGENOKKKabkUVJELZ21DSTD6ECF4fttNKazq4YS591ISqYvTZrUW8dhADSylUygUIPhg+b+6dwDaMO93nbs6Mod9FLN9B9CBewWZz49C6kY+hV5DkYFIv16RXZjVwhDCocLcc1dXyJcWvWshd14fTnLVPwcC1ezAd2lqf+CS/iaIx4APlixxbGRRUANJW6PvbUuOIlVoecN5yzoS9Xp4sX9zzWGLGaTDSvcI0xKr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJteIlO79Y2rWFPXDocP4+6BR4BIfRzr/YKUuRAX+TA=;
 b=T6VRVWTa2Q5awhwYKBqGq7F6HGiY4Zz5cWb9IRVuZPpv3O+cCmmCbfzGZBq/4tC2xgA5/m61UFU/U/MiTNn9E5RJNWoIx/re8ZdMuQ0EtBPbXYIoONtnlWdLzoIg9ZqKkKmYatmMj4yM4E97LY35O8kj3SOTmD30GKn+oK028hLULAIuHWDg7RyvSUlhlUJJ0H33m6va0Sbvxuz9CDQ49AM+XUdPMQ3KTCLlomXcq98rvWOU8U7yhryhI5OlFxgdcpzIp62Iqo9GNeu/7fpQyaiWIGqinsgUjnNZ8wFzCL+O1cQu2TmrcznTNWC1nlUiQHbC6Vi26Buu1Y2DuG4oEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 17:36:40 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8137.018; Tue, 12 Nov 2024
 17:36:40 +0000
Message-ID: <da1b454f-087c-489d-a967-7ab88d3a534a@oss.nxp.com>
Date: Tue, 12 Nov 2024 19:36:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] serial: fsl_linflexuart: add clock management
To: Frank Li <Frank.li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chester Lin <chester62515@gmail.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev, NXP S32 Linux
 <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241111112921.2411242-1-ciprianmarian.costea@oss.nxp.com>
 <20241111112921.2411242-3-ciprianmarian.costea@oss.nxp.com>
 <ZzJ9wWvfmIc0taq8@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <ZzJ9wWvfmIc0taq8@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0068.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::28) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b95fba2-c2ce-4658-00eb-08dd034090b1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXNrN2hxOVJZcEs1eG0zdDR3RENjMjdQQUowVEV5eGFpUmNIVFNSaWhVYlZ2?=
 =?utf-8?B?OWRLbFd5aWZod09XaHBRU202YWx6SnZ0dXZlK3Y0cU1XWDQ0YStFSWlQckJ6?=
 =?utf-8?B?ZXVpbWlCKzF4aEZER05FQTNRN2k0azFGeTVydXc5eFlDak9BR0hLT0dmYzNv?=
 =?utf-8?B?ZjY5UHJCQXBlMjNUWlhpV2c3aHIwVFBOYmN0YWNhWnpONVEvOXZqZ29uOWNs?=
 =?utf-8?B?ZFhWbTNFRitTQzFLeXFSdnozTkdlN1lndFZxT2xSRDBUQzh2MVpiaitnY3k5?=
 =?utf-8?B?Y3IxL05tcmthaXBwd2JlQ0o3bFZUN0xiMEtvWjhZeDQ3dGJXRjdkZzlWQzlK?=
 =?utf-8?B?bjdjSHF5ZUtUT1ZSYVVoNml6a3BPY3g2UmgzdTFGVGpSL0NRSU9LL2Rmb2dq?=
 =?utf-8?B?R3N0M0g0NUx3REhTSTJWQkNXb3BLOVVWVEwyS3hHVHJpQ1BBa1NjMW04UDZt?=
 =?utf-8?B?azJTcUdwdVNsTXQxejZLS3crbnp4UGFZN3NuQ2dXQ3BEbkVKbmRIc0tKeXVH?=
 =?utf-8?B?Q3IrL29xV2lSSTNMVG15b0FaWFhrT29kcStKOWM3WkhDYU9LMFdTeHp1aEkz?=
 =?utf-8?B?YlZBU0phNUdJUkV0YitWMWVvUERuU0xNQzB2eUtnc1VUa0hPVkFTZm1QYWla?=
 =?utf-8?B?dzBlUG9McVN6WGEzRVB3NUdLUU1ycFlKRDdQdmFub2p6RDkvYW54V0hIUkIr?=
 =?utf-8?B?R2g0K051ODFlM1RRZEZEWm5yQUt1M1oxcllxU2k4OWlEeXY3cUR0SnYxS3dF?=
 =?utf-8?B?UExKQkxDaVE0S1o1empjZ1hXeW9hU3JxUkhSTzZZckszRGhENFA2cjY1bW5p?=
 =?utf-8?B?QzR1WkNTRHhOQ0dsakFIWC9iUlJRWU1zSEt5V3FXQUg3M2Uvbk5JbzVvcjRK?=
 =?utf-8?B?eWJMRlZzUUFiSVZ3aEo4eGd2ejBiZUx6VXZPVC9GQ2VzVDBMMm16YXhEdGty?=
 =?utf-8?B?T2NGNFRsbExJVG9naHNKSVNMSE9iaXE1czJvczhPenpwUnpCUlNjNCtwcDdp?=
 =?utf-8?B?UGpsN3M5bXVzd2FIcS9nTVBocEhVS0d2QzhGZEE4ak96SlhQRG9LamRsaTEv?=
 =?utf-8?B?WitMVXBFam5tbXlQdlFqb1NXWUZOdEdWR2JnYm9ocklXYXYxek5IMzdoWWRU?=
 =?utf-8?B?MHlhUkhLZDhZeWxXeVZVcmlFdVdjYzUxSEdWcXNHeWZCdXlMa0puTGJ6ZlFX?=
 =?utf-8?B?N3NLRkUwTW8vdTd4WUNDdERnVkFCdXg4Nm1lcGxlSkZ6MG90d0MvOEZjVmh5?=
 =?utf-8?B?STJBOTUrOHViYmtUT0lxNXgxT1JoUVhDTEc4YVVvNzNMb1psaVovd1ZBUTBR?=
 =?utf-8?B?R0xWK0wzNko1d0NOYWRZbi9SYTF3cVAwNzR2RzZ0VUgrdzdhWjkwd1VXcjZs?=
 =?utf-8?B?L1N1RytSUXM3YlEyYjljYWdoUGE4bEdFaUs0RmlhV0ZMK1hpcUVHSmN1cWwz?=
 =?utf-8?B?YWlUaDNXb0xwR2ZVS2VzNmFRUWJGV2NXM3hJRFJnY09oa09zK1JMTjdjNGtS?=
 =?utf-8?B?VG9PRm94NitjQ3UrV01EdnpHNE5SaVdpeCtzOTB4SGJyV0NqTDNpTVkxQXBj?=
 =?utf-8?B?cEFSb2I1MGk2Q2lUelFHV2dyWkNCSUtmKzBvUDFtb09DRVc3VzdWREF5eStU?=
 =?utf-8?B?Y1BKd1NEaXNMYnlaSko4THNReVJYdVZnWmtRVmlOMHptZVVVNW5pR0R0dm5j?=
 =?utf-8?B?TWZZRWJHNnNsWWlvQ1Nob1VhdkV0REpPaFNNdndHMVRvZlRNemZESTFkbjho?=
 =?utf-8?Q?4lirFQQgL9WwaMMBwqwpp4oRevvIzN8AviZlOJN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3c4TDMwQXhnU05GTlVjbU1xUVd2aXZ6TVpRU0RTMHg0cUZWWHNNcXVjUkcr?=
 =?utf-8?B?cUxJYmswL3czdE1sYy93S3R1c20yZkwxME1JZ0VIQytTNWIyS2V2WHJydmsz?=
 =?utf-8?B?Vk10bXFtQTVmeWVrZWQzZzg5bGQrWTZEWlBSWFBXKzBCdk9QVnFlenZhTDcy?=
 =?utf-8?B?K0t4S3JVUCtTY0VvTHFESE9WbElaRXFESlhiaUViMnFXUVg1ZitYZUZoQlVt?=
 =?utf-8?B?Q0NaSEZpZHRTcWpNY0t3T3JTa3RWSzNXWW9OR0MxOUtWNGhGaEFaV0VtSWVO?=
 =?utf-8?B?Z2g3dSthZWxsaGpVaVNTOWNTaDg0dmhrNjJEeFg1U1RmL0UyYWkxeDNLV3NE?=
 =?utf-8?B?NDdoU1UrY0xoZURZYWZnN2xwVFhRZ1dMeHYvQ3g1cFVmaStvaTY5MTJ3MUI4?=
 =?utf-8?B?MFU4MU44K0tzL2d4VzhTem9zZ2JCZDRZYkMydmsxVXFaSnFMM09hVXI4UXJS?=
 =?utf-8?B?QjJud2hyemNmWFgxT0tIc1NwRmR4WmY0QmlRck5VWU02TXh1RU9sL3lnWlpD?=
 =?utf-8?B?SDJTaVhNcjlSS29nV2NNM3hoTytnQktwTzBUTDNBVmNDR1hlYkVJNVdFVUhh?=
 =?utf-8?B?bXJmZmozRForRUxqZEdiWkZxMWhEbVFyaVVpdEdkSXdhOEJZZi90NmdUaFdP?=
 =?utf-8?B?RUZ6N2NWN3FJOGtOdm5YMndSZXB4Y0xvQ3JtZWI5em9XYTd6MnRNNHRjYldp?=
 =?utf-8?B?dDA4WjR4TWpOeGprWitRSXA2VlFnd1FkWjBrRmpHbUJXSlQwcFVXQU54Ry9R?=
 =?utf-8?B?M01ld2V1MkhIQ25FQTlvdUducGFUekQ1OXdvSEN4OHp6bDd6eWpzZEF3dlBF?=
 =?utf-8?B?Uy93VHdzNDh2eFMrY0phZGZMWWhiWGN0bVE2alRpVThIeUlLWVlLKzlUWjZN?=
 =?utf-8?B?TTZubDkyWmxobzNER1hETzRCajhUSjhHbUNrckd1L1NzS1J4YjFmNWhYbzdP?=
 =?utf-8?B?czJqKzRqYWxxanBRb2JVQ3hwb1JuZTFvN1R1dUJGYlZBYjB2YnZOTDNtNUx2?=
 =?utf-8?B?aDE5Y0kybnFYRzRmUi9qQ2VNMkx4dFU0K0hJMGhrUWdDUEsyQWpNQ3VHM09T?=
 =?utf-8?B?NkVEY3h4UGZvQ0l5a09GS3VET0hmOTdDa2NhZmdKdU1BaERwdzFncms3TU5L?=
 =?utf-8?B?R3VUeXVEYTFDOW1lV0FmUnRKWmxUYmhHY2hoK0o4UDMyZGpwRTgxTVFjeVRj?=
 =?utf-8?B?TnJTQ3NjTnFXUENCVE1TTno1RG9UbEp0RXRCOUdiVGJJeTFqOXpUZDFyZUVB?=
 =?utf-8?B?Z1JaZ3dvMGVZaTBMM1JIYWMzSVptdVZXVnl6YUV5Vnd3eWhtQXhuNUswdkN1?=
 =?utf-8?B?S0ZWenRyTFdlWmY1NzlCckYycGpZa2o0VVA1TnpVQmE4UHZyVnV3aU5vWjJ2?=
 =?utf-8?B?amdyWE5Dak9FNXhWY2t6YjJrZjZDY2wvaU91NGNoaWsxRUxMUTR2U1lKSFpR?=
 =?utf-8?B?elFzemluSUpTbXVSbE9nRU5Dei9UdzZZdW1NZjlXL1VMVlo3NXZqSVRWZHFu?=
 =?utf-8?B?K0xsT3lFUmVwK2FEbFNyTE5FMzhZd25yTjl3SDIvWWtaUmJKT3lqcUZpak9m?=
 =?utf-8?B?dTVQbG9hUVgwNzc1dmEyMEp4RTc0bGpxaDYwZXpaeHZ3V3dkOHpoNmI1akVB?=
 =?utf-8?B?OHR3Z2xVWG5VcElVVFdUL001ZjFBNWJicXdTS0tMQ3JpbWZSeGl3QitGdEQ0?=
 =?utf-8?B?SmhwL3VPbDZRZTBsZ0dRUlR4MjlFbDdRcGJ1KzFMOC8xUm1DTjNIdnJIR3RH?=
 =?utf-8?B?eDMvemRadEhuVmIvdEpleXJ0SEJOWEgxRlpmSnhFTG05MHNRTkZ6d1l0bkRS?=
 =?utf-8?B?MGdiT1VNTXhGMG5FSGN0MlU2Tm1GTVRvZXhtYmprUEM4enRWTzNGMzhtaUxm?=
 =?utf-8?B?MG1QV0Vyc2RRN1llZVVSbGc5MUIwTGM3MVN6VW9PempVZzBCZWVyMCtRWk9l?=
 =?utf-8?B?MDFiUnV5alBTWWE2UlIwNE93YXZHODNKNFhYcmRxOTd0M0hjQk5VT25ERS81?=
 =?utf-8?B?dmN0SjF0dXZVb0s2MEZxdXVjV1I2eDFOOEVnOTBJZnhycnFpZ0x4T0FnS016?=
 =?utf-8?B?Tk5xSmJCVStxU0dBR1pUeGtmZEtNK1BFQWQwRFpjNzNONzRUcS9MeTV3QS9R?=
 =?utf-8?B?U1NSQWY1b1U5aG1lNTg5amU5NnlBOGFHU1I3V3NuYmo0dmFRd1ZRV1hnK2xQ?=
 =?utf-8?Q?OxeKZE7rL3YXkTQ3N7gDi2o=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b95fba2-c2ce-4658-00eb-08dd034090b1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:36:39.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdHv9hjD3tXuc0wC4bbK2GB7yi/pqd35rNx2lUcIMqEFMD3H87pWyJXq5QgndR0jM3kVV7o9yFhciFcPAmX+VwXRwRVFktcYIhEtFejXXy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

On 11/11/2024 11:57 PM, Frank Li wrote:
> On Mon, Nov 11, 2024 at 01:29:21PM +0200, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add optional clock 'ipg' and 'lin' support to NXP LINFlexD UART driver,
>> which is used by S32G2 and S32G3 SoCs.
>>
>> LINFlex driver should perform clock management and not rely on a previous
>> bootloader configuration.
>>
>> Clocking support is added as optional in order to not break existing
>> support for S32V234 SoC. Therefore, there should be no impact if not
>> providing LINFlexD clocks and continue to rely on a bootloader clock
>> configuration and enablement.
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/tty/serial/fsl_linflexuart.c | 82 +++++++++++++++++++++++-----
>>   1 file changed, 68 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
>> index e972df4b188d..66b822f36d06 100644
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
>> @@ -120,9 +121,29 @@
>>
>>   #define PREINIT_DELAY			2000 /* us */
>>
>> +struct linflex_devtype_data {
>> +	const char * const *clks_names;
>> +	int n_clks;
>> +};
>> +
>> +struct linflex_port {
>> +	struct uart_port port;
>> +	struct clk_bulk_data *clks;
>> +	const struct linflex_devtype_data *devtype_data;
>> +};
>> +
>> +static const char * const s32v234_clk_names[] = {
>> +	"ipg", "lin",
>> +};
>> +
>> +static const struct linflex_devtype_data s32v234_data = {
>> +	.clks_names = s32v234_clk_names,
>> +	.n_clks = ARRAY_SIZE(s32v234_clk_names),
>> +};
>> +
>>   static const struct of_device_id linflex_dt_ids[] = {
>>   	{
>> -		.compatible = "fsl,s32v234-linflexuart",
>> +		.compatible = "fsl,s32v234-linflexuart", .data = &s32v234_data,
>>   	},
>>   	{ /* sentinel */ }
>>   };
>> @@ -807,12 +828,13 @@ static struct uart_driver linflex_reg = {
>>   static int linflex_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node *np = pdev->dev.of_node;
>> +	struct linflex_port *lfport;
>>   	struct uart_port *sport;
>>   	struct resource *res;
>> -	int ret;
>> +	int i, ret;
>>
>> -	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
>> -	if (!sport)
>> +	lfport = devm_kzalloc(&pdev->dev, sizeof(*lfport), GFP_KERNEL);
>> +	if (!lfport)
>>   		return -ENOMEM;
>>
>>   	ret = of_alias_get_id(np, "serial");
>> @@ -826,8 +848,14 @@ static int linflex_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   	}
>>
>> +	sport = &lfport->port;
>>   	sport->line = ret;
>>
>> +	lfport->devtype_data = of_device_get_match_data(&pdev->dev);
>> +	if (!lfport->devtype_data)
>> +		return dev_err_probe(&pdev->dev, -ENODEV,
>> +				"Failed to get linflexuart driver data\n");
>> +
>>   	sport->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>>   	if (IS_ERR(sport->membase))
>>   		return PTR_ERR(sport->membase);
>> @@ -844,37 +872,63 @@ static int linflex_probe(struct platform_device *pdev)
>>   	sport->flags = UPF_BOOT_AUTOCONF;
>>   	sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
>>
>> -	linflex_ports[sport->line] = sport;
>> +	lfport->clks = devm_kmalloc_array(&pdev->dev, lfport->devtype_data->n_clks,
>> +				    sizeof(*lfport->clks), GFP_KERNEL);
>> +	if (!lfport->clks)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < lfport->devtype_data->n_clks; i++)
>> +		lfport->clks[i].id = lfport->devtype_data->clks_names[i];
>> +
>> +	ret = devm_clk_bulk_get_optional(&pdev->dev,
>> +					 lfport->devtype_data->n_clks, lfport->clks);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret,
>> +				"Failed to get linflexuart clocks\n");
>> +
>> +	ret = clk_bulk_prepare_enable(lfport->devtype_data->n_clks,
>> +				      lfport->clks);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret,
>> +				"Failed to enable linflexuart clocks\n");
> 
> devm_clk_bulk_get_all_enable() will be more simple. If use
> clk_bulk_prepare_enable() here, you need add a customer action
> devm_add_action_or_reset() otherwise if uart_add_one_port() failure,
> all clocks will be enabled.
> 
> Frank
> 

Thanks for pointing this out. I will add 'devm_add_action_or_reset' for 
handling clks disablement and keep clock management as optional in the 
LINFlexD driver.

Ciprian

>>
>> -	platform_set_drvdata(pdev, sport);
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
>>   #ifdef CONFIG_PM_SLEEP
>>   static int linflex_suspend(struct device *dev)
>>   {
>> -	struct uart_port *sport = dev_get_drvdata(dev);
>> +	struct linflex_port *lfport = dev_get_drvdata(dev);
>> +
>> +	uart_suspend_port(&linflex_reg, &lfport->port);
>>
>> -	uart_suspend_port(&linflex_reg, sport);
>> +	clk_bulk_disable_unprepare(lfport->devtype_data->n_clks,
>> +				   lfport->clks);
>>
>>   	return 0;
>>   }
>>
>>   static int linflex_resume(struct device *dev)
>>   {
>> -	struct uart_port *sport = dev_get_drvdata(dev);
>> +	struct linflex_port *lfport = dev_get_drvdata(dev);
>> +	int ret;
>>
>> -	uart_resume_port(&linflex_reg, sport);
>> +	ret = clk_bulk_prepare_enable(lfport->devtype_data->n_clks,
>> +				      lfport->clks);
>> +	if (ret)
>> +		return ret;
>>
>> -	return 0;
>> +	return uart_resume_port(&linflex_reg, &lfport->port);
>>   }
>>   #endif
>>
>> --
>> 2.45.2
>>

