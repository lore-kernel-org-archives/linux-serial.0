Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2104.outbound.protection.outlook.com [40.92.50.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02BD1DF24A;
	Mon, 10 Mar 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645639; cv=fail; b=Y4MIMr/EnSGsRDBtgF7RrljP+aoB26jwUT7od92WgYg/X1hZK5Pac2GWhIpUqj4xIsnll8Qp51Lr37c+j3MQevg0HDcTTb8VEn2bqOMC79dGLG/tUH7cRJHd/1083cQtQaWfuC1pgIybi+6G83mZ11sNWSGnKKC3X/lMVD1oOcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645639; c=relaxed/simple;
	bh=MoXp8xna9SQiTo7cxRumdehFudca/kmcwAvwlSj3qk4=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=pE22mh6hhVxjotL9RneCPYQAH2Ps+COQYUiuMvOyukSQYvnCNIp49/QcQ358O/03M/EjYiCy6/mjy6OgSq8zHsmaRDqkiAmnO7NRJCb4EvgGsVrHBfCLVE90RJvAwAhnpcGsNtBTA9+7jpXmUc2nkrMY2g1DjeDZBm4o96Pj9Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b=pscu8baT; arc=fail smtp.client-ip=40.92.50.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b="pscu8baT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KufaLQlfDFYUMobKQw+EMIAwoexqoIIRpe3EOg1Shg+g80TmnjX+bKaaK9Uqhj5WTwEmiLcd8w779sHZTiqfEAsD2No3qECaD7RN7kc1x3DkdjZ74KbY9FiRmwuSoQ6yOWJ/WYangcYJY2IDQYxMfu7aQZxiRbrsXmPlPh6vAzicoa2ppkiEStPcH3KcQwW+iK0vuG5yKZw1K4XuFtfR2AYgBQMwZaV6HukFFlzUIJ0yAu8EAMSrVdnJPHf9O9WmCIladn1pzYU1Uzm7QI/vAEBb7UfGLAsyfVXgkizky0tuErsjX/rDaepKpTDUNOWc5ttdFwGEC8Vho0APC5ZqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOpwvqXYsRHui8MHFp8cUTTj/YU4qAwBfLo1Blc3IFs=;
 b=hoL+8Shdc+RrSpPYTWUOdn1Ri7TpgwpFxBn5RvLllpw8mII5WXNfP/pMAz12Bgmb2NjxVoDY5i98uNe2iFAyNrSIvh+XA6qYG38MHCZNUKzNYZxQjEkyOzR9iELZZnVcTSzheLj+cvzolOkm58eHA0eKeGmeT7T2nBJsB5qcXegvcHDBZKlLsq6h2oHUJHHb/GCN7rZxE19OnprIkfWkUK58VzMkc2yH1OeWLMFMAkXTtBnm8BPkGaRp+5QvDUA7crImphomUz1YsUtsfobRRgl4z/5xyjz7iSbc+7LR3mbpdH+0tDY7p9ZKDzjTGyXNlt4RXtEo8QlVW2G76L6eAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOpwvqXYsRHui8MHFp8cUTTj/YU4qAwBfLo1Blc3IFs=;
 b=pscu8baTCan7s0GQj4lGWVcN9EVPFxNCA48yyZ85cRf/3Rgbf0h3D2uouWOTtJXKKXcmGLmBX86dJaaYKAxeam+HO8BA7tkkK1It3/63XXICVPThxHHFv+ykboupBsteqpI0iNtTIYrhGRGzLfNczo0hpGqAh+ddWWsKQ1dw90/7ExfkJI4F9ELE6UhqijxSwxT7ZtZJLZc9hW4YXMTeFVH8F4TH/PM1/LPiVuGQKfavtaGSC/yrPF+bol6ei1azWiyUAAEAce32fKpoMLVGcvPkqY7Ucafls5Sdml43MFPzJT2w5OOtmCI/imYNBV9OSIt886xKm6S2W6zGH7ye8A==
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com (2603:10a6:5:3::15) by
 AS8PR02MB9091.eurprd02.prod.outlook.com (2603:10a6:20b:5b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:27:14 +0000
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963]) by DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 22:27:14 +0000
Date: Mon, 10 Mar 2025 22:27:10 +0000
From: Cameron Williams <cang1@live.co.uk>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: 8250: Add Brainboxes XC devices
Message-ID:
 <DB7PR02MB3802907A9360F27F6CD67AAFC4D62@DB7PR02MB3802.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO3P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::13) To DB7PR02MB3802.eurprd02.prod.outlook.com
 (2603:10a6:5:3::15)
X-Microsoft-Original-Message-ID: <Z89nPiABC77Vm4Vn@CHIHIRO>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR02MB3802:EE_|AS8PR02MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 50339682-e8a7-4194-575a-08dd6022b3f7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|15080799006|461199028|5062599005|7092599003|5072599009|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E5Nvzc9+9E2bnUtJStRZzSpeE7XU5GNhOuDK65eqLXoRrw4k++GbX1eYea37?=
 =?us-ascii?Q?HW7Jg64wWM1Wxsg6yLtAvxGTNVSQVWdko2x5asXFOpvHwViCouAKZiB57xy8?=
 =?us-ascii?Q?et1G/wuz20gMg/YV7JAUptyIT/jlrBmPBoKejP9+DWvPGb3D0raTclp2BTB6?=
 =?us-ascii?Q?/Qy8QU0crJAL+SJP86bdBsZYTaF0KOHMWuwBookuWT2MWKOxXDWTtnBv85hS?=
 =?us-ascii?Q?jlrPKEiOQaveiDIogVJJ7y5SbKn4dXsOdAgmYl9+dZB9WE1drV9PJ0GfQ+Mh?=
 =?us-ascii?Q?Uw9fSPrmiqsho36N7GxvMen/ipCa6M+mhNOiBC4MqGidG6O+vZup3a6i4csH?=
 =?us-ascii?Q?vxU82TaInmgyGiXt7AV7wvHbwTfQd/vzuYhSMwFKyULq4SMqaoRu8ljwUC5O?=
 =?us-ascii?Q?3LYK2m1bsgev4o3Qv7BNYOMj//uDmGLpOyYLuMbNksr4pQSyNU8vr/HK15DF?=
 =?us-ascii?Q?ieSMLFdRhZ2vR0VjRt8sNoHwISPiBiWGJSLpUR/sScnfz2ZPhyT2kut/zYlo?=
 =?us-ascii?Q?d9CMm5y0Y4eUuNNco7VCRMYsZmR1d+/vQEo2BocDUV+WhkRKRP3ozAPZq+Qx?=
 =?us-ascii?Q?z6AYlKIv5kKvMrjQolrYYfnS4mhEbqnSmFxvS4+DCOyMFJQK5voOgyvDxv9Z?=
 =?us-ascii?Q?E4lmsadrcAYsLQpdw7pksRrLbDGgKe0RshUdt72/0g2g60Votn4nIlRcCfYK?=
 =?us-ascii?Q?JqGXf0lRFfQwJ83SmbU4aUu7rI54s5BzkjMzfMBpWS7jlUJC0MKD3I6op/uV?=
 =?us-ascii?Q?JQrM0z6Y21VV8CmNlD75BqzM/LTY0Y6cy6qI5nxrGfcZ89L9sRkjbgu8s/OM?=
 =?us-ascii?Q?dxVR2CwoTUMMeZtoeq9Usf1ykx7JiHu0k7WIeYfo+9yPl0xqguqnAyqE9w1G?=
 =?us-ascii?Q?pkp8eSPzBSKHC+8ZLGsOkCrh2z5UpGa54QglE8wC6IbBGojjXIQ1tiB7h6gs?=
 =?us-ascii?Q?kQVqUYgk3YkBWhZP63F5e++n6NQsADuL/0rRAZnSHuuAkKz7e26kaKFjP9s1?=
 =?us-ascii?Q?HAMyrisKAxY9G80eBaTvY4YN22+nwUadIZoKigjW9IY0GDzXQelX/i8HhbCM?=
 =?us-ascii?Q?0QF9vvC4ib2TvBl0DTYYCraMGUiz6EI6tPlKKkdGEVBRtofeEjCKzzyFah2X?=
 =?us-ascii?Q?He2Z7foO+Byo9xL+M9Z+9VqZzzH5zfTkkg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vuN6r8KYa070wKZN27oOzA+A6CyBFysq/RfeTwWiPQL658OWuXsCuGcy9dx7?=
 =?us-ascii?Q?d/pL+D2aGcl3tqcyfNV0+LceQoDaczJXlQNJgc5DKjZ47iYSUGVlWoEH4xsS?=
 =?us-ascii?Q?/5nAxNhmycYuRDeykY8vYW19In6Oym6pyJoZbtsOZV8q5Ud7I6DA/B4HnoFH?=
 =?us-ascii?Q?PohNkoeNvOhi2vEKBcSNT04m8LuEDnDEcSn/hmVwNyYE2f+rUe2Qz79dEEZU?=
 =?us-ascii?Q?ilvTjihr6LbALNokJlgulNOlb6MaUnyOKDSkwyqkt9eojioCHYXZoo4iFFUU?=
 =?us-ascii?Q?bmoaGQN68FnEloC4TIsZLzWsR+y9rnfN8OgnDILsjaWr+zCwInkUJCfEjMML?=
 =?us-ascii?Q?kYgOJM5OF/p9mV9Z6/GYhSKevdVkjiHjy8xua5eU0eYsxX7yEQnh/6TDVtYA?=
 =?us-ascii?Q?SrpkWSs9Q19Sq1d0nB3jzXwmnVW9qfgSAaBbLdIdJO4E7fq8lFdqafKNUb1e?=
 =?us-ascii?Q?ATnCUaAKOQH9JEqsw1zhmNwy/2mtbI65Ce8w1/DC+kwZCU/Wmt3abRoiEOce?=
 =?us-ascii?Q?h6GtLWf9/7V8Yh4aBsghV//sVmLrNXG67/wDqnXhk6IFWo3x+W15BuUJj02m?=
 =?us-ascii?Q?aJi4JrwQlT4uiZnQ0mD5HK4C8DDDp/jd6Xh37lw/zSx02X/jhTi68orevMLW?=
 =?us-ascii?Q?EfG2eeKIXvb0l3hAwtaZHUHwxdmgTWvBRm/nID53NRKpcxg2sp/niAXsyw4e?=
 =?us-ascii?Q?/ckKdG/GOQAyg3UdpfqzMIARnc/qJtMdXEigHXquDYEDUZfCy8n/1Uu0FVt+?=
 =?us-ascii?Q?q6/clMVi87O5iKIW+1mVfMfbZzoFdSCuQBA6yaMhiAx0azcC0AvYXNdAYz2X?=
 =?us-ascii?Q?Em9wCeygw1k6OmPqwR+x3cBb2uLPBo5XQB8zyeRgxpLDs6qVYom5zNXN3bMv?=
 =?us-ascii?Q?GAO/pznqJSwxektqpi2RSuvSxchhIADzuYdHej7jaES6Icd4EE1F5jzbFoXt?=
 =?us-ascii?Q?HoV7PWSJHqToVF6oHe0EKbzZHLPAVpQ7nhIv++Tl6q5926mR3J0gAlAr9Uao?=
 =?us-ascii?Q?qW0MTsiAfH9Q41grJuUXZCvbh1W8xQi5GcDBPHXvqWKXFZG+SYx8FRD13yIZ?=
 =?us-ascii?Q?4yUeDnjNf/PWc/gXSM+1hRQvCVZ56Ui+S15w6jWzB1tAiTKRyj2blwWQHLeV?=
 =?us-ascii?Q?TuGhd48keBwBioqtg/bXCfNtbkJKcgj7v6FRn1hOp828xJzK5x19dl2NsTXP?=
 =?us-ascii?Q?ITBiKWnrp79u3ogAJOIXwYnRfunnr4sExUU84BytQlCdwuQ+aBIR6ys+2eM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 50339682-e8a7-4194-575a-08dd6022b3f7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB3802.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:27:12.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9091

These ExpressCard devices use the OxPCIE chip and can be used with
this driver.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 drivers/tty/serial/8250/8250_pci.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index df4d0d832..911774fb8 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2727,6 +2727,22 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init		= pci_oxsemi_tornado_init,
 		.setup		= pci_oxsemi_tornado_setup,
 	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4026,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4021,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8811,
@@ -5599,6 +5615,20 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_oxsemi_1_15625000 },
+	/*
+	 * Brainboxes XC-235
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4026,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * Brainboxes XC-475
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4021,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
 
 	/*
 	 * Perle PCI-RAS cards
-- 
2.48.1

