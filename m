Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023125.outbound.protection.outlook.com [40.107.162.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECC4388E74
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790069135; cv=fail; b=H+mCMGleuIogYvj+jBSbJUpTYWG1adDHXvhx8Xavbn69xtjU3P6UiQvLHvIAO2XDd6zzVG2xjTWZlWWZNOO00nYzbFCeugJQM4pSdh16S0uk4DSwK1vYMzD3xkdnPS3VF7PRVc+Sf7AZyfgYn+IWAlhx4Hx65jL7m21OXMy/9pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790069135; c=relaxed/simple;
	bh=iqFXu9kNz2gruq8W89kL3IEbBFuaJ2Y5se6cxpxwlSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jPmbFeUHO3jOQelXOAY1vt1YcdB9ZLluJqzwGTncE5s+3emTehqMcKJ6pKlQAkkIPaXoZy0I0T6HwyVI7fkSAD59pbrN4mlVRmxdBE2mCC5PKH5GIxG3dSXKK9+ztxzA4V3mQ5EYwQMyQdSDMw93+amhb2GicaK6/9OGOQFTDHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=lH5urkmc; arc=fail smtp.client-ip=40.107.162.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="lH5urkmc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGv9lqpo8BnqYT/7QuXPcv7iQKXS0zyVJlXVn31TFPoe5y+r/Lu7KD+fLG2931SEFh0CfXtrKHQvloQZEGl2Qj08F8DPtqXdCms3LGAZ7I2sCNwcyOaf1UahzEq/bVqAuD1NXAAHptx9dlyNEHdNq2i1btYOMqvLktj8BEsUoRxJuu8XHrw/0Kjlx04XOwmbL2wgIZ/DIvglmR0nHIiXidUHg7eFWtgitRXaCXIL//FEvPwQgrzXkonI8e+m9gYZJKSSjh2+baAp06wPss+sSJVKb9qCP45NuDv4Nw2uzVsHve1nyeOf1qiu2SFjLTRdgFUE8ObIOvb2KySPqyLpvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqFXu9kNz2gruq8W89kL3IEbBFuaJ2Y5se6cxpxwlSQ=;
 b=Zn2rcDaRDMTprnPBGXdR/fAowye5bWsBrGX0hqridmjxmQhaIIfse28xsT3Isc4X7jsVKf3STR3Qy6SjM6hhKYWmBtUBmpcw8vEMSmLM+GP3bA9fn9kq+3/jfD/+ljmbkPBAb/cRGBoZf6DkQ4nUTaVLOuMVUGNC7vfeSNTnj0okTc9gcl9gdJaQyZVuewhT/Shf7vj4K+BlC0HOoW86zfRV31qN0gmFRxSmWEKoy69U3f0xRJp3B9AJCNDRLm3rM78ZuooFG7hi2WkqtYYdKND+i4r9MIYiZzfLijswCZJmjp5UUEr4K4o9hro80TNHuJmu22oxVVKC75xywwFJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqFXu9kNz2gruq8W89kL3IEbBFuaJ2Y5se6cxpxwlSQ=;
 b=lH5urkmc6BnNB42WVwS5Fxr1TKyNn4rRCLpJyC2m6ma9Q3v3ZFTq0VnlVycuFUbSOQ7Qq2NePsTjgRYVqkf3fvYXSMRh/eh3Rm5ctEa60CrGeFfTkQv61zKEHsKB/7bo2wkfCS+596gyDC838aVexVitRmzDFfJWmbK/IhsxL5ne4ps5ZoyTtqB8iV1vuG0o33r8BJqBHIwKiwOq8NUpiK45BDzJwAy0uMVaSsZG1XvuPmx/FLqcNfwdJJUDtHeMon4CYE3qxYvYUT35Lauh9WUq4oETEatib6xZrL4rU9vTCEt4tcUxjC6PYv1cK/YF8pH5lB9zWeuZyZOXVYxMlA==
Received: from AM0P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::33)
 by DUZPR05MB10975.eurprd05.prod.outlook.com (2603:10a6:10:4b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:25:30 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::5f) by AM0P190CA0023.outlook.office365.com
 (2603:10a6:208:190::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 09:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:25:28 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.89) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 22 Sep 2026 09:25:28 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AMZPR05MB429378.eurprd05.prod.outlook.com
 (2603:10a6:20b:7c5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 09:25:26 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 09:25:26 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Ginger <ginger.jzllee@gmail.com>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] serial: max3100: Fix a data race on s->rts in
 max3100_work()
Thread-Topic: [PATCH] serial: max3100: Fix a data race on s->rts in
 max3100_work()
Thread-Index: AQHdSlRQOJu7LpLUMUGcVzwy77wkvrbaPdSwgAAFroCAAAiyoA==
Date: Tue, 22 Sep 2026 09:25:26 +0000
Message-ID: <GV2PR05MB119417F5BB121B71DC5E27E2883832@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260922053151.11260-1-ginger.jzllee@gmail.com>
 <GV2PR05MB11941F04066D5CA3571C7919A83832@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <CAGp+u1Y+Xy0jguEaBQ96keiKQbJv2jpn_OM0fAefCLZWAd-yHA@mail.gmail.com>
In-Reply-To: <CAGp+u1Y+Xy0jguEaBQ96keiKQbJv2jpn_OM0fAefCLZWAd-yHA@mail.gmail.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	GV2PR05MB11941:EE_|AMZPR05MB429378:EE_|CPH1EPF00000520:EE_|DUZPR05MB10975:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3c19e4-fe13-4102-4c25-08df188b7157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 Vh+SRyXDhJviHb8zy4D0XwLuDZ0vNnwcAE/eayLo3zbiMTeahE7toIbEc18KyBLsWIJJA5dkUcstKSTo8MkPdJSDQ7u2+Z8LpIPEZnbDZD/ghAZIq4/wjTA5FvXdFRewiVu4NEACHtyTmhGGfGLkdY44ObLpQ+J62cgDZjI3B5z+sUF2s22NdSZq99GB1iDtJ0Rh3lHfbH2X1E2J3a82pqHgQVbh198wMeOqDEpDrVrK/NQ1lCqdxHsOEPsTT9iCr9ABvDRTlhxrkgcEMWkL5geNFmLBdnG0qcR6BtMU45Azq19Td/+Y5gR3Z3prQ7QcBDZt1O3B3kOlXL7eC1YGU50YtAqkwwahHAvce7MCsa101LDCkiooHBcL5ntXVqccpTbDUEbomfKkjrwm+YV2StVumaL7yEbxhhpKRCBJBeStrOMy3qkC8G0Lqm2kV9gvpADifvCnn4knF7RA1TucX1E6AGD0IP4bo8T1hwFIj+OmCbcE7/qTU0wIIUtk7MTWo2iZQqcxV23dZVNi/OxxiGZ3/8Yjh7Rh96Afppay9XrKrQoRzfwmL18IWK81sgIdA+MFluhvaFs28Wn/cdiMenmc7FnUj4R4s7v2WMP4oE0MPWuEtZc/WdNLztdyCVe/Pm5MwP53qu/9GHhR1/vp126xZ0GhHlmXG7cSoUBKOIlFC4X9wSTAbUK/4AUhkfOqOdFVguUCBW5if5/K7Cpec8fIbUWGNHQtalslBSRcT+E=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR05MB11941.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r61Cq5tALXa0yJwRjtfearK2i855jsMDJflaenvxKlMJtIEk8Ct/knca6Vkuz6hkD2jljz/R127B5RboxnAhhE9QcGm1Ceq7bYZwMaQO5kfEFdCYGMAK20zEZ9keae9Vin9WhAJETMLZtCsnYRtyxsGBEM7DIS+bXzrbKB9U5JjjLIk5kMdH9KMchg1i/0a7kYlsAPZOVnTKLG51Ot9zTSam1RhZMCbPFaxmXFUKyCeBia3+PvpTbt1UfknWjKFeRzSji5SuroeZiZXvxUA3CvxL2h484rzLPaArs7kA4xRAvEwpPRRavnquBH67lcPgKz4EsZxWTQtBuwNXKma1Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMZPR05MB429378
X-CodeTwo-MessageID: 28e879f3-6704-4502-9ecd-5f1e90f9093e.20260922092528@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	57ee7c59-698a-473e-7ad7-08df188b6f9f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|35042699022|14060799003|1800799024|36860700016|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	sHBDr9XymJ+A3eUH/c3DAY5FFP/LeaSpUSA8AcpvpHzJ5azrYEnpVZ4CvN0Y7Wyic7xKd10Uhuu+NGsF+qUuGxLRAFuNXwnOiIs7R7dwl/Cf+V0e0qUXtwtXiUnrn304gq9Ker3vusRm/Y21xmFP26RKWwh334sC/3ZDs/IOYK1BWiEpSHDmL8Or2+xOx6rXh5hvJ42xwCEth04VQVqfintFBX5ny7rBAcZXN2WrmLttmeMAAzXKupJ9fBUBQ+sBMen4jlUQ/VzkgrtCiGg68OVV9/uOkJScjMrbFG6DtMUKMl8MgN/9+x4kaR2rcAYBiaP0RiXjPc89/b6M+08nUMs/7DXm4vBgmI7gcXjeB8gtjHckOFUHuS6dHiwAWsr4nguP0PPouFvVY4a4gllA2rJJXLr7MBltM9sSLtSJW6kMIOazvEAwNSt8WzkuCsc5dVXzXMNha2aUinsmG1/TIsUefQLBxhFPWoPCz6it79CsgSWopDscjfgJ1WONKJs8EIHz3o6WomwsMIv3N3LmTs9ScfLk4T42n9WDuK6i7+LtognAmnoshlMIak038pMDwVucvllSQ/Q+emuWWJaytUnqMqRvJHmSOAVSMhgsnVvaa/odRQ8guMHK6kzsSykFJ3wpdKymEoOaS9O9SXh5faMcCiSu6RO88Pk/y4bmGc1xnkNRnchyPIZvNBkBEVCBmdFqpg4IxaF7Rf+NeBXCNQ==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(35042699022)(14060799003)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3EaabnT2wGaOXHRCJTtE/56Zq4B9otrKCBVQRs+SXSZ3FkntZQd+Gq6rEdFP3WVWTfsehb06q2BGwtSIdrtxzyzmFKaUfscKhhrMYGQUt0/JHq2guli3ll9WbaQN7eEefyqngZH2w+xLaDMrPozfc1qGu1AprPtgkQAmvdWnhwSnmWQHMFCAgk1ltWx9R0ttouuxNHxpcAIUw9Jkcf7AgQ1BKqp37eouNvy2NkcMxK1/Rb5IBj4/0hMK5UzuDcbhX5zN8d5joAiqHBqPNbROtmzfIbSS+K58RU1zqJJYDD/APhCPzpyrAqOI71SvVd8C0BQFqlQw0MPuOZOtLUHRBDksHnyQTxmjX31ixyhkKYuaWZxWa3YNDqPRPpMwRaZ+bjXz8i4Xj/cm7vMhNBBi1kHcnL6AHOFRCxDc7QhlJSyUhYoR0DLxGYTVECeB+2t/
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:25:28.9979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3c19e4-fe13-4102-4c25-08df188b7157
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR05MB10975

SGVsbG8gR2luZ2VyLA0KDQpJIGhhZCBtaXNzZWQgdGhlIG1lYW5pbmcgb2Ygcy0+cnRzX2NvbW1p
dCwgYnV0IGl0IGlzIHRoaXMgZmxhZyB0aGF0IGluZGljYXRlcw0Kcy0+cnRzIGhhcyBjaGFuZ2Vk
LiBTbyB5b3VyIGZpeCBpcyBjb3JyZWN0IGFmdGVyIGFsbCwgYnV0IHRoZSBjb21taXQgbWVzc2Fn
ZQ0KY2FuIGJlIGltcHJvdmVkIGJ5IG1lbnRpb25pbmcgcy0+cnRzX2NvbW1pdC4NCg0KSSBzdWdn
ZXN0IHRvIHJlYWQgcy0+cnRzIGludG8gcnRzIGJlZm9yZSBhc3NpZ25pbmcgY3J0cyB1bmRlciB0
aGUgc3BpbmxvY2ssDQpqdXN0IGxpa2UgY29uZiBpcyByZWFkIGJlZm9yZSBjY29uZiBpcyBhc3Np
Z25lZC4NCg0KU2lkZSBub3RlOiBwZXJzb25hbGx5IEkgd291bGQgbm90IGhhdmUgY29uc3RydWN0
ZWQgdGhpcyBkaWZmaWN1bHQNCnMtPnJ0c19jb21taXQgZmxhZyBidXQgY29tYmluZWQgcy0+cnRz
IGFuZCBzLT5ydHNfY29tbWl0IGludG8gb25lIGJ5dGUsDQptYWtpbmcgYW4gYXNzaWdubWVudCBh
dG9taWMgaW4gaXRzZWxmIHdpdGhvdXQgbG9jay4NCg0KS2luZCByZWdhcmRzLA0KTWFhcnRlbg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdpbmdlciA8Z2luZ2VyLmp6
bGxlZUBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXkgMjIgU2VwdGVtYmVyIDIwMjYgMTA6MjcN
Cj4gVG86IE1hYXJ0ZW4gQnJvY2sgPE1hYXJ0ZW4uQnJvY2tAc3R0bHMubmw+DQo+IENjOiBqaXJp
c2xhYnlAa2VybmVsLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LXNlcmlh
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc2VyaWFsOiBtYXgzMTAw
OiBGaXggYSBkYXRhIHJhY2Ugb24gcy0+cnRzIGluIG1heDMxMDBfd29yaygpDQo+IA0KPiBIZWxs
byBNYWFydGVuIEJyb2NrLA0KPiANCj4gU29ycnkgdGhhdCBteSBwcmV2aW91cyByZXBseSBkaWQg
bm90IHVzZSBwbGFpbiB0ZXh0LCBzbyBJIGFtIHNlbmRpbmcNCj4gdGhpcyBlbWFpbCBhZ2Fpbi4N
Cj4gDQo+IFRoYW5rcyBmb3IgeW91ciByZXBseS4gVGhlbiwgaW4gdGhhdCBjYXNlLCBob3cgYWJv
dXQganVzdCBkaXJlY3RseQ0KPiB3cmFwcGluZyB0aGUgcmVhZHMgb2YNCj4gcy0+cnRzIHdpdGgg
cy0+Y29uZl9sb2NrIGluIG1heDMxMDBfd29yaygpPw0KPiANCj4gU2luY2VyZWx5LA0KPiBHaW5n
ZXINCj4gDQo+IE9uIFR1ZSwgU2VwIDIyLCAyMDI2IGF0IDQ6MTfigK9QTSBNYWFydGVuIEJyb2Nr
IDxNYWFydGVuLkJyb2NrQHN0dGxzLm5sPiB3cm90ZToNCj4gPg0KPiA+IEhlbGxvIEdpbmdlciBM
aSwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEdp
bmdlciBMaSA8Z2luZ2VyLmp6bGxlZUBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBUdWVzZGF5IDIy
IFNlcHRlbWJlciAyMDI2IDc6MzINCj4gPiA+IFRvOiBqaXJpc2xhYnlAa2VybmVsLm9yZzsgZ3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmcNCj4gPiA+IENjOiBsaW51eC1zZXJpYWxAdmdlci5rZXJu
ZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0hdIHNlcmlhbDogbWF4MzEwMDogRml4IGEgZGF0
YSByYWNlIG9uIHMtPnJ0cyBpbiBtYXgzMTAwX3dvcmsoKQ0KPiA+ID4NCj4gPiA+IG1heDMxMDBf
d29yaygpIHJlYWRzIHMtPnJ0cyB3aGVuIGl0IHByb2Nlc3NlcyBhIHBlbmRpbmcgUlRTIHVwZGF0
ZSBhbmQgd2hlbg0KPiA+ID4gaXQgdHJhbnNtaXRzIGEgY2hhcmFjdGVyLCBib3RoIHRpbWVzIHdp
dGhvdXQgaG9sZGluZyBzLT5jb25mX2xvY2suDQo+ID4gPiBtYXgzMTAwX3NldF9tY3RybCgpIHVw
ZGF0ZXMgcy0+cnRzIHVuZGVyIHRoYXQgbG9jayB3aGVuIHRoZSByZXF1ZXN0ZWQgUlRTDQo+ID4g
PiBzdGF0ZSBjaGFuZ2VzLCBzbyB0aGUgdHdvIGFjY2Vzc2VzIHJhY2UgYW5kIHRoZSB3b3JrIGhh
bmRsZXIgY2FuIHByb2dyYW0gdGhlDQo+ID4gPiBvbGQgUlRTIHN0YXRlIGluIHRoZSBoYXJkd2Fy
ZS4NCj4gPiA+DQo+ID4gPiBUYWtlIHRoZSB2YWx1ZSBvZiBzLT5ydHMgaW4gdGhlIHMtPmNvbmZf
bG9jayBwcm90ZWN0ZWQgc25hcHNob3QgYXQgdGhlIHRvcCBvZg0KPiA+ID4gdGhlIGxvb3AsIGxp
a2UgdGhlIG90aGVyIGNvbmZpZ3VyYXRpb24gZmllbGRzLg0KPiA+ID4NCj4gPiA+IEZpeGVzOiA3
ODMxZDU2YjBhMzUgKCJ0dHk6IE1BWDMxMDAiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogR2luZ2Vy
IExpIDxnaW5nZXIuanpsbGVlQGdtYWlsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMv
dHR5L3NlcmlhbC9tYXgzMTAwLmMgfCA2ICsrKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdHR5L3NlcmlhbC9tYXgzMTAwLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvbWF4MzEw
MC5jDQo+ID4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvbWF4MzEwMC5jDQo+ID4gPiArKysg
Yi9kcml2ZXJzL3R0eS9zZXJpYWwvbWF4MzEwMC5jDQo+ID4gPiBAQCAtMjM2LDYgKzIzNiw3IEBA
IHN0YXRpYyB2b2lkIG1heDMxMDBfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncpDQo+ID4gPiAg
ICAgICBzdHJ1Y3QgdHR5X3BvcnQgKnRwb3J0ID0gJnMtPnBvcnQuc3RhdGUtPnBvcnQ7DQo+ID4g
PiAgICAgICB1bnNpZ25lZCBjaGFyIGNoOw0KPiA+ID4gICAgICAgaW50IGNvbmYsIGNjb25mLCBj
bG9vcGJhY2ssIGNydHM7DQo+ID4gPiArICAgICBib29sIHJ0czsNCj4gPiA+ICAgICAgIGludCBy
eGNoYXJzOw0KPiA+ID4gICAgICAgdTE2IHR4LCByeDsNCj4gPiA+DQo+ID4gPiBAQCAtMjUxLDYg
KzI1Miw3IEBAIHN0YXRpYyB2b2lkIG1heDMxMDBfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncp
DQo+ID4gPiAgICAgICAgICAgICAgIHMtPmxvb3BiYWNrX2NvbW1pdCA9IDA7DQo+ID4gPiAgICAg
ICAgICAgICAgIGNydHMgPSBzLT5ydHNfY29tbWl0Ow0KPiA+ID4gICAgICAgICAgICAgICBzLT5y
dHNfY29tbWl0ID0gMDsNCj4gPiA+ICsgICAgICAgICAgICAgcnRzID0gcy0+cnRzOw0KPiA+ID4g
ICAgICAgICAgICAgICBzcGluX3VubG9jaygmcy0+Y29uZl9sb2NrKTsNCj4gPg0KPiA+IFRoaXMg
aXMgbm90IGdvaW5nIHRvIGhlbHAuIE5vdyBzLT5ydHMgaXMgcmVhZCBfZWFybGllcl8gdW5kZXIg
dGhlIGxvY2sgYW5kIHRoZW4NCj4gPiB0aGUgbG9jayBpcyByZWxlYXNlZC4gU28gcy0+cnRzIG5v
dyBoYXMgZXZlbiBtb3JlIGNoYW5jZSB0byBiZSBtb2RpZmllZCBhbmQNCj4gPiB0aGUgb2xkIHZh
bHVlIHRvIGJlIHByb2dyYW1tZWQuDQo+ID4NCj4gPiA+ICAgICAgICAgICAgICAgaWYgKGNjb25m
KQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIG1heDMxMDBfc3IocywgTUFYMzEwMF9XQyB8
IGNvbmYsICZyeCk7DQo+ID4gPiBAQCAtMjU4LDcgKzI2MCw3IEBAIHN0YXRpYyB2b2lkIG1heDMx
MDBfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgbWF4MzEwMF9zcihzLCAweDQwMDEsICZyeCk7DQo+ID4gPiAgICAgICAgICAgICAgIGlmIChj
cnRzKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgbWF4MzEwMF9zcihzLCBNQVgzMTAw
X1dEIHwgTUFYMzEwMF9URSB8DQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAocy0+cnRzID8gTUFYMzEwMF9SVFMgOiAwKSwgJnJ4KTsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIChydHMgPyBNQVgzMTAwX1JUUyA6IDApLCAmcngpOw0KPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgIHJ4Y2hhcnMgKz0gbWF4MzEwMF9oYW5kbGVyeChzLCByeCk7
DQo+ID4gPiAgICAgICAgICAgICAgIH0NCj4gPiA+DQo+ID4gPiBAQCAtMjc3LDcgKzI3OSw3IEBA
IHN0YXRpYyB2b2lkIG1heDMxMDBfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncpDQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIGlmICh0
eCAhPSAweGZmZmYpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1heDMx
MDBfY2FsY19wYXJpdHkocywgJnR4KTsNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHR4IHw9IE1BWDMxMDBfV0QgfCAocy0+cnRzID8gTUFYMzEwMF9SVFMgOiAwKTsNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR4IHw9IE1BWDMxMDBfV0QgfCAocnRzID8g
TUFYMzEwMF9SVFMgOiAwKTsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1h
eDMxMDBfc3IocywgdHgsICZyeCk7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByeGNoYXJzICs9IG1heDMxMDBfaGFuZGxlcngocywgcngpOw0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgIH0NCj4gPiA+IC0tDQo+ID4gPiAyLjQzLjANCj4gPiA+DQo+ID4NCj4gPiBLaW5k
IHJlZ2FyZHMsDQo+ID4gTWFhcnRlbg0KPiA+DQo=
