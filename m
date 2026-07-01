Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013043.outbound.protection.outlook.com [52.101.127.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2F369992;
	Wed,  1 Jul 2026 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877494; cv=fail; b=ZUrz7lKwm/6orw5TiFspl+ZBB+NJreT7VOYpqf2x/d8AsKHUlBOEnelntOXAWJFs5m66pds3D0dxhQ36PTddZuVCKWQMtk4ShgQ10AjNP//bzyJ/qcHkMT6Q8+eQF7Nl7+YIsEAvxxknbfFYbBleRdlMvQyYFE85Rd7ghZ90Jp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877494; c=relaxed/simple;
	bh=Jz+DcG1ODBC56pK7zZnuUz7/9c4HI/fJ7Tn785r95I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m5USEQlq6CQhwrg7NoHCnSFs+OxwRjYGFC85Jtm2cluzRhTrAoUO6+fEzVgikuBBcrglZT1f1LizRhciZl3sfyT92VwD+29bP/ZRiLmd79k2SMh2i+QYSWeI1mTy/Ys7CizdMK2P93HWvhAo1INLFU69ZN9dZUSSBNq3ceTu4EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=XmAidB7f; arc=fail smtp.client-ip=52.101.127.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="XmAidB7f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6Xu0W1QuuRNlCuw2unTzYVnJhnf4Ix6YIX58h8UoGtKSSitIF8HPJQf57DoBCo3ue5juiAQuhIVGBEdaFPf6pCAJLqoExdvFbu9aCF2m4KPlaAtbx3NYsTb2WCw0/zHbIN34Ic9U374n3BcqddcZrhpAOX7EjJsWDV8G8F0GWlWyIjgF+0ZZbJ6KMHEUaD9RqKFYcTy3YVTatxfB70wBFrMAa97GchYAQiC8NTSrvWGimPxqiJVfDkDpj3B8sDJ5hIPMsQ5IBcPDvVIfa76WhY094844Zx1ZCaKAGDzLbZIMy+jzE4/qizWghhQqCi8qouoAwEG83bPn4hsYYFucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kt2c26ajinejSauc7NCpNgXYi8Jh0+YQlAUhMiVnszA=;
 b=ohEMo8RiReEsxvvGTzgosN7iT1rubk9Gp44ATF57Bate44w47At9aisNf4ZstWLeQDBkJtcFTl0mTYZqeiH5NdRfp9RXqc0UL7EjnMKmhToMXz+TF2qohpDRS6RU+yYsniFl9+cNPG/YlrXmhgKeIe9hbZclqpeZQ3vda1DtUXKCf7dIpSFT9KYm7FBnTSfCj0wMQtGpn5AmTv5zNDxJU2TJJOVB73+reVHl4dBV/Pm0kqxX5KoJiKChT3Ft9TsuJeRsRpN4tf8PWXym8FFuMqP/ACJQMZy4vomfKa1TPSIng0QtwM9zSzqv2/FCF1H32crQ7HzrBJJA+tufSKzGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kt2c26ajinejSauc7NCpNgXYi8Jh0+YQlAUhMiVnszA=;
 b=XmAidB7fhqvKdtL9K9x48uz6nzCxq0s0rlWVfuLm6qt92KzzUXRShQ4uivAIick3h7jubNvPuo2koM807kiNgV2j/njD1xEqMAfGtkRJMa3R6EPbFFLE32Bo+yFoFM9oI++5GrTnBx0SETYlbm4aistYirTMVyHu5AGVX4B+Plo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB5417.apcprd01.prod.exchangelabs.com
 (2603:1096:101:c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:44:48 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:44:48 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 14/15] serial: 8250: allow UART drivers to override rx_trig_bytes handling
Date: Wed,  1 Jul 2026 11:41:27 +0800
Message-ID: <20260701034128.218569-15-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5c9afe-6154-4ee6-bc1a-08ded7231959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|376014|1800799024|38350700014|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MscIYtEIsmonVbVWhQDpt+IiXJvQ44xeqR0RimkKh9SAy6XaKi9cjt9XtFBvGTw1FdGryBEw08+AeCopNgAdLWX/nUdg2AhBb8r0JyIubK+N6I1R7iERXJ20vCDpuFAzOL7DmU/7Oxnvx8VprWyypF+qKL/hE/ucaUDKnYe9pwRdVm16RYxGKCzQZOYUNdNbRUypFgK88KbFfS4BMQ4fGgB0sO24q79mwJwTHTRCUBWEeTaabapI/LBk/bx80zRzem1os+J2wkfrfSjxCk7T1Ek3xZ71c/Fr2AM9fHaXK5SqqF6C0U2hK9gP9H9qDPiZJLXA1UQmaxy9QQdd4KcrOcAzKjimcmDuXHmppJT3Sz+yQ+mo2S4sfUoV+T5dLLX4ORPezQ1HPu8vevL5Uiz0CTlpDIGlnS8cZWWFDOveEFw5Wh4GoI3W9IwbqBp6C/vvaDpw6gwZrZHqTnpbj9ARG3kAPSMmihklbx5CEkYfbLKUCS3v9NUfer47wwLd8mAERTRrKLqwC7kOeMdwumKs3MR2D59/4Yzjh9nUmdofJLdurk0kuhetbqMjULTyyxPPG2xeAZQUpPU8CCxL21Wu9wcH7Aybedsl4gNyWgthMSCgih7faJISBGYMLNA+TjuQKXm/kgKkJlc2lQmitOGnlMpetAi4cdgloFIWlYV3ZPnPtE6B2QGGHlBwAmfMJ0KS7vOM5XXYwlxrp8UTRgAWEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(376014)(1800799024)(38350700014)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J4Z6I5eoJE+liBnIX8e/JSJLf4amR7iVG5GnRoGZbAv1bA8xAAeXOH9urCPm?=
 =?us-ascii?Q?IIejZbDOVCiLELYN0yY8ScW0FAyP0IIe5Q3FiQY89p0h3tjpOPv4INLKP+Iu?=
 =?us-ascii?Q?hnEq6BbSlvdsIk+5jQxkrEk5c9SMmNc1mnsI5XwxGHj8Xmw5awAKH+kn427u?=
 =?us-ascii?Q?WMcQq6MYY8juqHvd8MPXt7/aenTGb+h2pmWvaC5NbyW3bSFbOuOn+ft/UZlD?=
 =?us-ascii?Q?NeJQ0QIYavOIX+/gGzDPd37rcTWHdMMm8rI3YIf3P0pupHNd5k0VQliklnWD?=
 =?us-ascii?Q?0ZZavAcX4/t14/Lo9EMCoQQxDx+KVr7Is8wIdxAm51BaaoaVgl08Cc17o0ez?=
 =?us-ascii?Q?qqQyIdQgOnyfHAhPpmEx9IcSnJcMr2ux9HwY63C7ixcBK0fqvd3CvzLDZPU8?=
 =?us-ascii?Q?ptexIrGy7Oo5AYmgUU2Bnx0T5lU9ZgtZxXAMFKwQT5L0BOzfsbRBCUKgvO3H?=
 =?us-ascii?Q?9RJ35Sfc2dWQY45TkvN1WmtYK/4lLCsxuauvtsGu6x/PObBY6W8nJEJBIhAf?=
 =?us-ascii?Q?zPCboZZd1sZ+hCRNtPa7i/Qs6xNjoUel6jEcBbb1vSwucqetOKH5wv/ZKILT?=
 =?us-ascii?Q?m3V3GzLaD+55Ui81sygGuzlHIvWfUhhFvnDbqaooCDoZ8xnBj4yjEY4dtHEq?=
 =?us-ascii?Q?OUilSHyeO4JHBWkgvfp5NADMJ+yDC7dp0Ray98YpeTgbehsx39h2go2/evDi?=
 =?us-ascii?Q?aM8pQtGrC21GxkWOckOw7v8jimbgUzrq8fG3kdU5PfzOTy/8+pHGJIU0Kmf4?=
 =?us-ascii?Q?3AYU+EVK8WMaSD4SVrO2V1e9hdOPZ6A0DHO9mvn3xWlTwPZi8+lKoQBGHJnE?=
 =?us-ascii?Q?4zGugMNzwxBUdn8REsaq+cS78ZQSaK4M/dgaNbFU49T6GZce4ir3hOI+mSoH?=
 =?us-ascii?Q?NFs1oTu57PQx4yShtuxHwQNVx2cdpGuEvmxg2V+K+Lr+3JtHIPa4SLGuDRni?=
 =?us-ascii?Q?QIwYD17Cn3gDQlBQlcy/yzBA7udXlbFNGMCpTCfBXEGO/Yo3UIK1ld261L12?=
 =?us-ascii?Q?QOu7j9Ju/Iie2UU4e4k8vIF/C7VxqrYOi9icBEdvmCWAxmXy2n13MANSAXaj?=
 =?us-ascii?Q?kT3dG44MC/aPql3cW4K4dP71HkSKQ4nM1uprVIlRn2/KwTq9YojUo0qCOOKk?=
 =?us-ascii?Q?H3+I0kA4E4AM7jf/Xmk1G8meg3hOReAHU8czWHve7MdGr5szhIxJheV7KJjq?=
 =?us-ascii?Q?m3EmmEAtoNLd+/RDKwbRoypfubXwQpPnagF/28rCAmv0GJVPM9QcCFwIUW9l?=
 =?us-ascii?Q?I9IeRjkuLWqT2VWyEAOXFSQH+0ymdyGtkpRLEQC6RWYe0eHYcw+4G748Aabw?=
 =?us-ascii?Q?Y14dj/cMNBPAc9BNXAXYjUABWnWh9QlGblwGACvI83mK78jNhs41449ldGRN?=
 =?us-ascii?Q?XSGkgJKg6srbEtfyz8gbzYoDjIMZOGtCIckA7pi83kyitDghUU9DUk0Uufml?=
 =?us-ascii?Q?UCNJ+KzcgntZBH9Bh6vRd223G0kObvRYAi6xlNs2rDHpjmOdxpfc6Mx71uWm?=
 =?us-ascii?Q?+HP+GmxrR7/fHFB5bB9DZt0tKJd+kuPb8dItJ0hG3IAUrs3hxGkowIHAQkH7?=
 =?us-ascii?Q?nFZeSJd5ECYox7id+gdzvAURifnfI0YtYs4JyWo8LVfMcZ3uajCtrQGwYiP/?=
 =?us-ascii?Q?Vfm5rcMYdgaiz07/PoeWssFR3uQ8FFO2zVxQWbVRbhfcpPbUbM+V4AaFP2P1?=
 =?us-ascii?Q?1U2UQ3J9oETNcDaLAiI9jKZXGkKDPv2qNdwX1RNE/yeoBElhBrF8/LSCz8Qr?=
 =?us-ascii?Q?BOZJWs6hR5CKHR1Oss7rFiBtj2lF4qs=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5c9afe-6154-4ee6-bc1a-08ded7231959
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:44:48.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3eGnFnmnFGx/GIxZWNSM1VIbxfpPXZDBN09W1haq2/tq5p9Aok9CJz6ZYobJggTc9xaOOlQzTdsOZsqCxe021cNc++/K+yk0NgMz+z8ek4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5417

The rx_trig_bytes sysfs attribute currently relies on 8250-internal
helper functions and assumes a fixed mapping between trigger levels and
FIFO behavior.

Some UARTs provide hardware-specific RX trigger mechanisms that do not
fit this model. Add optional uart_port callbacks for setting and getting
the RX trigger level, and use them when provided, while preserving the
existing 8250 helpers as the default fallback.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_core.c |  4 ++++
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++++--
 include/linux/serial_core.h         |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 0a3355eb4bc3..052c0020a860 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -792,6 +792,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.get_divisor = up->port.get_divisor;
 	if (up->port.set_divisor)
 		uart->port.set_divisor = up->port.set_divisor;
+	if (up->port.get_rxtrig)
+		uart->port.get_rxtrig = up->port.get_rxtrig;
+	if (up->port.set_rxtrig)
+		uart->port.set_rxtrig = up->port.set_rxtrig;
 	if (up->port.startup)
 		uart->port.startup = up->port.startup;
 	if (up->port.shutdown)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 72ecc0112b8a..2ece8af5d149 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2999,9 +2999,14 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = state->uart_port;
 	int rxtrig_bytes;
 
-	rxtrig_bytes = do_serial8250_get_rxtrig(port);
+	if (uport->get_rxtrig)
+		rxtrig_bytes = uport->get_rxtrig(uport);
+	else
+		rxtrig_bytes = do_serial8250_get_rxtrig(port);
 	if (rxtrig_bytes < 0)
 		return rxtrig_bytes;
 
@@ -3044,6 +3049,8 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = state->uart_port;
 	unsigned char bytes;
 	int ret;
 
@@ -3054,7 +3061,10 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = do_serial8250_set_rxtrig(port, bytes);
+	if (uport->set_rxtrig)
+		ret = uport->set_rxtrig(uport, bytes);
+	else
+		ret = do_serial8250_set_rxtrig(port, bytes);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d9e5e3d02003..68b2ab848d92 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -459,6 +459,8 @@ struct uart_port {
 					       unsigned int baud,
 					       unsigned int quot,
 					       unsigned int quot_frac);
+	int			(*get_rxtrig)(struct uart_port *port);
+	int			(*set_rxtrig)(struct uart_port *port, unsigned char bytes);
 	int			(*startup)(struct uart_port *port);
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);
-- 
2.45.2

