Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5881212B39;
	Thu, 13 Feb 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441501; cv=fail; b=FMSLqZ3UemfuS+6EMm75SR7fBy3XJ+QBLjcS2O5f16wpt9mXaY55sRiww1lwukxXzlTxXx01ZURJfWD+NYYFIxFhzAEy0sEpZcC8h3q4G1Rt0RGtEZz8gfgdTWx/WKp3s0sglcoxXkdyDqWL/4GBzCdqqTRTj1Qordybjq3SKFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441501; c=relaxed/simple;
	bh=/bgZidG13U7P3TSadoBun+u+yDmBKZ/g6foKQDoSDQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mr1YEFC17obKM+4rDFEysP05yZw9vQYfR3zYQDDDdfyhZBn0a099Y0jujeJo8DCYs0qbQGidAdqDOYcpQDDhPn3qWhAu96x3gxVt2iLFICgS3PzrzExQdVbZfOY8epeg2j0tGk4zkPouNBXWKt1/LoO9w9fmflQ0IozA9kFLpdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pM6CaPmY; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pM6CaPmY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aznrzr7i+2XamPgH0ZemJCbmclLdsJmVyzaaBZncn2T5NjzBGpNOaFww0STJBTFMV3msn5/0ZvThhYCg+dOwminHlD8/YmOmvAhGslAAbtfW1mExqisZVywQh6wPUsCaaMJabZEC2Stv/OlTT5q862lFpZD8XaRgalebslEtLc5wRQXrCQtfPczRkLMEfNIY2WwT/MtLJTht85L/UzeE7xk4DvOgq7rVy+Ex7kecYMRkTGsHavzmUfjM7RUBnop+rusHRdQmDjquIM4Vj8efKZ3asT8jUVetgU2Q3DLSm9E/OGHPtRL6ObgtrKCQp+6v/KpHCICs10jTFtSq7ZXmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bgZidG13U7P3TSadoBun+u+yDmBKZ/g6foKQDoSDQw=;
 b=Uqosovm+fJxsgltlPIuD2dKnWJ+NXVdQJQAboineIHSX/DaQM+KjEYQWUyixhqxF80GVNMgMHFBZRHl1JsNKEZBs8YOJHlgjMWX/2Jy5Lc3biY/WnHuWCQrYst+eXv2KwCiBTzRKuVe1+LjeblNCX+tcaA1M69d+R5Z7JHzE1bybLKdqK6q230a0hkykBSU7tI1dp7/tMw+4fVjmPGRskJTrUDuwYrgNifoBzmGvC66xh896wT2SlUy6IzybngupbsGMFW5avg7b8pPqqTm56dMmClrCpV/a7ifXCGx1PctNKE2Nd9OzyQwnpqAAgeGqGACFmSMIq0RtmqhczKMskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bgZidG13U7P3TSadoBun+u+yDmBKZ/g6foKQDoSDQw=;
 b=pM6CaPmYxNrUNOUhWilnLmd5PKkUTZJmIw2GQMP3o6QjcZmMMYyIjzUl8hE31oQmX1agnn5wWMvweGfpRqmlbIMnco+UPdVc/7Y1uziNnUUJl6a+jSlkd+Z56Zwf1DxQDYgsrNqF8xqYm+oQ83j+zqxdCXeRj0NKNObekSLGk7FpQiuwvzKxO0py4Zsog0VW3x5Mnrs59H1dPUmy7FYz3rzlKEuVSByFt/kRMZ5YZDRMRgD3HKgtRThxKGFBqEUfKfomCrUjG2LX0awYLJbARwLZbyIDgBAwoF+pMK/bF5uccGQOzEFid1H30JISERlda7mFeDQK5K/Exynk4sK4ug==
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 10:11:37 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::1770:161a:675f:7861]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::1770:161a:675f:7861%4]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 10:11:36 +0000
From: Kartik Rajput <kkartik@nvidia.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: Jon Hunter <jonathanh@nvidia.com>, "robh@kernel.org" <robh@kernel.org>,
	"robert.marko@sartura.hr" <robert.marko@sartura.hr>, "arnd@kernel.org"
	<arnd@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "schnelle@linux.ibm.com"
	<schnelle@linux.ibm.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] serial: tegra-utc: Add driver for Tegra UART Trace
 Controller (UTC)
Thread-Topic: [PATCH v3 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Thread-Index: AQHbfWAxahR/yn7oCUOxvUw4vBkqkrNE8iGAgAAN9ICAAAR9gA==
Date: Thu, 13 Feb 2025 10:11:36 +0000
Message-ID: <88a54c9bf88dac0a3316224b08d0e2378e8fc6f0.camel@nvidia.com>
References: <20250212104132.61060-1-kkartik@nvidia.com>
	 <20250212104132.61060-3-kkartik@nvidia.com>
	 <Z6y5vRGyouZsQWyj@smile.fi.intel.com>
	 <ec06322386adbf4404e2fbc5d7656e3465eb4320.camel@nvidia.com>
	 <Z63Bk6sgQryG1pFK@smile.fi.intel.com>
In-Reply-To: <Z63Bk6sgQryG1pFK@smile.fi.intel.com>
Reply-To: Kartik Rajput <kkartik@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5716:EE_|CH3PR12MB8878:EE_
x-ms-office365-filtering-correlation-id: 7c85ff90-836c-49cf-c98c-08dd4c16ccf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?UzFaNnlNT2V5YlVRR2hwSkdGLzdudFowU0JYSGJrcExFVXBDVWxHSmUvQlJi?=
 =?utf-8?B?dXZLb1hoUVd4WTRBYWxWbTNSQ2JaNXBHVUN1WTNqL3dEWVRaS1BqakVqUm1y?=
 =?utf-8?B?OURvWFRkeVQ1NTJYb0ZFdVdzRFhGS29CTjBFQlB6N0h0QlFXazdKS2xJWGFL?=
 =?utf-8?B?MWMvWko5bFJJaU1jUmloSXdpTzQzRFpKZ21HdHByN2htL1o5aHBuM3pSUktZ?=
 =?utf-8?B?cFBULzYwM3R4V3NLMHdLWmViK3Zxd0YvWkFNUk9ReW55cXRmZmZuSVlSaTM2?=
 =?utf-8?B?TXI0eldCK2w0ZVNuTDZKd2lFMUZtWTduMm14NTZWbGhTMHFxQk1wMDFia3c2?=
 =?utf-8?B?aDAwMXFJQXRDWkRVcjNjME9EWGVoc1J1RVp6cVA2Yll5NHdQeGEvVUl3bjlF?=
 =?utf-8?B?dlh0cmpnU3VVYnRGUE8va2c5WFRLY0JGM3VrZGVONWJwSDV6SHZIVFcyckdr?=
 =?utf-8?B?eGdqbmd4YXN0N1Rya0pHYnBERUhuRW5hQ2ZTR1daL3hJSTZDYVhpcjYwQkgv?=
 =?utf-8?B?WFR6dzgzSCs3aHkzTGpRMmlxMjdESmcrNW00NVJIZk9PUTdVUG1FS1ZHTmpV?=
 =?utf-8?B?SUszRzlYbXcveDRKd3B4SExiSXJRNS9jQnQzWXdMK1IzcmhkNHJGenJ6cmlO?=
 =?utf-8?B?ZnpwVXRNVHF5RnZ4clNJQ0JxUWtKelV6Q0JpRkZPbzE0VmptZHhPRStkdHdG?=
 =?utf-8?B?bkpERjhzWS9BUzBLZjFULzd0dDFMRndKa3VyTEM4YzNpVG56TmsxTWlhb3Fl?=
 =?utf-8?B?U3BXM2FjeTV6YjVMdnV0RnZRTHV6YmhTZ2F6WTJoSW4zU25Cai9CWG0xQ3hj?=
 =?utf-8?B?Umo1N2l5bDBhWWpIaXFONUk5czFNRUpOd3pvWXlQT0dUVldXVnNhOU5XVnFo?=
 =?utf-8?B?cnlSRW5STUZsNzlscUZrSmVGNUJ0MGpDRUxBTG9KQ1dqQlV3YzRjQ2QrSDJY?=
 =?utf-8?B?YVRXOW5MNlZWd2dQS2VoVHk1a2M4SWZWd0JKZ080SVYyV0xseUsxTXFOd2Zz?=
 =?utf-8?B?VWw2a1Y3V3phTXZXM21ENzhVaFlScXlNWDJrY1hOcmZ0V0l0MFlmRkI2OXR2?=
 =?utf-8?B?YUdQUjZPVUpMaFd2MXRoNk56SWdzOCtiTkdmUDQ4T1JUY2U0THkrSGxKajVv?=
 =?utf-8?B?eXlFRlNweHVtYkRTY0ZaMy81Zld1ZEw1aElNTE9sdkFnVFRmRzZDWGNURXk4?=
 =?utf-8?B?cHozNkJjbDVuV0svM3c3b2dld3pIaGhnaGNGaTNXT0gwMllvcWxyMTB6TmNH?=
 =?utf-8?B?ZFIzaGU0NXJ1d2plaFMyOVBCamJkUTNJMjVleXZobnNvSGdKOVFzeEpMRmNp?=
 =?utf-8?B?c3dRbWc1dllkcWFtM2NiSlpWNE1PdDdkaVBtWnNNamRwSUFKRGlYWnRUTmJY?=
 =?utf-8?B?eWVTOEpmSGdRejFWdm1EQjBXZkNtS0ZaR1Z6UitEN3dMVjJTV1BrSytXOUxJ?=
 =?utf-8?B?Q0JVNUNVTE5ldEd6Y0hFSnFJV1RCS2N3RWpkN00rMkdZN2VwZXpRMGVKaTNs?=
 =?utf-8?B?YXFoQ0NYZldwRVIrK0xhalcrOURkZWlhZjI5K1B4cUFBaGVCK0ExSEVKYlMz?=
 =?utf-8?B?bXhWWFBJN2VnVE4zbjl2cSs2dm0yNmIvL2xsdDBpeUNBMm9OakZvcjk5RkRC?=
 =?utf-8?B?Y1NwYWdTd1lYN21XSjNzTWlidFNxTzU2NHlHaDFOLy93dU5IUEpYeDQxRGZ1?=
 =?utf-8?B?MWE2cXNTOWxqQUJKWEVLWVdIVzNOdUNtYkJIL3hqaDJrS09JR0NZbDJWcHN3?=
 =?utf-8?B?L0tzSDJjeEtpK3RjM0E3aDUzejA3ZGcvb3pKaWlQRGt5Q1pPRTl4a21XVDVm?=
 =?utf-8?B?dWVRYmYvVEpsZnc0MUlhOE5SdFhTVkxQVVZKU1pnZnhVd1g0c1BReFFWUVcy?=
 =?utf-8?B?bm1ybnljZjhONlY4VVh4UGlienFXM3BjS2ZVZ3hpOFFCZi85ekVVOGVJY1FT?=
 =?utf-8?Q?7Ko80RImxBKUNS4wUr/FkBd78jyAPSFO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkdQUWxPYnIrYXpKcm9QUFRVSXJDT3l6cjdoRUpPcS84QkNmT0lUSTBndlAv?=
 =?utf-8?B?OXJmT2JtcGpkMUZFQnFwOXJNMFAzKzhHUGM0b0E0V1YrYTN6OVM4TERnNmpr?=
 =?utf-8?B?UzZ0eXNYZUlvejNVdjFDVy80a3g0RU1OZHJGaVphZjFpNVdkSmdtTk1SMENH?=
 =?utf-8?B?eXNXUWhlOFQ4N1VGaStwNnA3TUw0bVphd2RzSkVKVDBEUnFEOFk5Y1BJM1ll?=
 =?utf-8?B?ZmE4M05oMnhpell6VFBXYTlLUDJNeXlUdnh5M0F6d1MzYWs2OVRUdDlQekt3?=
 =?utf-8?B?V3kwV3pnbVQwL0d0TG5SdjZMMUZBTWd1UmhYL2V4RExTQkxCcU1hRWZPUHRp?=
 =?utf-8?B?ZG5mRVcraGxCd3ByMXJsc3JHL1g3OFhZYXI4YjNORVdRdWxYY0xkdnoyNW94?=
 =?utf-8?B?MFlhSEhqdnlWaGg3NmhZVWZVVEtRQjlHcHhIZ0ZtUnpQekF2dng5YXBSckNP?=
 =?utf-8?B?RVprZFExcU9kd0RRMithMU4vZFZoWGdTNi9mWlE3RklpRllrYmpUektWWDNy?=
 =?utf-8?B?L3AzbG40R0NSalZSSUhGd2w1a1U2VHI1K3pZWXlpdSs3ZTZWU3JnRjR4WnVw?=
 =?utf-8?B?c1l5RWF3QU5VUG5JUlg3d2dVYUdCSUk5LzBVMFNvR0RjeTZWV05tY2ZUeXRt?=
 =?utf-8?B?MUpsdUlLM2F3UzFOOUZJM0hPT2hoY01vRFNJQVpMazFzQUpqT0IyUC8xR3pi?=
 =?utf-8?B?enJwOXVkcnpCZFMyUS9kYk0zaERXV2VTZ3JoSXhpdjB4TVArWkM2R3djTnYy?=
 =?utf-8?B?YTZWOWxQdHlUTmhOMjE5T0g4UllWSWZ0QXNYZTllRlR4YVlhOEcwSjBnY3J3?=
 =?utf-8?B?TjFVYkRuQ3A1SHR1K1ltTmJzamVGa24weE9PNEJJSFVjSUpERGt3bmFtUWVx?=
 =?utf-8?B?ZU5UYjFJQ0kwUnpMcklDU2RJY1hId3A0aUg5ZWZ1cHdyUHMzUW1XRmdkWEZJ?=
 =?utf-8?B?ZjhLT2JSV1dicUtXTThTK2FBeTBDRTFreEtaUTZ3NkM5V1dYcXNNQ2d6d1Fu?=
 =?utf-8?B?T0g3RGdIZXp3UlprUTdJbmg4cnFlejd1My9PdlMvekxqU3pLbU04azB3SzJa?=
 =?utf-8?B?VXZyUENpcTM0UkpIU29XaVdjU01tT2UveEhwZzc3VGthaGM2ZnJHRGpzQk9X?=
 =?utf-8?B?ZDltVnh2MkNpMlczM2dRSHdleThkNkRKOWpYVUhBMVRnTmNwcWw4WDk4QWtK?=
 =?utf-8?B?OVNEUHdYV2FaL09VT2NjVlRYSzFNdEVrY0tVZEdwbi94eTU5ZWkvL1JzVDFx?=
 =?utf-8?B?OG1vNWFBVFRkaXJXcENSdjV5OGsvcTBRRytUR0grd3I2U1VCVE9RbFJMNlZI?=
 =?utf-8?B?QlNFZVdEMVl0c3Zqb2VhQjIzUVdlMEJQVktjQWdyYThyME9OYXRxcU1mV2Uz?=
 =?utf-8?B?NzRwT0FUcG5xdUdnQUhKaXRjaGNoK2NBK3FLYi9Xc1ltd0ZjVTFFUk5WTVJt?=
 =?utf-8?B?YnZZT0hubnRldncrVmdpTm1hR2dadURzeTcvY0xlWFFWRnVINHNhWm5kRFhw?=
 =?utf-8?B?U2txTzZpQjJRdHd6WUtyS2loTFZUTzVwWWJ3REsvQ1EvejF1aXRvQXVOTFFl?=
 =?utf-8?B?aHdwR3BVZms5cksxVGVPT3pwZXhFR3FiYU83eGJPK3JlMGFxMUgvL0cwenhv?=
 =?utf-8?B?TDJpYkQzM1lkdFhMSnhiWWx2VjhoZyt6VHVIQ3NJa2lYaldGakdyQXNHMjNI?=
 =?utf-8?B?cVVpc0gyS2VMOElYWHBYbkJram91aTJ4cDdtRE9RbkczVHhXMnNKaDg1M1d5?=
 =?utf-8?B?NkQwR1dheEVYSERvOS9Wa0QrNU53WWhjdE9ZeXk0NFRtS0ZpZ3pIcGF1SGlQ?=
 =?utf-8?B?a0t5MGo5eS9OVXh1RXlyQWg1N2JSYXQ2YjVqdXhrd2JwQTZDbXczTzNCS003?=
 =?utf-8?B?bmtpbVBSeDkyMEJtQmNUUlVxTXR0UHVKblUrK3ZyQXBoRzA4SzlPanFJYXYw?=
 =?utf-8?B?eTFpcFNraWFFSko4MEJDTjcyVWhFTTlJUnIxQjNMSjJGdVRwU1ZrYjZ5RlYz?=
 =?utf-8?B?MDNkeTBLNXJMWURNZGZvNklWNFNidTBvNkVvTENyWFJKZ3pQeWdjWVFReWZQ?=
 =?utf-8?B?TUNHdkpZQ0trMkRrNjQ3Ukd4dlRmZmhreUJ6UEh0ZlJPdWZ4ZWx0Vk5oTjlJ?=
 =?utf-8?B?QVUydEJlMHlBV2dwazFGV1BXQU9PTi9HNVBOSXBCdjI1aUQvbFQ5WW5zYlNP?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FAEE7A70B19CC45ACC6E71FD75DDEB0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c85ff90-836c-49cf-c98c-08dd4c16ccf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 10:11:36.7661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ba5lSLwkMV52+7Q6lNZa1SsbwzkSivNo2iBoHyl6Mj+YWMgjuYT8sk6fPNAq2ZNp8arfWuGdZf3eQqT+A+0iTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDExOjU1ICswMjAwLCBhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20NCndyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3Blbmlu
ZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIFRodSwgRmViIDEzLCAyMDI1IGF0
IDA5OjA1OjM2QU0gKzAwMDAsIEthcnRpayBSYWpwdXQgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDI1
LTAyLTEyIGF0IDE3OjA5ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiBPbiBX
ZWQsIEZlYiAxMiwgMjAyNSBhdCAwNDoxMTozMlBNICswNTMwLCBLYXJ0aWsgUmFqcHV0IHdyb3Rl
Og0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiArwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IGxlbjsg
aSsrKSB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFuYmNvbl9lbnRl
cl91bnNhZmUod2N0eHQpKQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBicmVhazsNCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYyh0ZWdyYV91dGNfdHhfcmVhZGwsIHZhbCwN
Cj4gPiA+ID4gISh2YWwgJiBURUdSQV9VVENfRklGT19GVUxMKSwNCj4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDAsIFVTRUNfUEVSX1NFQywgZmFsc2UsDQo+ID4gPiA+IHR1cCwNCj4gPiA+ID4g
VEVHUkFfVVRDX0ZJRk9fU1RBVFVTKTsNCj4gPiA+IA0KPiA+ID4gTm8gZXJyb3IgY2hlY2s/DQo+
ID4gDQo+ID4gSSdtIG5vdCBzdXJlIGFib3V0IHRoaXMuIFRoZSBjYXNlIHdoZXJlIHRoZSBUWCBG
SUZPIGRvZXNuJ3QgY2xlYXINCj4gPiB1cCwNCj4gPiBldmVuIGFmdGVyIHBvbGxpbmcgZm9yIDEg
c2Vjb25kLCBpcyBoaWdobHkgdW5saWtlbHksIGVzcGVjaWFsbHkNCj4gPiBzaW5jZQ0KPiA+IHRo
ZXJlJ3Mgbm8gZmxvdyBjb250cm9sIGludm9sdmVkIGhlcmUuIEV2ZW4gaWYgdGhhdCBkaWQgaGFw
cGVuLA0KPiA+IHdyaXRpbmcNCj4gPiB0byB0aGUgVFggRklGTyBzaG91bGQganVzdCByZXN1bHQg
aW4gYW4gb3ZlcmZsb3csIHdoaWNoIGlzIHByb2JhYmx5DQo+ID4gYWNjZXB0YWJsZSBpbiB0aGlz
IHNjZW5hcmlvLg0KPiANCj4gUGVyaGFwcyBhIHdhcm5pbmcgKGRlYnVnPykgbWVzc2FnZSBpbiBz
dWNoIGEgY2FzZT8NCg0KSSB3b3VsZCBwcmVmZXIgYXZvaWRpbmcgYW55IHByaW50cyBpbiB0aGlz
IGZ1bmN0aW9uLCBhcyB3ZSBhcmUgd3JpdGluZw0KZGVidWcgbWVzc2FnZXMgdG8gdGhlIFVBUlQg
SFcgaGVyZS4NCg0KPiANCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1YXJ0X2Nv
bnNvbGVfd3JpdGUoJnR1cC0+cG9ydCwgd2N0eHQtPm91dGJ1ZiArIGksDQo+ID4gPiA+IDEsDQo+
ID4gPiA+IHRlZ3JhX3V0Y19jb25zb2xlX3B1dGNoYXIpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFuYmNvbl9leGl0X3Vuc2FmZSh3Y3R4dCkpDQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0K
PiA+ID4gPiArwqDCoMKgwqAgfQ0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFu
ZHkgU2hldmNoZW5rbw0KPiANCj4gDQoNCg0KVGhhbmtzICYgUmVnYXJkcywNCkthcnRpaw0K
