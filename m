Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794823060;
	b=Ya9ERypuy6hkCIO/ffaN0eiEkAYMlGnTD9J9xuJjyX1GcBSOHb3PGgxvx9N67MXuMoIL
	 eLvIPogQvZb8K5NjujwNXd+xM/fc7PLYINEDeYgCfnsHEIwT5eD34WHERkp6FGUMncJbw
	 NkbJG4RfotR+bSx7MqkldXCrdXHdYtXhPXIGIHaYBve1TUnXEOVcVAMi5Q6vOixkYahY8
	 Wp7sqPybopeVSjBBlXQHSXLgvX/CmCYAu0Y3JIUmlv/PfPMJzHjFE5WvuI3lf5L2vTEbG
	 PXOegVv+YutcMW5K9U1mA2LvUDckZUBqn95QhLzZu6WNigjxekh2bTx8kuPH5nf7JOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823060;
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
	bh=XMaeVK0+vvSmz0BgfnVmnrm45Y8sxR0FNYjuSe2QVnI=;
	b=dguMJw+IoeHdOYREuOwVwu3hgdc1bPaBohGKQenOGC7mTH5oXRVY/H/r/sQ9VZa968Xm
	 b1OWNbfzkfXstrvvzqv3kZEd/Q+yFMsiIu6jyX+gDy/YXirYWC40wDjA/qIgfQt7rIFKQ
	 KIryLv1gi1PDBuKPS3v6dDQKOAUTLUqwz8dlDbeS7a4bv2ZRl8jxIWdhsGEKawZ3ntDaf
	 EUpwG4CgdMN4F5ByqqiKGsqfRmurGCFk1UZfAZkCiA/I0dgUKMLdHZlOWlCt4a5PZD/Gd
	 KUdjt5nv01wER4wnj8rNENva0exew3+XDDhgg4UBXZWr4iF2KGzSseZzEpBHFW7W4dA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b="z/HIlORa";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.103
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021103.outbound.protection.outlook.com [52.101.70.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150A606A883;
	Mon, 16 Nov 2026 09:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C150A606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=z/HIlORa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJfN7J0Fojje4E4whOc0/daTW5ecCImzhpBpYW8o5d7u3pDokV6pYqJtGkRZgDiVm2E8wDU6PXizbV41Cahn3Ldeve8LNN0pjmVpPXphPunOmBp9HL8j90GBnsoTjT6zhftgUKepJR62fpx6hFSV3cZRe4EIekdvXSjeGe+zZni5vUepWzx355nRmmPmUqokVoz9ZZIItarx4Ol8q1MplVhmAnsj61GBYutED27udkfElOc2ist8JyRCW13pcAGS34k22986tmTdovQIFMwYSx9EQNSyXR0qCMGAil5BZr2Bw16e8NoDMHc/b8nBHmhjFrBarmmVZOOJNpy3wiwwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMaeVK0+vvSmz0BgfnVmnrm45Y8sxR0FNYjuSe2QVnI=;
 b=I0VevAxSGWdUzCpiSl3gAIeyhZ0XRZZMk+/ezcG28TeKkswgtqfdWtq7zMefih7IZUfIoYD6GktReomOFXffJZxSmNrg8gFf6flLmdtpNhjeuub4eqMYbEntcrN0sohtJ3rNrtc35AtJFlreQUcf7lvYxu8vNU75Q8XykGJKNk+GzhemFWtDySCIVF0Y9QohwV0KY8f8qqgG1GAJGAyrLKiehYebTk+brZRCdPKicdRfGiGg6CRcW47G3K7JuyiqRtguH/Q9/8UDslbIsLG0Vm/k8eb33iSGUCmhkrGg8Fy7Z7QGV9h/3+SWXh8XB1Af1Vg7Q4hWq0pYlKgnTL8+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMaeVK0+vvSmz0BgfnVmnrm45Y8sxR0FNYjuSe2QVnI=;
 b=z/HIlORaAIXW0nfQrtWqklAtsaQbEIs7UZtcpTwUwVpYyxG8WDkPmCF84hKeWcEbA13Ak1+gyOpQWwbeaf1WZgZ8VtgM8pEAP/iQDNNZzhdI5LHp0NVBLi5tItwaVM5sGckGITieoW22FVsj/ewKgNzD7v+1v/7ckL6eQSuiJCwEFcHXb+1pzatCvl4cd1O4lfaMtzvLmkl8qLfoczY0cSySuj81nN5Z1qePcqIYepaXFfCx7bb4cTtZDO8f0+1Y7gIAXausvkWGPwm0yjBupL/5dDch1IOOj6YCXlZYJwgtHmIqCwC22eLpciHvpzUqJa2tm9cGgLUezQszHOgn/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS8PR06MB7541.eurprd06.prod.outlook.com (2603:10a6:20b:33d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:57:33 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:57:33 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 16 Nov 2026 09:57:24 +0000
Subject: [PATCH 3/3] serial: max310x: hold TX data until the software RTS
 send phase
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-max310x-tx-fixes-v1-3-61c01f180911@vaisala.com>
References: <20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com>
In-Reply-To: <20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823050; l=7600;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=eawYP+amhLcsiszAvBXsQrRq2vOHPblbI7yOPemon40=;
 b=SNm/WRnnC6G/oqy+qBB9rP+I81uRojKM8TLWkxn4C2fCrLmYV5FgnKJgYWZrw1jJHcRtKn5Ff
 hHtAS0vxqr6CAPqqPGXgMmg2Oc8GP2Cc4vEL996jZkyi62Wb3gyeCHB
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::10) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS8PR06MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: ae473ed2-975f-4a04-0343-08df43c80914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|6133799003|18002099003|22082099003|261009223027099003|3023799007|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|11063799006|5023799004|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	r+dSKMppp7XsCXNTCgosYdmF06t1QRPW8oYdecdyR+f0q+PSsFPkY2KcVi4kpNUwU8CLNGqL3gtR64DjNhUvj0oTsAj3ac6C9T9sye+xufP68SEPiBCPbYrjHoH8/fvpEiGF3w8HXW3Vvuxv2PUVuUNfFWUbso2yxIH3sIadEYXei4hkNJ0l3bjVTrucuyHRKRJAqIU3q2sNTFcvy+6mpnlaC3CSwOYnPbL6GZmsY/vT4RBHux0EbBses/7omte3BCTKLsvUOb6IZ9+pdNmdTUcAjInTuxNS9MnIwV2sA0TvKnNRBPtH3QZVLr7jeZiEfhN79dIs4ML8EhOZ+SMmc2gA9LaNoEspJsST/eaXwjVV9kKZXd4vE5tQH1Ux0IY1xF3sO77R36ub/EoKdsBD0AQPEuiBTy0TouZALRCidRoI8pTaO08i3mIWUJHA7riSuu7v2SKh2/z7f3dxtquujWRs2BIEoP/7+wMdgawttPdhZg+r5CPkoFbdQlLIDI2g7OpjuxM1dXG1iLI4sxyIwQkfVLU5jW4/ZBSsMQPHWlTf9uIECctjcWbrOLsBAa6h4aHQVrepXTmV2hulWUVYO5eeguz3VJIUK0SyeoqIv+ms8sHweKJCZ53W2dvmUJhEDSQAHivAtdY24e9DqDdN2Rp1SGwms0sbqO5W4luOVgQQmVi5TromxdIM21Mw6+k6VWiFh1fo9CbG3jyeMJ693Bzj+fJfTCsDv7lo+mG1DIM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(3023799007)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(11063799006)(5023799004)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE1NUWU5bTVYOHp4MGRkaDFZVUVKenBiY3RRVjkzUTlqMFBvL3pNWVJQakVU?=
 =?utf-8?B?WEMwc2ZZMFdNZnpvcmUwZ1RUTkkxZGptOUZkOVRHamZFQ1JEd2pZbVZmZTNS?=
 =?utf-8?B?T1AzTTkxUjd4Vnd2RlZCa0d0cUErUWI1NzNhaERWdHdVSnd3RWE5VlNXK3R4?=
 =?utf-8?B?YUp4bXAxSVJZRzFJcEtHVTBHZzVGNVNxTERxa2IwVjJHYUIyczlLTHpLKzNB?=
 =?utf-8?B?NUVjWHZ1cVlGNVhVSHBUQndJaTUwaEdCZlNBakNvYlFUcU1MamZPUW1lWGNJ?=
 =?utf-8?B?WnZoWEgwNXR0dCtBUFRRdFBDUFhxUW9WNkV3T29Bc0tsMFBDeGQ4SWtaYVBu?=
 =?utf-8?B?amlQQ3FVSFUrbzkwSkpkc2RGSDBBcXlUcUlSaS9JWG9IOHpMRExpOUlyWVo0?=
 =?utf-8?B?SWwyMGx1UlZoVXJRTmZiMXI4L01iazUyNk9Nemh0eGt3VlV0c1ZXekZ6Sm5S?=
 =?utf-8?B?Wkd0c0hYOWZQc0xaVFZvMVhXcURxa2RpazFaR3VyZHJ0ekdBS3JkQkp2YlZP?=
 =?utf-8?B?bFhTYWtzOFUyTmZkS0c0TWQ1ejFoMHFYbVFMTmxFbHB4Z0dRV2JyNFJ4QWY1?=
 =?utf-8?B?NTZpTDBvdXFzMXR5a21sZ28xYVdINy80dDZDNFliemF0cmE3bWp6c3FVd2hq?=
 =?utf-8?B?WGEwY3FFdEVhdnZwdXJmU092ZitKVVdHS05SU3hoQTJ6SDhCR2l6VU1uUlU4?=
 =?utf-8?B?eEhYMHBNWllUTmRUVit5b29HVUY3NDJUZmlRSEJuL041U1lsdG1lRGxONUd2?=
 =?utf-8?B?ODA2cktUc011UDZtRFFaQjdpcXlQbTZXOFdnTU1teVBzamhKN2oyRUlGU3Ex?=
 =?utf-8?B?Q1R6Z21VUE5ZcjlqWVB5RDZHS3hCTmdlSmtrYjltQk90KzI2cy9vOEh3SDZF?=
 =?utf-8?B?RkMyM0o4OHVFSTBOeUlRcUlVRkNmQ0Z3QzZnL3VPTTRmemN3TlpsQmZER0N5?=
 =?utf-8?B?Zjl6MXR4U3V3Y09ySmVvOERYdUtqZ1RTQnNvVW1UTExZUjdqMGc3bXBtbm9w?=
 =?utf-8?B?Z2VTYnFEMFd1UGxZTnpZSGJsaUwvTW5HQlJJMjlmR0t3aS9yOEdVSzczcVRz?=
 =?utf-8?B?TjliZU5rVSsybW5FTHFsa3RGUk1EVEd3RStIWjVSMmJpcVdOQW55NElPajlo?=
 =?utf-8?B?Q3FsK1RUcnhlcTN5ZDIrM1RwWkZKa3ZnaDc5K3BPb0VuQ2lDa1ZmbzY4MGpw?=
 =?utf-8?B?YTRIQWlGeTA2dTE5eHg2MFZ3YjJ5UUxzcldCRzJrdG9YKzEyakJsRC9La0Fs?=
 =?utf-8?B?TTNRN2VOVGVzYmtQVDljVlNnaVFPRFFtZjBqUEM5NFMzc3pGNWl5dEhhUXk0?=
 =?utf-8?B?am5MNUdvZVNmMndMYXdZVC9qZEFaL3NEMGYvRHN5YzV6K0hCU3p1UVRzSmha?=
 =?utf-8?B?cHNId1FNL0gwWUtBZk9PQy9rQzNrakJ5Ym1NcmQyaTBlRS9Kd2dNamZWbFRw?=
 =?utf-8?B?QUNQb0RSamZJU2g4TStSY0M5MC92b2dTQmVXU1o4WEZJZzZ5V0NTL1dEZXlh?=
 =?utf-8?B?Wm02NzhjYlVzUmtqcHlNbGM5aHcvY3B0dFhKNTE1Mit3R2EzVDBDMXdmTVo5?=
 =?utf-8?B?UzJNeFhsSFFwdzF5ZlJZS3ZSbHZsTUc0ZHRjNk1tdTI5bDExVVF4elZwbTc0?=
 =?utf-8?B?MkZ2MUNFU3d0OEs2MnQrQlhVVVc2UnVxWlprV2FVMlZzYU9UUGNjMkRtQU9H?=
 =?utf-8?B?RENnY2V2ajI2dkZYbXVJTTd2WnBISlpBREQ1UTJEYUtvc3lQU1dFN2g2UThL?=
 =?utf-8?B?MGVZVnZpeFdLM1RwNHk3MU92N2w5UFdLSGpvZFBTdVhmeENLU3cvendjdmR0?=
 =?utf-8?B?R0FwbGxCU3FzSWR1NHBWY3d5T1ZSYVVxVzJLc2x5ZWhYY1M4N0VJUWNCbkxl?=
 =?utf-8?B?T2VzcnpxKy9TK1BYaGZLTGtrOEtvbGF1K01DQXU4OVREVlJhZHpTOWx2NUk1?=
 =?utf-8?B?amZSSGl4c0FBTHcycHZMSVFBRVA0ZUp4OHZqRzVFajZjQjRVaTNsVWxCLzZj?=
 =?utf-8?B?M1pGQUk3aHBjZ3p0eWlQS1FtT2xmNzFxVVVGODZBY203MEZwWjNoYS9vTXAv?=
 =?utf-8?B?TkJxd3QzMk1kdlhseGVteld6NzhsRVczb2JKVG9HRzk0c1VJRkhkSkpOYkJj?=
 =?utf-8?B?a09oVjhMVFhzMkZhL2JYRnZESGhURitBWWhrcWxyRzRBb2tIeGdwYjdEY0Uy?=
 =?utf-8?B?WU9Yb09PWjVsQ1V3ZXBkK1h0U1hlWVZvSzRhS1M5WDZFZFVvcUhNZERDMGpQ?=
 =?utf-8?B?amt5aklFNUVydUFidEFMYWNGN3ZsYjhVY1J4ZXVRN05kMndXY3Q2MW5XSlNs?=
 =?utf-8?B?d1ZWNWNPQ1ZIU3RyOHBUN1FnaTNXbloycTUranlYSGRyNjNqL2ZxSThRQ2g5?=
 =?utf-8?Q?JN/oUMTw57C9eomQ=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae473ed2-975f-4a04-0343-08df43c80914
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:57:33.6280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MchWuMTO9AxTvibNanEZXrLFwKkK5qzwPkT0NN/CWBdXrxZ5r7bpUhtChS7Uz6dobNokXKvBRvWHQQsGjRXIOMi2g97izyaU8Ws5H0rmd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7541

On the software-timed RS-485 path, start_tx() begins an envelope by
setting MAX310X_TX_WAIT_BEFORE_SEND and queuing the RTS worker; the
data may only go to the chip once the before-send timer has moved the
envelope to MAX310X_TX_SEND and scheduled tx_work. Nothing enforced
that: max310x_handle_tx() pushed whatever was queued whenever it ran.

The chip latches its TX-empty interrupt when the last byte of the
previous envelope leaves the FIFO. Under load the IRQ thread reads that
bit late, after the next write has started a new envelope, and
schedules tx_work for it. That run found the new data and pushed it
into the FIFO while RTS was still down or the setup delay still
running; the chip transmitted at once, the head of the write left
through a disabled transceiver and the receiver saw the rest misframed.

Seen on a MAX14830 with a 20 ms before-send delay: with 25-byte writes
every 20 ms, 33 to 88 such losses per port in five minutes remained
after the after-send race was fixed, several of them as misframed
bytes.

Hold the data while the envelope is not in its send phase. The
before-send timer schedules tx_work when it moves the envelope to
MAX310X_TX_SEND, and so does a write arriving during a send, so the
data leaves as soon as RTS is up.

One more path enters MAX310X_TX_SEND, and it does not schedule
tx_work: a set_termios() that moves a running transfer from chip-timed
to driver-timed RTS adopts it in max310x_adopt_hw_tx(). A tx_work that
runs after the path has changed and before the adoption is now held,
and with the chip FIFO empty nothing sends the queued data until the
serial core's runtime PM calls start_tx() about 0.5 s later. With only
the hold in place, 10 of 338 baud rate changes made near the end of a
chip FIFO load stalled for 370 to 490 ms. Restart the transmission at
the end of set_termios() the way rs_work does after an RS485
reconfigure, through a helper for both. The helper leaves stopped
output alone, as serial core does.

A software envelope between two FIFO loads looks the same as an
adopted transfer, so a set_termios() that lands there restarts it as
well: RTS stays asserted and the rest of the data waits for one more
before-send delay. rs_work has always done that for TIOCSRS485.

The comment in the IRQ handler said that a stale TX-empty interrupt
cannot push data during the setup delay; correct it. The hold does
not apply to the hardware RTS path, which does not use tx_state.

Fixes: 33632215e1bb ("serial: max310x: drive RTS in software when hardware delays are too short")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 72 ++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 7ddfe8773faf9bc51621c49fa5d8e7d6b1e4bc34..d92bf241558862cd83073c1d12ec9f0aaf88f090 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -942,6 +942,16 @@ static void max310x_handle_tx(struct uart_port *port)
 		return;
 	}
 
+	/*
+	 * Outside the send phase of a software envelope RTS is down, still
+	 * in its setup delay, or about to drop: a late TX-empty interrupt
+	 * must not push the data out now. start_tx() opens an envelope and
+	 * tmr_tx() reschedules us at MAX310X_TX_SEND.
+	 */
+	if (READ_ONCE(one->sw_rts_during_tx) &&
+	    READ_ONCE(one->tx_state) != MAX310X_TX_SEND)
+		return;
+
 	while (!kfifo_is_empty(&tport->xmit_fifo)) {
 		unsigned int txlen, to_send;
 		unsigned long flags;
@@ -1077,8 +1087,8 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
 		/*
-		 * TXEMPTY latches on the FIFO becoming empty, so a stale
-		 * interrupt cannot pump data during an RTS setup delay.
+		 * A TX-empty read late can belong to the previous envelope;
+		 * max310x_handle_tx() holds the data until the send phase.
 		 */
 		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
 			schedule_work(&s->p[portno].tx_work);
@@ -1314,6 +1324,28 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
 			    MAX310X_IRDA_RTSINVERT_BIT, irda);
 }
 
+/*
+ * A reconfigure is applied: restart a transmission that it left queued, on
+ * the path that is now configured. A send state without chip data has
+ * nothing in flight: restart it as a fresh envelope so the before-send delay
+ * is honoured. start_tx() can drop and retake the lock through the uart_port
+ * API - callers must take it with uart_port_lock*(), not a spinlock guard.
+ */
+static void max310x_restart_tx(struct max310x_one *one, bool chip_tx_empty)
+{
+	struct uart_port *port = &one->port;
+
+	lockdep_assert_held(&port->lock);
+
+	if (!port->x_char && (kfifo_is_empty(&port->state->port.xmit_fifo) ||
+			      uart_tx_stopped(port)))
+		return;
+
+	if (chip_tx_empty && READ_ONCE(one->tx_state) == MAX310X_TX_SEND)
+		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+	max310x_start_tx(port);
+}
+
 static void max310x_break_ctl(struct uart_port *port, int break_state)
 {
 	struct max310x_one *one = to_max310x_port(port);
@@ -1363,7 +1395,10 @@ static void max310x_set_termios(struct uart_port *port,
 				const struct ktermios *old)
 {
 	unsigned int frame_bits = tty_get_frame_size(termios->c_cflag);
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int lcr = 0, flow = 0;
+	unsigned long flags;
+	bool chip_tx_empty;
 	int baud;
 
 	/* Mask termios capabilities we don't support */
@@ -1482,10 +1517,19 @@ static void max310x_set_termios(struct uart_port *port,
 	 * taking over an in-flight transfer arms the after-send hold from
 	 * the character time.
 	 */
-	to_max310x_port(port)->baud = baud;
-	to_max310x_port(port)->char_time_us =
-		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
-	max310x_set_rts_ctl_params(to_max310x_port(port));
+	one->baud = baud;
+	one->char_time_us = DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
+	max310x_set_rts_ctl_params(one);
+
+	/*
+	 * A tx_work that ran while the RTS path was switched above has
+	 * returned without sending, and nothing else pushes the data it left.
+	 */
+	chip_tx_empty = !max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
+
+	uart_port_lock_irqsave(port, &flags);
+	max310x_restart_tx(one, chip_tx_empty);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void max310x_rs_proc(struct work_struct *ws)
@@ -1518,26 +1562,14 @@ static void max310x_rs_proc(struct work_struct *ws)
 	/*
 	 * The configuration is applied: release any TX that start_tx()
 	 * deferred while the reconfigure was pending, now on the right
-	 * path. start_tx() can drop and retake the lock through the
-	 * uart_port API - a raw spinlock guard here would unbalance it.
+	 * path.
 	 */
 	chip_tx_empty = !max310x_port_read(&one->port,
 					   MAX310X_TXFIFOLVL_REG);
 
 	uart_port_lock_irqsave(&one->port, &flags);
 	one->rs485_pending = false;
-	if (one->port.x_char ||
-	    !kfifo_is_empty(&one->port.state->port.xmit_fifo)) {
-		/*
-		 * A send state adopted without chip data is the deferred
-		 * write itself: restart it as a fresh envelope so the
-		 * before-send delay is honoured.
-		 */
-		if (chip_tx_empty &&
-		    READ_ONCE(one->tx_state) == MAX310X_TX_SEND)
-			WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
-		max310x_start_tx(&one->port);
-	}
+	max310x_restart_tx(one, chip_tx_empty);
 	uart_port_unlock_irqrestore(&one->port, flags);
 }
 

-- 
2.47.3

