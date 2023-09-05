Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA0FCA0FFE
	for <linux-serial@archiver.kernel.org>; Tue,  5 Sep 2023 16:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjIEQee (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351623AbjIEQ0J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Sep 2023 12:26:09 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013008.outbound.protection.outlook.com [52.101.64.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3566E9F
        for <linux-serial@vger.kernel.org>; Tue,  5 Sep 2023 09:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK4WI6vrPePkiAJm3QhHLZTmXqdFN4EC5xOmv9xGWnysQwjsLpFmb+k6ZDl3z4Be6HcpeNsWSXQ6+Hhra4cSOYF9QjqbcDAJiv1tjOXqzKx48/tiRM8ydUdBTlm2MM06vbtQ/tXZq2KP4qlL5rpZMzQjHjdqV/cMTaEWFgSNbCOR9s/P3DP3+1w2bDO0DgpYqCvuFFQPqH0/JgD8p5SZkW5wUXxIbkKBedAF23ivni6Al0DWRNkSyO50A4OkwYHdiu/LijoQ6kIchlhJWhHM7UrtvBOIOObm4/NXZ56asyJggSTrxdHR7RKBqjQhQbnJtqtbOTUPYc4ksDXEeB9GGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+dORj+o/mvgH+DqPGnxFy1+jBQsGl4jF8I6wIBQBUU=;
 b=GzcObQe1vfYEHTdTUC9ljcYW4yOg7fi5VH0r0UKiEdLaW8/KoCh3m5+g6B6KKch2DiezWr4B9jgJJhvacLDTr4N03Af64YhGVIKvE5VlYcyYYeoQOM1TejMmbC91vMon+o0oh0ri02vH1JxOIHhMsYf0hCiPj7Y5b/SEQ7kHFAEPXHmSjVzkeTeKZj4haVcJbdWTXSAdYpM4AMqn62zl4NCw0II2mKl2IXyMjI+X5S8zsewYpD16WQemHMJFNb4cCLrIi2evGXHwC7KepwFdt9jYGTwcc5y4E0V3WOyIvuhfeGT7fbMbjZCi6CZcKsNRUyYt4/e3pxBTsz84tgHbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+dORj+o/mvgH+DqPGnxFy1+jBQsGl4jF8I6wIBQBUU=;
 b=PI4R9UWToWJLMaSaYBwebLZY5DyhkXUm7Urlu+qyLltkrA7H+zumT+W/cPGi2GTAYLIc/lUoYnpMzBZyXe0VxkdoYDKplCvDMXL9ia7o+WywyBOZmiYimA1WHo1oYFPxJB9PcujgfXng9F1fafG1uggniWYFC/99Gm4kRWKDq3gBuvVFWTMR9k9vp5Q1L1mnEbHgtO80CAaSBc7xdUtCtrGTzmPpn73vOlD97++p/2/u8mrzxgRletSWOmljdWiln0/H4VdJnO0n2RPT9Yym8vXKw0ehKRh6PP5IresIALEDh/eWXURPkPmcg0mYKwcsZnIZpp+2AD3YZCSmRypp7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by PH7PR05MB9131.namprd05.prod.outlook.com (2603:10b6:510:1f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:06:24 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 16:06:24 +0000
Date:   Tue, 5 Sep 2023 12:06:20 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@intel.com
Subject: [PATCH V4 2/2] serial: exar: Add RS-485 support for Sealevel XR17V35X
 based cards
Message-ID: <e2564a57-128e-cd9c-9bae-23b155fd8ee9@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN0PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:408:ec::21) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|PH7PR05MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c64912-8a73-42b1-a198-08dbae2a0d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lc5hX64tB+gVL3bx6qMvfbYNWu5L8WJbcKbKs7vLImr9lFmlqodrYVubK2/NjhIlfRrxA0TRVaQu3/oZitTQm0QrDTmRZqNXC+V3yrhLovDcUZKB82kg+2UIqYeRX6vqupVrnOmEcvPfjhjOf7Rh6uG/YbJ0oviAly6ElmRNPnJzQorxS+98/BjAzyyvq/0ja2EFZRxApLqYrwxUFjQK9UQLof7HeKBurRbPfkBtf3p78P+/O6iiITBeMnsYBPg95g6RBfJmwQmB9UtGPOYYvfa4P9xRfTgLh9kk6LRg4FJKwyVKOlkQ91WjowlT7h1exi7yR+RESBYrs2tXEU/8F7eK1rzLZfy+abw0HJEpyQ6xIGXy+mzho97czpEN3dc5cW0aw4f3Tcn3tTAbHeKT9gKLW2MNFS6r0ZAzvfPy59j1tNnjqPnXLg9Q/OX3EZubHg86avVMnRfq7zkRWIFhYjyInC4qnGJ1pp2w/jACSQ+6ENUV42MJuibypeTn18QDSdg+QbYc06YKlCpVl5nno+LSUUguIUan1f1XQRSNQ0EfcOwq5R66pTxyJUFe5B/GVSzBztA2xNQhN2guFq4Iw3MfiQUZsjjBnLssfkF0NmdaNejHDn3gUNGRAnKDEFru1zqT0grPUdbg0NqtqZYEyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(366004)(136003)(396003)(346002)(186009)(451199024)(1800799009)(41300700001)(86362001)(31696002)(6666004)(6200100001)(966005)(478600001)(38100700002)(2616005)(83380400001)(26005)(6512007)(6506007)(6486002)(66946007)(66556008)(66476007)(36756003)(2906002)(316002)(37006003)(31686004)(8936002)(5660300002)(44832011)(8676002)(4326008)(6862004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U0LCyS7lq99xgZQ5peAbBa26w3wYd6zUI6cbkURLj23lyzUYKqTCMqSRADoZ?=
 =?us-ascii?Q?8SHq1EyajB9fYrqhKMmbh1egbxwnSyI7vFmoNZN01G6EV7o5s1F52oIcDYcf?=
 =?us-ascii?Q?zhD5lRdG/w71x0GB9M2iOy0zfvssKs20f9wDpVutQa47TsfQkMaAEQru3xi7?=
 =?us-ascii?Q?kAfoNPB/l2qTOZP0gac49ry5vXPl5L/Q7X4cW5mMRiUxWaUFG5TLLVeZk7OR?=
 =?us-ascii?Q?qL+gmIHXOHvkERbU6XaDTIEnjK6E+oJevOiDWOekqEHCFae7584VLMbOK2Ka?=
 =?us-ascii?Q?AM+lpsMUkuMmNYWyyqRCljLmcvZHigc0OeikfkQivVrz1AXkqPiqswsSH0nz?=
 =?us-ascii?Q?UQOABovhewXgfR3baqX5z/lDWsRsN5AszGDyQeC521El5MatQMkxtlBj8FxO?=
 =?us-ascii?Q?6FzR+CPz9vCe3vRxL12QPeDn0CkjcCL9pZAzvZfkwliwUbuBJSmqfRHJ63U6?=
 =?us-ascii?Q?dviRIKiFKGboGCehDp8oroahPxf0Fh6Ujh9SqZCvG6QXzAcPhO+KNBhnK+ne?=
 =?us-ascii?Q?HMngTFPXdAyhq2D2D4W4BTAbOUTs+3VYx+p6hNEqRwFlTf1nVO2RUyzhT+3K?=
 =?us-ascii?Q?KokI45WiD1W5A4d9w6erDazBQhwN3XZQHB7gHxmTHsCeBGEQBhSEojlHTft1?=
 =?us-ascii?Q?g066sIP8p3G4KlO4qWhrtmq3gm86fx6wSReamc3PwVjdz++NyaPHLAwTvex+?=
 =?us-ascii?Q?VfW2puMUQJtsTpMjip3BgwZurxeG00X/i0udkzMGQW6VTyuj6bqjhQmFVfnZ?=
 =?us-ascii?Q?BGIzwCTe3H69hQgyV2+OuOkSs5KbIl8YEz9C8HgIb5lmyLN6bHkgbG3Ops//?=
 =?us-ascii?Q?KEXX1stzJ3zTpWGW8aD8B/AOH4rvSEyf0CURZ5BI7BstGUc8BtZAjnd8YN+Y?=
 =?us-ascii?Q?DN6tk9PfZZdRrWitr6CYpXPGEiJl6/iG04HND3zWR6yhKpwBbWb9RNunPBYd?=
 =?us-ascii?Q?GdsHB+z4CBRezgX9Ia8Ksfg136JDG5djsqwkCwYPq3F5R9RdbzctedfBlhZ1?=
 =?us-ascii?Q?qXE0vZFFITFPDnRRH7cXepIpdNvOEMQOk1uJl+YzXRbktIOHNfq0iGi17ZPC?=
 =?us-ascii?Q?vJMsW9NB5tE0f3AlPcKi7SEggdKvrUbwS/FBoZY1fp4Z3x/aEFgfQiJ8h4Cd?=
 =?us-ascii?Q?s6gjS4aJ0iaY/OdsAY/UHncQj8EsDuGmiba4eQb1cBgI5RaaApPAob2MATdQ?=
 =?us-ascii?Q?ChYTs7CqLRZBufRnjPHUzCGOWyIU5F1UgcSM1/pMyNkQC5lHCAP4FnmNammC?=
 =?us-ascii?Q?vlohjC2aQxFV3yyOyWIf0kTKsXSD4U+FuO0TXGBV7hP9i1yR9Pcrdf524mhK?=
 =?us-ascii?Q?70N9kOQEfrpoTL3gvFE6EuDwmQirq2R7f7l5XIqQ/vVtFg8ZNM7juTSgpJdr?=
 =?us-ascii?Q?IsgIvx5CkkDvgVWFRPF/2k/R1B+VIbuBEh5y2NCjxqTf1y4VwiO4U257Mjd+?=
 =?us-ascii?Q?BxMfl3oYXsfpCvnGNg+EwMiH3iSLtqLTV5G1ULuE9QbK+u15LNwTjvIpTo/S?=
 =?us-ascii?Q?l/NtwRb5yGS3xPowsunv9196lgHD02PJCJnzfQpRCGydI5HYsLA6ici0u4Zh?=
 =?us-ascii?Q?VdcfQKat5P13OqZLKl3gk6DK2x9JWglgTd4I+Dv4gXIH2rn5BLeH6JFwlRKc?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c64912-8a73-42b1-a198-08dbae2a0d4a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:06:23.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /T8Hmo3kzxSIElugB0jBYXSAMkM4stuiwKjqhMdaXcQzkWhp+TlaP9IIfZ2VsFW5UU0LHgwFIHeLE6T8aJKnZkykVmh7lkhD2RnKerWPsOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9131
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com

Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the 
current implementation of 8250_exar uses RTS for the auto-RS485-Enable 
mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on 
Sealevel cards.

Link: 
https://lore.kernel.org/all/b0b1863f-40f4-d78e-7bb7-dc4312449d9e@sealevel.com/

Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---
Fixed style issues from previous submission.

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 3886f78ecbbf..20d2e7148be5 100644
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
@@ -439,6 +442,34 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
 	return 0;
 }
 
+static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
+				struct serial_rs485 *rs485)
+{
+	u8 __iomem *p = port->membase;
+	u8 old_lcr;
+
+	generic_rs485_config(port, termios, rs485);
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* Set EFR[4]=1 to enable enhanced feature registers */
+		writeb(readb(p + UART_XR_EFR) | UART_EFR_ECB, p + UART_XR_EFR);
+
+		/* Set MCR to use DTR as Auto-RS485 Enable signal */
+		writeb(UART_MCR_OUT1, p + UART_MCR);
+
+		/* Store original LCR and set LCR[7]=1 to enable access to DLD register */
+		old_lcr = readb(p + UART_LCR);
+		writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
+
+		/* Set DLD[7]=1 for inverted RS485 Enable logic */
+		writeb(readb(p + UART_EXAR_DLD) | UART_EXAR_DLD_485_POLARITY, p + UART_EXAR_DLD);
+
+		writeb(old_lcr, p + UART_LCR);
+    }
+
+	return 0;
+ }
+
 static const struct serial_rs485 generic_rs485_supported = {
 	.flags = SER_RS485_ENABLED,
 };
@@ -744,6 +775,16 @@ static int __maybe_unused exar_resume(struct device *dev)
 	return 0;
 }
 
+static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
+		   struct uart_8250_port *port, int idx)
+{
+	int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
+
+	port->port.rs485_config = sealevel_rs485_config;
+
+	return ret;
+}
+
 static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
 
 static const struct exar8250_board pbn_fastcom335_2 = {
@@ -809,6 +850,17 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	.exit		= pci_xr17v35x_exit,
 };
 
+static const struct exar8250_board pbn_sealevel = {
+	.setup		= pci_sealevel_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_sealevel_16 = {
+	.num_ports	= 16,
+    .setup		= pci_sealevel_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
 #define CONNECT_DEVICE(devid, sdevid, bd) {				\
 	PCI_DEVICE_SUB(							\
 		PCI_VENDOR_ID_EXAR,					\
@@ -838,6 +890,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 		(kernel_ulong_t)&bd			\
 	}
 
+#define SEALEVEL_DEVICE(devid, bd) {			\
+	PCI_DEVICE_SUB(					\
+		PCI_VENDOR_ID_EXAR,			\
+		PCI_DEVICE_ID_EXAR_##devid,		\
+		PCI_VENDOR_ID_SEALEVEL,			\
+		PCI_ANY_ID), 0, 0,	\
+		(kernel_ulong_t)&bd			\
+	}
+
 static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
 	EXAR_DEVICE(ACCESSIO, COM_4S, pbn_exar_XR17C15x),
@@ -860,6 +921,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
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
