Received: from mx0a-00622301.pphosted.com (mx0a-00622301.pphosted.com [205.220.163.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3E3D411B;
	Thu, 30 Jul 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.163.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409595; cv=fail; b=Heeh20RIyIZ8tmn7y3MC5gSOu9PFLryTdb3IeBJ4NsYWAszGNX0QzRuE8MB+nGXYkeyBt4hMOcQgM25gm9PQF9GtQhLIQmcPFXbC6pUnM1pL5tomliaUvWh7Q2aMKETD4E3Ivn595PrkAe6xwDugHnLevdtNDnItim/7pwkWWek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409595; c=relaxed/simple;
	bh=wmZsbA1DfGVZHkpeYiUJMXqGL2UCIfqpep2REGaOz28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HAOVTUiLYHdR4ZwItXfxCr+M5MitIGXpxunjfWZCJEVRbSO4XEXBdOciLlXHNyj8xUUN85Dis1GOYoyMICaXnLP5926ZbcC7rSIQhnB+YP41JzcDPNGJ3XrSf7OzDT1mZZSjaBW1T26lmHvFYU0G7qE4L4kxgNlO2Np0AIA0Q6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=lm9gOxLy; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=bfSk0DUA; arc=fail smtp.client-ip=205.220.163.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="lm9gOxLy";
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="bfSk0DUA"
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UB02wh3685712;
	Thu, 30 Jul 2026 04:05:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=wmZsbA1DfGVZHkpeYiUJMXqGL2UCIfqpep2REGaOz28=; b=
	lm9gOxLyMSIfg2qXD8P48a94IycWcm/qgsY3n+Vw2K68rOtanT6gv1YBtzJ454lk
	s/lfAyRuRpDCQo4gh/qTo94yJXlLBC+t8OhhOJxEjy0R30qhaPK7gpAxNfpCy7e7
	ikvy2ukTYjiCaaaOrhBybnrhvYHrjKjwTdo3S+P1qEGrsi85bfNNT/Np3q7fu1CL
	y6qvB2rmw9RDrhjOcUE+FPMDgM+DCbCmUScR4Y6B+GQdDaQbvmT/cW0Q3Sj65RLV
	muqDHMTROwCt9KVeExjpWs+ota3NhwX+GPctXh8jAhM2oXy7cCAQbjbObnkqn6RD
	AO8NrN4kzh3rg2uhX8CijQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020091.outbound.protection.outlook.com [52.101.46.91])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fq90h983q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 04:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5uAZTVO/ojU3vSDUAsgEe3ffmiEuh72trhk1Qt93drY55BLrbQ5D6Z8DhxHek7IdxldaV3pmFLyoF/tiqoOXc2FqPXfLjpejlioEz5OkWNdVyAR+H7OvwxoCeDjaoBhFdnDSJnr/QP8RyAwFzZqYny29fdl91zYwdng/Flfb2fJjo+HJm9Mp6motMviNJ0LoUgfGS4FDShXo1eOOW5pfH7WtPBuUzCFJ/i2Hm/hCeFfKqPiccNlA6XXY939yezoUIKmcmE0SDXP4+hB0O8iwGL+wNk60HDLRxfkPBiZV9XLNfWXee1Hwz5zKSBwj5Pe5erMewRQD6LyVWHLJHlrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmZsbA1DfGVZHkpeYiUJMXqGL2UCIfqpep2REGaOz28=;
 b=kVAFFxSMnOEiI3t4vG5ehC+Dpcb21/5zdsdU1V0juYfx9QJ0qDpFhYCzlOI7E6eZ6M7AgOqdgco4pp2vbKpJWAhyiuDM7n7hM91C7oVmI3+TmeJzgoLkV+xKQcRnxUUfNR3kAIqjtnGCD7BcNqxpDiMO2doMNkYZnUv5SBn9ipmMtgd3sKggjU8KhglS1tffbx7gJdedxjBIGmQBq99GTsT0ZfgFPOw61e26INTLnMrNTQi71rrmVnIM+Qu1fTMuE8w1UXR/JDlQRQexi1983c9+LvZ7lOo+Td9yIiDIYQu0766AM/fmxv7f3qL9CeIiUJHJdpDAb09twlO9+oDQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmZsbA1DfGVZHkpeYiUJMXqGL2UCIfqpep2REGaOz28=;
 b=bfSk0DUAchc9nZtogNOpjalTo4rabKuokbutxKcnoLIxJS1D/uSfyFSHyEcilFX3eWbtmZzqGXJsJFFMboKO/v6fPONVc69HqfuhyBZcymXD4gXGVKZmuG2TV8y5kUlzqgrTsuLfomEymEdoENw1y+a6QimCYnUKX9seqnhsDGc61hLe1tHUvMNb/xyWhoEtUs0NRhafiKRptVie+oBeHP3AV9d/t5UQ5caTseewHDcIRuEiYr4iYNu768Wg6MH9cI1LEzstGnjaWP8AGccys9g9jWqf/syzCI5M4xePv6+ajc7oKDdDi5HnZ5XQJVakYKdA1UjGj+9lXL2ixgXFWg==
Received: from DS0PR19MB7925.namprd19.prod.outlook.com (2603:10b6:8:163::21)
 by DM4PR19MB7899.namprd19.prod.outlook.com (2603:10b6:8:188::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 11:05:02 +0000
Received: from DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b]) by DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 11:05:01 +0000
From: Long Zhao <longzhao@ambarella.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "soc@lists.linux.dev"
	<soc@lists.linux.dev>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 00/10] Ambarella CV75 SoC minimal bring-up
Thread-Topic: [EXT] Re: [PATCH 00/10] Ambarella CV75 SoC minimal bring-up
Thread-Index: AQHdIBBLIVT0ouMkoUSUABGF7rLeHbaF4bQAgAAERHA=
Date: Thu, 30 Jul 2026 11:05:01 +0000
Message-ID:
 <DS0PR19MB792519CDB8D28B0672713A05DAC92@DS0PR19MB7925.namprd19.prod.outlook.com>
References: <20260730104330.81367-1-longzhao@ambarella.com>
 <0fce6943-0d4b-4f3f-ae5f-277633577774@kernel.org>
In-Reply-To: <0fce6943-0d4b-4f3f-ae5f-277633577774@kernel.org>
Accept-Language: en-US, zh-CN, en-001
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7925:EE_|DM4PR19MB7899:EE_
x-ms-office365-filtering-correlation-id: 9cdf4416-9c42-4035-1ed0-08deee2a66fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|6133799003|56012099006|4143699003|5023799004|10067099003|4133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 UlSh/euw/wXL6kTA9nJy/kzX+m0+TsVaeiVbOukBqKh9eTe/XQO4arzsq1xkD3++4qktw0mkMl/NfaN6aNgdPjhysHD7o3AsWOwYV98NlY/wUr8ADrLuCpBrcby2QFeI+G1aP1kgDYS3xDk/OPJC/qNwWhFKc3b7Pcsre+cqJv8lppB+ASdF5GQKEBz55g6TJaLglpw8WLRY3a/oiVQprmpL5Txz3/H5Z3oOauOw/j5dt08DNt9ZF5toKS9ROiNoqXQIhXICNesEKRcYV424A0uw9DR2sll38yydYM3+S3uVypHEjNNO0ZVIFO8wgLLQgMOCDymeV1A3NQuLgvmK1W3A0gZKj0/otY4yr8Q5RK00UVSnHNtDohbCZu8MasdNG0P4gfstojxpE3BxA5LKzFE0jGDOjHc5P8lkdY2KVduKjBerv+7XIhzT/dm7x6MoPKrlrPcEeMOZqTYtnZhOAnyjiDCUWqMomc1s5PZdjfZL3v87sTDruIIW3VxQfNmQJ1bEevP2wFHGyHBOCGr8f69ShutaK7AkVdLiibdUYKoY7qWL59ZHoXoQK48ZZcK3zQADT8cp2/AIQDtVIPN/rDEjgeFymkrWsGmzem5I8cwSBaJqG3ZqzmoNgCV46MCCWNxHH8src1G/ZWnX71KNqZKDhKX71oP5IVwcjRVL/p5N9E3qCuSYtTN10RdGHxplWjQrEJ6mgNhfGukSI+I6eBGTUTyMiRL5pKYxRCrxv9U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7925.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(56012099006)(4143699003)(5023799004)(10067099003)(4133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWpJdEtuazZHc3lpYndFVlJQRTk1T2VRU3hMUmdPcEo5Z24rTUZWcTNlTHhB?=
 =?utf-8?B?MzZlMlp1NThNZjUxcDRucVBlcFNmcE9uT2FyZVZLTEdPWDIva2dPZ2ZRVEIv?=
 =?utf-8?B?bWZod1FIeTlEMkIvZHp1aVo5S2RPTUVLWlgzcFdxYzE3NDlsT2U0TUhKSFZi?=
 =?utf-8?B?dUVBSm5ybk9QbWN5UFhNSThVTU1DdG40VHpaZzhQcThWZkpNSUNpZ0UwMHdD?=
 =?utf-8?B?MmtyUDdZM1JPN0pnR05HaUwyd0QrZk1xN2FGMkNPRi9hZVNxazVuS0EweXNz?=
 =?utf-8?B?RUYwU1IzdVVqKzdtbEhNMW5VbW5KVGs4WDNIQlFIRmc0a3BJQVpTb3RwOGxh?=
 =?utf-8?B?KzJHbHFMTjk1ekl2UDlBWk9WWUtna0lMK09XSzJRRGkyaTVWejZvcGJtODlx?=
 =?utf-8?B?N3R3NEFVQXFBWmdCdFQvc1FNOERuL3hKQkJPWFI4NEl4OXF0Y0hnREgzTnRm?=
 =?utf-8?B?TUdHVE5zaERCTDZXb2tSNUVPMFBORlkzUGRxdlFTcnp6cjZwWWdVdFZyOElR?=
 =?utf-8?B?SlRoRm00U1FOeWxTcWtJNkJPM29FUGNEamk4UFpZcHpRZlpyQlVOY2RYUlpH?=
 =?utf-8?B?bG1ycHVlYXJlMk1YSE5JZldENWdsWVp0MEkxa3RUL2JzOTJTdnBVZEphd2lI?=
 =?utf-8?B?U1UzZi9UQnhDMW15Y1lDMExiTHpUaEh2LzMwVDBLYVVQblVuYzFONlE2ZnAr?=
 =?utf-8?B?SGJ0SjZ6SE9nYU9mdGtKYjE0Z1FlRnlHaXVaQXFIY24weWErcUFBOWpRb0lx?=
 =?utf-8?B?REhadkhldmJVTEgzVVdLbjdBdGY3d1hSS0trOW4vN2JIeE5KK2xldmlFY0tD?=
 =?utf-8?B?VVNpaW43N1haMUdEcC9KTnZpUjdjTEMzMytCT2pNWGd1QnJGakNEWTNrSjBj?=
 =?utf-8?B?eWhtWGtBeWhDMGFnOVhGZW1LVVhZYXAzdVdSY25kRmd2TDQ5RU5sbmFmOXFh?=
 =?utf-8?B?QU9Wd1YxNHc4SE9EanhHNHhCd21BWU01UUNLM0VKeVJVbDZlNktwODNZdkt0?=
 =?utf-8?B?Q3p1WGQzZ3lOVVRkeVI3Y0I5UmY5R1kzdUpPSGY4a0J4UWlNbWZ1ZW1uNEpO?=
 =?utf-8?B?TU9lSWI5ZXhqSStVa1l1a2liZlZjNUNESDlvclhQL0lKLzFiMGh5ZGJwcWZO?=
 =?utf-8?B?Z3M2UGMvek0wVUJrQ1VBcjcxbExubnZOOTB1YWF0eTdScDQ4TW5NKy9NM1Vl?=
 =?utf-8?B?TzFiQS9pWG5wN3ZmaHA5SXl5eVFJaW1sSHZYbC9PNWVNMHhUMGFpZ0xFNlkz?=
 =?utf-8?B?YU8zaXF0ZnpjTlZndU5RZzVHZW96bXJhVXc2VW1XZHJxRXNGLy9SeHY1NkVV?=
 =?utf-8?B?UENZOVo4bGRKREw4TlRlVDlLNWh4MVZkVkRzYVUvM3A5bjdyVWRaMFNoSW9V?=
 =?utf-8?B?SnR3VlRDSWpDV2xtNGNvTDdTaTBBenlXUVZiVXhzQlhrU2duWkV3K3dMME9s?=
 =?utf-8?B?TFloZUlwQWdFTFZ5alFSbkRZb2ZpdXpPT3BLZEpMYnh6ZTl6cUh6T29xdm1v?=
 =?utf-8?B?Z1lIdEMvc2FtME5vckxZbjhCRkRDcUpqMWYydEs0T0p4cFBDdmdIOWJhYnVF?=
 =?utf-8?B?b3ZDTWY2S2w3Ui9pQzAvMFBnWUhYSFRwbHRyVlVSN1Y2T0xLbXp4ZDNITUxH?=
 =?utf-8?B?QitjSTZuY0NYTWtxejB4UDFuNG9PempENlExd1RQNTJ5bHMyK0ZCdUtadm1I?=
 =?utf-8?B?V0ZFRVBaZ3gwelRNMlltSUJzRkVDUzk0ZVhNNExOMDRMalR1UXhwd3FwSGU2?=
 =?utf-8?B?bG5odkhQZWxwQVAvUFFiUDg3cmJ6NnZIaE5Rb2g5NGF4VndzRnZLQWU4OVQw?=
 =?utf-8?B?TFJsdFRZUVliVnc5d2lIRS83OHhYZU1RZGtoWGRUY2ZpRnRaTnVxcWJ3Q2Iy?=
 =?utf-8?B?MHV1ZVExbElybys3dkJzSnpjTllkWWZleEJGdUpGV2FOaTZyYzg3U2ZRUElK?=
 =?utf-8?B?cWttR0tCMVN4M1A3OWtSZGlwRk45K2dLUHM0SElyVWFRLzJNNVJmMVAvSlpK?=
 =?utf-8?B?eHEvN2ovVlFwTmQxRGRHcDBhQWdaT05mMHg4aGhCZGtLL3dsQXVSL1A1Ynkr?=
 =?utf-8?B?TFlXM2lLVXJLd1JGc1k5WE1xWWxaUDY3SVQ2ZVVOWEVRSldVMlZha2g4QU1j?=
 =?utf-8?B?azduaGNvZWRRejkybDZSdFBFWHdTeVRVMlZMbE5UcGxyUyszK2REQTBXZlAx?=
 =?utf-8?B?ZmVQcDRsdWd4d0o0SVJwdDNnTmxQTkxqWVRWdE9TYUhyb0R1akxuM1haUzJ4?=
 =?utf-8?B?UTZoTTFQcFkwa1M5b0hZMmlqOVNRMjhHVzZBbnRLQlNYUWp0OXZGeWRHUDRF?=
 =?utf-8?B?a1orUVo0QVUzTGtTWnRQM0t6V1RrSXp1OTVkajlWcUN1MmJzSEs3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lH5GUYm8D2CkbfgRFADZPy1wEOCXdvScoFBdeMonwyEKlC2BN1P8qFYNWMr6553N/ADAmTrwUg2QnIHWeZvsMCq2TEBp+yj2ljnlaIY78i4bW+RgJddX0jdiF/kwrPrcMnXn7efHuX97b5Dli4mJCfF11lcBD0SjSmShkpvc3S+Yu4fZ4ZEfLR3c6RAvw4/gBBGumZpn48EGHe98jEjWPtEU51zsX3lyroxpCn5kVav0i/EZr7nTDtC4ZTF8uOuNERQw2z+0Jt26HT5CZHzRN7Xz99Qp+Vhi9FUcOqOh7HZIgQESnU5CuV8SJcEiQLZ01pfnxwj4lqPK5KOdq9SlyA==
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7925.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdf4416-9c42-4035-1ed0-08deee2a66fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 11:05:01.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6O9Fuy30/eGdzc30vFwpd/kJU671pK4HRJZOcQ+Cs8h792W+iUSULIZigRvPZhepGTIjVT8d5+xHoSgLiuHcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7899
X-Proofpoint-GUID: AQzet7m6GCjFl6DazCpdteVvZktYK165
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MiBTYWx0ZWRfXxH8Zv2DD87Qy
 4Z70skcHuy3HRzOl6cMrIOqX9wuVismRgfJ5nwoDMpEBF5VXsyyR47Y5EwhsPURp3Ovdgqyb021
 LamR04kA9ghRCRKPjOwGzQ2pOyG0HDKu4wHdphGtolgW3i+wrH+3
X-Proofpoint-ORIG-GUID: AQzet7m6GCjFl6DazCpdteVvZktYK165
X-Authority-Analysis: v=2.4 cv=QZVWeMbv c=1 sm=1 tr=0 ts=6a6b2fe2 cx=c_pps
 a=5g1Slaqcz6OQozqf5DRlqw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=dkMdDuzY2HgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yXVIz-0bn9infC194UBj:22 a=pzaFphlX3Qn9zwH3AKfV:22 a=vnREMb7VAAAA:8
 a=VwQbUJbxAAAA:8 a=ppJngBeKAAAA:8 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8
 a=IpJZQVW2AAAA:8 a=ag1SF4gXAAAA:8 a=7CQSdrXTAAAA:8 a=Y7lJEgl3tIs_xKLw27oA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MiBTYWx0ZWRfX4tH/GYQmBrxU
 X5nNxV1uIOiD+9zsw15L9OMQcR21PlHseYUjPph2s5WUS3opiO/wGp1usSe70qidOuXuBWdu0yV
 nbKq9JrAaqrORlWuAXzApWtpEGZAbwwAeDNHrNPUgqlDkHY7DWOhgcJC03qw+NWlGTWcPhabMxm
 XKPPg/svUH+kylRYkBjZC5jHCMWnP2SKJDplAauJxzrhiBv4lPnMdO8aVjdqEYTs9DHm9eJRErx
 pxoiyNECJlMqro2vEOebcrHWQssHJOIgy6YcjOtFc4qCbDVLPqDddTIWB8IcbnpmUA1vPXRl+0B
 LONjcG0P9kPUW+Hh1vMQnZgFbD5h/j10gZKxCM2Tu7vvnaFj+WfrJVtfgZnD+0cUhXi7HrbduKs
 l546iO6sxYjzWy+eaJi1MyWZgF2Zc0MT4C51LAhkPkB6E5n4NYTZCiSLcvc/J2JPdgtzDHPIj0R
 Pq1gBUgj8pE+jGPxcrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300082

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4NCg0KUmVnYXJkaW5n
IHRoZSBmb290ZXI6IEkgZGlkIG5vdCBzZWUgdGhhdCBkaXNjbGFpbWVyIHdoZW4gSSBzZW50IGEN
CnRlc3QgY29weSB0byBteXNlbGYuIEl0IGxvb2tzIGxpa2Ugb3VyIG1haWwgc3lzdGVtIGF1dG9t
YXRpY2FsbHkNCmFwcGVuZHMgaXQgb25seSBvbiBtZXNzYWdlcyBnb2luZyBvdXRzaWRlIHRoZSBj
b21wYW55LiBUaGF0IHdhcw0KdW5pbnRlbnRpb25hbCBvbiBteSBzaWRlLCBhbmQgSSB3aWxsIGNo
ZWNrIHdpdGggb3VyIElUIGFuZCBmaW5kIGEgd2F5IA0KdG8gc2VuZCB2MiB3aXRob3V0IHRoYXQg
Y29ycG9yYXRlIGRpc2NsYWltZXIuDQoNCkkgd2lsbCBhbHNvIHN3aXRjaCB0byBTb0Mtc3BlY2lm
aWMgY29tcGF0aWJsZXMgYW5kIHJlLXJlYWQgdGhlIHdyaXRpbmcNCmJpbmRpbmdzIGRvY3VtZW50
YXRpb24gYW5kIERUUyBjb2RpbmcgZ3VpZGVsaW5lcyBiZWZvcmUgcG9zdGluZyB2Mi4NCg0KSSB3
aWxsIHdhaXQgYSBiaXQgZm9yIGZ1cnRoZXIgY29tbWVudHMgb24gdGhlIHJlc3Qgb2YgdGhlIHNl
cmllcyBhbmQNCmFkZHJlc3MgdGhlbSB0b2dldGhlciBpbiB2Mi4NCg0KVGhhbmtzLA0KTG9uZyBa
aGFvDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnprQGtlcm5lbC5vcmc+IA0KU2VudDogVGh1cnNkYXksIEp1bHkgMzAsIDIwMjYgMTg6
NDgNClRvOiBMb25nIFpoYW8gPGxvbmd6aGFvQGFtYmFyZWxsYS5jb20+OyBBcm5kIEJlcmdtYW5u
IDxhcm5kQGFybmRiLmRlPjsgQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJv
b3RsaW4uY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBzb2NAbGlz
dHMubGludXguZGV2DQpDYzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRv
ZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRA
a2VybmVsLm9yZz47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBNaWNoYWVsIFR1cnF1ZXR0
ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5v
cmc+OyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBMaW51cyBXYWxsZWlqIDxsaW51c3dAa2Vy
bmVsLm9yZz47IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBHcmVnIEtyb2FoLUhhcnRtYW4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5l
bC5vcmc+OyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBDYXRhbGluIE1hcmluYXMgPGNh
dGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggMDAv
MTBdIEFtYmFyZWxsYSBDVjc1IFNvQyBtaW5pbWFsIGJyaW5nLXVwDQoNCk9uIDMwLzA3LzIwMjYg
MTI6NDMsIExvbmcgWmhhbyB3cm90ZToNCj4gDQo+IE5PVEU6IFRoaXMgZW1haWwgKGluY2x1ZGlu
ZyBhdHRhY2htZW50cykgY29udGFpbiBBbWJhcmVsbGEgUHJvcHJpZXRhcnkgYW5kL29yIENvbmZp
ZGVudGlhbCBJbmZvcm1hdGlvbiBhbmQgaXMgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNlIG9m
IHRoZSBpbmRpdmlkdWFsKHMpIHRvIHdob20gaXQgaXMgYWRkcmVzc2VkLiBBbnkgdW5hdXRob3Jp
emVkIHJldmlldywgdXNlLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRlLCBjb3B5LCBvciBwcmludCBp
cyBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFz
ZSBjb250YWN0IHRoZSBzZW5kZXIgYnkgcmVwbHkgZW1haWwgYW5kIGRlc3Ryb3kgYWxsIGNvcGll
cyBvZiB0aGUgb3JpZ2luYWwgbWVzc2FnZS4gVGhhbmsgeW91Lg0KDQpNYXliZSBJIGFtIHRoZSBp
bnRlbmRlZCByZWNpcGllbnQgb2YgeW91ciBtZXNzYWdlLCBtYXliZSBub3QuIEkgZG9uJ3Qgd2Fu
dCB0byBoYXZlIGFueSBsZWdhbCBxdWVzdGlvbnMgcmVnYXJkaW5nIHVwc3RyZWFtLCBwdWJsaWMg
Y29sbGFib3JhdGlvbiwgdGh1cyBwcm9iYWJseSBJIHNob3VsZCBqdXN0IHJlbW92ZSB5b3VyIG1l
c3NhZ2VzLg0KDQpQbGVhc2UgdGFsayB3aXRoIHlvdXIgSVQgdGhhdCBzdWNoIGRpc2NsYWltZXJz
IGluIG9wZW4tc291cmNlIGFyZSBub3QgZGVzaXJlZCAoYW5kIG1heWJlIGV2ZW4gaGFybWZ1bCku
DQpJZiB5b3UgZG8gbm90IHVuZGVyc3RhbmQgd2h5LCBwbGVhc2UgYWxzbyBzZWU6DQpodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly93d3cueW91dHViZS5jb20vbGl2ZS9mTWVIN3dx
T3dYQT9zaT1HWTdpZ2ZiZGE2dm5qWGxKJnQ9ODM1X187ISFQZUV5N25aTFZ2MCFtWkkwY3NFQjF6
S2U3VUdFVWRBamJRVDdSM2c3YzNMRVlpdHE0RFZpM0ZfUFhqbDA4ZWF6UDVjdE1nb3VDQm96MXhf
YmRRM2tKZG1JV0dvJCANCg0KSWYgeW91IG5lZWQgdG8gZ28gYXJvdW5kIGNvbXBhbnkgU01UUCBz
ZXJ2ZXIsIHRoZW4gY29uc2lkZXIgdXNpbmcgYjQNCndlYi1yZWxheTogaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vYjQuZG9jcy5rZXJuZWwub3JnL2VuL2xhdGVzdC9jb250cmli
dXRvci9zZW5kLmh0bWxfXzshIVBlRXk3blpMVnYwIW1aSTBjc0VCMXpLZTdVR0VVZEFqYlFUN1Iz
ZzdjM0xFWWl0cTREVmkzRl9QWGpsMDhlYXpQNWN0TWdvdUNCb3oxeF9iZFEza1lOMFZEbE0kIA0K
DQpQbGVhc2UgYmUgaW5mb3JtZWQgdGhhdCBieSByZXNwb25kaW5nIHRvIHRoaXMgZW1haWwgeW91
IGFncmVlIHRoYXQgYWxsIGNvbW11bmljYXRpb25zIGZyb20geW91IGFuZC9vciB5b3VyIGNvbXBh
bnkgaXMgbWFkZSBwdWJsaWMuIEluIG90aGVyIHdvcmRzLCBhbGwgbWVzc2FnZXMgb3JpZ2luYXRp
bmcgZnJvbSB5b3UgYW5kL29yIHlvdXIgY29tcGFueSB3aWxsIGJlIG1hZGUgcHVibGljLg0KDQpC
ZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YNCg0KIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KVGhpcyBFWFRFUk5BTCBl
bWFpbCBoYXMgYmVlbiBzY2FubmVkIGJ5IFByb29mcG9pbnQgRW1haWwgUHJvdGVjdCBzZXJ2aWNl
Lg0K
