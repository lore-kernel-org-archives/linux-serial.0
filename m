Received: from addi-data.com (firewall1.addi-data.de [62.154.208.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A999279DAF
	for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2025 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.154.208.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791816; cv=fail; b=a4Myi+7g+qxZ03CLuZIqTIxONr3y+TYnci/QmvKLtTATaxF4uC/4P6NwK2Lra0PD1mKexiZvPjPLb4if1o7UFtV8/4KiMURoXmYQ6ZmPRvgDiEw2vkF8YWnTjEcfQDSwRIm87JOzigup+4xJdiBKVpmcMFQECi3UqCr/7QrBrRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791816; c=relaxed/simple;
	bh=eyzt3Bk89IGms5jOGHZ19LXtSeGrzRkPRrkbtSMQFHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cdaD+nnRUywlZnRKgSGKMERm8fiqHD5/G6C1lAAUzuIDfZWP70WXhwpfVT7rE4g7EnfhCzWPJPOrXVdLpKy5uBXjEJDujHfcihx0bLdhdXzG5qHyDotzFmzRluVa1iClgsyv3ktTCeUa18XjVrROA3ZZu5kjCjzYzccJ/PZnb8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=addi-data.com; spf=pass smtp.mailfrom=addi-data.com; dkim=pass (2048-bit key) header.d=addi-data.com header.i=@addi-data.com header.b=PczIYodA; arc=fail smtp.client-ip=62.154.208.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=addi-data.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=addi-data.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=addi-data.com header.i=@addi-data.com header.b="PczIYodA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=addi-data.com; s=standard; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MYp7rM0x2Cq+x/7i1aLtXCYeRmqTpNUeVvQD2OUzbKo=; b=PczIYodASDm/9V8K03C96l2jZA
	bAvpWF84OtcWSYhjnTAL91PKiTvUuCK73kdxx5aq25Lssr1vNHYv3lavTLuOa0RkW5qwVPD3PyJTp
	Ho7akQ9BEUxgHNhMuvvV9BtsZo8SAs41tkuZCK+wiphafCpKHiIHS+HEZyjW12cnMcRrxxYVVCEC2
	wmKbhdGqeT/Z3tGnqWhlF2tIs052F+Jce9HZ7ECiQF3CtiH2m9cb+HgfBoQOhEZGBfmHKcEcS0J73
	xSCMkimYVhjHjhrjrSbcq/QCu2MvZTCdORVzDfoytyCJEjLPgO0DDIQi8LAyO7vv8CF8wZBVF8APr
	tBBUMW4A==;
Received: from [172.16.2.41] (port=47642 helo=security01.addi-data.intra)
	by addi-data.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <Magne.Bruno@addi-data.com>)
	id 1vIUfZ-000000003gT-105V;
	Mon, 10 Nov 2025 17:23:05 +0100
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021109.outbound.protection.outlook.com [52.101.65.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by security01.addi-data.intra (MTA) with ESMTPS id 4d4w1z5ZPSz5Hjy2;
	Mon, 10 Nov 2025 17:23:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3ibReiFBymiB/DxmTqEfdZ16ZtDwQoGGxjiqVeChMpU2aWkaNKBl+9kUTyw1P1o5kosGIaU3N9xf5gk/IuqUHk//FsaPsECktQw71iDxH7e1WllH7LXWDsYny3KR94VOJfnBZQB+/mEIWK9jPeBL9kpNncixAxd6aJ/1rvxW7EGFswiCw9LEJTRDlzFLHk69jRfkMC3ppDGXW0Sj4Nddak+DrmrDt0+tG3TZapF7yIt1qiNfl682qHnG69YksCftQiih6n2Zz2i+U9gtJU9Azlz+tgG9VEbzf1xCHJ0q5bg2soKkJv/6xp/pa+V+A/fPYvA9Wd8qimJw3fnUSn9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ6friuexYFJAKSiHcr72HKM7AyO++rpOVLi9El+VHA=;
 b=YzdotAHv0gshvySWpicuvzIOa0fiffTCEXxbR908ouSRTe7hHlZ+ySBOQ5KoLdKwi2Kja1BZ2QtaapX90XYw1dcAcbroIXsI45OxbAbaFnZb98BcLyiaWt9nTr3OIXohOO/0tN8TO8jdQSKJ+S4dPVDYX2QowXKeijKSCWaqzMlpTCTCfoH2CNLly7or/d4+MCLwOZFuPhk4m2EiwRBUJMYNsoNJHVj2QLELq/Ivc8VP9UKWbzpVNnJmbJxbzCpcJ3k/oGxtMbxHPoMq+zFAFTyg8X5CKJxPocIYix4L0QyWw55oWyrE1Nki1pdbmaBP3+E9PzdrVboKGVLhJSHbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=addi-data.com; dmarc=pass action=none
 header.from=addi-data.com; dkim=pass header.d=addi-data.com; arc=none
X-msw-original-dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=addidata.onmicrosoft.com; s=selector1-addidata-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ6friuexYFJAKSiHcr72HKM7AyO++rpOVLi9El+VHA=;
 b=utNAurQqOJfPkP79D+z+nEVmSYzUoF9ob8wHkzePWFqSCNv5RuWmcImDU0Xb9EI3iNFpL03kZgs8Fsrd6XiaWT7pr8xcTs5qUus5OLwbZT1iSGUQrmNALHXTF6n3ETFA8m7iMm8ClQxhbKgfCDt9Pi8RNj99Qoozlrjw1IcG/4k=
Received: from AS2PR08MB9917.eurprd08.prod.outlook.com (2603:10a6:20b:55f::5)
 by GVXPR08MB11445.eurprd08.prod.outlook.com (2603:10a6:150:2c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:23:01 +0000
Received: from AS2PR08MB9917.eurprd08.prod.outlook.com
 ([fe80::df0a:631a:1616:8759]) by AS2PR08MB9917.eurprd08.prod.outlook.com
 ([fe80::df0a:631a:1616:8759%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:23:00 +0000
From: Magne.Bruno <Magne.Bruno@addi-data.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH 001/001] serial: add support of CPCI cards
Thread-Topic: [PATCH 001/001] serial: add support of CPCI cards
Thread-Index: AQHcUPkkysAOv9HL6EWv578Saj8PmrTpg6cAgABiVlCAATKCAIAA/sTA
Date: Mon, 10 Nov 2025 16:23:00 +0000
Message-ID:
 <AS2PR08MB991756D1D031B016C90D397BAACEA@AS2PR08MB9917.eurprd08.prod.outlook.com>
References: <20251108214617.77631-1-magne.bruno@addi-data.com>
 <2025110945-poison-luxurious-7e49@gregkh>
 <AS2PR08MB9917F98E256B2C7A97EA5BFAAAC1A@AS2PR08MB9917.eurprd08.prod.outlook.com>
 <2025111009-whoopee-avalanche-002e@gregkh>
In-Reply-To: <2025111009-whoopee-avalanche-002e@gregkh>
Accept-Language: de-DE, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=addi-data.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR08MB9917:EE_|GVXPR08MB11445:EE_
x-ms-office365-filtering-correlation-id: 0eda7ee0-a478-4457-3a91-08de20756ad9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xRHJ3MSFbqnNGIrLeYhiNmZe78MwZGFMOUpuJ5id364PLiNGpr51ik98UB?=
 =?iso-8859-1?Q?+B5RjwlHfVnVh271UFJNxU3eIbOYt6QCud/vwimieSUOYFQTsy2FClj7wd?=
 =?iso-8859-1?Q?g4aDnW+kzfZjGVc9FGs16l0A8Tj1v3MfikuYsxCA38TI+pcWvK8AxVa9vm?=
 =?iso-8859-1?Q?9/Xpj8cfJFQztth+m9sMObyFxziAFiHVZBifsDgnOXwhQOcg93E7rYalgR?=
 =?iso-8859-1?Q?qT9AASb3oNSHfmcIU/Rc3Bl/ys+7/2JrrnW02n64eLad3hW+Or3Fn6Fm9U?=
 =?iso-8859-1?Q?8RX/4pREESprtca5Mrm2bhl43wUB/Qr3+8GP53XTYMi1l+LJjlaG/gj908?=
 =?iso-8859-1?Q?2mjjfVB5UwrA61x+VEg0VddRysFyc9QF6FOJ39Ka5zr08bSaOYWXAykWDg?=
 =?iso-8859-1?Q?cBONtQo5nY2439wGTuvIXwwQ1Czacd/3lhLvoV8OT3AOKl/lO6WuovEP6+?=
 =?iso-8859-1?Q?R6f30/G+PvXLgge2KgM5kBl1SXXlQms9ZNz/41JF0amsLEiKtFUUdUrPjg?=
 =?iso-8859-1?Q?f9nlANagNdY8DhfCEdPItmO+X9vhu+uBX+qPZTwEwQCQwuK9BASCuAxGUA?=
 =?iso-8859-1?Q?k+haxTZfPoJdxaqjza41IxCwtebWvvYqsFRhPPnV4GgI6AmAtUI/5Zm01a?=
 =?iso-8859-1?Q?Bz8u+0Iwqa88lFM85OJaAFlUivKn2wVO1DUTa3YBgJ+HsVYoEEx+XCiwYK?=
 =?iso-8859-1?Q?Og9bgPgMLMbLEoanqqaD0mC1i5t6iwOclMp3Bz0L3tba/UBkXSUoEkha6a?=
 =?iso-8859-1?Q?mAKz+cfDI7ucZrUjouePUy35FRXEW4y7TzQTNIQxfnB9W9d4DV/7ndo8jJ?=
 =?iso-8859-1?Q?AAJEFToi3OtT7SIXBnllbj5jCkDaJ5JPe+/l7zdUcacWfBomWGman4hbAH?=
 =?iso-8859-1?Q?+GWfsFLAqFdOLsSnndCFpizpFf71blSvuwP9/xGljQmjkXavNBXVyPmrqy?=
 =?iso-8859-1?Q?4BlNRAl1qAfzXcNu4mtCY47Gw9Fr2ghI3NylCgOH7AEaOh0VSwATu0YY+e?=
 =?iso-8859-1?Q?d6tIu3pLhaPbwBJOLV5ZvxqmeGruEQm17xVRiybTVHrCQDnp04uatW0f/7?=
 =?iso-8859-1?Q?3KxqE/P0mFtD/tIMLILoL84/0KLzhd55F0s/C9YHVGxtWpjspUmXTP9ugL?=
 =?iso-8859-1?Q?mQFLuCSjIotQB27jQwRW/TWnsuDF7063hdm1vMahCTU4WduXDvWFOzc8s0?=
 =?iso-8859-1?Q?M6wkH0IQK8oD1b3NodPFwAFTEsKwQ2XvpIL75wF+DxejrC1dfpkAKFbqG1?=
 =?iso-8859-1?Q?PClhd2SnvrpPS8dMdSxAJHKV87h0K/CmcS3IMT/iJhatflTPgoeJF4by3q?=
 =?iso-8859-1?Q?MCJSLqKrc+JagoLooj7h6yX15rUy5bsufTFYtQ7lPbud2ldSPjglWjp/TX?=
 =?iso-8859-1?Q?WjksSpBiJTfSGhudJiG6DqJtfPxFIEi0BgBgeFf8TBXCTsmkJrJYLL1+Xd?=
 =?iso-8859-1?Q?jw2bDq3z4uKV8qXc771HKiVHg6E0Sal7ItZy9MjYZAJpAE18370Wy0AH/g?=
 =?iso-8859-1?Q?RQNJ93w7a/dG5VixYOeUlbD881dy+fxuow1tibrnt1Jrla8U3ADkjpBExW?=
 =?iso-8859-1?Q?Dw/kMY7cxLuZDBDRx8JdZ+bVk47g?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9917.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fgKXa1x2qr4RdeCiVjYHSbyihLW9MSCLCgYfEHl7rDZc8lOZqR4rpyMgCz?=
 =?iso-8859-1?Q?KYFY6C4WXUglEPwgbZ37mOLbsK9EK9dGbxL5UMXTcE7P7w0zDwNkbELb2u?=
 =?iso-8859-1?Q?kUb1ntmuikTGy4rHvxmCAYlH3VH70zxP4mmjL9l3A/wuYOE29r+ju5gk0u?=
 =?iso-8859-1?Q?FAEi4A9M8PNJbES9BmqELuF8lhfCjeznWjrQw9ftecgB8Hoxb23j3jkVxm?=
 =?iso-8859-1?Q?tM9biRdL0j/wZ7UDvk80mmut4xH5AeHDkfxPBKtGzYL37Ube6hAGWwZx1x?=
 =?iso-8859-1?Q?sQ/q/mdpPVz5U7VRgD86EG8eazOAGv2biZknuOSLDsxTLpXzXCX02o1W3K?=
 =?iso-8859-1?Q?EDJDZcqkY+iRmlO92mtNis+Yl6TO0TTqDAzFtT6UsuutidAiL+uuwMUS7T?=
 =?iso-8859-1?Q?nhJMzv+GWvW30lzFzmgdUwiXmtGoheF1GOJXrPkUg/Bg5yDYrr7Fq7qJgf?=
 =?iso-8859-1?Q?M0gSKb6VXZEXEpUqgF4F2tQvR6QRqqs6URKSotuL71hPB1RAuMC3oXjHuE?=
 =?iso-8859-1?Q?0w1mO+Oy9ZABLq252ESfWpcgQqavZGVY2N27VRndyFN9u5kAigKJk50HnU?=
 =?iso-8859-1?Q?2MP1rpOjekuZCnD78akgx3b9H4UZ0fUWORWOd+egiaE3hMH1z//VELMdy7?=
 =?iso-8859-1?Q?FwtJPfMTE6HxTvQls81verNObp96J2gu0mHYaBRAT8bIIeznthNOdKNdfd?=
 =?iso-8859-1?Q?9lL4VCyexBMRKbQ6jbGu7X6OZQq/YNHkB3PbyzhK50zjjhcvtYA1SjR63p?=
 =?iso-8859-1?Q?/vY8nM3zuw4KJi/asn8/B5/2NGfb3KWoH0IWE+s8zT2IlA0liH/h4ZhMMm?=
 =?iso-8859-1?Q?IphLedEGWkx12igFsVbnoa6CzUd4Z2+nZAqWaI/3k2SO3Eb9vtueHLGvhB?=
 =?iso-8859-1?Q?wTBZ3KFHKvWFAL2VEnEwBDRjSq2zTjzoTJQSGswcJ1H/gOpl96xjZH0PcG?=
 =?iso-8859-1?Q?Z3yOai6x+zDNZHGyonjPLSNb+JqU+BhHPtisRxRmn78Y2j3IJi7GcKrblz?=
 =?iso-8859-1?Q?qesV1BtSwTOMySTcrYgC8au+r3+DZN0daVouByRnXm7NrzUTpaeNqr74u2?=
 =?iso-8859-1?Q?XiQEpupulCSnnKGcOZb3SoDNWnDp4aypdMGMGSkIG2aivV0+vwHkCpHCmn?=
 =?iso-8859-1?Q?0qvK4M0j9SdTMAc0phz2jHu/Et7o9KOp5k3x69NliQlsDQ7lryvdxKQXmG?=
 =?iso-8859-1?Q?Gm5dTi5N5eYTbpPvqw6KibB98VzXexz59MtkuWWKCcd4E3p+CYCdTBnJuc?=
 =?iso-8859-1?Q?+r01ffYo69biPpb1xI1FuQXL0Ei42yROd15R7gzCzKO/Fu0MTAV/Ii9aIc?=
 =?iso-8859-1?Q?o8B60si0N9yiG8C5dTajVZ5e4gxlI+vFk5e/7VqCiEEzPf7gdaeOlUkQxF?=
 =?iso-8859-1?Q?pq6P7KnGjxuTaEyFmHdG8l9yYs0suAxgnJuYcURoaHv0+Apdt7M8kIqPMZ?=
 =?iso-8859-1?Q?zNqwj22WzQwGos6dPRWEcZkBbTL7pnAEkc5opIUTeu/g85RmO4qI0VcuWi?=
 =?iso-8859-1?Q?24FvySO89ZeT77WXGFE5maj+q7JzZqV6ycxJdMt9+pD/vtIhIMcj+zFvF9?=
 =?iso-8859-1?Q?/HKezqcWH03TG97JATNYhtorqV1uVB541dF0YPCrZLpnn3uhfheEmTTplY?=
 =?iso-8859-1?Q?MJOQzeR0uhN5dzlk8FRkreOA065Mz7hgGO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: addi-data.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9917.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eda7ee0-a478-4457-3a91-08de20756ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 16:23:00.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 08e9ac5d-a1ac-4651-9388-1e0361912f99
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndnOyc0roV0nigLArj/xjAb5rbWHyNw3O20qXurDWTLVTaLUEGH0j/eX+ze1o8R0Yzkq4sQ63936jX8WmzeA2dp9KEZYaZbxFHpKumlMzWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11445
x-agari-authentication-results: security01.addi-data.intra;
x-msw-jemd-newsletter: false
X-Sophos-OBS: success
X-SASI-Version: Antispam-Engine: 6.0.1, AntispamData: 2025.11.10.152719
X-SASI-RCODE: 200
X-SASI-SpamProbability: 11%
X-SASI-Hits: ARCAUTH_PASSED 0.000000, BODYTEXTP_SIZE_3000_LESS 0.000000,
 BODY_SIZE_2000_2999 0.000000, BODY_SIZE_5000_LESS 0.000000,
 BODY_SIZE_7000_LESS 0.000000, CTE_QUOTED_PRINTABLE 0.000000,
 CT_TP_8859_1 0.000000, FROM_NAME_ONE_WORD 0.050000, HTML_00_01 0.050000,
 HTML_00_10 0.050000, IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
 MSG_THREAD 0.000000, MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
 NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
 RETURN_RECEIPT 0.500000, SUPERLONG_LINE 0.050000, SUSP_DH_NEG 0.000000,
 __ANY_URI 0.000000, __ARCAUTH_DKIM_PASSED 0.000000,
 __ARCAUTH_DMARC_PASSED 0.000000, __ARCAUTH_PASSED 0.000000,
 __ARC_SEAL_MICROSOFT 0.000000, __ARC_SIGNATURE_MICROSOFT 0.000000,
 __BODY_NO_MAILTO 0.000000, __BOUNCE_CHALLENGE_SUBJ 0.000000,
 __BOUNCE_NDR_SUBJ_EXEMPT 0.000000, __BULK_NEGATE 0.000000,
 __CC_NAME 0.000000, __CT 0.000000, __CTE 0.000000,
 __CTYPE_CHARSET_QUOTED 0.000000, __CT_TEXT_PLAIN 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FORWARDED_MSG 0.000000, __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000,
 __HAS_FROM 0.000000, __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000,
 __HAS_X_FF_ASR 0.000000, __HAS_X_FF_ASR_CAT 0.000000,
 __HAS_X_FF_ASR_SFV 0.000000, __HIGHBIT_ASCII_MIX 0.000000,
 __IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000, __MIME_BOUND_CHARSET 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MSGID_32_64_CAPS 0.000000,
 __MULTIPLE_RCPTS_CC_X2 0.000000, __NOTIFICATION_TO 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __PHISH_SPEAR_SUBJ_TEAM 0.000000, __REFERENCES 0.000000,
 __RETURN_RECEIPT_TO 0.000000, __SANE_MSGID 0.000000, __SCAN_D_NEG 0.000000,
 __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
 __SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_END 0.000000,
 __SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000,
 __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
 __TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
 __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000, __URI_NS 0.000000,
 __X_FF_ASR_SCL_NSP 0.000000, __X_FF_ASR_SFV_NSPM 0.000000

Dear Greg,

I did the changes as you suggested. I send another email well formatted wit=
h the right patch.

But what about, the previous #define in include/linux/pci_ids.h ?

#define PCI_DEVICE_ID_ADDIDATA_APCI7500        0x7000
#define PCI_DEVICE_ID_ADDIDATA_APCI7420        0x7001
#define PCI_DEVICE_ID_ADDIDATA_APCI7300        0x7002
#define PCI_DEVICE_ID_ADDIDATA_APCI7500_2      0x7009
#define PCI_DEVICE_ID_ADDIDATA_APCI7420_2      0x700A
#define PCI_DEVICE_ID_ADDIDATA_APCI7300_2      0x700B
#define PCI_DEVICE_ID_ADDIDATA_APCI7500_3      0x700C
#define PCI_DEVICE_ID_ADDIDATA_APCI7420_3      0x700D
#define PCI_DEVICE_ID_ADDIDATA_APCI7300_3      0x700E
#define PCI_DEVICE_ID_ADDIDATA_APCI7800_3      0x700F
#define PCI_DEVICE_ID_ADDIDATA_APCIe7300       0x7010
#define PCI_DEVICE_ID_ADDIDATA_APCIe7420       0x7011
#define PCI_DEVICE_ID_ADDIDATA_APCIe7500       0x7012
#define PCI_DEVICE_ID_ADDIDATA_APCIe7800       0x7013

They are only used in ./drivers/tty/serial/8250/8250_pci.c.

Must we keep them as is or should we move them too ?
=20

However the VendorId must be kept in include/linux/pci_ids.h, because we ar=
e contributing in Comedi driver ./drivers/comedi/

#define PCI_VENDOR_ID_ADDIDATA                 0x15B8


Best Regards
Bruno Magne

-----Message d'origine-----
De=A0: Greg KH <gregkh@linuxfoundation.org>=20
Envoy=E9=A0: lundi 10 novembre 2025 01:59
=C0=A0: Magne.Bruno <Magne.Bruno@addi-data.com>
Cc=A0: jirislaby@kernel.org; linux-serial@vger.kernel.org
Objet=A0: Re: [PATCH 001/001] serial: add support of CPCI cards

On Sun, Nov 09, 2025 at 07:03:14AM +0000, Magne.Bruno wrote:
> Dear Greg,
>=20
> If, we do not add those Ids to the serial driver, the driver will not man=
age automatically our 4 CPCI cards, like it does for PCI and PCIe cards.

I agree, sorry, what I was asking specifically was:

> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index=20
> > 92ffc4373f6d..221a83d4e1ed 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h

This file, look at the top of it.  You shouldn't be adding ids to this file=
 unless they are shared across multiple drivers.  Just add the #defines ins=
tead to the .c file where they are referenced.  So this patch should just b=
e touching one file, not two.

thanks,

greg k-h






ADDI-DATA GmbH - Airport Boulevard B210 - 77836 Rheinm=FCnster (Germany) Am=
tsgericht Mannheim HRB210433 Gesch=E4ftsf=FChrer Ren=E9 Ohlmann
UST-ID-Nr.: DE 143754253 WEEE-Reg.-Nr. DE 65862200

