Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4B19ADA6;
	Mon, 11 Nov 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324575; cv=fail; b=lIE+aevQSNznvCLf3IVNTcLFQWP7wMTcBXIWXBH28LlJ3D+cuaNVdT4k/6encxkfK2tfjW6CBsJQim6f3C3ZsIKRWEnTPNkNzhSIkGJ5OZWde6ixzKNfbvMGEUniq2i9dJidiCBJPWpN4tG0LM+Wbvq5T9gTc+TGtBgdxlbPNVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324575; c=relaxed/simple;
	bh=U3aKSTfkIfX8ziAzTwiXevPZFl/XIYiQaKlBFU2Eamw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dh7qkReqv4SEbiRYTQe2p41t7xaN0hRJNFBnuKs1yqv+7zzC/PbsA7cj1CZL2xTpHnB+CY4fcHvzYumbrATmHEnU/VFpOMhgwNPRpxgLSep5AnGkMt+owOWPaZPFGK5B3WSqtm8YYb5Hs+no1C44Vh9bC4fQEUIZJn8S2UNtv6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pk1PJy+8; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pk1PJy+8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtMRg5B50ICl9BfX65vaIlmkRGJpEwlb3JdYnFX3kzYdG/m4owi24x/7Uyfh2ni1l4/KqVXXHdDOg4LIWHtLLgcWll1AneggJzLIy2WIGr7Jo5kRe0umHk+iiJGuP9f38jErCUWgrtajs458TxVuIH2oeMPEWNQM657QVbRZwbwC8OhrQVfDD+kgxjPFiWk4uogV/UhhXdMqAkiuXq/4AuQfUOzWZgxZOqxM3Yk3d8+sMpxw7GirehhJv6KxcNCvyZdmghyxfwEXJvrHkTPOdmd91IUffXswd5rjkMzybS8P5mOUxBbOQ2bv5z2QyYHga7CMDZbVMpxuC4DoH9k7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu0oE1GIGr5qQhuxhEibYhKhPHEqwX6ErErQQhbkEp4=;
 b=uCUFscuCSuE+Gv9eacKaOU91PHbPe8oyQgbuI2SAaHxLgEcSNiiXE+LDnrKmJTTI0PCjLe+Z4gbWCYsasmw0knAYWV2Q2Cn1D4cWW7vEhdxZSWLOBHc4fszec/zrjyo11NiGuXO5xaCFul0ufF1aS5RWkPIgzYUCisCY14f2ZpLLNfVDQS5xbnlJsHgrzo6xai8AT+mgyx+X4s8RJOEpL/p/tsPIgZIpwAGk1nvy1LvtDSpoNsi9KN50YD4bCKXZKJetpnVVqOP6saicQDgW+Etz1d4uRRohaDSXA5nox8eFaEUdtbwW8dRSbJ4p/N6t9WnySvGIT6nNiLi9CNgcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu0oE1GIGr5qQhuxhEibYhKhPHEqwX6ErErQQhbkEp4=;
 b=pk1PJy+8ZdafsRdRGdaXOUyjq/W0Llo9hjx+JXmP+XUxaJnVANiAQzjv0qwiKtHD7cUnWA0CAAFmKhbP7Jrz0ubNrZYj2ukXY+YfV80h8Yf2pwHyixGZsq0o0oVQ7BN0mKVLlKqhGzi8f2rQ4kbUMzuPJzcXXndNlG9ZNWRJDiSDTuxPaBl6db8FGwBwvRF9Bgh3RZgcm6/Jw45HSpu1jRb+AF9PKuTQYLKiY6dzn1ywV/XzkUwodwn0zwuBLPZZh/AyyT+lB+xbBR7ePQLtFpblMRgYPWTrYFg7MoNC66S75sVCIgbWrd3GM2oo9zFVxjammptsrlmZAYdkixgZtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB9428.eurprd04.prod.outlook.com (2603:10a6:10:368::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 11:29:29 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8137.018; Mon, 11 Nov 2024
 11:29:29 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v4 1/2] dt-bindings: serial: fsl-linflexuart: add clock definitions
Date: Mon, 11 Nov 2024 13:29:20 +0200
Message-ID: <20241111112921.2411242-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111112921.2411242-1-ciprianmarian.costea@oss.nxp.com>
References: <20241111112921.2411242-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::13) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d3b5a8-4796-4d74-5880-08dd02441ae8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzFkdjJvL1JXb2JnNEdKQlRtS3B6KzNOcDd0ZklrejJpZzJkcW1MRVh5Q3hJ?=
 =?utf-8?B?dFp6Und6S3RTd3FTSkplTFlhbFZHek1tcGhHQTZ1VUhmeGNBc1BlRFBJVWdE?=
 =?utf-8?B?N0UzWXNnN21BdWJmZzJPM0NOVXFld1ZnU0hjeVJGeVJKb2JpU052c3BOczVK?=
 =?utf-8?B?VjZNanRGSVNnZE50RWN5Q1V2YUo2NUtGZVgzL3VXdVlHeGhSVk9YQm9WTUty?=
 =?utf-8?B?NXRtdGtWdXRJcnQrUHJLRjFBOXVubVdOU3oyazBwRDVwTG9md203VmJxa2FS?=
 =?utf-8?B?VjRoU3FVN3laVWsweWdXRlQ3ZDN3U1ZkbE00dTIrSzY0eFcrSmtKNWZtMU5h?=
 =?utf-8?B?NVJCdVZ5TlpmMm4wYmpkQzcwZ1BRT29SYnFtWVYrUSs4RmpQMDEvMFNnM0Nn?=
 =?utf-8?B?MTd0dWRlMzJ1MHIwcG10V3BEWFdDZnErSHNETklCQXBxRXhDSkZrUEtIRVFN?=
 =?utf-8?B?VGlVNVFWNEE2ZVM1Ynh0OHhKSVN1YnBQOVhiSnlpa0VSNHJvVlpYVWJyREk0?=
 =?utf-8?B?Z1hKdTNhUlJydXkvV2FEbWNNTEpLUkw4Y1Izb3o4T0NJUzkrbjk0d0ZPZGRO?=
 =?utf-8?B?TWRudlJOQVV6ZUdvM2cwRUEya0hrMTFRU0FzUFI5bW13ZVVwVnVkNWdvdVdE?=
 =?utf-8?B?ZElXR0NLcTRvQXlxaU9zVE1DdFhsVnFhNlA2TVJMLzdackozMU52bENtWm85?=
 =?utf-8?B?UG9RRDhVL21xVG5sdWQyZTl0KzFhY3hXQ1hHSmpDVWdGdllKdEpyeHlDS2JF?=
 =?utf-8?B?cVV2SFRjK3RWclNqTWxMeFVleEFSSVhOeUlHMzg5Y1c3aXdhS2hZaFpKM0tw?=
 =?utf-8?B?K0Vuak9zSVp0VnhEcUNKbForcVhpY2UwS3c1ZGpIZlkzQ3VLZXhXdzlna0Y5?=
 =?utf-8?B?bHZhOU51ZE52Wm9IUkJIQlMzSHNRRzdFQk1abzVTMitGY0FZcFMyVmtKK2sv?=
 =?utf-8?B?UkJ6U1FZK3k1b0cyWE12RG1YVk4rTzFUWCt1cWFmdk9WRGlVTS9ScDk3Umtr?=
 =?utf-8?B?U1p6RnE2TkpZV2xEUFFzbXlPNHBoWm5jWHN5MDdtU1oxTWJsbGcxTjNzSUpr?=
 =?utf-8?B?NDlrajBZcldQMnV2amx0R1FLMWo3ek9rWHo4UUFBUUxLVzVFYnk1cDE5UEUw?=
 =?utf-8?B?NGxZaFo0Sk1ueU04cEREM0dKTnJ5eFk2bW1VN2NzOEtzb1dUNkoxSUtuQTdT?=
 =?utf-8?B?UXAwUUJEMDY5WWFGSWhrTStOc1QwR2dLR1NyTVNzbVQwNU5MR1lNSzZ5dlAx?=
 =?utf-8?B?V01rT2w0aFBzN1FDcEV3Rkk3bmVydkhFN1ZTbG15VGZaWWNYYlV4UUxJUFYw?=
 =?utf-8?B?UFVQZzRkaHpqbWJBeGprOHdFWDJmV2JMTDc2T05OSENwTldMTXNYc1Jad1d0?=
 =?utf-8?B?dE8zRFdidEc5aTFjSkNjTjBQajhpWFR2UzFTbXNWTE1WeDBVUTNSS3UrRE9Q?=
 =?utf-8?B?WDhXMjgzWnJVbUt5UWNTRVVYVDM0OG5jZ0FYTEl2VW1naGVvZ2FqbU9JaDZB?=
 =?utf-8?B?ZTBic01yMW8wMUkwR0ZVYW5ndzVPdHlWYXJxU0hoQnBTNHBEZVdoaTVHZXRz?=
 =?utf-8?B?SzdjVGVlWHd5REVDTUVrMEZHYUlhazc2c3JKM3J2dm9GTXJjVitmbnI3ditq?=
 =?utf-8?B?TldwRVBYY0dNQmFxOVplZXB3d01yVk5zUnF0Q1BEM0NHT3ZMNHRIUVRYdXhE?=
 =?utf-8?B?Z0g0VUtxbG5iSnVxdlg0b0hIS3VETWQ0RTNGY3hMc2lEQ3Y4bUJ2UUlOTk5s?=
 =?utf-8?Q?vGVdUfbMnOuX8g8if4iOmeBw1i5rF4nuuJ08mS9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm9OZWVYNmY2SDZvSklZT2VqV05GTHhoN2JPRWJMeU1Damw4V1c2VlZrTmMw?=
 =?utf-8?B?eEk2OFpuS0UwSEVjb290V1hTaHJxYWo1aE14SjVCWUQ0NW43M0Znd2g2T0c3?=
 =?utf-8?B?NHlUK1dvRzgvVkx0QVZXZzZLUHIvRmsxdXoxdDVQVS9lb0hrVktFVHNiMXNm?=
 =?utf-8?B?VERLZ0VYWk9pU3dxM0NDWnpxOHZmV2h3Z1JJVzgvK0pKQlhVVzFHL3RLRVpW?=
 =?utf-8?B?TlZUdTVyZ2I4dlUvMGlPbW1yVEJSNWEzcWZiYTdLd3h0aHhzOEtVYlhLZjVp?=
 =?utf-8?B?TG1nczhIVDZBV0RCNVBJaGpnK3dsemwyVURraFMyVjdONVdGbFU4MDFFMzVn?=
 =?utf-8?B?cEpBVlBJQUdzWGJXd1E5a2g3d292djZQaWN2bDRLQUNUMDUwMlZUcm9QRHl3?=
 =?utf-8?B?c1ZZeFdvTGYwb0g1ZWFaM1RKdVBtTlhCZ3pHWmJ0RWMzUGh5QTBtWHB1QXJH?=
 =?utf-8?B?dVJUZkh2aFdSVnl1THNkK2doY1JnNklENHhsSWwycTZQVy8wT1JqdGdJSWRL?=
 =?utf-8?B?WnBld09CZ3dzNFYrcHo0UEZLdCtQMVd4c3dXYkplNkNpVFZtSitVR1Jnc0xS?=
 =?utf-8?B?R2RQK1dXQzVZZ0RFWG9GenNzZjFiVVlmZ3JqN3lSaHpsUGtqUVE5T0NXakht?=
 =?utf-8?B?b0NQN3RCczZrN25LcFV2MFRBOWFQMUU1akhwNWs3STRkYWt6aHhqN0ZjN0Vn?=
 =?utf-8?B?aCthVkdZQ3VYMTZma0doSnIrVXJQcXYyb1NWVkVrdENHTU9UN0J3WWM3WkhW?=
 =?utf-8?B?TnRHOEY1aWFReDN3MXhBZTNKeHh3VXdJc1F3LzdxbWdmQi9kL2VGRjVlaVkr?=
 =?utf-8?B?Vzc0d2cwaTFSc2V1TzVSbjBSTVNmQUViSWIreTdXejV0S1VHMWtnOGxwMTdo?=
 =?utf-8?B?ZmlVSVZMTHJDZXBlNHg2M2VEZjl4WmlmdmM3Q25OUk5rNDZuSTFNYk1LSm91?=
 =?utf-8?B?b09BT2t4cG90aGlKZnRTanVPMnhTUDYvbzRzaGx0a1JXQVNUVVVKWjRQdXBG?=
 =?utf-8?B?ZUd0MHE2K0IzemR6eUtjVy9iRHFMUXVJcndxUWZrcjF0UUhqdWxteVBlNkpq?=
 =?utf-8?B?UXp3cC8zcDgyL0l3NXNjZFV0eEZDbEpuMUt4ZlcxK3dBbjI4WnNzM2tUclIy?=
 =?utf-8?B?cGx1L2NNNm9lcWhSTGMzN0pKVUxET3RMcldsTjUrYng4eFJxaXRHMngzNmMr?=
 =?utf-8?B?bEMrTHI5dmcrUGkzN2FRaDhaNUVYK3FYV1BMTlptQW5wQm5FT2J2SUdqdWd3?=
 =?utf-8?B?M1ppdlZPd2o2bUlrMWRESzFuZmIyVFd3ZDdzamVFZzl0ZlkzMWFFRjBicHAx?=
 =?utf-8?B?dE81ZU5OWHlrT3RTWUdMOFIwREc4VWk3Ymc4bXIvMWFld3RpZ1RmQU1MY1M3?=
 =?utf-8?B?S1kydVVLN2FRamIwTmllUWxpTXo5dFVBdnNUdVFEcEM4ZFRHSXg5R2NiMmVZ?=
 =?utf-8?B?OW9LYktjWXFUbjlhMFhuU0xnOEVzaVgzYS90VzdBNkRTV1NuYWNEZnh4UUpk?=
 =?utf-8?B?bEI1dW1ZSVI0a1VhZ3RsOVMrbjN1cjFLRGQ1S1JINEROeWFIN3NGNGlpUmUv?=
 =?utf-8?B?TjdrcFBRUUhvcEQzbTE5VFhwNGdiak0wT3AwVDdwNFBjU1lGaHhBVnJFT3Zl?=
 =?utf-8?B?TzBUYVFoWk9ZTGh6RGlsNGpqVTZGb292TDMwc2tlSXRhYUFYRGtVQkFtaG8w?=
 =?utf-8?B?UENtOWovNjh4L0Q4eFJzb05kN2ZtRUZncG11dkU4dnlyV3BVdk5scmpmQk1t?=
 =?utf-8?B?OGdpK3R4Rmc2QUFEYVZMSlRiUk5DY2p1Smpxd0R2NGRyalhWVzF6UjUra0gv?=
 =?utf-8?B?ajVDd2s1NE5qaWVQMENnM3VROHJBb2NORUNrMzBCN0RubnVaTTVQcUwvb2Np?=
 =?utf-8?B?RjZMN2FGR0FJd0lUbktTRTU2S0tzdkd6ZWFQVUVQV1pnRlZvY3ZtUlIwRFRN?=
 =?utf-8?B?a1V4YXAzTnpqTnZkOTB0QXlKd05PRUhHejFMd1g4MGtSSit1Y29XU0pZc3Uz?=
 =?utf-8?B?bnNXM1RiZE1kQkd0VmRVNC9DbFFrY0tjNU9nSktQOC83dlAwVlBwcC9NUG4z?=
 =?utf-8?B?YkRzWkdSYXZ0YVZ5L2dsSTVNeTU4Y2d1U0h1RTF2c0phZzVyZUh2WHo3Wkhp?=
 =?utf-8?B?eFQ0ZzNFVzhxK2hvMEpteUU0L0NnKy9oaUxhOHFhQ3ZDVTRYTmlidVArdXNz?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d3b5a8-4796-4d74-5880-08dd02441ae8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:29:29.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: runY9l9qD5oj2/dBIfyvWlXRNAvaqZBNlcKsJnC8XHWEn6fcy2Y7zen1vdvz1dGLWZQL+cvsJy5DIJJCP0i+JEPxKofARJ3FiE9c1OfSHNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9428

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add clock definitions for NXP LINFlexD UART bindings.

The LINFlexD driver was working because the LINFlexD clocks were
configured and kept enabled by the downstream bootloader (TF-A [1]
and U-Boot [2]). This is not ideal since LINFlexD Linux driver should
manage its clocks independently and not rely on a previous bootloader
configuration.

[1] https://github.com/nxp-auto-linux/arm-trusted-firmware
[2] https://github.com/nxp-auto-linux/u-boot

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../bindings/serial/fsl,s32-linflexuart.yaml     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index 4171f524a928..ca3146d9b872 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -34,10 +34,24 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    items:
+      - description:
+          ipg clock drives the access to the LINFlexD
+          iomapped registers
+      - description: lin is the frequency of the baud clock
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: lin
+
 required:
   - compatible
   - reg
   - interrupts
+  - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
@@ -47,4 +61,6 @@ examples:
         compatible = "fsl,s32v234-linflexuart";
         reg = <0x40053000 0x1000>;
         interrupts = <0 59 4>;
+        clocks = <&clks 132>, <&clks 131>;
+        clock-names = "ipg", "lin";
     };
-- 
2.45.2

