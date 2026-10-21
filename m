Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792560004;
	b=cGywTEG5uJwOY4ba7AVMiEJA0T/BOpS627fJ+uNCk1LtgnTsNQSxyBRQYHjCxhUWUzIx
	 sbiubYm5n03qbRJPUdnWqLgYodjmtMe7xqe63oMXFH1CE8FWzunTY0KTAa0+zcdvD8SeZ
	 EFMv4tTrv1gI6BbVNYzniR4twG+RM0fw6EBwTlKNfivViBK1bmYeASJfOSzQpwOQfZRLK
	 ULTe4jHfk6dFxTcKG+gAihuOpYacwc2Jy0GoUznuTqS4TqKus9swzEkwBpUPuKwPBg1Uh
	 YEktTr1XU3BIUAM8rYwctlxxPgzPl56Jn9SzNOOowl7v1LwmEwLtOI3KndkIDJP7cvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560004;
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
	bh=VmFD5+3xyKtPX+FvgFBQYj1nPlsPRDCSlz5xtV8umaw=;
	b=fjWUYzrYIEvnfprjE2v08nyIMI6tgfHGaxSUlMGWaQp37Xza95c9x6QMRxSdzfs9e7hB
	 lU/wBHaxIO7wJP+jjCDObqMw5I3grQo02hsvd/IAKqNAKN9AwEN8ByaYJsIyDG0xhiz1l
	 7qhAQZcFbH93ZPTAUvTG3fhkms33tLO1MCg3Isl80xJcLa8nna2ga1JxGq5lU0XtjMdDb
	 2VO2ZsQ41uNH+HqOsVzuKhW3rjtXn3RhMV8dQvwSGPC9l0oc8ye21WDPxfzu7KazdOI7L
	 tgzJU+78kH4xFVH4RIl7qpUo1g/6OdkAa1OqMh8D4aOEaolGz6JTU3sDU/pv1zBhHAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b="DEIwmM/B";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023108.outbound.protection.outlook.com [52.101.83.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45B606A332;
	Wed, 21 Oct 2026 05:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B45B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=DEIwmM/B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPPYTcw6rUz/z3DhDXOEqy6K6U9UEhJh0ebE58gdsLmHTTJK88H/vpQb+RHH0MyZKQW6i+ww8QMbTOc2CqdFxdrCGoU6FAAWTt/1/5/UiZx9bpZ0p3LmhNc+pBGVz2Ej45NgYDMgUzO7vn3nLikASPUvGpj6qdpH7taXds/s6UqQaIUYAZaqj/R0um+zBlQMJkf9E7EkLpvyfWnEdqySQhOAl2PuiAyUupG3POuigpJpYCZg2tOguZxXBJd6zKjLbWEfq2LpQjldWa03jQzJIIdwP6UiJvtdXOkN1izHFedlTKydWOT4tiiL97HONK/Mmz3a4k2jWXvTnMXAD2bvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmFD5+3xyKtPX+FvgFBQYj1nPlsPRDCSlz5xtV8umaw=;
 b=NjTjKqH5tNY75dajDCbG4Fs+iqYXR0h2wEJnhCbu+x55Bjbi39RiBbgKAL7IB8E0JHkb1KWCmlMq3Jdn2Yljq4sH0KoORDUIQD4b4fDHnooIERafcdGXxQlKekSz1e6iIqMgB/2KvIZ6MIXc5b6/wk9IvHpThPt7xraRJi7fXN4AY/YSAQ32mIa7fCDQDIjtTqTHJZiUwQv3VsJzaA/PN5+QQV9QQMfiouMWmhQVvZL4khVDCG2iDR2RobztkUdZHzet4mW3mGbB4gCFQsgjMCWyWGzJGgbb588OMlrocXvLiqs//azVgJGhXMdwZntrwb9oM894v/bBtlm6C6gi8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmFD5+3xyKtPX+FvgFBQYj1nPlsPRDCSlz5xtV8umaw=;
 b=DEIwmM/BkMupRSmfb7JpLAwckJR5zW22b1GxE/xUVhHh7+ZaYHOkQn1Sucyis7FAO6z2SFSjsgVJ29otl1NcJApg2XxmcESMinzizca083W6aRlpm4tsphInods8n1tGswlsajdhdztOimBzqzj7cnB06eSsJ0/ilP4bKERRsu2g3PCjJYCrq1Zlmi2bNIs7dOAMFt6OYvaZ9N54gqKEgEQ70z54nynTN9xFUG3dDi/PVnggKWzPcYHnznd4yXAmv7Yd3q3EZIUha8tPRtXFVe+0ro/9ZUL52hHW5SkCAOWFiPBPtowYSJQqtowDiUUGrmWgOHaBuq34+AWHtq2KAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from DB8PR06MB6441.eurprd06.prod.outlook.com (2603:10a6:10:12f::13)
 by GV2PR06MB10300.eurprd06.prod.outlook.com (2603:10a6:150:2fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:19:50 +0000
Received: from DB8PR06MB6441.eurprd06.prod.outlook.com
 ([fe80::2e1c:62a3:98a9:35f1]) by DB8PR06MB6441.eurprd06.prod.outlook.com
 ([fe80::2e1c:62a3:98a9:35f1%3]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 05:19:50 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 21 Oct 2026 05:19:39 +0000
Subject: [PATCH 2/2] serial: core: Drive the transceiver interface select
 GPIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-serial-rs485-mode-gpio-v1-2-80d7b0903d93@vaisala.com>
References: <20261021-serial-rs485-mode-gpio-v1-0-80d7b0903d93@vaisala.com>
In-Reply-To: <20261021-serial-rs485-mode-gpio-v1-0-80d7b0903d93@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792559987; l=5600;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ovNZb4rrkILSL8w/2/h+MTs7CqI1IVNfR+1Hc7i2RL0=;
 b=K+KcY0eiPxjiXJUQRaeWyXqOyB5nKXYvHDLc+o1WZ2TgituCbprobyHsbiil551yqLkEbSUtf
 0amUYPFK/WUDR5g2DOFy1ryw+mlQZvkxT9VirUUEjAnrbkTmBXjqG7k
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
X-MS-Office365-Filtering-Correlation-Id: e5558e10-b87d-4642-4913-08df2f32ee10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|23010399003|366016|56012099006|38350700014|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	oL1/o30OhMOfd2xAdw22a/aB4fg4+aeuYoGBJ5bFwYxsIUNLhmXLS5nc+EHu/DDmpc92NvE2/3L7ecU/nOWmgi3k5U5SW+9dteWT3JsAavLln/+kUuYWvuwmxYQsevobePfsrl2Y3zw4J1OUCnUWSlu44v24QpwvrxLjxTG82UKdmttP167ttZXPWqCO+d6ze+NrztbynhouZ6t3Zg+otDYgJHiAAolVHcFbG1UcEOAE5lvJBQd6rJphJxQSJuaENfwhDIJ92WOMy+34mU+mBjT5e2iRK4VeL/s7bTJ0Ns8LaU7e4PX7sFxBzIpqZXaDun0BMEQflTMnplLDUYrRX0p6m2hj8rL1dow9FyeV40Z+GcvOLMUyor0aALFZUfAWaq/AeefW6MM/GD5wrTZ/8NCdFmmAXigiOVK2BX12fxIgz4Uqk3AEyuBYla08SKWPKN+A8B8WiQYkWnTAtDLwxu9A7LZ1+m5gH9ZltHvKa+/8OhQuDBwI4bdm9FtMBx1L3GEy0kPJyh9YmM0COkVgWiiXq9ovIhgsRo7hHmKh8lOFrPFpNhtSw5R+DiDsTIX+cvg7sAvv86PzDZqH20ITSi6ulE96S8UB+BjMLBtcGFnTMePi1Nq2mHMl7bNK5qeGfnNyMNWVSh+xe48ZjX58HfRgIqLItmfZ89BO+YcqhkAFWVXo4sWUfDZIZeRmFQ7Ugt+i9dHvAk0rnxD3LY57TNwVEg0tJV4qi1XI56VnMOg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6441.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(23010399003)(366016)(56012099006)(38350700014)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFQrREozQ3doQ3d0cHNPZzdkQ1gyM1VjRnNhRm0xbDZBdEtmKzMwZWJlc1Uz?=
 =?utf-8?B?b1NSSG55SHJ1MStFK3I1a3AzMXJTaDdQWFpoV1dLQnROUUkvTG8vR1U1T0Yv?=
 =?utf-8?B?czE3emFLR1NKWmlYNWRDUUhyZUFVb1lXSlpXcENiL3ZQWUg4ZWp5SlJaU0lk?=
 =?utf-8?B?UDQ0dkYyUFI1Z1FEZmdoYkZUZzkxakpsWTMzTllQWHlQNDMyV2xRTFZOSzZU?=
 =?utf-8?B?TjBCeE90anVHYUh1b2FKbXFxSzlTYkYyOUtnR245SnVlOE9BVDJ5VndLQ1VO?=
 =?utf-8?B?U3VyQXlFMHF6a3J4RzlwT2ZOREZ2UTY5M1VQV05WYUpsaUE1MHF5dWNna0Nv?=
 =?utf-8?B?cjcvTG1nVzVHVkxjTk1RM3owSTZsVVhqWXpweWNUMnJOTFBsZERDVDVNR29B?=
 =?utf-8?B?NDhpMEpZVFZrOEdRbGtMVjM1K1FWRW05MVRqMjRjRFY4ejVDbFVRWm5heW9u?=
 =?utf-8?B?SzdWUE80djNqV3VneE5qaXhHVjNUdHhTTXhOV0RPNURrc3AzNDN5UEVPVVgx?=
 =?utf-8?B?STJsY0ZXME1xbkZERGZOWUx0RTJYME1jeDNtZ0ZxZE96VkJZUXl2WTNJWnQr?=
 =?utf-8?B?YVYrZk9Zck5lV1pWTHlVbVAzNS9IU0J6SXBNdzBxKzNtV2Voa25hVWhUbkh4?=
 =?utf-8?B?YTB6SE1ZVmh1clB5RW1MOW9MTjlnQXd6b3pLN29IbURkbXZGMjhhdUkrcWg1?=
 =?utf-8?B?NmE2SmV6Qnl0WmN6eXNOaktsRVM2emZFS1BTa1ErLzluTGpBUlIzSmtGS21H?=
 =?utf-8?B?dy9USUZSL3RVaWxRQU5MNzRDU1dSZTB1Z25Kd3pIRU9Yb0ZVTHMzeUhPa0xT?=
 =?utf-8?B?N21kUmxUNlpWL3Q1a1JHL3U5Y2F3c3FuM25tZk96SzRqUkJkSXZ3b0FJMG40?=
 =?utf-8?B?R1VEb0JQU3AxSVpmZ2htN1pkTnZJcE9vWVFpRHZsUGJlSWdEWUVTSkMvcGZw?=
 =?utf-8?B?dWpPSlpuOFZyUUpvRG1pQm02VjNEVnZWa2RRTEtQdzF5VXd5RmJrQkJFQVNq?=
 =?utf-8?B?cU5hQlRTTUtOcHBUQXpSbC9OWFpWYWZDM1B3dFVzemNtUW13UG5INGVMODhY?=
 =?utf-8?B?b0QzUSs3bVhmZHdkZnl2cFB0WGRIWjQ1TDRKaTlmci9NcktKbS81Sy9Yb1Jn?=
 =?utf-8?B?aGRKbGMvZm5KSXN5U0NmcnQ1RUlTV0xlZDQ5aW5LbVR6OTllOXFHMXRiRVNK?=
 =?utf-8?B?WlJHMTl5SUNiQjJBYWdySndsRVlHaWlwRE1RenpoRG5KYjBTcUMrS0JBNWZO?=
 =?utf-8?B?L2xyQnY0Y0tCMTBpMHZSQzl0WG5aSHE2T0NGcy9NR2VrWXdGSjJoc2pWMnVj?=
 =?utf-8?B?UXJlTzRNRjRyeEZ4cVVQSDlJQXhWY2tpRjZJekQyWURkeno5bndBd0xnbWpB?=
 =?utf-8?B?NjJ0UVFjZjM4UEtlN0VwOGp0R1ByMy9jUTZJV3k4Y0l1WGpzZHk0emlJdjRl?=
 =?utf-8?B?WVlFcW4rNFBxOU5RMXFWTnlBZnNRWjhBWDFLdmlZU0NzendxMUVVeU1IMEtm?=
 =?utf-8?B?aVBIZ1hQSVhhVm15OHlXOFA1NVFmOG92d1g1WERhdW9Ib21maUN6Zm1aSGJw?=
 =?utf-8?B?dmx3TG02b2ZGZ3RwbWhWbEw4dC9XdDVzWlpLU1FQcUg0d3phOVlTZmQ5UzE2?=
 =?utf-8?B?QlpzQy8xUS9OVDdJQUpnOXVYc3ZyQ2xML0F5VU1pajhYNU5tNkJ0VkNGcnpu?=
 =?utf-8?B?cEtEQy8yaFF6UDRRam5CcmZoYVhLVzlWa2R0U3hNWXpOR2Nvckx3djFINXNq?=
 =?utf-8?B?ZzFwRjlnOXd1Uy96Q01ZSWhQczJuRktJaklMQ0NNVEZLNVVsbzFiWWR0VEMx?=
 =?utf-8?B?ZWptQmxZM3NyVUNJSG14bUsyV3RwUFhBSjhqZDVUZnRHeW8xRUU3aWpWYkNJ?=
 =?utf-8?B?d1k5T0VBcFd5L2lqNFppUW8wWTBrdU5ZZHpyVWdwMGNVMms4SVN6bWo5K2w3?=
 =?utf-8?B?eGVBcWRTcUJqRElrM24vUjFCalJqVnZkVlkzQ0NZVEFSYXUwd1ZHajdwd0wy?=
 =?utf-8?B?ckNoZzJvTldZeW43bXh1cXBxL2RIZjVIRW9Oa0IwL0wxYzU5Rm9ZSUJaOU1m?=
 =?utf-8?B?Ym5EaDZ4TTlQUzdzYVFIOUVMTUJ2ZWxyUTU5My9uY3lmdTlBL1JFZUxJdXho?=
 =?utf-8?B?ZWxxKysrRlBrQU5jempPeVdpNnYybFhSZmh5cUdpUTVUUnNWWkw5dGtLRGVI?=
 =?utf-8?B?czZUblM3TUkwY1o0OTNHbWMwQkpNLzF6OHh0QVk1cFF6UjM0cWY2QTJ6dVM4?=
 =?utf-8?B?K2J5THcyZWJTSmh1MzlhUlNVemdoRmVpOVhPNVhmTUFoZ3djVis0RnRFeXJq?=
 =?utf-8?B?SjZ0UVJnL2NLU2xyMFhqYW0xblFHaWtvbmw3SnlmdUwrU2wwc2VSSzdKUjhT?=
 =?utf-8?Q?jP748CeYU+czEB7A=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5558e10-b87d-4642-4913-08df2f32ee10
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6441.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:19:49.9811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4z+mg6X5uNWDQLfjf03Y7RWeTQSFOOOrZMLis78jEISWSxv6Ni+sk7vd9m0wQjnCrfbPmBceRDr8w6TLGHo+lh7pcJjKZq8hTFlMZNDOVMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB10300

Multiprotocol transceivers such as the LTC2873 provide both an RS232
and an RS485 interface on the same bus pins and choose between them
with an interface select input. There is no generic way to drive that
input today, so a port wired to such a transceiver is stuck in
whichever interface the pin is strapped to.

Add the optional rs485-select-gpios property to the GPIOs acquired by
uart_get_rs485_mode() and drive it from the RS485 configuration state:
the GPIO is active while RS485 is enabled, which selects the RS485
interface, and inactive otherwise, which selects the alternative
interface, typically RS232. RS422 is a mode of SER_RS485_ENABLED and
therefore selects the RS485 interface as well.

The GPIO is requested with an initial state derived from
linux,rs485-enabled-at-boot-time, so the transceiver presents the right
interface from probe on. The state is applied in uart_rs485_config() for
the boot-time and resume paths and in uart_set_rs485_config() for the
ioctl path. Unlike the termination and RX-during-TX GPIOs, which only
matter while RS485 is enabled, this GPIO must also be driven when RS485
is disabled to return the transceiver to its alternative interface. It
is deasserted when the driver rejects the boot-time configuration and
restored to the previous setting when the driver rejects an ioctl, as is
done for the other GPIOs.

In RS485 mode RTS is the driver enable of the transceiver. The GPIO is
therefore driven after the driver callback when RS485 is enabled, so
RTS already sits at its RS485 idle level when the transceiver switches
over, and before the driver callback when RS485 is disabled, so the
transceiver has left RS485 mode before RTS reverts to modem control.

Drivers calling uart_get_rs485_mode() need no change to support such
transceivers.

Assisted-by: LLM
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/serial_core.c | 29 ++++++++++++++++++++++++++++-
 include/linux/serial_core.h      |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af41db10de15ccca4169c603d9cebf6..57b022d0cf01b00d0d383d833d13afcfa6084760 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1435,13 +1435,22 @@ static void uart_set_rs485_rx_during_tx(struct uart_port *port,
 				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
 }
 
+static void uart_set_rs485_select_gpio(struct uart_port *port,
+				       const struct serial_rs485 *rs485)
+{
+	gpiod_set_value_cansleep(port->rs485_select_gpio,
+				 !!(rs485->flags & SER_RS485_ENABLED));
+}
+
 static int uart_rs485_config(struct uart_port *port)
 {
 	struct serial_rs485 *rs485 = &port->rs485;
 	int ret;
 
-	if (!(rs485->flags & SER_RS485_ENABLED))
+	if (!(rs485->flags & SER_RS485_ENABLED)) {
+		uart_set_rs485_select_gpio(port, rs485);
 		return 0;
+	}
 
 	uart_sanitize_serial_rs485(port, rs485);
 	uart_set_rs485_termination(port, rs485);
@@ -1456,6 +1465,8 @@ static int uart_rs485_config(struct uart_port *port)
 		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio, 0);
 	}
 
+	uart_set_rs485_select_gpio(port, rs485);
+
 	return ret;
 }
 
@@ -1492,6 +1503,10 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 	uart_set_rs485_termination(port, &rs485);
 	uart_set_rs485_rx_during_tx(port, &rs485);
 
+	/* Leave RS485 before RTS reverts to modem control below */
+	if (!(rs485.flags & SER_RS485_ENABLED))
+		uart_set_rs485_select_gpio(port, &rs485);
+
 	scoped_guard(uart_port_lock_irqsave, port) {
 		ret = port->rs485_config(port, &tty->termios, &rs485);
 		if (!ret) {
@@ -1508,9 +1523,14 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 			!!(port->rs485.flags & SER_RS485_TERMINATE_BUS));
 		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
 			!!(port->rs485.flags & SER_RS485_RX_DURING_TX));
+		uart_set_rs485_select_gpio(port, &port->rs485);
 		return ret;
 	}
 
+	/* Enter RS485 only once the driver has parked RTS */
+	if (rs485.flags & SER_RS485_ENABLED)
+		uart_set_rs485_select_gpio(port, &rs485);
+
 	if (copy_to_user(rs485_user, &port->rs485, sizeof(port->rs485)))
 		return -EFAULT;
 
@@ -3643,6 +3663,13 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (port->rs485_rx_during_tx_gpio)
 		port->rs485_supported.flags |= SER_RS485_RX_DURING_TX;
 
+	dflags = (rs485conf->flags & SER_RS485_ENABLED) ?
+		 GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	desc = devm_gpiod_get_optional(dev, "rs485-select", dflags);
+	if (IS_ERR(desc))
+		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-select-gpios\n");
+	port->rs485_select_gpio = desc;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4eeb8253752aa08b27829e80a259c7db65728e8e..fe90a8aada98cacf5a80f20ec2a91e249c92d0ed 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -600,6 +600,7 @@ struct uart_port {
 	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct gpio_desc	*rs485_rx_during_tx_gpio; /* Output GPIO that sets the state of RS485 RX during TX */
+	struct gpio_desc	*rs485_select_gpio;	/* select the RS485 interface */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };

-- 
2.47.3

