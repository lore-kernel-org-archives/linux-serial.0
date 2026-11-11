Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400109;
	b=lK5zfrglm7mAq73B8sJaYhATj7RIroWdh3LI9GnERbFwSiJRoYA3xcLfaRLOC3BrHxv6
	 xY3XDzlLRirbxGeAdMhuU5/WkPDTCgEY1RNsKImE+kvEv7RAjnN6eTo19mIHOosKXgQBV
	 ebaiHR98vdBeUKerBxytr7bTnfTZX8v+nNVBaPbozhcN1zzjlIRXg3VglNYxX4py8FX7j
	 t7jGY+w27KcLxeB1WhVjbMGp+3O5oPPGstmMuptoFyDdRCi+GObQWWogpn0jval3JEuA2
	 ij0wUvRKHb5MwuiKcot8mYUy8HMqfc9QZE1vqoTTSSlKpYuHRjIg8DCQVfpWDSRrO2w==
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
	bh=Sl6AjKrBTMhG2T7gCdexRDeP0LTxqQeawwQj7kS3Q+U=;
	b=k/hINSnbX8/VzLQYshwyK+OKfH5GJnqbqooStoh2rb7o+Z4wHWGLxGtdIaYA0eCcMNh7
	 CvLvFy/mtec4At9amRE7QdhfYhMG0NYIOesQEZpZJcwevdQhiuRXyEI1Rkd6vXGrYioPC
	 T5R2zwHj8XHoefKoaKpEWGS8hmjkvL0ZDboLlVEOx/+AeMnYdW+3VjKwKHoKWUFiOtmgP
	 87LLSS1sWgtO2Xovxc9Fr7SNfpK4sPyF6yZwJuQW8KUpXj8W5CHcgCYQtvUtYFseW2E0r
	 wsihmarDKepVs2AYaISm/CHoxXDkxUV/JKeLHJg1/uTCdzD8kWZf2F9/sembs3IrZBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b="i/9gwi2L";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.106
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023106.outbound.protection.outlook.com [52.101.83.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01866606A32D;
	Wed, 11 Nov 2026 12:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01866606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=i/9gwi2L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cV7RFhpj8zukgRSvn3HIeNyJC1AS+V69dLBBsaJzsB8MAGNNC/ms+s3F6xu2kTyZ9rTJHdCmveqiwdnWh4GvwKBYKYC1JrcapK0kWMvy4scf6VVvGcKqugUt/ir4NAgAbVKx/ltwQ1X7/32jwVtcGfASVcKHbyIGdp+Pz0BENT93SieG2vEdMjGHYQe0rfMfyBcRAfJPUGg5LyI+HTd5I76lv7c/FOe4PsCKTX+Ivk+QGO/q5d6nP2W0/r+gwgp0gDHxS1eBeUULJzRXwxoqucIAbHqV+mAODXVWcGMwAYLoz9n7b5EC7ZVOrtiQcAleWf+3nob/E70W6fPoFwpc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl6AjKrBTMhG2T7gCdexRDeP0LTxqQeawwQj7kS3Q+U=;
 b=UFBdhuDJk+2VsvtOkr3pUdjBbcCF+Ba/S51+JOM3fuib1/pGmoqCNeZsgA3ffW0wjsvz+2HzElmdIT4JCHNf4czU/ftTGFqkkvhDI5dM5Svu5cWrsBSoI8LGiahA2i9wVaLgPCSzwK7sUqYLYBiOFoY42saKxvU6lj1BSz4gr/60ysCjeCbWR90xMygfsFfOuGKClvt6GfgM2AT5M88i54/6cbsYrYgDWuYmOItbW7TVG+OBwAgxlr4lZ64w3ZXSonRdI+/jFKUUtfwNQUy7QMJvBizRKiZlh0gMqpw8kODCFrImr7aEL+YqaohoI7RVKye/2KkGX1pYc+6W7gz5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sl6AjKrBTMhG2T7gCdexRDeP0LTxqQeawwQj7kS3Q+U=;
 b=i/9gwi2Les6kjpD0eqEx0tNUN+laj2y63hxfIy8uPhk9uYVxS6WnLmBThR9NDWkAmSz7hyPUWylFM7U24QxZdPzq+EhgkHty5jag0ZlQsD2mCcjk1YH8INu6hrI8CcZCwANkTM5JfG1bEdgif0H0yCjpCXa0IhcuqTrAk5RGxA1cm/5KOQRiXBwetda+78uK+8kgHkWnhoODV7B88DTAF1WA03LTnIbf1b0WAXaxwYtOmrniJHp5swGIqktTkEafoNBtv7/6NOMpJYhqRFDyKyDibI4UR93Sa9UeXO4NNGQ2VJRNEoxIiXOLwc54lALpUo3kGqsII2QxO/YWYCcUVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by MMZPR06MB127973.eurprd06.prod.outlook.com (2603:10a6:190:3d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:28:22 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:28:22 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 11 Nov 2026 12:28:05 +0000
Subject: [PATCH 6/7] dt-bindings: serial: max310x: Add
 maxim,tristate-when-closed
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-serial-transceiver-supply-v1-6-40bad0f912f2@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794400093; l=2278;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=TDuMxv9yVTWKtiotu2LlzRliIIpymVEOqm8+jrr9VaQ=;
 b=P4SY6yX9XbWmLxpUi89B+Qx+HlaL0NeehSXgE5X2ci3utCtcJN4RSZiGPCBYAY8/8vfvv9v4V
 Ajp9FxQznK0AqPWhG+FBOLOKYaHXuhpbU+98EJmdcKEaE73GZ5ieVYu
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|MMZPR06MB127973:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dd6cd5-aafe-44ee-4173-08df3fef459e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|23010399003|1800799024|366016|38350700014|10067099003|5023799004|11063799006|56012099006|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	EYLJ/lZhA77vGQzBHNs/qWDPnXpBMhVKNnWiCP4TlZiik5DZQuIs+xsAolilX+jOcKFa8ocK1hqdJvoL+KFTROSuClXUDX7VpcaHbuc7DvuAT80tjuSqaTgdSrt7KI8RAIEVuAUoMirw2T9OWO25SCrE3QQkWfbUyzhTT2YAhiELJVdgO+YqZDNal3PU5ExGTg0qdhFeTWezXg9y5XYRzjym/iddX+zxMZYDpmL7JLkktEhEy8iPz9hN0JrQ1nbSveiRZznQfxM9I7zy0H5E9E0NhejcPHfx/FCNuLD5cvhMcifmOjqPa72L9NqEG/PWUtsWB//vnedKbubYrnZIgqaZUvj/1q0Le2tdxWF5HBwe6/aMc0yIxSFePxuQzC3krmUzY4oDx9cE0Utxpw5jNT/odaybxkV/9r7JjvQwVSaCwLFNpcAx3dFWEAC4JGukUjRaY1do4ObFaUswx0oO6Y/ZC05V6XDHbnIO1WX2+4pb1VAvg4L7ojiYYQitCl0+O0FzfRuLGyrCS/fjTJGvJf6UAxJ9JnVH3DE88FnybmtLDANQc/+m0Rewu7gW55dEm3JNg97gxlU+rdt8ORSkmBzaMQbZPHjVWpfyRKIWT1DSUuZwmKxnc8bGvGFOc8dOJ1IKbpPbyqlIRMYE04ZcDbVYAMPsaK0mSM9pLtXGbUrTY80vkNbA8ZQ7vozd0WCg9as/IMu+Fo0h/Vafe0mIIia5H7HEedDpCKZAaoIEgNo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(10067099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTRsNzJHNVBkakJZV0RwTm5LZG5sQVhNU1RZV1cvczFWNTZlYXRSSkM1MGdo?=
 =?utf-8?B?U0lYUGVrY2tnNkhQbEVyYzQ1RmVKMzh5V0hXeWhUTzdjeGFndzVSTjJ3UXF3?=
 =?utf-8?B?bGxaazN4NGgzd05PTGdtaFFhd3ZQVjM3NGlBUVIvc2U1ang2bnVxaGYyWFR6?=
 =?utf-8?B?OWhiK3pYWjdHYS9hZlVWNU9vMWFzZmY2MERHckFiMVhvSEpacysvcFFMaUdP?=
 =?utf-8?B?bitSNGc0VDFOMEFuS0lvcjJMbUp4cTd1WnlhS2ptQTh0VXFhZ20vUUZ2Nm1a?=
 =?utf-8?B?SXA3ZU56R1dQSFZYRFJPeUpHUGRZMXpyT2Z4NkpwOW10eGp6bDg1OWhNOTdS?=
 =?utf-8?B?YkVWVkNPK2ttcHo2Tm0rYjVmejhqZldxNDhJcDZsUUlhRUErd25OY2plZmZw?=
 =?utf-8?B?WU0yTG1EOFgyakR2TmF4MGs5UGswV3NIWUV3QWNoVFBGQUMyeXBLOW5wcWhz?=
 =?utf-8?B?RkFHZWdTQmE2OFczT2JGdUhTMGoxbkhwSkdnNkhyZjRQY0JwZkhUak85RDUz?=
 =?utf-8?B?KzJmWnlBelJYQ1VyYXFOWXNwMUkrbUVzMG4xSDZ3UENLSVpOYTFzaUJnWERZ?=
 =?utf-8?B?R1IyQjdrUkpNajM3cEFncldmT09QZzAvYlVkaktuYW13V2ZnT2ZxRzUvM2x6?=
 =?utf-8?B?SGs2b01vbzQvazlscUZlS1pqN2lPUURYUzl3R0c1MkZKWVB5WFBUcWtaMVk3?=
 =?utf-8?B?K29WZU1pVWNqMWhwMzR3UnhyOEVabW0zcUwzdE5hK0FLK3FlT0RGK3NGN0NG?=
 =?utf-8?B?ZS9NdGtYditKL3MvS2JDelVHU0ZVTkRJcm5MaGdjL0VuMCs2OThSSSswRC9J?=
 =?utf-8?B?RFhHU25EWTc2N0lpelR2UGN4bGw1eVh4elgveWhvM3AvWGJGa2YwcW9QeDI3?=
 =?utf-8?B?MmFrL1dKOS9DYml6dUhhUVFQYnNPdmNYQnBhM2hJSWo1ZHNyQnlpbktwNjUx?=
 =?utf-8?B?ZEhZR1BYaDh4dmRSM0J6bHl1S2l6TjFMckFnVUxRbkEzb2hsSm14dXBubTI0?=
 =?utf-8?B?cnBOMEtLd01WaVNHVXFmYU9hUkhNbnBIYStsbGtHcTFYYWRUeC94eW8yV2Mr?=
 =?utf-8?B?NjB6MFRqdzNwZ3hkOEh3eTY5eHNYU28zQkFIRXlPSGYvaENteTE4S2JTRlNJ?=
 =?utf-8?B?N3c2TlIvT3UwaFRQSzBjVTcrY3J3aXFzSTYyT1E3akZLOXQ5N29tUHZidXBz?=
 =?utf-8?B?eGU3SU9hbEljOXRoWlFwVnFCb3QvWTFXcEc2dFNXQTVlaitNN3phWU1vSW9k?=
 =?utf-8?B?VllUME4rL08rTkVFL2tkd08wcEpzTGhVUVYxY2R0Nk41dXFwNjE4ZjZ3SDFi?=
 =?utf-8?B?ZFpyY2p5bjRkL0tEbXozRmRJSnFRU2d2MFBaVllqa2NJamVwS0Q3UUVhTkpH?=
 =?utf-8?B?TE1YOThoM2pUZjNEdEJGOEpxMUl2YmszaGR6Uktza3B0SnlFZ05KY21zbjkx?=
 =?utf-8?B?OHlQTDZ4ZHpIU3poNStHeTZjZkxDNnhQVnZMUEk3S0VpUE5RMjhxbDdyTFpK?=
 =?utf-8?B?L2R4VDBRdTRaZ3lqUlFDaVVOQXVMQU5kK2Z2MVNha2k0a0J1TVNUdHlIenMv?=
 =?utf-8?B?V0ZENm5IK2o2U0hZTE5JRE5Ga0plTGhBdWNLSmltS2hBQ1BMUEpjY0MwcUNa?=
 =?utf-8?B?WS95bm0reERqQUxOdVZhVjVYY1JjUDhrMkg4Q1FHdzJOY3h5ZnIzZFNFYTFi?=
 =?utf-8?B?MVNCVEIyL3lVREdiRTlxT0hRbmNrZGlkTHlLZ1FETktIRTRzcEh5eG9FS3pz?=
 =?utf-8?B?OHJoVXRQVXg2RlV1YUdENUx3SFRaT2t5bUhPVDJpQzZIV1FmcmdRWm1tMmNS?=
 =?utf-8?B?RTV2bXF6T29qSDY1bFhHSnB5TmlUMmtuMUpVL3hlMmJkandBMGxTR2d6TjU2?=
 =?utf-8?B?M2w3WnIxdG5OVE9vOFVLc29MczdVMTRiN1F4N3UzQzdxaHMwNlJsaExDR0NH?=
 =?utf-8?B?NzR1SzkyamlpMnBickRQdDc5cjZ2TzQ3Nk9adDg0em1UZDV5SVJNMTExN3pp?=
 =?utf-8?B?NytYS3JaQ2NHamlJa2dxOUY0cVdpYmpJTjFSbU5Eb1h2d3RaOEQ2Yk54eXpq?=
 =?utf-8?B?dk8ranBhQ2JmRGt6RWtHY1YvNW9Bdm5NUHBCOG5jcEFtR0h5MkFFNVU1QUtU?=
 =?utf-8?B?ZFlZZmM1OHJncmVtVVh6UXBYdGMzVEl0VncyNGdOYUtFSmxWalV3by9PNTI1?=
 =?utf-8?B?eEVub003YTFzTy9uOVpHKzBwOEtJd2Q1Z2NUZXM0RTZLZXFSZElsaFRqMCtN?=
 =?utf-8?B?T2Zpc0UxQmJDRkhDVTczTjlYaXgvMHNFNUxZQldiSnQzanNyU09rV3AvcmtF?=
 =?utf-8?B?WHlFT2FIdXhQNTZER2VOdUNpTDRoL1IzbjBHSUtSUEt6QzVtZHp5blpFZHFq?=
 =?utf-8?Q?DGP9R4JEIkRDZKz4=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dd6cd5-aafe-44ee-4173-08df3fef459e
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:28:20.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/17QxBRRH1SIZBE3aKFYQEILW0EgrHJZvZ+rqEoKrgcOm4yFQk8kysi4lG/Qpq1m7h1kgPW0sG6yvfH2+Pl2XayWJ/rWT55sHk7PXdtU+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR06MB127973

The MAX310x UARTs can three-state TX and RTS per channel. Add a
per-channel flag asking for that whenever the port is not open, for
boards where the outputs must stay undriven then: a driven output
would back-feed an unpowered part behind the pins, or fight another
device driving the line.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 .../devicetree/bindings/serial/maxim,max310x.yaml        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
index e598dda4d13f514820ed8012f2fb2fc2aba3e669..f54296f6b6c85e3a6246e210af9ea8ee6af5118b 100644
--- a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
+++ b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
@@ -54,6 +54,16 @@ required:
   - clocks
   - clock-names
 
+$defs:
+  maxim,tristate-when-closed:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Three-state the channel's TX and RTS outputs whenever the port is
+      not open, from probe until the first open and after each close.
+      For boards where a driven output would back-feed an unpowered part
+      behind the pins, or where another device drives the line while the
+      port is closed. The board defines the levels the outputs float to.
+
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -68,6 +78,9 @@ allOf:
       allOf:
         - $ref: /schemas/serial/serial.yaml#
         - $ref: /schemas/serial/rs485.yaml#
+      properties:
+        maxim,tristate-when-closed:
+          $ref: "#/$defs/maxim,tristate-when-closed"
 
   - if:
       properties:
@@ -93,6 +106,8 @@ allOf:
             reg:
               description: UART channel number on the chip.
               maximum: 3
+            maxim,tristate-when-closed:
+              $ref: "#/$defs/maxim,tristate-when-closed"
           required:
             - reg
           unevaluatedProperties: false
@@ -156,6 +171,7 @@ examples:
 
             serial@2 {
                 reg = <2>;
+                maxim,tristate-when-closed;
                 rs485-rts-active-low;
             };
         };

-- 
2.47.3

