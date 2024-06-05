Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2134.outbound.protection.outlook.com [40.107.103.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BF17C96;
	Wed,  5 Jun 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.134
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583433; cv=fail; b=OOC8nDSx/A15EzFyzl9g1+Q8usAbs/vKP9Ea3Mtl+Y4RW7cKVDE8a2HkPRtqdkcPij68DQUhtbJMHVXko4dMTzTvor7dOqYaP7zow3OpyYU9trzKGYvIMK9KKIidnj83+/vANKlEGmWOBB5TZg8BQvdyElkEh1LoIt+eq4qA+mA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583433; c=relaxed/simple;
	bh=ufTdhIethcfMRmMNS9+9I3Bl28OZrY+S9WWbUhy7et0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tNgqBPrLZuxuRSz6gyAmYBfNkJZZRNVrm+dAScZn//rRS87KEtDk64JoygNxv/m3hSrxjeUMNSDuNCqKgqqnxtsZd0Yvv2lpBJJk+J8DBgB+ltz5m14TqnfBznKZ3fwVOO4vMS1fe6E3jHyzcili9NCC0pg3Av/PVlWniqPzyk8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=M4eUijGS; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=M4eUijGS; arc=fail smtp.client-ip=40.107.103.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="M4eUijGS";
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="M4eUijGS"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=cRJ/w7QCu3Y8olYF0foRGTEFzIHwD0Sd2kkbEhiaB56E4JDgsf3NEeAm6PHSShvUDg6EUcyESjxhC6QIRR3UWd9Z//tnIFuJUi+lT2lGzwaEdbJiVeNbz+EZmg6+MZ8fTI6aYldW+dEI/6qw5baOvN9vY+X5iWNabIJ8z/M+KQwwATv4tq6X9QEjud8ogj4r617HHn2HgUQaObY7T/xG7rrkh9DkWLBo3LEKDPoi0/elLVBBNzBconHxkdvGHolwFGHodmxpl2JIBwwgwAcH/UdBs+SKBIMdlEpyDniLjCQo7O99gDyuvscKLeevv12uKCmazysBlAHIvJY+8Hc6Nw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufTdhIethcfMRmMNS9+9I3Bl28OZrY+S9WWbUhy7et0=;
 b=YXOEJZG/I0CjXJyMWFPBvLp9PKb7CnRjk/j4dOQjZsrfSQGuAhC5XCjZTODsCgTZO+81SX6iFNt0N9cG6HITZWy9k1Dn7tyOXTko4MDFIwDYdRoi6+gS6XLtoraRB6oZuljDlmT2GakmtXRFu9TGecjWKiOmGl6JIgoDGjfK479/vCBzsiy3tOFLOn4e8F3CxOx/Qx4N0ye95Fn1aywBLFOLcpJjJGumx/e00dPoF/hn89tzagNmRWNHKtBI4aDNoe4v0wylmKGXSBT7aFRIiZPbSlqVeXJWSDw6g7bM7L9fBC+vxRxmf5aIysF4BcZH0tKiPKgzq41iCVb4s4Hb6g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=hugovil.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=pass
 (signature was verified) header.d=sttls.nl; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=sttls.nl] dkim=[1,1,header.d=sttls.nl]
 dmarc=[1,1,header.from=sttls.nl])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufTdhIethcfMRmMNS9+9I3Bl28OZrY+S9WWbUhy7et0=;
 b=M4eUijGSiSxV5AqIgdYaRLNekqC97qGse0pwfdj5HRvFjJmfuPftAXqDVUOhTdvhNsnnqK7HS2LYQXn27ili5grMfGBJqHHAABRU0M/0YEJBIe+Sj4DsJsm53h38A+BjLsF4N0vcGVHuurkDebOkucnlQapUKYARTBaUsAEoPOQ+C2Ql+gkpJ8Mx80L/4w/W7AWP7bejm9F10NWsXp7I2BkVlRT1JNjg0u0wXG7gLjsy6rdLRqM/5BavjIqlgz4tndAjgvaWUCZHnoSDnfBtXNUPKd1vUH0VhAwXggB9H1H0J0JuJgFp9Lm3uu4KOyrwSUSRuSpiZPyVosFM7eP/gw==
Received: from DB3PR08CA0036.eurprd08.prod.outlook.com (2603:10a6:8::49) by
 AS1PR05MB9084.eurprd05.prod.outlook.com (2603:10a6:20b:4d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 10:30:26 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::84) by DB3PR08CA0036.outlook.office365.com
 (2603:10a6:8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 10:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=pass (signature was verified)
 header.d=sttls.nl;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:30:25 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (104.47.0.51) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 05 Jun 2024 10:30:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF6BKu+5Dh5L6Rk8mWsIwyf+dpjhJJtMqjHqbo7EO2y9lS4zC3LaHePoitlhbjYI7gyulO4Cwi1YAAxIIa3LJXLGwpOaw8EwOLLoUB2I9KkNvG5m6XS04zlGpiYD7mF9GczQZG2rXBMHc3C5T153s783/sQDRrPiVDmLcnPE2tAvIUFzYhp65y7+yhsGU3P/CaBfTnG1Qx9p1d3TRIOADogREYGUX8qOdXVlIAoh0jRe6FUmlSyIWlMNTWYsajDzvuq7yPNjiaq6np+d3evhc1SaD3uqTjwB9lB4CHUIUtZhXu+l7JT2XNNakpgiXuJWYAORI0dh2ESBoJsW5AU1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufTdhIethcfMRmMNS9+9I3Bl28OZrY+S9WWbUhy7et0=;
 b=jvty8+4ul0Ksk6mKk0Dygrcl9ddy3yZgXldNPjzttjCUJdYPZVKo9ONzmee2aGkJ9yLpFP8n5/8uDYDSnWXORB+VhondJOm5X4XfgBL2ZPIa9W1jGMbckGVS9BrnYljMfTYzw/TkUmKF86L436gquh4HwfVeybT/DN8ZYzlQCJfmJq6KTQDlB3LNEYqhsjcITIRe3fBgB48nrHH5AK5TtruVkP53Y2ijtoYguvnsFWJIZn5COrpyeZM5Ahf9MvLXg7TwraMUqb0T/yN4aBizkmg6aB2zcylQif+Y1xl6UQbygl+u5PG1VT/sro3YJsNNhu2GWQtLC/6iPsqdmFkRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sttls.nl; dmarc=pass action=none header.from=sttls.nl;
 dkim=pass header.d=sttls.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufTdhIethcfMRmMNS9+9I3Bl28OZrY+S9WWbUhy7et0=;
 b=M4eUijGSiSxV5AqIgdYaRLNekqC97qGse0pwfdj5HRvFjJmfuPftAXqDVUOhTdvhNsnnqK7HS2LYQXn27ili5grMfGBJqHHAABRU0M/0YEJBIe+Sj4DsJsm53h38A+BjLsF4N0vcGVHuurkDebOkucnlQapUKYARTBaUsAEoPOQ+C2Ql+gkpJ8Mx80L/4w/W7AWP7bejm9F10NWsXp7I2BkVlRT1JNjg0u0wXG7gLjsy6rdLRqM/5BavjIqlgz4tndAjgvaWUCZHnoSDnfBtXNUPKd1vUH0VhAwXggB9H1H0J0JuJgFp9Lm3uu4KOyrwSUSRuSpiZPyVosFM7eP/gw==
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com (2603:10a6:20b:5c2::16)
 by DB9PR05MB8685.eurprd05.prod.outlook.com (2603:10a6:10:2c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 5 Jun
 2024 10:30:21 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734]) by AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734%2]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 10:30:21 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Hugo Villeneuve <hugo@hugovil.com>, Hui Wang <hui.wang@canonical.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andy@kernel.org" <andy@kernel.org>,
	"lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
Subject: RE: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
Thread-Topic: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
Thread-Index: AQHatoMSmrKlXbpByE24p7W3ELDzzLG3qHyAgAFOd4A=
Date: Wed, 5 Jun 2024 10:30:20 +0000
Message-ID: <AS8PR05MB9810940582493046F2FBFDB983F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
References: <20240604132726.1272475-1-hui.wang@canonical.com>
	<20240604132726.1272475-2-hui.wang@canonical.com>
 <20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
In-Reply-To: <20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AS8PR05MB9810:EE_|DB9PR05MB8685:EE_|DU2PEPF00028D09:EE_|AS1PR05MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0f7539-56f7-4569-c5cf-08dc854a8359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?OGNTYUx4cmlBVHpXQi9LMndZdnBNeWZYVjk0SGRNcUpyKzhHWWN0U1dXQzdH?=
 =?utf-8?B?Y1l3TWdUdnhBZFBKckhyUlBqazdVMllvdSs5amQ4aTRpNms5cDA5SnhJWFpY?=
 =?utf-8?B?SXVNZGowYnJJMFVmSkExY2xJeWJPSzcrTklHMTJ5NnlEaXRvalpRRmYwYmVB?=
 =?utf-8?B?OVcwNW9wQks5YnVBT2ZEWjJDaDZJcG54SEluTW1UN28zVGtiRGdFMUQ3dDAv?=
 =?utf-8?B?MXhxbXRaZXZlSno4b1FZNTJYZk1UUWJJZkRvSjRyRUdMMkdwN280bjdyMUxx?=
 =?utf-8?B?WEMrOXdLWVpNdi9nMXBsZlYyU0QvNkNJQVhzUEp3Wm5IcE5oT3BNOTFnMlNN?=
 =?utf-8?B?WHlZV1kxb0t4bVNhaVRtNW1mdU5vK05XTVViZ2tzc0hxSm5TTmh3V3Z0dkQ0?=
 =?utf-8?B?V0g2cVRTcUk0N0JvVTVkZnQ3V1R4Vi8vV2NIbGZhZDBPYVJzeGoyeWxxdUtw?=
 =?utf-8?B?WDZJTHFUNndYZGxKckpoV3NMRThwY0NtbDNOeGFhMmVHTFRKY3Bac3ZmQVpn?=
 =?utf-8?B?RzQrUTlrS1VmeTkwZGlPUjNZS2VSYUVaWVZlS081OG44MDhxTDNWcVlTd3Jo?=
 =?utf-8?B?N0VKTEZaTVZJemh3d3NLWDR6alNDWUNYVU54ZHovYmNrOUFYQ3d1YnpRemdt?=
 =?utf-8?B?VlhZbXpRVlJ3VWE1eXJ3dHNjR3BwVTIyL2Z3VzJZbnBPb21Vc1NCc2dUMGU5?=
 =?utf-8?B?cDdFOU5mSVpRekdtMUtoQXA3eG1jdWVYS1BrSDVDaUh5RnhRSmM1S2YvRzZk?=
 =?utf-8?B?UFQrbktGVVM4UkRkeGhFMXdERXdWWW9hKzVvOGhXL1pPUVo3SnQrRWI5Ym9z?=
 =?utf-8?B?amVWZHpZdEJucW9QZElxbm5oeDJabUpxdUUvc3IyVXEyWXFuY2JsVVRxZXJ2?=
 =?utf-8?B?eS9oaGNsT3k4YUxxK1VSY0J3TmZ3a01PQXlNanptS3owZnhSbVpWMU9naFR1?=
 =?utf-8?B?ekdPdERjOEh0YXBDR0RWUGpzL0p2QWI3cVdDUjNUN2xqZnpTL1Mvc2M1R2tw?=
 =?utf-8?B?YzZPMVN0OUEzRWFGMy84b1FJRndHWW91eXZBVFBpM1M2M25aTHB5MUVIa0cr?=
 =?utf-8?B?Z1VQeE9KUHBCbjlXUFVkSmFWR3VodlBrQVhjOUhRZG81YUNoNWRHL0N3UEo3?=
 =?utf-8?B?bDhjTUtFNmZqcEl2R2k1MURGT2E3ZGxLZ3ZKYlp2cDNFZklZTjhQNnl3N2xT?=
 =?utf-8?B?V1F5R1NuWnMrT1R2WVZjMEFtdTZUN21yZFpyeUgzL0VGU3lUSm1oOFp6YWR4?=
 =?utf-8?B?ekhOS2VHZUxkT0hZbUlVdXZTOGlHWUJzWFBidHpPYmd6YlBCWVl4Y3BSNU52?=
 =?utf-8?B?NHNGVzdFMC9QbWtTTERrVGtCNUMvYnpWNWdZTDB5aVE5K1lhUUE2d2FreXlZ?=
 =?utf-8?B?YjlNQWpNek9Jd2haRmxDNjNOMFVaY3ZWN3FyN01oa0VHeVRGSWRGVnJOU3NV?=
 =?utf-8?B?NDJqSWYyVzFaWWxUc3BDV0QzOEhhVEJzUWxBM0JlUHlrTDJKQ3AyZXdiaUtL?=
 =?utf-8?B?d2FrWkpVM29NL3VhS0tIZ1IrYnVzM2RuaEdUM1NYMEtKVjQzK1VRMlRuSHBT?=
 =?utf-8?B?bENiWGMxUFdVcDc3ZUNvMWdCVDAxdDdVQXpiY0pnWTN1M2tZODVVSHZsVlZy?=
 =?utf-8?B?MlJwUVo0UnArS2xXZWJHV1k1eHBaVGdIOE44dmJadjFpdTlXb25QNGN6MkVh?=
 =?utf-8?B?M0kzVENudEMxbjZkam1iZHFTeUxwamFlUnJNdVUrQlNsYjZ0Um9NUVBqbzd5?=
 =?utf-8?B?N1ZZcmduelo1OFlxVlE0NDhWRTd3VzhJemhIV0hmRVE3S3pPNmhHY3NwL3hx?=
 =?utf-8?Q?A7P/t4dkETJnm+L8jWRNqyvGXz7AEbIj+xDd0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB9810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8685
X-CodeTwo-MessageID: 09ced323-2d39-4eaa-b503-83047d4c16fb.20240605103024@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	12f2bbeb-4da9-4974-f349-08dc854a808b
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|7416005|82310400017|35042699013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDNJYmRtanNZVVM2Q0hZdno2WWFYSTREOUxiMm5keW9Ockdnam1lY3dmbzFk?=
 =?utf-8?B?bHBocGNVMUg2aXpXa0xCTWQ1bmowMHdJK2tXYldvaThsTDEvQ3V2UWxXK3Uz?=
 =?utf-8?B?eVYrNUNZejZEREs3MWRnNktKVTQ2NWZlMHBmMmJPWEN1b0t4NVN6SGFpN0Rs?=
 =?utf-8?B?aDRINytQd3ZKZTBHZ1ludnZOSmFkam9wMEdidVNXS2NHRlA0WEJUczc4T3Jl?=
 =?utf-8?B?WlV6Z3JoanFxVFp5dDJ2NlNiWHJBWFFLQXkzcFpiNVc5QXVsUHRrQTRMalBY?=
 =?utf-8?B?MUpUTmU4Zk5pNnY5ZVc4MVpYRGRBNGdIaUZLQTFBVnZRMmpiUW1qWGpSc1k4?=
 =?utf-8?B?ZWhhQ3IzSmNlUStxOGxvUk1aTFhhYUgzMnpGTGtMb0Y2elplNWJYVTJMUUpU?=
 =?utf-8?B?WVpGQlZxWUZEcWJvRTl3UU1HMFNUOHNPYUlKOVM2cFY3U0ltK2VIcGs1N1M0?=
 =?utf-8?B?ODJGMklRSWVkbmpQUnNWYnZQL0tncUk2WmtKT0E1SjlNMEZ0cDJyYUltZUIv?=
 =?utf-8?B?WS9qNlJhclllQW9rMVpMQTVpN25KcXlNRGc2ODZsQU42L0dSNTB5ZGFMMWN5?=
 =?utf-8?B?RW5rVW9pbDBPQ294WU9RR1lNbTljVXV1SUZJaUJ4S29zVWIzbkZ5ZHJDOFdq?=
 =?utf-8?B?RVJwUTZGb0tITEthbGd6SCtIMnNxcm5kTytVaDU3dllkY3YvMEZxTk40bUJx?=
 =?utf-8?B?UXg3VGZhakRJWklIVjNJQUM3TDJyRkxKR1lGSXpoNzA3cUZ3SGViYm5xR2xh?=
 =?utf-8?B?ZHIyQnhaWDErK2YwVDd2Z0orcHRvTndCSE12RWNXQndXTGw4blhsUXRRWFVs?=
 =?utf-8?B?ZEpYaFdNU2NWZFYvTHRJUUU5dlZHMzJMeW5tVU5mK1FLajJhaUpRTlM0czJM?=
 =?utf-8?B?T1RNRGU1WDk0MUswS0tjQWtHY0ZiVnhNM0w4NnRZNC90M0RzY3hwWk1uTlVv?=
 =?utf-8?B?a3N6RWhsT1RqcHQzdUFlWUdSQ3VWaEVTWE1kTWwvWmIyNm9FWWpWRlJhalpT?=
 =?utf-8?B?UlJnc2Q0Y1lJeU8yZ1pja2kxbTlGWm9pZUU5Q3pleURCRmhUS2lPckF6QVpa?=
 =?utf-8?B?dU4rYmtnVG8rbnFyN2M5cERqZzBvamZzemR5SUFvL2EzdEpyZ05TY0Y4cTZG?=
 =?utf-8?B?RjV6UnBCbVdiVHkzZFJuQUorOHJ0V3BoSitrcXdudEVPKzlOa2oxQW9WMUxI?=
 =?utf-8?B?dGY3d1ZKakcvV2hGdjNscWdISnUvRE5yVDRVbnN0SUxYU2VsZWRMTEpDMjZC?=
 =?utf-8?B?WnlSZ0FrWG9Pdzc2ME00dlNKNkU5VjkySzdNYTU4WDZWSU8zRFFmUkF5TWZK?=
 =?utf-8?B?cWRjcEQ3dGxCZlg2UHFSSW5qK2JPcU5JQmlKZkpBNUV3ci9lTmxhU0haTjFX?=
 =?utf-8?B?WjlmRTNCdEJaTllGWXBGb2laelBkamVjbVExbmpvdmJ4SmhpOXFZTHZhL2Yv?=
 =?utf-8?B?S3NJN2xmanltQkpQbXpObnJJUWVMR3ZJaEgzYXlEM1VsdDNZaDRmaWdqbWJF?=
 =?utf-8?B?bW5KR3NSSGlrTzZpcDNjbTVRTm81dE1zVVJxcGlvVnY0VjFzN2p2WWkyWXN0?=
 =?utf-8?B?UERzaVpOSUE3S3AzNjBscFdFOHk2UmVjL2Uvbk03SXFJUFN5WHI1VlJBdG1q?=
 =?utf-8?B?WTViblUzbjF4RU5iQSt3MGl0aUtSOXNsT0NmL0g1QzdMNlAwaW5RbCttdnh1?=
 =?utf-8?B?RHRnS3E2ZjFUZll6WEc0OXUvdVEyYUQyN0VmSVRYUkR5cUF4Nm5PWTFoWDU3?=
 =?utf-8?B?SmVJRzRxTXdBVkJRUmthTVAxVWtiN21oTWhJc3JRcGdzelIrWFNOaDNsMTlt?=
 =?utf-8?B?Y1hsRWIxL0ZPVmNrVTg2eUlZYVBzSUV3WlV5OXQrVG5XSmNFZi9ISkplaTFH?=
 =?utf-8?B?Vk5nb1l3eUdxV0h0aW1qY1FUT1M1eERoUlI1ZjIxS2Y1ekE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(7416005)(82310400017)(35042699013);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:30:25.5196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0f7539-56f7-4569-c5cf-08dc854a8359
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR05MB9084

PiBGcm9tOiBIdWdvIFZpbGxlbmV1dmUgPGh1Z29AaHVnb3ZpbC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIDQgSnVuZSAyMDI0IDE2OjIzDQoNCjwuLi4+DQoNCj4gQWRkIGZ1bmN0aW9uIGRlc2NyaXB0
aW9uIGZyb20gb3JpZ2luYWwgY29tbWVudCAiUmVzZXQgZGV2aWNlLA0KPiBwdXJnaW5nIGFueSBw
ZW5kaW5nIGlycSAvIGRhdGEiLCBzaW5jZSB0aGUgY29tbWVudCBhcHBsaWVzIHRvIGJvdGgNCj4g
aGFyZHdhcmUgYW5kIHNvZnR3YXJlIHJlc2V0LA0KDQpObyBpdCBkb2VzIG5vdCAoYXQgdGhpcyBt
b21lbnQpLiBTZWUgYmVsb3cuDQoNCj4gPiArc3RhdGljIGludCBzYzE2aXM3eHhfcmVzZXQoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcmVnbWFwICpyZWdtYXBzW10pDQo+IA0KPiBTaW1wbHkg
cGFzcyAic3RydWN0IHJlZ21hcCAqcmVnbWFwIiBhcyB0aGUgc2Vjb25kIGFyZ3VtZW50LiBTZWUN
Cj4gc2MxNmlzN3h4X3NldHVwX21jdHJsX3BvcnRzKCkgZm9yIGV4YW1wbGUuDQo+IA0KPiA+ICt7
DQo+ID4gKwlzdHJ1Y3QgZ3Bpb19kZXNjICpyZXNldF9ncGlvZDsNCj4gDQo+IHJlc2V0X2dwaW9k
IC0+IHJlc2V0X2dwaW8NCj4gDQo+ID4gKwllbHNlIGlmICghSVNfRVJSKHJlc2V0X2dwaW9kKSkg
ew0KPiA+ICsJCS8qIGRlbGF5IDUgdXMgKGF0IGxlYXN0IDMgdXMpIGFuZCBkZWFzc2VydCB0aGUg
Z3BpbyB0byBleGl0IHRoZSBoYXJkDQo+IHJlc2V0ICovDQo+IA0KPiBZb3UgY2FuIG9taXQgdGhl
ICJkZWxheSA1IHVzIiBzaW5jZSBpdCBpcyBvYnZpb3VzIGZyb20gdGhlIGNvZGUuIE1heWJlDQo+
IGFkZCB0aGF0ICJUaGUgbWluaW11bSByZXNldCBwdWxzZSB3aWR0aCBpcyAzIHVzIiBhcyBzdGF0
ZWQgaW4gdGhlDQo+IGRhdGFzaGVldC4NCj4gDQo+IEFzIGEgZ2VuZXJhbCBub3RlIGZvciB5b3Vy
IGNvbW1lbnRzOiBjYXBpdGFsaXplIHRoZSBmaXJzdCBsZXR0ZXIsDQo+IGV4OiAiRGVhc3NlcnQg
R1BJTyIgYW5kIG5vdCAiZGVhc3NlcnQgR1BJTyIuDQo+IA0KPiANCj4gPiArCQl1ZGVsYXkoNSk7
DQo+ID4gKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJlc2V0X2dwaW9kLCAwKTsNCj4gDQo+
IE1vdmUgdGhlIGNvbW1lbnQgImRlYXNzZXJ0IHRoZSBncGlvIHRvIGV4aXQgdGhlIGhhcmQgcmVz
ZXQiIGhlcmUuIFlvdQ0KPiBjb3VsZCBhbHNvIHNpbXBsaWZ5IGl0IGFzICJEZWFzc2VydCBHUElP
LiIuDQoNClRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCB0aGlzIG9ubHkgZGVhc3NlcnRzIHRoZSBy
ZXNldCBpZiBpdCB3ZXJlIGFzc2VydGVkIGJlZm9yZS4NCk5vdGhpbmcgaGFwcGVucyBpZiBpdCBh
bHJlYWR5IHdhcyBkZWFzc2VydGVkLiBUaGlzIG1ha2VzIHRoZSBkZWxheSBhbHNvIHByZXR0eQ0K
dXNlbGVzcy4NCg0KVG8gbWFrZSB0aGlzIGEgcHJvcGVyIHJlc2V0IHB1bHNlIGZvciB0aGUgZGV2
aWNlIHlvdSBtdXN0IGZpcnN0IGFzc2VydCB0aGUgcmVzZXQsDQp0aGVuIHdhaXQgPjN1cywgYW5k
IGZpbmFsbHkgZGVhc3NlcnQgdGhlIHJlc2V0Lg0KDQpNYWFydGVuIEJyb2NrDQoNCg==
