Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795530348;
	b=UltaBBpJz/vHW6m8yci5CMbFQTLZmHNwvaPQLGaZCN2qezyEZ3sAY7i7b3aklKJ7Kxb7
	 IARyc7MU606GpX6RlMfDGB1f/hkb+jDkWc/KWqWMDkXq49BVoW8wXTsFcdku8Ov/iCjT+
	 uI9Tv8ROmVKQjpYZZ4PFT6y//Bm71hKng7m4B9JxPHbW13Z3UOThLJD4Kk9AewTvOd7Dd
	 wqYQ5y7D0yPwWKqAlXIszCIuDhErXLLsZyvJY4lDv/pU4fPolA9NARipNgWUtzhKPgPUS
	 rNNfg3y8L7IENDRvnYFjh1zid6U9jfl+PZVLFDuRWeK2FuLmAGzglFUi1SPhgTYz07A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530348;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=LjXLgXoEu5avpj166eUYb9LYw2iV/tPId4+YzA6xYRs=;
	b=XsblfhmOF0LbvL5LX+5V919zbLWmSs/JFBdTK6sWAzyc72C+YlsAfnUGpjUqnLPOY1Ym
	 VjIWtcc3FycyCv0mGZZVRooCwPDRsTxEtEjxB2Uggva6cAtV0iqMJVAtJDDJP2uSCDIZL
	 1oGwWB+Ml+eKeTm++IQe+XUAiRsa3Hl0gmekREOiSYyLd66SC7DrpUDA8QUCZsCxQ4cmE
	 mxkjjJxD86nETxJ9k00vVF9/5v4ngOqaLtnB/MacKzfumJ7X6CC1uT68o0cNWWv9kxcJS
	 jfh7Z60bbsVs5pm2eckJZTEhD2ZLXspQuMHfGjPLnSbiPMvs4OGetmxNTP/MrD1Ej0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b="V2C6/XHW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.19
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010019.outbound.protection.outlook.com [52.101.229.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D9606A31E;
	Tue, 24 Nov 2026 14:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 840D9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=V2C6/XHW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMYf9buLtHvxYIbzxZH1h6HbQhahjavIpDKdUsUqvRRf+L29uc55qTQRjAJrP6JAH/2YfVdvn6MMliEmci1ie2hKQFj6JIOU3wKX1JH7SUh62EgpuPguEMslbf+8qSYoIUd42UlzzLx5eD+05excXXG5imfCepjuLeZQp4GGau0qYmaDh3PYZdMhJs8VU5yOo4s4HDW3TME+/CQOJDbmbs8/IHik4n6gXDiHIQ9MiYA4LnDUU0arZllxm9d3ITuGGmwgyAtYAKeBjbAq/8vTef1gCH3dZug2PmMK9lFfYON920VqoKLlno3qWCrJQKGmaJTX1GvB6UbkYTELx30UAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjXLgXoEu5avpj166eUYb9LYw2iV/tPId4+YzA6xYRs=;
 b=Yn8gd6A9UtMuPjg+fH7agd4ro0D8ZeJ5XDRNO6c2TP+GWkhaLruKDEfaO9h93uDrxNGrfvv+x1W7UhEzozc4jcxiFmj8/2JeNLM0q9uOxTP5pBWlr4O4Z+3AUU5T0kgHRGgPkYUlMLRUuRb/CaIH+ks6alkmF33mR9US2mnTW+PPlVzdnPnJYwkf2o8WRROiU453CbmCqhx+TzTDedHU4aqaeYspsEyHqA9AXdihAP4YRow5cDDNMDkrYkQEDdeYOlN7B4sdai2xB5Kki7gxrReAjMrHjyRdqpKiLh+kAXnRLKFoDSfBcMti6hDEw5KN4De6dvfdUakl3BR4ms73Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjXLgXoEu5avpj166eUYb9LYw2iV/tPId4+YzA6xYRs=;
 b=V2C6/XHWMx1hqGce1BWv4ZuEn2XSAgNT9TQdwLtnHvvaFwApZQSuN57xicFPFY9RTSrOLRNXL/GcGcT6e1eCRKB+xyPT8whj//23H+TSKsST+yQMv6urNOzE/eK//7v0jwz8Wk+8Mi0cO+ZRXFNsayTZ/GTeg4aHfgdnUcXonyg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11) by OS9PR01MB121353.jpnprd01.prod.outlook.com
 (2603:1096:604:544::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 14:25:44 +0000
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4]) by TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 14:25:44 +0000
Message-ID: <b67ce2cc-0454-4842-ac89-09897c966b36@renesas.com>
Date: Tue, 24 Nov 2026 14:25:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mainline-linux 4/4] arm64: dts: renesas:
 r9a08g046l48-smarc: Add RS485 support on RSCI2
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
 <20261120-divo-ssgrlpcsrc-2996-rs485-v1-4-a989baae3559@renesas.com>
 <e4b514e1-4b0d-4bb7-a19e-e13518ceb277@kernel.org>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
In-Reply-To: <e4b514e1-4b0d-4bb7-a19e-e13518ceb277@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::9) To TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11)
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
X-MS-TrafficTypeDiagnostic: TYYPR01MB15118:EE_|OS9PR01MB121353:EE_
X-MS-Office365-Filtering-Correlation-Id: e75b592b-95f4-4706-d027-08df4a36d2f6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|921020|261022105027099003|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+QiDoRNBUkdPvtKMbYqwSRcSkzhtN9/O85mdACrNjWj+VS86B7h5GVy2Wpo0S1ibHIJl/UEmH3qrLFmL2DDtgxCiFWrJWO74G9CUmJgQnvprXx3kiPeqtkch7gJGhZPVuJ2hyzxYMvROb85Ndbf/q9hmfcHJaH06/A6fdoxr11zqmM899wZ4dD3Eg3y0VYg3NMZCDeXqv8xHGFHA2+3jGkRWf2N8ZrsaC+6/ATgjMwHlX5t6a3g6yCwveZiDYk0W1ZcbiMLna7/kJkgZHaKZ73ecQWitbEC1+CTBI/+7ZQ/vn5zhlnUvMDsxna5c9GKofvewBphDWkayr4kn5zvw2h/Hlq3sITr/j9elrJ6wTXMZi2uTCC1WVZcnl9sjIwuGXraiN9MGiWUwM3uz+jgkcgAgFEAbM+8hI7OvzCRlIQZM9pktNeajSD1xFYqgK4DKXWQUm7aeWs1wnyPTk00bDvzraOEEK+Gc6XXYu5s/mymCUR/JhcvcNp9oaMTrECxe6w8hVr89R34RbpH01x/qcm16zRxRM4gS68BClv89laNs/toJhIs446ZJaBeXkYCkHq/PTkzcVUL0RktwFBaEqv2F0gYUmq/xsGda1nEDYKZVDCQjJoYZZ/WYS7z2hO4sBzkWrZDaga3+AlkexdwIAOZ3B90uXd4VIc6olRv8+NekiOOm+XveJY64d4KkGus4BMj7Wyc21BY9gG8Y10sTOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15118.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(921020)(261022105027099003)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDVYZExUU0d4dk8weTVWOHIxMGdkVzA0aS9PejZmR1lRRTU1T2VRMVloUE9B?=
 =?utf-8?B?WmdZT01vYldqbzhZUzR5bWs4RlNFVTFDNHloZXRUbHd0aWJrM0djK3ZXM1dp?=
 =?utf-8?B?ZWxlRlZBR3JaWkJFMGFPc25ldFRjRDZmbDNoSjZjMjJzNUxSRGJ4ODJPUDNn?=
 =?utf-8?B?WG1lSmd1SjN1SjFrWnkyQlhpSUY3Vm1INVF0a2ZTaUQ3L0pQU1o3RDlzZ0FZ?=
 =?utf-8?B?UVNQTkpSMElmcENQYVFMK2RiZDI5b1pnTnYzRVV0K0ZQbDFwVEI2UWQvK2s0?=
 =?utf-8?B?WFNZQWJyWXVtVGFzUEp1R2pxNjM2b0pTYSs1WS9ENEpyS3hWSkJ3eVQ2TWc3?=
 =?utf-8?B?L1hNc3M5ajJIUTZnZFkxaFVhNmdFNmhuNkRpQkIwbUxvSXdpcFEvMmpYWDQ2?=
 =?utf-8?B?UEpZQ0RYeEVuL2VWby9DaXNyNUs4UkV6WVNWcGFEenJsUmRqZGpKTkhjV0Ew?=
 =?utf-8?B?YVI3ME4rTFZwTUJrOVZ1cTZMbFBNc1p5OWRnblVzN0Fod2kvb0FMQXJFSDRK?=
 =?utf-8?B?clZRYWtUdFUxRHRnWlY0VW5hUUVxNzBMYkJyV0VtSVRVZk5zcWJaUGtVeXdJ?=
 =?utf-8?B?ZlFaMVUwUHR3RVZ5VjI5akdkQnBQZ3ZFTGFvL25oa3ZpaTZjME84Z1FqaDNM?=
 =?utf-8?B?NXAranVRWVNFdmJRQmo1VnJ3dTJPdkpWYTJrSlVob3pZZ24vc3NVMUtTNDlV?=
 =?utf-8?B?YTNYNXMvbDVWcXpQYUl1MlEveC9NNXYyQXJMblZjVmFHWjdmRGJYNDVNbnVY?=
 =?utf-8?B?WHFVTTZDMzVxUjR5RHU4L2RaZ3VuUWU5cmZDTEkyTlh3REhWYWY4V2U0c1NE?=
 =?utf-8?B?OEU0TmxqdEVpZER5dGk3WkplQkVBRXVhelcyWGNiZVlsanY2MHhKeHVHZFdr?=
 =?utf-8?B?bFhpY2RmaEJoYzRnM3pwK0wwbmY3WGRYTm9DNHNsOTZUTmlHUEdCR01BcXZ0?=
 =?utf-8?B?WEVKZ0x3SXhoS0dONExSaC8rV1pXaFpBZXh3bVdLdXNUNGFDUTEwNnN2aE56?=
 =?utf-8?B?TytUMmlKMFY3WkRscGM2R3VQVzc3SGhxRDF6RU5FV1E5NXRYQTkzMWtYTXdw?=
 =?utf-8?B?UjQ0T3p5Wm1KK0s4cG1TZS9SYzViM1ZhcTlNc3haZTcya2VsVC9yOHdKaWRV?=
 =?utf-8?B?ZXlScjhMcUp0OUwxQUJlYlJmU1BObTc1NWdJWlZhMXU2L085azAwOFpxOWpL?=
 =?utf-8?B?MlBMcTBWRUt1UHdaK2ZrS0Z2T051Y2E0cjZoeUhKNEI1YmRIM0Zjenc5WjVa?=
 =?utf-8?B?Q0laczI5dmM4WWZvMkVua0ZEZTl4MitqS0ZYaTZDYlBLU2xkM1dYd0VxODVX?=
 =?utf-8?B?dmliUGtuMitBQ2JHU08zVFdLRUdXMGZXcWtoT0ZNQWV1Zk84Ukc3M29yZWQr?=
 =?utf-8?B?eStJZFAxaEVHUU1oOXNIZWN1RWJrUjlyY1d6NlhYdEZyQXBiMmFGZE55VWQx?=
 =?utf-8?B?Ykw0ZW5LVjgzTHNnNTQydWE4bVNGQ3R6MUNuTEZrWFVTb2dydFRpT0ZWa2VW?=
 =?utf-8?B?T3hjU0FLcE9WVkhsdnMzS1BrR3dxU3lvVUlDTFlkZmJxSDRBSTdtVFdjMGtx?=
 =?utf-8?B?OHBrdzVQcVRKYzA2Q3Y1N3VrMldhcjFtRVlGNGFpYXFVQy9wb3BnN1QvYkdT?=
 =?utf-8?B?b2ozU1BEVjJRaUdMenJJMURKU3RXNGs4TjlHQW9xdEdaWWJJdHZVb2lYUHl1?=
 =?utf-8?B?WHhaczcvWkYwU1VzVkxPVTNmYlIvVlVhM0JwN2FtaXZuVnU4WEN3T0V2NFZM?=
 =?utf-8?B?aXdqc00rVnVIWDMvSGpHaHo0YVEvZE01d3Bxa0FyUGF6VHNpZk5WUVcyUVdW?=
 =?utf-8?B?NnQ0MndSZHRFaFMzQ01ZeVk2cEJ0MDRtVE5UWWF3RHlOUWNnQzBXL0Y2N1Ir?=
 =?utf-8?B?K1FiNElab2ZaS0MvZERwQ0ZjOC9hUm5SUk1lT1pHNzlVZGZhS2ZtTzEva1BN?=
 =?utf-8?B?T0pLc3p1czhyeVNmOVdIUC9qenR6Y0NNdUo1Q3ptZU9oeHNlSTUrYnY5aVFE?=
 =?utf-8?B?N0ZuRVNjNGVsY2hvYXlHZG42ZWt4NS9EeFhGcktQOForajYxU2VCelYrVmFN?=
 =?utf-8?B?bVdqN1NlVHFNWHV3NVpyY2RyOVpUcjVqaVlyand6SVN1b3oxUHM5VTJQb3ZN?=
 =?utf-8?B?NlV6VUdCTDByTXlsUldIa1lBUlQyK2h5VHlIQ3NSd3NsZlhQOWxvbEk0VWZs?=
 =?utf-8?B?L21qNXVGYlg5T2pLNGFscWJyaU9CZFQ5OGVoRXNyN3o1a3RHYXJ2cU52TjM0?=
 =?utf-8?B?TUIwMVBCUjVKQVdiZkdkZ3BVU3JBY2M3MHVyMmhhcmJ6TVd5eExuN2ZqNWNw?=
 =?utf-8?B?QmR2WFpwekpMc1BjT2l6WUNDMWgwVFJvUldrVmdEbXB6TzVzcGZRZz09?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75b592b-95f4-4706-d027-08df4a36d2f6
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15118.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:25:44.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK4YkSiBWUn/8mUwvbFdPgYttYxcK2V31k/Fan0/bH47OctC4mKQg2tzo0FYKF0aAsVBHcJPATQ/0aN3xW+w28993Uvt/3X3Tw3eTsNRhec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB121353

Hi Krzysztof,

On 11/20/2026 4:03 PM, Krzysztof Kozlowski wrote:
> On 20/11/2026 16:49, Diogo Ivo wrote:
>> Add an RS485_ENABLE macro (disabled by default) to configure RSCI2
>> for RS485 operation using the RSCI2_DE pinmux instead of RTS/CTS
>> hardware flow control.
>>
>> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
>> ---
> 
> Odd subject prefix. :/

Yeah sorry about that, it slipped on my side and will fix for v2.

> DTS cannot be combined in this patchset and must be split. Don't mix
> patches from independent subsystems when you send something explicitly
> targeting only one subsystem.
> See also: Documentation/devicetree/bindings/submitting-patches.rst

Ok, then I'll send this patch separately.

>>   arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
>> index 68d7b579e352..d583f52e61e7 100644
>> --- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
>> +++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
>> @@ -23,6 +23,8 @@
>>   #define KEY_2_GPIO           RZG3L_GPIO(6, 4)
>>   #define KEY_3_GPIO           RZG3L_GPIO(6, 5)
>>
>> +#define RS485_ENABLE         0
>> +
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/input/input.h>
>>   #include <dt-bindings/pinctrl/renesas,r9a08g046-pinctrl.h>
>> @@ -185,8 +187,12 @@ rsci1_pins: rsci1 {
>>        rsci2_pins: rsci2 {
>>                pinmux = <RZG3L_PORT_PINMUX(7, 6, 5)>, /* RSCI2_RXD_MISO_SCL */
>>                         <RZG3L_PORT_PINMUX(7, 7, 5)>, /* RSCI2_TXD_MOSI_SDA */
>> +#if RS485_ENABLE
>> +                      <RZG3L_PORT_PINMUX(8, 1, 6)>; /* RSCI2_DE */
>> +#else
> 
> That's dead code.

The way that this is meant to be used is that whenever someone wants to
use RS485 on the board they would change RS485_ENABLE to 1, similarly to 
the way the other defines are used on this DTS. If this is not ok from 
your point of view then I can move the RS485 enablement to an overlay.

However, when you raised that point I realized that with the current 
approach the RSCI UART ports will always advertise RS485 support, even 
when RS485_ENABLE is 0 and as such the pinmuxing does not expose the DE 
pin to the outside, making it impossible to use this functionality.

There are other boards upstream that behave in this way, namely the 
imx8mp-hummingbird-iiot-rs485-{a, b}.dtso, where from my understanding 
the ports will always advertise RS485 support, even without the 
overlays. So I would like to ask the maintainers if this behaviour is ok
or if it needs changing, specifically adding runtime pinmuxing support 
to the driver (and perhaps the core).

Thanks,
Diogo

> 
> Best regards,
> Krzysztof

