Return-Path: <SRS0=wdWf=6X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AECC54E4A
	for <linux-serial@archiver.kernel.org>; Sat,  9 May 2020 10:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA0621473
	for <linux-serial@archiver.kernel.org>; Sat,  9 May 2020 10:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="I0jwwVV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEIKYw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 9 May 2020 06:24:52 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:23453
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727837AbgEIKYs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 9 May 2020 06:24:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnKAZfOUlxTKvWkWD4MlOjB/2mZ8AiGyJRU8BfK65kA6DXDDkPVNlywJAFEfIcaLRGuoNuOvjPBFOLNndeXHeRqzwx6Bp3GtstPKyZp4Y65q1olJrmB7J7kaphI3XaJEERfEYBHhZ+OwgS+d/t5Yv8pymILlaKRHa6vI6noG2P9ls774QzuKkOJv8f5JizBLUe/aAYJNxlt5LMPvk5VnzwexcmtCfj6LbovJ8y24RmV06m5bqCnPZJLSZFLWyy2kFgT1pKIH2/44Z7ZLQ31jucnXW0iuT8K71hkoW0Q3caaSxGlZbFwH/CJwyOoxHwxRab0fWw2IKBVEMIvyiktrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT3UTH3unlFwims7hK3k+7BQPZIQauXuKeJKChl6ubs=;
 b=IzlDZG4okQbch/m0kAoFjbkOob3cF7CcTPF4argjT/maoU618IihEreptnikzINkhv29XzD8eDwP4qJOF7sz/y858OJoX+bwcv+OysGC8qoAsENa/x+AlcrVQBkQUxbTXmXLHYV5qLJbSUVTXijR4l+9V6wDtFUIwjCYD9RAeW5Acgz3IDwSYrpZyCp27TpHSQzM8h4RSr+DROikk7RGegUtkqga/OALpArNSU3PItspmFgbtJDhClBwEGYLMTfDkgioXQHNK0jj4ncGBWxjvLD7S/BK8XY9zu5HbPolaGcNZOM34XniIQ90IE3jnKtf5LEJB3PBUmZi+HboCUHx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT3UTH3unlFwims7hK3k+7BQPZIQauXuKeJKChl6ubs=;
 b=I0jwwVV9PiFDGjk9DyeCgTBzKyzv2J+1oGj8sslD8jVl8sFSvkaET/7xY49ET85EVICH4C/6Ypk3z2zMKGz0ZERWANwqpRxBSNE9GaJiJFRUTA8VB3FiDlfjk0xW4krMHKlMnHFF4OaBwH4Pec2WU24+qlgh+QvuCrarVSNC/sE=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=sifive.com;
Received: from BN8PR13MB2611.namprd13.prod.outlook.com (2603:10b6:408:81::17)
 by BN8PR13MB2724.namprd13.prod.outlook.com (2603:10b6:408:83::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.13; Sat, 9 May
 2020 10:24:43 +0000
Received: from BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929]) by BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929%6]) with mapi id 15.20.3000.011; Sat, 9 May 2020
 10:24:43 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com, anup.patel@wdc.com,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v1 1/1] tty: serial: add missing spin_lock_init for SiFive serial console
Date:   Sat,  9 May 2020 03:24:12 -0700
Message-Id: <1589019852-21505-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589019852-21505-1-git-send-email-sagar.kadam@sifive.com>
References: <1589019852-21505-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0056.prod.exchangelabs.com (2603:10b6:a03:94::33)
 To BN8PR13MB2611.namprd13.prod.outlook.com (2603:10b6:408:81::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BYAPR01CA0056.prod.exchangelabs.com (2603:10b6:a03:94::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.27 via Frontend Transport; Sat, 9 May 2020 10:24:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c2b23d0-35b2-456a-c621-08d7f403304b
X-MS-TrafficTypeDiagnostic: BN8PR13MB2724:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR13MB2724B7DD7CBEB557DF4F891399A30@BN8PR13MB2724.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03982FDC1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0sve2qwUV1ISg9tRM9XhDQ6c+lxkwq2TPsQ4kZkAe18bsZxaKmk61t5HmxLRrQSO/81Alg/x0CG7EabFMchdeo6YHP/0rnwJ5d2U5cacPrsDp65xUEVB0PMWK6T9N11Dj6cF5kSAqW8HE2/Jl3A9eiuK4DR7G4vkHJjY40WMQj+sb69FL1rhFzvu3YHiauxacZxl140qeW6kzWvYQeEuJzdpMBj8yqt2HbsR+7/2z66Xlu5lChazv193Y47CJIkAnsvnkIcyk9f0CZ9K17+okjOYJuDT97kJS+jsxoSBuCAfZXDbjq5YznJ5V6w6scyTS80t3HjhgGj5vDDW9tt5EikybVTXoCjBAFaa/K17EITrquSJXIYLO7EEaaUK0Zq1dvVaijwZgNKi25E9SEs8nsR90DqY7NxdtkPOkOoXlmQ+6XIrXhCYnGMyJ8TztZHfQfdgORUUxIBm55/8ZF5T17npCLJdnAmWmoeiLDWcuGTPDq+qN9nAAaCQXpfmec/0tLDYNpeDTGcsLDbOTdLEId2oz9/KLjAMBhcICe3gDjaeK8Zsez5oN+l4ROPW5IVvIasEMPzL7b97nCl4QVT76hKywooSfLuIkme4iPzGNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR13MB2611.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(376002)(396003)(366004)(346002)(39840400004)(136003)(33430700001)(86362001)(8676002)(107886003)(8936002)(36756003)(4326008)(956004)(2616005)(4744005)(6486002)(186003)(16526019)(5660300002)(26005)(966005)(6666004)(316002)(478600001)(2906002)(66556008)(52116002)(66476007)(33440700001)(66946007)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Dz4OezNYHZcProe9aSmZIKmxNvvkkf5Berzry4ILVCnvSyt1wETtwPfzp7OoSfatUiFAUX+XO7KwaEtHoz2D8Ece5F3HL1O9uL3/73+e6PF8NueI6gM2Bulj8inq3TC8EAckPxU5W5wDRlu+6Mt8pBq8GIlONUWZxFmf/LvZdmNgNQxJiqpwhWqyjUL0NFNFiNrQz6di5qm59HGJEpYeNSZJPbRUzJioOyhtazkei3mR00B06ANT9rVxT2eFrPs34N5PS71k1ncukIK0Hv2w0me8v6rctkU3uijFWP9ky4l7jT393dRtFPFpT5kHXLa5ok27dNYVdCPMtplOCCLJY2a5bv05XGRWASK1mddKeRUspvudEOuJIi+rUmEYrPF6jl3UiYLMk3BRh1PH+HgNP03R52iyszVLSHKL+pHITMJ69oZC1Kg/BCl3nzfu1DjnNfZ9h2J+QYQoBlYhXYnZrXoyeH47+jxkKhVIqhz652c=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2b23d0-35b2-456a-c621-08d7f403304b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2020 10:24:43.3053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H47gJm8m8zHr61iGLTsk3vs2ykGtYznYrn5N0AUBmnLig8NRYjIjEFhAJs1hyV4gICmOCoVtILx2G7H/PE7G+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2724
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

An uninitialised spin lock for sifive serial console raises a bad
magic spin_lock error as reported and discussed here [1].
Initialising the spin lock resolves the issue.

The fix is tested on HiFive Unleashed A00 board with Linux 5.7-rc4
and OpenSBI v0.7

[1] https://lore.kernel.org/linux-riscv/b9fe49483a903f404e7acc15a6efbef756db28ae.camel@wdc.com

Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
Reported-by: Atish Patra <Atish.Patra@wdc.com>
Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/tty/serial/sifive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 13eadcb..0b5110d 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -883,6 +883,7 @@ console_initcall(sifive_console_init);
 
 static void __ssp_add_console_port(struct sifive_serial_port *ssp)
 {
+	spin_lock_init(&ssp->port.lock);
 	sifive_serial_console_ports[ssp->port.line] = ssp;
 }
 
-- 
2.7.4

