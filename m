Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794896063;
	b=ntsjqZd4y5evUg+Ev3yO2UvhMYxdNdOCvQiOXtcQt5uuoQL4QpdX+TlEhf3pRIK1FEtf
	 EQhEvh7oOHFwwh1pvt8PA7hSR4w3ZgR0Px1yaP/qU0odqOu6kFAa1AdrWvPf8TWqwE9Hy
	 KhvVodTszBILf9bp1bpUaeK66L4jUkMukehQgVf60LShWvBugYT5WwkWamFFSEQWBQpbh
	 xqRTw6jx4t6ZiqcifP0toFWLLh+/olzH23k9C9d8GQk4jgaRj/2lzmRlVWF7XELUQuWEX
	 mvuODX99T0XavJY5ihGxLcnalBUw8x9AmqLK3IRbiy/YTVkw8jBq9ucIPl9WizKWTpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896063;
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
	bh=OgMzjLxnJmAV7zU1n1doVIEiYS8OH42EabYDwDi9m+M=;
	b=UhntzrhRrfkHPyvn9pEaDpo79kI70anc73Svrj9H6wqMCGutl7y4+HeUbyrvGStHjC1S
	 bEVzWHWMUyFD4NLkROFn0ptGpbsNn58dbR0CUY1oiZNNq+22eyc5sHwBq8EF1RBoI5sH3
	 Pn1Ubb2sdTsZrcju7QNIMC+Agb0EDq9w4sqW3NjVGgYsb6IdSWTa8NCsBne0xrdo2i/CA
	 nyiW1U8B4bT8jJqLTHIf7SHw/bBaNm71XqUcLFIuCkJuf8Y3qMZ3Nyb3eqWkQDEsF+jka
	 cC6iKuw7SnOC61YliQ71B75Ci0mULQY+XTu/9d486GrfAPzNr3ubXovnh4H1CbNg1cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=gEleRSrb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.73
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023073.outbound.protection.outlook.com [40.107.162.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCC606A338;
	Tue, 17 Nov 2026 06:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EDCC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=gEleRSrb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQxS7UTlaXiGEpdfEfN4kCgHvKZkoizc2I4Ic12QvR6XWWkSTTkn7N5s4MWoBfq5ojaUZJatP1fhOo2Gl+Zh4TL3YmapMypa7a9nGCzS7bid84xvctvks5xd+plNMGXcqnMH7l8gX/68VYKOnzFjzprtZbAoQqQnlNOSacq9R9/Bqeq7vYfJiHOVCWwymOA3ctP6aay1EGF/e6UFrKsLmhyR12eqRQ8baTSyDmOAXLJ/2XVGBCvuH+Axpf5MJlquBUfcGeBlwWKgnjnQlPRXiyHqhI9h9ZxktogkK0M1/IDsZAy0/i7bq8Wv2wm5AKG/5FBel2gZy6IsFqwxrl7lwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgMzjLxnJmAV7zU1n1doVIEiYS8OH42EabYDwDi9m+M=;
 b=jmV2yKT+WUI3LOuJFsJJuFeoOZt6YBv8R3RmS127j5BK/3CrimYo7FSdXmZ7jBUf3A83SdQJ2ukV99YK0PvrBRFMlrUCeEFyP6ijwu4S/kh4RhuTtuslJDaAQNrvLLGqnWMbHm9XvU2j01RQvwvHzGY0JLh/dJnNEWc0XJATrzzdsRDjlXlo05Wn3cDe0dnEMXl00lIY1FcUXC4TCnYv3dbepSu58z11gjelmbpPCTP9uDS0SLfGlZngGwzrfrnVO83Y7iUn+YOwiQM0GED10R4I5CNfwUlrxb1/W4BWWNf9oV8ajsnPYo+blS/7UwRJylInLe9dsrD/XK667apmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgMzjLxnJmAV7zU1n1doVIEiYS8OH42EabYDwDi9m+M=;
 b=gEleRSrbboqHQe4T9fvN7kLvYk3J562RQPmgz483UiTtjN/o0za48BBOjrkGDdmzh8xFu9JNuJ+evmeWZ2QdgJgkgDvii0XN8g6dM9U4jZ4ajXSCSrnld7iXtv0p6AbLd+u13bX48JB8qZoowz7z+ExxLqo8pen3ccgHFzyAkXdT7eRbO1jqACyRlBsTfDkXN4tzZVZKcycZKRl/jfAWlQaMciSsHRz0J9PbRPkd99/3h6C+I3krkn7fVPemtOs6BXBTbPC40LsMzx3BWaWChW5PPjrsXk5XX9D1IofPrXIUo0a4JkEALUUS28PmqRGnjj7dV2rCNnIGyudZ+rNdAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by DUZPR06MB8724.eurprd06.prod.outlook.com (2603:10a6:10:4b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 06:14:13 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 06:14:13 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 17 Nov 2026 06:14:05 +0000
Subject: [PATCH v2 2/4] serial: max310x: re-check the TX queue before the
 after-send hold
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-max310x-tx-fixes-v2-2-b395126fd23d@vaisala.com>
References: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
In-Reply-To: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794896051; l=2547;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=yxw+rga1UVi0Z2vhADlUFN5h1RESJIQyhsg2WO4xdTQ=;
 b=s5bPoFY2LHNStLGPELMd8bwqufjYMTLYi9fR8mVVBGxMvlSmlc+sciSmEHXQMRptKaujHj2u7
 HdcYS1ubGa4BylJ6bkr3FLJf+miY7d1E0VwLeQlhpsscLTvOqRtRDP+
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|DUZPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe3e0b3-ac38-4980-a1ab-08df447200a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|1800799024|376014|18002099003|22082099003|5023799004|11063799006|10067099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	XkhMrE7w3y2Io77XJIJbSh4LN6eneEWWvaBn9hUfqHvzHbq7IpiWDwyoE8BxuTmNc0ul3C+dqo4EXtbDcUUdGvSPbIejNyQdmdUqlMt1nwrQjjObqAFxGqpytp3+Ne9QsvrIXre6CsaPBZacLgInu7OKXHUyt8xfQyK2odQ8GgehSwf+NeA9EySyz3QBeSRxrVi1rkLrZsIw2Ozo/oZ4vaZidrV5EuUxG0M33oznmwXSPXMTQ6elAJBU7fbOE2LVXOcdTUIRa299rwX2URBmoN6IvJGPelsvzMMD9SUM1ILzuW3I7SggAxlbAEyH2ZIIndQvQPUz4hlWS6GlTaVfOvLqwQFqanNgvTVmnqIma6iinOYtEaemyNqydyLyNiu8jJU4zBad4/YD1OCox64BcilZOUGhtcGGAOch1+9t9kvmF7ub0wjeD0X0F5QYDohjEXu26J2/spuPkr903AjTarEIAi9Cff5VtSFoTCW2WJTEv3SnGLHkLewuT5SntkvS1xWnGOhYcExtKO1PDSd+EAENvPMH+2aQ/jIr3KkBGaT15jese24IYqU6/REv/EkEe5HNpixAL+F/Oj1aehg1GjYGv3jmVUiXHPRwZsegryRK9chc6Ey1Qc4rKBveI3t2zcynyrLI7KMNH/j/o+ZB7OZyhWm9VCbo6CgoKw+7bFEjiWcjOLJdjaTQ4+9LoFKDonC5JLcUicBEMGU1v/cUhw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(1800799024)(376014)(18002099003)(22082099003)(5023799004)(11063799006)(10067099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0xWSEZFTWFWWFAzV1hNNjlNdHlGZEJabkNvMmN3TmMwWTkvQnI5UXRTcmgr?=
 =?utf-8?B?cytEVHN4Zk40QXZ5b3hqNUFxUGtrR21oQjNKZDQ4Q2JiSGp6dkovV3VTci95?=
 =?utf-8?B?U3BUZWRldy9kOEN1NVJLQm91VkFUbXZPMEhNSUw4Y1crS2FiVU9pK3lGcWQz?=
 =?utf-8?B?cVNlN2ZDWEZaTzJnZXA1YzRuNGhlSXdaTDBhTkU3bmx0VTI0K29BRWZlbnNl?=
 =?utf-8?B?d2U0STJ2N2hpTjlURS96UURBc2VtK0V6MDBnN3YzbWRpaXN5TEowaWVSYXN5?=
 =?utf-8?B?TmpYTzU2eVR1cG5KRWgrWFc1eGtSYXQyc05UNDBVWDc0clgwWEVaT24weGZF?=
 =?utf-8?B?ZDAveC9DTFNtRFpUUmdEY2h6cVVGVkcyRUVjOXNDQ2QrK3lzR1U5YmViRnBi?=
 =?utf-8?B?UVpXaitoU2Y5Q2JIT21jM3JRNlYvdDc3bE82SEF0M3ltbVBKRzJnbzVxSW93?=
 =?utf-8?B?OTF3YmtzVHpMY1drSGxSYjlvRnRKa2hqS3dTM08xQWVwZGpSbUZFdlpaeFJM?=
 =?utf-8?B?Zlo5M2pTcmxSL3RyemdTVlVlNG5ReCtiYit4empTSUhUNm42ODl2L0lXZm1I?=
 =?utf-8?B?eTZYMUlNRnpNQTJwWlljTXhDSjZ3QUMrL3hWTnNMSzNmTHZaZDlTKytWOHNr?=
 =?utf-8?B?T3phYUJVeHNFc0tKRUd5OGNBNG5VbzV6WkZxbEFqYk9YcUxvRXNkejI1RUtW?=
 =?utf-8?B?LytWYWpPYVppblZkTlN3SDl3UU83K3VwUis1SnRPNHpUdFZ1M0M4VGc0Ujh1?=
 =?utf-8?B?MVlkYkVJZVJ0N3k0bjRhNEJGR0xkZ1U0R1pQcW4rZUJLelRURXloVE8ya1Bl?=
 =?utf-8?B?Tk9aNGJPZHRob0ZRcVVYWi9id1Y3VE5uUDl2WldrRHhzb0FuUVl1UlNpd3l5?=
 =?utf-8?B?NU9zZmE0RGl4Ti9JT3Vab3B5Zks0eDZiNjJoQ1FIYUtTT2lQN1JEQWoveGUw?=
 =?utf-8?B?ckxkS3JMVWtZcld3STlUMTRCdG5sdGo0M2o3RnFrRXhHUUdoSWEzSEljS3ky?=
 =?utf-8?B?Z0FhM0U4aFA0ck91Tjlid1crd3Bza29ZTGplNW55ZU0wRXVHVkZCMml3NUox?=
 =?utf-8?B?VVhldlRORHVrR3kxajZ0ZjFOdFd6RVk5dWdwLzNCMFNSNUhCR001M0lERDdk?=
 =?utf-8?B?Q3A1L0RvWjMxVkFCT0hPWHMxNjd6bGNDaUJKZ2o5YnN6dUxicjFaemVoOUVZ?=
 =?utf-8?B?UmJPSDJDZjk5cXM4c0NXanZZM2tWMVJPMzhCUGlyZ2ZZWExBKzdLM1QxOFdk?=
 =?utf-8?B?QXZrODl3N1hQSi91M05XYlIxWXUxZHhnZWJid1BiUGFKRmRSYVA1RTBqMkRt?=
 =?utf-8?B?aFZtU0FqN0VucGx3YnpVUXRma0RzSXZwdjRWWWZ0RDM4R2hkbmJoUjNWS2Fn?=
 =?utf-8?B?VXlRTTM2Q1NJeHFOWk51d3Jjd0NyUnR5V1ZEVmk3U0oxa0tLbzJnWUNmdVQ2?=
 =?utf-8?B?dmJQcnVtcTJHd2o1TW9MSm5NRGdYeSs5SGhvM0NQc1I3VUJjTk1hTzExQ1RV?=
 =?utf-8?B?S2FTNHh4aGhFVzNWZjgzK0NacVRUMDdtTUl6ZTFLMUdOcVVTQjBwOVh3YVIx?=
 =?utf-8?B?UjJiT3RDeklsSzFybjNHRDh4M2FrTVNUVkNwbm9jNllFT2NnaGczaUxDMDR4?=
 =?utf-8?B?SVVvdjBZV2lvRE5UcmhoU2VOSlFlaVZTL0t6RkU2eldRL2U0MnQyWmpDOXdy?=
 =?utf-8?B?NUZENmd2R0tKZHpYZ2k4Wi9XTFdBN252My9MQUNIdC9FbW9pUW83VmxUd2d5?=
 =?utf-8?B?ak5WY1lZNStMYkRkNGNXOXplb3VWM1Q5ZWdFRllUVTY2ZGtFNDZCMnpqU1Y2?=
 =?utf-8?B?M0wyMVpkdFRJV1hPTHVPaENvejZtRWlyRFdGRVNwVElFeGxsbStnekIrTENT?=
 =?utf-8?B?QWxwQXV0ano2bEhQT2Y4a29ueGJIODRQRlN5TUV6NFROOURUYU5TVmFyM0tk?=
 =?utf-8?B?VndjUmNsSGdDWFdaU2ttblBuUHNJcksxWHlRK2hxY1dCM2dpYVZ0V2wrREc1?=
 =?utf-8?B?RVhXRGZxSml5SXdYY04yNFNTQkphRnJPQmwyeHM0MjBZek95dzFWK3FFME5a?=
 =?utf-8?B?UE5IT0pjdFVtd2VXTHRsTElaQml3eG4rVE9zYU45SEtLR09ZcnJmTGxPSDBZ?=
 =?utf-8?B?Y2RlRG53YWZaUGNvLzBxM3poWmJkc3E4R0tjTFZCTjRnMzRVYkhMYnA5b1pS?=
 =?utf-8?B?dHNUUlNGZ1Z5T0VMSi9jSHRvZ1RLN1lBcWZiaGszeHNMVURHcVF6MWZRaTcv?=
 =?utf-8?B?eGxTZi9MNmZUOGxlSnlUSllhRFE4T3VKN3VDOFYrZGhMcGxkdEJTSWJPZXZ1?=
 =?utf-8?B?R3FXdUtKN1lGR05XajY2dTdFa2Q4RXlDdGh2U0RlVVZWbVIzY3czN1RVM1BU?=
 =?utf-8?Q?VJqBJn4f4zIQtFdE=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe3e0b3-ac38-4980-a1ab-08df447200a5
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:14:13.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdoSKn5aCWGnyrOOmFDMN5NK2ArvSv0120NC7YBsXC4xEpJpRzsx6wVmy6Byp4x7bgmNI//7EkOljBNS2+BstVje6a2SLPMmLRoWT+d7GME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8724

max310x_delayed_stop_tx() decides that a software-timed RS-485 envelope
is over when the transmit queue is empty and the chip's TX FIFO is
empty. It tests the queue first, then reads TXFIFOLVL over the bus, and
only then takes the port lock and arms the after-send hold. The bus read
sleeps, under load for tens of milliseconds, and write() queues data
under the port lock in that window. start_tx() finds the envelope in
MAX310X_TX_SEND and does nothing but reschedule tx_work.

When the stop routine resumes it sees an empty chip FIFO and arms the
hold on a queue that was empty before the read. The hold expires, the
RTS release is scheduled, the rescheduled tx_work pushes the new data
into the chip FIFO, and RTS drops while the chip is still shifting it
out. The tail of the write leaves through a disabled transceiver. No
FIFO overflows, so no counter moves; the loss is silent.

Seen on a MAX14830 behind a slow SPI path with 20 ms of before-send
delay: 25-byte writes every 20 ms lost 1600 to 2200 bytes per port in
five minutes in RS-485 mode and nothing in RS-232 mode under the same
traffic, overrun counters equal; 96-byte writes every 60 ms lost
partial chunks of 14 to 75 bytes a few times per run.

Re-check the queue under the port lock before arming the hold. Data
queued before the check keeps the envelope open and the pending tx_work
ends it once that data has drained; data queued after the hold is
armed is already handled by start_tx(), which cancels the hold.

Fixes: 33632215e1bb ("serial: max310x: drive RTS in software when hardware delays are too short")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e6a740295b96653281a92f8d94999f06c2c74685..7ddfe8773faf9bc51621c49fa5d8e7d6b1e4bc34 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -897,6 +897,14 @@ static void max310x_delayed_stop_tx(struct uart_port *port)
 	    READ_ONCE(one->tx_state) != MAX310X_TX_SEND)
 		return;
 
+	/*
+	 * Data queued while TXFIFOLVL was read: start_tx() saw SEND and only
+	 * rescheduled tx_work, so arming the hold now would drop RTS under it.
+	 */
+	if (!kfifo_is_empty(&port->state->port.xmit_fifo) &&
+	    !uart_tx_stopped(port))
+		return;
+
 	if (!hrtimer_active(&one->tx_delay_tmr)) {
 		/*
 		 * Add one character for the byte still in the shift register -

-- 
2.47.3

