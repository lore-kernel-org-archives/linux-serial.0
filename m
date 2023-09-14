Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A233AEDE9BB
	for <linux-serial@archiver.kernel.org>; Thu, 14 Sep 2023 12:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjINMc5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINMc5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 08:32:57 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012002.outbound.protection.outlook.com [52.101.63.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247651FC9
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 05:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfzQlIHBUCcgzot4XT8XnzE1LO683rIEG2J14qaqvDCRwA5BNtE0RXY8cBks2Ch3c8HpNBLvgnex98NhxOljIH9klA7Twa0peDCK44TV5DkhYe7iaLfvw20EfYRZLl0RVXUIcIRRSTIuW77Q5+eTxJiW1HDpYH6QI4JbWcKij4dSznaK5Rkb3FnKQZWOJacdyiYwmRmFWG5LE4da/K2BquySg5nyegPcEd92SWCsuV3HjgMINJ11ZmEZH7yh1nTEJbNASN4vf3yhbqpb3B93FT30IgSziElmbnZLodJ6GcFG/VHmcg9hF/eD+Bq1T6dX8lqY8O+qIZIwyZ7l4iVXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2pLCOabxvD+r/QlLNiQpG7edklpuhz5jHtYKNMx0ts=;
 b=PDyMBFwmcZYNJiimKTY5SL8antytLnl9B2gnIVFq/SdLNMVBXBboEr8ocs2t3UlC1VYdvkJg0JWGZxm8xF8bRk/ZfHTMOJbrwAGUetceQfZWidB0trVANysAxg2W3RYMsxCrqc35+Enxp8WPygXMJGZ2xXIMwNKAIiSRS7bnlLeJwM/GzgaLbaRB0eMx8cQCuqIF9XGfMoBfpc0fbMTzzdTaf05fbp0sL6bBvrwExMhfDWc94mqgmmEOF54FjthstdmrMdcw7NsmKujYP0Ld7V3PggJSmxJx/VIidazHBVID0dQXbztGPUGpVp8Zs9UtusTUzXTaQeVxWts6quIMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2pLCOabxvD+r/QlLNiQpG7edklpuhz5jHtYKNMx0ts=;
 b=ck9yFhK2Pb/MYVZc33LRnAfTVH2ahUcwaN8/tg778KwnEU3pt1ybR8iZH0LB9bi2aUGMPRT9peFaViHYssmkiu73kke7w1JTELRiYgQx0fywM+dQkqqtULgrtYlDN6HBCsyFbw14KjsUqPXASvSrFFNRp5Ds+1Cqi40CNUYp6gDbANI7vKoTULiGFB7sI56CKlvSklP01JMz6g4XpkEx/uWMh7KeeLVhC/ejYFmdp7gaK13BouWkHQq8gEdP4VWI1BIBNn07q7T0o8EqIzerWDnT1SZ7l1HjxWGXqtvdQq/f3QsPf1UFV5uzY3vYZioTESgqZrZKXuSykExt6GQ7VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by SA1PR05MB8723.namprd05.prod.outlook.com (2603:10b6:806:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 12:32:46 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 12:32:46 +0000
Date:   Thu, 14 Sep 2023 08:32:40 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com
Subject: [PATCH V5 2/2] serial: exar: Add RS-485 support for Sealevel XR17V35X
 based cards
Message-ID: <24b88a50-9c53-82ba-84d1-292c74c81981@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0882.namprd03.prod.outlook.com
 (2603:10b6:408:13c::17) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|SA1PR05MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: ead58d38-635d-475d-a3e8-08dbb51eb322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCB+OGVK1vwu8orHOEFRpLepTpzZAnd25nyae0oaWrqGw3GpyDOUyHN1uccqB1uNsKeZMImyruKKqA14ZHxcfc8k3YwXOOQ+ZLZvDS2hc9lNY4S8x0hV1GI75jaLqWamObATB46v1waElkMiheNFljLVok+sb5FaD0k4dBlDdzVg5FJ+wXCxCTrvCwmBdnyPyi8/Pc83v9CuZiZvA3DU1NgCjkv5yyKKsRl8WNx5sFH60ifMastcdf6xmvZdwWtURfCBNEs0GJIGcjgYXckeumogqLOmopQVJ6LQRSO7+u/DoWNit5VzGadZOqEerlbYV1nBhqpIe3tqgaY/g3Yre4KVVoVExOx6JdkfYTRYpsrhKZBt2fhLdCWiRIeqEiJJcuoilU1sgiSp1mUvfZCukP173xgqVsrpP7gr/FWDIwys/2yZb/LrBE1lItspfnRYoriXxfGc1aYSFvpe1WugL6KCcQxIneybItdjfX3Q06Gea+z3hPAhxFt4NzbdEYezmLIYW/E0JC6iQKeD8AkB2UKyiUtzltfcnix3wtNH18q+xPogJgwTZmpjcJMiztBv/JzgEt1KpUAUXfMokmkcASgftYNCk2m43VahSPRwg2byPRrEHAMp3AhzB3nMAR7ROYMej+E+rh3w9pOFsDoqYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39840400004)(396003)(366004)(186009)(451199024)(1800799009)(83380400001)(37006003)(6506007)(2616005)(26005)(36756003)(6512007)(6486002)(8936002)(8676002)(6862004)(316002)(4326008)(5660300002)(66556008)(44832011)(66946007)(66476007)(31696002)(6200100001)(86362001)(41300700001)(6666004)(38100700002)(478600001)(2906002)(966005)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9JzjeYE4wqNTra0Eh0D5T6lZCb9WMilOEauNVBHpDAgZ9Hn3om0AAf+xEij/?=
 =?us-ascii?Q?Olz0Ijzrh4SHWVpSyUWLnfV4uqY+xnd12S9G5W4peK2uWc90z7bffjGtinmB?=
 =?us-ascii?Q?iigWew0udE2D4ZT0x/5DBewaE1DgpkPk7TpBbXk6FJA+iD7jR0NBbFnQro6h?=
 =?us-ascii?Q?efp2j+amwv1CAAYzKlWqy1KgZlehcIitZmEnVkE6sjvRjp1dLbJwBKuoQc4w?=
 =?us-ascii?Q?evNL17teQtKrjcyYyQCDM5efKHYvgfogbplyfU9u9DLDpVVT5eosb0rttZhJ?=
 =?us-ascii?Q?WEyi3fj/dMcxPOPZzsAnxZFCJWVbRBVw3jqSpN/Zxjv2ikCCROy4gnXSFlMl?=
 =?us-ascii?Q?UyGnFfPC9ULeCkUKmwL7eF4JhdHGSXj5ZGejf/9TZXaozodiTyMtr/ZfTeae?=
 =?us-ascii?Q?ZuxvkK0w4GVHB70AFLnm3vk2YLxuZjdBTyCr3NYroH9GZ+SWtcnIOOwahL9A?=
 =?us-ascii?Q?9KJMfOs6sVWD3ZCZgpI6b8jLIVnRvhIpFR5l+cxXhJax/Xvx/MpvhwCgaoIJ?=
 =?us-ascii?Q?UZ1yi7ihRe7rGyohlbwkHgi6zGG7hi4aVRVJcSvqkovupMyUdi2qTHKLYnrC?=
 =?us-ascii?Q?MR+8Ym1eeQBIQ5OHQgz7GAC0timMz2Wc1uCX9DHdfrbuel+wRmbjqb9rVvoj?=
 =?us-ascii?Q?svnV5MIrZSqUqfNTimhlrIBd/mfOMvjyFEXbEaTE2Cll5/zm0jYN4uvKKnBi?=
 =?us-ascii?Q?Sl2IqY3n9TfTsN6iJQp4PxPcCRg7Bjo5IQ0ZEsKosP+9E/VJT8+WQ/wNHf+A?=
 =?us-ascii?Q?RFWAA08gIB9XDC2qLQCmn6CGpb/1JHfBpLIPd9GMADZbVGNCkGX/ADxQj1PM?=
 =?us-ascii?Q?XKqhHqG/QtxPa9NzSOciLXqn6ZHooJrX06fbxnQ1LRDKOAnrcIZ1GnEMRw+/?=
 =?us-ascii?Q?usi/+r8QF73xxXXCpQzDTVefTTGnIJIZEYs6+wjuhnsnrt/1SOrGyBqU3O5N?=
 =?us-ascii?Q?jv9NjGldP6ekJgYOd6WuofIS4ictOnAxwd1HnP6Xd87koUcM/JScqR6HoTvP?=
 =?us-ascii?Q?5QMylCsuQPxTm0cPB5pX0RUa+ptPE2GjqZgqEfyc7Y70iHcnr7+oNZLumtxR?=
 =?us-ascii?Q?B9Gvc6OXo0Fmf3UZ2broZxwlwa0xCsdlWopFg+DPaznVuBIkoWFi3oThG8Sf?=
 =?us-ascii?Q?hvgC89QeBLl/I37NGFLtJ/+nhN7Cz3scPk80wplaIXGFvU8eWhmFy8pp8AUU?=
 =?us-ascii?Q?/7Fwtt+E5i/C8550FSiY57oDAheIlDDGqxwyk+ou7YbDu99AhhiQ4Zr1whNz?=
 =?us-ascii?Q?BoF0ntBhkldr07ZjH3MrpcfVeVGVZCHJaDkpJnO1m8UI+MkWM8X5AH0ar89C?=
 =?us-ascii?Q?2uczmRdeTA6csDDWoHm2+UMNOss/ZZx02QRTlqAB7hHoANMIjeiTYLVKilYZ?=
 =?us-ascii?Q?/Fnj9+lO+fyRnsry+pXGdIOlMXuVGqCL0mjaArFQGAaG7qNG/ZBHOyF7egw3?=
 =?us-ascii?Q?bfU2PSkC5KLXmdJL547W0zAX++lLSdbnCNCVLSf5WJBEc/9QolUz5Dq0vYgU?=
 =?us-ascii?Q?98+QcTnCaZgOUjLtb2v+I/azzxnbapXxE7KMKmpg/YOp1tpfU9T0QywTi/QK?=
 =?us-ascii?Q?RUxwlhLkwBQSgQWz0f4GDtNecgn0XfCCjqjJJGVNZio6qIrUX0tSKPMnZxtm?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead58d38-635d-475d-a3e8-08dbb51eb322
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 12:32:46.3830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3vjzDAIVSP8H8s7HjzdAzabeiJFjQRmhupGlzJPNdCDVLyJEKD9Z9aUtQ+0/RpevNivYaxrSMo0THHwygTOW/ZMBw4g5J9Vx8x8++aWVRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB8723
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but the current implementation of 8250_exar uses RTS for the auto-RS485-Enable mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on Sealevel cards.

Link: https://lore.kernel.org/all/1b3f5094-0b14-5a22-8654-a64eb8b7666d@sealevel.com/T/
Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---
V4->V5
Fixed typo in commit message
Split readb and writeb into multiple lines/variables
Removed "store original LCR" since it was clear from code
Various small fixes to tabs and whitespace

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 3886f78ecbbf..9866dfc84953 100644
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
@@ -744,6 +782,19 @@ static int __maybe_unused exar_resume(struct device *dev)
 	return 0;
 }

+static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
+		   struct uart_8250_port *port, int idx)
+{
+	int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
+
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
@@ -809,6 +860,17 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
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
@@ -838,6 +900,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
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
@@ -860,6 +931,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
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

