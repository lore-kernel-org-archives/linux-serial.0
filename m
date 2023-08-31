Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1A9C83F2F
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 19:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241820AbjHaTs1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 15:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjHaTs0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 15:48:26 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011009.outbound.protection.outlook.com [40.93.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80581E6B
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 12:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnjR2PjJijwRiv3Uv1LTg6AB7nyCeU9R0c1eWrbK/yfpNw4t01qMdLs0+IHIKuWeNZpU1zajP69grpRH5ppf8bb2MfcIMupJ0C3QiLdbQRYS3x+qC22q4DywPYn7r+GldFgVby99jpq93YnL3a4jrQSeJ8F/7ClRf8Mk0T8Pv8xer3s7loOgFqMePDAMGpL5exKkgFETzVgN1BDWdIHVShzIBFSDJL23ak90ns8JjfaNypbVLtr5LbTD0wA+PgT0IAK61i0FqBz/N2+GiiJwWAjKlUM5Vb3x4lzLOAt9pPNGe4STf+l5EEqHTIc06k2ikLNWEglE4Jloj8eL3iYEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8Q5qz06IrSifDkh0vJ9FNy0S5H7Xhv2dJ2UVfTDCYI=;
 b=fb2e9E03r1C8vTp5/4b7dAiMdHSIVr/tW2eg/K6WD9k7gThaAYILoX84901FGsLBfqHnRL2i+hIZfcou5LqwoarRjMeL53I7sDu6uCF59O8BsXHDfWfuFw+Fsvz0ZvQY4L8KX5zgjYTV79pbZXbupWWAsywvzeCZ/N2iKVxxksbH2GBFYCd0MasBfELLOBN0CWZuu8oQJKil6ZaWNO64T9/cdtWm3fYW5eqHNH1Xn8i84oCGEnmwam8rXpbdp2Vu/VW9QAW6JT3L3v2LV6zae1wzcoBydwwBnWNWwUu2xjFzrLsaJ2ymi+FTaR0INz90fAPjBo7CXNncFFGcvJajMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8Q5qz06IrSifDkh0vJ9FNy0S5H7Xhv2dJ2UVfTDCYI=;
 b=nJaP17Mufce8IHxUWQSMQyoCi1SZPWLQa96+V93Q/X2QeEgSO/XsuAhF0G55Rt0CVQ6f/kQjiqIlEjKftVqrXDnGgr5uxEvxXxRZJ6cOScKJrplTd7a08tNV/0yaL8Fw1X8kEphYbBr3RtdfQxI19PYVSPtjJdsWMjHtgsxdUNlzmvWI2iX4jcyo+XsjDk/7kY3Z3UCOGCs4FxvurCB6ChY0jM87AAeGJhyTTXUaMdBkM0VytWiNtOJxPjVgc15rxAsdNN5W7BNJUYs99/lRYknM8l5Fx6PzEgv7+xdzBITtfI+byt1z5pcjAlM8cirRsR7FUm4uOCeEOTBRhEdc/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by LV3PR05MB10336.namprd05.prod.outlook.com (2603:10b6:408:198::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 19:48:11 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 19:48:11 +0000
Date:   Thu, 31 Aug 2023 15:48:08 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@intel.com
Subject: [PATCH V3 2/2] serial: exar: Add RS-485 support for Sealevel XR17V35X
 based cards
Message-ID: <b0b1863f-40f4-d78e-7bb7-dc4312449d9e@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN1PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:408:e0::11) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|LV3PR05MB10336:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d30baa1-572a-47f3-5c21-08dbaa5b3526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jC7jDKelSkZvYtNkSf2TO3NYSDk6VQg5lOPcIdVwlHXbvEUczPNOgZTsqlvF99KIMbyQakYPmHUxEjPjw1K8tavbDSSPFtgyYhQEjzpJW+LLVbtlUVXZ5rUqEEW903a3DHWaxOFjZjz+amcmpxe9/dJDOOwXEprx8uQmsEcxeZGWqIg9BTJxaUYvfOzJ+eUQhnjYMrg57QA+cjzDFRGumXNe8B0uRuYbhWT3KcVUwg/0Nya993uvN93lBdOtWCuLZMHUotKY+bo+EJzx2oxN7y3CJ3mv2o8ZnwI0JSsdSNy2qEOgGOx8yxT2CwMbE2YHFBuL/s9ReZIBnWAII4nPZv5+PCCGP+xx554IKim24DuBtD3nQZLG50TMfrHEAhr9sbazp6vfyyhh1hlvPdzFUYbZdstq/KZPu600qrT9/YoQzpPi2TeSawTC4fX8B95mTUGcF3yHfhzrmJJpeeI5tOBrZQTXMjFM650iVKT9ovk8oUCZ1hGwV3znjsUWIi+cSaLJbMgkReVfTR2+OBBClLyDW06snWLttwjaHNuymqyeoBZGLm8pVJprfqYE24rRxOm8C8JywUTDfounn0z52aUBbPayxNed7TKBhaDnRt42fKA78n2GM3OdWpyv5vJa+4XwSd7l+65pzPyBihIsbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39850400004)(346002)(376002)(396003)(451199024)(1800799009)(186009)(6512007)(37006003)(6200100001)(316002)(36756003)(41300700001)(38100700002)(6862004)(4326008)(83380400001)(31696002)(2616005)(2906002)(8676002)(44832011)(5660300002)(86362001)(26005)(8936002)(6666004)(66476007)(966005)(6506007)(6486002)(66946007)(66556008)(478600001)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w69rvNs0qRukOp1saV050+Lm6rRlDIH9yAx6V4kzJSFbcoLT4Nvq/AkhoZBC?=
 =?us-ascii?Q?B73UI5qeUCzElKZZ9ERZeaHH2TH0rur3u5ufgbUIBrJ+ECVAjdCcY21RE+F6?=
 =?us-ascii?Q?CLwK0vHzZgQmwqAR0kCjaEGF7q+E0oK1WxCRYu0vH4StiMZBfwmZBrlu/D9H?=
 =?us-ascii?Q?cnzUuuRB5/P/aG3Mv7lAtwJbbKbqAHLPGy37g33+YSZtTotQ6WPV+7Q5DL8U?=
 =?us-ascii?Q?uUJbfiNhpsg20HDWnJ/kwlkqMn5uIfTqb0dq4KEMp9ik3/a6uqwQ94rzpN3d?=
 =?us-ascii?Q?0LNaHiBICKDmzIoovZ3mI2Jd4sumV92OqP7j327tTlKPoXWB/6Qyi5dMGuQy?=
 =?us-ascii?Q?P3SH66FG/GUrxEvU1yDRGBR87eT+KzpUZwTp4DKlg6fkijjdbuvpcWeOYW0G?=
 =?us-ascii?Q?UecH4HuF6f0hs67+h41ipCfLHAfOpIpj04wM5jxoioGsZQc+4SU8+22HKRn4?=
 =?us-ascii?Q?mpzzaPWFlRn7TS0V2Qhu8Kr9zxN8/Y+v4RYOTyqhPnEOYVtkREaT6bLp47xX?=
 =?us-ascii?Q?G+ectSoQE2CvANt8G3/ZVJ+Dj8bm6aBfbvToxw0ZyaxTYc5l9r7Um6HsK8aN?=
 =?us-ascii?Q?5DdMn7jVyNuJaJEk3DmbiAczF3c/NEwghmY6UBY1+boDaHYAlpiz5ss3fyOg?=
 =?us-ascii?Q?OwjIOSBtAZNoa+vW6v2Zhj8KKHwPDwybyLDVE6fXKdMHJDpWCBAOsn4mEGVr?=
 =?us-ascii?Q?L8Lnn0QGH92VU25zLfJxnLxSGb19Pw+cmG/spz1Ye8GDZRWKsn+g9AkMpyPA?=
 =?us-ascii?Q?DaYFdy9wqFPXPZ+XsG/RCOETH2foXJATTCjIyDdRaOKDGNoRoPfeTtsTjwNW?=
 =?us-ascii?Q?36AsCjp7uPATZb9CK2Ulm60AaEP3K62cJ/VDwdiHCaDlH3X0V7nzHu5rInBs?=
 =?us-ascii?Q?PAV92gAcdu4lws0jaAZK3B92dVFUe9Rz7x8DOfX1/lW1YX22rkow4fl5zzq3?=
 =?us-ascii?Q?MsvcvKYPolNQ0n6n1NPMCQpY1RoUOED4ojh3//jtFFz402BX2k67bN02l6ns?=
 =?us-ascii?Q?0QEbyZ3lT3eDHesirBt6BoEZ+MzX9wC0vk3BZPZTZUESxMDctWJWNJfgfbFX?=
 =?us-ascii?Q?cu0ZjGIjxvdSv66Snh057OOptSKS5FX6fEhu4zEpWuSCic28xm5oEvR3Lc2r?=
 =?us-ascii?Q?wgarqghvZPeD2FxOKIRANUJT6xEyvdVQqj4L+CGQqi3LL1TFGryNk0Texe9K?=
 =?us-ascii?Q?vl25p/LUBfZMUcErWuSGmc8UFlCAlhjtUc0b6uDynwNcF1BP1i3tPdPHqae3?=
 =?us-ascii?Q?TFUQVdtd2F+211+RqJhjr1bDG6DYqWX2edF8y/br/L01g4phdWpyfYDSyP8+?=
 =?us-ascii?Q?+X29GyhwcqzryjHyx+UJmvirCxjKfQlI1FvfWRHxNu7+4mWF8ZJUWA8oDONA?=
 =?us-ascii?Q?1UmaHm2kKd9lTjHoPT2eYTW0OLqv8znI1L6c2QgBPt85GkJgHYwq8WuMHdDV?=
 =?us-ascii?Q?JQgTp2M04t+GpDwtgeQs2ts5VVtmGlrvfFMBhnvKls4ul/DGsGHAyIb5/9V1?=
 =?us-ascii?Q?uo1waWLWRrka3x37jCue/YQQEi/LPLnXrvOIMG1wqVoKUJuAngHZ2bU/cJL8?=
 =?us-ascii?Q?lXlMeuAZtw8Ki+/iPt5nyBxvroIAwzbcvB8vQskz4gxl+aBI9r5Jrow6Fa/W?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d30baa1-572a-47f3-5c21-08dbaa5b3526
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 19:48:11.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DX45uu4IXXzv7EXDlLzOdLNhM0Zm8rAGFcKzLemz5FBwUIkeyU9/6q7PkpONHyUjI7m0F5cV2pyG8Xokx0bMmYp7UJZsHYi5uLBHvC8M16k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR05MB10336
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com

Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but 
the current implementation in 8250_exar uses RTS for the auto-RS485-Enable 
mode of the XR17V35X UARTs. This patch implements sealevel_rs485_config to 
configure the XR17V35X for DTR control of RS485 Enable and assigns it to 
Sealevel cards in pci_sealevel_setup.

Fixed defines and various format issues from previous submissions.

Link: 
https://lore.kernel.org/linux-serial/b2a721-227-14ef-75eb-36244ba2942@sealevel.com

Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 3886f78ecbbf..6b28f5a3df17 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -78,6 +78,9 @@
 
 #define UART_EXAR_RS485_DLY(x)	((x) << 4)
 
+#define UART_EXAR_DLD				0x02 /* Divisor Fractional */
+#define UART_EXAR_DLD_485_POLARITY 	0x80 /* RS-485 Enable Signal Polarity */
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
