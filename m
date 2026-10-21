Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792559997;
	b=XQ87tPJoUUwK3ozoPIYZMuCuNOpvNBF+IwS7UIQBYxblXuKs0NDHqr8mxb6QywTUb0nR
	 GpYuo1JbWWj6tRJkpPHZW8TfoHL6FOd/X4yQD60n2hNNNpp2HY25LUUVD70wkD9yuu8+2
	 ApRICVX9GaHHJFG0cd4GL/fgjSOBDd7mn3FLyra4xFO+6r2v5bd5HefhcFPtk3HbueixL
	 lqAqsD/BiwEOIA6MEiaYnnC5KNMIuTKmG1UyRqjzX56HUT/D0uxm7mw5hfvxqXJjbrWe7
	 jJSJ+VycvjFM1tTX7yV5/DKnj9rDrvun6YYvUuw6m7hsMoWLVsvtSN8LTwakkS6CnkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559997;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
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
	bh=v2RAg2fHyueO8zRhaBKxtzBId2kU4hiiq+EloxMBeWM=;
	b=ovEHf76MtfeBFZuNSkiogBLg0cj001yUQzwkLaMAcwS+qw7xYVVsSjwjQ2d3kCyIhjK7
	 PNu+UJG8rd6Vur7gDgqk5avsbC+9OKQQnqIeKFeciJyH1Mf0HWIxmQ16S50wfPXQtR1a6
	 4sHsX+5viQFJspsFSjvPFM7ffEQMSaJH+KJzbdcIsGLWPhqbPlFho5fVzjtLCuhK+J4xA
	 PB+uvmCRvdxIsfaG3rYW+0W70Sr341hVUSP/FsEpw0U+eesIJyYuPYkScP9ewJ/vDhCZ7
	 iWFS+rnIOH1zNBPXirHGQODX3wVB8B6OESsfdpPPbhEqrSS3WwBgHw2wnuTeuRWQZlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b="t4/ftJsK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023108.outbound.protection.outlook.com [52.101.83.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F4B606A319;
	Wed, 21 Oct 2026 05:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88F4B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=t4/ftJsK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlQ5p5vsxtjJOObhVAhrxRqYRfAQCf0Ko6guy7iahi6zucmQsnmSJP1PZgSfOhdAceJ2f0FiCOJR2E7T+kef3g078LwEfV1OQjN5ZpVGFILJpdaYb9080yMWtBH9qTJQ1Mmunv5JdYm/t4hZ9dJ2oXJ8GwPRAezinDTlAZkND5/55kbLUJoFQMe2gU/SM7JMoebOSyFBWSL+icKBqi1XerjoNxRAuhYvZAYPBNWWQ4l4hkNAV23SkOl8T0mZVyNmawT+rITMkuyRCYeYRztkdYg8zQruXLaaIehiyGdLruQHH3p9FEyU7ul2iO99spaHLTHQliwFsEnyk+EMVHonOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2RAg2fHyueO8zRhaBKxtzBId2kU4hiiq+EloxMBeWM=;
 b=wF7MPnCQEwz5rbdmj7gqYYsX6tpDVkjTixhohcQ99h6XaqyEB1XJvUZkm6WeHqMiUTHfEciOHdmQbE3EohwBYKo1mirT0SKfXLQJgEdWQ1pw3PVK/ZYznirrCVBTRAXtJlBYnk+WeSU7dWgUX48g3B48a/wxI7h2fzT56bds7QqZGqTlgfJSo2+ENOvfqBI+gGT8BtcUCmcMFLYOX6ob+fe81B8P/blE08TGZ1sBDSHf0BeZMw92aB6yQ2ln3TnvIxUUC3G1H6WCoENWAHMp742bZ8xeZ4qfHxJr5VPzVExIIPa4HwJK7gWH2HhzPwhzWr/t8s4XbuxoOG2MLOqmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2RAg2fHyueO8zRhaBKxtzBId2kU4hiiq+EloxMBeWM=;
 b=t4/ftJsKoJ7nPpsgksW/JSuDPRMLoIixDV3F4NF3/WFCfMksICVONQ/9s8kLfVzVEe1Aj3xkujOaL6EaUssmCC58B2lLrRfHYNJznZUMKrjhFlLBK+dSi8y55UN00QInhkPLUGa66AO633RPPa/gzsv+ovt13l2hQSnQvR1ZtcSgydE7++MBWN4/p4Sy4DxWVgt8YwoKkSbtwwGA7TUZquwYN94k7E1dd5B4PyIZ0qSwki1yiG/S09JWO+FCkKDpSyRAXHS0GoacFHCpPbTnkp93eU4Axw/pprmIM3ZOYoE+l5eLT46ZrLOXFocJiQMtCflynBEaJVrzNKHlIm0rIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from DB8PR06MB6441.eurprd06.prod.outlook.com (2603:10a6:10:12f::13)
 by GV2PR06MB10300.eurprd06.prod.outlook.com (2603:10a6:150:2fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:19:48 +0000
Received: from DB8PR06MB6441.eurprd06.prod.outlook.com
 ([fe80::2e1c:62a3:98a9:35f1]) by DB8PR06MB6441.eurprd06.prod.outlook.com
 ([fe80::2e1c:62a3:98a9:35f1%3]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 05:19:48 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH 0/2] serial: core: add transceiver interface select GPIO
Date: Wed, 21 Oct 2026 05:19:37 +0000
Message-Id: <20261021-serial-rs485-mode-gpio-v1-0-80d7b0903d93@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGlL2GoC/x2MWwqAIBAAryL73UJK2eMq0YfWVguloRCBdPesz
 4GZSRApMEXoRYJAF0f2LoMsBEybcSshz5lBlUrLUnb4+WbHEKu2xsPPhOvJHqnR1jbK6kVJyPE
 ZaOH7Hw/j87wez9P9aAAAAA==
X-Change-ID: 20261019-serial-rs485-mode-gpio-e76bb72b6f21
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792559987; l=1321;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=Q4rN6dR0djUM/d4SxaNFgE/oSmyrDbm09qyeZ3Pnuao=;
 b=Zx7Z9/CAAGRcPRzRTJLq18U6IzmcdQ3uyhwLpekdmg+vBIAL0eSeZ9ucj1ayfsgMdFpPH82H6
 Wix4vHqRtsZBMDD1E6HnGejETHWgtyo185KFa6wvyNOAFPorJmgOmRc
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3PEPF0001DC1C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::105) To DB8PR06MB6441.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::13)
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
X-MS-TrafficTypeDiagnostic: DB8PR06MB6441:EE_|GV2PR06MB10300:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8d11cf-0364-49dd-b051-08df2f32ecf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|23010399003|366016|56012099006|38350700014|11063799006|261009223027099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	sb7gvP+qdd97v8GG9sh+Miw8L7I9UyMhee5xtnMD+xd/8/hy4V0r28Ce64aafv3kwutTrI035rqmoXlux7yv9KQtQqZy42IyadgFO/3yrhPeGNlV56kr9pTPabkkcwZb7nlCvQBndRV7+qj633yzjWNzRAC1FQPJr81JQF+VcKGbZe3mfr07sOCspsQUtXGUW3T4hXmpDvAoFncL32VWTdG4lQodRHSH1bLtAocO3l781+LigHVABJIqChFsKhVeubzUHxWmnAqxNY4r125tZGLN0pbdbFudQn2KuKZuNjlp6y7A68dO/gz/2DXBvIng7M+46lerLrPaIZaUE8sGZe7UB/HHopyy4E5k3cEM16zcs2jvp7NZMLMoXMI2bnzFYEe7c/Z3eFd01SeY/D/tYOf1z8tGjb0LUtdxIkNiYyG5l2WaW8vauYfCGuGhrTwl7BOP6q1V/XdbQ05kY02CTq83az6C5ELXk2cQO3ThvbUx9onoELrceG8i9cE5uhud0cOtJnpCMCKimk06Kt9js47wTz7bwGB6C3WYqNLhrWd6czUKhQ2LZ3Hrxedus/4F2l9/ntt2FFd6r2EMOETk9o66cyHNs0gJ8UQ0Clt3kRKUVETm7K2RV+b/s6YqkivPD0WwHrKmYc3MIHax5nArNG5yRLYyY2efgH7ygIpvQ/R1QHjQ0KAxgAsFg9GB6ssLC91mAzhPFr5j9pZxgq5R4sKY00FXhyqzgu59qeNMDsM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6441.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(23010399003)(366016)(56012099006)(38350700014)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVZQU1BnQ0xTRGkyclJhSDV0Vms2ZGhweEtnTnl1bHNYRy9IZno1bVJrZlhk?=
 =?utf-8?B?UE5qbTgyYUdjL2hXYTROS1k1elp6NWRxUU1pd0JEeHppTUJzN0gxMlRPMS81?=
 =?utf-8?B?dWlQbGVieUpYV2VDenhjSWhsZ0FmWkVlb3I1aXM4OFY4YWdqWi9xelcyaHMv?=
 =?utf-8?B?QXppczB3dG8wZ0J1anh4SWFZZ1lpNHNXMGl4c3Q0RXpxcm1HZ3p5YnplTENx?=
 =?utf-8?B?TFlQdkhwMlVSVUlZTHRXblRvc2NtRSsxWk9HWk1pTjQzbllPaVo0YWtwUlJ0?=
 =?utf-8?B?cldiZkZTcEJ5NUk5VWh5TmtRbDlOczhON3l3WWhOeVpEMXNueC9yczFVZTNj?=
 =?utf-8?B?TWNRcTdocnZCdEd6Q1IzOGdDdlFtbjE2UVV6eU5uczlKQmhuUzJVUTBTQWND?=
 =?utf-8?B?MVcxblYxcXhLcFRPSm5IdVNLbUNLY08wMGswNi9TaU5GM3gwNVR1OGNEQnhl?=
 =?utf-8?B?ZG5lRjIya1JvdEc5WG5NNHRGWk9JdHhYT3VhNHlpdTFhMU1jWXJQdmpEOE5s?=
 =?utf-8?B?RkJVVlljSis0SnBoSC9PWWdyeG1VUmRNWW9KQTJuNDFqVG9RVlYyVWRiRjc3?=
 =?utf-8?B?bTRxVDVlakoyS2sxanpKTFc2b1F4MTZESGdDZ3RFT0VRa1BSam1qZWJzZGRi?=
 =?utf-8?B?d200T2haOVNTYXJIVmJhejB3Ri96NjA5V3h1cWg0YncxUFdjd0lVRkxMY1hO?=
 =?utf-8?B?ZUVITGcxdnpvSXJPVmZ4WW5YYzN6MXo1cVp2emt6VFY3VVZMVkdrN2pzemRF?=
 =?utf-8?B?YVNvcFhpeUhiUU1KOU5qMXNiRm54M0xpejBZOStLQzFtZVJZSGx0emlVOWtS?=
 =?utf-8?B?L3hNa1J4akg1ZmYrdUhkMXlvdHF4MWpONmNaWmVNK29La0pqaWJGU0VsTmlp?=
 =?utf-8?B?Vnc4dGlha3kzbWNJNEducUtsVjJsbkJ0eGRwb0NBcTYycEpJUk5mYTc2SkZo?=
 =?utf-8?B?RnpWSG5IVVh5Q1NscnBnWGthVmFxV2NXTG9jTlF6RkhzZnlZK0M1MGk0Wmlw?=
 =?utf-8?B?ZUtybE9PVm1Ta3JMejZabXFyWWltQzZqS2VLeGxmV0JFNStIYTRYdU9jdmZF?=
 =?utf-8?B?Q2ZuWldYMU9kbW83dXhuWlRFRDBTR1ZkNmpzQXVyb01MbnMzNTdjU0Z3Ylpx?=
 =?utf-8?B?WFdSRjJVU1M2a3J0Q1hyeEdUNXFFZStpWUFESnM5a0E2VjQxVmV3TnNHMnQ5?=
 =?utf-8?B?OUdNSmlEY0RRK3dxMTZVZ2RlMzlyQUdjblpFbVM5cUVGa0dyS29HTkhhd1cz?=
 =?utf-8?B?RzhOY21aV2w5TlU0QjNZR3lRemdPL25pYnAyTWRVbHU0UUNGb0dUc2wzZUZS?=
 =?utf-8?B?Ym4xMHl3aEgzVGRtOXFsc1YzMURHREZOTFhGbkZjcVdjMWlkQzVjSm1lWjJN?=
 =?utf-8?B?Y2JpNFlWOHE1cGhrY2tmUjFFenBnM2VVbnI0OGpYeUlmdzhJVTBnd1lWODkw?=
 =?utf-8?B?WTlLMlRFOVBjcCtoVitQVWloVWRDczExeWpNcHdjT2o4YjZveVpBMlRzSVVW?=
 =?utf-8?B?OCtUa3BBYzFaUHBmNWNzMk5ncy9DYmFyTE1Ed3RpT0pQY0Ird1hZZEJMQjB3?=
 =?utf-8?B?c2prNXRpSmt0RklRQUxZeklNZ2dwUXJZaWszVkZvRytEaHBzZFo3M1N6TzRj?=
 =?utf-8?B?Z0ZmWHo2SS9YVGxDaStld1dlSC8rRnJzL2k3OFBxdDVOSGJ6Q0FuV1V6VXFG?=
 =?utf-8?B?cjl1akl0b1RWbTdyWU9RWEZ0QlJORE52YVRpRjRRMXBqaFJxRzhVN1JyaTZ1?=
 =?utf-8?B?dVJIVGxuMGt4RldhcFNqeTM4TWp1MThKT2dpM2xLSUNZRWJ1c1k0aUlZVVJI?=
 =?utf-8?B?TmNGYUw0eE9Ub0lBZXdMdTR4ZVZ4d2FqR2xQLys5eXFYRzlLclkzY3pQekdH?=
 =?utf-8?B?UDVBMFdvSDZ6T0dkQUVsa29QSDNpN0ZYZ3VNSEpQOEZ4VjBqOUFzSEZLUjdi?=
 =?utf-8?B?TXZSdDZlV2dsSkhDN21nQjZ5clhMM2lGRXk1RU9tL3JxL0VRT2xSVjlpYU1Y?=
 =?utf-8?B?dVNtUjV5WkN4U0tnbUs1cDlrelNIVFlBRHRYQ0lweFZXQjdwUHZjMkZSeU5x?=
 =?utf-8?B?bE1tQlZ1ajl2ZGVqRVBJTDVwb0FRVmEreVExd2JCWHFMNTV6VDlrZHNYN3Ni?=
 =?utf-8?B?T3lwbUp3Kzg5ZFQ2c21YeHhSSmpGek1kZmtNdWZySUdGZy8xd01uUTJ1RGFJ?=
 =?utf-8?B?b29vcmE5cnRjN3F0cUV3MWs4VjNibDkzMTZUSUNMY3FBczAvUXo0S0VONzll?=
 =?utf-8?B?SnVKUDEvTHczbEY5V2FZbTlleG14UHpuTE9pZnVRbTZGbFBpYjdaMzZialE5?=
 =?utf-8?B?bFpjekFYUDMwY0xzT1o4YjliSkxYS1pid1FtTks0MmVOc3g0bENPV0cwNHR4?=
 =?utf-8?Q?c+AF9qKKozqtluQc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8d11cf-0364-49dd-b051-08df2f32ecf4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6441.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:19:48.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9ygTXk64UlxshQzfIDJXKhUKdGXPiXw5pv//3qVWRV4PLlkrmU/lE3ufQcEFBTHiqWGIpaF1FpIu1qjE+OyUgtMsRJmqRsWdna9hsM+UcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB10300

Multiprotocol transceivers such as the LTC2873 provide an RS485
interface and an alternative interface, typically RS232, on the same
bus pins and choose between them with an interface select input. Add
an optional rs485-select-gpios property next to the existing
rs485-term-gpios and rs485-rx-during-tx-gpios, and let the serial core
drive it from the RS485 configuration state, so that every UART driver
using uart_get_rs485_mode() supports such transceivers without driver
changes.

Tested on an i.MX6SX UART and on a MAX14830 channel, each wired to an
LTC2873, by observing the bus line while switching RS485 on and off
with TIOCSRS485.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Tapio Reijonen (2):
      dt-bindings: serial: rs485: Add transceiver interface select GPIO
      serial: core: Drive the transceiver interface select GPIO

 .../devicetree/bindings/serial/rs485.yaml          |  8 ++++++
 drivers/tty/serial/serial_core.c                   | 29 +++++++++++++++++++++-
 include/linux/serial_core.h                        |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261019-serial-rs485-mode-gpio-e76bb72b6f21

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

