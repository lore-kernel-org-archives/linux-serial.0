Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794904680;
	b=ROeI4s1qKE+TLUj+dSdam1hILatvRDzW9kWAoQDS+R/a697kuRJSiHGEfk7DyE9wFZNr
	 /x9LXGIias1F9HuQMBTT6Gbo6K5Do3JntDCAYAtu+IulSbk2IV8fjqSf0+97YElsnooyX
	 dhKSOEqRqpbgs+f52Eg+iU+Kz5LupGENqleJpv0jCJ2r15DVBGMzF+b8F0rZnkLemJ2Vq
	 2sY6f6xJlmtYZIfuGfsIg4Fnny+hV0QQvYjaCg82G8KzuouZ5zBUniDqAW1tWaUSB8O12
	 +jXEjRy7W7hEtKBQvds++ysX5oScVDhTqkMyg7qRzj48dUJxG1Ydcvb5WVGHUd9kYVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904680;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=c3VIxYS06Q6WVtsY3UAWo6bC5E0VPya2kMhXSYyIKVA=;
	b=0tvVsUuJBVrFUiR26H7xGIDu6G+mzfX1NemqfylTcvgKPwW5ScvxsLJhXX7pGT6MQtTT
	 jrpXcyhgctb8SP/58FZ0wDNG4JYaEYGjOTaYvVvVb8kpU2tBCQsUSOGUNWakA8rdHfNF1
	 BAV6Pyk0zbVhcrHBlkhxFjwtqzn1bF97kF/GXLZXAUxR8Rc5QEFdxCTj6bQyqhZmQ/R0x
	 pTRGTUGiTY7thSJkXPd0aIAbKuYlMjYSIaK8HJC3h1GrlGH93C1QLvNanmyOLQALNmqjR
	 ZKbfIuXMV0wo/f1Bmqciy2i/krfiUBtLfppnyu2/aOsEMXbdG4HvNrK8IJIL/CmVBnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Zd8uIDsx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.53
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2872606A893;
	Tue, 17 Nov 2026 08:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2872606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Zd8uIDsx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFLaFVrrSjtvrfCssYJ6KJKXQrhuMH2ICN9Pu3hgekhZCgZi7ZL2cKwx8GiXZHgf2FzNbU78j4ht7hHOXdYpvbOROeh/qWfmYkoyP2ntA4FnQqyWaJ3gITgPPT/pYIUWCRPWExGu7H+ZQOkogrSWfOu0Y3NFOOgvEGfVu8FpA5GzF6ZFubCOhMq6NT8XOs+gp185dT3Dt3vxse70BY9o0UnnZGaVt+qeYTA0G3YE7ro32kur1wph9+xkwk6AoWi8bYCO0BbZgIxx0+OJrCzbO1OFwdGpt9m+FidCsA0jD6CHfPG+ZQc9B58Y0GGRPRFOwRZNl9JHEEKcZ0pp9nApkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3VIxYS06Q6WVtsY3UAWo6bC5E0VPya2kMhXSYyIKVA=;
 b=wLuCNb68LebDHaHX/fEq8i7MeE4YcYkBtwUS949/yKe7egGbqqWuI2tGXIXBPj1mWh2fHDjA9zG9V0klMxmyp5VRqUxDGAvR6BpcUrLCk3YBlX0lNQYAS2P9hrJm9pyS90zJYy1wdvX2EqoVakdRuAosLNZPMcetZ5p4n1dhTUqiPePz5ta5N12t7NJT9QhUkhoQ7orR2Oe7m1XHiNbX7/tmgsooewg2PbvH66NJ5UlnxsJ98OCG4V3V5cIbPaYFwMJP4Fu/25zq8E/hrScJHnPJthDrGIYV08gKdUOyTy3nffBLo4pUD3c8Gn83rjfmAC88K+zQTBEbnPgms8gU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3VIxYS06Q6WVtsY3UAWo6bC5E0VPya2kMhXSYyIKVA=;
 b=Zd8uIDsx6j99EYFw6qSwQhjl+JEmYp1GknobLZERO0PKUkfCu9soT1n+/SQCgUgJMBau4QwoAMlwaw5pwyzrNeaYGSM5jhtJc8E79Rzl+hl2YDfU+0dNrKxvhzTwFGSrknx0fRDIMYQBzt9fke6pSAXDB87cKsxN5OgtNZe44Te50PcqmUICUB0J7Mohksr6fbEp8Tuv9B5LQFJ/j9LB1Ir8Gm65iaofwCPRxV52YqZNPab/SnvOvgeA2OGuTrQeIB78I6MTUlmpBNyXp4ZhBdsPv6hs0cdmS9nuAu3pQDIor0Vx25q6OKhLFF7tnx++OmDlV4zLLd11gOEg0OvSaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PA4PR04MB7613.eurprd04.prod.outlook.com (2603:10a6:102:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 08:37:54 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 08:37:53 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Date: Tue, 17 Nov 2026 16:40:32 +0800
Subject: [PATCH] tty: serial: fsl_lpuart: fix the RTSWATER field mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-lpuart_rtswater-v1-1-c2a95ae804f5@nxp.com>
X-B4-Tracking: v=1; b=H4sIAP8S/GoC/x3M2wpAQBRG4VfRvjZlKKdXkTTGj11Ce8ah5N1NL
 r+LtR5yEIajOnpIcLLjbQ3QcUR2NusExUMwpUmaa60LteyHEd+Jd5fxEAVjgaws+r6sKFS7YOT
 7Pzbt+34fFwV1YQAAAA==
X-Change-ID: 20261117-lpuart_rtswater-eacee387bb89
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, sherry.sun@nxp.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794904847; l=2684;
 i=sherry.sun@nxp.com; s=20260723; h=from:subject:message-id;
 bh=M8EIQJomX+x/ECvkGNK5bCVYocZT+OGwXmzn2JIkoUc=;
 b=FR1ljmH7QdeI+A/AoWJnsm/eHH2mHDmXo4vtcFa4TgEb73KOhQ0rIUUOkRYwXwKP4tqV8ORrT
 qk1x6zyzkc+Cl+V1kLDUZxK5zWndrS0dFFkw3kPFGkme8kc7MM9dAge
X-Developer-Key: i=sherry.sun@nxp.com; a=ed25519;
 pk=YnYnIFJ2l+5v951x9shBVfHhminNi+3LTfFa3PxSdnI=
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
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
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PA4PR04MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: cb371e87-e7c6-47ae-f444-08df44861285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|19092799006|11063799006|56012099006|261026140227099003|261028144727099003|10067099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|261009221227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lvqEEVO8OQ5zONzq9gDPes5+MlItJHU6stDv4vl+tn9d92eZT53E6E0l2uP7BKUjAMcNoDh0fXs0nMX/1XNvGPb0t5ZdadelNKU/J6HgRcD62mz+pp+k7iuw0URVOh8DTFfRwksSTgV3eaLYw5/APevrC3W3WfcEKT9M5JZ5QnMNCGcolU1+sVFAwGPR1AVxohuHt9j1rqIVE2Z13kq4uVaSnKi7UX9NlNMI/NQ0RuILxBkupeNw8EMQjxtzkC0fmFGmKOw0dALSPbEIhG+Xhoob3k14VnPtFYVEZyKz49yN89VRUPoneFedRADUoesIOyyX1z08e7YvscJUn48Uy1EgXGuiX6pJLPdYF8Dfe3zODo/tAcbzHhNOR3+RM4pqU/kKtHYUfKg18aGcr4T9YZLk8hX4a+h7F3WqpXT7DA9QuJNQzIjeuHn4iKNm95V5/duNIOcsaut1beUjrm/ASZ7Q6PLg+MYtaSLsNBith2dwCzagzbsxK2ozeqKHyOO8jTJuB63ytgJ6gWkZZotmlbJ8EELK/kFfO9c1+hL1MGNTH0U8eDRxiZJxmKsC/VZKxbgkBHzu84R1kKdzbQyfB1z9hs18WfpxGKh8KlIBMtbTx8ZwHW8Yx6uhiDQ/bThov6fM6g4bmndfy4qFFkKYVQaiUjs03WaKJp3piWDtiVc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(19092799006)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0xyQWt5ZS9uWnc5MFQyNnpkOVRuZmdGc1pCMmR5OGdVRWN5MVNPQ3RvbzZQ?=
 =?utf-8?B?YkJ4ZExBWlo1VGFTZWdEVzFTd3JKOW5mazFrRXl2dHg2bjQybjZBVTVqQXpO?=
 =?utf-8?B?WUNJVTJjT0htdEU5dmRVSFlPcmk4d2ZWTVZWVnBQR0t3eTlHbnk4SHYzQ0M4?=
 =?utf-8?B?MFFuLzNkRTZqdVcwVWRESkVtMkdYSWNYdUlIOThlVFZSeGVBYlozbWk3TElU?=
 =?utf-8?B?VC9FblhZdTZFRG44OFg2Lytva2xJeWI3NkdZR0Y3L3Juais0MWFWZHdzclpz?=
 =?utf-8?B?UE5DVHZ4bDkraSs5eWEvb2lybW9rTk1IVUtCYUR1eEZaK1FBY3AxM2hDdEtY?=
 =?utf-8?B?RWdBNTRCTzk0bEErSXVoV1l5QzhLQTJYdWFER1J3cURaMHBZaTdzZWZ1bGVn?=
 =?utf-8?B?SUdhSnFIUVFEU1pZSlF6M1M0dndLelJ0dTg4aFJrOHY0SXUrV3FKR2MrdjVF?=
 =?utf-8?B?aFRtWEJ4QXZBaVY3WjRZeC9oZzY5UjQ2YUJ6YmxhYnNMRnplMTUzMk5BQlZT?=
 =?utf-8?B?Z0c5SndoeFBYUmpVUldYR1NKclZOUEE3YUkrVDNZOEdybS9HNlFsaWlYcFRB?=
 =?utf-8?B?R2dKNHJrMUlLV21DMUt2eXRJclFxL1hRMUVrTUpwazhnNmRQRUFFK2dXL2tl?=
 =?utf-8?B?cm41cWlxcDRObkJOVTBnUXltTnhzZ3VMblQxUGhmeXFDUkJmMWFoMGY3OVZw?=
 =?utf-8?B?K0NRMjRLbkpyQ0tBNDh0eng1L3M3OENHOVF6TzlpNU9IUS9qMzdLakVRaXBF?=
 =?utf-8?B?UzhIMWFCTlQ4S2dvdE9COWNXZ0FhRVhScENDSUVvY3lSQmozbk40VVJUN0xm?=
 =?utf-8?B?Q2I1T1dTbjlaOThmekVYN0V4WkFITlk3bU1Dd3JVVmN5ck1oakJockZ2T2Fi?=
 =?utf-8?B?UHRhSmFReGNBdnQrQ2hWR2ZFNjNndy9rYm03OGFOUzJoLzBMN1llZHFkQVJn?=
 =?utf-8?B?TkdQSW51enovWW5wclZRM2hqODIyQUVTRmloOU5WdXFxamhpdTdvL1d6ZmIy?=
 =?utf-8?B?b0U1azlJV240R3V6U2h6VXNEcUR1dFRGUFJEeUZsRVpxcVFVQTNySXV5c3RH?=
 =?utf-8?B?UmlnSnpudGtSSEg1MTRiNlE1Y1pIY0RORU1sZVZTRFVVdVFrWmtDT1p2R3VH?=
 =?utf-8?B?Qm5uck45MjBBSTVXVjhyYzBJOVZFNGcreERuMjdrSU13MUZ3ZXNScmJhRjEy?=
 =?utf-8?B?WG9oNTZBcFBiYzF2SXF4VkU0L29XWFN4ZGpTS1M4bXlmYzZVWTJmWEEyOTcw?=
 =?utf-8?B?U2UxUEhzVUFSZGxCdDVXeEZ2S0doS1UwSnFCb01obmxsclErYi9yOExMVm1F?=
 =?utf-8?B?bmZQZitTWUhKLzhPZVgrWnFkVXY0cVZXejRYTk5uRjJWS1NIRXF6Q3dPYUdS?=
 =?utf-8?B?RG5FVmxiRXZWSFRjUHJ2RTZjWFNuMjh3UVQvMDUzTzJacDdSUHYvbDNJajBS?=
 =?utf-8?B?cytMbU4wVWZ5eEpyUWpHQWRGNnpjNGZNcWdxUnREaVVKaktkSHl0Q0JDT1pv?=
 =?utf-8?B?M0piazFiL1I3dmZZOStIMjV6aHh0TFFVTGIzTEJsNUFDUTJ1VWFSVG5IY05i?=
 =?utf-8?B?dFBGRndFNldrY3RUZEtQSDF4Ukt3UTUycS92U29zMjdyaTVuNnVjdmdLNVEz?=
 =?utf-8?B?QzVxTU9LclEyZnFDNStnZ0hlRVFEMGRMNCtDWHR4aldKTFFiMFhKdWI1eVBv?=
 =?utf-8?B?VTMvS1JjQXNpajF2RW5iN1R2eTlOMmdKUVVlZ3h2WkJZK0FMRElnYkNsaWdR?=
 =?utf-8?B?bk90dkhqK2d0SkpzWEtKRjNSOVVnSWlqV0pYTUc0b0JZMW45MVlMYWVGQ3I2?=
 =?utf-8?B?aEpKSWU1OW9DQnZtMHZHcWVNTlZlbzA4SE9KTmUvY0VGdG1rNnV4MVRnTVFH?=
 =?utf-8?B?NEtadGZZTmVTZitmS2hxS2J3dnIzNzc0ZmV5MUpxQUNWN1E4cEV5Nlo4cXc0?=
 =?utf-8?B?MmhqOTVDaWd2eWd3TlkvMVJuMzZYZHVxN2lDM1ZneGdmM3pqSmluQ3FuWWcr?=
 =?utf-8?B?NVgzYkNHWGRxcDZDbE5NZFBlN3h6TW5DSnhNb05aWmhycWJxOWJzcG1rMnND?=
 =?utf-8?B?UmdDRmtqNkhzeGltYWtnbDhwQWh2eGoyYVdKK29GV25meWpnRFpFb2dpNHNB?=
 =?utf-8?B?V1BDbjNuaFFpKzBOSjUyeG8zNnJrc2Joa2gwaE1HTG1nbHlQckR1dFp6aXZl?=
 =?utf-8?B?UVFBS3pQZUxwQ2UxbjJXSjA4bjFzY05pak9vWmtHSW1FSEw0SUlxSHUvbFRN?=
 =?utf-8?B?MFNFYmU5Q1Ivc0hBT21IdGxtVHhLTVcyOXd3amZ3Y0pBdnIxNXBGVzhoWE4x?=
 =?utf-8?B?c0l1Q3pYcnJaTmRyUHlrTW9yM3RaMUxzMXFRU09scnZ5Wno5U2FlNkpIbmJw?=
 =?utf-8?Q?RLSw5Z6xfockELrVbZowyVn3hzIuaX9XsEjoi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb371e87-e7c6-47ae-f444-08df44861285
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 08:37:53.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnJB9s7sts0aDGwcj4MfFMh8J8Nfb84I22beRHSQFMwX87lw891eGdIMyZCjYQVVA8HxImmjoGbTaHMEQV0QjY00tcXUqLxxA5V4SBHQO+0+9OCqt60SLCxc65KQFnkc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7613

From: Sherry Sun <sherry.sun@nxp.com>

UARTMODIR_RTSWATER is currently defined as GENMASK(10, 8), which
matches older i.MX implementations where the RTSWATER field occupies
MODIR[10:8].

However, newer i.MX SoCs extend the RTSWATER field width, for example:
  i.MX8ULP       MODIR[10:8]
  i.MX93/95      MODIR[11:8]
  i.MX8QM/8DXL   MODIR[12:8]
  i.MX8QXP       MODIR[13:8]

The driver programs the RTS watermark using:
  FIELD_PREP(UARTMODIR_RTSWATER, sport->rxfifo_size >> 1)

When half the rxfifo_size exceeds the 3-bit range allowed by
GENMASK(10, 8), FIELD_PREP() truncates the value before it is written
to the register.

For example, on i.MX93/i.MX95 with a 16-byte RX FIFO, the driver
attempts to program RTSWATER to half of the FIFO depth (8). With
GENMASK(10, 8), FIELD_PREP() produces 0 instead of the expected
encoding for 8, resulting in an RTS watermark value of 0 being
programmed.

All currently supported LPUART implementations define MODIR[13:8] as
either RTSWATER bits or reserved bits. No other functionality is
assigned to these bits, and writes to unimplemented bits are ignored
by hardware. So define UARTMODIR_RTSWATER as GENMASK(13, 8), which covers
the superset of all currently supported i.MX implementations. This
restores the correct RTS watermark on SoCs with extended RTSWATER field
widths while remaining compatible with older devices.
Also clear the existing watermark field before inserting the intended
value.

Fixes: ecba98f9ddf4 ("tty: serial: fsl_lpuart: set RTS watermark for lpuart")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index cd2575a3aef7..97201414ced6 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -203,7 +203,7 @@
 #define UARTDATA_MASK		0x3ff
 
 #define UARTMODIR_IREN		0x00020000
-#define UARTMODIR_RTSWATER	GENMASK(10, 8)
+#define UARTMODIR_RTSWATER	GENMASK(13, 8)
 #define UARTMODIR_TXCTSSRC	0x00000020
 #define UARTMODIR_TXCTSC	0x00000010
 #define UARTMODIR_RXRTSE	0x00000008
@@ -1695,6 +1695,7 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	/* set RTS watermark */
 	if (!uart_console(&sport->port)) {
 		val = lpuart32_read(&sport->port, UARTMODIR);
+		val &= ~UARTMODIR_RTSWATER;
 		val |= FIELD_PREP(UARTMODIR_RTSWATER, sport->rxfifo_size >> 1);
 		lpuart32_write(&sport->port, val, UARTMODIR);
 	}

---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261117-lpuart_rtswater-eacee387bb89

Best regards,
-- 
Sherry Sun <sherry.sun@nxp.com>

