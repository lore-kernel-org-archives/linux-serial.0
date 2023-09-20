Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF29AC04FEB
	for <linux-serial@archiver.kernel.org>; Wed, 20 Sep 2023 19:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjITTDW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Sep 2023 15:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjITTDT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Sep 2023 15:03:19 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011011.outbound.protection.outlook.com [40.93.199.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EF9CF
        for <linux-serial@vger.kernel.org>; Wed, 20 Sep 2023 12:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMlaWWseur3Gl5RMc9Qv0ZOQ1IPmdGinwd/i+EBM0jfDIoc/gChnW2LlZ5+VtZxkhOUeITSTl5hiUMaEr/a4zd9nXSibODDzZb5qeO7UJGO67sRNEN+wa6RDlSL0LqqXqIuNIj1ruhKN74DigN28TdIUcyGWoOoJjJ0mXuWu3FwfHGrVs7lbePVJSMEe+5bfB3TrxN8Fg1KXd3rmyLA4sVB+crqxUDr7hlcB5gR+CXF7mmz2t28fXF0PdS29rQHWH0Wcku9bnT25XTpYw1D0FQWD55mF+rVYrQ5fLe6rE+1uimJAseUf2lJuywZrPpMaKAlGnHgfvqcmHfjqxfd0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOzjSCqp3UpUsBvYxpleaRNS6MeJ87CoIKA4QhmNK88=;
 b=bexFRTJtTczOmKS/DLnr7lQdk5BMUVfPxn6LO08eVIuBAsi6QRcUNG/R2WKIItEafwHJrxsGZlyp0hKKVrZ88QHJKSmGz+ZoAl9lwYY1Hnwf0OyWp5OtJ+RTXkljuKvaM1YDeLxwcalNI6uLpOD06EdWxNjw3M2uBMipuNtTMLrKcwyVKuqCseOJ5Uji/D8rKj3vXkAvZZVdl3E8KyOZ2n8lWoGFTlMUS66uieuqLsvub0uwTKS5eDDiHhBrTQyg+rlsC7MSlt6Qj/QPUqplCpUlJnyeAXCEiOoGocpJeyZIN3aT4vNwr92SZK5Jq1wdBTPTdpCMUx1WGwTPPFHM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOzjSCqp3UpUsBvYxpleaRNS6MeJ87CoIKA4QhmNK88=;
 b=Fkt1kY+1tyzWdCOOobJAJbvwWdYRwsUs2wvnIwk8RbeuMEExIZf+NPalz5QVQsKsEu6nbBdiBEBoBniNaACOPiy3jMQ6B2SFCNZ4O7w1VvINbZ5JBX8WKXz47ld6SN2/8IRymOsAZKPXFKCtxVVs2NGgGGrHdk85rob//wEIDPR2AtuseRn+OxMKIlvoQO+qZS+HJplFhAiKSuXhE6f+QSK2mZui2xHTkW6QmPeQDGK0pB3jM/Lh50c2LlglUOt+fq8DuY4iRknaYEnGtTfL2DC1PodMpjBrBLj4PTeMZncpJawgLYoT1Uoiqihqlf54c/4dGirIM/Ne1YPr7xvbxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from BY3PR05MB8419.namprd05.prod.outlook.com (2603:10b6:a03:3c6::10)
 by SJ0PR05MB7231.namprd05.prod.outlook.com (2603:10b6:a03:286::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 19:03:06 +0000
Received: from BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4]) by BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 19:03:05 +0000
Date:   Wed, 20 Sep 2023 15:03:02 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com
Subject: [PATCH V7 2/2] serial: exar: Add RS-485 support for Sealevel XR17V35X
 based cards
Message-ID: <d44f91c4-4599-1911-5cfb-bfc3cde95a9b@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN0PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:408:143::17) To BY3PR05MB8419.namprd05.prod.outlook.com
 (2603:10b6:a03:3c6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR05MB8419:EE_|SJ0PR05MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f49750c-03b2-4e51-0591-08dbba0c38b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfHPmA2D19jbl4bqM1OvIvJ7ELd2KuptWm7Cj3f77QjyT2fKtR8tY1dUzjPyfxnqlixiRTbIG3aDJpiI+mWgOy67RZdXUczNjaOcX0y/Uam5u7jUtrODxMghlHyeieSOJ8VF4bAVFeeCgK3sPXy7IVH3UoNAoGxc61N8WHRAHw6du5oOtoez+/B4k1gPFX6t7/Je8f3IrXEAcvtijl4VXVEfVjLMRnk74GiBmHZATC8z25lgYjxhHo+wtmUQP9YDZSc6lggsJFrwRX6Jocrqp8xtYo4y2kFM7ilDp2SKZ+wvtqzXjoxOTUKNRFHpI98bsHWXc4QBG01Axl0NNOqNbgfItz6LgLVoVLam8XuEqxgfda3WefgCIY1N44QPoOhIbsmFoHePKRiDAEXxGQx8yulc3qXPqXWRc/C3aX38Bo6rthE/lDARNpp6Z2nOiDyOorQcOnIHlrSrinBevhiQjye+9me+7AATTdUvaHfjC5JBQmjQ70tuf7kJE9sjp0JCg2YOnfswWdk61ITKIw+UkmU5CxxBeLujrgHn8UTCbb1sV3ny41ZTllszyju9c483K+acQPg5JGvM7B8ZgE5/0vnPBpKKSe3LZiYxAo4Pg/N8ZX6UdBSdTj10mdouDlmM59TZPGBBvaelS3QoTvPffoNSwOsNc5733ffgjPrH0vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8419.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39850400004)(396003)(136003)(186009)(1800799009)(451199024)(37006003)(66946007)(66556008)(316002)(6666004)(478600001)(66476007)(38100700002)(2906002)(86362001)(36756003)(6200100001)(31696002)(41300700001)(8936002)(5660300002)(44832011)(6862004)(8676002)(2616005)(31686004)(4326008)(26005)(83380400001)(6486002)(6512007)(6506007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NrlLLAXEeW3vTZl550AfV139DRz1WGnGegLHfAJ6APRmvliGkZ/t6S3vLzPE?=
 =?us-ascii?Q?+ufwyodA6IeLmpLWXSaNQGpYGdPrwTRvJb3MGc1R44qLbovQSLbYjrSUYkZR?=
 =?us-ascii?Q?+K9yy8AKWtRLtiTXCEnZo/bJZF2ZwuG+YAsgkSvvQ8GIMj6v7sLXfOdazY8F?=
 =?us-ascii?Q?g1AORwHSz+EYLSGbPoIHHBuQ5prPDljc7O4fsyEJn9lmULqscYRltpGZjGJT?=
 =?us-ascii?Q?o0+mVkqDfGKIKVrnYzQn0ARNB4kD0mot0HrXB1qbWT3HFoS7XJpkPQYh/B4L?=
 =?us-ascii?Q?e+CMOroo+UY6xMMeEIPD8OUBRYUEp++74QJ+MjP6AvrM89g8XXGYvfbOf4H1?=
 =?us-ascii?Q?VsKDEPopw8e8Ubne7qld4Dw4kKTlTtb4HsruDgFsJ2qxKGWtBttosUbHmw7p?=
 =?us-ascii?Q?WnSkNArF0LiLgu1UfEXy71xvO8G8eWcVBfHYGZq0laGhIb7KuSVsog4GAjV5?=
 =?us-ascii?Q?gy1w3NExBVw5lsSsqOXqcYGDwipGIZR6N5k7Shucnz5lnWv7FXF1c6I2bcEg?=
 =?us-ascii?Q?ELKeV1LukKnSlupWS0cdaISzFjeJHBZ6Ax8lGkbNMKm+pBwBqeQbTD95OUFH?=
 =?us-ascii?Q?FVkwGvi5e8+tFh7oFum4Y1mY51Y8sUQXC1yZPqMMhpMbVQXbKsQUImqeoO0x?=
 =?us-ascii?Q?WyvGdagsLa+SB8h3hqHhdPsElRPanIreqmV6ElUS8/0pOaPkQN2L6XwzAVdL?=
 =?us-ascii?Q?PlK9vuB4NfDnLdZ+4YyPy2gwsQpMhq/sNAn+Paw7QXCt7D1vdH4HKR7t/GcP?=
 =?us-ascii?Q?1gpD3Xox5byeK+3x4Q15OBzMA+r/2J3PU9hhTcGW5mepQHqd8aZh0++75FIK?=
 =?us-ascii?Q?EywpD3DVzRJ6wd6+e1BNUtSZgnXXTqzlS5kV+Yzaa4a9Pduke5DAQTOoyOLm?=
 =?us-ascii?Q?zsHK5cwc0U49QSTrsExYZ5FP4Oou6qcvqs6bm6GshEI0QC0Muvd5CG+SKSdI?=
 =?us-ascii?Q?CJ1MKnmdC9xHRrr6sbXhdHLkOfOS951Fyykz4gHv/9/AmT1kAaHhieCFuwBb?=
 =?us-ascii?Q?bWFIVbtMC7cvTeQRjqr7gk6+jeXEpiLtn2YFMD1hjSJBU/w+oZrAKAUBrmM0?=
 =?us-ascii?Q?7wNEh33jO/FRqDkeG7Nea92VlOnW7jPKGvalDJuy+0cFRHGK6V8fvBh/2DGn?=
 =?us-ascii?Q?SLG5m2EM0i1yoGLhy/oDL1uf9RLnWEl0HNtrvKmGBoEwveyo0hW51j99P7AM?=
 =?us-ascii?Q?Cke6otAcwIbQGe21DRp9f/DxmHydK0xy+XnhmnDXw3eLMRvpE5+BdkscpF4i?=
 =?us-ascii?Q?ERjK83kChyArjoInUqVL3WqNOgVICLK1a9QUiFSeXCJkWubTPxfbHqUBa5eB?=
 =?us-ascii?Q?1ocQUHk4Qkc4syjZa8eFdm+lRi4VtUHcG3YxeO4HizilnXTAMn1QNlG+gBRa?=
 =?us-ascii?Q?If/h8iCDUKkLzxcdYMqkCTuD5iZZCPTZ0ImnlK6JOkOjH3H0v6oIPaEJiy2B?=
 =?us-ascii?Q?+6TzJfDzVzzPnIxgQR1oMkf1xvT8UjkV+UEcQv+KVZVZDZkyhh6o08+zq5Aq?=
 =?us-ascii?Q?h0H51Nm+zDGamiZM6NjC5fohPT2Xah8VqwikTOjs9kGF6WPisdV/tVKVEiC+?=
 =?us-ascii?Q?ga0Xt0Hl0hB7IIWSHFwRAdc8y7738PF3RIJC10fO/+64RpnzkA6oeclMhyzD?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f49750c-03b2-4e51-0591-08dbba0c38b1
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8419.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 19:03:05.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plQwkTBJuiJESe3zMA+HQBVmFJ+ZpkmRIGX4S1A6uP/NX7kERT68+kB2EVCux/puvKuZj7b1sCXLY5ZQXCfEewisokszEeoU/tLtM7NRafw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7231
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


From: Matthew Howell <matthew.howell@sealevel.com>

Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but
the current implementation of 8250_exar uses RTS for the auto-RS485-Enable
mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on
Sealevel cards.

Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---
V6->V7
Added return check in sealevel_rs485_config()
Fixed misaligned tabbing for UART_EXAR_DLD
Hopefully Alpine threads correctly this time

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 3886f78ecbbf..03e4162ee131 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -78,6 +78,9 @@

 #define UART_EXAR_RS485_DLY(x)	((x) << 4)

+#define UART_EXAR_DLD			0x02 /* Divisor Fractional */
+#define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polarity */
+
 /*
  * IOT2040 MPIO wiring semantics:
  *
@@ -439,6 +442,45 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
 	return 0;
 }

+static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
+				struct serial_rs485 *rs485)
+{
+	u8 __iomem *p = port->membase;
+	u8 old_lcr;
+	u8 efr;
+	u8 dld;
+	int ret;
+
+	ret = generic_rs485_config(port, termios, rs485);
+
+	if (ret)
+		return ret;
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
@@ -744,6 +786,20 @@ static int __maybe_unused exar_resume(struct device *dev)
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
@@ -809,6 +865,17 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
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
@@ -838,6 +905,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
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
@@ -860,6 +936,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
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



