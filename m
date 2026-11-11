Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400108;
	b=q1YB9Ab3WyJULSFJztnfjxsWraIBnizsbg49NDfO+jrNd8s3o7zH5os046QVgHRWM9bS
	 VpYbwJbMG8aZ07AYqmhNjdT0ezOoKiw3LmcdTLc/Tr26D/lmZuNfhYXKsb4hQo+DytWC3
	 UzTw/zw25NEtcqHYuZ++3V309HF6B+4iaFFOpu0FL/ElSyiFC9px2h2haGPWBpxKGN1Ap
	 l6HLVhkdQAZpDrnm+fj7tf0t/pTw6wPjAYhTL8iOjN6gVZ4o7w/XPYEWjBrSoya3n7vJb
	 f7JLW0PHivicBb0BepX6lkSakSlc+boN+/6l5V6VfAFgxeioJiO2BWpqboswauNxScw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400108;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=o6oYYkNjxznzb5J3btoPQlBhMFHSFBPttuN8theTXe8=;
	b=qTSLKLHHqFp29+lISgczGu52waNPeMRvevfgwMHYXSoqZL3ceFwxWARvH74I0UNKnFNR
	 GXxc+HyyeDiDVNKenLayXZfPtByV2FsF1ZpxMB/pZ+Ga8oO3NAOcKA/GN44aYFTo+oVOw
	 VyboFBG5xDNg4DK1zR1TNcJDGRI9l2ak5QA+Rsc51+Hntk9hvXQkNjArHO+fSA3meWxJQ
	 dTz/XA7a2BG0fy+SePsy0K49Y1I5EigwyiSQkVQFFTNJi8+hIybZ9IKg/i6RGfZMl4TTd
	 /yPOShq+7WAvw4/XyvW+ANuwoaur+5JK6+gq6mznThuufgwwTgVVNieL0zGFEy3mzwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=qv2kFR1r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.112
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021112.outbound.protection.outlook.com [40.107.130.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129E606A321;
	Wed, 11 Nov 2026 12:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E129E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=qv2kFR1r
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m76sA4uhFBhp19nQ2EhOaBQgf+2TsZg9bzqYZGZSQxmIxncMOFZpAGley1n4QBiWfRF5VvPRiaJYYUp9G7uxnk+TmJDPFCCLoeTqEEL63AYtnVPLXPEgqAe8CKXFvKVi3m70tgtuF+M1ZqMkuDwTCwGZt8aRAsCqT7EtOMUN4cIzc+EoOU7ozeTr3wHnm0XWStq3YjtH3CANIbYe/6S96rP88VYEs6r+iIZF6qjajuj4CNTj3lUKVTwlalPELsrd3b33YoOz58NH0GF/M99d/oEnG2ku6oSOZ7QBwBmBKfXVctyxG30PeZcKj5qDLKrRr/zgA6aHYmPewHEnURk13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6oYYkNjxznzb5J3btoPQlBhMFHSFBPttuN8theTXe8=;
 b=Azczt15F1s3uK1lmDTeCRR53nMFB6hUoWCc9I16ipXcOpHi5kyMERDWWABdm4lDVIz+oot55o92j1eySNcDzVN7VkszBGBBubmbgxBltRJKfLxpa0WCKYZPY4duWcxBDuTjQ5VsmxPFRkIP86iEc1c0XE94JTst6GM8vMexjSLrIfN8Pxp4Px3z7RZRe6ja7l01N8J41EgdibTCzufXYIBO+9OTVruR3k+ANXEnp7S3uZ2DyYj02LHXYDUbf7Qe79uFATTSYNGT6sA8A78Hi0GVa0NAlVzD3YSQ3MGz7vq5snxXye2uL27KJG0UZ6MINP9JZsdr5OHYhchkjRJJCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6oYYkNjxznzb5J3btoPQlBhMFHSFBPttuN8theTXe8=;
 b=qv2kFR1rlxfOzKbbICXKq5+S5c1AVAY6dfJfcpDTV5i+6ilaw6Q+CyvFQzE+IdRUysodsZ5Uy4hEoRteb4pWW+UvFhlc10AwRBREOo/vHky556Mu/N0Xd1luTMvimI2vDyP5itm54aMjD+6gtkscWVhBuUIfPZFT27TgfoeohqFaM73cQS8KWBUCBRjfvmci7XO7/0bm9MjcanAnfrK0S/2kCDajiywxZSM+pSJKkx+mhq4/0t9ROXZzm77/M8aodNpHaG30o8753Z7Bk7JtADRkMJ4WbGutNUp5KqmRIGMLM4d9L+s/f6AaX6bpVXd+9zhMnaTzh64UhWXekryFRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by VI0PR06MB9953.eurprd06.prod.outlook.com (2603:10a6:800:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:28:20 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:28:20 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 11 Nov 2026 12:28:02 +0000
Subject: [PATCH 3/7] dt-bindings: serial: sc16is7xx: Disallow transceiver
 GPIO on dual parts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-serial-transceiver-supply-v1-3-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
In-Reply-To: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794400093; l=1492;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=K/3kFvBvwmfhzUzbdIM53K/cQQxLEeJA/3qkud6RWQc=;
 b=+7DD9zIiYNsQtD6LzBlUTshUUIdkWa2GkgmV2NMPeDRXhcw38fePxOfIfnaynjFIKyjVxvNCS
 kWJkF3CEbRHDak02qJg6QxyTNcj0bXs2bwBskQd7sXB8jOaNNvQeGlK
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: BE1P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::13) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|VI0PR06MB9953:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc95e29-ab6a-4d55-81e1-08df3fef4374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|23010399003|366016|261009223027099003|10067099003|261022105027099003|261026140227099003|3023799007|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qONnoAYPE5DzH1clp+qHvfHLH0aFSUM52eg5GJvypOigw5tZG/HkYyTo5WTE4tN4uUt178CbS2gJfBe8xCwgchsvEegzNKCopOnuwGReZny/DAeIWFik7pHeACaLIyrKduZltn/UCjDL9v5rvQdDyAJbHwDZwaSv82f0RJfVgsfS9rBfjTWD7K6aqVRizT1uqx/lWUL6VxD7KkcjKR97ODT/bcD5xmSL/lHti7tqKqEaf8CvdXfSG5//oMETN37574aBr1NNGhO9RkHi6nMA7MJzKK+zpTAz1dsn+6QqcdINeMWbGpcHiUfpZsXmv6iDiDZQgPUR+RxA/wjte8GnquMOlCNJ7ln7UA21/RwAT4df2h2wXAm0RpdDj7R53MOtItkoTrWFq9PNMz/x+EKLMPQTeZKk96cGgKxcWqpGK3ICnmn74GJaN+yKZINrtNo/qlREh2dE7xUJywhZe67702GtimozcncYdr7L48wqL9wWBGi9V++F9RNWIQW5Z77nfW3KXIbdZCP2xtD8gk+WbPkkgKurBLNYg1xS9KEZIIopjlRhL2PrMVZ1m8aEpsi8jy27mLfiCRV6uRKgaaaKR4B5iZd/cPz5ryFwknFN6+D3eIHnr1QMB5F4C7SR2eJ1tBdFVItAGQl8RRiObpRxsnrVw/2KAIjom7jRYWbSRI9xckXo4rP+vB00AT6uAuqjcbYXp3gi4hsOxVgMWRB3YByLV9DkB8PX5nhQC0r6NcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(23010399003)(366016)(261009223027099003)(10067099003)(261022105027099003)(261026140227099003)(3023799007)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVk3bGhDNm9HMEI5OGE2RE9lVEYxR1lmZmNTaUZJMUdIRUNIK2lBUlpiV2dL?=
 =?utf-8?B?NFM4Uzkya0xaSGtyVFVid21ZeFJJaDc1d1dhUkdmNHg5WkZNa0ZXLzJTSzRZ?=
 =?utf-8?B?d1d2aXRnam5DZnRsYUVqaUVCc0E0NHBQQUtuUVdrR1NISUdLaXNVdnplcHVa?=
 =?utf-8?B?NXRxWkoySnh4cWZuOVgxV3JEdXE1U0xKZWZVUVc4VzgwQ21Kb3JTbVB4MC9z?=
 =?utf-8?B?aHowODRLWlFVNnp6cCsxV2EwczRLWHlNQ2NNUG8vck90Zm5BZWoxKzVJMk45?=
 =?utf-8?B?NGE2UHk0eldJZnNxM3F4TG5JZGRYU3J3c0VUb1FSN2kzK2pHOGZMdlpVNmZ1?=
 =?utf-8?B?OTRyVjVqWVhaRHJnUEM5UUUrVjNtOWVoZkFiSXpoNy9FN2NsaEpuSkl0bDZj?=
 =?utf-8?B?bm9hazFJUGpzdjZ5cEFCbnBTTUQzWFEvS0VFN3NlVnllTStlRHdDeWpud0tq?=
 =?utf-8?B?KzlrWGNBOVRKNVNYMzhIZDZqZlE3TE8zTWh0RnFFSHNVVXRSNWF2L3NGL2p4?=
 =?utf-8?B?RWRwQVNINEFsZFdtbXp3aGFSc0dMYjZUSHk4dlh4Y3k0OUJEY1M1UzUxQjVS?=
 =?utf-8?B?QSsxaTRrbzBHY21yUHVLeHpPMlRsNnNCNndDKzBwL09tdHlKbGx0WUlBVG5J?=
 =?utf-8?B?WWYyMDdHOXZISXZVa0xOUW1TanFuUTE4aytDRzZ0OHZPWWZINnl0YXA1elJJ?=
 =?utf-8?B?V08rTjlOOC9XODB0OEdVcEVRWTlCZWFzdkF1Ukh3Ykt5MjRMY1JDMmY5U2xH?=
 =?utf-8?B?WFBvbW5FaWVIMktQZ05kZWZFU3hXeXhKb3AxVDdmVjVqMG11bFlMZkhvQTFX?=
 =?utf-8?B?S0lzSEk3T0paQUlmb0R3SFRzK0VVZGZONW9RQzAybXZRSDNlbUJkTnM0YzZk?=
 =?utf-8?B?UC9wODVnd2piTnA0cVNxbkJmMVYvM2lnNCsxYnQvQ2NDNU8wcmpDUklONVV0?=
 =?utf-8?B?UWd6VFBJODR2ek1MRUU4WW9ncC9mZ0xyKzh5S3U1a1o1T1puRmg4UVY4T2x0?=
 =?utf-8?B?YkZDdEt2V0kxc2Y3N3Z4d3BEdG54a2NhcDRkdlA2RVFRV3BraU54dWhlb2dO?=
 =?utf-8?B?ZDlLYVcrRUQ5Z2UzdlF3OCtWZ0xFRzd6Q004L0F5akE2L3FFa0NPNFJtS2Zv?=
 =?utf-8?B?ZHB0QXJjWS9mMWh4cU1WUFhZSHg0UXhHbHhKemVoaUxQYmVZaG1lcUpxb3Fp?=
 =?utf-8?B?R1hEdzFNZ1dBVFExeVU5c0VlK3dSNjhia214dVozOWIvcXRPQ1dKcTNFYmdH?=
 =?utf-8?B?Mi9tMmQ0cXlnMzV0WmxTKzdLdktWZGpGKzFDSlAvWGZmZmdpRzAzczVyUVZk?=
 =?utf-8?B?UFZrREtzbEplNGdINzQ3cTdERXJrTVIyVStlSnQva3JqUkE2Q2hhd1RSR3N0?=
 =?utf-8?B?ZmV0ZVArdzdBNW8zLzNBbllwblRlYlBreHhPMmdjODlMa3JreXF0SjNkN1BZ?=
 =?utf-8?B?VHVnT2FldzdTZkJlcldQeGF6bUg1akpPVVBnWElMOU9OdVJEZkVvV0U4YmZE?=
 =?utf-8?B?YjVzcmc3M0pKblRuOTV1UFFvWm1sUUM0b2x4NkxJRlppakpKUFZnV0Y1NUV6?=
 =?utf-8?B?OHRWSmlIUWM2TUNHSnRVSmllSEwxSFgwNEY4ZVlqdWFkc0VDdEFSMVR4MmpS?=
 =?utf-8?B?aTBuUU4zQWcwL0lEYTZYbm9hUVBCcGJCL2FFTXhiN1I1Uis0eEJoOWtMT0FE?=
 =?utf-8?B?eG5IaUJNQ0Rzd25XdmxsUnlySXNVZ1VqZzlFY0FGbFRnUkl4N1hxOW1uRnU4?=
 =?utf-8?B?bXJrYTJTWTA3L2JCNitGVXVNYlZCNGgvSG1EN1N2UGNRa3Z0V3pxcHM3NzRm?=
 =?utf-8?B?NU5HNWJiYnp0TWxjQWtsUFZvZGtiS0E3UDdKTzVPSU1Ba080TTBNeWpPSmJR?=
 =?utf-8?B?Q2czMDJ3UnJvckMzbERZSVp1WmxsbHFyc0V5ZDVRWlR0L0YvVVJPeDNLS0ti?=
 =?utf-8?B?MHU1SnNPZmRzYUZXWmN6S29BTGJZVE9PcmlvejJaWGxiVnFCbjUvRnRDOGhP?=
 =?utf-8?B?WlVWM0UwSFZpOGhGaStVMFl4dEQ1SS9ENmpzdHZlaDhKMm5JK29SaGVENnpM?=
 =?utf-8?B?WDhKcTM0N1ZxRkFyZGh3a2xJYWhEUW9ZWWxnNnZGTHFxZ3dLdFJNTTY1b2Vy?=
 =?utf-8?B?OEZqUGhQQjczUWttQ2U2QmkyZzZqRWQ4L0x3VWJPc1F5S3JRWkZDTjJSQ0dB?=
 =?utf-8?B?NUVQdkRTZ2JySjg0Qys3alB3SS9VRVd4bXJnVnFzTEMzTVRPOHZ6VTBtMkc0?=
 =?utf-8?B?UlRZT2hrMFVlOTVUUXkrdjFwN2g3c2kydGlrZG5aN1ozMWdrTjhONDB4aWFI?=
 =?utf-8?B?eHZGRmkzblBQYVVhb0NLenVZbTM0eU1PUHF3Q1A2MWpYZmJzZW9qdTFldThP?=
 =?utf-8?Q?OLjor+VJXiFbCzG0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc95e29-ab6a-4d55-81e1-08df3fef4374
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:28:17.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjEhebLn5nnO8/3JLNZO42wOa6yEArsjNalD3Go2/CqohiOdv+hJ7sEiuLgtI64NWqo1MhD8/MXJjGXHEDDBkYjtdPVENiLcKdFgs+Z7OzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB9953

The SC16IS752 and SC16IS762 describe both of their channels in the one
node that references serial.yaml, so transceiver-enable-gpios validates
on it, while the GPIO belongs to one port: the driver gives both ports
the same device, serial core requests the line once per port, and the
second request fails with -EBUSY, which fails the probe of the whole
chip. Reject the transceiver properties on these parts until their
channels have nodes of their own.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index ab39b95dae4029974dce1a2a2425785f26588eac..cfb2250587f74c9e4fa2ffa3f9ddb7de9cb418d2 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -83,6 +83,17 @@ allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - $ref: /schemas/serial/serial.yaml#
   - $ref: /schemas/serial/rs485.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nxp,sc16is752
+              - nxp,sc16is762
+    then:
+      properties:
+        transceiver-enable-gpios: false
+        transceiver-startup-delay-us: false
 
 oneOf:
   - required:

-- 
2.47.3

