Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400108;
	b=Su6UTzWUsUIfAlpGHz8oRgCMTA/IQD7ba7qELNv49sLEUH07HQpfSRgWfLZDl4/MbN6l
	 mpswpGRmCBcrGrLoEIlnRmfYgVkJVqvQq7/Wo6noBp5JkYcwf0a49ABDEaPCwGkAXXyLD
	 d0d02vzcbzxM5gVYM3KQfxAqUxh096t2Y/pTiwdYqWBwkEuDvhcY9p9Y9+eRXXk8FmRT8
	 zd+z+80v3Rv1ttxFJXjmHHu4A4Ay9KWXTnlRSxuWjVzYVpEv3c775fnNgtveJBp508aAY
	 rA5399SaDs6d3PG+0cBqK5RqCBhOCg9SIgVd9ig4FhQNsD+cjZvSGhL621ApWTNtvYg==
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
	bh=/zwps/mys52e6wYNee0cVp4aB9RNhygbG+8Mg23RLEw=;
	b=Uc+fgC850gFbKu2JOwbnDXzqEx9zjuceDEk8uWkYLXTSGYJbhWc6qdX7fcDOnG2+fDG6
	 xwBUORn76AxjJMdwSLT5JQp2ABmacBJ6sZ8TEqbz5yBb6IXurUgRyMASd8vk49VjXbiY+
	 nJRMnOYxIS1tonIGfXrz5dv0GaYq3b5oshhyYAwkzPRjdZTUfFp2BIUD+U/ZkoJPIpY9b
	 F8xLvucNi/h+xB12PCg4sTWlGNyRWGKg1dUvzYWs5D5Tb5YUSTEhEZVFS8arWRnORODs6
	 e9oKYV8/09Pu2PR9jQIlfEk/WkzM0D4ZYBZ4MIthAHb77awhUVvbc6W0XPDU6TmLXow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=izGvpoxH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.133
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023133.outbound.protection.outlook.com [52.101.72.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A8606A32A;
	Wed, 11 Nov 2026 12:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D8A8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=izGvpoxH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgH1wNvWGm+KHVTAPa7fF5er+gpVKXnsDq0OpnO1N0FAwm20iBwNb+ozBzVRm7xf81qnmtY42KuM7br8BrdMIJp8H94fo7rhkmYJ13bQYBhggQpfBF/12MwXnJvjfPRoVWLYf33yCZNQLLNWzP3SJVDPXVi1yDWiQ4GU2cmEaF9Bsj6HUrUDDpb57A+0d48xyrE/ANfpyZwMxoJTgVI73KYMIe0EC713XgjDsXu9EaVf2m2sKQ2U4cla3QvEVVN4H0Zisl7yR/ojKaCF1vJ1LqACKubky6FPQIj2L7DPML2fTsb3fGCBSPOsLfzHEUxxSSBGS+2/Lt6OEtsNHM3NwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zwps/mys52e6wYNee0cVp4aB9RNhygbG+8Mg23RLEw=;
 b=sWGI6EcRNgOJjpdF5qzAs0ukHK3uu1sEEMivy6/yxX8CDm2kqpiN5/VyKheh4T7Q4kuYiN8nYJXhULItuXzpzrW0qYMemKo1mdd/TsWHmWHcRiT2cfZd8yG5hdE0v50Ovj8GyRIl30Q3FwRKLDhtgBKxDunqGiGXhh2K/ikH1T4bfqVUN/fX9BFsW5iCzLu+uzLDWuj+uA5LxtueaVP2rbxdvMmY3dgMKzH1Aaw3WaNuOhjg5Q/zGLiwMertDS0RCTGx57JI08Jt6xdYoLss12ZUULTugKh4jiKoUAk94TCTRevDWkCvWMRh8fbvArdmD9yf0yaWDEtK1J9Mmkfw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zwps/mys52e6wYNee0cVp4aB9RNhygbG+8Mg23RLEw=;
 b=izGvpoxHKvkP7XCUv1Eihhu0Y22mpN4+AU2RO2b8GOLHSOGOwwJGRyRGXVeRb/+GjJU9k/BzNyLpcBJscN4zGD3ijnKRvLJS39NkYn94vN8rYxvDvGVzwwOyhcYDNU5yIBqxxgv/zEep4tHd3SXtXHWT719RIOYpVP1NKlThegfifqV/oQFhbnXLk76VD+pDbhuPE85aD5abZMeeFtc8uSsSub/sABhggts1OrYxfRgHI+gshzehget8GK0E93itv4IYqLn5/uL0CWSo4z30z8vmmlnGzit/aCiuODmG9HtbLDcghH8QANaWCbzlPN3dnErQOwRMRnv7g9Xm/Pjekw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by MI3PR06MB10548.eurprd06.prod.outlook.com (2603:10a6:290:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:28:19 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:28:19 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 11 Nov 2026 12:28:01 +0000
Subject: [PATCH 2/7] dt-bindings: serial: Add the line transceiver enable
 GPIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-serial-transceiver-supply-v1-2-40bad0f912f2@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794400093; l=2228;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=8+O5EPRwi3KDl8zLGCiLTTm2r312fL3qMz2zcpq3eoc=;
 b=xwvJZC7NHBsAPL4M7hNSTI3fOF5xUDsZEWpHH5j140UkDIQI7tdbtBqyQGI286lRGIw+CV3YH
 kFdUjaDXWFjAP1+HAKwRm5TV0yLLxvX49Sal77EZf9ToHR9xXpI8d15
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|MI3PR06MB10548:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c66f901-af56-464c-263b-08df3fef42dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|38350700014|10067099003|11063799006|261026140227099003|261009223027099003|56012099006|261021121427099003|261021123027099003|261022075727099003|261102123227099003|261022105027099003|261028144727099003|261026121527099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0w20Hlj+83I9pCKAVSWxdjuQ97F7H58PxqIKtgDm3HPb/UHV87CaavnsVqxu/lowKeybBtmfnVCPkB1Irun+s8dDRlbEOMr5nBKSobfQVzQ9dYxMt+SMmZfTETW9IJ7LOfY2/OV3/Q3ixvgvtqkFqS2CEH1+yp5GWrxOY5k0XG92NAMX6PEaM7nkqKQt67Ozmepd5XPqxVvakb6pPY3hU4XgNhyeBNDV85AIQw+jxD7XSegaFKPH0P4/HhqRL8HYN9cocRLkh+/gPieJ1vYTbZozuzOWSXTwgyotU9gjM/QtGkxQghmLdje+xMpz0NGcPiblB6ZpqZEu/7fotHOFrP/GXPuwZmflQcte6BtgbyUmXKB3F7es+OZYzV8ZZzhmzUxmDIcpmlymVYjhoeuEVKpL35vBes6azi5misHP1Ovztqfc3FqyZ26wrw6ApTGZ+QAUbOezvr+FVpVzAfk2nJ3bIqcS6QcJ7sl5oeb2n1Cnmn2UlmI24Zh+kxAZmbAA48CWmGNwoQVK4OHvpzsRz0/moYPQFTrwrO0N41Fqqh2M2zGmwv4xiKt0vVyh+NSTbHzKkiRQB3e+s5o5EaJWacKZh2XeUkDScBivpoYLV5RJFLr2an0AGM0HHQqjgERKye2jA8SVo8UPDmPUDd/9qI5o6PmCmwUbmp/OmPFLa2cuinDWJRepgd13PZsxBj8cj5dqr3esGZsjyxMqArwycxpWvqnyCTMkNORWL/A8p5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(38350700014)(10067099003)(11063799006)(261026140227099003)(261009223027099003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026121527099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0JiZTBLVG11SFAxNThPcTRZZFZEb29WMU4zV1VYQW5OL3J3R204YnZXZTkv?=
 =?utf-8?B?dXdob0lMaHYzcmxZeHlPNmFubXR1NjhMOUYzdHlVODBUVEJIQnpSVDRRUGoy?=
 =?utf-8?B?Q1g3d0hVdDA5M0VwLzY1L1h4QlArWStYWm5UTjBjSEdiczRmcDdBaXZmeVJD?=
 =?utf-8?B?alFuSUU2alQ2dWtsWXhPZTJIOVNTczFLUFEzUVcvY25WaG1jQmw5Rlk5OHBj?=
 =?utf-8?B?MkpMVUIxNkFDVGgyL0dIMTFsdkJ5Y1czNldONzgwZmNUU1U2QVVJb0hwbXBz?=
 =?utf-8?B?Nkl3aXJhUGYwbUJXWmVtaHJyYW95TkVwbHJKaVZKdFUrMGNBNktHaURNd1BC?=
 =?utf-8?B?Y1VFUWFvU0ovUHA1c1ZaNnNXVk14OWZqTE1PY0lxdTZ1a0h2ZDlKWVAxdjVZ?=
 =?utf-8?B?RWE5Ri94aTNqcFl6TWhWUUx0QWV2VDhxSjlleldKZU9JUG9UT1piYWpQZTdZ?=
 =?utf-8?B?Y29RellIbFZaek9OYVE1eC9WUWJ5QnZ4NkNteHByVEQ4eDI3Yjg3ZjVlZFN5?=
 =?utf-8?B?UVRFTDJ1U3dWVE5QaGtaRWhldDVTWFR0UWR1aVlkYXJmRlFJZGpvZjVQZW90?=
 =?utf-8?B?MUx3emlYeFpQZ2VBTjg1RFpOMFZaeTExZTUzdVp2dkZiNmhKSEVEbDJpSEF0?=
 =?utf-8?B?R0lSaVV0MjN2ZW84TUFlRzh3ZTdXZXBwTU16QkVNT1BXNllQcnJ3U0l2c3dy?=
 =?utf-8?B?WEUvT2xvUFJUbkp6dkRUWk1mcEdJWVRRQlJZVkxMeXR0aXB5YlByb3ZkTU5t?=
 =?utf-8?B?aHMyMnQ0c2FQMm5tZFdQbnAyanA3eUtzbE9lMDg1NXUwZ3JtWGhFbW5xNmJU?=
 =?utf-8?B?azVsZWw0UjhFSS80MGxvMlhDQ241R3llVHQxK3pxQkZRU0VNL3d6N25iQ3o3?=
 =?utf-8?B?eGxsYThLWFBUQU15S1FIRTFTYkMwSDVwM1RTNFZ0dnhPMFl1VFJSQmhGbE9L?=
 =?utf-8?B?MjIxNURQRWdFcFBBZHFna3Z5ZjRkRXRzaC9pK0xyUW5UTEVmcFVyeXBxQ20w?=
 =?utf-8?B?MXFJUWo3UklQcVdsbWtpelhNbFhEL2pGT1ExMVJuMXc3clhlbE5vWjhGa1dN?=
 =?utf-8?B?a0Q1Q3hQYWhVN2ZpZE5QdVpkblc3V2x5SHBSWVphdVBRRy9PN2V0Tlhmckxr?=
 =?utf-8?B?dk82YmI5dTZjY3JRYU5oeTJRVlpHcm96NzZPTkQ4OHExL2hUQW8rbTZiK1Uv?=
 =?utf-8?B?aHFCM2oyR2tQNGVtVWNjSlMwOU1RRUZqSmlGcis3bm1reXM0ZnpVbmZEQ2VX?=
 =?utf-8?B?MnpwanZiVFVJdm9FVkNROGJKSFlsMjRhaEVxNDFWR1JOL0JEZkpWK3U4ZXpX?=
 =?utf-8?B?ZXFXeFZQOGQ1L2pFMVk1STdCMG5NQUhOOEZVWUFPVlBjcnFFeXJiNFRHNXZW?=
 =?utf-8?B?ZGJNaFNGa2lyUTVaOG03QS9OdzhiSlhlY2hqcDgwTDhUd1FZczdDTWlaYWRO?=
 =?utf-8?B?ekkxd1VGUnhKSkJ4eXhhWkIrRXdGRERMTHcwTk5HeW1kWjdNS0ZySkFRODl2?=
 =?utf-8?B?bWtNTEh0S1E2dHNhNW1sL0VQMjJFOEtwYlVXSXZLa3ZuT0JNVzFWTUJENWtR?=
 =?utf-8?B?Y1RsU1dpRyt4QkJMYkJJK0dLV0RoSElSbVp0VnJBNC9rZkl0YkxuZlUzeEpV?=
 =?utf-8?B?WmttYWJLUEpZTG4rRS82M3RzYkxlNThSMzVrcDZSajdFQko2a0VmS05jd0s1?=
 =?utf-8?B?NXlud0prSis0VzZySWJkdU1lc2hEV0E0QlpuTXgxYndxaGErNStNbGVWT1hp?=
 =?utf-8?B?MWVVSVFHMDREbnErcEIwZXg2WkNwOUZadDRqYnNNeGJadTRNUVcvdXRkRkdi?=
 =?utf-8?B?U1MzRWJlM0k1dHJsb2o0SzdGZEgraEQzUG5YQ2FJZE4rMWpGWFBjdWFLYzBn?=
 =?utf-8?B?VE1qeUpzVTE4SlYwYWtkVDBrb2p2OSt5NGhZQXN1ejlzRDJ1c3lRK0lKaUpw?=
 =?utf-8?B?K2ROTThCelFJbXhZdnh2bU5RNnZ4M1NNUU12ZWFxRHZUOWxrS0NyTW9QZnhU?=
 =?utf-8?B?RUNyVjRYcU84QlM3N2o4d09UQUxQaG8zcGRYTmt4VkErZElJbG4rakhuV2ZP?=
 =?utf-8?B?OEJnL3Q5TDF4OXpXWjl3YkZwbno3ZUNJb1Z0Z2dTT1EySm0yZzV4eWJndktx?=
 =?utf-8?B?d2RJYm0xUXdEN2dXVktRNlFDRTQraDJDeFNkNnBJY3FFaGFnS2paUkpFank2?=
 =?utf-8?B?b1NUaDM0ckJWLzk5RUdwZDNvcWFoOGlHSFNmbmZoWVRyNlRqYnRXNGtuV1RY?=
 =?utf-8?B?MG9nQ3h2ZldCbklPWXZFL3NMdkIvOWpMbDQwcGJlYXBObC9VU2ZQVk1BZURl?=
 =?utf-8?B?SFBNOWVxWmkyT2c2TG1PTTBCYU1Sd3ZMZ1JJNzFaWnRPbHp2OEpBMjBMcjJy?=
 =?utf-8?Q?vi7lLwFtXwWLgFZk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c66f901-af56-464c-263b-08df3fef42dc
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:28:16.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z7X8O3TAfeiUoOzes9Ev8Wn/NgZfl/hj+hyKfjA7rh3mRfLynIEhI/eKgQKqCoWJRJe4y3+TbTgEVn1DlLvE+VscS0U4Z8f9vFIJQrCzQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR06MB10548

A UART's line transceiver (RS-232, RS-485, an isolated or a
multiprotocol part) is a dumb device with no node of its own, yet on
many boards it is the largest consumer behind the port and can be
switched off, through a shutdown input of the part or a switch in its
supply. Device trees have no way to say so, and the transceiver stays
powered for as long as the system is up, whether or not the port is
open.

Add transceiver-enable-gpios, the GPIO that turns the transceiver on,
as a property of the UART node alongside the transceiver pins that
rs485.yaml already describes, and transceiver-startup-delay-us for the
time the part needs to become operational: a transceiver that
generates its own supplies behind a shutdown input can take a
millisecond until they are up. The GPIO belongs to one port; on a
multi-port controller it is a property of the port's child node. A
serial device with a driver of its own, such as a Bluetooth module,
remains a child node of the UART.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 96eb1de8771e9b4fc659aab3dadc3ac9f8599d39..baf7733c720b42a79643e65696041ff0765b682f 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -87,9 +87,23 @@ properties:
     description:
       TX FIFO threshold configuration (in bytes).
 
+  transceiver-enable-gpios:
+    maxItems: 1
+    description:
+      GPIO that turns on the line transceiver, through its enable or
+      shutdown input or a switch in its supply.
+
+  transceiver-startup-delay-us:
+    description:
+      Time from the enable GPIO becoming active until the transceiver is
+      operational.
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
 
+dependencies:
+  transceiver-startup-delay-us: [ transceiver-enable-gpios ]
+
 patternProperties:
   "^(bluetooth|bluetooth-gnss|embedded-controller|gnss|gps|mcu|onewire)$":
     if:

-- 
2.47.3

