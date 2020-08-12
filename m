Return-Path: <SRS0=P72y=BW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECEDC433E1
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 21:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3C320774
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 21:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="YcImmrcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgHLVtr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 17:49:47 -0400
Received: from mail-dm6nam12on2137.outbound.protection.outlook.com ([40.107.243.137]:23489
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbgHLVtq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 17:49:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv1VAapg+8irh2TkHfa9M97yNcbpI89vm5GSOpd6VWlTIpAJwc67QVcso97/AoTGesTDQNiFAqxFgsZ0vQ/p5r3M0jHsIS5wLr4Poba2i57pnKaXLKUcQ9cvp6Hxr8M5EdbrnEuE7PMTOWeNJ2fDMianUO2fmtsTyCH/P+hT5MWnS27We3cWseC5EpmwHxT1BI6ydjpsIP7LY+Nxa+jKeGGiFwd9SESg7U4tcsOyFZ0qJ5vGD2TOFj3Yt2GajHE7S32kDXFEnfxnxyo04OM+1vC46EQ1+vz4IC3uwh8pGb+sflRCzLFUb+6p+lCYCs2tqzaEnknwOH+cEYuHktE/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8rreC8sU7ispKu2hOnLfRlyFkcozGwDdt7LlWRIcVI=;
 b=Eifq5R9jsj+bAkrSzXWKYaIesmZ760URqpxiyCoJ0pqfVenH09u1m566E3G4uDsa9LitfZOM6w0o59pSmidzxAvBqjsBYLRS9Q7UHkxB6/Uo8hvFS1LEnLbJiDIYdXGh4GD7qLT8V8b87+fqvYCt2DAahh4xGOxdQr/gUHV5+j40Llx9a4yRvjaHjim+VYOgoGils3/hbZgAAIxtLic/QIYeUO/hVXfKGE8t267UBvYzFB3qv7q+X9oz45muYlC6T6LXkGrj++u6QXzaAFTYHjoP/sP/VPiAatsdRqk7XMRNHXJfyXfAAaVut3DgVEMK471XIikB+XqAzK9tWI9CiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8rreC8sU7ispKu2hOnLfRlyFkcozGwDdt7LlWRIcVI=;
 b=YcImmrcpvtmjdkY60/AoKK0Zax0HPxXozbYnEMInCA2s4LK+SS8Atr0M1nCd8pEuWsDEYyTn8A8yG67Zvy5X+k7WP5uwiovWZj/fL54kRzVip/gMJYr3bnzsk0O2m2PH3dGZj+byUyvMfjPf6WCypQ9MkkIt/vfjPx3hYz7FFZs=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from BN8PR11MB3604.namprd11.prod.outlook.com (2603:10b6:408:83::19)
 by BN6PR11MB4099.namprd11.prod.outlook.com (2603:10b6:405:82::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 12 Aug
 2020 21:49:40 +0000
Received: from BN8PR11MB3604.namprd11.prod.outlook.com
 ([fe80::9caa:fe2f:bbe7:123f]) by BN8PR11MB3604.namprd11.prod.outlook.com
 ([fe80::9caa:fe2f:bbe7:123f%5]) with mapi id 15.20.3283.016; Wed, 12 Aug 2020
 21:49:40 +0000
Date:   Wed, 12 Aug 2020 17:49:37 -0400
From:   Valmer Huhn <valmer.huhn@concurrent-rt.com>
To:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        sudip.mukherjee@codethink.co.uk, jan.kiszka@siemens.com
Cc:     linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_exar: Bug fix for determination of number of
 ports for Commtech PCIe cards 
Message-ID: <20200812214937.GA332930@icarus.concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: BN6PR1701CA0004.namprd17.prod.outlook.com
 (2603:10b6:405:15::14) To BN8PR11MB3604.namprd11.prod.outlook.com
 (2603:10b6:408:83::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from icarus.concurrent-rt.com (12.220.59.2) by BN6PR1701CA0004.namprd17.prod.outlook.com (2603:10b6:405:15::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 21:49:39 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a71a2bc8-9b91-499e-1c24-08d83f099d56
X-MS-TrafficTypeDiagnostic: BN6PR11MB4099:
X-Microsoft-Antispam-PRVS: <BN6PR11MB40996AE616E1E9AFFCAD267CA1420@BN6PR11MB4099.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0zeCOdtyYb6RqfIyx2j3IE0v4di96/y2g3lcMaFEwLbO0Sr0q1fe6lkNnuL5zuDDK+jdYTrgGCW2TLk/KKRaGf+Tzy7NA7iEmXnGOFYLN5vH1Kg0AefpzJZB6jni7Cl4R6YOQKUTcKw7GPnpkLWj3qZdmeIa6z+wQNfeTKGj2PkKB4q3UBe3gTHehBg2cOBW3cxfyLG8AyiX14OnP6nI/yrUXoDAFEsMSYO/OeKVtb0duChJp91dOw9j3UnlHDsCdQ71O8xZhtlxo6/zOidUYblUMeCbI8BQA2rCHSURtDfqznj1ZhwmmolKyH/gvRcN6qywniGOb3b1AqXcC3Qqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3604.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(366004)(136003)(39840400004)(2906002)(956004)(186003)(33656002)(7696005)(8936002)(16526019)(26005)(44832011)(4743002)(316002)(5660300002)(52116002)(4326008)(508600001)(8676002)(86362001)(66556008)(66946007)(55016002)(1076003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: j/AeKJoY5bB+0oXEwtm4+/7ozI1KtdmqQFshSegu2Jy2lmzZB1o2IWD7/BEf/4ZT/LLTcxUaUfLrxVOOKm0fBROkM8ZnhMLvbkOOsuO0ViypsThrqmVtJ4AD/27peeNMwUfiRCYkw56AVTCGt2UtuFVLtaOUFoODIpj6XFTDhV85hzpDiizJijGa9vz2IwK4g8zllqZ94mm7FpoElLwmlFagn4F+pE7eW5iKEaW9fELi4UOqc33Qtm+RO23oiQXqZ9o8EBOa5N00cO0D/x43X+FIiEhNnfoZdy9dD63AbCCI2GOhAGdMfITdbnfjmKfCY1xABpOxupt0mh0wIXI9tORSqa1zIKXLtem9w7khzB5SAnw1Ef4x6kCxvgApxf/83geJCMEASAz01QPcx/N/qUyL3sxDPmD7xgq8FkKme0qds4bTL3d1Q2fzJmBdTcvEB2nyVdgHnsjiayvDsU1PmsukIfYsE7ULSQMBxC3+dYh6wDppX63OD5HvWF1v3LgMspLwfIGGt24jwwRkBAO0t4oO/h7h3PgxZVQW3FTb7qtZsA3GGZo+kCCgGLO/YpO/6X6Df8Y11LlnfsDjdr4sQIfFvzXVWkrMFzjU80wq9HkCeIIfkP+huRDzXSvmcgiT
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71a2bc8-9b91-499e-1c24-08d83f099d56
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3604.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 21:49:40.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEbLTBzTMJVdv5jrxhICcOWIBR4LTjAf+3QsA3AwG9bur9jGifGCt0/zHUry6nN0Bo+pSSRKqSOaeDUYCJAUeII4FzC2q4T6t9TIILDUq18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4099
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

serial: 8250_exar: Bug fix for determination of number of ports for
Commtech PCIe cards

The following line is used to determine the number of ports for each exar
board in a/drivers/tty/serial/8250/8250_exar.c:589

nr_ports = board->num_ports ? board->num_ports : pcidev->device & 0x0f;

If the number of ports a card has is not explicitly specified, it defaults
to the rightmost 4 bits of the PCI device ID. This is prone to error since
not all PCI device IDs contain a number which corresponds to the number of
ports that card provides.

This particular case involves COMMTECH_4224PCIE and COMMTECH_4228PCIE
cards with device ID 0x0020 and 0x0021. Currently the multiport cards
receive 0 and 1 port instead of 4 and 8 ports respectively.

To fix this, each Commtech Fastcom PCIe card is given a struct where the
number of ports is explicitly specified. This ensures 'board->num_ports'
is used instead of the default 'pcidev->device & 0x0f'.

Signed-off-by: Valmer Huhn <valmer.huhn@concurrent-rt.com>
Tested-by: Valmer Huhn <valmer.huhn@concurrent-rt.com>

---
Thank you,
Valmer Huhn

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index ddb6aeb76dc5..793906afb0f6 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -734,6 +734,24 @@ static const struct exar8250_board pbn_exar_XR17V35x = {
 	.exit		= pci_xr17v35x_exit,
 };
 
+static const struct exar8250_board pbn_fastcom_XR17V352 = {
+	.num_ports	= 2,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_fastcom_XR17V354 = {
+	.num_ports	= 4,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_fastcom_XR17V358 = {
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
+	EXAR_DEVICE(COMMTECH, 4222PCIE, pbn_fastcom_XR17V352),
+	EXAR_DEVICE(COMMTECH, 4224PCIE, pbn_fastcom_XR17V354),
+	EXAR_DEVICE(COMMTECH, 4228PCIE, pbn_fastcom_XR17V358),
 
 	EXAR_DEVICE(COMMTECH, 4222PCI335, pbn_fastcom335_2),
 	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
