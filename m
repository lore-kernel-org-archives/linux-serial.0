Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2036.outbound.protection.outlook.com [40.92.57.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71114EEDE;
	Sun, 23 Feb 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740348466; cv=fail; b=YfVIngIakh6N+AhKisFId+6moTA/S+s/X0KX59aSmkm8IIHEDtRkCTQiQyaELdtRFi7SJNtqe5QRWpeo25Sg54ahLGSsFD9a/SOOBTZGv7i3GiJ0LrwPvoF+A70eyyej2M3PvTvcxoU5AWckVc0xsFh0W+yt6QcHJ4v1xvfsArQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740348466; c=relaxed/simple;
	bh=lsPYDRcbfYid7OxvKWUlzDz1/FhLndayVms5NR1hk5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EwfIT0GIpLkzVZ2lhaaY9S5599bgWFXZIN/sRXA3ZhapxPh/sW3W9MDStReBigykG7+BNxJ7krmYAhjBrwB5uSLBxGJX2+WJRsCJq2BgO+QBGma8j7SnJ6MTD8LyUHckh2y2vJZ2g8wErIsm3c65BlruwC92gVVBwfetGuDiHK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b=Nafe+4k0; arc=fail smtp.client-ip=40.92.57.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b="Nafe+4k0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+xhsSWIXCS1pEaVVR1GJPPWUDvmYdnVWIHTd8Cxp3LP8o9GkPYA9+vhUGK3eHBtz3G2/4hXwDcp2iQ3KLEQIP6Qr68TXRiXW6WHoYhGnspsT42k5wmj7EewhkR4fop7y9SQdNt9lkM+t1dGo284kn7AkXuolH/w4esB4vvR146x+DbV8v1uAptwsek7iOhvE1ENVEqVdj7Y0YAmG279fy5GNK23cTI5+wzqGDkE1DInJMxSWvQgnW4MrdZ+7udF/iTs3KA3oEzrgHhSYKrvXVRoaFYhEzwwpZRzG1YP4uGS25GvU8/41sbdZFRT4luqpJlXVnX1R2JimRB7mdg+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrHoDS/9Lifa87FFtg0El0zyPxyAcmDrVJfFKIzn4GU=;
 b=XCyE9zGkyguYuUeSFSwqY391uHwFrML/NVbpS1KAO6ttBNZ/I6q2IxxxnFk+oSh3ZYdMtzQFcnwL5fvCPviGz0FwYNvINQzLGlS7Wf+FUwLu3y7vucrH63QzDuyE69lg4+xWhxe6i+/CkaaKQByjAOwWgNW8YwYEKt3HINnmWa4ifpbjkeXz6IQwQC0vtv5yFTkBYc5PXNS+DeULixaLvqpxN36dNEMcvRfBY9FO+EeB+ccaBNMbrRzp+rdVm4FHOC4hRKU1G8YeUlQwIw8AcN2O5LA/Z0neBvG9AhQ4ECLQFvV8J7G91x5XBhERkCux5NJKKceRIeHuiMpNr7VI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrHoDS/9Lifa87FFtg0El0zyPxyAcmDrVJfFKIzn4GU=;
 b=Nafe+4k07ajVa6d5hxqY8FxCCAiNhRb+SXlqv/EvNyZL0sMCWCaEdDLgRJ78p3l4JBjdBBozKQH19e/ytimf78cQ7yBKjENkVTgmZEtci4W4l0/EyE6nQZd976bxtWbHLgWaO6m9d0UMU2k/8q1gunJDvRnAg77/pHrFMKJNBrByzasILbV4sMb+xrJz4FjANH25YP2nXupAa3h2FTtmetbJupAE2xnqU9f1G82xX12qzv1d7BOojNEcbFA6FyqbJ5Bxs6zsmyYVipEuw/6s9j1n61l2Hm0ZEij5SacpvqSxzXSpTlUHtEfhqRPt3qmrghUPnmEOHkd9rdr/U8cNkA==
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com (2603:10a6:5:3::15) by
 DU5PR02MB10550.eurprd02.prod.outlook.com (2603:10a6:10:51a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sun, 23 Feb
 2025 22:07:41 +0000
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963]) by DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963%5]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 22:07:41 +0000
Date: Sun, 23 Feb 2025 22:07:38 +0000
From: Cameron Williams <cang1@live.co.uk>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: 8250: Add some more device IDs
Message-ID:
 <DB7PR02MB380295BCC879CCF91315AC38C4C12@DB7PR02MB3802.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO4P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::11) To DB7PR02MB3802.eurprd02.prod.outlook.com
 (2603:10a6:5:3::15)
X-Microsoft-Original-Message-ID: <Z7ucKgeWUNPkiujp@CHIHIRO>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR02MB3802:EE_|DU5PR02MB10550:EE_
X-MS-Office365-Filtering-Correlation-Id: 054d38cf-c877-4def-ed10-08dd54567dcd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|19110799003|15080799006|5072599009|8060799006|6090799003|461199028|5062599005|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5VX0dcKzZGVNSVRAFFalF6VurfLsidKj/iQEoyAM84iObuUg7oST4ZA1g+ep?=
 =?us-ascii?Q?TnmJdzMKoRTXuKKGU3CBKrEldEBSzYkD0iBU/wMQXyJfR/lsZMUkRUEnQH7K?=
 =?us-ascii?Q?V5/7TJKhKJzU4oQxnLO9gaY6nuuA/FsqzN0WThWK/A5GpH0FR7Xaip5dmZwf?=
 =?us-ascii?Q?Y5maNmWoI1Lyn+FwoUfzcU2fvkPzCxEwNT6dL7Ys1ZaMhkuDMWpiw3YXXwDx?=
 =?us-ascii?Q?z54zkEh2F1xLG6UejhQUvpOwqsSZsBYFTYSTFsvAdBz3j0NNrwXrxvZS8R4f?=
 =?us-ascii?Q?oL5XC8iVtvTS0MOUgeit14MZ2mN85lNxoO5pgDIOo+CAbYoPxS/mYAhUG53K?=
 =?us-ascii?Q?09gcVB+Fxa7LhwcNAaLN/AX1wwWA07vxfF8ZzTFmadi3zGn83LNcsNQa1fnI?=
 =?us-ascii?Q?SkgtH06EeDjm37LmrB28lMgQ/qtCx6yScj8lGjiQCSbgrfYS6q1TmUbjj+ip?=
 =?us-ascii?Q?TWmk7GTwh41iXf7V3Cw6qvS2l5Vi10Sez8dLSDQYSYtEnTfQN6dsn8PDrQW1?=
 =?us-ascii?Q?/ya2zsWuRj9G4i62+IVKfZww5mMjPIHZB+YOxGc4c0OHV8lNiem8M2hLLn0T?=
 =?us-ascii?Q?bAJwJY04klEmBK7v9odCe+f5zzwwfwkRA95WX/RPrlr3qyRrJ5z9l2Y1Yg+8?=
 =?us-ascii?Q?85loWEzzV/qtG9k9HOAebNXC7s5Zw0M1MPhXle5rjCa5t2oRc89iBx90EWsy?=
 =?us-ascii?Q?BOK8cy+1lqgwc4QfYYgThOuP0T8LL+9hPKR57gFGLvsf+QT64sSwPqzDcDl/?=
 =?us-ascii?Q?pDf3x9FXjGMtSIItCUkRuGaU5IBgaZ9Lr/QZxOoKVhK305GpPBZoaOr79Eqg?=
 =?us-ascii?Q?BAhndVosIxwdUGCW/RK+Zy82ZQ/14Moqv/eScW1Aqzq15Jh3XfxhcBoqSlZB?=
 =?us-ascii?Q?wPSUoBseQ4Pwlb4Urcmyupfi5dIOkuRuJQisnCk3BIS9hoHBjO8ED8Q9UMho?=
 =?us-ascii?Q?94N/wx7rKjXQTImxXtolJ5D7uwPalXFYiUP+uutxUK4FsaekjSJSLiiyLC4f?=
 =?us-ascii?Q?a1pyC01R7lh/T1J2ODake/rBOuWNRqbQPG5k8WxPjPxp/pQjB0ukLu/svlyV?=
 =?us-ascii?Q?nCxSWXghWsti/IPVCSE8wtY3Gjy+dkpo8mOagoBjUJltWUCz3In2YPqimEGq?=
 =?us-ascii?Q?p6niSAY0A5B3tl7i1Il91vYwNjiJtR8SXw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MLsWIN98CabZ7if4zu7vfapW3acetGKun7CEQwNagFwlLJYOlQMKtd+lPOsE?=
 =?us-ascii?Q?R6uBUbccAoaI9XKAyMmcQjol+XeFniIIvorsp5/AgnzSd//Kfjxtrwb/zGbz?=
 =?us-ascii?Q?vm//7UYGFDSrQHVM26viXg+yoBKBOXyXz73sKn5uk1xt1SZQ4LD+egLzYaUl?=
 =?us-ascii?Q?LJ8g9od+LMDtx07wo1VygIIcEiraiXjmfiBiqDJhtizpJ+i3RqlSMk+JQpRS?=
 =?us-ascii?Q?bR+kC2JAEhhcA01YP3zHdloSC4TFZhmZf1rvzW0PNQqcgBJMBD8MsgSLCSZ4?=
 =?us-ascii?Q?H8ChAdxWMVxk2WLBuJchOraNVjvDfS7iRj1sTHDdj2gh26q7drFM+0mKtqq3?=
 =?us-ascii?Q?ceBojcueNtKNq+GmoKCsZAG8lopj4T7NlKAgLQPHin1v+Af2fBMlJVzrwpuE?=
 =?us-ascii?Q?JDmAkc4fmn66I1ezwTbBMVegLHQqAeFburXtMybV5gSVWWnB9/BGWAKlbDUs?=
 =?us-ascii?Q?ggxoiG8a7idvZVB1GS4uydM1Y3uIraA7E7+i5VgFeJneo13w18TqMvMw3ksr?=
 =?us-ascii?Q?YQO8ijhibDazhs99rdmnnHaS8CUFbAZ2ATpH+FHGCcdJxjFRN6Z4sFWD2VoV?=
 =?us-ascii?Q?JpronkhYY2Oqm+8r8XL9KsObtoAV7brVY1rQSABRJRn6hqqHnk28PyEbN3Kg?=
 =?us-ascii?Q?H4sq38PICaaFsXFlsJQ6XMs8DaZUmb1psRoqs6BnPTZxkVv41fIqMbN18yQo?=
 =?us-ascii?Q?LH3JhXblx7ySI3yUcxcfsor5RAyLz5kurg0klc6xlAyZHyHlQAQTIYOlvtBE?=
 =?us-ascii?Q?e49eETAFx27fisWiJMViozzaKaQXrOp6RF8ofXvikKn7vuqvVFwR1uilsS5j?=
 =?us-ascii?Q?/igYCQT0POJuH/HMI6BXRwxeJXVx3SBYanuTEPosa/IpnRVLQAIFrW3RHU5L?=
 =?us-ascii?Q?0yQ6JASXGnWtajoWuflk87g36snB0z5IUWpFPsSI/McuHjMFun3PGfPAHVu+?=
 =?us-ascii?Q?vPmrncIBsxV9xhfu0jhDMOkyz7D4XT3NN9N5uwOn3BWSu4CE6eqUP0sZAkQa?=
 =?us-ascii?Q?Va7WcUgIWfz2brfUA8/1W0KfBn6xvR/U2kBSwk0PxKzT5wOKcCT8O6BP1t8S?=
 =?us-ascii?Q?vtXBF2rRTRW5zirdjK4+avwau2/InJOgYl4N0PGwKib0ADEy1SfjNLEyprRd?=
 =?us-ascii?Q?8CFYEyNG7VZShIgFxMRLiWsHLXJF9N7iuivbi9Bw2zWCDWh9vx0pSacmLyvt?=
 =?us-ascii?Q?jz7Kvg5X418N9HnZymX7g/eOtzp9XfFOn/nkvChy95psA2I9RrL6gvsbXw0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 054d38cf-c877-4def-ed10-08dd54567dcd
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB3802.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 22:07:41.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10550

These card IDs got missed the first time around.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 drivers/tty/serial/8250/8250_pci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index df4d0d832..37a5df725 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5253,6 +5253,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-235/246
 	 */
@@ -5373,6 +5381,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C42,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C43,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	/*
 	 * Brainboxes UC-420
 	 */
-- 
2.48.1

