Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012002.outbound.protection.outlook.com [40.107.75.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC802FCC13;
	Wed, 27 Aug 2025 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262730; cv=fail; b=DmC/GkrQbqy1TP1TWurOAVwBd4JTcOo4gJxdELTb6FzCwR7tawDFcZtZkXon+/KgNpNSYVTkFu/5ObUm53f5btRjodERyX0cvRUyu7hMcYPof/FCrwt72nR/7E41YvT+pU58U16MUeBiChyFuIKlxVAjTegV3wj3SEzP5Vp+rNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262730; c=relaxed/simple;
	bh=+Mf5iMwgBd1pjTEjYarCOSZ3bcZDjQJWbJ3nbmlhb+w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S/H7pBQRe6seRfUVNc6hWvn64lNpx8ns5BnqMn8emkXOSBFKpJD1xag1Fn/vEbxwIfqgmwRvtlShlQI8h7nU73EIy0wC7H2NnRuWgot1izFTaFhW/a/5F9T1u+7vsyeu17S0lfKQpXz/o2bfMaYP16SlHhFY0SKiST7ZwArHEoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VkN1HxuQ; arc=fail smtp.client-ip=40.107.75.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VkN1HxuQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QN6yJh9z5Sfg4CIfnJJ/xuI13U8iXPzVucGSM/3TsOaThHYUM+0fWqeiD1YWAeoaXnYm53PO1TvxlG1mYLTHFdn552MLirMMS45Gktp67q/+eXX8GQ+8CoKHD4Rqg+lg2bPrXqBV25JJ01Rd/ExBVuPGs+Vgs0HOAvCVeO2dCuG/gqHM1UovZ4Rwx8dESKeZRrsWE/Y6+6y3AMVdWwpY7Q17ELjpANSGuvxQ1ehcFhN8CloSkeQ4adD3aroCspGQ3rV8Yc2L5laxARgoG8NueESQ0y5eJrYuFV1dKd5BxhBRsvSbFoQwD+KO9wlyyzRMEPz9qvGKV0voFeivMH/aDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAqPmzXUTwmXoGBqaHwbXX6tJtNe41ozuSWTYz2GAC8=;
 b=URel8D9C1ZDCBqefJdafJ+kLfs3rARqv0SvfhgJchH5P0k8ZQGUq9kMwfgfzALXVG9/IFV4z7KaNwTbcF9VFcNH6/cGsU8TDoU6kM+qlLc4fhvI1/seuJq9al/FNk8B60jWdXFNKpBZmCnrGv6Zgq709Mf4eeRt3Su4ACa204v+seeMw3Kg/IVgpLKLAJldIpR0sLUj+ANMiGdHFHBeywxo774ARi9/Y15CCrcBBKbXqQZIe9S9GL1cTctsS50XO9zNsTyZg5VkjXRpj/W3Ud1KVFIZNur+Ph+m5tbsKAX0h8cwbYibF7TdTyGENxFRP8s6vho46BEYSNR4KwtGLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAqPmzXUTwmXoGBqaHwbXX6tJtNe41ozuSWTYz2GAC8=;
 b=VkN1HxuQFChWMi4PViC6DzRZwZ+5RXv+5FDD9nyP7tgk/vTmmuIqZ//zYyUhWV7efDYKVMAog+lQ0Xyc2kHHdJxGWIYSqyX9QyHWhS7/w5PO4rJN2RTmJT++k8+gx6rV43ulRpHdgGSd5JR+8cuui2Nd3X2198RBT316Sseqxa+0JKVgJD4ioy2Pke/nBU8BYI2zv0WFeDep3hhDF139NsKVttjQoHMwVQ2vsrjU/NwD6trKqgu65B2oBIxJTzZ3breDg2jlYwu3gT4LMTTMUmSFIK7IUcQeUxUenYrwe5f/wzkOysj9374XtL47Rhw6pFsrU3yG1MzCoUyjscnxUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB5805.apcprd06.prod.outlook.com (2603:1096:400:26a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 02:45:23 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 02:45:23 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] serial: sc16is7xx: drop redundant conversion to bool
Date: Wed, 27 Aug 2025 10:45:14 +0800
Message-Id: <20250827024514.76149-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d4b2b9-c578-46b8-1e68-08dde513c543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XjoWe99+ORvrq8gSFY2Ce3IAlwBFp6FRGqX4SzWRR5+PIMqJs0gw3lKtdHSf?=
 =?us-ascii?Q?eTFo+fOLm09njCirGEu281fdlNtCgeNpqNepP7QGcz4dRHWoX/qsAJSe/KZ6?=
 =?us-ascii?Q?xoWYvJ11eAxvApHGPRWfB/tKHW991pyiAWrb3BKXRo0Y0wTZbNh2MecQPLY8?=
 =?us-ascii?Q?eCAU/7UmGV7Gyz54vbVa+AWvtco2dccfLkMnqqMXuRGOdTqWD6ukq2V4V1I2?=
 =?us-ascii?Q?i0ioWq0CgNl+hcPon4IPwQmxcMufyZt0QPM83731IfVUB4V1YfSCjugQzXZw?=
 =?us-ascii?Q?64M1F37idrvhhKlTCGL1Aqr2iRYa/E3bqzQ1i1q8ciABB0Jvy2OGIsOkpIyM?=
 =?us-ascii?Q?DE+QGHTkFet85ZeFTdnHg1J59THSj5Py9g9bol/L3721KryCu/iHlkm1iNw5?=
 =?us-ascii?Q?2Wvhva4XsTJG7ABkdMGiSXy2Plm7MVgVMNUxqg9qXBUXgzfvOwXjx3qsWWgH?=
 =?us-ascii?Q?/z89TvHHIfdo2Cs8GiBeXDeCB61mJZFEgIhNSAy9KH4j6eImyKRqTMXgIOD0?=
 =?us-ascii?Q?JJbR3JES4/TS3snRBSJKR3DRjRu65HaCnRRijGU+ji4TCTqH/uu3gcymbpNq?=
 =?us-ascii?Q?Ehv20qW3v+z+9Sd5QYyBeASUWcbwVJraGg/OYlgdD5KvF5YLfuYjrzgFKLon?=
 =?us-ascii?Q?Pwb1C+6bhO786Q1tvBOh5W7oLTVIfzrzG/Yh5VnfFHwrJ0ffbMVD1NeXmZIS?=
 =?us-ascii?Q?WwZ3m57xUElAwx+IfdfAf4nbF9Vlk6BCEf81kccSSoTOaWUfdzA6Fyqs4Ic4?=
 =?us-ascii?Q?w8YkOi+sr/gqly/8ao1m+Q0WjI20DNoZ2OwRKZjsPyAwX11n5ocgGfYIXh3c?=
 =?us-ascii?Q?vtonhUyPiD1CtzXHe1m/36lpQzdHgDn3GWqJ/Axh0UB8QiE7IKbTjPdnua/3?=
 =?us-ascii?Q?YJiaPQ4S75oNDkIPdoNRQS0gOrh5UEsQ1d59x+ACEyVY/+roiJvzWW/gpktc?=
 =?us-ascii?Q?lo6p+zrzWrPtbGTOCktLVFJ8hdNPRXqBH6rDOdmNO3Pp0Sn0/gtW+mQvNEot?=
 =?us-ascii?Q?c0oB62/HOBrhmOaVVqVZB6LfVPfS5F8W2PEd7pd1NKPJ2e770b/LCpqInJdF?=
 =?us-ascii?Q?sThi+GNmV546baT+4fIMB5ZgM4kFZOUNmq7d/gPnEORwI0Pl3ri9t+WOGLMn?=
 =?us-ascii?Q?HqH8GHzpJzfmfNNEuiVmJh3QH2ZgeNMgpFP51m+VZbmGwMt5sbeuXEsbuWYZ?=
 =?us-ascii?Q?2+N79aHrcvo9DuYD33QvNPHfNJNKgm/QGX+TGj00qMBctETMmgeaylVHNpPF?=
 =?us-ascii?Q?BeA/n7x3uDBaHxqDgKCkxlrX0oVpkRJDlr+or47/GFZaC5xCWbtLvAEdJgf3?=
 =?us-ascii?Q?PDuX8oUZ1oyZkJoe++c5wxf0AxZo9Q7lseFfR3Qru2pbusRGr2S2bNtFDdHo?=
 =?us-ascii?Q?qAdsZdIu4dXVlNGH1c1XPv9PL1c1r6Vj1jzCk9iUCNYVRKiNdsZwZIHFlj2h?=
 =?us-ascii?Q?kPlm5r2Afh1hYWtaFa2sOV1g31uozV34gVE/Ecuta7KvPSVytuGWmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jyAV7bDUwyvytzAZfFjXiIll8MAq0vpg8hFienqTrDhPpbqt4V4njY9xvdOl?=
 =?us-ascii?Q?CQnsOyM9GWLHsPSRHVvCOq7N/QH0EVncSp+0kLgW8fd+2amtRXgcbxQPwwxx?=
 =?us-ascii?Q?l+xu5MPWq4WBXLwX6TuFYwE1D5oSNnYAQE7ek42XjahHT9WGNKI10S5JjX2j?=
 =?us-ascii?Q?gZnDWNK6HPtGLNVjfFWRckDial/IO7Uq0w5wwDe8sQzNdMt8CuXArwGh3a54?=
 =?us-ascii?Q?oQRK3q5XR8ZbtT5hqqkLhfWrUftfeuVA3b1HjIgZOl4pvqpwNkbZObouN/m9?=
 =?us-ascii?Q?AyzhPuanDG5d+T8aU6Z/x1uRfUMNWAOiTJA5AEtTF5Y5ZAgMJdYig+DvmaMu?=
 =?us-ascii?Q?AJGIz0pzP4TjiRDfP9LgXld8a7CGDuZz72vomZiPdMPCOlGQoP9Kuefyd8rD?=
 =?us-ascii?Q?jr6kNWFpfg9xNIiFUvdNE0y8C6C0DJe93ZVZ2sMLDSFCeWkkCWlS0GmH81Of?=
 =?us-ascii?Q?5ZJ0qPiYUoFSzKrcHB2T3MY7WZrhvzQMGFyudwH4TCV237gsp84Ph8bH0R7V?=
 =?us-ascii?Q?31NOhrlJ0PSlUJCjqy78cEgPFbEIvAitQPxOrA3Xy0V8qftT2AwCbytt2+8f?=
 =?us-ascii?Q?VRHIeE9L85t4zjsiva3YERNmfKeF8ihnLHt9UFsZQLemTn3FQaWMiCd+qkvh?=
 =?us-ascii?Q?uZx+zErpNGgCyWDaZd+RgwmuK2jU/SxjVgTwBUB1bYVzjC5S7CV6Rf887pjm?=
 =?us-ascii?Q?Mf2phsCA/9cZs09di2vlj9EP332RE5FRqtEBAqGNcWp2RyBsReHMzujU5DI1?=
 =?us-ascii?Q?OQ01J4GhlMqAwKXZZx8aRxWUKX5DNa9hZeXp6YhR+1M+idAQ+OYNqJjlExsx?=
 =?us-ascii?Q?psKaUgJnMqj4DvRJ0HZW3ZGS5VDuk9gqfRBPzFW+DCBcQmt+Zn9JyAm8J5cY?=
 =?us-ascii?Q?lyk8H3baFAT6U+SFh6qIZ427cnyC3dyI/xpNZnnzZQnutIWeDQbWh9XyEew5?=
 =?us-ascii?Q?UTbnOwb5wFoiyKX9wrcnntVgMqq8miX/g7X+h7tKs65jOnh+QT+9DoXAT0E0?=
 =?us-ascii?Q?IOf48rUGwMkxsbk7OfG0Bkx+9a9G5ySSPbDrwd/iTrx80CFmnF7Oy6W8YJWG?=
 =?us-ascii?Q?c8qbW+xeLYsvnZBOndyV4AsCgm5cNsbbvO3cpvlx8CV2XvY0ZscN/MrLOENT?=
 =?us-ascii?Q?WAT+9FoI1IkWLtAAj/SAzDqVNz5U5Q7zM+zUISRdwptfz5c44A6KhcgE+Xep?=
 =?us-ascii?Q?W2l1L5OwQmXlE10oJHKWa5emtjz+qJFQO3e30ihW3ZqIJtN8M7QSDjQPQ5Il?=
 =?us-ascii?Q?EbQ/f4h3dpCJiK7eGFxel5U/NNyzA1xwfVnHAaOejNS2J0/Lze6AJKwsua9q?=
 =?us-ascii?Q?8iodU38Q9cAGLFCn2u4YzYjLEu4TsT/ARab60Z3EJSlqm1Vex8m4D9TPGQE/?=
 =?us-ascii?Q?dQFv3ds7ETVp+Lj/nJXUOkiq7Wfe4tBRTgzFBWYs6CikcBp8DCmlKqROdcrw?=
 =?us-ascii?Q?gbq+lS/mzGeDk813Gxjr4Mn3MBbVuuTYT8DnlWLq54Tf7t2qoSrv6rTXI/QR?=
 =?us-ascii?Q?rdx1zLF+q5psLS6t2XILWKV0ChvdZZOpKy79tSO7/AHBY+64aQAu23iAhXSv?=
 =?us-ascii?Q?d8dRsMae9WOcY+J8XxHOnDCK6mdifb6hmcs+J4J3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d4b2b9-c578-46b8-1e68-08dde513c543
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 02:45:23.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwpuJeRpSRtPvsWhKOI6IqcjEgp5I7+BLyTfINPopt5RXu4DXZ/znBcEIZoPDPjhVR/XluECxdvosMYroi1xOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5805

The result of integer comparison already evaluates to bool. No need for
explicit conversion.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 5ea8aadb6e69..1c115d9e3b3f 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -626,7 +626,7 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	unsigned int lsr = 0, bytes_read, i;
-	bool read_lsr = (iir == SC16IS7XX_IIR_RLSE_SRC) ? true : false;
+	bool read_lsr = (iir == SC16IS7XX_IIR_RLSE_SRC);
 	u8 ch, flag;
 
 	if (unlikely(rxlen >= sizeof(one->buf))) {
-- 
2.34.1

