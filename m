Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C71EEAA74
	for <linux-serial@archiver.kernel.org>; Thu, 14 Sep 2023 20:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjINUwe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjINUwe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 16:52:34 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011002.outbound.protection.outlook.com [52.101.47.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C7526B2
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 13:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be+VKPZcgK5PQkMiGPUl5TTMa1bM0l4d2iwH6aTSIE4A0jo8cCOQ/5aYN2doSFnQx3B060ASeVyp/YRHv6S/NzGshx7mfMtlwSvecaeIJwHb1Ybs/nMzVr0BXhPhFwyf1GWyLEWlj/3b142REn8emlpV9flDWW125SBKAJUcRnjrA2DxWQFp9k8iuxnOF56YzIUvKl+f8V9eLl47kt6clSoVuVrVKFpekDoEjZQcjRvhNEzPJBD9AdoilLNf3a+gbc2phqZyCHrTElFgLPWInWW0kT76PTvcrMACF3VLGH29naVEEVvKPxCG1wf5wRrRGu1drFe24Z+hTqhGHpdG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mboZhAhNQy1mc7Y1k5meqJeXG8LSpNvXzzu+AP+tfMI=;
 b=QWFr3XLUDvv+GCczp4TbLBBZoSehp9Xqo9WjEnOs/lx7627KMU5m0FAaO9SXPja1pPTjVXQQNIsflfWMKuzQfJAG2aGUHyVed03Dfmo3wI65otkhfGZ+I3j78VVB7cphY5A+ghrjFZhWn2y2FCDPIq73Z/K5wlMmCq87yYT12GAZn31g3SqrevovbnLxxEYZwQY20+3nu1f75FN0dZIQDZbpReWJRB5C7mRUfDTOgD50DrMorUgtul08HAF0xe50TNIPQcrbYFjdYSslLRxasIbi2dzfmqfhlV/F9vvTs9Y+LRouh58QwJxxvdC3SQtghXUq+ShMTyjhdTVoKLsWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mboZhAhNQy1mc7Y1k5meqJeXG8LSpNvXzzu+AP+tfMI=;
 b=Rk/hX8Hy3tkeOd6tstH3jLI/ik1C4eV1z7YVsSgUn8lZJqux8oY65GV5hdr4bitfK0UQ5Q7rHt3lmhWc4V11Rnf9Ba0CdkjkoqLfUGbWrPsvttNIasgpCetYDR84idk8f163n5LkNvR+fjLG+a4lMOE58tirPeYNQGbEni1ipOoZRUumA84db6EUn/4fHleXyAXCQJGITxhHsp4FZJte5dtLKoHZwJIJSz+fYPhVIliu+xQLbup8AO/ORr5vlfypOn6ZSFKAL5QH6ahvFGgEVfhqqU/3QnOsjA+v7dgo3FcMC+YBjR3Sw9rJOWHFXkM24qOlvG3ZXsLJWwUlH45thA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by CH0PR05MB10182.namprd05.prod.outlook.com (2603:10b6:610:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 20:52:27 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 20:52:27 +0000
Date:   Thu, 14 Sep 2023 16:52:21 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
cc:     jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial@vger.kernel.org, andriy.shevchenko@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH V6 2/2] serial: exar: Add RS-485 support for Sealevel XR17V35X
 based cards
Message-ID: <1cfeb276-788b-5d21-5af9-8948c9273183@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:408:fd::27) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|CH0PR05MB10182:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f1522c-2ce3-471f-af4c-08dbb5648138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4jy6+WLUcrwsnYwSabmaeTqr1MwvwCm4aeXrIulUWiM0WoiTKwuJ5WucTu/3TCoo8rhyziRD5S70IDxF27V7/cC3nHaqAsxaPAdeTBwbFiwoNtvqrkav2GPPxBndQ5rX6lZDO0pNip2BHxhgW21M7V3Cqex4X0zJKx6xtvPbP78waTe8Ag66ecUj/xUH1DprjIhBgHSTQR/loRmcDrLyBB8B71ErdZkSzck6BhnynlhXyUi2oVuYnRIQ7Mn2yeoNySbVg9BZyVegfNUotzXGZWOYDDOrJ1OG99oeS+ugKhxq/ZxuqlYK9fYHLzxoSVs3O+upr8FmTULyBoOCNdIgkiopO5xlbrFWi5aJxCBEuPYBFUVGuBeCNjTsksoO9+hImKfiuitko3yrKLCb2xIVABdj+99dKspSYsu4CNZwQhcBAOmJkzg66sHEZt6hGdLJW95uvNHf/lkQhtxjJcAJHjnE/uZgNeiYxC7B8NP6p8Ln6l0v5Eqh1n1VHi/UCNnWBHAmQbiN+7fhVwO8FxbPq8BlCcSOWmzB1b1cuFe6TSkbzH31TK0E9J9E69PO0xps35FvyAsAR2a1nUEmXCRHJnlZEwLxfv6fPx3HbvMeSN2zHCQV0Yz04x2j8hyYmerMFRnyhjJxHNZX5WyCHAd4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39850400004)(1800799009)(451199024)(186009)(31686004)(44832011)(5660300002)(66946007)(6862004)(2906002)(6200100001)(316002)(36756003)(4326008)(66556008)(8676002)(8936002)(41300700001)(66476007)(37006003)(478600001)(6506007)(6512007)(6666004)(31696002)(6486002)(966005)(26005)(38100700002)(2616005)(83380400001)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3aIbjrN6sr1pr88k9oszCKMzPTF3CsiWxyhMnQqlBa+lU2xEW4FGT5YeXSrm?=
 =?us-ascii?Q?nH9fMKXQa7PifxcYhIXwfNucn4Co9+DT5SYXB81lpLEe6MeqnL62rnX0I4D0?=
 =?us-ascii?Q?ExBssVVgqYxbSui4iJFOX26ZYM3CuBtByIRpgWYLfj4QBjANmG8ZjOQ17q2u?=
 =?us-ascii?Q?GRGR0ToYHQq7t6LzjhjjZO2CRnrficGOdpIA1I3buH9AV9VmVsF3E1+HJPEV?=
 =?us-ascii?Q?iD1yCAnD2JyaEEHseM9zvF+PNv6+AmDb9LBbThtplEsUrm+mwgxUYDDrZgGQ?=
 =?us-ascii?Q?34+uFLA13x6W3TWOl7jJdJYM3ZcPl4PdevPsTy3Zd4jEZ6dBtzVi/bfCROrq?=
 =?us-ascii?Q?QYOsWGtUtvfUvgnXTbfvpaacK6e5FF15eVOnigR/+BqSAgJOXklLUMwgpCWc?=
 =?us-ascii?Q?V2rrbehVN2v0N0v8uhxzgLx8Cz1FwIdybRb3hJtWFF+zJ1rchLTRdHzF57dJ?=
 =?us-ascii?Q?SaliipgbhRyqqHyt4VrKlzMk4rogI5TY7KrcZtYf1AZLnSQI6N2S6Rp4lmZJ?=
 =?us-ascii?Q?XXSVFfuKq+/zIvwwCtImIWeThRkPb0vXHHbsE1jpGDB8CZaYT9W4NC4OS7xo?=
 =?us-ascii?Q?XQGcvPgJzUTcmi9sJ3NWGy8uvN68ZFMNZsnluMuWdlVzfGRdYd3MNGaAFfSI?=
 =?us-ascii?Q?VfoLeTI0UF+eDiQ2C7HGdJXyzSPXGJvRbVI/3lmYcpM79C/5ZbAZRhA9AouC?=
 =?us-ascii?Q?uHiEFBT+ZgbX7OyjXiup4mnKB3ON1wazcT1wQNuGEAvdTuRUADanQAfh7iV6?=
 =?us-ascii?Q?2+Hi9fw8zACwHSntymKgQJg0yTW/Osh2iaDENThk6EANyp0i0sGawGqYjlw9?=
 =?us-ascii?Q?Jeeci4umwWLpQabMfFR8gQcIbgehG2CCOwD03rEYem27I1v9B/v7j78YLSI/?=
 =?us-ascii?Q?Il5fa5jXx9Uu8GV1vUC7360geiQxXIBh/Q2zWaJEX93Nd1vXu4uI2mPumrus?=
 =?us-ascii?Q?QVrc0glQUwx/cKyZ5w2M3f9lCuH6Qtfp54VL9M6CUsODN5V9j6rA1ED9uFoh?=
 =?us-ascii?Q?5R5pGVskHVfw+Lrcw2INFVlA7FUOiOid4M1BvTmxyIcrUtchE3WbhorpU4L8?=
 =?us-ascii?Q?D8OF1G7MXNy8LO1Y8o/fyP+C78Siwh4PNCBFnD7GblsHsyrzLWxud38P/wvv?=
 =?us-ascii?Q?SOautfkC37R5d62DNZH+zwyraRaJVqjBr5NMk1l613qbERzEmk+QGCWb7Ngd?=
 =?us-ascii?Q?7MpE9cPiJFuHEOwt2vOqs1jiMIyVLyOsSoM2988XfcoW0lQL6oPFMtnq+cBe?=
 =?us-ascii?Q?5/q8iT13KB8r4mGbSgEeISVCx+i9lHcldyq8P9Tqx0KNORSPFKoIusufCASe?=
 =?us-ascii?Q?n94iLFTKPolBzDLxqND/ixktaiErXI6r9QcfzmsHWSsubgC1wfhLgsclQnm3?=
 =?us-ascii?Q?8jl5P1LwAS82aeUbHICOAkrVcvQMQTObpDJCzD1OJpGhoVq5wU6zok+Yvmyt?=
 =?us-ascii?Q?bYbriolgFjB6xp/IgSr2SySWnRD7lJm/XzIVvca4y6Qzkj6ptNIYaPhzn6Jm?=
 =?us-ascii?Q?LSxS7BcHEnxfQemh21+1RCxORHOQ6QSbngjPd3v7g6Vji1Go8isGs+0vLDyN?=
 =?us-ascii?Q?jf3FrGH2QSJOmzSRejnnqmgfU4YzJbFQ/l+OyaDR2RpoTTcF1ia9kfE9QRd9?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f1522c-2ce3-471f-af4c-08dbb5648138
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:52:27.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtfukvrByQBd4+V4FRZckz5vBFx6d8V+ZtdZccrPnBxkRxPe8d/9ZxDmp1761peeDNZ6bXRC/2yX5r0rbpLlLIZU03vsOD9XFtQbIuh/E3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR05MB10182
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but 
the current implementation of 8250_exar uses RTS for the 
auto-RS485-Enable mode of the XR17V35X UARTs. This patch implements DTR 
Auto-RS485 on Sealevel cards.

Link: https://lore.kernel.org/all/24b88a50-9c53-82ba-84d1-292c74c81981@sealevel.com/T/
Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---
V5->V6
Split ret in sealevel_rs485_config
V4->V5
Fixed typo in commit message
Split readb and writeb into multiple lines/variables
Removed "store original LCR" since it was clear from code
Various small fixes to tabs and whitespace

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 3886f78ecbbf..34f0e18c7ad8 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -78,6 +78,9 @@

 #define UART_EXAR_RS485_DLY(x)	((x) << 4)

+#define UART_EXAR_DLD				0x02 /* Divisor Fractional */
+#define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polarity */
+
 /*
  * IOT2040 MPIO wiring semantics:
  *
@@ -439,6 +442,41 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
 	return 0;
 }

+static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
+				struct serial_rs485 *rs485)
+{
+	u8 __iomem *p = port->membase;
+	u8 old_lcr;
+	u8 efr;
+	u8 dld;
+
+	generic_rs485_config(port, termios, rs485);
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		old_lcr = readb(p + UART_LCR);
+
+		/* Set EFR[4]=1 to enable enhanced feature registers */
+		efr = readb(p + UART_XR_EFR);
+		efr |= UART_EFR_ECB;
+		writeb(efr, p + UART_XR_EFR);
+
+		/* Set MCR to use DTR as Auto-RS485 Enable signal */
+		writeb(UART_MCR_OUT1, p + UART_MCR);
+
+		/* Set LCR[7]=1 to enable access to DLD register */
+		writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
+
+		/* Set DLD[7]=1 for inverted RS485 Enable logic */
+		dld = readb(p + UART_EXAR_DLD);
+		dld |= UART_EXAR_DLD_485_POLARITY;
+		writeb(dld, p + UART_EXAR_DLD);
+
+		writeb(old_lcr, p + UART_LCR);
+	}
+
+	return 0;
+}
+
 static const struct serial_rs485 generic_rs485_supported = {
 	.flags = SER_RS485_ENABLED,
 };
@@ -744,6 +782,20 @@ static int __maybe_unused exar_resume(struct device *dev)
 	return 0;
 }

+static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
+		   struct uart_8250_port *port, int idx)
+{
+	int ret;
+
+	ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
+	if (ret)
+		return ret;
+
+	port->port.rs485_config = sealevel_rs485_config;
+
+	return 0;
+}
+
 static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);

 static const struct exar8250_board pbn_fastcom335_2 = {
@@ -809,6 +861,17 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	.exit		= pci_xr17v35x_exit,
 };

+static const struct exar8250_board pbn_sealevel = {
+	.setup		= pci_sealevel_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_sealevel_16 = {
+	.num_ports	= 16,
+	.setup		= pci_sealevel_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
 #define CONNECT_DEVICE(devid, sdevid, bd) {				\
 	PCI_DEVICE_SUB(							\
 		PCI_VENDOR_ID_EXAR,					\
@@ -838,6 +901,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 		(kernel_ulong_t)&bd			\
 	}

+#define SEALEVEL_DEVICE(devid, bd) {			\
+	PCI_DEVICE_SUB(					\
+		PCI_VENDOR_ID_EXAR,			\
+		PCI_DEVICE_ID_EXAR_##devid,		\
+		PCI_VENDOR_ID_SEALEVEL,			\
+		PCI_ANY_ID), 0, 0,			\
+		(kernel_ulong_t)&bd			\
+	}
+
 static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
 	EXAR_DEVICE(ACCESSIO, COM_4S, pbn_exar_XR17C15x),
@@ -860,6 +932,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	CONNECT_DEVICE(XR17C154, UART_4_485, pbn_connect),
 	CONNECT_DEVICE(XR17C158, UART_8_485, pbn_connect),

+	SEALEVEL_DEVICE(XR17V352, pbn_sealevel),
+	SEALEVEL_DEVICE(XR17V354, pbn_sealevel),
+	SEALEVEL_DEVICE(XR17V358, pbn_sealevel),
+	SEALEVEL_DEVICE(XR17V4358, pbn_sealevel_16),
+	SEALEVEL_DEVICE(XR17V8358, pbn_sealevel_16),
+
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),

 	/* USRobotics USR298x-OEM PCI Modems */


