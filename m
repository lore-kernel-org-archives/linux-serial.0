Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793862782;
	b=MM6shPMSN41VJL1zLNCaPCUuHN9Ahgy0FRqEl5pFEOg/dk6c5c82HqQ73yBHGNsGn59S
	 xX6deBQt3SWu5PvUEXoeho/h8+9iM/dq2Rcfv1gr3aFKTBH9XpyWyJIUsijMAzVHUidzJ
	 LupNs7VyYDQDyc6tHUkipT34TBmQfRSWGjV8xadUODxcDNFdU9DpYxq5qICj3FtCoC0cH
	 VLaa64JftBGakOktOylaQ1D8lDutVhm+iLfsanFASf4/pDbr4+2onqDxM/Wlt7234l5om
	 Y8inUCc/hgOtPxTOIBhaCsxQAF9X3yYeRJLsqKeTIc4U68j9dagzuj6GtHnOLzBwMlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862782;
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
	bh=DF+kec1b3UwADrZqzFt+9LW+3EiuvDJ7ZEU7kF4oXrA=;
	b=1XRFZGKhcQ2VH3jqOu1kjsTsKznfQt1t6AgBcFBKCJEyJ4i4KZEjRCyscXBDVc2yez+D
	 rUCQ3nWy1e5r+66ofySue2Mk5eUScTF3rtNNqQt0bDkQ7e3a3LCHbMJiezId7yU2X1PTx
	 9oDcaqKNjyl/TCORe9+659+msctyBemMBlV4z6ZxFKPBEM/HYlKcN/6IvpZdzFs4E65DZ
	 eQNlkNaGU/ep5VwbJRqrEBMH9+8+PnAdeyRXL9oEDPVZtu6hwA1eCs399o192Y4PbEPpq
	 XRoPgN+hQgqkFob6+kUGIxFxLF8jGa+hhQSxNQ6+GfFj1YO+8qAaoA9Me6/Ky/f6EQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=iQz3whcU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.138
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023138.outbound.protection.outlook.com [52.101.83.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF1606A32C;
	Thu,  5 Nov 2026 07:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBDF1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=iQz3whcU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifJrPiwwZfeIH+gmXsKrVuilPI6pcG7Lha9UUMwML/IijM6Osjy1zuYC0HCIcnqRmDwXlxrrq9nu4hsYxDoBUnKZjFBJaedfjsa7obJQV/HruUo4Z6S6Mm1kv6z4Jxm50KTf3eK8dfutYOp1V6G7MXqQx8Ug+OXhpnNc5WZwvDpv6OCMBnmQ7ogcfDhqVCe6nWrChaeG9/UE/zLfJfQgwnCs/oo3IrWRZiwcS2+JX/rnjAop3jCrwg+EKJu8Ian0rp6UzOvZJbahrPhi8ArMEk9V5JB4odeN1U8lKed9QwXo339teIJBfp9RyqAtOXtekOJBz7DBQI1a159KcE4oSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF+kec1b3UwADrZqzFt+9LW+3EiuvDJ7ZEU7kF4oXrA=;
 b=I9m8/+ACmFsgtiG45m3yWLcBvWNPfeF7rG6oOtWhvAxvd1lKC7fWxkCcqiAnWiKZtPQRBQyHdddtQR9QzrYMoyqZktwtQygUrktz31HHCYeSDquooBeR2cJ+YYPCuISaGVntTXaZncNcsiunHIdPvXoIcu+glEpvkyhZIKCge4XgSssTnZZpNMq7Zw3guIsWT9JojA+7lrLulRjum8ziRh5qNq5uKl3/zz/5AciziB6PDF+ki9AwFue5+YVCxXN5lo/7E73Og3zOGLfVVjPfzKyXbvqlYJ1Sn3gzQc5j5ZxTQzZHGLJ5zFOlL0OOrQz0smHpclTkxc3O+1tCkRfIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF+kec1b3UwADrZqzFt+9LW+3EiuvDJ7ZEU7kF4oXrA=;
 b=iQz3whcU+3SwAh4cvX08vOCAusDfZm/5bnngz80tUKUO7+w+5kEWW/fKs2jurQpGyYgMSIPr210kqUH6JQaiCG9S4BcFyQr0tbcqySAmsHxA3vRQI5cpsKVtBVRBSC081F7nip5UIF8n4CcyDEEI41QSkm2tGeWqmefEgDwzBtjc4TrBcWl0I2BNuQT5b28FN1/OgQPnHrJdryRwmMmlWo+HZkh84wKLNW2WbozVMQrxa0rGIQOAMTA08LdoLAAczKZhdfNg+SOqZsuWhM4SDVviqOfI/CEAs8Kc2rQAIC2TETWGNTmGCxRb9oEJCLqROXfbuExW5mKJfTpAN+kU9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS8PR06MB7877.eurprd06.prod.outlook.com (2603:10a6:20b:3c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:12:50 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 07:12:50 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 05 Nov 2026 07:12:20 +0000
Subject: [PATCH v2 1/3] serial: core: Forget the RS485 GPIO descriptors
 when a port is removed
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-serial-rs485-mode-gpio-v2-1-027e5348892f@vaisala.com>
References: <20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com>
In-Reply-To: <20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793862767; l=3847;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=m65HZntko/Jblu/aGm35WDF7WZnC1nDspD1nI4o0o4M=;
 b=nweMvU8IfXfO9esDQCXb30eWCRyGsakA2Em9PIysm/9Etxcg25CpzBlje+r55UdZODZwrXbw9
 6EVoW4Lnvx6DF9w+uaxKU+O3EJUsisoCnA0hZ3uA02k/JFsu+69oLh5
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
X-MS-Office365-Filtering-Correlation-Id: 874ee62b-a09a-4932-c6eb-08df3b0c339b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|38350700014|11063799006|5023799004|56012099006|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261009221227099003|261028144727099003|261026121527099003|261026140227099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AGtqktEnRv1vXksSiryRPiRyHVAtf1ZNJe5FnxJVnnpD90Z4ko9T6oMhq8XK7D8PZBReW79JqF8AAh0CjlMm8xr3Mz8aQLlXCgRXIy0Dg819xmOb4R9PVMY4Z2wUjjP8DKWimaBCNF7bqoVQ+qbpPAZpHWIY6oLSE979j5HFfuK9nQnugKTV/pkvdaFZ3TQLa97UUmfV8XQomZXbkDVAqTpM3BqHoxU4bzluFyb2GCWR5kicoWyQLXaRTLNKKFn+toh4t/GL6MX/xhlqZeSWykxgTidqerW6a7XKmatqnGe+p6ER3M1MDvb8UsI/MtBzLIme4E4fTYfDRmIrPOvn/NVhmYZMN7FUhiPk1KOEreeD1ZWd78YZPceFEem5dp9V9dEQ/DmVYCIpup7BPJdqzP1s48AgY8KqeJ7mB1nSoTFRaE5prWoN3MvkgZgPaHmHTcbOBiBxXL1PjF52A5LM5Snc/1CdkKsdjA+FM11t4RCmixPN9NwER463qn0knyRhWHbq+LkNwisIsZQIALIUOhS5kPbvpfD7G3h6tfVuB4VP5smxsyLO8mTttCIZX8BLQpNmy/Ft4xes94Q1HXkSdEZH4Y6kraAATESiZW4apKOw7o9StIM5janhGPHn6V4KrkfE2jih28kDHoHIUsEKQrt0UFHGJGBVO6gw4aVWY/q0kAz7aaTPbfVbBwoSlb7SFmhsAnWVw6luUmekRCkA94nvvY+1EJi1Zwoa2AOCStw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(11063799006)(5023799004)(56012099006)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261009221227099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWkwNDFwKzRvbzNEK25lTXZJUThqSWh3Vm5JYnNpZlZlTVYweWVZamFlZ3U5?=
 =?utf-8?B?bjQ3TldQT05hNHVJMW5ESS9aL213TU10KzNXbkt2UGFmUG1MVWtNYzcwcndX?=
 =?utf-8?B?UHhzN3gvNmhGaDBzL2sySzhhS2VmeEZZMjg3NVdBV1JxeE9kOTE4amRFSTBH?=
 =?utf-8?B?M000NzJIUmhxb2JpRWk2SmFwdktCSEI1YmcxZUxvbVRkUDJURUEzVnh2VGZm?=
 =?utf-8?B?RnlUcmliaCtQemU2Z1NGT3ZaR1Y2SmwwOVl0RW8xUzFkZ2d2UkdaRmdENTdS?=
 =?utf-8?B?dXFJOXZObFQ4UVF0ZGxHNHRZNGt4bzJCczMxS3lnYnhhVTVMUEpmV0JPSVJy?=
 =?utf-8?B?dUpxaExuSTlLMFlVS2FxWW0zZWl6ZnZTeFAvcFpnbEdSejUrSk52NS9PcXJu?=
 =?utf-8?B?VXBiSkJZM0s0ZjJRZ2tsVGcrV1NqQ3JjaUVPdmNJUUsrZkU2Z0RqUUlLWk9I?=
 =?utf-8?B?QUhaWGhqS0FIOTk2K3JweDcrdmN6SmxRRWgwVGRzOFBySmwralpXVFFMcm84?=
 =?utf-8?B?aUpNd1crM05qbGF5eVo4TEFJTXJNeCtnQ3g0R3ZjNlVwbDRJbTRiNytaZTQy?=
 =?utf-8?B?R08ydjNFcXp4WGVmakNWMFlzc3pZaFhVRS8reXIrbCt6UU5teXhxMVBRaGVD?=
 =?utf-8?B?NGh1RFdacml2b3ozTHNFbEV5UEJVTWU4M3RMNk11MGtMUWl1dFFnNTE5VjJG?=
 =?utf-8?B?dHRQL3pjeFdPVkhmUm1hTUNjdW9CaWlpTWcwaHB1VUx3VWRGVFo5aXRIUm1C?=
 =?utf-8?B?eDZxVGo0MVk4aTU0M3NOQ3pIL0xWbXRRc0FVcWdkdmlPTFNtSzZ4azRxaVZY?=
 =?utf-8?B?anFmMkFXRGxUNWhKNUtoay9ZbW9pVlNXWlRtQVNNc05yd0dxT0srZE5RQkE1?=
 =?utf-8?B?UWRsMzZteUh4dEVmTGZPVmk5bkJaNWFaUmlvQ0c4SkNtYjhvUUJ1bE5oUjJO?=
 =?utf-8?B?dUlmRmdzVCsyS0dDWVBJbGt2Y3kyUmR2dDNFcnVIQ2JydFRLTDVDWUg4YnZm?=
 =?utf-8?B?NFhkVldkWFRNcHFFSStYd2FhN3dadVZoaWpxVEp1bnFUNEtxa1hvREdIU2VX?=
 =?utf-8?B?b2JkMVF4UTdZblFCM041dXJXR0pLcXNsUmFwS1c5TXo3SjE1Q1VOZXFreGww?=
 =?utf-8?B?VlA5NTRHQUlRRUUrcWNSTUNQOXRReGlONy9Yd1FNNllVekRVM3BkZHZQVU5V?=
 =?utf-8?B?QjF2RjBTZnIvS0VjbEJ5Y0lyOUlVQnY3TElDbTBNYVJ6aUhFSW0yRThlUk1u?=
 =?utf-8?B?OGRFeTlvYkl0cUM4eG1zQ0kvdTdxZkxnakkzTGF4R2pIcXVuTTFwb0Zmcy8x?=
 =?utf-8?B?OERuQ3ljYTYraU5OQ2Ezb1J3KzQ2cHF0ckJmeVE5N01zZDFncmNIZlZEN2VP?=
 =?utf-8?B?WW1yRm5nT3FRRTFuMVBOQ0tqMUlTZXQyOGs2em9CMGJjM3FqT1pSdWhtL3JE?=
 =?utf-8?B?eDFhN3VhUm5KUXNMNjM0SEt0ZndscVJIQWxVSk92MlBkaEhCb1NiYWZFa2Jz?=
 =?utf-8?B?TkY4aE41MGhCN2tBUEZRSGpwVkhoL3FnYkgyNjlpcDZGUFgra2UvL2FVNnVl?=
 =?utf-8?B?MzNVQlhJV3dJNXh1eld1WHo5TEFhNHBGYkhEejF6dVVwcUVQWkU4ZG9Samha?=
 =?utf-8?B?UER2dFpJbkFUY2xZdDFOVGZ2em9kaTlydkFUQm9mUzVRajluUW1PNXh5WFdL?=
 =?utf-8?B?RHlKdGdaYVZ2VnRWVWJSYW9MQUhvYVl1RnBYU0h2SEl4WUNubytOWDBwU3JI?=
 =?utf-8?B?Sm0rbU9rcys5ZjUxcTVGOTlYZS9Scm5aOTg1cHZiNXlvbWxOblFjY3RYRjl2?=
 =?utf-8?B?L2lEUWhoTWZvOE1VNjVVRkxMKysxclJQN25NSStjQk1oZ0o5bTVKQ3UwaThV?=
 =?utf-8?B?YVYvOUlrZ3Qxd3hxUkhYU1NuOHd2NXZ0eWtmNWc0ZitHMEFwekZxYWJhaWZl?=
 =?utf-8?B?ZGJ3b3R5OXdUTFJxaXZReEoreXdSekVLbExxVmpCcXdHWlY5T2lnajlaVlkr?=
 =?utf-8?B?KzU3MzZLWWQ5MnI3cUpWYk9mWndNNWcyaHVLa0lEanNhR0RTejVTT0VYWkRL?=
 =?utf-8?B?M0FYNUw1MldhMDIvNk5TZUVJRWhJVlYyV1psZjY0OHp6bi8xS3k3bmxKTVhu?=
 =?utf-8?B?REw1WUlyK0dTdHlQdDkycG4reHBQMy9iV2tlSWVMUlV1NklPYkxBVHQzK1dV?=
 =?utf-8?B?UFVBc0xuU0s5WTVEdXZtN1FvR3N4WE5MaVZWRStmUVg5cVl2emFhZVpuZUln?=
 =?utf-8?B?M1BFKy9XV1NiVkszZURqWTVWZFo3RUpuMVlicU9XRExaSlY3NzVnTHM5VFgw?=
 =?utf-8?B?WFQ5aWRYMGFSOEpaNlZyRXRSM1BZVFFSemsxcUVJRGtES3NmRnE1YjlpUGd5?=
 =?utf-8?Q?UeZWbcw2oLib4g7g=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874ee62b-a09a-4932-c6eb-08df3b0c339b
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:12:50.2019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24k+d/DZlomR5DPZM1ar+m9n6wR+08M8R1c+4qcQtVWZHPkusH/obbz4kdpgjXK145AZyoqGtPrYRlI61jCIID3uuugKDy3pVRxZP95KYmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7877

The RS485 termination and RX-during-TX GPIO descriptors are acquired
with devm on behalf of the port's device in uart_get_rs485_mode() and
stored in struct uart_port, but nothing ever clears them. A uart_port
can outlive the device it was registered with: the 8250 core keeps its
ports in a static array, re-adds an unregistered entry as a placeholder
and hands it to the next device that claims the slot. If that device
has no RS485 support or no firmware node, uart_get_rs485_mode() returns
before acquiring anything and the stale descriptors stay in place,
pointing at lines that devres has already released. Enabling RS485 on
such a port then drives GPIO lines the port no longer owns. The same
happens when uart_get_rs485_mode() itself fails after the first
descriptor was acquired.

Forget the descriptors when a port is removed, on entry to
uart_get_rs485_mode() and on its error paths, so a port only ever
carries descriptors acquired for its current device.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/serial_core.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af41db10de15ccca4169c603d9cebf6..9516f50a72139c73d70826f4bb0627aed2d3d310 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1415,6 +1415,17 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 	memset(rs485->padding1, 0, sizeof(rs485->padding1));
 }
 
+/*
+ * Drop the port's references to the RS485 GPIOs. Do not touch the
+ * descriptors themselves: they are devres-managed and may already have
+ * been released if the port struct outlived the device it was set up for.
+ */
+static void uart_forget_rs485_gpios(struct uart_port *port)
+{
+	port->rs485_term_gpio = NULL;
+	port->rs485_rx_during_tx_gpio = NULL;
+}
+
 static void uart_set_rs485_termination(struct uart_port *port,
 				       const struct serial_rs485 *rs485)
 {
@@ -3265,6 +3276,7 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	 */
 	uport->type = PORT_UNKNOWN;
 	uport->port_dev = NULL;
+	uart_forget_rs485_gpios(uport);
 
 	guard(mutex)(&port->mutex);
 	WARN_ON(atomic_dec_return(&state->refcount) < 0);
@@ -3579,6 +3591,8 @@ int uart_get_rs485_mode(struct uart_port *port)
 	u32 rs485_delay[2];
 	int ret;
 
+	uart_forget_rs485_gpios(port);
+
 	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
 		return 0;
 
@@ -3628,8 +3642,11 @@ int uart_get_rs485_mode(struct uart_port *port)
 	 * Works fine for short cables and users may enable for longer cables.
 	 */
 	desc = devm_gpiod_get_optional(dev, "rs485-term", GPIOD_OUT_LOW);
-	if (IS_ERR(desc))
-		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-term-gpios\n");
+	if (IS_ERR(desc)) {
+		uart_forget_rs485_gpios(port);
+		return dev_err_probe(dev, PTR_ERR(desc),
+				     "Cannot get rs485-term-gpios\n");
+	}
 	port->rs485_term_gpio = desc;
 	if (port->rs485_term_gpio)
 		port->rs485_supported.flags |= SER_RS485_TERMINATE_BUS;
@@ -3637,8 +3654,11 @@ int uart_get_rs485_mode(struct uart_port *port)
 	dflags = (rs485conf->flags & SER_RS485_RX_DURING_TX) ?
 		 GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 	desc = devm_gpiod_get_optional(dev, "rs485-rx-during-tx", dflags);
-	if (IS_ERR(desc))
-		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-rx-during-tx-gpios\n");
+	if (IS_ERR(desc)) {
+		uart_forget_rs485_gpios(port);
+		return dev_err_probe(dev, PTR_ERR(desc),
+				     "Cannot get rs485-rx-during-tx-gpios\n");
+	}
 	port->rs485_rx_during_tx_gpio = desc;
 	if (port->rs485_rx_during_tx_gpio)
 		port->rs485_supported.flags |= SER_RS485_RX_DURING_TX;

-- 
2.47.3

