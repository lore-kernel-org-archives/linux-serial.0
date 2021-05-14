Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568ECC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321AB61453
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 16:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhENQ21 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 May 2021 12:28:27 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:53102 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230009AbhENQ21 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 May 2021 12:28:27 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EGRBFO001307;
        Fri, 14 May 2021 16:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=yXBNYAIpIYASkOA9YTRnQGvVXe64ZG47sgYOhjZOxOQ=;
 b=ACe3mqiY3onhofVQLrqYl5iACGURkgumBJZz29OBt0CovIGu5bCpxg4D/Ti0aV4LCzkN
 KFr3DBM6uFPcd4cyACgcn5T52FtmN/vQe34ZqRyHsELasTzYLFTErs1KAWynmR8Q1iV9
 dmbhGfSoEWx7TTGUDvDwAotWLIig8PVFCYslwqCSRnWdnEXjfwefKTBJmyBLFoieq6yu
 BwgaWvPi9n+sCp6XK0VRwpS76kXc4ZUTNGENUZOG2KTm5zuhCYQascPveRmCWFwIbFAb
 02XLFPhUcDBAG5qYAOl2Bhpl8AHF8FLyKCx2cANi+lx7aQYFx65/N0YDH1Tb246dqSHM QA== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 38hnmh3eau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 16:27:10 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 6A89359;
        Fri, 14 May 2021 16:27:09 +0000 (UTC)
Received: from jahtest01.ftc.rdlabs.hpecorp.net (jahtest01.ftc.rdlabs.hpecorp.net [16.78.32.72])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 8572A47;
        Fri, 14 May 2021 16:27:08 +0000 (UTC)
From:   Randy Wright <rwright@hpe.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gustavoars@kernel.org, geert+renesas@glider.be, u74147@gmail.com,
        tobiasdiedrich@gmail.com, jirislaby@kernel.org,
        gregkh@linuxfoundation.org, jerry.hoemann@hpe.com,
        toshi.kani@hpe.com, rwright@hpe.com
Subject: [PATCH] Add support for new HPE serial device
Date:   Fri, 14 May 2021 10:26:54 -0600
Message-Id: <1621009614-28836-1-git-send-email-rwright@hpe.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: 0GTiLpo3WSnmfoVomxMaoBf2-7nT8bl3
X-Proofpoint-ORIG-GUID: 0GTiLpo3WSnmfoVomxMaoBf2-7nT8bl3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_07:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140130
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add support for new HPE serial device.  It is MSI enabled,
but otherwise similar to legacy HP server serial devices.

Signed-off-by: Randy Wright <rwright@hpe.com>
---
 drivers/tty/serial/8250/8250_pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 689d822..04fe424 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -56,6 +56,8 @@ struct serial_private {
 	int			line[];
 };
 
+#define PCI_DEVICE_ID_HPE_PCI_SERIAL	0x37e
+
 static const struct pci_device_id pci_use_msi[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
 			 0xA000, 0x1000) },
@@ -63,6 +65,8 @@ struct serial_private {
 			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
 			 0xA000, 0x1000) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
+			 PCI_ANY_ID, PCI_ANY_ID) },
 	{ }
 };
 
@@ -1998,6 +2002,16 @@ static void pci_wch_ch38x_exit(struct pci_dev *dev)
 		.setup		= pci_hp_diva_setup,
 	},
 	/*
+	 * HPE PCI serial device
+	 */
+	{
+		.vendor         = PCI_VENDOR_ID_HP_3PAR,
+		.device         = PCI_DEVICE_ID_HPE_PCI_SERIAL,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.setup		= pci_hp_diva_setup,
+	},
+	/*
 	 * Intel
 	 */
 	{
@@ -4973,6 +4987,10 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
 	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_AUX,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_1_115200 },
+	/* HPE PCI serial device */
+	{	PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_1_115200 },
 
 	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-- 
1.8.3.1

