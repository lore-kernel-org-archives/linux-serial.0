Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19011027.outbound.protection.outlook.com [52.103.74.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F61263F42
	for <linux-serial@vger.kernel.org>; Mon, 24 Mar 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843669; cv=fail; b=oc6ZALaxeMj+xQ1/5cbsgGtcGy8Lzbav3uimliHEWkEmxiSFZLgQtxp9KUoOj6d0tGRRuIesXv/lIGhVDj8C+/jJmCi3cdkyMHI0U1IOiCglxBCl6ptN4sPV9zfcqyYUIdWHdBZtd9h8RxmytaOM9ECP7NRD0ZsmOuag/ph4nFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843669; c=relaxed/simple;
	bh=0W85n6A5vnS5Hmbkupiveqn3PILGQlUPywCoZR4Yrf8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sSEk1mZxsPpAENGGRuRuqnIE9lJ35TSATkKyEt5TfmQAb+er4US3unefiYXtyBK4isKSR9V+t6tidgc+pKPrdmN69k2F8V7kUGK6BiEh/M5ss3RXciY5FBKZZe3ytlEGqlyWWbdYF3NBokrto5Wo9VApEVRp27Kr0QpiRY2c680=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AHfySvcY; arc=fail smtp.client-ip=52.103.74.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AHfySvcY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mo992enwAo6T+41GYYksREZldeOI1TGn5gymyCi7IntddUywtnm+bULG2TSvbtwbeuXzZcD75XfwUV62vLAPgAQpdtQR7tXGlIhcnp3c4lkNoEByAg8UVmnbxtBm6+ylo2731VSS61Xuc+G4PJioW8yfHg45RagOx1xeAWMgc5+sDEAWDoWkGvmrsllolR7ieKBWUQ1i+U+428VJ03JjbsBCHO9EFUl7hH8QByuHlQEKDLniSDwlROletkviLDu6mKxUzjH9SPvn9wynQMdlYYtpqGRJrdZfQoqq91Sac6tznXkOVjj02eOCBWDGc/QsVZdtyAxQK/WYoP5rAUnKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W85n6A5vnS5Hmbkupiveqn3PILGQlUPywCoZR4Yrf8=;
 b=Kss4fIC4pVB5RMdSrP2wWG6a4ZcD3JkfaylAcUOwpcuMp2QoUajBeZ88RD75UZLo3MSkSZCFu8MqEgDB2YA+6W9H6b/ScfvS+0Mip3LB4fG9Ud00b3E6XWUT+Q0XZ0AgT2zXZoKXSJJhfqfm18aNM6QVahhmk+BVZALSEzSwKjqIjhHA6LKQXvh/5DpinxPLDofAVhwMjezYsvmwVi5YG63pXW7u2QPHzp02Oaqq07nrJJMVo1h2dlBndJDbbGvWGdrAF+QXmw/Oq6HxCEXiSxaeDaxvZAcck9E85xL+75VVE0+b+m3SFskVhdYxpN5o6PwSe76UwbPqHtjLeEFGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W85n6A5vnS5Hmbkupiveqn3PILGQlUPywCoZR4Yrf8=;
 b=AHfySvcYjgGYhsdwbMJHUjeC6DH72zuFoQ1k19y16ZZlqok5J+cvs/YjOzy8uBLxZpk/nwbalKu2a1jJrW6VpgC5IJ9ELbWvtuQtpWa4Y9q+K5a5OQ5wTqldG0f4G2j+UzobqETPnSuUraVUXk3ZQJq22xHXTBwsmZl3JxzUEDuxxNnDBb19QVz9fAYPrK4R8mocRawVTu+Sp3DGD/1B5d5p9pEBhbj8O+rPbejTXo4QsZCMExcbCR3VSAa9WSmrPdo/jpNatj+2NunH4D7jnMbFyJhhigJIiqHpcWRHpED5Hn5piZxFb2Hpzec6fBifB2Q8JnPc87yAlRxAqr6tAg==
Received: from SL2P216MB1157.KORP216.PROD.OUTLOOK.COM (2603:1096:101:4::11) by
 SE1P216MB1863.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 19:14:24 +0000
Received: from SL2P216MB1157.KORP216.PROD.OUTLOOK.COM
 ([fe80::99c5:912d:7db1:8af4]) by SL2P216MB1157.KORP216.PROD.OUTLOOK.COM
 ([fe80::99c5:912d:7db1:8af4%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:14:24 +0000
From: Lexie Hewitt <lexie.b2bleadlp@outlook.com>
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject:
 =?Windows-1252?Q?ProMat_2025_Attendees_Database_=96_Expand_Your_Reach?=
Thread-Topic:
 =?Windows-1252?Q?ProMat_2025_Attendees_Database_=96_Expand_Your_Reach?=
Thread-Index: Aducxpe/3VuyFealQfmqdi/1m5hyBw==
Date: Mon, 24 Mar 2025 19:14:24 +0000
Message-ID:
 <SL2P216MB1157F0A17F395F146FAE2CE3ADA42@SL2P216MB1157.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1157:EE_|SE1P216MB1863:EE_
x-ms-office365-filtering-correlation-id: 78a26f3f-5cce-47bf-4a5c-08dd6b081725
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|461199028|8062599003|3412199025|440099028|102099032|41001999003;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?8TRDC/ncGQDbsARJBD/4APZzrqgcfgObSoQ1qm7R8uqlQms88IObbKQ0?=
 =?Windows-1252?Q?8bfxiA1O2PqhSMMNM7BZNhCy6A9ZQMVIcctlWR6GftOucrUwKKBklqds?=
 =?Windows-1252?Q?6Ndk9aqfydvNoXvX/b3qps2YM8x2e9Qdrb5Q+bgJFLIwOU0p1ftQq/+6?=
 =?Windows-1252?Q?x9RqL7LdY7A0y3rj8wvIyDxrxBazTxeNnjSJ/MtAIBr83P1x9GljcdoD?=
 =?Windows-1252?Q?t5MFOjOZ4MWP28Oi5cngPnbjtwBNTWh/LE/ctLBYe2K0WvGU21YI08Mw?=
 =?Windows-1252?Q?uSiIXphT3IBO7UGbiRX3RqeLREV6ENy7WjZHWReeBI/BBZNXg6D8To72?=
 =?Windows-1252?Q?oL+BVM8tEjLICqrw+fnU6GwgRCPLJTELQXOAuxbeVgLEw0GlSz4g0+AZ?=
 =?Windows-1252?Q?WL7+5Uc8gkHo5/7MlDQnYfbPUGyXFBx1jYRf6mVYtHunp1Hcs/89tSIz?=
 =?Windows-1252?Q?cqPQIYZJWnfs5MLopNjJ/0g9CXIRMxCiKKqNd/H+JxWjpb1zfbWHhdai?=
 =?Windows-1252?Q?CnqvO4ZHmrree8hQ0jWbF3M2tW7eBcBllzawSeIPOBtzX6Px3hzt3oqr?=
 =?Windows-1252?Q?Mhx7yKn33JwM9FKKO5mFCFCGxf1AEsmV1cb6VoR4Ov5cUpSdUz/49XWz?=
 =?Windows-1252?Q?o0t0TcdaLlfIwYkUezjrVR2WS81su2JZRBEpUWgcF+xa39CC1LPjBJmR?=
 =?Windows-1252?Q?2U9B5WPbNReBeRCTYUXwK/qUi69kD1XU43Mm1FhalgAJmxzZJTspt4bY?=
 =?Windows-1252?Q?VIi5jyulasC/D+7GVJ28YqU/tJ9uO6ss7cAFN3o5BxbNIaeKvkyou5Hz?=
 =?Windows-1252?Q?B+0N5qZF2qDfJBgUXM2b5oBmWXb0SuX607vFlNbxRMeZim8FR49U/kyS?=
 =?Windows-1252?Q?3HiyVWNVJz98JYcRItwgHRIEUHjyAOpjGDW3Myr0qFVB9AsUsgHJnope?=
 =?Windows-1252?Q?7GNqVLdbxBsmiBWhJDp025iUbnvOnlFvnXyQbpi1wd+Zxh7CxLXCLrFk?=
 =?Windows-1252?Q?e17siPpAGHMuqWe+fJTE6w6PhwAi7vlyNGVcG2us2ZbWeLzCpIlajJba?=
 =?Windows-1252?Q?a9k0AxJ9HlPiYNmLouEYR+FkVnsMaWbhEZxbsPDGLbjIN04jHRpv15kW?=
 =?Windows-1252?Q?Xw6qFZFLH379YJd39OjQ1RmLjBQtX/VQ3Psi+GwCbCUcpWemjEnhkPtk?=
 =?Windows-1252?Q?uzoKk4YkLKU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?BTolOB+NMTSPqUYcR3a1BS4dR4og2xTRSgGCKgw0+CRMWJtMH2b9BI0c?=
 =?Windows-1252?Q?WDMu4UU9Yd56MJGToyQvpNgIUlIVLEfeaeJ0bICLbBa+8keFCoC0yalV?=
 =?Windows-1252?Q?9QlXodp2gQwd7DSlQDl/eEIjajXX0RfgRAdcAKAA6TH7Az0e9ab5xB2G?=
 =?Windows-1252?Q?1/koyRwa8Bp/qdcchzZlXNWigOMZssS9Jsn/16oB6OZhyETqX1/q+qqS?=
 =?Windows-1252?Q?wrfNrIzE2JtPFgxDV+7LcGKJ1AovW5xisEb4HCk8GOkN1WEZYbr11b/Z?=
 =?Windows-1252?Q?/3cr0mZ5bia6KD05vBVPXuCQGuusLPP1iLhH2QowHa6wjmvIk530pCM6?=
 =?Windows-1252?Q?vvlHe1+sW6vxhghF39MVGAP+ie7+CQO7UbapOjTYaANS+9JpnerajMvr?=
 =?Windows-1252?Q?KaStL/TGMfmc3OeovR9jWT8n3VkStCPXVcuvdpxc6BPRdRh2fHnidWNr?=
 =?Windows-1252?Q?tDZPLyyGpRAKGjf696qZdM1y9nE1tVfQCQd0D/jj/zlPL93s2abS2TO6?=
 =?Windows-1252?Q?1MLf/eTdXE7V0f4H472WoFZwn8mr4WTye0C1Bj8btaq0jbNMQ44ANQex?=
 =?Windows-1252?Q?9GHehTK1lkKFDf0Z72jYqDBKQP5FyYFEH1f/2r4PlDbpsirBxTJxESK8?=
 =?Windows-1252?Q?F11XIQ2BqiD3RNEaCjmx5Sld0AZJ2xTzpe8IQT1SgYnOKy0DR1+GAZfe?=
 =?Windows-1252?Q?keYva+4jptBZtbvlohGwPxm/o+8mcLu6sirJVZv0D1ye936OEzy9iOHJ?=
 =?Windows-1252?Q?ADRHMx4OIcACXoQGn1rq6gbT7VTiFXrOF9h9bx70+udiZ7BdokB2W55b?=
 =?Windows-1252?Q?xTEZh9MBSvqTVPbO+xOpe5ZCVyWXZHleZpXXf58lmsJ1iaVo9CkTmLB9?=
 =?Windows-1252?Q?sc7gAJVgWe4PJjgWFs5j4tmlJspUKZTQmqN28omTyxN/BH0U1QZthdd5?=
 =?Windows-1252?Q?YkMbMhyfs6Ek0U8M+j26YzPgOkT9oUvMjCcxpkYU+/WLepn5VAh0yQZJ?=
 =?Windows-1252?Q?El6C/Tc/n6W4fNSijQ2njRWFGjhq6k0wDSspEDG7nycWJ2qK6dYeAjyd?=
 =?Windows-1252?Q?AiZIubxI1Azy0QO9lVLIMlJajIffmV90EswTYyWYmFnWTx1AHYXmOXQW?=
 =?Windows-1252?Q?upH2rPfpqgCTSz4CT2ucHYOHoN9VK4LRp1xgYPNycvL+IkITyOQeTfYe?=
 =?Windows-1252?Q?CbB9KUhuFJ5NyIPDCzVHsjLQ4bn5LaR9EbrvRJsy4lRR3R0yKfy/9uEU?=
 =?Windows-1252?Q?fagyui98YcCPpDjxVv4wYiRthSV6YuvoR4odlkRfKIM8lnTKvDC2Xr98?=
 =?Windows-1252?Q?OzwmiuZJ4sFmA24Q/Lfv/Ep+GZ3OX3j3xLayqxV5XO7yO0o+PJq63wSN?=
 =?Windows-1252?Q?2EuCxCulZXE2EbLlX004gYI+n7TlahgupTPOqx3eF+i21emQ6J+HcGrj?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1157.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a26f3f-5cce-47bf-4a5c-08dd6b081725
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 19:14:24.8223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1863

Hi ,
=A0
Have you thought about obtaining the ProMat 2025 attendee list?
=A0
Expo Name: =A0ProMat Expo 2025
Total Number of records: 35,000 records=20
List includes: Company Name, Contact Name, Job Title, Mailing Address, Phon=
e, Emails, etc.
=A0
Are you thinking about purchasing these leads? I can provide the pricing de=
tails.
=A0
Awaiting your comments
=A0
Regards
Lexie Hewitt
Demand Generation Manager
B2B Leads LP Inc.,
=A0
Please reply with REMOVE if you don=92t wish to receive further emails
