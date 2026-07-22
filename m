Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013046.outbound.protection.outlook.com [52.101.127.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41D3E929C;
	Wed, 22 Jul 2026 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692024; cv=fail; b=pQ4vktizP4TtvWGBDIVqrTuOVtuMXaNf1S/qHgIiF66EyUQhU08ijsFO/YNSOvZrUnTgT/hyxFosDgUMe79ZiRDr9CAorr3XMMX3PJDou3XW7/pcjELVbbuipDtjeYe7wjyWlqwLcvLi2eyB7V63o974w1zGlxBWrvb5XBjtVl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692024; c=relaxed/simple;
	bh=LqWE6OUVSdhcwYqvI5P4A0YfvWMysjsBn/7nIOA66fY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5c4YX8JCuYSDyT5+/FhB19ZDcLapfFEEzTYLLZuhzhACuFcg4GcrhfDFmKHuE/i7AIjufbT4XAc4SqGGW+Ur7BGh8caOvyWqQtx6KrE16TE4tJB25jcAwrxNJCFxvFlv47cDvqgY6g84BMJa/5wNnIte5yYDYd06BYm9y77SKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GUUnwWYq; arc=fail smtp.client-ip=52.101.127.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GUUnwWYq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htKmq/HvbggPBeK7Q2zaFSoCsXPCVWituCtu/2WcbgZqyEqp1VWlOE/3c/6QVIffyvszEi0QF4PfGXKe2JPcbfP5idejDjzLubolnUBtkbK0+MWZXdBwX9qt6Kurh0v980rDALoAwGjSerotXAtYlewc2CiFzSPzYbS+5rPAf5bz2uLBxEDjh/yk+qNrBS+eqtBjaxDr2FRjcvrbQxjyfxAm5nybFIMEEn2lnSXFSNvgsTfmk+9iFztU9YLrFcDZN6fEkurx9xgTMFqqpPio6KlSWvMN2dQ/fI0Qy2l++Lj7mE0QeR3KGsd8mXT9UYlg+jf7dKCV/lIAkCVOzRLN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+odOIMr8bqlxYLyjsaqZmink5+eFUshLJX/oB6CHpUA=;
 b=wridVZZasaAoaQwkjjkcrTA5NUqUVyaEGtG9Nj1rgve/6A5lMuaVSRBA0lU0U00wc5gTbPEQF8QsDKV4mEMtbpZaWKVnn7E9vLZqulsNBJzOM6MsjAHvTr3M0tH8Xjt/Wiguhl5UCvMAhMHnGkNqyqrbHM/45j0zXNhJT3FPqrrpLorwuBPIa04bAGbAsZWebgcMT8eCn7gExeUv5U7ES+nv0DJtaH4v/3LhT/oOKFHF51qpiRZ6gspop9KSheGlnZWETRPOelAW/6flY0aFVlvVc/t4jvn/d2SOka+f2aOVpReRpv2E+RfzNk1DO46ahvpEEOH6FVtD99Xki4wiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+odOIMr8bqlxYLyjsaqZmink5+eFUshLJX/oB6CHpUA=;
 b=GUUnwWYqDQidqa+pWpeCXGGUme049u0cC1lcNRzy6YVXxpZ+3rnZJ7X3h1j8NiU0GdGET20TgMSj1S+AW40OtAZcoc9jo9j0dTAyE+2sgnpRW9B3hcq3DMyRl9u7IjegLATnhymMWdeQZngMrgCov1y55FrMh3CgnZQjKBzslfMktXqJ8loX0g5gQ83bMJm0Z+Orx1xUqNKwEW2PKEAwKxyMUBXz0f2SqnoRRwYxY1uF99YrlgGTveEJ8dqAoDw2TEe0Dddhh0fvHQboVcTouIAwmLIoharxcaTec8ZEOcroEQa7fqkGff8KS4M6eH+piMVvsWd/kwVR1uvL9om59g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8988.apcprd06.prod.outlook.com (2603:1096:d10:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:47:01 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:47:01 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Cixi Geng <cixi.geng@linux.dev>,
	Wenhua Lin <Wenhua.Lin@unisoc.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH 5/5] serial: sprd: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 11:43:33 +0800
Message-Id: <20260722034342.316755-6-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722034342.316755-1-panchuang@vivo.com>
References: <20260722034342.316755-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0ff994-8f8f-4675-df8a-08dee7a3e354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|52116014|376014|921020|38350700014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FHxVY2s1xTsGtRLWabXhf8ZIhMjkFjF6qct5nMc278zzTMH9UvIwhebhRVJaHab15oxIkQPAwnvGFyD6oh//u5F0lMNExVkjo36qgyef/LJRE2lmS9aqL/AasLGHTJzAmSj11EQDgRNTa7a7zlgjc+rIWpK/2RSQOkaSsc3S9CUSOtDvF+aKeoqpmHyz1NCf247GJ6C966AgXNlzbswOUHX4oUn7FvE7pwVfja8rDWoGuEXD17tdpqQgbggaTFhMJa0I2Dnlu5h54UhoDh8a0MqglGy8FHmrNj75F51hrKQoJsSllnYpwA+2dxOSnaIMvs2BWUSQtgW6uw8WMj7oo1kbpqZ/oZmXXfqTzNCVKRoQsk4smfCNNfwA/RJBogYD1SfY9+C7naHLEKIL+Rd6V/nwfBzuFoVdt5nfDdusd1W8+WzguUldDCWViIc6I/lBdIy9qqjml+jpWnrcF0LgXSmKb/dtiySDHW+5C8L9qy21etbFwU5BUCGSPXWWzgGQvtDTMZh3zDdDv2c4HMaAJpiCWGTT9tXvZoUN+ytRHnLDfM5JDHgvnQMLIOcT94juSjyB6lX/r/AdYRvCrO/PRx9Krep10oCLiZJomSurFzFV6Uj04kyDCqykEZ+fHEtKI1TkhiUrLgN5AAIH6g5Io1Ta2aOlhm15De2AVFPK2GpBf9YQXYGhxS0o3ogflxhE4WITemisoi98b/fW1NID0QnQJl+RPyOpM21sJJSM0WHehwjeEYjkd40mXmpYzduM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(52116014)(376014)(921020)(38350700014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cU2IQRpe+2n+d0ljmlg6+IzBX4QKMbBPngVtEBWMsr/VnZQiVleX8XBSFiHn?=
 =?us-ascii?Q?UaFN4o88Vlz17feC86L0XFpfdG6EokVy8mF8lPaB64IZ5Ls9oQt4blaX+thU?=
 =?us-ascii?Q?Fe+gV4AJq1AnzMU9cOAkLI4tInqD6w734efGJ6Krre1kkQpyFPIJfzeTkAlG?=
 =?us-ascii?Q?Qd7Wgh9/3pQn5vD2LeUaejuxLBc34R0+Pugez2UCFPjmfBOxds84EZVacCax?=
 =?us-ascii?Q?ffEkH2s4u/I5wXK07wP3PjZdGFFKqhnAT59Wqhdn9NXd+vPzo+YlcbPH7xSX?=
 =?us-ascii?Q?rAEPos4Tm2poE/TV6SjcuMv1oOljJPb5G4USm0qr/x0nZQ2sf+PPuxMSeyZv?=
 =?us-ascii?Q?ULZzX1+bQ++m5by1rY5WIn2hnAdHjdwkAsvUJrUYiBZ7feWZKLRyFbv5wSSI?=
 =?us-ascii?Q?qJtRsxIKkzmCAuoSuN9rIfewHdx4wt25H6nvEfzfZPku/WipNrWNuO3jy0ib?=
 =?us-ascii?Q?BqyCtKP5MscictcTk/DMzRrt1gr8BLz3qvKl3IUXNsFyqPpnK8WyL2DQj0CE?=
 =?us-ascii?Q?aUmZalPloTtEhh705aVf8AmkZNoNN5MBz+Ybhlx72l5V58hnBuJZ6ax2zPx1?=
 =?us-ascii?Q?OKSbdvM9OX4rR+wCAYggUaOdGQQJgm3wil990coYQc9LMwh6mfHWAbtcitJp?=
 =?us-ascii?Q?Z4CDsmEDIUWw3Repm4W0Q6fS5rCK9L5FhcagmXwEvnm25HbX3WIz+kLksroj?=
 =?us-ascii?Q?hQXMVFXXDTA/xZDa2nGE9gZlazmk2qeMkvZ6HcDTsNZMtQfaWcq4hSAAewAs?=
 =?us-ascii?Q?qtciO9uofcYMeGi6j5IpDH5lfLD7mrF0vV4hSQ+VjyorU8vQyeDY/sK166bj?=
 =?us-ascii?Q?xajhtUpCDr0hORJtfZOuFv46Lr9+ibSk7g1IA/NJrNpmAjmToG//J+3DGv8A?=
 =?us-ascii?Q?HAcV5BztlVWgjkDI9INlNM6cYh3kukRZ7/g8iw0K6mCBGaVhFHueFn9uCAys?=
 =?us-ascii?Q?ZMaXJMrcRAy/k687ZJcFLzjN4sUVoipgBUWQXmc7SAygGHCacXj5Q5MuOd9f?=
 =?us-ascii?Q?5hBkO4RAFdeRDxoyzGk2whsBHMvLo4folxaoWsriTaxiNu4ZU2gkaiCqYgpa?=
 =?us-ascii?Q?JmOrudZCDA1+iF43CWGLSswgQG6e7FRBrVskhRMyLzVeakFP1HFrgmkdJrjE?=
 =?us-ascii?Q?zMlT+JV/NkLMqy6AAV0ex86QoI0XeuGcTPCcAMOvInZWVRVWA2O8pS7Y/dn5?=
 =?us-ascii?Q?j1dWqsXXBGNGEIDPwJi0iNtYVw2cbCgcu3Y9Wlgr3HvesJZaR12aIVx/s/74?=
 =?us-ascii?Q?lKCuJpJjyd/J/CBrKODVIDo6DdXvGGmUVhIIZDltS6gSnVnfpkBcDhUWYJO0?=
 =?us-ascii?Q?O2E+FAxki1idFgw5TILkNObeD3Zgr8r2FohBy7wM9WwEZoDdRsH2PY5gNtvB?=
 =?us-ascii?Q?QF4muby59VgGgo0tuU0f18koviPKbOjWy/bDzoksVhsgIgfqL0iajRhHW3yc?=
 =?us-ascii?Q?F5kG62teKdaNyi9+Vu8ZpT2QSjCMnH9G2/anymDpHD4wqBK3sAagMNvDGb3H?=
 =?us-ascii?Q?1kZoxBnomdpnXrtalnw5LOuLOia2GmV3G+DuzI3/ZPnlqcaig1d2PxtcZOEj?=
 =?us-ascii?Q?uXxjOWEFxz8AtDa+G10/zuyru6chJZi2Q6U+VvkFEUIWhZmFdFwWEVhly23d?=
 =?us-ascii?Q?JyB05MP4SB9eGEyxh7Q8Xw5YdR1wuX3043zLd7DGl/dvSF/PMr+77sD7WYWA?=
 =?us-ascii?Q?HSQfwR+Aut2vApedILYKTFjeRHBZfg6nyfMkCXYha3cL0hxTr/DYDyeSr4Ng?=
 =?us-ascii?Q?v3mNjHE2Dw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0ff994-8f8f-4675-df8a-08dee7a3e354
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:47:01.4874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItnmrkV9WQZ80ZVv37e7Uq90t4COyrN7i81iPQOdj4babtg3E6aVsBL7bHyUY7tZbahWCMYezsQXk3Oo5NgwEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8988

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/tty/serial/sprd_serial.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 092755f35683..3fdf5939a62c 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -741,11 +741,8 @@ static int sprd_startup(struct uart_port *port)
 
 	ret = devm_request_irq(port->dev, port->irq, sprd_handle_irq,
 			       IRQF_SHARED, sp->name, port);
-	if (ret) {
-		dev_err(port->dev, "fail to request serial irq %d, ret=%d\n",
-			port->irq, ret);
+	if (ret)
 		return ret;
-	}
 	fc = serial_in(port, SPRD_CTL1);
 	fc |= RX_TOUT_THLD_DEF | RX_HFC_THLD_DEF;
 	serial_out(port, SPRD_CTL1, fc);
-- 
2.34.1

