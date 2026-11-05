Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793862779;
	b=cDszZH2ALIYh4bsZAkdaVfvkht4ouim1h9m4lQFJmAFj/RoI+KPMtCTfrFn3N0MqKgye
	 mEJCuQbH2C99uXVJ5dIcS0fP22rbfTuJyf8w0ZwJnRk0B800UhkXfzPasCu9RDIcOPYyI
	 IDNwr3H71c0BK/LBpfmQBEMYk5qyGirNUsfPUdUpWpKi1xY8ICvju2SoZaif3SAeCLFi5
	 ZuwAoUsOcTLbe4+MGBX01cLQ0kqhvasYkaDQANllZ5mLrEVArODyi62kwWnZRPFlTjHh7
	 ULzKrUg/lflr5q2M1HVkNKIaLhWENRBFHYkMuB9yN/Bhmx7SkSGW/3IhT1iNvZLUXQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862779;
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
	bh=OEu5RHTlj9OTJ4RaFhoVwJjeW4OAtL5kI7qzH+pfpZI=;
	b=ipJFTVPryfXU/WiS9hdArZ1VrNozOWqhvrz3xl7CYl1rnjHsDVUXbeqcOcCjCeY3Rtsr
	 pfRj0ClWsN0tjrI9xwWaXMCGmqGgTpx1bN3e4wJ2d4xmE9xFftHG85NF4uvPTB0uj1FD/
	 NGBYzEBkm4u6lUDGFpMDedXkF5T8V8/z9xTKSlazs6FHC76m10g5GntUFnQYUKLQC+c2r
	 ieE54Un+K0nsOaRS+1t2D3j+zy1GsJfmT7t9Pu6KzFyKTZaBW20nur7LHOuulPfzyq3sr
	 D3JqGATV7yADW6IJRP5sDAvaWNvMSQSkUe5c4jMw+mK0NuOENIOdnGpUGr7loR0ES4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=Au07uMNw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.138
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023138.outbound.protection.outlook.com [52.101.83.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986A606A330;
	Thu,  5 Nov 2026 07:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C986A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=Au07uMNw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKCQXg9R2zDWzdJ/HnUISsrD36HuXotwcXLTKPllLYwn1xsywvjSBX5VfWBtYWhUWe/ZGS8132Dt957wyWygvXutPq++pG0Mlj9A1IwrYfqp7mEur9WgR6egWAJPuz9pTzM87GT8c9BNDJ99zEZU3FC0KVdQbWb6zv2bVY2lnPMgy5nHkHDwN3tZ6gptJBsEcDVdez6EQfN+fw8FfaCaKfw+WBp8+58tJ5CCEhcb07vzKQIlP2YlpfFZVKduu4tfxsCBZsBO15V+43/EeWqIcKcIVDpBVe8rDCN+nZMPkc8AezQNuf2u5U9lelHjkzwO8UulwTqx+Sd69U1HTx8BIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEu5RHTlj9OTJ4RaFhoVwJjeW4OAtL5kI7qzH+pfpZI=;
 b=miwA7esFv1uhN3Gvs8nzsqQm6tHA8tF04en0ltceGC8xzysI/h5w5F8T30faopbMZ5PSDiw4L3oIdAthDzuU6WmJ0lGDBf1EvopiyG1VDdJHusO+XeLX787iQoRl39LLaNq3u85ImZxpFd7RjGR2CohNJojV77FUDvwXm2edJ022TOmP/HsbWStBYgYZHo9Ag9mhDAH1rPGVZu7lggJ455OLplhu1GC3mfsKT3L+VgFCdMpyaVrYMGKFNH1GXX9JiQM9XDDhvTIWtKZCQZNogJ5I7Av+wbgCWitmX+3BfDbvODxZzzBNqFA0b+SgF5kKGQgAPaNMA+4ETOIq34A/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEu5RHTlj9OTJ4RaFhoVwJjeW4OAtL5kI7qzH+pfpZI=;
 b=Au07uMNw6X8+fnbZ6YEye/I0FtGRH7kxybjMzK5/0NqZk8utBgSXyRgDoNohbeoGx6varsDdxLVLc8EwMcQC4Wyn0bHUrVzqOrSyA1H2TuNeryMZhlnJ7QqFd0nyY7cA8PmXZ0QArA8yuKJHr1nouZg6l1JefGQ1t1AMd+WducQrjEgo86aAsquxkbAxGgR+7ZEhoIhdqX90YzIWA6DXSI4C9dlxjK+71sofftjuVonPW5cGIGM7ZrRHoNvuYfA7HlGvkfYW4dyXRFJ3KXnMANjWhKbzDOd9SMCTYoEuP2ZgAIfcvDntoNkd8n3UP9XdkfgJwHUMSVVOE6QSb2yv7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS8PR06MB7877.eurprd06.prod.outlook.com (2603:10a6:20b:3c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:12:49 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 07:12:48 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH v2 0/3] serial: core: add transceiver interface select GPIO
Date: Thu, 05 Nov 2026 07:12:19 +0000
Message-Id: <20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMs7GoC/3WNzQqDMBCEX0X23C1JbP079T2Kh8SsuqBGkhJax
 HdvlF57/IaZbzYI5JkCNNkGniIHdksCdcmgG/UyELJNDEqoQgpZ49HXE/pwq+44O0s4rOyQysK
 YUpmiVxLSePXU8/sUP9vEI4eX85/zJ8oj/SmV/KeMEgVWwpZG1CK3df6ImoOe9LVzM7T7vn8Bs
 1nlNr4AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793862767; l=3322;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=GZs6fbmKI9QvNH19tzD1RgfkEpqEyRf3hn84N2sO8x4=;
 b=dsD9PnPwfLqx7nN4b69t8KQ/PSRd5CN6oyyfu4ne5Fs9+dJ0N3JVoVbKURtrMbwkbzNMFGgy6
 ADI5iDd+SgzBcDWm9iShYIFFs8YqzVpwp5Gd2R94yW8MoosCR1x9LwD
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV2PEPF00046789.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::25a) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS8PR06MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee870ec-745d-48a6-2e48-08df3b0c32c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|38350700014|11063799006|56012099006|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|18002099003|10067099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QjZdGihqvTcegMCnZVePSI1bZQmE6QKEk6Huh/Glt55fQ0anzOU8xAoaMXoZEyBqqEQB7WeqFjIEkcDKpsXwaNIeQfRWvhSoLwoUHkecwAQQxnqekp094IQsK5UvTPk9+DYa+QVvWoR4zZY+xwOMi+6q+OFoxwibYttObT240fQluIYKm1xGmq7r99mmME0LEEpguh1a+/8hgcW/e1mA1ckCvwTVWQMpkLY7UFq2W8ca+LKptKvqeRe9P1iqMEyOueOpga+NrmD8UxtGfG3eVV3Py0T9y22hUfVgajYEX3ze0VBdgXS8sQ7L1bkFec7JbTnibMQ6u8ESf/Is/iCE3wOyyYfsRkqgjhLZuQWAUs/qSmZF4BjYAyOqEamT1tmgdLSQDt4/wqqqnA2RDBL4ITeJhNEGS9zuPlzt7WmeKoKgtIQT63Bv8Ge8C4Ibd/TVVQkuZPucjSuzKv+34D3GGbwieGSi/8ttia8vKAGg/+/FJWCKnoCat7dXpDDo6P8qL9o/2CXO8wVCD3x+L32Eyr24CjhVnIKD5xkGbUr0Yyu8J9/k8JjJNZGPH0mQDDaZrJRTaaI+U/3Yxg25VneW9aBFdxruNcFKUJAcj3kWAPdVIbtqiwjoyeOVGq0w0KBtnXjQKF8qJGrtHUbnV5kotIJnZ/aWzaBuYstm1qgq6g4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(11063799006)(56012099006)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(10067099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFp1Z2VOZ2o2RVhlRTBxU3V4Q2tGQnBpN1BCWUtGWGs0b284YkFOcldmMldx?=
 =?utf-8?B?c1pjRXk1YjlyREdhT3BJaG5KK0pFL3BIYnNsZlFEVG5od2hVSDFUbGJ2VVJt?=
 =?utf-8?B?QWNVL3FjcmFKK016RW42bXAxeVM0QWhDQnBzbFNzb0lnRlRmVk55dWlGUk1j?=
 =?utf-8?B?a0pJRUp5aXVHaTFlTkNyd2x5V2Z5RkhraFpNSjArNjkrYkdhelpnaklLOW5N?=
 =?utf-8?B?MzBXc1VsZ056T0lyeEN2Zm10SVNWSHpBZnVkTG4xeVdMbFY3c3hnZ3pnOE1r?=
 =?utf-8?B?UUxRaFp6ODBuVkNLQ0lreklTeGhQUUJ2bmMyQTMxZ1F6SmdXUEhoYm1VMDV1?=
 =?utf-8?B?THdTTVVLcUpYb3hjSjkzRGV5UFRlc0RhRlBTZWlvZ0d6S0gzdUt0R0JPaDJ5?=
 =?utf-8?B?Nno2MlljYnQyTmY0cmhzempvOFFOTnVTZEx5M1J4MW04M2swTUw2Z20zWWVo?=
 =?utf-8?B?NzZuc2orWER0cUdGa0tVMXp0TDBLSitXV2xmOWJwdGJPOFR3VkpBWW14cXln?=
 =?utf-8?B?Ly9TRjdyV1NQelR2d2h1RjdEbmpKcExvUWZsOTNpVFAxY3kxQmNLVXQxUmtU?=
 =?utf-8?B?OEt4bXFvaEQ2bGFnMXREem85VWNWWEpLOGR0YXI1T3hieTI4eTR0dXRRemwv?=
 =?utf-8?B?Z29CcllXN2FudHFHY0ErUUVTMzBNV29qQXVwZnZtemJlZjlkajV3UjBGcU81?=
 =?utf-8?B?eXI3bktZbURadnlZNzRZLzlYbUEzVmlPZ2VNZE1KY0RENEFwRVdPbTRTWEM3?=
 =?utf-8?B?VGhuM241YVI3dEliV0F5bnJHUVlxeXBSK0lMVUpQR0lxMG03NTRXcklZL2RL?=
 =?utf-8?B?Q2c0MERLOTBKUmM4SUptRlN4VUJYOWpZMVRPdUsrejFRUzZoQVRJeW80RjMy?=
 =?utf-8?B?NDhVWFllVWxFdkJNWDZvcVRIUXJrRUxlRHpYUnRhclpNRk1kZHJ6K01mNHhS?=
 =?utf-8?B?M2l4RDhNUEoxUEpHU2U4YVJzMlFTTE5nOTBLQ01vd2xLYThCVkFWTHFCSCtR?=
 =?utf-8?B?VnNuN3R2MXg0OW81cEVreTBqcU8rZHZYRlVkUFlPM3ZoaFhMS2tFQzVyR1Bs?=
 =?utf-8?B?bUtEU04rRUhHT3lKWkxLdW5EaUZRdEswbHR3ZlpYUk8vRFBpU0NUMm5adGhr?=
 =?utf-8?B?YkUyeWZFZ0Y3UWFLWFJkRnh4Z2pKN3FNd0VoeHNGbFNDYzc4cThFWnpiWkV3?=
 =?utf-8?B?a1NjSG05UTRQQmxyMUkxU0V5ZkhLZnMxTWI2SVNuZHd4bGUvMVN2Z0ZwL2dO?=
 =?utf-8?B?REFXTjUvME9LdXRkR0ZuNCtha3Z1NFI2MDNBdVR1RjhyUGtoOEtTMWhBZW91?=
 =?utf-8?B?bzNHcnZxb0t3enl2TmZKZms0SWV4TVhrb0VaNWtmL0NpVjBQQ2pab3ZRYWQ1?=
 =?utf-8?B?UXhONWFJc3dpc1Ywb2JDWDh4QlJ6K3J1QlBJRjJsdjYvZzJFMzcrWXFzcXFI?=
 =?utf-8?B?RTlVdVd1MGtWbHBsMkxhbVV1M1hoRWJSN0l2Qld4L3VJWldGbWI4WGtxV2li?=
 =?utf-8?B?T2dtOHh2ck53N3oxTGxNcVZiOGJXWDVvZFAvWklQbUVxN0N6aitVWWl3Q2tS?=
 =?utf-8?B?NXd0d2lwckdwRUNMWFY3TGlUVDB4M2VyMU11YVFQTlVCWmlOa280T29rQTl0?=
 =?utf-8?B?dXFQVmJFQTd3OUZqQkJqdEdRZTJDNDFyc3NNUVJPTit4QmFiNVkxdzRsWTdW?=
 =?utf-8?B?UnVoNHdXV0QrVThkQ0dWTXY5MmQ3MmlMSS9ndkxuZ0kwVmdQUzZYUDhKblZR?=
 =?utf-8?B?dDZiU1ZiWFlrdzk2VEFMNmZiOUJpSkhCcmhkc1d2SzV4bUFwbDB2QlJDbnQz?=
 =?utf-8?B?NE1JblBrQkFRZ1FXNzZ0elVWVDVwT0Zkc1V4cEdPNEFJUEkyS2JSYkcycmt6?=
 =?utf-8?B?WlVDRy9aL0wzZHVtWFIrQk1ZVWhMS3NwK1VnZy9ZdzBBUmgwR1pkYXBQZ1Ft?=
 =?utf-8?B?MldMOE5yeS9rY29rMTZzMFMxN2dOV3dmUGhtTHJQbldXRTF5cHdpMStSck9w?=
 =?utf-8?B?VHc4SXBhVlpzSEZpVFdFOTF0cVhlUDRaMzNJVHZBWE9yMW55NGU3N0Jaa014?=
 =?utf-8?B?dEhHbVJ5VzlGMGZrM3N0b212dEtic1dsNmpHd2F3eWI4SjM1a3Izdnl3ZjY3?=
 =?utf-8?B?MjU0MjRIMWhLc1UzOVB3Tm5NeSt2Z2ZtNjM1QkJMTFlIeHZqWmhKam9udWkw?=
 =?utf-8?B?VzRDNWcwWWRiTHVpRXNpY1g4Q3dqYzVkVWt2Vlh4ODRkOStFYmRhSDhabThY?=
 =?utf-8?B?S1ZBRWNJYVBjRXFWTDQ0U0ZIMVFxam9IVnY2ZUJuMEVLT281RFgrVzZoSTdD?=
 =?utf-8?B?Z2EzQTk1SmJOSHMybkV1M2JSaXZKYlBEOFUzTUZyVTdjK0VnU1JjelF6QXhH?=
 =?utf-8?Q?J22qCbruuZrU/AMA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee870ec-745d-48a6-2e48-08df3b0c32c2
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:12:48.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kT5DtJ9/onCPCXvEgm7MCoZcmsf+w7lr7MzLDgT4TgAj89X4YTTYteRt3BBfRBxe1KPYEXWr84DNu2dU7aLuqVx0ugt3W/TrBRzbPUC8E9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7877

Multiprotocol transceivers such as the LTC2873 provide an RS485
interface and an alternative interface, typically RS232, on the same
bus pins and choose between them with an interface select input. Add
an optional rs485-select-gpios property next to the existing
rs485-term-gpios and rs485-rx-during-tx-gpios, and let the serial core
drive it from the RS485 configuration state, so that every UART driver
using uart_get_rs485_mode() supports such transceivers without driver
changes.

Patch 1 is new in v2 and fixes a pre-existing problem the review
found: the RS485 GPIO descriptors stored in struct uart_port were
never cleared, so a port that outlives its device, as the 8250 ports
do, kept descriptors of lines devres had already released. The select
GPIO would have made that worse, since it is driven whenever RS485 is
reconfigured, not only while RS485 is enabled.

Tested on an i.MX6SX UART and on a MAX14830 channel, each wired to an
LTC2873, by observing the bus line while switching RS485 on and off
with TIOCSRS485, across probe, unbind and rebind of both drivers.

Tool use: Claude Code (Anthropic) was used throughout. It drafted the
code and the commit messages, reviewed the series against the serial
core and the 8250 port lifetime, and prepared the v2 changes from the
review findings. I decided the design, in particular that the select
line keeps its strapped level until the port is configured, reviewed
every change against the code, and ran the hardware tests. The code
and the messages are mine to defend.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v2:
- New patch 1: forget the RS485 GPIO descriptors when a port is
  removed, on entry to uart_get_rs485_mode() and on its error paths,
  so a port never carries descriptors of a device it no longer belongs
  to.
- Request the select GPIO without changing its state and make it an
  output at the level it already has, or inactive when that level
  cannot be read back, as on output-only GPIO controllers, so the
  transceiver keeps the interface it was strapped for until
  uart_rs485_config() has placed RTS at its RS485 idle level; forget
  the descriptor if the request fails.
- Commit message of the select patch explains the ordering of the GPIO
  against the driver callback and why the select line, unlike the
  termination and RX-during-TX lines, must not be driven at request
  time.
- Rebased onto v7.4-rc1; Rob's Reviewed-by added to the binding, which
  is unchanged.
- Link to v1: https://lore.kernel.org/r/20261021-serial-rs485-mode-gpio-v1-0-80d7b0903d93@vaisala.com

---
Tapio Reijonen (3):
      serial: core: Forget the RS485 GPIO descriptors when a port is removed
      dt-bindings: serial: rs485: Add transceiver interface select GPIO
      serial: core: Drive the transceiver interface select GPIO

 .../devicetree/bindings/serial/rs485.yaml          |  8 +++
 drivers/tty/serial/serial_core.c                   | 73 ++++++++++++++++++++--
 include/linux/serial_core.h                        |  1 +
 3 files changed, 77 insertions(+), 5 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261019-serial-rs485-mode-gpio-e76bb72b6f21

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

