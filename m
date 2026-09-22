Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020079.outbound.protection.outlook.com [52.101.84.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37FF40B6E0
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065052; cv=fail; b=sS4Z4kRQi5NI+B9Tj/E/3V9mqGVw67RMjS+FXFZkl8zMdvfcJWbs5JJh+hw6GlvcvgTE70UDHlqdvmaFkhe9+GyXgVhn04j/hokQmiMCB85Ysb+HIFu79Wz9qs+ev4NVq+JBbHhSPy+oYeN1CCyKwNaRQrxfbEL3gzlVhzw65/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065052; c=relaxed/simple;
	bh=Tafd8SN/JW3ALIgBWldmlxgLfozk7n6sxzHf4Fzw6ik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pqffUdEnp/BPWtIIbFFc2DrnsvMe+59fOJbnwYFnHI2tCcP+dLDkwIc1jC4uICzfppufW6cBfkbLqk1UwklxBGPI23PyKXf6vbh2AI2EaTHwTSxpCa9kw/aau60dJPsF4Zw6FSPXeveDCGNDxhb6rFSVMeCPOHmTcsnxnXRLTKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=jzZjHC2y; arc=fail smtp.client-ip=52.101.84.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="jzZjHC2y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOFtslYzP4p5Z8dKLZqYYtcYW2oRMG7+kexUXrI7wPFCFTEUiihSYgBOs3/HKNM411i7+9nuL8ngcbFa44lrCdxcndMs308uVtv71OhTl5i9NliAqeKI8m8Y2UzbD7CtaDVZyvXeP1DasllH2TaLqQRf60rDKfjFe2XLpmYtQjHDv5XmYxcmBXJcuywxQzeJ7Jvu0rmsb2jUmV4Gjcej56T70o1oelgn52QC0nVtEvyYdMXaQhAYRVPpmysqF2v8RzS2C+bQjZtQLNb2I1BXTSyZQ8yD6OAwkRVrM8SwaQWSc1xKdBLGZEuYgMQ/2jE/rezp2DP4mPMPOTCanUeEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tafd8SN/JW3ALIgBWldmlxgLfozk7n6sxzHf4Fzw6ik=;
 b=v0OCA2IrXkS/0G0Cfxikd0DtkxowAuL6EiEZ4Yhs/8KNpPWGeMJX1rOzEmmZteAhNdx4pjXPxMDayriGcai7XpYeyDvG7UrcrDuH6rEtjIUGgKqYLNk6Xn3WMfYV75xboVCkzx02SQA2Z2hv9nWHaOPZvCgLjd2Ki5Z+utBPOt7IvtPdCp5GG06G3FzPavnv6ptDp2t8oec2IuQIN24HCnL9aDc3TwcpGF9RpTwVWlk2FewlBt/Uq6bB6R7oB3nQ5a7ywXj/RXYU80zvqexIlzxzbyH+bDj9AGbnOdViqHXY5ZfPpqak+y5rbZtYRrwLDdhAr/7mzJmpwB1IXpN3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tafd8SN/JW3ALIgBWldmlxgLfozk7n6sxzHf4Fzw6ik=;
 b=jzZjHC2yY6Yv2uzgEL1kEmFjouak3+7+Q4sPx1vZgh2qzmn+/B12VO192odl+6t12Xt+Z6BFc272/0BFhoLFJe3byc85TZ+1d1XztQSDWd2RiWQk669Z8lZuI9zGMQ/vU2xKs1IkVTd3fUl4nziINbay4CH9tgC8/LSJzs9q4XKAcPlAPO8hhiflY1SgLXqkAOSR9BSYrUQ/nEq2hSPR0Z4/ysya22eV/QBcJ/+L/IPaXkden83qLFAxtltxuqj+qOQsNBzvMz6ABMoMue8vMNb1c13SDg7pa6p4ZJbvLoCujt8dr+j0c+aJi2EigD6QasmYJFpIZ9KBFvyhPyWKUQ==
Received: from DUZPR01CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::8) by DB5PR05MB12873.eurprd05.prod.outlook.com
 (2603:10a6:10:651::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 08:17:28 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::8f) by DUZPR01CA0052.outlook.office365.com
 (2603:10a6:10:469::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 08:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 22 Sep 2026 08:17:27 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.69) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 22 Sep 2026 08:17:26 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by PAVPR05MB9854.eurprd05.prod.outlook.com
 (2603:10a6:102:32c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:17:19 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 08:17:19 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Ginger Li <ginger.jzllee@gmail.com>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] serial: max3100: Fix a data race on s->rts in
 max3100_work()
Thread-Topic: [PATCH] serial: max3100: Fix a data race on s->rts in
 max3100_work()
Thread-Index: AQHdSlRQOJu7LpLUMUGcVzwy77wkvrbaPdSw
Date: Tue, 22 Sep 2026 08:17:19 +0000
Message-ID: <GV2PR05MB11941F04066D5CA3571C7919A83832@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260922053151.11260-1-ginger.jzllee@gmail.com>
In-Reply-To: <20260922053151.11260-1-ginger.jzllee@gmail.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	GV2PR05MB11941:EE_|PAVPR05MB9854:EE_|DU2PEPF00028D07:EE_|DB5PR05MB12873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8cbca4-6220-44b1-c4ad-08df1881f0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 L2N1Vjq5yrB4IsFmunMNu3Hs1XYPCTCJobsJKHs/grhaYwrPkpIcN1GtaCC8o86UPQTI6Q3oP90+q/TitouHN2M0jwrUViBojGFiUhYIWv0OUTR0/As5JR7eY0qZU8cWPZmhcXUFUzVm83+ebV0jkUbfH5SdlMpR6k/gG9SPjss7fcdrFebSeQBBXui+3gYbSyIsDlpL2zSZnQoxwwJ1dasMepPy4wWQTV4eABWL2WrJZ9v3bZxYfw9wgS4C5cx3mIH9el/jB53t7AVvk8JB5RQfg9x2kn/KGufNwYdT0CMI9KK3ahUeAqTIMYxQ20gkerdcYBKNoOk9sRmrWOTIoTSSfsPuZhCvFf8b0TzVarpoFDNMQqo8+H0OHvrStOtyBcMJldaaNGlevI6233wpXry04SaAdtCT2EwdhyDb+f8HIMaYd/2JVE52Kd7EiksvY6kOH/o8mQ/1bekBODGSknKwuIoY+naNQC6kMClRmTuJDMop/v8gt8MoDfeekEoJpm/BXhN9Fk3ZGHC8jJO6kSnT5PM7mpKIShdpVRpA/ddhly55zkBH6SWm//sjX6geR9RmsyIDswsbeTkmTWgPZZXFFOrj0cygXm73DtoYUUaOiOPQGK4Vh+PnHzLjGcDwTvdxxYmpzmyTI0jbQYKqvwA5LWAhkgNpCr2RzfXgiz5EONRGuJQkPQmhx4sUU6F7yMc5Jzuq0mIQOEUVYPIJLsd47B9YJu2cod10vJ9ecRU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR05MB11941.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IEMtjuofrgxDXOLX4pbk5mvPWlwx8pfPdAaYiZeNktvLB7gj/97iK58CsbMMZe2Z6tdcnsxT2ouoJxMCYG1v3HNbw978tIt2+dDCVraIRIjNe9kKVmpIEg/4HUg9lFWUZyGrtSaRQGaCJDHy8/uv8wnrgc9g/TWbzwKPN9X+9F3t10Coq0DUG7nEnB9Rzp9fS9wVBpaeACcFQUZuzA1UiXtsxuneed2RK50+1TsW8lr3zy4TSk/Eg4xUzMCCprbjeqjgQ2nB8Ww26tnEGJ4GyU0vkjfMz2u3xvLBVrKQ3kuFDrB77z2rs3Zm/XJ2LomLRE1YRczxFPVRlx8mVnfS9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR05MB9854
X-CodeTwo-MessageID: 346bc16b-68bf-4dc4-b99a-04dbfd8efc2f.20260922081726@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2ccffb1b-7e55-4c7d-86d0-08df1881ebd2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|1800799024|14060799003|23010399003|36860700016|82310400026|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VGbkwNwEY/Kof9yGWvv91WixL3wA5fqE+6mU8Fl2uGfEIIE4V3PJeu0vyfx4o9aHvlRbAlMPGcNwxGEowluPqMYSsjAwO8psGu34Xx4hF6YWHW8HOFo1OqUWX1hw58pZBQrP6MDrqjUNDyl1MGrblAjRd5CvC4uvKW9qswMj9/oKd6eRfHuKPu1DAh7SB1WHNSDppmgCQcgMUMWvrK/aAr4WH9iAHn/ng44pNJ1gD5jlHATYzM0IJqOINf0eaZpos5AwE2v8/hlhDxCvl5vvrG0ihuvPp8UX3nS99ASIZ/9habZjdv/PufpzhnoxTjRnoFiIte0A2/yz8V3BEuVV694pH7cz5zqccfQXX2bd0pUhizamro8PIfrxtFdMZgc/VnmNnC0/cwiW0d6SBXzek4AyKOdAR8aXVw5JF41+DEKjRbsjpGUsU5/ysc1+J8i9RkIvXyOteQnSxlJshJ8lnh4sI735zkfgFnZHKPeqFsna/u/famDOV4tGV5I7d1cSn2NRb6t2cL57EUIDeneQbIxwbVdraX5AB489zyGSbMuDJ3xglhM2oAVRzC9OW36alSuzqchMNMti1ttQQ1FuuESCkCMUqPb1cTHFAxtW10Nl2qMSkDZRLJmflfJDbyHd/qot1kR2ReYuwm2iwrVSpGowYJ9TpgeFWktPl7HdQ4tvF+XSxbPhC/UolMgpffrEty46J4pwomB6OMxaADKrRw==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(376014)(1800799024)(14060799003)(23010399003)(36860700016)(82310400026)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9AX91v+dfvJbrz6XGssqgfGoVaGAaWerYHP5TlTrokdSGNn6Y1MELedmrtuXhHvgzHkISZDpO2qAWEDUq8JdoYhhWIJb4w5i5dJgkK6n8olXUDMu8TQ+MoVfFb7YgjeyBpIXoQIMO4E59q+clClvhlLrK4GP4hX6nYz3FFAUo1cP+/QevNVBsuXCZQNqXBcjjsK/BqO1kgcR4qlrHXLSyLYOBYlHKOhP5U4Kccy0NW9paUkeySFsNiErEAFBPnw50GICn9fVS2IGWDw/YEqairvMr/8PwCkBgBdfD8pnO807F2h3ZtgbnhwiM6MBEoMBaLTE+WqZPASP2K4kHNyxIFuvFH1c/Lch3aFby310bHi+S2h5xZ9Jsi1LP9DqCPH+VYKGz4t2DfrTxwhrrqcY+2glJ+ZJjU2T+7ItAbnnsBiR/Oq26LMQD+/eeKYH3DuX
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:17:27.8651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8cbca4-6220-44b1-c4ad-08df1881f0cd
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR05MB12873

SGVsbG8gR2luZ2VyIExpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEdpbmdlciBMaSA8Z2luZ2VyLmp6bGxlZUBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXkgMjIg
U2VwdGVtYmVyIDIwMjYgNzozMg0KPiBUbzogamlyaXNsYWJ5QGtlcm5lbC5vcmc7IGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnDQo+IENjOiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFtQQVRDSF0gc2VyaWFsOiBtYXgzMTAwOiBGaXggYSBkYXRhIHJhY2Ugb24gcy0+
cnRzIGluIG1heDMxMDBfd29yaygpDQo+IA0KPiBtYXgzMTAwX3dvcmsoKSByZWFkcyBzLT5ydHMg
d2hlbiBpdCBwcm9jZXNzZXMgYSBwZW5kaW5nIFJUUyB1cGRhdGUgYW5kIHdoZW4NCj4gaXQgdHJh
bnNtaXRzIGEgY2hhcmFjdGVyLCBib3RoIHRpbWVzIHdpdGhvdXQgaG9sZGluZyBzLT5jb25mX2xv
Y2suDQo+IG1heDMxMDBfc2V0X21jdHJsKCkgdXBkYXRlcyBzLT5ydHMgdW5kZXIgdGhhdCBsb2Nr
IHdoZW4gdGhlIHJlcXVlc3RlZCBSVFMNCj4gc3RhdGUgY2hhbmdlcywgc28gdGhlIHR3byBhY2Nl
c3NlcyByYWNlIGFuZCB0aGUgd29yayBoYW5kbGVyIGNhbiBwcm9ncmFtIHRoZQ0KPiBvbGQgUlRT
IHN0YXRlIGluIHRoZSBoYXJkd2FyZS4NCj4gDQo+IFRha2UgdGhlIHZhbHVlIG9mIHMtPnJ0cyBp
biB0aGUgcy0+Y29uZl9sb2NrIHByb3RlY3RlZCBzbmFwc2hvdCBhdCB0aGUgdG9wIG9mDQo+IHRo
ZSBsb29wLCBsaWtlIHRoZSBvdGhlciBjb25maWd1cmF0aW9uIGZpZWxkcy4NCj4gDQo+IEZpeGVz
OiA3ODMxZDU2YjBhMzUgKCJ0dHk6IE1BWDMxMDAiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBHaW5nZXIg
TGkgPGdpbmdlci5qemxsZWVAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdHR5L3Nlcmlh
bC9tYXgzMTAwLmMgfCA2ICsrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwv
bWF4MzEwMC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL21heDMxMDAuYw0KPiAtLS0gYS9kcml2ZXJz
L3R0eS9zZXJpYWwvbWF4MzEwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9tYXgzMTAw
LmMNCj4gQEAgLTIzNiw2ICsyMzYsNyBAQCBzdGF0aWMgdm9pZCBtYXgzMTAwX3dvcmsoc3RydWN0
IHdvcmtfc3RydWN0ICp3KQ0KPiAgCXN0cnVjdCB0dHlfcG9ydCAqdHBvcnQgPSAmcy0+cG9ydC5z
dGF0ZS0+cG9ydDsNCj4gIAl1bnNpZ25lZCBjaGFyIGNoOw0KPiAgCWludCBjb25mLCBjY29uZiwg
Y2xvb3BiYWNrLCBjcnRzOw0KPiArCWJvb2wgcnRzOw0KPiAgCWludCByeGNoYXJzOw0KPiAgCXUx
NiB0eCwgcng7DQo+IA0KPiBAQCAtMjUxLDYgKzI1Miw3IEBAIHN0YXRpYyB2b2lkIG1heDMxMDBf
d29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncpDQo+ICAJCXMtPmxvb3BiYWNrX2NvbW1pdCA9IDA7
DQo+ICAJCWNydHMgPSBzLT5ydHNfY29tbWl0Ow0KPiAgCQlzLT5ydHNfY29tbWl0ID0gMDsNCj4g
KwkJcnRzID0gcy0+cnRzOw0KPiAgCQlzcGluX3VubG9jaygmcy0+Y29uZl9sb2NrKTsNCg0KVGhp
cyBpcyBub3QgZ29pbmcgdG8gaGVscC4gTm93IHMtPnJ0cyBpcyByZWFkIF9lYXJsaWVyXyB1bmRl
ciB0aGUgbG9jayBhbmQgdGhlbg0KdGhlIGxvY2sgaXMgcmVsZWFzZWQuIFNvIHMtPnJ0cyBub3cg
aGFzIGV2ZW4gbW9yZSBjaGFuY2UgdG8gYmUgbW9kaWZpZWQgYW5kDQp0aGUgb2xkIHZhbHVlIHRv
IGJlIHByb2dyYW1tZWQuDQoNCj4gIAkJaWYgKGNjb25mKQ0KPiAgCQkJbWF4MzEwMF9zcihzLCBN
QVgzMTAwX1dDIHwgY29uZiwgJnJ4KTsNCj4gQEAgLTI1OCw3ICsyNjAsNyBAQCBzdGF0aWMgdm9p
ZCBtYXgzMTAwX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3KQ0KPiAgCQkJbWF4MzEwMF9zcihz
LCAweDQwMDEsICZyeCk7DQo+ICAJCWlmIChjcnRzKSB7DQo+ICAJCQltYXgzMTAwX3NyKHMsIE1B
WDMxMDBfV0QgfCBNQVgzMTAwX1RFIHwNCj4gLQkJCQkgICAocy0+cnRzID8gTUFYMzEwMF9SVFMg
OiAwKSwgJnJ4KTsNCj4gKwkJCQkgICAocnRzID8gTUFYMzEwMF9SVFMgOiAwKSwgJnJ4KTsNCj4g
IAkJCXJ4Y2hhcnMgKz0gbWF4MzEwMF9oYW5kbGVyeChzLCByeCk7DQo+ICAJCX0NCj4gDQo+IEBA
IC0yNzcsNyArMjc5LDcgQEAgc3RhdGljIHZvaWQgbWF4MzEwMF93b3JrKHN0cnVjdCB3b3JrX3N0
cnVjdCAqdykNCj4gIAkJCX0NCj4gIAkJCWlmICh0eCAhPSAweGZmZmYpIHsNCj4gIAkJCQltYXgz
MTAwX2NhbGNfcGFyaXR5KHMsICZ0eCk7DQo+IC0JCQkJdHggfD0gTUFYMzEwMF9XRCB8IChzLT5y
dHMgPyBNQVgzMTAwX1JUUyA6IDApOw0KPiArCQkJCXR4IHw9IE1BWDMxMDBfV0QgfCAocnRzID8g
TUFYMzEwMF9SVFMgOiAwKTsNCj4gIAkJCQltYXgzMTAwX3NyKHMsIHR4LCAmcngpOw0KPiAgCQkJ
CXJ4Y2hhcnMgKz0gbWF4MzEwMF9oYW5kbGVyeChzLCByeCk7DQo+ICAJCQl9DQo+IC0tDQo+IDIu
NDMuMA0KPiANCg0KS2luZCByZWdhcmRzLA0KTWFhcnRlbg0KDQo=
