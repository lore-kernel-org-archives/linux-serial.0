Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B563EE4993
	for <linux-serial@archiver.kernel.org>; Mon, 21 Aug 2023 16:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjHUQHQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Aug 2023 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjHUQHP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Aug 2023 12:07:15 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011005.outbound.protection.outlook.com [40.93.199.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65364F3
        for <linux-serial@vger.kernel.org>; Mon, 21 Aug 2023 09:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+GNCSBo4FhFXshfAllZ2YhrMDC+WD+HmovshZyuOtuzjxH6OWEp0eLq1vrgynRhdQuTB1f525R0WxDTUi8G1mKpm+678JTYBqOLieSGZrbl2QNy2V40f0h91D7kJA2zC4gYBljPtERGi7PS3KZO6Fta9QQ/XGJeoahRTOa+KoW1E2GrYHiDRLWxbID5crASchJa4Yefct54I2IXDn+67cvHPviTTstkeoXEEccqECUbYdK0piDOzLZ6d7ceOzbhc4rVdfhoHrYTj35I56PbN4x14C7nrD1YCcqv606h+3HHIALiIYrnC9OkY9C12VkY2HTciut1xUPYOUWSPY3gxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puQ1TaV6bBRfmlWdLkre8ahiy1OigQHRrgy2XNUYkMM=;
 b=Cbqqq6AmtDVSVpkC6WPeM4Fu3WmbzHFHeVnqxS4M2veid57o60F6wDDNaF7CD6euPmjhtGSnCX3+OKjJTWS1jFkXejq1YAwQoV5ifMf14YYcqCHuoTPfi/662gHZ7ZrprJX7lLocHAdTYJjzrdBALCqkBgN/RZ6zcqv4b3BUXl+yXtxeA+uZV9Xx1NOi8WH9JcqERuVyk3q9G+w7nE+B8rHGVV7ggSN78p9ZDThaMeZobisdHkeD4A8Lu657GdbB91mSQwbFHZOFnYUj9p8l3FLJ386yw44Bwd7FuQUoZbTcC+SWOFaEWtmQuzmNXMjBqyuwnVMm3qN7Bif/4YrMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puQ1TaV6bBRfmlWdLkre8ahiy1OigQHRrgy2XNUYkMM=;
 b=NHoLrcRMr9rNpK7arMHnzHkG6GVkRyQ1G1SCZG/ZVnqbDcIqtN/tIJlHQbkDb0A82RgmX9rV4VNVvBJNW1yxNPK59Kd80oIji7y0Yqrk7MyRHzsXceUivwZeD3+KSNpWi3kihmNuuEYZQ8ID6GoCLe7ak9fLHYqd8tw9cBxOcKOYGoRKvk7mmCVU0V8uD51pdAc1qIN0AVwSCDSdikR2tkYgKcwSGZO5/ELwsGuGrmP+oEy2iSzcmkzZ7URwm+ya2vKF4LeyIzhO4MphnyJVi0W+6+iksWXGG1QmLpTi7e8JohhEfPUUIpywSHOyLuCfixsKFI+xZh6v7xeZXHxIPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by PH7PR05MB9777.namprd05.prod.outlook.com (2603:10b6:510:279::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:07:11 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:07:11 +0000
Date:   Mon, 21 Aug 2023 12:07:09 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     gregkh@linuxfoundation.org
cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com
Subject: [PATCH 2/2] serial: exar: Add RS-485 Support for Sealevel XR17V35X
 based cards
Message-ID: <766dab31-6982-67d9-ead9-30f61648d7a2@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0586.namprd03.prod.outlook.com
 (2603:10b6:408:10d::21) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|PH7PR05MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: b5527f3a-e24b-4e21-23a2-08dba260ad74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSCAKqeR3pa3YWqHgGCZnq6ybsFrBtFHCItbH1knrV7bH9TLBt6SUd6BxRsCWV9s8xKaoRh2H0rux1dV7FrwUm0+0uQ09bB++E5coCkknqLXjmGpUZjksNukRQgqK4jKCKJKTU2khtw2w1pvP30qiN1tOeBzOKpcDDUfUijXczXk3izowP8x+7UdXwQpTYjuObflZb5nhoLC/l/M/vAETRiTx0k2/gLe4PMCBQh1RbuzYuprCs7GBk33y7+bjZ8jXO8OHfVbBA2Kat7QIcfqW3bn85hWSOqOr2VmNFnvqaEiaGRvmscktx91BScrS0Y9sf2OCxGR8VDO0uBMWKMSoouOShzpC4UIAmvvGWNK5VhpZPURrQL/F2EVP9ZyjoNHAEiMmPjH59SKu//kR3durpKmKwFfoGyQ/x5l+XVmDd/0yHmmFSRGpYcQe7WR4Y3m05qcKzozSZ2CyOKg8KDQqOYYVw/r+5PwWOV6A7xSa6Za3dOTwcxO09otSp10/5bb0trwUnP2UJ+h7AO2NaEmUO6iuX/mPvbQkI/PmDpmPerIJk2lm7cvNOnYXd4vP1Z12/TfYfsn8/PVXzw1u8nFhQwf+tpAgYRpmCN0/fnKuvSUBjpi5hrK8ekbbqdpeKV2WQJsft7d3m7lut9+7SwgHCsEmwK96n7Zb7/78xqCOgikT7vbNu6M+D2YbXU47L1d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39850400004)(186009)(1800799009)(451199024)(2906002)(38100700002)(83380400001)(6486002)(6506007)(316002)(66946007)(6916009)(66556008)(66476007)(41300700001)(6512007)(36756003)(478600001)(12101799020)(86362001)(31696002)(31686004)(26005)(5660300002)(107886003)(2616005)(8676002)(44832011)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cYrkUe23Zu4wzIZk1dxjewxPzvkE0bSK+agPqKddwPwgzcSljwTDe7X5JQjK?=
 =?us-ascii?Q?WSyCiaxG5cf9MpllryKg5NdcltwY6eyXRvxl3CmFG2NZpbQD8eX/q/QtnUUR?=
 =?us-ascii?Q?pKxTn0xIV9dohLdzRa19Ti6siyHspuCq9t90OpoCzx8dMluSPsUD6Bdd8H9Q?=
 =?us-ascii?Q?NuFqd4y/xj91AnVZTRQ/jyz45XddQCLvNVmEiyUFC6nlU8GkaOWikTBswxLT?=
 =?us-ascii?Q?nYRK+RT82T45B5V7Tx0As5ulcSnMXXf6+kbVuO8J5Vz9O3xVauV3BcgCR99+?=
 =?us-ascii?Q?G9CUkjfNTC799TlGrytIPCeg1EV7K1arvZew4bYBNkQyFaOsaA05fW/cFUcu?=
 =?us-ascii?Q?LIYdCPQ4tWIKHSuK096L5t8owSRd1u4ttZu1osG5rSIj00I9/cQIgP7nCOwr?=
 =?us-ascii?Q?95wx9muI0H1zC5pSfNn0ghCHGHtLDGaii8kApNXclHt9kkw2JAG2Q1TRR3Pr?=
 =?us-ascii?Q?jf4vd7UDFE0lIdDJoh+zCkkb16XtB/xzY1OKJ9vIVyKE7sIXclK/i1/t9zZe?=
 =?us-ascii?Q?VFR2mFhfaRxIdl2ho/NGJ/EPZrYDf4Ho3k0zWPc3psIbe+sZa9X9G7EOHu5T?=
 =?us-ascii?Q?JAGh1eFcRPTOoJgEyQz8QzkYr7y1wzvTtN71Rtr1e1SNFkBtpPv+exaCiKDS?=
 =?us-ascii?Q?Z9XiDTOOx586Z0KUg+isazGQo9YG9IAe9qS8x3VPLLqHJguMPNuLX16litqz?=
 =?us-ascii?Q?4Y6Xa5GMe6kxhp77Ato3VIFVYskoHpwy/13GINfj8IpToWzD/jD8NWSNRnF5?=
 =?us-ascii?Q?9ILrVobCK7QDq5Eh7FlQY6VHFAZfOZpS72/dEjUKlnCyWvSJjRjb+5ltt07P?=
 =?us-ascii?Q?lwdOf4QUm5dHdKlefuHnoxJQHDxBaxCwq5H26Jte46U+fspg1s1QQmBxDOfA?=
 =?us-ascii?Q?h2vgalmkKUH43ArfbCI3W3VVscw15ADDqZYlMV4GgEVCc9/Hc27vbjqymUAY?=
 =?us-ascii?Q?p5lohHBsa5kuWgPCT/+vs2RIkacqcQmE0ZNWmAl0Oo2J0t8NlyIOR5tVwZEW?=
 =?us-ascii?Q?6xQzCxz+eBT63QdIWtvnQE5idkSi2eCYkdu/Hb5qkStoAEMPKICGp+19IwVx?=
 =?us-ascii?Q?CEhvUgzgAb9lbefZmVjGfmzb7+Lf1XiDk1dUenYoIUVZYb4gR3RgR19dhUWA?=
 =?us-ascii?Q?dDjxNiaKiVd1fK7vK5y02SM61VRi0RWSD5+tM1FQwm+RKgqULjWqmcI3Jsii?=
 =?us-ascii?Q?QhvhxAXBBuwizRNhW70AK/u3pUT+EPIQRH7CBOs/+lZanTN8RdySW6mLT8Ei?=
 =?us-ascii?Q?0b1oH0PskIcIuC4zYj+UopvVfY+eKmq/9ZD33J1cIMRs4fXg/qyQN47Ul1Ei?=
 =?us-ascii?Q?J64jYPuof8kGSYxgIrpieCQ1wDn0PnW81qBioxszefPqymDS2kahYvxcuH5Q?=
 =?us-ascii?Q?2m4ahlzvzS/zTdundZ+Mk9PW1hgAFtNFI1NKY65nfU9DJmUtxcZrhrn/3iie?=
 =?us-ascii?Q?Kh301Uiu638aNsii1N7mmjcLauUwcytrAHY0go3YC69Ss16uoAXsr8DDKvZU?=
 =?us-ascii?Q?D5vTAMOMFTbcw8svwIfpUF+5JjWm9pOpLeHwrJi4+C1Mfn7ZD5S1ScO3fnsM?=
 =?us-ascii?Q?H+4FMQUNbDzuaN3DkGsP83dDk5BYZ1/qmUnsIbVFx/KF/zVhzsLVjQXk2SBC?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5527f3a-e24b-4e21-23a2-08dba260ad74
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:07:11.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zz8fd8f0kd307orI+xp4+96rkhIjzBSZUrW81gePKBpjvfg9PdfqWs99TdmGzaHE7sDNj6gKxlXIR5Vw9XXtTbJWlJJjx5NM/10xZo8wY9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9777
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the 
current implementation of 8250_exar uses RTS for the auto-RS485-Enable 
mode of the XR17V35X UARTs.

sealevel_rs485_config(): Configures XR17V35X registers for Auto-RS485 
Enable using DTR.
pci_sealevel_startup(): Calls pci_xr17v35x_setup(), then sets 
rs485_config to sealevel_rs485_config().

signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 018cbaaf238c..246cfb3cc3f8 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -390,6 +390,8 @@ static void __xr17v35x_unregister_gpio(struct platform_device *pdev)
 	platform_device_unregister(pdev);
 }
 
+
+
 static const struct property_entry exar_gpio_properties[] = {
 	PROPERTY_ENTRY_U32("exar,first-pin", 0),
 	PROPERTY_ENTRY_U32("ngpios", 16),
@@ -439,6 +441,35 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
 	return 0;
 }
 
+static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
+				struct serial_rs485 *rs485)
+{
+	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
+	u8 __iomem *p = port->membase;
+	u8 old_lcr;
+    generic_rs485_config(port, termios, rs485);
+
+	if (is_rs485) {
+		// Set EFR[4]=1 to enable enhanced feature registers
+		writeb(readb(p + UART_XR_EFR) | 0x10, p + 0x09);
+
+		// Set MCR to use DTR as Auto-RS485 Enable signal
+		writeb(0x04, p + UART_MCR);
+
+		// Store original LCR and set LCR[7]=1 to enable access to DLD register
+		old_lcr = readb(p + UART_LCR);
+		writeb(old_lcr | 0x80, p + UART_LCR);
+
+		// Set DLD[7]=1 for inverted RS485 Enable logic
+		writeb(readb(p + 0x02) | 0x80, p + 0x02);
+
+		// Reset LCR to orginal value
+		writeb(old_lcr, p + UART_LCR);
+    }
+
+	return 0;
+ }
+
 static const struct serial_rs485 generic_rs485_supported = {
 	.flags = SER_RS485_ENABLED,
 };
@@ -744,6 +775,19 @@ static int __maybe_unused exar_resume(struct device *dev)
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
@@ -809,6 +853,17 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
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
@@ -838,6 +893,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
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
@@ -886,6 +950,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
 
+	SEALEVEL_DEVICE(XR17V352, pbn_sealevel),
+	SEALEVEL_DEVICE(XR17V354, pbn_sealevel),
+	SEALEVEL_DEVICE(XR17V358, pbn_sealevel),
+	SEALEVEL_DEVICE(XR17V4358, pbn_sealevel_16),
+	SEALEVEL_DEVICE(XR17V8358, pbn_sealevel_16),
+
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
