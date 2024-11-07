Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27E20B1FF;
	Thu,  7 Nov 2024 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981114; cv=fail; b=tN9PzaJUPI2B5cQSz+lIdZg8fU5wKa22th6NVbn+u+iz5fjBkLRwaJT8v9Dfv7OswDO6IYCavdRHp02p/8uNEXqJZm9n1Nx/sKJ+HOp3E1GdiBYfV0r/B97mCU1WzKT2TDEfKOgVdRPzd0x0nOgP3ugCGHzm2GiUSWFEkznPeao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981114; c=relaxed/simple;
	bh=Or4obT3AuL82AxkgPUh26rH1I714/hlSJEZ9Y8uRwEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dU/br307HBwspVvSFyVQy25f+/CCST0BtfsVFfuuieobC3oJ3A9cCVVX+ff2F7H8ceRqX7ZxpehdJSjrwVsDdTAx4msVVHoyc04MG9V5lEJtr9BVWIL/TOwp7HuqPTqZR/CsMMTqasPjcNcrWArRnIV8yJ6YbaeCtqBAMFEY4Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZwLn9k0C; arc=fail smtp.client-ip=40.107.105.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZwLn9k0C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz6PFxr6ZZB7vRD6svhVaems6GUNpmK0TcVu/beFfcaNDSbFVB0ReUVuAlQc14AfNIaHH+3j7bvDKi6ldqEgFQF1mzkMPo3CeiHuPm/gQse5WeQxf7JDrbeJyXuZDOfpf7sQMT6QFY6wVtVP5ZnzX+Kfo5hQ8VWHGrdi1b1WWx/wg+wBiNUkZLZ22zuTeh9TNWVWKjYPRHJZrVw7SOpA/JHryrljI4atBt7H1pteTNZ3FAkolvaJc2gvfiCDFcOKD3f1WQu66kWL9M9dKXQJxa52FFxpqp3Ou9vduy1dwiunIIfEyMRamLoTCS5kGCzZ1qXQcf4fJbX5iYQvgZLDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQGNV7Lbtg4TYzRYLe8vC3XELoA40NRSBdOPwWo+NXg=;
 b=GhB44Wt8b7Y1EHTJFCuWW3kJcnVEwbzUWmyioEtTdNdxJWuyotvp0QH/uTOswd/OgcjBiYMJ402cz/7XxypumOZrq+ck04y7ZkAD9HBxC1w6xBc0hbjMOWUlV5Pgz3lENqYG5cvSlNd5djVh3Hp3zPAr8qZ/epGZqn9iGoqUxAqUNPWckxumQmfOvQbTpAwj/Cvs3/lvtsw3gIDocxDJz/EftcWMhBkrMaTwNc9L8/EI4w+f57LbT8ARaDjzuSaKvmQfq2zGu3xpOTwbDnNFWRSeo8xmHj/I2to4bVFBvV7d1lOKTnenHQDSjb4fd64uaNrrbCLDqv4IzVLqpOhenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQGNV7Lbtg4TYzRYLe8vC3XELoA40NRSBdOPwWo+NXg=;
 b=ZwLn9k0CQpTTUQf8dqPKwFVABDLb5Ir6Lf4ZINm2t4zkJ28LuOy8wMmDyUmo49y+5dhNyYXcUklBwF6NmUZn2/ZGehHfAcK3U3OOYi2y8Wzkbbu1G0fCe/cmcC9ELHw8TSKxo/H5UtCcWnfST8BPD8SnBVU1wR+pxjyQaX/5ZtwWwA0BrJXEhUIB8mKFsrxSsBZl1P7clv3xq+OnXmYxrZB0+45VaUSt891TcLI/ShBv5houKj927XZhFeG0YuL6Ycyc1EQ+F/s6620H+BKEi0ZGtInUTR8tTlEaFRy/v2BgcjhoPqw1GWGnYS/OIiMDNyFkZSMbKy2lwmzBKws6Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB8996.eurprd04.prod.outlook.com (2603:10a6:20b:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 12:05:09 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 12:05:09 +0000
Message-ID: <18aebb8b-954d-4451-9610-0cfd2a5a040c@oss.nxp.com>
Date: Thu, 7 Nov 2024 14:05:06 +0200
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
 <7437a82f-be1d-45d0-9151-886564fabb4b@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <7437a82f-be1d-45d0-9151-886564fabb4b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: cd352da5-c5b5-4f0a-ed3e-08dcff246d00
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekQwcGNGRm1rMU5QaG9WL3RVb0JpQzBrb3h0TEFDcEFHcFJzd3BxSVpMZFh5?=
 =?utf-8?B?T2ZpUUFpZThBQVZJbDNhSGRUampMM0pnUHdOMy9NZnVvOUVtUkNheW1DOW55?=
 =?utf-8?B?c3JIZmJTZXlHTEJZQndMa1ByWDBwNDVWdFBRelhwZFZtYzErd1ZsODJaMWl1?=
 =?utf-8?B?NGt0Q3RmRXE4SytHb0MwZ1I0WEJ6MnVhenpLZktXc1ZMT29JRzhpWEtGZmE5?=
 =?utf-8?B?VXZUSE8xSUFiUnAwdWZ2Z043c1JSZ3k0YXFieUViTjhUT29VNmxTeThOM0dx?=
 =?utf-8?B?cXpybE50VVdqQVdkWlFpMjNoYVdjaS81UHVoeU15QUc0b3BWVHBGSDNWNm00?=
 =?utf-8?B?Wks1a2ZkNjFBTHBod1V0VGdjUys0QW91LzJVbkF2Wk9kTVlXbis4R3VIaldW?=
 =?utf-8?B?RXZ5Um5XYmtYdHF4UnNGaGRnckxRN0owUWRqVlltdGVJYmxqOEg1c1JLRy9r?=
 =?utf-8?B?SFdqRGFxTFFrTEUxTmtWejUvSUlPbDNaUFZWSHdPWjhuNVNzYU5uTUdmb3k1?=
 =?utf-8?B?OCtYZDhNMlJkb2VUempvNXh5OE45TnlVUDZKVER4R0U4WndIOVN5V3hheUF4?=
 =?utf-8?B?MjI5L1grSGttZHNRR3pWWk85Uk5ZYVRacWZzT1IrclZLWGtoaDB3T2ZoOGVx?=
 =?utf-8?B?SHJhQVBObmJIcTJWTGRDRGdoTWV6TlNOdURRcFBzYWg0NUVUOWV2UmRZZnlY?=
 =?utf-8?B?RlZQUE92SEhwc0w5bCtHZHNRMWliUy9ZTDhtWVI1ai9RcTluT0J1ZW5EamY3?=
 =?utf-8?B?a051eWVwa0JOeXNxdXVJekxkdHRHK25aN3F6TVhQWkVCTm13SGlNSXNTYXBt?=
 =?utf-8?B?R1d4ZFpzbFlDNWllQXZPWnordG1GRHlsbFNPTnV2dUJndGlpb0gvRXBXTHgy?=
 =?utf-8?B?OWV1eVJEak5VbDcvdlZFamhVMjQxOHJuNkdZUWhsdkRjb0lrb2crRWljS2hP?=
 =?utf-8?B?eG1wNnNpZzF3K3o0aDFTYUtjSzc2Y2l1c3hZY0FWaklxQXhydUovT0R3bXVV?=
 =?utf-8?B?amtKVHF0UmY2aTRnN2FZU25pY2VjR05lRVFPYUNDYk8xbEFHSTZ1UjVLYXda?=
 =?utf-8?B?YS9WdVRnbCtOczhiNmNXL200a2VBbDMvRFcxOTZTOTZkelFmOHNVRXhVenB0?=
 =?utf-8?B?eWZqUjV3QzNWOTlnUUw3Z0huL0h3ekFxZXY1K01OdHRmejhPbTJMbER0Y25p?=
 =?utf-8?B?TC9SNnZ5ZFhRY0ZTemxMR3VCR0RiZ2xKSFhKekw4dWVpZ2lwcEZ6ciszcHY3?=
 =?utf-8?B?enBLbVUvdmxFVW91aVA2Q1drL1d4ZHJ5VmluYzMxSlhSTUpVZ005U3c2d3ps?=
 =?utf-8?B?ekNxeWVJNE1Oc1Vldkh2bk14dlhjeno4Zk9qa1BRcHBtOFJXT2dZNFRPNjhy?=
 =?utf-8?B?TXJpWldwb3cwYVZ4VUdxSVNtK0F0bVQxQlNTUlNOMWJBbUJGZVl4ekNpOW92?=
 =?utf-8?B?dlZMU1hjNnVWOWp1aU5kZldCazRBMUwraU1ESjJneDhGRXYxY24wU1lIRHlo?=
 =?utf-8?B?YjNxVnViK3gwaytjRkFSRCtUVy8wZWtqbFltRC9VRE9SdDJwSVZhU3ZpRHdC?=
 =?utf-8?B?RkJaNXFWZlREVzArSmF5Tm9IRFVBcVJvcEJjdHR5VHR1RWExVTk5VlFicTAr?=
 =?utf-8?B?NEpjUUppNm1EYWlRako0THdRN2hwRU9ZbXU1REt0bEtYb2RKKzhXcUlNY0Zy?=
 =?utf-8?B?VkExWk50SlJNMU4xVGV6bHVvSnJNV1p4dE5OR0RsbUZlNXErRnltdDgrdDE3?=
 =?utf-8?Q?K4nixY6huFBJgnd2sMQPvYOf/gc0pwdpHkLy3AZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vzl3WjByajJyS2VPRFZ3QStpMkRZUVB1dWtBMS9QRXVsQ0VzbmR1NHY5UDZZ?=
 =?utf-8?B?RVpCTHhwM1UyTmRFREFwVEl4SjYyQTNPYVB1Y1hQRGpPVExqTmdUK0dnNU1Y?=
 =?utf-8?B?NVQ4RU5Kb0VOaVVJUTJEay9XVWFIWVNHcXloVUhHS3RiZHVHdEpjc3FoNGhk?=
 =?utf-8?B?U1J6N3pjWDhiaHZucWZIbHo5T256S1BrOElzNlpkekQ1QjRoVHUvSVd0R2tr?=
 =?utf-8?B?ME5hVjFVdlc4TWQ3YjlmQW5QSUZrYlJFWmZpNUloS2Q1VTRhZVNYcTBEcERF?=
 =?utf-8?B?NkZJSmJseG9hZ0wyeDNSTzVVYWFva2ZFZjFVb3FqcmozUXJjZTcwdGNqNEdK?=
 =?utf-8?B?REp3VFYvYjF3SmJvTWhVVGFRNmI1N29YazFWOTJoVWtJbHFXc0kvOGRjbm5a?=
 =?utf-8?B?NWpJbnU3alhTT0xXL0ZUdW5HZ1dKK0tJbjZJSHF6TmpWRVFoVm9SSFpkMnh3?=
 =?utf-8?B?RzdqbUd0SnpLeU9veHlWYm8vbWZvMVA2WmpiZi9XM05MNkxCTXZOd01uQUpk?=
 =?utf-8?B?QXpUdFV2dzI5Q09vUlYrRVJvRXJNMHBtV1MzMDBncnZ2WFhGdTFpZE8rWUZS?=
 =?utf-8?B?V1M0aVZPVXl0eEllbjAyRWsvVUtidTN1WHJZVkxGcGc5dWVGb0p0VmxBK0x0?=
 =?utf-8?B?WkRFR2Y2YXhJTTNVbDhQbFBQS3ZtbGhoTlQ0MjdGWFk3cHRVUVBSTlZ5MHhX?=
 =?utf-8?B?eUpMVUgvRDRwK28xWUpDNVRsMXBQd2JkY2svQ21mL3JvRnVlaVZ1dVRzV1NW?=
 =?utf-8?B?Ynd2N3E1blRxeWphbjE2QUtlK2ZrWUZyUGJ5Nm1SVnZJVGN5TG5aRGVYbXJa?=
 =?utf-8?B?cmUxcjZnMVE5SVdWazZJem5ZSTZoNlRzM1BlTFFYbWRDOHoyaUFRZWRLYmVK?=
 =?utf-8?B?ZUM4Mk5RKzJCcE5VSWJyUFVMVERIMk04L2hHVVUwRC91eVY5Q3JvTDF0N3dV?=
 =?utf-8?B?SytRSmpscnUrYkx3bjdXYVdyem1UUmYvbEdhV1BqeDNOQ2o1b1YzUU9WdUxK?=
 =?utf-8?B?Wm5ITDV1c0Z2TytKMmRuM0x5dTlGTnBCWld0Qy9WMHdDcHBzRlhZUXJkbkpw?=
 =?utf-8?B?V1hETisrRnlBamg1b0R3RUM3a1QxTE1Jc1BCOS9VYnJlMHZpdnFVRmNmRXUy?=
 =?utf-8?B?VEFDMGNLSWVnZG9jbWZHL1hHQ3ZONVZpUnMyQm43cGF1YmxxZm1RcnZGa3ox?=
 =?utf-8?B?RFJoNG5rNzZTSkxlVXR2ekJ6WDlkRUdFd24xNFFBYTkvRmQvRzRIaGtlWmhP?=
 =?utf-8?B?U0x1WHJuRW94UW5tNHZIVnJqekRsRmpGaUdWMmxtdDRvV3RsbGtzMTE4RGgx?=
 =?utf-8?B?WDVBTzlndXlhck5Ya3FMaUc4T0FoMzVqUWlOTmtWbVlhaXJ6Uyt6VUhGVktr?=
 =?utf-8?B?VSsvOGxUTW1MVTN2cjJRVFJzeWdtMDJIelY1NzRPcjNaKzN2MlBVN0ZhZysx?=
 =?utf-8?B?dzFmUXR3QVVNalNEKzZsL25lbi9VYlpLUTZaZ0ZrSXVUd3JqUVNmSXZTa3Jh?=
 =?utf-8?B?dk1kUXVZZkkrOUtjUU90ZUorbmVwQ1BPR3ZHVEw0TEVxK3E2YlJzZlcrVzBs?=
 =?utf-8?B?T1dOdHQ2Z0JaN3pvTStvcHNZNWlkYkJEcE8rZFVzOHhMZFNzZHFTVlRqTEM5?=
 =?utf-8?B?NlNYemF5SEFBUVBlSGpYWjVYeWRZL2NxYzBQbG5IS0lFSzhCcmtjNHh2MFFX?=
 =?utf-8?B?RHd1dFVRTW95UHltUldsODgyMEtCMmJKZ2FBL08xdzcxekV1TXdUQnlrUFcw?=
 =?utf-8?B?N2VJRXlHOUZHSFY3ODBVc2psSW8wVWRBUUVFKzNGUTQzVDMrNHZENGFzRTA4?=
 =?utf-8?B?cXl6ajdHTW4wVzRha05xRzRVZk1CUUNCQWhQTElrekp6NHlURTRLMkdBRUMy?=
 =?utf-8?B?THl3QkFUOHo2Wlh6OXc0dDZWbnFJbk50bXZuYjZxbE5WUEJOYUV5blFDdFl3?=
 =?utf-8?B?Q0hWcUtoUnhsWFJvLzlLMFNqSThWbHp3MXFZMDhIN1N0dDh2RVJQQnAwMHNJ?=
 =?utf-8?B?aE1NZlhTUzJSd1BjMHhHejgydmtHUTV1dytKbjlhelFkSGNyWllPbEZnSVZ6?=
 =?utf-8?B?aWNvWXR6aUtBdkhtZkFWQkl5WlgyMUtLbjF1R3dMbzNnN0FPbUp3Zis1WHFl?=
 =?utf-8?B?U08wT1QzandsVmpkeG83RytDeUZCOGpJcUkvMFFPMHlMR3ZTSXBEakJsRXF5?=
 =?utf-8?Q?4msxSX4v+UKQ4M9ZShGApOI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd352da5-c5b5-4f0a-ed3e-08dcff246d00
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:05:09.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KumymSbQ1Wq7sQr/bTgSisR0y85BN489q+k4KKOL8KSNft7HgElJPqTAOdMSzrCNHAnrdcaAJsmY1VtpLigQbd11FhzgXAeUo74KhaLK1Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8996

On 11/7/2024 1:53 PM, Krzysztof Kozlowski wrote:
> On 07/11/2024 12:46, Ciprian Costea wrote:
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
> 
> Ah, and that's an ABI break. That's a NAK unless explained in commit msg
> (including impact on users).
> 
> Best regards,
> Krzysztof
> 

Thanks for your review. I will try to add context for these changes in 
bindings in V4.

Best Regards,
Ciprian

