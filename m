Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794470577;
	b=xTUvJsZ35AeoeyKGLM9rpjVTuxAuNDmGCq3UZ6xMC1kHzaiBM/ggvEFgrRKjNqS+DSae
	 LKDwVur/Y7Ns/sqUvU7JmaSJvSZqrVO2GK6R1QFQ7fgnQeuqqTtAN+qf3/D9QjpUc4czD
	 XmLlr7/wLSQ3t/vZ5ZMge1SAMjIq+DCS/DhB/IdPD0KrxgES16U5HmdI0DaDWcWVSQSMk
	 JCjqEiHYHJG1nMHOIFzBsljWODn0O9jcfxtaJf3Qkb8mvedLPnjVEjjoMZ3tC+oxz5jCQ
	 2yqa2SDoNbRHcoZsrsD7UCe+a8d/iH0I/49YCAM0ThJGKyekQAZ7xu0kZHfHT8udsBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470577;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DjY+nfs4WD8P3P6ERqHPO2fSclH6ns/lpkbqFOjEXCM=;
	b=5PkdatX4EzCtfRI1envhJHruzzbdYtqITvjVugotD6QhSAm7oY0VcfsVjqtGMpYlLlaG
	 5Yz56N/7cqPKz6bwbgojrJgNC/GxBgQqN68aQlnSgSXdxR3Mhcsav9GmgITDVCr8zVZOF
	 EwOkAIIowsPKPoZnPxOVX3qDP+VN8aeSzdtCPihwbIyOh1z5WmFRmY9C8I48G9iioiavc
	 V+WmF6v/x07svAiBTLMYZ13XFemF8jdcze35uDg+1vi0dqfntqenFaTEP+M65rkWTHoHd
	 pG0YlRqJXdaABWlDkT44gCviLkaaz3l2ualqA/9+xNH+lwtx1r3GejNwtE8OiIQV+jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b="KWGi/pZ/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.67
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476F606A323;
	Thu, 12 Nov 2026 08:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A476F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=KWGi/pZ/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nr2P6LcT7A6bE1+y6wtc5WRuG8UyMAbTyCpRwvA6mfiIv19zlX1nKPKvCUUtsuVuvIE6n7YMHGA7eq/Gfhjov9z9C0PH2gQuMKVzP73cfgHeQinCe9HeSKnXFkEUFQXRzy6vUrmOushGV8bEadAzP0A34pA7zNWHw9D3CEHtnW2uqxJGIt2HIK9Ui4pd+TDzxixnQ29NuQS7hxYolylGkevT66bMRGrkADEYekRCsRCGdXoZw84y6UcuXG+ciNFDDuAkEdYLeMXbiAn5QQGD+BDyRii1QcZyxO5L7ONPkUTfgPLlKi7TwPEJQQ5cjdYPPwcJytEQv9F/rgfzk+nweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjY+nfs4WD8P3P6ERqHPO2fSclH6ns/lpkbqFOjEXCM=;
 b=qCaKHyA/UbTAsXEJHwOyCpqOs8N9av7XVVgAIvOEEfiGrsBjIE4FXmOKO9X37POEPzbmeuqRNab7H/zCXCdmOfpg7nVTcKqGs/4th1J6o0EbXjRMONI9A0yYHYyqCDe4/WKhLxSO8L2Vy6QEUZlhtiAe3WkohVfw/rxNHmQWZVFqxruXOg3+4BoPVb1OtzekUb2dwznxgNX4eZ11UR8I/3S0QYYiJQdTPlydtxTUJCbSSzMXtTouLuDe+XMNwMezM+1Ww3Vw2AnbdRfTR8J1+Gsh8fodpON+PX7tM+VCRFcsarxsUnCdkvplQLK1lkkENG7yxYk8k0cP4b8yHh9glA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjY+nfs4WD8P3P6ERqHPO2fSclH6ns/lpkbqFOjEXCM=;
 b=KWGi/pZ/I1tDZGg4BT9IX4tIg1kvU4wA1k9bws6VU58r1zijC6XsobqUY9pcTsN0xsER0aoYQZ31EUB5NU+OW019tC849Csd33q7KTm2y7oXzGA37hYcghJVzUsw7YXYG/DErB5Dgzt5Bxm/PQ0cmTZosg+2tObtHZbSXMJPM6zi+iNhc8+xTQCCy+PsQ2tAhWRVyYsXuQATfNsUddPP27HMe5IJkWCJmQDyPjkipzNr6YeMCdRDg1fLsnAFMN2m8yHlnzWDFttR5QE/9Vc3TdfrzD0+rnFpHcHEW18D+xDe+M/IM5NLJmF4/S5ZEMZaTCraH1Uxt80gY5pZG79kDw==
Received: from AMBPR04MB484752.eurprd04.prod.outlook.com
 (2603:10a6:20b:7da::11) by PAXPR04MB9570.eurprd04.prod.outlook.com
 (2603:10a6:102:24d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 08:02:52 +0000
Received: from AMBPR04MB484752.eurprd04.prod.outlook.com
 ([fe80::47e:af5a:c2c:93bb]) by AMBPR04MB484752.eurprd04.prod.outlook.com
 ([fe80::47e:af5a:c2c:93bb%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 08:02:52 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, "Sherry Sun (OSS)"
	<sherry.sun@oss.nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Jingchang Lu <jingchang.lu@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2] tty: serial: lpuart: Add port lock for registers read
 in lpuart32_set_termios()
Thread-Topic: [PATCH v2] tty: serial: lpuart: Add port lock for registers read
 in lpuart32_set_termios()
Thread-Index: AQHdclRUC+KN3DOg90yO+NlWpF6Dwrcp+LaAgAAax1A=
Date: Thu, 12 Nov 2026 08:02:52 +0000
Message-ID:
 <AMBPR04MB484752D41C64CB1AFF9BABEACC92702@AMBPR04MB484752.eurprd04.prod.outlook.com>
References: <20261112-lpuart_port_lock-v2-1-e1d914e52660@nxp.com>
 <987f1008-bea2-4d02-a2e1-f4389a0ff3d5@oss.nxp.com>
In-Reply-To: <987f1008-bea2-4d02-a2e1-f4389a0ff3d5@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB484752:EE_|PAXPR04MB9570:EE_
x-ms-office365-filtering-correlation-id: 165c4a09-feb1-4ebd-104a-08df40935a17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|23010399003|22082099003|18002099003|261009221227099003|261009223027099003|11063799006|56012099006|261102123227099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|10067099003|261026121527099003|261021123027099003|38070700021|4143699003;
x-microsoft-antispam-message-info:
 ZtktuINCMMH3Espz3mzu8GYJSXlKEwDGSxuQttH6nTGK/FkCtrlql6nYeAz0G9Nr3EbcWSZKyG5KWYfobK6JQcecF8JQ8tA4IvK01unOTYCTkeo8hJ/GSWNkeRUCy/e1yLrOZsDV3NhI6EiraL1nmT/Qju6FBks5DG/OfApTUxeIRXTUYkHQ3xdEqhWCMx3ccUboCOOFAVUFDcO/xcai5Crzwq0g9kn/HdS+/+Ttd0envRJt4lXjMKvolPUAMw5jv59i8UbKeW6CPJijw9k9sA9XzLAgo24DPrAZD7B+K3DiS9MLMsqv3yDlxm1BAyrARcfMfrWziKNzASiy/RzFEhSffQuu1bxTMK+SWT395c8RM5hruGFqNzt1CHpSU6cWSsLYOjj5VHCyPbU/hLa/cCbA4z92ssXslt2zbcz5+SDziW0MPdi4qdpa42U/9nEZlQb7sk4aVajepX8mA8M9PhvoO15a+3yKzI7EteBkTEOo46dZKURBldg68kiHb68mBDuBykCkp8d6AMdfQZLROpFwWSnaQsgq+0WxG1HCBRHbY3JrQnJ/3O41NFHh1W136zDaJZ+GQf18hAT/a7Ekr48vRCCegpKmxIg2c8iaNXvFQwWKlWAzzTlBF3rBTs6JemV90I3uFPaQXkE9aBrETgRbmxC2AsOQV0NBVlkG//2MFIzl0d+tE3DGlaXX8zlg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB484752.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009221227099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(10067099003)(261026121527099003)(261021123027099003)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnFNNFRPMmZSYUJPSFZBelRzTWpOK0xTTGR5QmdmMHBFd2hsdXpBQncxb0J4?=
 =?utf-8?B?RDBTWHUvT2RPUHNrcjEyY3RhOWpsZE0rQnpKZXFhRitNMTZQK2JPb1hQUXpR?=
 =?utf-8?B?alBpQjZCM1JzK3E5cTNLbXBMcVB1TEtrYWdDbzN4N2x1aStoMnIzaWtqSSta?=
 =?utf-8?B?cGNiVG9WRFdYbEZ4MWNrSGdLZTNDUVNDL2MrSE9EL0k2VDNFYXNtbkM0V3NB?=
 =?utf-8?B?KzVCSHlOVFFpK0VySW5oZWZOelZUbzJsZFBEazl1bFk4SXZkYWZuWDNuUkJM?=
 =?utf-8?B?RXZkT1JsVE1WZTlUaTVmVzF1OURoTnlpaHVpd1VHZkZvTTZ5alk5RGR1WnlV?=
 =?utf-8?B?YnBhTmIyTm1CaWF0bXVkSGJIbEJmYndDdFMvZFM0T0F4eDhDZzBSK1dxZXl5?=
 =?utf-8?B?Q284L0w0cVduRDc0dmp3ek9SVHVpNTRxZTlCRXZ1NmdmamZYY0MvTXVVd01G?=
 =?utf-8?B?aVhMSjAxUzZDcWt1OVEyZ3hadU14SXlyUW1ieSttUFF4ZitZNWpvTGttUmtv?=
 =?utf-8?B?VnNtaE4xWDBZNDJ3V3V0a0JMeWpObTZoNVI0ZU5QMzJOUEV5MnVFVG1hU3p4?=
 =?utf-8?B?cnlXWmwwdmp4YUlBVFBPaHZGR2o2bHBVc2NKc0xYbUVGQ1dKbW11MXJZRUNF?=
 =?utf-8?B?WTNkdm1IVEY3RDNoMDBEc3pXL0UwU29YZUs4QjBnZVYrSzhuak5hYXRoMGww?=
 =?utf-8?B?MmFNc01VenpaZ0ZGZXJ4RXo2SkdFR1g4UUlHblVONTlDWk5DbmJGSytMbU4y?=
 =?utf-8?B?TlJrakJNcy9mTGtXRUhoYVVqdjlCZjgrZE9sUTJJNzhjMnBteWw5d2dpN1k0?=
 =?utf-8?B?K0ZNM1o5VnZlWFp3TForNkwyMXVjTVlkWVo1RE5tU3lOM3BkK0orbXlSMzBh?=
 =?utf-8?B?a095NE00SGN5NFhMbGxRUE90Y2U5TTBCaTBObFRRQUhKeHA2SWUxMThxSVlo?=
 =?utf-8?B?bW1nRENnYkJxVXdhRkJKelNzMjFhSUtNQXJHZEpHRzJvTldjTnZ1WFExV0NP?=
 =?utf-8?B?d1RCQkJLR1ZSclcrWDB2OFhVa3BNMU91ZGduSEV6RVdHR1FxSHRFOFp4MVQw?=
 =?utf-8?B?WllCMWJJaSs5Y3RqelhqMW9lTGRHT3dEaVlqVTFnSzhHQmhUQWI3YlBseU56?=
 =?utf-8?B?eGxIMzEzMnZ3bXpCclY3UVMyVWVNYWlsYld0cjV4WG9oQzB6WmlXcENtc3Jo?=
 =?utf-8?B?c2YxWkt1SEk4cm02dzJ6Q0hMS3NvdXN3enJ1TkdCYUc3bmk1Y1lHK1ZQSjBO?=
 =?utf-8?B?MU1RVXo2cGtIVVh5QlJHd0pvMTJrTXFaWlVTWnN4bmhVNVFxM3I0UUUxSmNS?=
 =?utf-8?B?S2pqU0pQbmZObEIzcFNoQ21wbVpaK0hLZjBKV1FtbVpDMEpMbDFGcFQ4Zk82?=
 =?utf-8?B?YXNlSFBDZzFEK290ZXVLL25MQnZUOGJmaHVhMHYySzFFQTluS1g3NDZoa0Zu?=
 =?utf-8?B?NDFXYm1RZlNXbHFZM2NwQkxmbS9KN2dMNkJhMll4RXA1MXd6TlJ3Qy9KTVcy?=
 =?utf-8?B?S201VmgyTzhRejhHWmxycjBjMFVzbS9RTXp1VmdEMTFjbndOSWtnQloxSE5l?=
 =?utf-8?B?eXFaYUo4anJUeWRtcFdXRy9RMFZ1aWRaSCtjT1d4b2FQQVVtZEJST2tRYmF0?=
 =?utf-8?B?a1hYRHp5TlFUcXhvSy9ReHlZdWxBR3dJdDB3dzBoWWkvcUVONjE3dzFxTWVz?=
 =?utf-8?B?Z0FWRTNMU0JDSnpBTkVjajJJUnVIOHlpdWJhQmRReERmRVlaMDJucW9hc2lz?=
 =?utf-8?B?L1VyczRESFIwOXdDeXJxM1lGemFtQ1dZUStkRXZOWlFFTEF3U09KRzd6eE1l?=
 =?utf-8?B?QUdoWm9UajA4aGFWL3ZINmJqeURNVnJCUVFQcHN3dlM5SlBCeW53bTdtS3p6?=
 =?utf-8?B?QXlkejZGd2V3RFE4eDdmWGZiMUFpRXNmd055TVg2UDR5ajNRa0dlQUpENDdx?=
 =?utf-8?B?UmNCSjVGNHFyeXUxZ1pYSXZaL2M1dmRuZnluOC9hait1RVNwZTk1N3JiSGxZ?=
 =?utf-8?B?OEpLNmp5RXJxL2dxb1ptZ1BLZVgvY3NHVzU3SEFUMXRwM011ME92ZXBwRVM2?=
 =?utf-8?B?cEhOcUppamNiYWVaQmtrQncxa1RFOG5Yam0rUDJ6RW1VUWZlZ0I1bFZmVDVk?=
 =?utf-8?B?UEdocDFiclJrMmxTU3ErQjNXVjBzQ0hXSmdKNFNucmhWcFFhaENjZUZ5cXAr?=
 =?utf-8?B?S1YzL0RRV05BVEpkT05yL2VlVkE5RTltNmM5cWYxRTNaYjdxNm44aUE4cXA5?=
 =?utf-8?B?b2tScUdBdjlxeG1sOE1SbXFneFd4bk0xbjh5SnpFejlMZU9hc3ZyTW9YYlR2?=
 =?utf-8?Q?fd/tcAoFyUOJ1PVrnK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB484752.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165c4a09-feb1-4ebd-104a-08df40935a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 08:02:52.5222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1UI+395WiuUrUrhlOjbVGRKB3OZBDXasj8DK5mbYxC7hifj5adRzshZk5BecfH/UrQzNoqrK6JeMYoJ2sLcjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9570

DQo+IA0KPiBPbiAxMS8xMi8yNiAwNToxOSwgU2hlcnJ5IFN1biAoT1NTKSB3cm90ZToNCj4gPiBG
cm9tOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4NCj4gPiBscHVhcnQzMl9z
ZXRfdGVybWlvcygpIHJlYWRzIFVBUlRDVFJMIGF0IGZ1bmN0aW9uIGVudHJ5IHdpdGhvdXQNCj4g
PiBob2xkaW5nIHRoZSBwb3J0IGxvY2suIGxwdWFydDMyX2NvbnNvbGVfd3JpdGUoKSBjYW4gcnVu
IGNvbmN1cnJlbnRseQ0KPiA+IG9uIGFub3RoZXIgQ1BVIGFuZCB0ZW1wb3JhcmlseSBjbGVhcnMg
dGhlIFJJRSAoUmVjZWl2ZXIgSW50ZXJydXB0DQo+ID4gRW5hYmxlKSBiaXQgd2hpbGUgaXQgcG9s
bHMgY2hhcmFjdGVycyBvdXQuIElmIHRoZSB1bmxvY2tlZCByZWFkIGluDQo+ID4gc2V0X3Rlcm1p
b3MgbGFuZHMgaW5zaWRlIHRoYXQgd2luZG93LCB0aGUgc3RhbGUgc25hcHNob3QgaXMgd3JpdHRl
bg0KPiA+IGJhY2ssIHBlcm1hbmVudGx5IGNsZWFyaW5nIFJJRS4gT25jZSBsb3N0LCBubyBub3Jt
YWwgY29kZSBwYXRoDQo+ID4gcmUtZW5hYmxlcyB0aGVtLCBzbyB0aGUgVUFSVCBzdG9wcyByZWNl
aXZpbmcgY2hhcmFjdGVycyBhbmQgYmVjb21lcw0KPiB1bnJlc3BvbnNpdmUuDQo+ID4NCj4gPiBO
ZWVkIHRvIGFkZCBwb3J0IGxvY2sgZm9yIHRoZSByZWdpc3RlcnMgcmVhZCBpbiBscHVhcnQzMl9z
ZXRfdGVybWlvcygpDQo+ID4gdG8gYXZvaWQgdGhlIHVubG9ja2VkIHNuYXBzaG90IGNhcHR1cmVk
LiBTaW5jZSBuZWl0aGVyDQo+ID4gdWFydF9nZXRfYmF1ZF9yYXRlKCkgbm9yIGxwdWFydF9kbWFf
cnhfZnJlZSgpIHVzZXMgY3RybCwgb2xkX2N0cmwsIGJkLA0KPiA+IG9yIG1vZGVtLCB0aGUgcmVn
aXN0ZXIgcmVhZHMgYW5kIGJpdCBtYW5pcHVsYXRpb25zIGNvdWxkIGJlIG1vdmVkIGludG8NCj4g
PiB0aGUgZXhpc3RpbmcNCj4gPiB1YXJ0X3BvcnRfbG9ja19pcnFzYXZlKCkgY3JpdGljYWwgc2Vj
dGlvbiBhZnRlciBscHVhcnRfZG1hX3J4X2ZyZWUoKS4NCj4gPg0KPiA+IFBsZWFzZSBub3RlIHRo
YXQgdGhpcyBvbmx5IGZpeCB0aGUgbm9ybWFsIHByaW50ayBwYXRoLCBpbiB0aGUNCj4gPiBvb3Bz
X2luX3Byb2dyZXNzIHBhdGggb2YgbHB1YXJ0MzJfY29uc29sZV93cml0ZSgpLCB3aGVuIHRyeWxv
Y2sgZmFpbHMsDQo+ID4gUklFIGlzIGNsZWFyZWQgYW5kIG9sZF9jciByZXN0b3JlZCB3aXRob3V0
IHRoZSBwb3J0IGxvY2sgaGVsZCwgdGhlcmUNCj4gPiBpcyBzdGlsbCBhIHJpc2sgb2Ygc3RhbGUg
c25hcHNob3QsIGJ1dCBpdCdzIGFjY2VwdGFibGUgZm9yIHRoZQ0KPiA+IHBvc3Qtb29wcyBzdGF0
ZSBhbmQgdGhlIHRyeWxvY2stZmFpbCB3aW5kb3cuDQo+ID4NCj4gPiBGaXhlczogMzgwYzk2NmMw
OTNlICgidHR5OiBzZXJpYWw6IGZzbF9scHVhcnQ6IGFkZCAzMi1iaXQgcmVnaXN0ZXINCj4gPiBp
bnRlcmZhY2Ugc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5
LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBBcyBzdWdn
ZXN0ZWQgYnkgU2FzaGlrbywgc2luY2UgbmVpdGhlciB1YXJ0X2dldF9iYXVkX3JhdGUoKSBub3IN
Cj4gPiAgIGxwdWFydF9kbWFfcnhfZnJlZSgpIHVzZXMgY3RybCwgb2xkX2N0cmwsIGJkLCBvciBt
b2RlbSwgbW92ZSB0aGUNCj4gPiAgIHJlZ2lzdGVyIHJlYWRzIGFuZCBiaXQgbWFuaXB1bGF0aW9u
cyBpbnRvIHRoZSBleGlzdGluZw0KPiA+ICAgdWFydF9wb3J0X2xvY2tfaXJxc2F2ZSgpIGNyaXRp
Y2FsIHNlY3Rpb24gYWZ0ZXIgbHB1YXJ0X2RtYV9yeF9mcmVlKCkuDQo+ID4gLSBMaW5rIHRvIHYx
Og0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjExMTEtbHB1YXJ0X3BvcnRfbG9j
ay12MS0xLTVkMzMyYzUxZWRmZUANCj4gPiBueHAuY29tDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
dHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgfCAyOSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0K
PiA+IGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyBpbmRleCBjZDI1NzVhM2FlZjcu
LjA3NGJkOWQ0MmY4NA0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9m
c2xfbHB1YXJ0LmMNCj4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+
ID4gQEAgLTIyNDEsNiArMjI0MSwyMCBAQCBscHVhcnQzMl9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFy
dF9wb3J0ICpwb3J0LA0KPiBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pb3MsDQo+ID4gIAl1bnNpZ25l
ZCBpbnQgIGJhdWQ7DQo+ID4gIAl1bnNpZ25lZCBpbnQgb2xkX2NzaXplID0gb2xkID8gb2xkLT5j
X2NmbGFnICYgQ1NJWkUgOiBDUzg7DQo+ID4NCj4gPiArCS8qIGFzayB0aGUgY29yZSB0byBjYWxj
dWxhdGUgdGhlIGRpdmlzb3IgKi8NCj4gPiArCWJhdWQgPSB1YXJ0X2dldF9iYXVkX3JhdGUocG9y
dCwgdGVybWlvcywgb2xkLCA1MCwgcG9ydC0+dWFydGNsayAvDQo+ID4gKzQpOw0KPiA+ICsNCj4g
PiArCS8qDQo+ID4gKwkgKiBOZWVkIHRvIHVwZGF0ZSB0aGUgUmluZyBidWZmZXIgbGVuZ3RoIGFj
Y29yZGluZyB0byB0aGUgc2VsZWN0ZWQNCj4gPiArCSAqIGJhdWQgcmF0ZSBhbmQgcmVzdGFydCBS
eCBETUEgcGF0aC4NCj4gDQo+IFdoaWxlIHlvdSBhcmUgaGVyZSBwbGVhc2UgZml4IHRoZSB0eXBv
LiBzL2FjcXVyZXMvYWNxdWlyZXMuPiArCSAqDQoNCk9rLCB3aWxsIGZpeCBpbiBWMy4NCg0KQmVz
dCBSZWdhcmRzDQpTaGVycnkNCg0KPiA+ICsJICogU2luY2UgdGltZXIgZnVuY3Rpb24gYWNxdXJl
cyBwb3J0LT5sb2NrLCBuZWVkIHRvIHN0b3AgYmVmb3JlDQo+ID4gKwkgKiBhY3F1cmluZyBzYW1l
IGxvY2sgYmVjYXVzZSBvdGhlcndpc2UgdGltZXJfZGVsZXRlX3N5bmMoKSBjYW4NCj4gZGVhZGxv
Y2suDQo+ID4gKwkgKi8NCj4gPiArCWlmIChvbGQgJiYgc3BvcnQtPmxwdWFydF9kbWFfcnhfdXNl
KQ0KPiA+ICsJCWxwdWFydF9kbWFfcnhfZnJlZShwb3J0KTsNCj4gPiArDQo+ID4gKwl1YXJ0X3Bv
cnRfbG9ja19pcnFzYXZlKHBvcnQsICZmbGFncyk7DQo+ID4gIAljdHJsID0gb2xkX2N0cmwgPSBs
cHVhcnQzMl9yZWFkKHBvcnQsIFVBUlRDVFJMKTsNCj4gPiAgCWJkID0gbHB1YXJ0MzJfcmVhZChw
b3J0LCBVQVJUQkFVRCk7DQo+ID4gIAltb2RlbSA9IGxwdWFydDMyX3JlYWQocG9ydCwgVUFSVE1P
RElSKTsgQEAgLTIzMjAsMjEgKzIzMzQsNg0KPiBAQA0KPiA+IGxwdWFydDMyX3NldF90ZXJtaW9z
KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcywNCj4gPiAg
CQljdHJsICY9IH5VQVJUQ1RSTF9QRTsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JLyogYXNrIHRoZSBj
b3JlIHRvIGNhbGN1bGF0ZSB0aGUgZGl2aXNvciAqLw0KPiA+IC0JYmF1ZCA9IHVhcnRfZ2V0X2Jh
dWRfcmF0ZShwb3J0LCB0ZXJtaW9zLCBvbGQsIDUwLCBwb3J0LT51YXJ0Y2xrIC8gNCk7DQo+ID4g
LQ0KPiA+IC0JLyoNCj4gPiAtCSAqIE5lZWQgdG8gdXBkYXRlIHRoZSBSaW5nIGJ1ZmZlciBsZW5n
dGggYWNjb3JkaW5nIHRvIHRoZSBzZWxlY3RlZA0KPiA+IC0JICogYmF1ZCByYXRlIGFuZCByZXN0
YXJ0IFJ4IERNQSBwYXRoLg0KPiA+IC0JICoNCj4gPiAtCSAqIFNpbmNlIHRpbWVyIGZ1bmN0aW9u
IGFjcXVyZXMgcG9ydC0+bG9jaywgbmVlZCB0byBzdG9wIGJlZm9yZQ0KPiA+IC0JICogYWNxdXJp
bmcgc2FtZSBsb2NrIGJlY2F1c2Ugb3RoZXJ3aXNlIHRpbWVyX2RlbGV0ZV9zeW5jKCkgY2FuDQo+
IGRlYWRsb2NrLg0KPiA+IC0JICovDQo+ID4gLQlpZiAob2xkICYmIHNwb3J0LT5scHVhcnRfZG1h
X3J4X3VzZSkNCj4gPiAtCQlscHVhcnRfZG1hX3J4X2ZyZWUocG9ydCk7DQo+ID4gLQ0KPiA+IC0J
dWFydF9wb3J0X2xvY2tfaXJxc2F2ZShwb3J0LCAmZmxhZ3MpOw0KPiA+IC0NCj4gPiAgCXBvcnQt
PnJlYWRfc3RhdHVzX21hc2sgPSAwOw0KPiA+ICAJaWYgKHRlcm1pb3MtPmNfaWZsYWcgJiBJTlBD
SykNCj4gPiAgCQlwb3J0LT5yZWFkX3N0YXR1c19tYXNrIHw9IFVBUlRTVEFUX0ZFIHwgVUFSVFNU
QVRfUEU7DQo+ID4NCj4gPiAtLS0NCj4gPiBiYXNlLWNvbW1pdDogNzkzODA3Y2ExM2JmMzA3MmZj
NmQxNmNlNmQ5MGU5YWI5YmVmZjJhNQ0KPiA+IGNoYW5nZS1pZDogMjAyNjExMTEtbHB1YXJ0X3Bv
cnRfbG9jay0wMWY3ZGVhYjQ1MWENCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCg0K
