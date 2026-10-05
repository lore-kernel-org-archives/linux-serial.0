Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023118.outbound.protection.outlook.com [40.107.162.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283A446BF6;
	Mon,  5 Oct 2026 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195143; cv=fail; b=ux6khFtqLWZHHSgCiqMT9EzJXKbtlT+iJysLuDa4qKJZbEQ6Td1YipAS+8uCDaxORaRBcAASqNp+q+2oPcSZSUwaD5epOUnEog5ZEYaDXV/KJhIC0TlgYvnkYmEwa8kBr8IGGCXv4ExfgWoeBHjwImEwDkiNlDW7A3r5XXBpjRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195143; c=relaxed/simple;
	bh=63Qw3lvcmh45vrcwwkfR70ILnwwC4Bw8yrEUcsBYVyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AdNYQlbX/tuqi2/2FO9XlQYF4QC8EW1S711UP8ufT5fgOIdZDB2eGQ3h7i2tYHjpjamgSmy85dkqV17TAxTPe+e7m8RuZvGwJp+RFpYP7VgXTAxR2QQSTlRjkofWkvcQeHrQA30QEapzrTJatNQP7VUH6t2cExd4D2fgo32NFJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=Pjhu0Ls1; arc=fail smtp.client-ip=40.107.162.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="Pjhu0Ls1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4SCy8HfsJMP5gY0pCAE9ioA/bByuwNQVaz4osQ7u/R8a5uABO+iAWbRwAizo5ZQdeLiMX3QSmpun7tpSlZCuVE5O1ycCitMHnm00wwVfBeQ/llYq72DPEoCOiLsQbSX828YSFwdwYJvd4jhPl6gx3alBpaw+Ei9aky30bC6f6NRC955GCt5MseBzUqm69k+bae6oR9TgWps1meiC8qeYUgPBkKe+owSQBYpswgYhLchXXGTrGfkbIPEIPVRuPzEa9x302KWsYMc8/yQfF/9TxaAe6OCmil08uXYY8qo5p8Pb08ZSNdcUsPMNT7yP39umpbQ1DXpBQ/PpJLQ5/EFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63Qw3lvcmh45vrcwwkfR70ILnwwC4Bw8yrEUcsBYVyg=;
 b=aRxvgL45WqVYN1dWEAdn9rYMK4OAW5y8LDrm2bUXMi5ClRwaSROk1CDQ9ZNn8SdDUKqR3tnL7b6OruTnypNdaAWkHT4O8NXOqFxLihN1SXmEGE0ti8m6XOsBluceTnTsNriEgbvBk/GZrFuplL4oC6BB5oXgCrxY1zvQENHMHQoYHMDepHAJpfSwpeHPtEIn2J8xOPA0FddtEWvXQ4pa0x0YYaODpXg5/wqFPk9bzOVSB9vI5fWG9yniFBvFfQJi9pWQQFBLzvXGhFNvNpvOHF4UnnDUzSxBmxw4dwEqFEf6tgJB06qRke4ozCgurdlJFQVol5Z6tHVlxjfe6OWDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vaisala.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63Qw3lvcmh45vrcwwkfR70ILnwwC4Bw8yrEUcsBYVyg=;
 b=Pjhu0Ls1I5AiZMIsREq2hbSqglJkKN+RSm4SzZUluIxDf1HNK9fIetaX25s4A/wGZLeMogwO2xSrJo2BmZYDZF1kr5h107VXqcBkNCe8d3+0nWTCNQH7rDH3WZas/u2SBQBsWLeJpoH2WhDZRJBqQ1SGppf5GVEQshKYRiQMJFDncZZ4wCk1x7AKdWaSI0ejTH1j+eP+SQ2NRFdhCAiDZ1pLD6yHve/sNQp7hCayzsOWwOnaPa6uMGvNyX8pY7t8JsHeTDUioCvqIvrCnxJC/HnE2iqybDNOh6CL9WfK0N7+/a+KnzsCpMb1N0O5aHP1b0akKEuHP4CsRwpVaEOZLA==
Received: from AM0PR02CA0186.eurprd02.prod.outlook.com (2603:10a6:20b:28e::23)
 by VI0PR05MB690607.eurprd05.prod.outlook.com (2603:10a6:800:366::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 10:12:14 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::23) by AM0PR02CA0186.outlook.office365.com
 (2603:10a6:20b:28e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 10:12:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 10:12:14 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.68) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 05 Oct 2026 10:12:13 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by BR0PR05MB322490.eurprd05.prod.outlook.com
 (2603:10a6:2c8:4d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 10:12:11 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:12:11 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, Tapio Reijonen
	<tapio.reijonen@kolumbus.fi>
Subject: RE: [PATCH v6 5/9] serial: max310x: wait for TX to drain before
 powering down in shutdown
Thread-Topic: [PATCH v6 5/9] serial: max310x: wait for TX to drain before
 powering down in shutdown
Thread-Index: AQHdU/sVAs8zWDCW00C7L4OXp3pwSLbutdYw
Date: Mon, 5 Oct 2026 10:12:10 +0000
Message-ID: <GV2PR05MB119415B20C7D800FA6279CE4183962@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-5-3a0ef13ed9e3@vaisala.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-5-3a0ef13ed9e3@vaisala.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	GV2PR05MB11941:EE_|BR0PR05MB322490:EE_|AMS1EPF0000008E:EE_|VI0PR05MB690607:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d37626-5542-455d-b061-08df22c9209f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|4143699003|38070700021|260925021311599003|260925021911599003|260925022911599003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 pdFkYUqtBSWXebu31V+qLqNK9lMkXgkpRtktxD18dZDWLWM2+mJJrnpQna1g9QqGeEUtbmy2GQv0zGOiY2M86mJHO2tjFdKoewMPuYXpjIylMe1klk8ImxZFPmAXMfBxqOfcAEQfNAV3vbD0+gDCeEJrylWs78b6gNnd3MBrw1JvT9rywRsu1i1l3n52OmQRv7BIkHm15yc3jiWVV0oyAoi4dHNuXq2Djmwqba4QKSFsp30QUYuJB72LoVEIVx/X7/zla3MVTqDG7jsxfX7+wK3ofzAuRU/khqWyOqbGu+N0op8F5Nb92EPCK2cKFQeePfbZ9y9jvsD8/QUM9RyJvzt2nyjrN1o5qEhEDH50lG0YW3sl4h7rMnAy6Dymzk+6HTr/eqrblkdxX8NEgHGxtC4ETvVZOWsyR3Rwux1IACQnjfX5pcUKSrvJDFhPI05LbsfIUDtf6bn6D+kNobza+UetbFPR7ouL3IlRw6B+KvAKQBtEZ+dsANQLhKo0PWDbpbu33FPzUxW0w5efWa/i7qkakc+FyxN75yHKvX+6KyTWewufFLqA2QqrLOr92K2A1GpBHdz9AjnfoHKGWjQK+92Rx6Z0usOvpJ+kDJSbJ3joxPIxOGGeVYW0dzLFOOzbzpzbVzPdJpMq9s84pJRaunyzp9nx8CuWmy6OGqnh3hm4/mYezmaf1TI4bj24xwyO7VKzHp5igyONRJFEVzMQ6w+HWDp3/0rkth2iGyRmbM4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR05MB11941.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(4143699003)(38070700021)(260925021311599003)(260925021911599003)(260925022911599003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OizvD6SIJEIZYPtb6y3blZXqKJ6IjjiW4qRA3nhKtGqdze4uIMW1Rs5EUKzHYa+bTat47A6sryiLaeI89Da+Z4zw7zdwMfzrC+qkbcbsR+vk8VAZttqZlBeUSe9Pov6S0L2KZQ/OAOzoPFpQhhp6h5LE4OaQBI2CztgLz6Q5eUnO2EQ/jYwzHvGL6NxwM+dKfFG2gpN15BQEe+jmLoX8hrYWxaNV/3gKcjsk5xme9JlkE5tVT6yYFI1xpYv1F9AOWaovVpolc444OVYDu3aX7T6ySE3MQVcC4hz+94zPcPmKHYndDM2qgnY7mAjzx+5cQCFFX5hnioCY291unGLVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR05MB322490
X-CodeTwo-MessageID: 8cf1af6c-64f1-4478-84a6-34a071467cac.20261005101213@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c8881535-ea98-40c8-0b31-08df22c91ec1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|14060799003|35042699022|23010399003|36860700016|1800799024|10067099003|56012099006|260925021911599003|260925021311599003|260925022911599003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9ZYvYWNBaLKXZsBfsd4oluuqpn46etNei/leSAB0jABETt3wJRtZrrslEmdlSPOLyBTSuuVblmf7gG0bUK0cngYjMU5gG5VBAlVVi+B5oXZ/kkPuSIykY1vuKJFZcsT/Qy/tAyGpunp5KugKXzChw+s3NwdlBgVJVpHmyl5oT+/s6k8RSS6c/FKNMHsAZGodm9YGbSWQqGxPAGl1BJahMdM9Nazwiqhcc2Ot6a2rLXdXjYC/2ne7v0A2ols+gP3X1lgCOIrSCF7dqg0mR3AtBN7i8p9/zvhxL2FiHlbmN5vSo8e0ZNaN3XhmCNevE6O8AjAPEbB2X4D9fhBTtOVnQVuzB12PizIDaBwpv06DEKXtT8B458xQZO8FC4tDF1F8D7GDu3DLTrpl8EcD3f7du6Jtoa5wGX2eqiqgRtsrx3juWCSUvpEU3QM4QUtdTVvAgFrUBa0y1RLL6AFytGYomT/4nbz0twj2F0wIrjUAn3+66pPCWmDgf5DXnY+xOj5ZwyKB6TO8mZaqAZHX0HMYgAmGYk7+7vv9C/g6YDPnUFAz1QHuIPlWhvf++pS1lipI3pEJJOtGaxlWl9xV3uu0yy6YyQP8DINJO89hJpn3DFhr15qH+Gi8sYAD2DLT0vM++7JHY0ZDciQ3Cp+vdQxItygzuQhFauY9p2TERwtkCXkN5hmUt7tY8SjneojmpnI6GU7CFwSxdGCYB0cYx3cWRQ==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(14060799003)(35042699022)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IZUQgsFVNX0qzcTNoXKo4VgHbZVLOAm+d6YOYWCZSAYKKrkdumrrDDc6gvaV7q5jKqYJ13NDd7v3RO4Ly38fI4wSB9GLmFu9oybv72tKxyRSIrDf6/bj0RGhM86M9Af5gU+5LgrqW8aNBwW7WR1CLu0uneiZTSwxElQLNKOoZLoYMKivoqZEI43KK89jK3tCKCGa1Kq8xNI7YPMB3246ST3vMqhEC4VeS5DThdlFNgXvTMHXhUdDKQ7v8GdmEfcK6dgiCCDfm5D9Wdq4YEmC04HmOco5gs2fTkbO7FlCxHN940xoPbsWyENgiKTiaOz1URTumDmlgEwAg+3Du/FldYt8bUNh5HH2DneQY+gLWVerLg581Vct4UNHHf7yWQh8VOZwIJ8tfOtwPvjb53EoDl3RsZGAJI1BYn3L6qT6fnI1DJ+PGai/9BuBbiK3VdzA
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 10:12:14.0897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d37626-5542-455d-b061-08df22c9209f
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR05MB690607

PiBGcm9tOiBUYXBpbyBSZWlqb25lbiA8dGFwaW8ucmVpam9uZW5AdmFpc2FsYS5jb20+DQo+IFNl
bnQ6IFN1bmRheSA0IE9jdG9iZXIgMjAyNiAxNDoxNg0KPiANCj4gV2FpdCBpbiBzaHV0ZG93bigp
IGZvciB0aGUgRklGTyB0byBkcmFpbiwgYm91bmRlZCBieSBvbmUgY2hhcmFjdGVyDQo+IGR1cmF0
aW9uIHBlciBGSUZPIHdvcmQsIHBsdXMgb25lIG1vcmUgY2hhcmFjdGVyIGZvciB0aGUgYnl0ZSBp
biB0aGUNCj4gc2hpZnQgcmVnaXN0ZXIsIGJlZm9yZSBwb3dlcmluZyB0aGUgcG9ydCBkb3duLiBU
aGUgcGVyLWNoYXJhY3Rlcg0KPiBkdXJhdGlvbiBpcyBjb21wdXRlZCBpbiBzZXRfdGVybWlvcygp
IGZyb20gdGhlIGZyYW1lIHNpemUgYW5kIGJhdWQNCj4gcmF0ZS4NCj4gDQo+IEZpeGVzOiBmNjU0
NDQxODdhNjYgKCJzZXJpYWw6IE5ldyBzZXJpYWwgZHJpdmVyIE1BWDMxMFgiKQ0KPiBBc3Npc3Rl
ZC1ieTogQ2xhdWRlOmNsYXVkZS1mYWJsZS01DQo+IFNpZ25lZC1vZmYtYnk6IFRhcGlvIFJlaWpv
bmVuIDx0YXBpby5yZWlqb25lbkB2YWlzYWxhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3R0eS9z
ZXJpYWwvbWF4MzEweC5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL21heDMxMHguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9t
YXgzMTB4LmMNCj4gaW5kZXggMjQ1NmEyYWY4OTFmNTI5NmNmZWM4MzNkNjQwNjkxNjA3M2QyODY1
Zi4uOWRjYzgxN2I5Nzk0NTM3Mzg1YWE5Y2E3MjZjYjFjYzFiMmFmNmI0YyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy90dHkvc2VyaWFsL21heDMxMHguYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJp
YWwvbWF4MzEweC5jDQo+IEBAIC0xMjIzLDYgKzEyMjgsMjIgQEAgc3RhdGljIGludCBtYXgzMTB4
X3N0YXJ0dXAoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4gDQo+ICBzdGF0aWMgdm9pZCBtYXgz
MTB4X3NodXRkb3duKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpDQo+ICB7DQo+ICsJc3RydWN0IG1h
eDMxMHhfb25lICpvbmUgPSB0b19tYXgzMTB4X3BvcnQocG9ydCk7DQo+ICsJdW5zaWduZWQgaW50
IHRyaWVzID0gcG9ydC0+Zmlmb3NpemUgKyAxOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBUaGUgdHR5
IGxheWVyJ3Mgd2FpdC11bnRpbC1zZW50IGlzIGJvdW5kZWQgYnkgY2xvc2luZ193YWl0LCB3aGlj
aA0KPiArCSAqIGNhbiBiZSBjb25maWd1cmVkIHRvIG5vbmUsIGFuZCBhIGhhbmd1cCByZWFjaGVz
IGhlcmUgd2l0aCBubyB3YWl0DQo+ICsJICogYXQgYWxsLCBzbyB0aGUgRklGTyBtYXkgc3RpbGwg
aG9sZCBhbnl0aGluZyB1cCB0byBpdHMgZnVsbCBzaXplLg0KPiArCSAqIHR4X2VtcHR5KCkgYWxz
byBvbmx5IHJlZmxlY3RzIHRoZSBjaGlwIFRYIEZJRk8gLSB0aGUgbGFzdCBjaGFyYWN0ZXINCj4g
KwkgKiBtYXkgc3RpbGwgYmUgaW4gdGhlIHRyYW5zbWl0IHNoaWZ0IHJlZ2lzdGVyLiBMZXQgdGhl
IEZJRk8gZHJhaW4gYW5kDQo+ICsJICogdGhlIGZpbmFsIGNoYXJhY3RlciBjbG9jayBvdXQgYmVm
b3JlIHRoZSBwb3J0IGlzIHBvd2VyZWQgZG93biwNCj4gKwkgKiBvdGhlcndpc2UgdGhlIHRyYW5z
ZmVyIGlzIHRydW5jYXRlZCBvbiB0aGUgd2lyZS4NCj4gKwkgKi8NCj4gKwl3aGlsZSAoIW1heDMx
MHhfdHhfZW1wdHkocG9ydCkgJiYgdHJpZXMtLSA+IDApDQoNCldvdWxkIGl0IG5vdCBiZSBiZXR0
ZXIgdG8gcmV0cmlldmUgdGhlIGZpZm8gbGV2ZWwgYW5kIG11bHRpcGx5IHRoYXQgYnkgY2hhcl90
aW1lX3VzDQp0byB3YWl0IGZpcnN0PyBZZXMsIHRoZSAoTUFYMzEwOSkgZGF0YXNoZWV0IG1lbnRp
b25zIGl0cyB2YWx1ZSBtYXkgc29tZXRpbWVzIGJlDQppbmFjY3VyYXRlLCBidXQgdGhlIHdvcnN0
IHRoYXQgY2FuIGhhcHBlbiBpcyB3YWl0aW5nIHRvbyBsb25nLiBBbmQgYWZ0ZXIgdGhhdCB1c2UN
CnRoaXMgbWF4MzEweF90eF9lbXB0eSgpLg0KDQo+ICsJCWZzbGVlcChvbmUtPmNoYXJfdGltZV91
cyk7DQo+ICsJZnNsZWVwKG9uZS0+Y2hhcl90aW1lX3VzKTsNCj4gKw0KPiAgCS8qIERpc2FibGUg
YWxsIGludGVycnVwdHMgKi8NCj4gIAltYXgzMTB4X3BvcnRfd3JpdGUocG9ydCwgTUFYMzEwWF9J
UlFFTl9SRUcsIDApOw0KDQpLaW5kIHJlZ2FyZHMsDQpNYWFydGVuDQoNCg==
