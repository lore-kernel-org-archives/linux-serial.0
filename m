Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216B4C83F26
	for <linux-serial@archiver.kernel.org>; Wed, 30 Aug 2023 18:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjH3Sif (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245313AbjH3PIi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Aug 2023 11:08:38 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazhn15012016.outbound.protection.outlook.com [52.102.133.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C60E8
        for <linux-serial@vger.kernel.org>; Wed, 30 Aug 2023 08:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGvbk2b4ujIfrAiWm5SWTJ6F29gC3H0sWgr3IGgwORoSGfGg3KLV29sBtkkrA0t7WKAoqbeGs8vfCy95qRl9UMTRulFHlwf21s0HeRClP00urSHdS6yUHcZQhO/okdZkqRsHl3kPabvh1MeBIR2ym2oaEifhiSvoSZLddMl9//CWazTeHHUzE7aavSV3LKcRD64RnXC2eirwAW1DJACOmLUxWQVlPqD8VSq1pFHurWvEfDqALZBdZ3hmMmkr1kx0gGfZIx/hDK3F0lA49OtJSNorXY4m5eNFQa1xCeLmY4/rn4aV237RaZt/hyD/aM/FXbDCJXJ6shiXBl13TiKfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEtkzRpj2y6mfzf1UqF92+KHLCnmECGv8pA/H4BJ7yY=;
 b=CjeE5yP6oayB64zvHcR64Kbu0aZU7j4QzOUGmyIwxYdrM2D6LaeIVYlPzBdhbRHva2qAYbllHQSyFq5uRQXEle2DXb6LGqDtRn9pdhcOZaq8zPoifhEWyJxj0Huq1f2SUQH/ZhTzWC3FJrGf+l5qX4l7NR3pDhascmI60XKF83uxO8t3d1w0TtrF8wavRndTLF2FsT1Lw5IOUdCRL50gSd6D1SLTvZ1nRKj2jincm/45q2lWaNPHkOvpCBOrca80OZX/HLWpj6yF7eT2SrkoH9k3+vtXmgqXqfwzPepqPeV0sbkdoUqHv/fe7U1k4iJPDDcY4gc+eaNOyAchDTrD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEtkzRpj2y6mfzf1UqF92+KHLCnmECGv8pA/H4BJ7yY=;
 b=i/bcL9GhuhsUPALUSWj2VCVt2BGbii1YgXujVbBkSFlX+2bPCMWduZFm+Apz48Fc6t/pEDNvhioCg+NaIrEU6+6cWRKAneYKWMfvAG0hLiyABRZkCt1wNqMdI55CA0+zUblnDyn27HOjSfe2qdSCOlfX9VRGyNMiCnav1pgM1hoBze6bHRCUop388ZvoforIqLtLqARNYkmzwp0DYNBMlXDu/7mVhpzV22eEh12dekHw6us+ZbQM0lwLH862IHV7SiSFD3tAERbjPLEYZ4fFaLZt0tP4rkUIYPGM2HiBbRFtU8uqam7d/RarZih2ICZlOs0vnMCxQmAWDCqEmvBXeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by BY3PR05MB7986.namprd05.prod.outlook.com (2603:10b6:a03:367::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:08:31 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 15:08:31 +0000
Date:   Wed, 30 Aug 2023 11:08:28 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 2/2] serial: exar: Add RS-485 support for Sealevel XR17V35X
 based cards
In-Reply-To: <b2a721-227-14ef-75eb-36244ba2942@sealevel.com>
Message-ID: <9fcbbcb5-5e54-d3b7-3d28-7b50215a580@sealevel.com>
References: <b2a721-227-14ef-75eb-36244ba2942@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN0PR04CA0124.namprd04.prod.outlook.com
 (2603:10b6:408:ed::9) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|BY3PR05MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8d1c14-6969-4539-e34c-08dba96af915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?txFSKOzaqEZ5/W0vC9OmtB/iVgCYQxfqNikxBQJ3OxiDoTYKfIggISO0AO8N?=
 =?us-ascii?Q?LLTAc6wXMaA3tQ9vfI8c1v2vwH7mrn0u6EpLWd5t1zKcBgOpG43t3SuRKexX?=
 =?us-ascii?Q?wVG0Il2CmHbrHIrcJ7/7Yoi9W4e2F19RF5XYe/kq0ZlR82Bdh6zoZuA4UpkA?=
 =?us-ascii?Q?lELrkh2J/NSHpy2Dufprva1Vx0++13kaCqcVpDpva6MzXo61JwoYHKGIovm0?=
 =?us-ascii?Q?q5rLdtPgIWyvCusC3Etl1r4SZZVBA8A1EkQKbOO7BseP0o8RySyINsE8t4OK?=
 =?us-ascii?Q?n++/j3l1aK+xjE65piOcwHlXkO8mAeX+buEPmTb9NoZs9K6z0A5wThWCItSu?=
 =?us-ascii?Q?Q2HQoFhqZ9/9aTBP07bXDFDoLFLiWXz40h4wiN+qsqNxw/yTfhtDDQJf7TbD?=
 =?us-ascii?Q?vT0SGpwJ8UBdlFJodPr+L/8sMNM6dVAdX9YcoNUQcY72roXqmuRZGs4zOd9T?=
 =?us-ascii?Q?MZRUhNZtxR6xJvqc8cyW1mfmlxyYCS0DUmt1lKw8WBTqtnWzquLOei2hNSiP?=
 =?us-ascii?Q?+bR8pvbkNbhd49WzCaqxkyfG6K3c5oSObaLppaA1U/IEs20+6UR/Ou/8O5Vh?=
 =?us-ascii?Q?2ISFHOhDNB3xFIpvRGJ4b28k7wVIl0Dqr9bMGDG/ls5giEyJTrlbGrMSNhY5?=
 =?us-ascii?Q?PRxdKER8TfktkjEIOCY2h2VznfHvxa+RmKfe1G3FTbp7+CDOJHPKSe/9PCS9?=
 =?us-ascii?Q?5k40zQDyJZ9PxFUkeFmpvMkj0CSyZaG2bCu7wfqqm+psrN9Il1NpzYiDCd+d?=
 =?us-ascii?Q?SVrfb6lRnMmMDik3FZ++EQa2dSaWl4m+aJe0kjaGGzR8hy8XP9sTxwDgzySd?=
 =?us-ascii?Q?HfNTNt82HS1DVea1j+hhUQTn5LApfRhcrp5z99hVYLcHYeCdxUHInxr+lL/8?=
 =?us-ascii?Q?9oZWG0hhexmCgHK9Z3nMV32wAIuho3Jz43U4MYZ3HACSvC02WST5ehQ5W7V8?=
 =?us-ascii?Q?dO+T3UKTkMlxBAQOMXOhVkO7vEToiQnRpxH0lEqsTsEXsMj7KLJ7bOLWXZkP?=
 =?us-ascii?Q?Pdf1nQOOYIJazjLtCLkyuySun3TopFhf2uN17ZfxdwnhHVBu3ZRxKfSDoOZD?=
 =?us-ascii?Q?Qkq+IDpMDO0IcKBkz4giqi8AHN8xHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39850400004)(186009)(451199024)(1800799009)(66556008)(66476007)(37006003)(316002)(66946007)(478600001)(38100700002)(2906002)(86362001)(6200100001)(8936002)(6862004)(41300700001)(4326008)(5660300002)(44832011)(2616005)(83380400001)(8676002)(6512007)(6486002)(6666004)(26005)(6506007)(36756003)(58440200007)(45980500001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E6+lEtugx0E74/P3KSTPOiXiOKvPSllU9mMTmZCwkmewnaoGfNdLXj5AXqIO?=
 =?us-ascii?Q?yQhge8cobfS9lyWWfv2zcOUrxxu8mXKS55jcOFEKhXwW+pFTNT6SbKq7l7J4?=
 =?us-ascii?Q?E/YGaUcQuXlO+TwdT7w1oIFbWJzZRXu0pLiM9uMlgdFDTTxHkEptXo8/Z/n/?=
 =?us-ascii?Q?mQeB7EGfQr/D7huzX9ExBPeH0xr4FyXb46coYVtmrwXMxAoeohXozk3jiL+F?=
 =?us-ascii?Q?i/dUo9jNiZtatQRmLQdZTxwy6nvm3OuE/pruhuFbXHd/WaOjTlHPwzlKZ7gY?=
 =?us-ascii?Q?dz9yIzzQyYo8wRicjPsoJN1tUxBlzRJrvibs6NhIGTXaPu+REH8TO3CCorRj?=
 =?us-ascii?Q?wsrJcOUIg/NGCMkcaEX98i8rejHqSlf6+4FGY6s5r5QNYxEfo4y+CqagcqBQ?=
 =?us-ascii?Q?T7c+mVbMtR9yOXlO8+CMqDZ1RF0tDcZ5vzMG/vfUW4qVxc5kZUKJtLIRzCaa?=
 =?us-ascii?Q?pu34QnJnHozyJRX6ihdyJ2MeijxqGW+YV2OYiVaKTNZqhL8EbLftkdfYK3N3?=
 =?us-ascii?Q?CfTATMAcWUxQNf8aqviaItaEUeuuU0A6DWd6babOVbmHsQmnTTMRAAWq3vs3?=
 =?us-ascii?Q?IO6q9xainHTJmqC/9atA6icoTpqzmYxiEPIscQt96uCff6cf66yxsjTtNb4l?=
 =?us-ascii?Q?nj59A+tNpmTjlGgFoINxDKwuSEj3IAMhZYbyp5CDAnDImx4RovAltmMcJfNH?=
 =?us-ascii?Q?fy4njGrBcUiQO/wU3t7PrVKBCZ4gqb2xxCdgd5VEmWXI5+8XAOu6zjFe5PH5?=
 =?us-ascii?Q?ILDaZALaoHHdptzT374BDq+BQ01kz69KP2JLQ/zaw3z+o2dzl6Noug4CqYPw?=
 =?us-ascii?Q?JqoAAAhyAZAZqVzy7JRfmUbCIEFTc5/V1P7yj+nt5hFcL7d1h1Fjh+tZzP+3?=
 =?us-ascii?Q?MSWLvLmnK7WjzLheLH2LiH/7eqmqhEvHT5Nnw8gu3vLGDzMjhCWCKvQ4rm6s?=
 =?us-ascii?Q?9AVWenYmLXtVs1hT0Vb4bXJb+WI1LgQOWR1REvydko+LQhIO2kABqhtFblO2?=
 =?us-ascii?Q?8cYLlW1ixGR30Fe3O/LW1QwVSdCYNxsmWfSYjIeZs651c+IDBAgS40pzxi6F?=
 =?us-ascii?Q?x/uiuatA+Zb8oO0ZnYUK1Ic5zZMPq/orRQUpLxPYp+Vwq8d1J3Er1zfQj/ud?=
 =?us-ascii?Q?ELKRVHcLkreU3nNFP3iGqHjKoUI5OZo5OFt+nBGEF4gzwngVdnYszvoUBwgj?=
 =?us-ascii?Q?xEj/cU9SG7UZTcQmOb8ReZz5n3d3NZ0zVVPKSRmQvjlqnYOARUDYONZE47UB?=
 =?us-ascii?Q?QyjMkooTx0ghmOzFYNHmN2HH1UxLvpVabCTtOGHVZRssMefoguWBofMKNUN4?=
 =?us-ascii?Q?0IeAF2TxSg05BdqwLSXvCEcb3+rE3ndV021ABEyssZJxcD70WWDVTzg1+gzL?=
 =?us-ascii?Q?p9vjDX38aJEoyH2YGxtGaS3CaBbHMeZlPW7GPyY7iCj+cvmBMxD5EyVkDVps?=
 =?us-ascii?Q?K7KSw5+kv97s8U7m7ScgLEBZ28sSb0KN27IxbI13W4IBEkbBnDmUI+QNcyxz?=
 =?us-ascii?Q?CmHG6BWQ5QkLu8ArJulNsSl5LselxK4OcQUrOqPCJ1gzHM/g7Nbe2uzT8Xkn?=
 =?us-ascii?Q?r0ubsZPyrBd2GWpYVVg0j1T7xGLHOjsNJwxXfDcFnddxFtEg0QDbO8wuYAJX?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8d1c14-6969-4539-e34c-08dba96af915
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:08:31.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XM+qZF388qNEtxyK0S2ZhTJGL0CpaJH1lQkm5I73TbNUjZzZm/JVVOf9poS0G4Zvfs+oQkgoaNC5ZNOYEfXfgu96zQQ4zRjkEi7XKWvYpeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB7986
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the 
current implementation of 8250_exar uses RTS for the auto-RS485-Enable 
mode of the XR17V35X UARTs. This patch applies a new sealevel_rs485_config 
function to configure the XR17V35X of Sealevel cards for DTR control of 
RS485 Enable.

Based on feedback from the first submission I replaced the hex values with 
defines and fixed up various format issues. I couldn't find an existing 
define for the DLD register or its RS485 Polarity bit so I created a new 
define. I tried to follow the format of the other defines in serial_reg.h.

Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 3886f78ecbbf..2fd2bbf9364f 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -439,6 +439,35 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
 	return 0;
 }
 
+static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
+				struct serial_rs485 *rs485)
+{
+	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
+	u8 __iomem *p = port->membase;
+	u8 old_lcr;
+
+	generic_rs485_config(port, termios, rs485);
+
+	if (is_rs485) {
+		// Set EFR[4]=1 to enable enhanced feature registers
+		writeb(readb(p + UART_XR_EFR) | UART_EFR_ECB, p + UART_XR_EFR);
+
+		// Set MCR to use DTR as Auto-RS485 Enable signal
+		writeb(UART_MCR_OUT1, p + UART_MCR);
+
+		// Store original LCR and set LCR[7]=1 to enable access to DLD register
+		old_lcr = readb(p + UART_LCR);
+		writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
+
+		// Set DLD[7]=1 for inverted RS485 Enable logic
+		writeb(readb(p + UART_DLD) | UART_DLD_485_POLARITY, p + UART_DLD);
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
@@ -744,6 +773,19 @@ static int __maybe_unused exar_resume(struct device *dev)
 	return 0;
 }
 
+static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
+							  struct uart_8250_port *port, int idx)
+{
+	int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
+
+	if (ret)
+		return ret;
+
+	port->port.rs485_config = sealevel_rs485_config;
+
+	return ret;
+}
+
 static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
 
 static const struct exar8250_board pbn_fastcom335_2 = {
@@ -809,6 +851,17 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	.exit		= pci_xr17v35x_exit,
 };
 
+static const struct exar8250_board pbn_sealevel = {
+	.setup		= pci_sealevel_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_sealevel_16 = {
+	.num_ports  = 16,
+    .setup		= pci_sealevel_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
 #define CONNECT_DEVICE(devid, sdevid, bd) {				\
 	PCI_DEVICE_SUB(							\
 		PCI_VENDOR_ID_EXAR,					\
@@ -838,6 +891,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
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
@@ -860,6 +922,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
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
@@ -885,6 +953,7 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
+
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 08b3527e1b93..188c5032f218 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -164,6 +164,8 @@
  */
 #define UART_DLL	0	/* Out: Divisor Latch Low */
 #define UART_DLM	1	/* Out: Divisor Latch High */
+#define UART_DLD	2	/* Divisor Fractional */
+#define UART_DLD_485_POLARITY 0x80 /* RS-485 Enable Signal Polarity */
 #define UART_DIV_MAX	0xFFFF	/* Max divisor value */
 
 /*
