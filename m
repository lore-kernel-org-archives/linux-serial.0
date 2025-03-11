Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431D1E832A;
	Tue, 11 Mar 2025 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676250; cv=fail; b=DdYO4fw9GnqEg2GwJZwBu0Lwx3wpIqeGYx5t//zvYyBMN0DzocBpRzu0tqHr0q+j8xJoBDCak/+oxG434e+qss2wBI+LsR3cW3TVWtwk0uijL6R74W5DGdNcMUHORPHfCmsAtloGH22ZWSV1E9t4PQ1fRT4+X7+ztcDfnGacSaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676250; c=relaxed/simple;
	bh=1sZ6nrpOSxVJA6VqO0BWyXNu4eTJG+9KMhgWTHOiObo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aAVJYLc73uzYLaRLKTH+GQuZFqcL+J2U3KS7y8ShQPd8UqeZxiaqysyrVb+VGK+9kyn47vYrFUIjMsQlGlSY+k3GG+EFWckCH46DLfNdgneBmR1zC20xeUB9oDeQ2HYGI6hT0X5/+80Ls8LhJeslzlG8cUdDz6JARz3i7tX3MFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MODRNTy6; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MODRNTy6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0q30bMMi8SncV1AZARMAwDri4mGqWPaPaSvXDnAG8YD2HZNtla9b48Wwi0SV4Da3HBZt5BbQodXnjk5q3cjdUCwSKOzY/9CNiBighkVimYBqUjuYqImPJSnIVkApgKOv0uW+jubHBunrK+3BTZ9HCkuzyc+yhf7BmtEkpgq+M+2IjjdkmoDf2ZU8mAK+WAf8wR+b5/0ZPjoNycnzeOkxQVq/k3OKaP7VzIoN3sAfQxzc+AV8jhXgfFY0VCjP22XItXFgOkvtLBbK2AuBPHl48WnI7DeJxTcmQlDrmgz95a+pWth7U8CgWn+pZSLg6U+JG4FRLKxK6G77K5ylx2ZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sZ6nrpOSxVJA6VqO0BWyXNu4eTJG+9KMhgWTHOiObo=;
 b=WNXCqYG2r/z4HHqlLE/YRlUxAxjTj1l3U3uAJ95Gtwfn8jM2iItj/mQ0UGYtMhGDhWr5Dfc1D762bNmsxKi66Qpn+MRghgij6AmyLmUV7G9eoqbt2RaObg7s8KyNVcMPe4Tle66ZVIwG6az8zckELyo/1oUm/14di2PdS+GmFTLK3i0rDcVExEPIS9TWFxfPdWVzM9euPq/Zg97ETVQTVTzcHxFPe2BGu/HUiDjYoLhCSVEpvXEu+nGyTeQFQfM1J0OnBnddrNxWPCD4YG2E+uGFb5CcLtRCYoEQDNuwvFplbTq11hIrP4fr5YuXwvxlh4A+lzaYwBDN3YQ8nXklSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sZ6nrpOSxVJA6VqO0BWyXNu4eTJG+9KMhgWTHOiObo=;
 b=MODRNTy6Pcd7sIsBzOD81+t3e0TZyH6LUTtaBO8kqtJfSgG2i5YKVD+6OVhIyEaEtNY1m1/hmaqgRhks/p9f47AA0CcQ45yDaIF9bUUKIdEpVtHoYZZSHYFZdVhcNLUyw4hdy4ZKnU1w085wIqMPJKqchgG3zZ57Ota8gN8Bf95EOmMnrsT3tLJJPV/DjlxgEvbSh0cyfyz54BH5+gd0wg8NPZGQ5iYIsq3bHvTN5j2s4tX2xLMf3Dicqv2w5xGtbWMgqxLuuq8h5dEHfdkyouUPn3Q3+b2pSqRPCaHhytoEOXEcE5eU8b0RptBB6gZQnAscG5xrKyLrKIW3Nuiuuw==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by GVXPR04MB10517.eurprd04.prod.outlook.com (2603:10a6:150:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 06:57:24 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 06:57:24 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Jiri Slaby <jirislaby@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Shenwei Wang
	<shenwei.wang@nxp.com>
Subject: RE: [PATCH V2 3/3] tty: serial: lpuart: rename register variables
 more specifically
Thread-Topic: [PATCH V2 3/3] tty: serial: lpuart: rename register variables
 more specifically
Thread-Index: AQHbkjbXO4SXc7K3Zk+KSS6rM6P1jbNtTRaAgAAyxjA=
Date: Tue, 11 Mar 2025 06:57:24 +0000
Message-ID:
 <DB9PR04MB842943700539141A89FB116592D12@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250311033336.1254842-1-sherry.sun@nxp.com>
 <20250311033336.1254842-4-sherry.sun@nxp.com>
 <7b0bfff1-7398-4236-9579-7fc2cd450c44@kernel.org>
In-Reply-To: <7b0bfff1-7398-4236-9579-7fc2cd450c44@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|GVXPR04MB10517:EE_
x-ms-office365-filtering-correlation-id: b876d862-5dcb-4cc2-64de-08dd6069fa6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3lJNTFRK05xeHhPajNZVnNNN1g2Uk1OeTVuZ0o1MUtjMUxLTHBQWktkcnZJ?=
 =?utf-8?B?UWRNWGo4aU9Bajk1WXVmWllIOFVvWUhHczhHTmllTS9zOTJGcUZ0S0hBRno4?=
 =?utf-8?B?YUliRU81VWZqL3dORlM4MkZmZDlicDJxUFdHN1NYaXRvd3AxZHFvd3Q1dVk1?=
 =?utf-8?B?d2x1ZlVlKzkvRm5oV01ISWJPNm1kZExKWWlIc2xZZ2V5ejEwbkJOMHh2MDlS?=
 =?utf-8?B?RjBqODhpbWR6THpreUwyVmZpeG5PYlBTUVdxUmdkTlRVcllrQkp4cWk1OURw?=
 =?utf-8?B?aFFIbHpjbHBueHM3ZWoxUXY0UWpJTTFJMUFkd05WZnZGa3ZHNTNhN0dYaloz?=
 =?utf-8?B?dzcwT1AvU3R1eDBOWmxURnNMZkpIc3FFbWtldjhFV1JtSGdZdlNVSGZPcmFa?=
 =?utf-8?B?VVZkeDFER2NtM3VsOTE3WU9HUHV2UzZ6cG5ZeGgyVVl3ZTJCMEtHU1dqSzVF?=
 =?utf-8?B?bmJjSHQ2c0djRTI2VlRxSzNIOEpJNHI3bDA0MXd6Q1pzeDEzSjJ2NmlhdmY2?=
 =?utf-8?B?a2kwcUlheXczUWwyR3RxTm5uR0dwcWxPUmNhRjVlWVBaZkYySUJadGVOcUFC?=
 =?utf-8?B?SE96TnQ0bnAva2FpckxDT3hVK0JWQ2NjU3hyTktZMnVRa3BaUXRXV2x0dEgy?=
 =?utf-8?B?WExCTlBZZWtyRS9aTFgxVEM3NG1zUUtxSnVxcDFPb1U4bGJHd2NWaVJ1bnE0?=
 =?utf-8?B?SG1qQmRNYVppVTJnb1FmeVpWd0lRQjhHWHErT3pOMjdZTUV3bW8rZXM4U1pF?=
 =?utf-8?B?Qlh4RUVza2VabVpNMnRrSS9HT0VrMW5SdForaDdsUkRDZmtyVjQ5eG00cStj?=
 =?utf-8?B?cU1JTTcxclBFazQza0k0QnpMZXNFWFdsYkg2ZkNIM1JLY1ZZUmd0M0lqYXdt?=
 =?utf-8?B?bHIrK1NXSnJ1YUlibm8ydXVxRzFuMUgvM1NBYjBZcW5DZThjZUZXR1FWQVNX?=
 =?utf-8?B?NUZwK2JQeUs0emUyVGY2djJuUVlYeHlLcUhuL1Zqc3hWdHpKWkJqd0t0eDhw?=
 =?utf-8?B?R0pUOG9taHk5eE5Fd0JWdFNFVUhmekZsU3B2ZDI4N3BYdXVTR1IwdUxKMUJO?=
 =?utf-8?B?b25tN3cwZjJkeGZLd0dLdnozR0hBNjIwSm5UZCt5aEk4ajYrd3ZRT0oySndl?=
 =?utf-8?B?ZWlnS2tqeTlZcnBLSSt0ZDFrMTJEL3UvMnBqMVhyTWpOUXlCWkRLR1lNOG1z?=
 =?utf-8?B?cGNQRytYcFZvTWdjSDNPNFNPV1VQcC9lSlpVWFVhNjkyV3R0b0I5ZWJQZ2Yy?=
 =?utf-8?B?VUQrMVhKVW1DMFdIZ0dXYXgzbnlCdFBJbVlpeTV3L0t1U0wxT0xETnlqTU5V?=
 =?utf-8?B?RnhwV3FJZmNuM041ZDN1YVZaUVNKcWhCdUFpRHJTNGJiejFicWJBMUhlKytW?=
 =?utf-8?B?NTNUYTVWNGxNbmRiRmRRampyZlQ1VmkyTVhad1dkajdVeWtoTTdzQ2MvMmVN?=
 =?utf-8?B?R1ljQlVZUU15UXcwMnQwdlZ4SnZ5WlgrL2w3ckxLTXJVM3pSOGMwbmYrcjhH?=
 =?utf-8?B?cXhENlhPcmpEZ3ZnL1ozUVp0bjJBWDJiUDVnTWhUT3JUa2QyWVBUa1FtckR3?=
 =?utf-8?B?bFdweTNrOW5TZWFuYjArV0RNSnlacGVoU0xQSld4NlZwOEZiTDE2Y1RtNGxk?=
 =?utf-8?B?RGxMdGZQWkhlZlplb2ZwRDkxTDVEakozczIybDlWa0kyTWdWLzVWK21Obmpl?=
 =?utf-8?B?MVZyc1dLZkVVdnpGa3I4ZHc4bjJkRk45ejRTYXAzT2FiRFc0OE1OL1NqRFNE?=
 =?utf-8?B?ekZXcWR5VllYOXg1Z2FzY3VVNzRRVWg1VXVsUVhnak81c3l0OU9tNnRYZHFS?=
 =?utf-8?B?WXU1K3U1dnlnVFFXLytKemZyZFZYa1M2Q3dRT25DNHVPZjAydHJ4LzQzYlFo?=
 =?utf-8?B?bnBkbndSb3pzTkNzQ3NxdHNVR0VXUStrTjBrby9JWk90cmIyU3BudTJqQ0lq?=
 =?utf-8?Q?3TiSJZCJWXJhoBB3yz2iTolpQmD9paVJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHpoUk5uRlRIcHpUWVlQbEwwcEdYMGo1VGFPMStqTzl6RjE4dGcyN2haTXM1?=
 =?utf-8?B?VXQ0enY1QVovUEE1MSsyM0k2NXhFNnoxbGJ5VDhTQm9sYlExSmN6MmxMTExs?=
 =?utf-8?B?amlBZU5IdjMybTYvRlpBYndyVGpncjZHUWpMVEEwVjRWcTcwRG1PNXIzcmVx?=
 =?utf-8?B?MGQyOGxMMlZXY3NkWUNVbUVuelk0aFdKcG1icm93eldURUdTb1h1VDN1TTFz?=
 =?utf-8?B?Tkp3TXo5d2lqU2grSlBOSm9IbmsxUHl6YzF2N091azZ5ZElGaFMwdytpM0I3?=
 =?utf-8?B?MkkzODhrbmR3L2docVQwdG5wVjdHSGhEMW1LWE5kSE9STVFxN1N1MnN6emtr?=
 =?utf-8?B?NlJtNWlFMUxhWmswem1aNE53RVRKUTg3TkQyRENXSFNOYXhnRi85SjVWSEZO?=
 =?utf-8?B?VUJyc3FPOVZTeENXWVRTamtpdnY1Y0RKU01vam1uK0NjRTZVUnYydEZMWm5Q?=
 =?utf-8?B?bm11WWFsbEVNd2NEOWoxYkpra1JxbFVDUVdUcHFrZWJXWlBCa1MyeE1YWGlC?=
 =?utf-8?B?SEc4TExLbDl1R1VxZTJ6bU1pU0RyWkljT2ZQV1ZiNXJDNmIyRlFzbnNsemU4?=
 =?utf-8?B?NklydjRvWldhb05XK2hRL3dkWGdmM1dRbG1EWFhoUWl0UnFENnVnWXo4Tnk1?=
 =?utf-8?B?cFE4bDU0MHlWUnpkanBLandzQWdvZ2pyOXFJZThOS3ZqU2RFVGxHNUdTY0lE?=
 =?utf-8?B?ZXlBZ3F4M0V5K0FzMGVyRWtzYnBnMEJ6bWJ1dE5EZ2lmQ3lqWDdUdDJOUFJ4?=
 =?utf-8?B?UzVNK3VnK3pad0g4K3p3ZGpKcDE0aE9ZOElDQjhMUzREa3NLaTAySWk4bytR?=
 =?utf-8?B?V1FvQUtVVGFPeHdYbFcycnVEcnlnL2xyOEF5enhreVEzc0lKblZQWWJoV1BO?=
 =?utf-8?B?ZnUvbllwWEk1bU1UaCs2bVJzKzFDSHNVTW5RVjFSZk1wRE9nQThjL1dveHpj?=
 =?utf-8?B?a1FrcE9JeURIanNJMGwxRTF0dXhQdmFlQmVuVkpESnNoTWkwVURTZHJMQnpM?=
 =?utf-8?B?Q042blFrWDJGYVRYZlR4TzA3Q0VBSitRUnRjY3dWRXJpN0xGUXVFRFZsS0Z5?=
 =?utf-8?B?UTYxbXljYzRmL3A0aDdIUlp3V1ZJNzF1M1FJWXcrQklOcFBTZTFMZEpaVjkx?=
 =?utf-8?B?QTIySUNWUUkwK08xM2ZzTlNCOGNKY0FMY2E2aFlXRkR5cU9oem5BYkk4UTdJ?=
 =?utf-8?B?U0lkSURqWjZMaFpUL2k5S2JRaUpoQmcwZ1dIUlByd3puaVo4aGxLL3haVXQy?=
 =?utf-8?B?YnVieDNsc0Q4ZUNLMlZ1eWZCWm5ZTVVuYUlsVmlTd1VLNElXRDN1azNHdDYr?=
 =?utf-8?B?QkRvMmNLWFhMelFYNHdnTXpNR0tzNjhGQ3U5LzNIWndzbnBtNmthSVJoZU4r?=
 =?utf-8?B?ZlAxQS9VWm0wMW1qbWZ1aXU4dlRoUUlrdFE4QlE2cW5wODdBYytyU2NOYkJW?=
 =?utf-8?B?YzVwaCtIemFEMVJRTXl6OWxHek5CTFNGVkcxV1Z6aE9TeVBPK01RYXpBSUc0?=
 =?utf-8?B?UjdzaDBVUDl3Zk9aRklDSElPdE1qUU5PdkZMQUtWdklKczJvTzJoUzdZT3ll?=
 =?utf-8?B?ckRuT1NEcThqR0ZPNHBuUWtLajdXcDVaMmlVZFlSU3plSm8wU2ZCUzN5MTJF?=
 =?utf-8?B?U3NVU0d0MEJKVFBVNldiTE12c3JEMm10SWV4eXlNT1poVlhmUG0yeHhKV0NN?=
 =?utf-8?B?N0t6T1A3RTRFbUJxck1zTXVQUnhkMmRVWVZUeXI5Mk5yMTJuckYrZjd0SGlU?=
 =?utf-8?B?ZnNrWDRuYXdCaElpejREaWVRUGVNRHBUWFNEMXRYdmt1MWhoNjVnMzJtYXBZ?=
 =?utf-8?B?NDA0RHBHUDBZNjRBcVRNdTJsa3RzSWJjQVMwaXBFN3V5Q2ZhNmJkYnNWN3M4?=
 =?utf-8?B?aHhzQ2U5QlJHdWxlV1hFS3lrK3FzUnVQN2duOTFXNGtHRkt3L2NIeUdibnJv?=
 =?utf-8?B?d3lDZVRiTGM4TTkvMXVSd0VVSWRqUndSUHJmTEtmR0hQSmM4dVViNjdTMmNn?=
 =?utf-8?B?QUNhb08zQmhBYm5lS0pCcWV1VEVCQVNESnFuVU5DVWp5dDVLQUkwdjg1WWlI?=
 =?utf-8?B?bVJjemVISkhqNmhaN0F4aHQreEd1MXRZQVhpcjhDaFlYejdVSlA5ZVFyL3lw?=
 =?utf-8?Q?oISM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b876d862-5dcb-4cc2-64de-08dd6069fa6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 06:57:24.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9EKmKumndQrWeNd+g2wcf28iZBAKgA6s2N4fNvtMNUkifUDz1AbgvjXyz1itxs72iDCBqqMab98RsKB2psvdHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10517

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlyaSBTbGFieSA8amly
aXNsYWJ5QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDExLCAyMDI1IDExOjUx
IEFNDQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+OyBncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZw0KPiBDYzogbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgU2hlbndlaSBX
YW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAzLzNd
IHR0eTogc2VyaWFsOiBscHVhcnQ6IHJlbmFtZSByZWdpc3RlciB2YXJpYWJsZXMgbW9yZQ0KPiBz
cGVjaWZpY2FsbHkNCj4gDQo+IE9uIDExLiAwMy4gMjUsIDQ6MzMsIFNoZXJyeSBTdW4gd3JvdGU6
DQo+ID4gVGhlcmUgYXJlIG1hbnkgZnV6enkgcmVnaXN0ZXIgdmFyaWFibGVzIGluIHRoZSBscHVh
cnQgZHJpdmVyLCBzdWNoIGFzDQo+ID4gdGVtcCwgdG1wLCB2YWwsIHJlZy4gTGV0J3MgZ2l2ZSB0
aGVzZSByZWdpc3RlciB2YXJpYWJsZXMgbW9yZSBzcGVjaWZpYw0KPiA+IG5hbWVzLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyB8IDIyMCArKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDExMCBpbnNlcnRp
b25zKCspLCAxMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90
dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+IGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVh
cnQuYyBpbmRleCBmODMwYjVhM2JhOGUuLjkwMWM4MzQ2MWJmYw0KPiA+IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gPiArKysgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gQEAgLTQ0MSwzNiArNDQxLDM2IEBAIHN0YXRpYyB1
bnNpZ25lZCBpbnQNCj4gPiBscHVhcnRfZ2V0X2JhdWRfY2xrX3JhdGUoc3RydWN0IGxwdWFydF9w
b3J0ICpzcG9ydCkNCj4gPg0KPiA+ICAgc3RhdGljIHZvaWQgbHB1YXJ0X3N0b3BfdHgoc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCkNCj4gPiAgIHsNCj4gPiAtCXVuc2lnbmVkIGNoYXIgdGVtcDsNCj4g
PiArCXVuc2lnbmVkIGNoYXIgY3IyOw0KPiANCj4gT3ZlcmFsbCBsb29rcyBnb29kLiBJbiBjYXNl
cyBsaWtlIHRoZXNlICh0aGVyZSBhcmUgbWFueSksIHlvdSBzaG91bGQgaGF2ZQ0KPiBzd2l0Y2hl
ZCB0aGlzIHRvIHU4IGluIHBhdGNoIDEvMyB0b28gOykuDQoNCkhpIEppcmksDQpMb29rcyBsaWtl
IGxwdWFydCBkcml2ZXIgbmVlZHMgbW9yZSB0aG9yb3VnaCBjbGVhbi4gOikNClN1cmUsIHdpbGwg
YWRkIHU4IGNoYW5nZXMgaW4gVjMuDQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQo=
