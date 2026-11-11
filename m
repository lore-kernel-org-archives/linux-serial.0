Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400109;
	b=hT9F3WbGxvblCrJxvL3I3wwF/YLf4dsRs1AIXkwHE7fxd/719Ydy6x9SwMJZUVkdKXwX
	 urs1gNYI0i1KSxrq04FBWWecDmbS72kDI4jJB9vDWKGZfg0tGPWypS4d1gHAclzgVBEjF
	 FegYDXKHkuhALiHPZnoQcU9BLSwiTCAJf8YLVPbFyS4K/IT0VdaYUPn0eb8w+Nhi6uDNt
	 2t2z4uiw3ZDzwytW4sk89GOzZVPGT+NSDIBMqPMDlzfG2geZ1269jU8N8VCY0/lxxrq4h
	 o3ATyLPsKcttzRWfvj3exj21Scp1g9SmWBRwC7CHCE37W61/k/yuYgyrk8PXiWybY1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400109;
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
	bh=4mq5yIF7e3zpqLWWXzut8vD2aYUNib06Guq+T1odL4w=;
	b=O6Aj2HSP4MzLqqFmYGtRm6/GBlYfXykCrwSi8adewgAUettZlewXvIOcF30zeju7Smmz
	 zcsWbhWg/cr4kTytYTAV4+UmCbclrYoXIzT1ZWFvj+g5md620S1s+rzmcn87K5inkspZY
	 em43JVnyCGlt71gRqxQv9/QIIYBHDpsgAxBDBZcWPZq4Nuy0OEYeNN+wGhh59n0SUsfpu
	 lf7YAF0rnKZqwlQJ77faz359TxC5EkFmGkE3snxihN+fVlp68oPCyLSDP6WyNqeS351Tc
	 R9w2BTO1KmsOEJhVGp0ZyLXHig+dENZimKGhroV7QHM4u6P0gNr7aJZczw1+n7ysNQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b="FQC/+bwd";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.74
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020074.outbound.protection.outlook.com [52.101.84.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120DD606A88F;
	Wed, 11 Nov 2026 12:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 120DD606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=FQC/+bwd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4mBbBpraqr/lOE0wn7kD1VDcgDFI1VvHx9SfPIXQchWfPAaxNuMU/vWidu55BAGmHWTILtbUCk/B3eCId+cAkZ8ii/oHAfVZu6Nj8BoIUJOMQWLEhc6xxq8LaUMGLbsvvykgaBoS5X/FApFOxswDj11xBpQb+WZIweaB0Pdf2A4LazKkIzYHNrZcO2VoF2zv1gXUk5zNjtLS0L00xh4Xz7SZuPIik1IJulOURCctf1GLlhP3Bqs5xRdph6YZ7/MYWD8DzSp+NHApi4kmLIcFvGUEc/Xl8HhRAdYubYRJm5021nqmG1y2CYSXQMhtL83XC47I5xze6kvfl1ikU8gyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mq5yIF7e3zpqLWWXzut8vD2aYUNib06Guq+T1odL4w=;
 b=BXqO4GW5hdGthGrq8QOfpznDrgPhnacD5//I2Ic/bC2oMbiQbo+Q2e8mS/vlYkXf6RbIEC2di7hKre/uGKGzQan+7KSubKgEZeOMG4bUACGWY6eZ++yeIFmXw2I+4PYSZLB3RrVyUPrrcyalnStQU3HaH/lG6xFK0HENRsOfAt3+mqVsXPbp4o7oXGanlMfwXLBpjH66W6jbyvhCYlIvlG08TJgUfqZLwIAeekVjL4THAqzOIBDxaTJIHwrut4qpYuSLg00x/kb3whg+u1EWdzo0M+klIiDnniiozQ2Vvk2i3CAqgP7SiIGaTJllKULNA0q/2whOSKitwIZ5UNAcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mq5yIF7e3zpqLWWXzut8vD2aYUNib06Guq+T1odL4w=;
 b=FQC/+bwdjV3yFsdfRcdIKGnuCBPABygNDyOcP3h538BvONiT/PXkcEdCBuJaqhImV7lOYveapxyzKwGRlyypfOq/4ua7bRn3sYpdBAfxEv4slmbRPgkzAnqcDjFtPTo7b2JN5WJxTvjkxkg9sgnUxZnLynQMJQGdC1jpsGjI92cdcPfRq+Q1DYNS0pzpIC1XISN+tQSjw/wzKwkF1ki6Gk6YzGP2IQHAZtDJy0Ff2Dp2Sbe9WgHzrG1ONMK9tpKYmKNPxUpfKEq/iqsa+scX1RUa3KwnZ1gxZwO3Z2+6MIq2e1eC/Ut+55iYVDXN1Fbo1FcVb+pezD4LCKvH7d4DVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by OSKPR06MB10051.eurprd06.prod.outlook.com (2603:10a6:e10:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:28:23 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:28:23 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 11 Nov 2026 12:28:06 +0000
Subject: [PATCH 7/7] serial: max310x: Three-state TX and RTS while the port
 is closed
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-serial-transceiver-supply-v1-7-40bad0f912f2@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794400093; l=3576;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=V/3zOr5vQFP/pukbJvEbFdnjdjuoyYdojpzqhf8xWoQ=;
 b=hayptFgaIlODhFe4sQPyIb821wBG4ftkzYIQ+lYPZhj4a5avKEKW2er0MMDfM09k/BqxbhGLD
 bUTZOOhY4X2C9sZT/TqReK427/nC5XV1dnFzcjHAGXQzou+h6h6TbKn
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|OSKPR06MB10051:EE_
X-MS-Office365-Filtering-Correlation-Id: 794b8210-f056-4031-4ca4-08df3fef4647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|7416014|366016|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RdovbZehJG0NxHJhHJ2CnvFeLfqLFKyrlnZMZL/D284ebEzfpEMGrfJCyzEOn03k8d3vqzFTW1rItZg0y75wBxf2TjAPJP9KL5tdN0f5L5P+Dtg5Piv/3xtN824IhudXvlG1jJ3AXpA75TxOe1GKrYhao8MbTlSYOco8NYUfU2H61iBY9Idl70F8OgY4owFUzeN5KQwk3sNGc8BeVibGXt1ixI82hI0dHcp3NTpEiYYT0/o7APuzb0DO+4EOontsWWRMNxwB/Zxq34i924rSGQYE/0/mw8cGzVCABDN8a6/DJbdFxzvTG8/6WUpdGtpFZcVo8chMamA8NFqtcEpO18BiAWHb5/uSQ06zc6GRUo08tV62XWyzqpg34KSJVvvvcSgaG7OlVYCbkUwRyZ86HGVv26cMUoPpeMasz6BCSyH8vkrg/bUlEpZAGaHD/eIEypwvuiaCAnikF49Swt/ULpRfxRJzTaW3OPL74qDOSHLnmeXAh3J67G13XKQRLSUKN4toQ3mq7OkgQAstq9mOrXkyDF+/t7R6FXEzVIbbj1fv3o7DTM6HT9mXhKIi5b1h72s8v+C3MBzMpSDtmENpWzJ6AxHkQ5dhByq9LEU7hH2GJiu5J1EbqgEGATxQ2By2s5aItjXV5wOWTCgLBOEgh5t/WatAc2ZRIq1v/gbKESvf7ulnzXR3XUhTB5zxXy4dlxXgN+Tt6EMuwgmvJ/+1xP7EYiJn6ZmQ388zh3MIqAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um1NT3haNUMzUVp1ajByRWw4YUJ4ZFhwVTZPaW5DSXJwZmNGejVjLytjRWly?=
 =?utf-8?B?c21lTFpGZWFQNGVCNUFXaTBIT3BXRXZlbkpNM3FWU2RXQ0NEdDVmbnUwa1o4?=
 =?utf-8?B?NEVSRjZQVWo2UWpneHkxdUR3UzVPUmk4K21xa3Z3dnhVUFhRMXZTV2RFOVdZ?=
 =?utf-8?B?UG5hK0c3TTdWUjVPelVQSXlaWWd6dFo1UmJHVDBJb2hHVk16a0l0VTdCSzY5?=
 =?utf-8?B?NllJRWRvL3YrekxvN0luNUpiNnRGTHIrNDJVN1g2Y2l4Sm5wQ2lpbmVlNmxO?=
 =?utf-8?B?OG1WaGpRS2xjQmFoams4aW0yNnJjbHpJMS9nYXdpckNzcnhUZ201L2dGbWR2?=
 =?utf-8?B?emt3c3lqUVZNRUpXaC9abHBCdUtDYVljOEdEMlNreWkrUDFUZGlIZXF5SHA3?=
 =?utf-8?B?K3pCaktFRFFXVXAzUWlnY080TG4rUXpzbWsrK2c5Q3NtTU9rb0c4aTdRd253?=
 =?utf-8?B?Qk16RkM4d1p3bDUwOFFocDdCU3dqQ0xHbDRQWVhQUWZ0UStQR0pJYnZnQVhW?=
 =?utf-8?B?azBGZ0N6RXNOY1ZnM0haWkpDeGRNT3pNbEZMVHUyM1NUOFEzR1g4R09OZVNk?=
 =?utf-8?B?ZmRuODhTWHROZVR6T25rbTZSOFhTanVqbUJrb3RKSXdxU3pIVFN4VG9CNkc4?=
 =?utf-8?B?U29CdWtFNW51dTNLTjZ0QnVpc3pybkZkYzdRQVFBelFobDR5QllBYTA4MFhY?=
 =?utf-8?B?RTMybWc5REwvc3dSbTJqNnBYUWJaNERhNTFSQWQrek1BN2tIRDFjOEJobmdz?=
 =?utf-8?B?MG9ZZHFUM01aYUZJRW4zWG9lZ2MrSitnL1pnT09PNTVtOW5VejMzMm9KWEZi?=
 =?utf-8?B?M3Y0aThGUkJxOWlkdklCYkZMMzNMeW1ydmo3Y3NzaG5lUWRlVEhsa1VWQ3pj?=
 =?utf-8?B?NFJaZVpsZG0xaVd6MUpRd3daTVY2RkFJcWZTUlI0anA2eDE3Q0NIYzA0RFVh?=
 =?utf-8?B?dDhXM3FpeEZlSUpqeStPQitqSUltTkNsdzZkdzNyNk1XaHg0cUlUN0pNcVdv?=
 =?utf-8?B?OHZRaHZrTU44U2kxaVBtUTZTaHp4OXpFTVROYTgvYm80Z2lIWG8ybFA5bUdl?=
 =?utf-8?B?Uzg4eUNhamtUSWt0WjAxVTBoTmVOazBZM3NZamJPWnVSck1qL3JaUzFCYUFy?=
 =?utf-8?B?aVFOMmVJT3YvWlowZzg4cTFHTkFxYk91bDZtUWFTaVdTaERUK2VMTU9Raksy?=
 =?utf-8?B?ODRyMmRKK3BWeHArNDNPaXBXUElENVBZM1JqUGhNVU96QzU2V1ZmVnEyU3gv?=
 =?utf-8?B?NVFwTTN1aHlobEt3V3VBMTJnT2lvRHVOekZGcjhrYmVqVklrbmhzZ05uSTBj?=
 =?utf-8?B?c0RwTnhBNndLOFprSTRFaENPWUZnZWdJMUt5SFhQWHI0d2lZbjFtTEpZQk9K?=
 =?utf-8?B?b2tER2FpZ08vdEx2SGd5MUFGRUtsZlo1Z2gvZ1NUMGl0RVVTemU2Q2hRUVVU?=
 =?utf-8?B?UWQ2dEN5RnhhODBPQk1DSXVHTUxxWTBseGg1YmJZUXczMnUwN1BZVUIvWDVP?=
 =?utf-8?B?SGl6dUtiNXB3UThOS2lxczF3OEk2NTJIMWpYdW1XdTJ1ampzS1drWVhtNlBR?=
 =?utf-8?B?Z0txYlBXUXVOcVlRNDNrRVhHdXhnMldPcmRUOVZERi9zZjJmN1ZZRlRGY0RN?=
 =?utf-8?B?L0p0dm4yZnBhN3ZMellMaHpZMXFLb0NwTDdLRUJ4clZoNHFqUU1pWlc4OUJr?=
 =?utf-8?B?NmcyNTllYVg4a0dySGFQT3FqZjJ0OXJnallHMDRwdFEvQkxObWlEUXNkdUxh?=
 =?utf-8?B?QWh0OXBUZUVRVkNIcHFnbGJQK2hGZ0cwUkxta0R5RjFtekJiQzErZm95Wjly?=
 =?utf-8?B?UFpyTXFSNkk4UnRWTzlYMUJ4ZkJqWjQ3VnVFUklnaU8xT1h5NE9yTVdiVzNk?=
 =?utf-8?B?eCtLamFVcExvQlpkWmErWUVSQ1N1N1hLWEZQaVExUC9TUEgyNWQzL3YyaXBu?=
 =?utf-8?B?QnFNcjVkaHpEbUNRY1lxQU5mY2p5Y0paeXRZcCtuajR2OXdXb3psMXdlZU0w?=
 =?utf-8?B?bmlybjdrZHcvSGpiQit5T3R5aU9kVEJBcVppQjN6VTArd2I1YlR5WnVVZmFF?=
 =?utf-8?B?QkR3cTUzQWxnb1lWZ2FuTXhZQ01qYnFhTHEzWFhiUXVYZ29JVlBYU21Ja0Fx?=
 =?utf-8?B?U1I4TEtuTEpoWm5zNVdMV0xNYXR6aENrZUUwWkxkYVlsM2U2eFliU205d0hR?=
 =?utf-8?B?SW9nbFg4M1BiZmIya3FYQnNiNmlOY1BNMWhjdjB1dzNMSmFiNk9vS0d6V2VE?=
 =?utf-8?B?Y2hHNjFDN2hxRDg4SmhnY3VVNGpjamxVYVp3czlkQWloZkY1N1BCMFB6akVO?=
 =?utf-8?B?REN3RGd6T2poRzR2V1RTMVJCYmJmU3ZzeFlnUzB0QjBTYTRJR3h0d0pJYkxq?=
 =?utf-8?Q?6+fKMUj1l6Dug1NA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794b8210-f056-4031-4ca4-08df3fef4647
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:28:22.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2d4yeklyGqRfz5vNNDKjbeJTbhxyXHqH9pVziTwDW+QyXwa2Q9eRxM+FA9V5SM2IdizZIjpypCQyxI+FGH/Q9Fj2L4fSHJWqFms0YaMgMoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR06MB10051

Implement maxim,tristate-when-closed: keep TX and RTS undriven while
the port is closed, so that they do not back-feed an unpowered part
behind them.

The MODE1 register can three-state both pins. Do so on a channel with
the flag at probe time, before the port is registered, and as the last
thing in shutdown(); drive the pins again as the first thing in
startup(). What the part's inputs do while undriven is up to the part
and the board. The pins are driven from chip reset until this driver's
probe reaches each channel, after the MODE1 reset write, the clock
setup and the gpiochip registration.

Channels without the flag are left alone.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 876bdd1f5496dcf46fdc790a89892342fd85a9e4..d5884c870d8e082ea99486cb0d2bf906815e98b2 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -315,6 +315,7 @@ struct max310x_one {
 	unsigned int		char_time_us;
 	unsigned int		baud;
 	bool			sw_rts_during_tx;
+	bool			tristate_when_closed;
 	bool			cancel_tx_delay_tmr;
 	bool			tx_teardown;	/* envelope being torn down */
 	bool			rs485_pending;	/* rs_work not yet applied */
@@ -433,6 +434,20 @@ static void max310x_power(struct uart_port *port, int on)
 		msleep(50);
 }
 
+/*
+ * Three-state TX and RTS while the port is closed, on channels that ask
+ * for it: a driven pin would back-feed an unpowered part behind it.
+ */
+static void max310x_set_tristate(struct uart_port *port, bool tristate)
+{
+	unsigned int mask = MAX310X_MODE1_TXHIZ_BIT | MAX310X_MODE1_RTSHIZ_BIT;
+
+	if (!to_max310x_port(port)->tristate_when_closed)
+		return;
+
+	max310x_port_update(port, MAX310X_MODE1_REG, mask, tristate ? mask : 0);
+}
+
 static const struct max310x_devtype max3107_devtype = {
 	.name	= "MAX3107",
 	.nr	= 1,
@@ -1542,6 +1557,7 @@ static int max310x_startup(struct uart_port *port)
 	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val;
 
+	max310x_set_tristate(port, false);
 	max310x_power(port, 1);
 
 	/*
@@ -1685,6 +1701,7 @@ static void max310x_shutdown(struct uart_port *port)
 		fsleep(max(one->char_time_us / 10, 100U));
 	}
 
+	max310x_set_tristate(port, true);
 	max310x_power(port, 0);
 }
 
@@ -2042,6 +2059,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 			ret = uart_get_rs485_mode(&s->p[i].port);
 			if (!ret)
 				ret = uart_get_transceiver(&s->p[i].port);
+			s->p[i].tristate_when_closed =
+				device_property_read_bool(dev,
+							  "maxim,tristate-when-closed");
 			device_set_node(dev, saved_fwnode);
 			of_node_put(port_np);
 			if (ret)
@@ -2050,6 +2070,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 			ret = uart_get_rs485_mode(&s->p[i].port);
 			if (!ret)
 				ret = uart_get_transceiver(&s->p[i].port);
+			s->p[i].tristate_when_closed =
+				device_property_read_bool(dev,
+							  "maxim,tristate-when-closed");
 			if (ret)
 				goto out_clk;
 		}
@@ -2065,6 +2088,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		}
 		s->p[i].port.line = line;
 
+		/* Pins float until the first open */
+		max310x_set_tristate(&s->p[i].port, true);
+
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
 		if (ret)

-- 
2.47.3

