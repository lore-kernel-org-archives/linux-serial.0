Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E53FC433E1
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 16:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636DE20774
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 16:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="K5vo2yjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMQxA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:53:00 -0400
Received: from mail-dm3nam07on2103.outbound.protection.outlook.com ([40.107.95.103]:54476
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbgHMQxA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 12:53:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx+S0UfOQ18nvXlredLcT/DtuIypRurEDDbdmXW4cIcpnTOcQR78G+lQL+hKeTVC8XWUXWzj3iLkElo0cAAHVU3pGzAlb9vKIo/PoK4GVX927+VtzDQYQC1YcZyizA9XR+HkZpXYv81smskmXh05gnt+RHqf7+opOd7Qzo1PerBwqP+L3HxeRcT+hb8jHInvd9PI+cskYXO8yGyq2MK5ydTLEJGyxnPfIg4NKN4sItDgO4Ke91SiJyzlMRd/+pmK1H9IVJ7cRuProxGGs8nxWGdvnt6a5BhNXIHyfXLyn4w+LpzPVamd0x92Kofm1I6bOGIFmcspYwYz61agdFih7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJXDuxcgoKpxKXhY/p1fhwxCoL2CM+2AZ5/7Lgu48Sg=;
 b=fiXWHpr5jEE3kXEJ34V+ixTqFJCsq2qP01LYx5MY9yYElKwd4qj2mfnfOkrxoCvhc4g2HT4qJnlASuknEqMN5T5nIDPs5WOBdQ+RJhHjQiJSUQ0c75wMUYINUNQXu2fb+TUC/ape1fXnK2YZvTEe48vOYcYCDBlE2HVuDHNlKpY3h6t8gr78vIWy9htgL7HnjRYbEWCq7oPAXT4rmK4DoFcXxu2WLDw+gcPkz/EPhXBiN59tDvUshcc9R+kkmZQCGldYDV5t63yU1ZRf5Oq0dPoivmFNt4CiZzXMes/3t9G49ZMBsOWBHc1b9F79YvQ25xfkz+t8Ko4rSmd6y8G5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJXDuxcgoKpxKXhY/p1fhwxCoL2CM+2AZ5/7Lgu48Sg=;
 b=K5vo2yjzm5WoAUN73xwdkegKhHmJ4ro+UodF4J7jSYHxylpTi7lGNWJ9JpqSx1S7meT/j9fgftYlO+MameQ+47mQJFvHn31zslpfoxG4RvK6hh/so5d1fauEf4PJrWMss0iTHjpR5l1WVeJLRqNESNFTR/i3cSdpfIamqu9j3CY=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from BN8PR11MB3604.namprd11.prod.outlook.com (2603:10b6:408:83::19)
 by BN6PR1101MB2148.namprd11.prod.outlook.com (2603:10b6:405:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 16:52:58 +0000
Received: from BN8PR11MB3604.namprd11.prod.outlook.com
 ([fe80::9caa:fe2f:bbe7:123f]) by BN8PR11MB3604.namprd11.prod.outlook.com
 ([fe80::9caa:fe2f:bbe7:123f%5]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 16:52:58 +0000
Date:   Thu, 13 Aug 2020 12:52:55 -0400
From:   Valmer Huhn <valmer.huhn@concurrent-rt.com>
To:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        sudip.mukherjee@codethink.co.uk, jan.kiszka@siemens.com
Cc:     linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_exar: Fix number of ports for Commtech PCIe
 cards
Message-ID: <20200813165255.GC345440@icarus.concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: BN6PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:404:79::18) To BN8PR11MB3604.namprd11.prod.outlook.com
 (2603:10b6:408:83::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from icarus.concurrent-rt.com (12.220.59.2) by BN6PR14CA0008.namprd14.prod.outlook.com (2603:10b6:404:79::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 16:52:56 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f9ef5fb-fe39-4b0c-8724-08d83fa95480
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2148:
X-Microsoft-Antispam-PRVS: <BN6PR1101MB2148F682194688C235ECD1B7A1430@BN6PR1101MB2148.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrf1nuIfl/biZyIn2SW7WiEzisDJJCtgv+cg35HG2IUenORIVtrDGqts7PX8jTQ8Mhh1kAVlgB8i+tUt0JC2rVEe3Rvdz3M/t+APPL3tV+ogRIcwTax/z0fUft2lZsjQ+BCG8Xu6MIvWBMZXbnbs/6m4bLu2+GwCwxz/+IAfRsU+lREOxl+eAp5GYmlNrWQDLMPP9eINKTeJt0CwAhvXWTBoO/f/MgkmNMq5O0TwACrurM3PlKlTKdHWA/YfDuIlDpZiixPrA1pi5vDaJ4CyKApSB8YhUlgjE8KA4SQw7BthOh+XvtENvZYVL0z3DsyMR27X+6H5WekLSL/+5cVrrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3604.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(376002)(366004)(136003)(346002)(956004)(44832011)(8676002)(8936002)(316002)(16526019)(33656002)(26005)(52116002)(7696005)(186003)(55016002)(5660300002)(4326008)(86362001)(66556008)(66946007)(66476007)(2906002)(1076003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Ec9ziBJLy1u/gmYiRUOh8cUK4JksUqywmSlyp9DQsKw5fzgRftSYB93aeHIUkT1PHQEhKH1vTBCMXHwgk14ryjkbDVt6H+zE4dcFGH+oBI5J9l5xFujLauIU5GEJ4A7dFK0GjlfHytjafZY+2DRf0zcxVWYDTkJLeqcTDxODzCOhCXUinvdCaxELfUXGijzUtLlYYh6alyMgZDkOBhYIR+p49ewfHTebOXkPxwfcJqRlWgsCDPz2rJk7jQNqqvgd9yCOIV9HF6n57wvYv4ew3p3KddZRR7ebyai3I8a6K4o/m0vdZ/4w1NatrixCaAhugQH8vuRdJQIWDd6Jk3s4VJFDRLa6pCeI185gB358r26evW0XZRDisGiSeaDN63fIKuPA3GP4au86bcbzD2Ct0ysOpmxDU4WyzvEQuDbK+2e0Nfe5dNwCUCtutcr5F1vl3fBDnjgOmjHDpodpg0QGQHsgd3jZeDQBYoUoUEsnQytPnjDE9HzHXPlbU5iQMSHjk0sjicSvTA99kwiQNd+/YuW6T+3HvoGubT/U/uUXoiz7uQiy+nT+gI4x5zTjkWm2xukb3uKe3d9pgcd8irwdWf/Q1haPFhX9Vbcy7LdyoWZikOa7vB0mJuLy4IVTivQaUq8VzTA/KrHK61suntnxmQ==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9ef5fb-fe39-4b0c-8724-08d83fa95480
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3604.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 16:52:58.0193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADkQgX9JnNLxvqcODcpfVOJT5swyDqYPajxV6cTlhfS5XPuTiYvdqV6qMI3qGNHvlBgXgZl7YC+DsoqCCFvRZlax0ZRWV6FbeWB6NvybFnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2148
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following in 8250_exar.c line 589 is used to determine the number
of ports for each Exar board:

nr_ports = board->num_ports ? board->num_ports : pcidev->device & 0x0f;

If the number of ports a card has is not explicitly specified, it defaults
to the rightmost 4 bits of the PCI device ID. This is prone to error since
not all PCI device IDs contain a number which corresponds to the number of
ports that card provides.

This particular case involves COMMTECH_4222PCIE, COMMTECH_4224PCIE and
COMMTECH_4228PCIE cards with device IDs 0x0022, 0x0020 and 0x0021.
Currently the multiport cards receive 2, 0 and 1 port instead of 2, 4 and
8 ports respectively.

To fix this, each Commtech Fastcom PCIe card is given a struct where the
number of ports is explicitly specified. This ensures 'board->num_ports'
is used instead of the default 'pcidev->device & 0x0f'.

Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")

Signed-off-by: Valmer Huhn <valmer.huhn@concurrent-rt.com>
Tested-by: Valmer Huhn <valmer.huhn@concurrent-rt.com>

---
Thank you,
Valmer Huhn

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index ddb6aeb76dc5..f3abc1aa0b01 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -734,6 +734,24 @@ static const struct exar8250_board pbn_exar_XR17V35x = {
 	.exit		= pci_xr17v35x_exit,
 };
 
+static const struct exar8250_board pbn_fastcom35x_2 = {
+	.num_ports	= 2,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_fastcom35x_4 = {
+	.num_ports	= 4,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_fastcom35x_8 = {
+	.num_ports	= 8,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
 static const struct exar8250_board pbn_exar_XR17V4358 = {
 	.num_ports	= 12,
 	.setup		= pci_xr17v35x_setup,
@@ -801,9 +819,9 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(EXAR, XR17V358, pbn_exar_XR17V35x),
 	EXAR_DEVICE(EXAR, XR17V4358, pbn_exar_XR17V4358),
 	EXAR_DEVICE(EXAR, XR17V8358, pbn_exar_XR17V8358),
-	EXAR_DEVICE(COMMTECH, 4222PCIE, pbn_exar_XR17V35x),
-	EXAR_DEVICE(COMMTECH, 4224PCIE, pbn_exar_XR17V35x),
-	EXAR_DEVICE(COMMTECH, 4228PCIE, pbn_exar_XR17V35x),
+	EXAR_DEVICE(COMMTECH, 4222PCIE, pbn_fastcom35x_2),
+	EXAR_DEVICE(COMMTECH, 4224PCIE, pbn_fastcom35x_4),
+	EXAR_DEVICE(COMMTECH, 4228PCIE, pbn_fastcom35x_8),
 
 	EXAR_DEVICE(COMMTECH, 4222PCI335, pbn_fastcom335_2),
 	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
