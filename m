Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2126.outbound.protection.outlook.com [40.107.6.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B817C96;
	Wed,  5 Jun 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.126
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586368; cv=fail; b=C9OTeuD8CqZQ5bIEP43fQwDDWAdjYaXNAY9iyx/lF/pxy9P1riXFRQZWP/x/I5iEFt/0Y9Mt97wEuobsVU8IlmHZANtQdMjyZkJEEOuTuBLYi+7nLngaO5gkQRtH661mcJIf2ayb3sIQapEhCbVI5cr6FuKkAB818CvdJFFqQV0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586368; c=relaxed/simple;
	bh=ruhY6/bpDByWoONYndH8VbYpIQCkAKCr2uA/KVjMCLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b0Ok3G/1VvNZI8lLv8SoJSbUIAtBiyccnZSgFDr4hIvqk81//vuiFIBii3EJ6zrShgeeShYw3NPWBxWjqgB+8Tda/mQI3YFVzfzIJg///CiXSMlcpIF8cHGptBy5u9Afs0RIKqup0EK0BBQ3RPcKpIUWVacHCqEcxNKaumbW7kA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=L/V5BkA5; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=L/V5BkA5; arc=fail smtp.client-ip=40.107.6.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="L/V5BkA5";
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="L/V5BkA5"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=EtRwDDyEANo4uvj0HttyZXGa1XwVcIswkxdspFiFMr+nqoBPjC8DbDEDYlQutEc0ZtAg4SyHAfu8xKm81ujavBdOGHCcUGeKolFv1mPBY0HiJMebKNfZqhQW+kwm1WHsAB+VpoXxZrNlcUZnLjtJpjXMCD7XfFpbxed47yLtN/L/x3tqPJL2eoHBJZT2jG/gV/LJhkRB792GNlEWig5JrlrO8XBghoaYTXLFsAv9YQWxr2415c5GqH/vhhRuk4Koq4qUELY6L7xTIysNRh+P4EcPnp77vbjqxuDPr/QDFCwbG1VITznBRbwzGEX5Wg7fbQCyBkoqaoDYd9SfjLuCnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruhY6/bpDByWoONYndH8VbYpIQCkAKCr2uA/KVjMCLI=;
 b=AjYMHTvbTv852hXva5YotqmN3XLXeft+n1wDvyJdHtKNVBzUOMfgSr8wu27+bwV+/vnhCTkLewc9u9PUjpMSQ4pp9ZDNmDkfEKJ6mUqsNVOe2AIDrrQUiQxQi62RGz1QL+8uHVBTIgSsGNJ9JRIcf/W8TS/EDTIGi5oZuBFd+CHdG1OD1+BAAKg6MXQH1IQCYa7AqIrUpXmg9nuJbW4iQzVLcvpe/ba4fT3ya+xU+KcCNLYhBVd0To55onz/hNxwxFxLCZ9HN6zhOiANWf+YKhuhMnRUqeTBHLbXnnq2oOTaPUvIJSDlEFBD7DHw/u5xXxavYcfVGvCjn9N31s19yA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=canonical.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=pass (signature was verified) header.d=sttls.nl; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sttls.nl] dkim=[1,1,header.d=sttls.nl]
 dmarc=[1,1,header.from=sttls.nl])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruhY6/bpDByWoONYndH8VbYpIQCkAKCr2uA/KVjMCLI=;
 b=L/V5BkA59dH2M5uRQoJg3p7PwWGY+jV/xUf8bMYJI65icSzTYO032+da1yyB2Hp7CDZbqpa0l1BaBLawH7uLxXjP9XKkDwH6JgUrn5Fws3o24y2zyzSO3bBBYXCY8X0HqDAm+l1Nc/EMMB8L9dNpNuqb79gSBmoXMtScVA7cHFCWc1tiNTuWdDoqXCj4fHd0qDDr4+jrRM9P8WXom0DEqyz6xsYVtkRvtfNFA1GP6Rqlcj8XwPXZSL96sl6AGTwG5+la6Rt6I8Ngu/iCZ/oSSb6uLV5WqwHgdobtVdzhfPzWTHUveBLDyAORd9vPR9Bx8aNpyDJ6Q/dCe29E5D+RlA==
Received: from AM0PR04CA0029.eurprd04.prod.outlook.com (2603:10a6:208:122::42)
 by AS1PR05MB9516.eurprd05.prod.outlook.com (2603:10a6:20b:4d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 11:19:22 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:208:122:cafe::52) by AM0PR04CA0029.outlook.office365.com
 (2603:10a6:208:122::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 11:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=pass (signature was verified)
 header.d=sttls.nl;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 11:19:22 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.110) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 05 Jun 2024 11:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw1FeyrDou/0MQ2MMoDjq4HgYsZdsuG8ukyC8MQVxPIpeqGFov9w8vV2e6XSNNTNTU+c0aRW/dluGKjk+H3fK82vui582PMfY6HfoCh39yjIXLLVNMM9Cy+WiGKy6j3o0Y4ZzszRVBJ87zSgcnCQ+t7WONyKSl6TIARZsamB0P5i+mHkP8TAbD2PCHLzoEIrmn8cDPWkJnVFnTvHgaDTyzxKELc7LcJyoLBaVU0i0yiBuuZk8TLiUYcAvDkSyMZoBv7vIjvxKEdWsynGRdIpaJ2vFuY/duiXcp8j2MION6Uji7VO5D67nCkXzNIn/YYvQb45FdEVwWWt+L5/FnhpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruhY6/bpDByWoONYndH8VbYpIQCkAKCr2uA/KVjMCLI=;
 b=aeui2ejOqdbLhQkddS9yl2B09LELtlDjEmLL7UDR1Ot2ZFE4QraLdk2je3D0SIpCcLCP+hCRlh0mws0vq270rURyyxvIw6tUl6tN6hHMANcULMpighO+aYMYTxIGCQeONwYY9huQfN4r4kn5tbwpSZ01hw65sG2i9yj+Bpqye03gXKXS4o4eh8Q/Ov2uPPOySVEdu5yylSkXNw7y1nlYVHjfnhRbu2xUn0cuJIZsEL1ptVlQagJZ4b3J1KWwafbGADqwoeo77RUg4wJ+YIiczSwONDO9Z4H+RPpLgFaeIQg3ONNzYXEkpcvGQ73rB7jG26+Q0n6gubIUcbFx4XfzfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sttls.nl; dmarc=pass action=none header.from=sttls.nl;
 dkim=pass header.d=sttls.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruhY6/bpDByWoONYndH8VbYpIQCkAKCr2uA/KVjMCLI=;
 b=L/V5BkA59dH2M5uRQoJg3p7PwWGY+jV/xUf8bMYJI65icSzTYO032+da1yyB2Hp7CDZbqpa0l1BaBLawH7uLxXjP9XKkDwH6JgUrn5Fws3o24y2zyzSO3bBBYXCY8X0HqDAm+l1Nc/EMMB8L9dNpNuqb79gSBmoXMtScVA7cHFCWc1tiNTuWdDoqXCj4fHd0qDDr4+jrRM9P8WXom0DEqyz6xsYVtkRvtfNFA1GP6Rqlcj8XwPXZSL96sl6AGTwG5+la6Rt6I8Ngu/iCZ/oSSb6uLV5WqwHgdobtVdzhfPzWTHUveBLDyAORd9vPR9Bx8aNpyDJ6Q/dCe29E5D+RlA==
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com (2603:10a6:20b:5c2::16)
 by AM7PR05MB6630.eurprd05.prod.outlook.com (2603:10a6:20b:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 11:19:20 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734]) by AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734%2]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 11:19:20 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Hui Wang <hui.wang@canonical.com>, Hugo Villeneuve <hugo@hugovil.com>
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
Thread-Index: AQHatoMSmrKlXbpByE24p7W3ELDzzLG3qHyAgAFOd4CAAAm5AIAAA00w
Date: Wed, 5 Jun 2024 11:19:20 +0000
Message-ID: <AS8PR05MB98104348D77097F60396B82883F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <20240604132726.1272475-2-hui.wang@canonical.com>
 <20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
 <AS8PR05MB9810940582493046F2FBFDB983F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
 <f56a2c59-9ae4-4d5c-8321-fff9639c5405@canonical.com>
In-Reply-To: <f56a2c59-9ae4-4d5c-8321-fff9639c5405@canonical.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AS8PR05MB9810:EE_|AM7PR05MB6630:EE_|AM4PEPF00027A67:EE_|AS1PR05MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: e83040a3-b04d-4311-3b51-08dc855159b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZmhnUTg0Vi9OTFVvNTRqZUY1OFVyZi9XSXpqMTQyejNTcGIxSkdFK2tLWUwy?=
 =?utf-8?B?ZHYwbGlUaEZKUThjU2psZTZsUTNRc3hpZ3BiRXZXTXhXeVo4VnA3TXdjdlh3?=
 =?utf-8?B?UFpYa242Qk5EWklqVHZGOC9EM28vR3VTM3hWVXdTSXlXMHJyaGdHTy91Mjhh?=
 =?utf-8?B?KzVodWptekJUM2ZLMW9uOWtJYy96UlhlekJnWjczajNrdmNKTzc5K3Jra1dK?=
 =?utf-8?B?TDJNdmVHNmZtT1FPZlAwc2RuRjlkMzNBdUI0ZnFCeWZ3R0xzbU5uNzMwS0Q0?=
 =?utf-8?B?Nk92dGlFOWJoMUpNVnRoR2RjNHdsRENJeTRBd3lVZm9yZ3Jtb0Q2N3dBM3Rq?=
 =?utf-8?B?Y09mc2tWN1RFOVp1UWd3a2pBZExNNzl4UW90amdtTk4zWHIyYnFpdUlscnhS?=
 =?utf-8?B?TDNickRwVzB0K1RtM1M3MWdEcXpGaE9WQ1JXM29IeGZ4SGFmUUdjaU9RVi9q?=
 =?utf-8?B?eEdDN0ZiSzJuK1gyVkRqajhlQlNtTWxzeWJJQzVEZWtEUkhVcGJQUWRvQjl6?=
 =?utf-8?B?c1VFcmhMYjBobThuVk5NdkRaV216eG1za001enQzMCtKa05YYzJtRmJBM1pp?=
 =?utf-8?B?S1hJcllDMGE1bTNJRjNKa09BZ0JOSWlaMWFKa3ozaGFUUHZlbGdEclh1TGV4?=
 =?utf-8?B?ZmNZVTlFTG5EUXNUeFgrZXJyZmdnRlhHank0Vlo2S0IrckdvZFVOek5aWi9L?=
 =?utf-8?B?cEtnak52d2hTUS9BY3RlRW9yUXRMY1JOTVZ0Slg3bklabUI5dWZLN1NOazdy?=
 =?utf-8?B?TkQ2YVRCdk9ocmlrTUh5WFNCb2ZuUlFVcEJYNDNqczBRbUlqRXJPdGE0N1g2?=
 =?utf-8?B?OEkyVFlvaTB0eVdiTWl2QlJSVXVqQ09xcEVTMURIdHhqVGNCUU1wTnFpUS92?=
 =?utf-8?B?MjVNUnJCQUcvcFl3ZDFCckJRUHpxLzR4RGJ4V1VwS09jd2pYSW45bCtYb2d6?=
 =?utf-8?B?R25BbE5uMlk4dUNhNm9YWVM3ZVBxV3VjR2xaVU93MWxmUFhwcnZmUzVXSThG?=
 =?utf-8?B?VmMrY0ZCeUI2OGJaQnJuWG56N3FESUkrTjIzK09aZkJNQXloVjFscDRXYVI0?=
 =?utf-8?B?MnA1and0a3lOTURHaVptdFJwTE4rbXh5QzlKMlV4QjJjdFQ2SEN4NTBHT1Nv?=
 =?utf-8?B?cE9uckxOTkpZS0VsK0crU2ZiODFFTkNKaVE4MjE2MTFtREgwQ2dibVQrY0E3?=
 =?utf-8?B?ZUx4M3Fsdm53MTk1U1BKK2ZoNXpCWVZpRGI5dHFsK2d6eGhDOWJEdC9UOGR2?=
 =?utf-8?B?b3VHRFZ4azJ4YkdxK2NlTzMzOE1TeWJvTXgyY2dHcnErWTV3M1ZSdTVVYTZN?=
 =?utf-8?B?M09PZHBkRUhNUGxEenZBVm9PWFN4cDFSWm0zUlpwU3lKblhRZENSUUVIcjlX?=
 =?utf-8?B?c2dKazh4b1dIckNFRVl2L3ZNU0U3WnVsRjN5cjRBYTJEcC93V015SGkyeHFk?=
 =?utf-8?B?SnJEMEhqcVhyQ3g0OWIwTGVQdWV6eTdXS3JKUUg5ZXlXM2ZLZzk5VUk4Q1hS?=
 =?utf-8?B?YzVhQzF6YkZrazlma2lYZGovcC9Eb2M4UUV0cFdZUWxsaXRHM1drdERRYWlX?=
 =?utf-8?B?cEJtN2tkWmpIalhuS29NbjBzcHJoS3dRQ1NNTzJoMEpNaGYwUkdGS1FLUFc4?=
 =?utf-8?B?amRrWnVoSkhGQ2ZscFU3QkNUTHRqb2pLODY5Y2trd2h5OE0yYUNWMzFnZ3hk?=
 =?utf-8?B?WFJIaTFTY09JZkZhRVZ4UUFWb1VMNDVLQW96ZkpqMklsazFBQWtMU2s2Um5t?=
 =?utf-8?B?dWtIZnM5dGptQW9oM2pTSnpmanpmNktYU2xHU0pnblJWWlBwTE54RVUrckF0?=
 =?utf-8?Q?TIPdMYLBQrol+ja2Y9qFlgIKmMra3Ekmc9DVg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB9810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6630
X-CodeTwo-MessageID: 0c563e3b-4581-4cea-8917-1c6266d9442f.20240605111921@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5cfbe948-f157-4a2b-ec8f-08dc8551589a
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|35042699013|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzFjMWtqd2I4OHNjZW5BKzBNSmhlUExkM25kYkVQZ1YwMGhESkMza3VicFIx?=
 =?utf-8?B?eTdZaElxa3BwbkZGRmFtaWMvcUJtY01RcXBvc01WSmpHQnFpMVdXemE1RzhJ?=
 =?utf-8?B?K2pPTWhOSmtmWWY3MHVkZFVKdy83TXIvTmt3blFQK1Z0ME5iSG1qSkFKN2t2?=
 =?utf-8?B?MGZiS2NGaVN2cEpNeTcyWU0xaGZDSlkyaUZ1anVTZG5yRm5YK01nNWpnMjJv?=
 =?utf-8?B?NlBxRG5Za1hmUzFSMzZDZGtPdXJob1JSMEhLeG9peUZMcU8zdFdYYVk5WVVH?=
 =?utf-8?B?QlZCTXgxZDlFVGw4ejc2U2J1VEY5N3NNdnloNVdyQ0llTUVjVnFCYmo5VzN1?=
 =?utf-8?B?bEZubXJWSTdoSlBmR2lNQUNaWGVWY0lXWWNOZ2JOS2d1OWNaVzZWME1MUDFu?=
 =?utf-8?B?Y2l2MUc3bmNJRGptM3h6NERlclVrWG1VQzNEanpHS1o2RWJoVkxIL0pNd0pI?=
 =?utf-8?B?YnlUOXZBRURuYlFmV3F1MDZSYnprWk92WUlWT1g4REw1aVdTZFR2eGQyTXpD?=
 =?utf-8?B?dWR0L2dCTWVSbW1PZkltZnNzL0ZYUy9DTU9GQ1pFd3dWd2w1OGdESFVQUW5B?=
 =?utf-8?B?ZklXcXQvMWNVTFpJUjRZNnNwN0NWczZkalVZU2ZvcXl2S090ZkZETDN5OHho?=
 =?utf-8?B?RDhhUmFUS3k3MGR6Q3FTYk1yZHowMUtvYk9jSjBXY0lyb2M2UXpkTFVMUXpj?=
 =?utf-8?B?SVVyTWI1MVZ6UkJud0pJUE8zRGFIa1RmdGV3TnpMaGJCTm8vQ2pNK0ZUNkQr?=
 =?utf-8?B?cHhPVVNaNXF5ZnVSV3FZdXhGcmtPR3dIb1hnOWhuZmRBTDVaQTc5eXBmdHRE?=
 =?utf-8?B?UnFIeUs4OHVNdHV2U2RoS1Q4YmVhQkM1aFc5REJwaEFUZGVSM1crWlc2U0Fl?=
 =?utf-8?B?LzRIR2F2QUJEeVFVemZjd0FLZUdTcFBTUUtSTnROWG9mTDV1TUtpU2dXamhF?=
 =?utf-8?B?eG5aeXYzb0hkRGJTUk1TY3VOdU95VGliWGFrZEJuZUdYK3ZJWmk3ZDVQZFVO?=
 =?utf-8?B?NVhqQm5ZZmtidjByblNCMjFtSlA2bDVVdTVzWUxOTm5PL1Jmc1A2eXFZUm1h?=
 =?utf-8?B?L2pEekJFOWxmS1pqSmdQdXI3U1ZKTll5aVg1VGVmdjFwN3ZSMStybHd6RElU?=
 =?utf-8?B?b3hiSlZXeFBzbTV3akFYYndKTDN2bzNyUXZnNFU0WCtGZkx3SFhHZC8xTTRB?=
 =?utf-8?B?aldLeWZiUTlYemd1WGdwM1JtcDBnMjhQM1ByYzBpY0FPNlh3K3BsTGhZbUpU?=
 =?utf-8?B?TkN5NFYvbG5ERTNpVmtmYzQ2dU00SEVBWEp6UVp6b29QOTJDdzVndXgrZDlq?=
 =?utf-8?B?a3N4OCtVTjNVTXZsOWtzb3Y0SFRUR3lvNmplTklOakt1UzljdWprTHZOVVU5?=
 =?utf-8?B?cm9jc1BwRWJndk5nK2s1Q1lqdHFYczdGLzRsbFF5N0ZzSDRveG5DT2RMNi9I?=
 =?utf-8?B?dFljdHUyOWVMZ0ovcnhENWpuR0wwUDl0VGh1QU50K0ZzZ2g5MkRsbDhlTlJ5?=
 =?utf-8?B?VE1MOExwU2VzK0hBdDJoajBYaEY4NkhULzA3amlQNTZHTUpoNHdNc2ZEcGVI?=
 =?utf-8?B?ekNSb25MeHB5Rk9QemZTMkF6a3BZWm81N2g4TGdqb0NjOFpGYXlMZCtlTzVD?=
 =?utf-8?B?WmExODBwNzZJZUJjOWx4dFVDRjhmd2lDd1lRYUo4RjRBL20rYW5pSmFYbEk2?=
 =?utf-8?B?bG1xbVlpK05ock1NL1JsNTM4RHpJZ0t4SnprV0hlK2RaclpucU96clYyUURy?=
 =?utf-8?B?ZVhoRWJzK2ZsNVc4WVRQSWM5T20zOUk2aGRGMkhmaFo3R2wyRHo2Z1pCN2hr?=
 =?utf-8?B?NTdRdENsbUpQRSt0R0dWRVFtZ0pIaHhGY1g1MFE0Q3RHNDN6RVJjbTVITTNJ?=
 =?utf-8?B?RG96T1R6RElaVldjeHRkdWxSMmV6bmZraklJQnVoSWh2M1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(7416005)(35042699013)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 11:19:22.3037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e83040a3-b04d-4311-3b51-08dc855159b5
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR05MB9516

PiBPbiA2LzUvMjQgMTg6MzAsIE1hYXJ0ZW4gQnJvY2sgd3JvdGU6DQo+ID4+IEZyb206IEh1Z28g
VmlsbGVuZXV2ZSA8aHVnb0BodWdvdmlsLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgNCBKdW5l
IDIwMjQgMTY6MjMNCj4gPiA8Li4uPg0KPiA+DQo+ID4+IEFkZCBmdW5jdGlvbiBkZXNjcmlwdGlv
biBmcm9tIG9yaWdpbmFsIGNvbW1lbnQgIlJlc2V0IGRldmljZSwNCj4gPj4gcHVyZ2luZyBhbnkg
cGVuZGluZyBpcnEgLyBkYXRhIiwgc2luY2UgdGhlIGNvbW1lbnQgYXBwbGllcyB0byBib3RoDQo+
ID4+IGhhcmR3YXJlIGFuZCBzb2Z0d2FyZSByZXNldCwNCj4gPiBObyBpdCBkb2VzIG5vdCAoYXQg
dGhpcyBtb21lbnQpLiBTZWUgYmVsb3cuDQo+ID4NCj4gPj4+ICtzdGF0aWMgaW50IHNjMTZpczd4
eF9yZXNldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCByZWdtYXAgKnJlZ21hcHNbXSkNCj4g
Pj4gU2ltcGx5IHBhc3MgInN0cnVjdCByZWdtYXAgKnJlZ21hcCIgYXMgdGhlIHNlY29uZCBhcmd1
bWVudC4gU2VlDQo+ID4+IHNjMTZpczd4eF9zZXR1cF9tY3RybF9wb3J0cygpIGZvciBleGFtcGxl
Lg0KPiA+Pg0KPiA+Pj4gK3sNCj4gPj4+ICsJc3RydWN0IGdwaW9fZGVzYyAqcmVzZXRfZ3Bpb2Q7
DQo+ID4+IHJlc2V0X2dwaW9kIC0+IHJlc2V0X2dwaW8NCj4gPj4NCj4gPj4+ICsJZWxzZSBpZiAo
IUlTX0VSUihyZXNldF9ncGlvZCkpIHsNCj4gPj4+ICsJCS8qIGRlbGF5IDUgdXMgKGF0IGxlYXN0
IDMgdXMpIGFuZCBkZWFzc2VydCB0aGUgZ3BpbyB0byBleGl0IHRoZSBoYXJkDQo+ID4+IHJlc2V0
ICovDQo+ID4+DQo+ID4+IFlvdSBjYW4gb21pdCB0aGUgImRlbGF5IDUgdXMiIHNpbmNlIGl0IGlz
IG9idmlvdXMgZnJvbSB0aGUgY29kZS4gTWF5YmUNCj4gPj4gYWRkIHRoYXQgIlRoZSBtaW5pbXVt
IHJlc2V0IHB1bHNlIHdpZHRoIGlzIDMgdXMiIGFzIHN0YXRlZCBpbiB0aGUNCj4gPj4gZGF0YXNo
ZWV0Lg0KPiA+Pg0KPiA+PiBBcyBhIGdlbmVyYWwgbm90ZSBmb3IgeW91ciBjb21tZW50czogY2Fw
aXRhbGl6ZSB0aGUgZmlyc3QgbGV0dGVyLA0KPiA+PiBleDogIkRlYXNzZXJ0IEdQSU8iIGFuZCBu
b3QgImRlYXNzZXJ0IEdQSU8iLg0KPiA+Pg0KPiA+Pg0KPiA+Pj4gKwkJdWRlbGF5KDUpOw0KPiA+
Pj4gKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJlc2V0X2dwaW9kLCAwKTsNCj4gPj4gTW92
ZSB0aGUgY29tbWVudCAiZGVhc3NlcnQgdGhlIGdwaW8gdG8gZXhpdCB0aGUgaGFyZCByZXNldCIg
aGVyZS4gWW91DQo+ID4+IGNvdWxkIGFsc28gc2ltcGxpZnkgaXQgYXMgIkRlYXNzZXJ0IEdQSU8u
Ii4NCj4gPiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgdGhpcyBvbmx5IGRlYXNzZXJ0cyB0aGUg
cmVzZXQgaWYgaXQgd2VyZSBhc3NlcnRlZCBiZWZvcmUuDQo+ID4gTm90aGluZyBoYXBwZW5zIGlm
IGl0IGFscmVhZHkgd2FzIGRlYXNzZXJ0ZWQuIFRoaXMgbWFrZXMgdGhlIGRlbGF5IGFsc28gcHJl
dHR5DQo+ID4gdXNlbGVzcy4NCj4gPg0KPiA+IFRvIG1ha2UgdGhpcyBhIHByb3BlciByZXNldCBw
dWxzZSBmb3IgdGhlIGRldmljZSB5b3UgbXVzdCBmaXJzdCBhc3NlcnQgdGhlIHJlc2V0LA0KPiA+
IHRoZW4gd2FpdCA+M3VzLCBhbmQgZmluYWxseSBkZWFzc2VydCB0aGUgcmVzZXQuDQo+ID4NCj4g
PiBNYWFydGVuIEJyb2NrDQo+IEhpIE1hYXJ0ZW4sDQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIGlz
IHdoZW4gY2FsbGluZyBkZXZtX2dwaW9kX2dldF9vcHRpb25hbChkZXYsICJyZXNldCIsDQo+IEdQ
SU9EX09VVF9MT1cpIGFuZCByZXR1cm5pbmcgYSB2YWxpZCAoZ3Bpb19kZXNjICopLCB0aGUgZmxh
Zw0KPiBHUElPRF9PVVRfTE9XIGd1YXJhbnRlZXMgdGhlIEdQSU8gaXMgc2V0IHRvIG91dHB1dCBh
bmQgbG93IChhc3NlcnQgdGhlDQo+IHJlc2V0IHBpbikuDQoNCkFoLCByaWdodC4gU29ycnksIEkg
bWlzc2VkIHRoYXQuDQpTbyBHUElPRF9PVVRfTE9XIGRpc3JlZ2FyZHMgdGhlIGludmVyc2lvbiBm
cm9tIEdQSU9fQUNUSVZFX0xPVy4NCkFuZCBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocmVzZXRf
Z3Bpb2QsIDApIHVzZXMgdGhlIGludmVyc2lvbiB0byBtYWtlIHRoZSBwaW4gaGlnaC4NCkxvb2tz
IGZpbmUgdG8gbWUgbm93Lg0KDQo+IFRoYW5rcywNCj4gDQo+IEh1aS4NCg0KTWFhcnRlbg0K
