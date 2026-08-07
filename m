Received: from mx0a-00622301.pphosted.com (mx0a-00622301.pphosted.com [205.220.163.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6B38F250;
	Fri,  7 Aug 2026 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.163.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091795; cv=fail; b=RRs4euvorZw0TX8JKf6NCT6RwiiTONkI0dO3+OI6HLrCOKxC/iTEfp2U7WvEwSv30c+ug03yp0SmDHAiTL6wBl22Fjk9Y3OgB60XcJDdzrGkZ27tW0faSE5s3vLrXH8WDmkBmjrzgsrYQKvImHszhPaMsQf0fd1x1X1JMQ+xV9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091795; c=relaxed/simple;
	bh=MzVacaQ56ZM1pOhjMO17xMUY12t4a2debGfTT3UtCQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FYlqt+l2OD50Vf/RZvE/nuepYV1IggNtSmkkrhKmbbFAx83z3jO8d/Emufc3zLb4mZmD1K+V21j7T8bZguKe5RshJGeT2U2jdBbPWxLnCBEnKyjF5xB0VSpv9oNVasytz3YjavMdMJocNR0YCmTriE5UI/+ifWyo1GYAgfXfmCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=cHwxTz4W; dkim=fail (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=oTKb7y7w reason="signature verification failed"; arc=fail smtp.client-ip=205.220.163.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="cHwxTz4W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="oTKb7y7w"
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777C4te2845530;
	Fri, 7 Aug 2026 01:29:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=MzVacaQ56ZM1pOhjMO17xMUY12t4a2debGfTT3UtCQ4=; b=
	cHwxTz4WBicU4mWfH3tP30P7uWNdPXEtDqQPcfDqJHpSBcU3iKpbw8UB1RGUg8RC
	g4VR8tEFI62MvKTO9W59xHl3h4PEp9sWrie0n/KzLqciDb19ZUuYq4sTlWvU8rsQ
	T8QjgGBY9LJ653L85//avWrCvGy3UbZwH/1f2qu0vY/Euq/pJwKh0K2oNfw3Czb0
	CMa6IJGF0zQQVyofEog258T6KfMbHCQaz4D5n3QrrinD5GAQXiSzo9FrHErI25CQ
	xSDu1eR4hCQR/lwe0Br/UwSfR69D8BEOeEnLtYHQoQ9FWzjCgQh2p2gra8sVubbL
	RFbLHvL5lVGJQAAoswE5QQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022103.outbound.protection.outlook.com [52.101.53.103])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fw4pxr8pf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 01:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVcvsv+HWQ/bje2ikdb9Xqh7tLp4kUMQo1RZhDCSi70q4D91Mc0NT4Q9NCt9fq3rj03nuvM1Zypd0+9d3hC/PfNhCdnMfaR6vTE7Wy0Y6wa/074Dg0UNDs3+9/yuRo6bIFmat9yiv0cdArOXGN/81ZpTu8byf0FXTbD/r3RP4KsxqfBSK+GC4YVAWbgwgrGGBrpM+0ShH31kLe0Zes+MYcBfUW7GrW1FFKdzEoahI17yyp5bHQoITHBThOx1k8jUIH2UF1GVg8pJBj0J+2XNGtIE0b2nCsPodWPlyFXjS2JSXDXb+QkKR8cIRWMbO4/3ifX0HEYAvryPq+ysFNGaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml773QjRRIiRDS5vPZ4fiMUFeg1FPwxDuAkNqnLa5e0=;
 b=bZI2S7n8GksS2NFdBJptjXkVWp22SPBizhjHITYtNAkJCLbRP7SPi3ebJ0SuXojSxWNvXYnAnvIwqBjTK5nIphKJFKY/XLy1GNo17IdVqZ4jWYbhIAy/pFVUb8/8cpoCzECQAshzZBxPlLXmbf1DKudI2/gZ2xfGupa3Rcs908A09acSMCPkUAVaxo8p8uBrGjOlGYXSMd0dP+1ttA4IuxHUgJSpUYE8TTeij/lGfu2D5hDGLQETMzeuib9uOI/jF9ixnkbA8EnD9EU8c4lCZiGrE6+I0Z4v/S9m08LnUa7GFzO+CAFO4eJSTvT/xUurwOENhlLAhFQ0KjjGSatpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml773QjRRIiRDS5vPZ4fiMUFeg1FPwxDuAkNqnLa5e0=;
 b=oTKb7y7wwUh1fud9AUvb6Fz/CnrPwD7fVqEfF3zaD6AfEtB/H/hT6qS11YnrNlL67ZW2oTex+1B4VqBRwZ5IyDqrgfasPwEk7dBNlDmsKocpC5RGKVhXB6aC+PbUFD+agIAsun3/KRYjonUM/gYeuHYwTcWQoXUTChzbjIlZCdU8R/70oviakqVYQGe42fXYp5c5tbj52nWVh757CXxmzh23SFIUKKBHFKdheRquOJLB8v82iUN2eA/Y3uc9F9k6jczOhVpUUJEBfFOL2iXKQtlaYzPa6Xx+YTS59vbQbWiR4qElyWRYqNrnyfEID7CtW5GVrrWaa2jof4sjsOS8Kw==
Received: from DS0PR19MB7925.namprd19.prod.outlook.com (2603:10b6:8:163::21)
 by LVWPR19MB997398.namprd19.prod.outlook.com (2603:10b6:408:3c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 08:29:47 +0000
Received: from DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b]) by DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b%4]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 08:29:47 +0000
From: Long Zhao <longzhao@ambarella.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Linus Walleij
	<linusw@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri
 Slaby <jirislaby@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>,
        "soc@lists.linux.dev" <soc@lists.linux.dev>
Subject: RE: Re: [PATCH v2 02/10] dt-bindings: soc: add Ambarella secure
 scratchpad
Thread-Topic: Re: [PATCH v2 02/10] dt-bindings: soc: add Ambarella secure
 scratchpad
Thread-Index: AQHdJkbnk8axDLIGPUCcVNmCTrLGxw==
Date: Fri, 7 Aug 2026 08:29:47 +0000
Message-ID:
 <DS0PR19MB79255DB7FCF4BE36FE6ECC8EDAD12@DS0PR19MB7925.namprd19.prod.outlook.com>
References:
 <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-2-6b09707c5fe9@ambarella.com>
 <20260807-raspberry-chowchow-of-endeavor-e57df8@quoll>
In-Reply-To: <20260807-raspberry-chowchow-of-endeavor-e57df8@quoll>
Accept-Language: en-US, zh-CN, en-001
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7925:EE_|LVWPR19MB997398:EE_
x-ms-office365-filtering-correlation-id: 0ba4b7de-2135-4b18-cee0-08def45e0a71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|38070700021|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Fm/LJOB+DlafE5dUfbEB3uWUWXL+et9a9t5TrPAKSYU4biORRlD9EXO2xwPzi6nQdIB5NA6dl+sJ0E4NlZLKlGNjskRfUagA4f6CQeaFOztd7ByocD9loGWwNVFdRLZD1cUvg9ipc409Aj/gsgSaPEjP5rKgH+yYYwuKZMH8FjNaNnl6P0BflxZfLeGGnT40G/R+fGDriagxC3KQSOpEF2EyWmiDwAehLSyPoqrQdocJ/0aMDMucf80WHywJRQ9/NImEwMXXf9IjZgyKwCDAuvCQcT5ljmoDZmcCPqDvcPOyn0uAJ2h3hPC6Q4YtLydDU75BJFiN33/NUO2Y6+Q9yGptHEvR6jvc0q819talEXaqOSKEIj/zlOdZfY3I/+FxpYuXKjDV4mesGvM3019pVO5WIEbXtwmsq5u6CM4UMhifSw9v2MDpZdTc3edJ8C+tfHlMKzQWx27ziHeh8KFg9ZCeCFI0ozv0wGL/Wl3cxruISszolTROLtC7NCONGYmYcWozrD4RjE8TcnqXsf6gIOJKaxswfT+bexVv7yGuQfKcP3ymEQ6yzDnUa29oei8CGZdHMouyDqsLS6MWz9LQZhznhedn1z/HJqYMfEPRZKZbuSYXKQMM5/jKG9/jKqWFT7uOoIUOcUrPXey8t6vpFMEgaT8XzUkyQfo76BJyb1u6EHyUc0yuLVyGWn9cxCUYUXD8uOos9d7ehJcQZFD/TcvF5EnYXYCTQTug8DZRta8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7925.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(38070700021)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnFhT01yMHZCdjByWkRnTDZkUWFyRXAyc0VSUCt2eDRjam1qNU1TbHVjSXFI?=
 =?utf-8?B?NytPYmxoOS9VTU52WVJQV3lLV21CTTJQZENxRGU4ak15bWFxWktDU09HRVNR?=
 =?utf-8?B?cmZHN0N3clcxZnI2MEpmQzB6MVU4U0NJMVc0bk9HYXVqVXBVYm5GbWRkU1FS?=
 =?utf-8?B?Z2s1K0ZRdzdLNUIydUNidnZ0S3dqTUZnQVdLNXliU09QeFdSMjE4Z2NpWGc1?=
 =?utf-8?B?RXBFc3E4cTQrYUdVbVFHWWdWelpRNE80OFJHVlVUSHl2Q0MweFBnMGlZZnV6?=
 =?utf-8?B?N0xDbGNTVjFLQStSSDJIa0ZLZXJXVmtTdko0Vnl3Zll3RjBweUs4b3cvb08w?=
 =?utf-8?B?K3pOSTRwMTgrSUhuSFdsT0NyVklIYUh2ZkI2OFBYTlRCREVSWnJmTlA3NVdv?=
 =?utf-8?B?V2xCSUlESE9qYzZVVjB6TzVkVW1hbXY0TWhMZzFpcUVLeFBrSFRZNzZJSGhQ?=
 =?utf-8?B?RzFHdkdoMGk4K3ZEdmZ0b3ZHRFNabnJlcmhiWXlkTzYzQTBLWHhaL0NIbWVx?=
 =?utf-8?B?OE1Sc29MK1YxQURiNWFGVy9wcjRqV3ArTXdsRUhoZHpabFJSTjBDejJ6Rjdl?=
 =?utf-8?B?bnE1VExkTnJIcEU0clR5V0ppNU5xd0NzU1d2S0dtc1BqL1RvelVIMEQ2Zjlo?=
 =?utf-8?B?SHZOcmpHdVpRS0lzaVBLQ2JhTkkyYjRvV0RNRXlDUVBYRXZEREhLWVB5Qlln?=
 =?utf-8?B?dzYvVjQzVXdQRnBhOVNMUlA1K1B1VElLUnpackRLcm9SZStoL1BYUS8wUGRL?=
 =?utf-8?B?NXh6K2FPTmFoeXVBN1p3QWgrNXRpZUV6TThLajV1Z1pDdWJhbklvMWx4STlw?=
 =?utf-8?B?U2dBQXlDazUyNkNVUHc1N29OTWsyK0IvY1RvYmhyQ3gzOFdPSkNOT2xDQ0JX?=
 =?utf-8?B?UFBsWXVSaStHUGNKaTlRZ3ZFUTBuUW9zdjF3Z0FZL01tYXZXN3htcXVDa1M3?=
 =?utf-8?B?QW5ZN3RsbVRBNFhEeHRJWFNCVnJnWkxEM3BIQTNpWDRIVWNYYm9UTksvTlpV?=
 =?utf-8?B?bmRvMlBxazFjS2owMzRiTDdlZ0hkZGsxeXVWVHdXQUNuZEJoV3JIZUR0NUU1?=
 =?utf-8?B?c1ZDb1lHK3BNRURZb25UZEdHeDlzS0tSRnM4S0wrNk1UK0FGVDhvaGFwNjJr?=
 =?utf-8?B?KzZvMHFkbzdWN0dDa2tZTmFSd0E2V1VUdE1tUE5NalY4bFIrSjlkQ251SDdM?=
 =?utf-8?B?eVJ3MGVlakdOVGFpdFNHL0lkVEZ4aWVSSXB4Y3pheGVpUlR5MGI4UVhLRkcw?=
 =?utf-8?B?N0hndWdSNmdKaWhTNk5LdTN3eVVOZVpRekxRWmc2RjYrTEtIaFZDMFNwek1P?=
 =?utf-8?B?UGpOWTJHYlNaWCtFdExNcFNtb05YZEJhSDBWS1ZKZCszTDhxemtGMmpsbnJt?=
 =?utf-8?B?Umx4L0V0eS84a0pITTFFWmh6WDJ1dXFjNWJpMUFDd3AyL0F4alpycTJuQjFO?=
 =?utf-8?B?b3R6NVJaL2p5UllBSjdXMmhENmp6Z3p4T0VXQUFHR0UyNTR6TzM0aW5kWXg5?=
 =?utf-8?B?dExzVEtHU3Y3Yk1iK1k0UG5ldncwV0w5NHpYRndJbXpJM1RRclBxZTZuRXBB?=
 =?utf-8?B?OG5XeDBZQ1ZPaGVXdmc4a3RUZVgvcElSQ3lkVmNFbTBHLzNUdnRVbGNtaytu?=
 =?utf-8?B?Q0FsTDgrZ1JFZis2N1A5MGxCMHhjSTVobnFxei92ZC9WdzBGd0h2aVZGcG5S?=
 =?utf-8?B?cCtPQjR5MnFDZVFLSWk1SWlXS2FYSnZPNWJqbUsybmVOazFJNlZlSFpuZ2dO?=
 =?utf-8?B?TXM1bysrUHRmcWlidDRSVlR5cStSeENwOWlYTXZERFp0b2orYU54NjkxR2ZJ?=
 =?utf-8?B?ZGtZTGMwbGxTbXgwQzlxSkg1QU9LNnQyVHBydnY5TzVSZStkTzFpakI1NWQw?=
 =?utf-8?B?bEY4UDFwYjR5dGN2ZnlrY3NSN1cxVndZQVVQa1V5M2RJa3MyOHR4ZitBRE5U?=
 =?utf-8?B?Vm5jUmZFOStaTzVwalhDTG5mS2JtcnRQWDUzMEhRTFRGTytOOGRoUHdIMWl5?=
 =?utf-8?B?NFlUdzQrSDVLbTdUcUVDazdjWDVQRHhjc2Nma2x1K3ZkOHZmZkRrYXVibzZu?=
 =?utf-8?B?c3VUN2JUMGwzT3NuRng1bjVob2tMT3kzRkR2UmgvWnF2VmhVK3RMOFVUakxa?=
 =?utf-8?B?N1V0dEg1bXRhSFB4VGl5WE96USt1aVFKS3hUcDJJUFZ0TDJIZlM2N0U2endL?=
 =?utf-8?B?am9SNmNLMDYrbWc1OGFpczVsTnNmeU5sUUswaFJHeTZnRTdGN0JKZkxFeVhX?=
 =?utf-8?B?R2ZGMkkwcHNzTTVQWWRFSWEyZGpYMDJWYUhPTlppZTNHWEV1ZUsrbjNMUnR3?=
 =?utf-8?B?VXBTbTdxamhUNVBuNTZGMTJzSnNocHhVUjZjeUw3bmNoRURTVUp2QT09?=
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MihcWCROtlNq9rEQMCPh1zKgYYT4ThDvWZKcSRhyQ3u0D0piiQjbc66aSb48E2jLKr8W68RjDMCnudRSz9t6j78nDP2zmiRARjncQyAwytf+bLAPTm2goE4uv75s6YfgRwvuVUzgTeuXq4FilPZL7YhdCfinR0iCr7jFfc6yJ4TYBSePRSvolVzK2XySuWWz66LBabVHh/9JDR1sra2L6gA25wPSwAllBRNvVVQhzHrGD4YVO07qL/WgQGMGdLzdz0yn6uTDt8D/yv/pui9Xt3oEe64ocekNuGwsrKKfUnmGiPeR/MJv5NUbvPP35lE3q6PjVS9cDAMUhVPa4A1GRw==
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7925.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba4b7de-2135-4b18-cee0-08def45e0a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:29:47.2150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gIkOLa5uWjEucKtQgKUkE3Vj5fLv1xKPQO2n3jklS/WZnpU/y6whoEnkytMei25whWqZMYwxC1ZW0dbmRzDYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVWPR19MB997398
X-Proofpoint-GUID: xnfXHUvsx1HzcEHzpNalOgvFwP2hBXlG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfX62Iw6F10Nxt5
 lr5IvwCImhI3HjzqnLkCyY/QomzUP05ZxJounWFCSjku7uXldVj9ZSdHe+cW43ez9QoMuC5rUwR
 gIsEUDWkByWVY/hwIcns7zToAK9kQuIBa/Q2zUF/1jsK3lXCdvKl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfX4gLo29jcAEi9
 ayzZiAS0X+2TSNiysYkJV262eaot2gdCW3dTRX8cpKlc+giS0iv2f2X1bpaPKc0EHi1wATeG2M3
 +KKvh/y7dwYqrl8i9SDeFYQItI0KkeiELOnSxKqL8hEAx4Xo0tqVjGVu9U9TZoDdUK6QvkcgnSH
 IqDALhoNAEdvW496q1re0Cq8J8rdxzB60VUJYUeSIRnn9bf9LG1831m8bGYRGEnnrtV7gJ7CWax
 AwUSXCM4rr/1GsUDxSd+nz4AowlS/bDGtxfvfITr/anDj1lwf7DaNPHgPTb3//D8+v1Q4C1uOqm
 wPd4jYXE6jslet63dNRBA+k+yKTWZh8UkRu7Ef9gQcKM50Mnk1skUIX3m6PMNINHEr7hBL/U84R
 eJQiREVPUZLhdjOmuMiEcP1CG5JB/kydbQw1EQISXO/Mz2d7/Hqc4mj8Q6szigL4XpkGCx5AtB5
 y/Nw1M1eXuqaT2NB/fw==
X-Proofpoint-ORIG-GUID: xnfXHUvsx1HzcEHzpNalOgvFwP2hBXlG
X-Authority-Analysis: v=2.4 cv=X+Ni7mTe c=1 sm=1 tr=0 ts=6a75977f cx=c_pps
 a=RRWFpuCx2phrQjYgHg+kDg==:117 a=fVfL832+mzDTHoFKNp42fb2xq0E=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=dkMdDuzY2HgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22 a=pzaFphlX3Qn9zwH3AKfV:22
 a=VwQbUJbxAAAA:8 a=ppJngBeKAAAA:8 a=IpJZQVW2AAAA:8 a=ag1SF4gXAAAA:8
 a=7CQSdrXTAAAA:8 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8 a=cnxaAMSkUWrhdcsuYbYA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=d3PnA9EDa4IxuAV0gXij:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070062
Content-Type: text/plain; charset="utf-8"

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCllvdSBhcmUgcmlnaHQg
4oCUIHRoZSBzZWN1cmUgc2NyYXRjaHBhZCBpcyBvbmx5IGEgc2hhcmVkIHJlZ2lzdGVyDQpyZWdp
b24gdXNlZCB2aWEgc3lzY29uIChlLmcuIHBpbmN0cmwgcHVsbCBjb250cm9sKS4gVGhlcmUgaXMg
bm8NCmRlZGljYXRlZCBkcml2ZXIgYW5kIG5vIGV4dHJhIHByb3BlcnRpZXMsIHNvIEknbGwgbW92
ZSB0aGUNCmNvbXBhdGlibGUgaW50byBzeXNjb24ueWFtbCBhbmQgZHJvcCB0aGUgc2VwYXJhdGUg
YmluZGluZyBpbiB2My4NCg0KQmVzdCByZWdhcmRzIQ0KTG9uZyBaaGFvDQoNCkFtYmFyZWxsYSBT
aGFuZ2hhaSBDby4sIEx0ZA0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlz
enRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4gDQpTZW50OiBGcmlkYXksIEF1Z3VzdCA3
LCAyMDI2IDE0OjAyDQpUbzogTG9uZyBaaGFvIDxsb25nemhhb0BhbWJhcmVsbGEuY29tPg0KQ2M6
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnpr
K2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBNaWNo
YWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBTdGVwaGVuIEJveWQgPHNi
b3lkQGtlcm5lbC5vcmc+OyBMaW51cyBXYWxsZWlqIDxsaW51c3dAa2VybmVsLm9yZz47IEdyZWcg
S3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBKaXJpIFNsYWJ5IDxq
aXJpc2xhYnlAa2VybmVsLm9yZz47IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFy
bS5jb20+OyBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgQXJuZCBCZXJnbWFubiA8YXJu
ZEBhcm5kYi5kZT47IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGlu
LmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1zZXJpYWxA
dmdlci5rZXJuZWwub3JnOyBzb2NAbGlzdHMubGludXguZGV2DQpTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIIHYyIDAyLzEwXSBkdC1iaW5kaW5nczogc29jOiBhZGQgQW1iYXJlbGxhIHNlY3VyZSBz
Y3JhdGNocGFkDQoNCk9uIFRodSwgQXVnIDA2LCAyMDI2IGF0IDA1OjM0OjEwUE0gKzA4MDAsIExv
bmcgWmhhbyB3cm90ZToNCj4gRG9jdW1lbnQgdGhlIEFtYmFyZWxsYSBzZWN1cmUgc2NyYXRjaHBh
ZCBzeXNjb24gdXNlZCBieSBDVjc1Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTG9uZyBaaGFvIDxs
b25nemhhb0BhbWJhcmVsbGEuY29tPg0KPiAtLS0NCj4gIC4uLi9hbWJhcmVsbGEvYW1iYXJlbGxh
LGN2NzUtc2VjLXNjcmF0Y2hwYWQueWFtbCAgIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgDQo+
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9hbWJhcmVsbGEvYW1iYXJl
bGxhLGN2NzUtc2VjLXMNCj4gY3JhdGNocGFkLnlhbWwgDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvYy9hbWJhcmVsbGEvYW1iYXJlbGxhLGN2NzUtc2VjLXMNCj4gY3Jh
dGNocGFkLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAw
Li40YmZlY2EwYWMzZGENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc29jL2FtYmFyZWxsYS9hbWJhcmVsbGEsY3Y3NS1zDQo+ICsrKyBl
Yy1zY3JhdGNocGFkLnlhbWwNCg0KV2h5IGRvIHlvdSBuZWVkIHNlcGFyYXRlIGJpbmRpbmc/IFdo
YXQgaXMgaW5jb21wbGV0ZSBoZXJlIHRoYXQgaXQgY2Fubm90IGdvIHRvIHN5c2Nvbi55YW1sPw0K
DQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YNCg0KDQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQpUaGlzIEVYVEVS
TkFMIGVtYWlsIGhhcyBiZWVuIHNjYW5uZWQgYnkgUHJvb2Zwb2ludCBFbWFpbCBQcm90ZWN0IHNl
cnZpY2UuDQoKKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKgpUaGlzIGVtYWlsIGFuZCBhdHRhY2htZW50cyBjb250YWlu
IEFtYmFyZWxsYSBQcm9wcmlldGFyeSBhbmQvb3IgQ29uZmlkZW50aWFsIEluZm9ybWF0aW9uIGFu
ZCBpcyBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwocykgdG8g
d2hvbSBpdCBpcyBhZGRyZXNzZWQuIEFueSB1bmF1dGhvcml6ZWQgcmV2aWV3LCB1c2UsIGRpc2Ns
b3N1cmUsIGRpc3RyaWJ1dGUsIGNvcHksIG9yIHByaW50IGlzIHByb2hpYml0ZWQuIElmIHlvdSBh
cmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBi
eSByZXBseSBlbWFpbCBhbmQgZGVzdHJveSBhbGwgY29waWVzIG9mIHRoZSBvcmlnaW5hbCBtZXNz
YWdlLiBUaGFuayB5b3UuCg==
