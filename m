Return-Path: <SRS0=9J3d=AU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F62DC433E1
	for <linux-serial@archiver.kernel.org>; Thu,  9 Jul 2020 19:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A54F207DD
	for <linux-serial@archiver.kernel.org>; Thu,  9 Jul 2020 19:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SealevelSystems.onmicrosoft.com header.i=@SealevelSystems.onmicrosoft.com header.b="yTdm+/M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGITXo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:23:44 -0400
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:21824
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgGITXn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Jul 2020 15:23:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYIdFIsdYHrP62JbYkf+b5RwC0FVFOHrUVYC5XY276on5T/0IedskNQEqvve6u0nGJ81y3iaT0DuFVADms/VpvXkqU9CZtzRjISxyRTy/z6FCN3AxYuF33g/dqBWQ2LLEsE+z40L091wLdH+AOGe/etQgj2YsWHX2IOQhbin3xCrSujIceAXK7w2ES4BwCyiblc2BhO0ztZVmjS87iXuETuctNSka+md7c00q5UKsj61thqaPfqtzHI9NE03Y3HGtWMGWfdTHvZtXJy1AYsBxwRmn6OgoCh7WCJGePG+UC7b1m+u6QLBIkzK7nhdP7+9ZkVIFZ0QS6DfNu3zv3+hQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0R3IJs4Mx2QoXuLG4IAecpzNOlwJ4IRWPOtv9FvBCHQ=;
 b=l3992cmpJJRDA4sJbcx9sWnePkDogd21FhI7HWRr4jG6FLRr9oVlxu6KhpR/NQscjkO6/unvtWSlnjEsBNl2SDdzz5cIDxAvQlxqHUhwovuKrifP1H7ftBOoi2YZWDyqsvEdA2LXv+FNf9Aixq8mgPDCSclE+OH1oPNqIwjiep1XHVgo+ggJt0eiIUtVfyxp9zCh8vqwho8lKkKMVUpeMtaufF1NGEhBZGii2sIXgSeYWrlge7heD/2JSXnSHw/RXQDPtTbVrQBnDRX0/LRZdSzXbVi3fb8V8G3Xs3auRQtSHm/RUR7TLWD5FnNah2qEcOvak19ZLoUjVscJK8FtfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SealevelSystems.onmicrosoft.com;
 s=selector2-SealevelSystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0R3IJs4Mx2QoXuLG4IAecpzNOlwJ4IRWPOtv9FvBCHQ=;
 b=yTdm+/M7ra4Kn0nrS6YrsLU3fH+BDuuD16kQOQF1ghUKcNTnv7jXx9eu0vC90Bsy7M483VpRPSjBOkSfrrKEzKK4jLpijnKOu9DCYXdhgYOmdaeUJoCMkuDPZVJIiAHqJQCe903UIQolKFGAEJf5NS+0jJBIvDIyZrVQd1bxjTY=
Authentication-Results: sealevel.com; dkim=none (message not signed)
 header.d=none;sealevel.com; dmarc=none action=none header.from=sealevel.com;
Received: from SN4PR0501MB3757.namprd05.prod.outlook.com
 (2603:10b6:803:4e::26) by SN6PR05MB4848.namprd05.prod.outlook.com
 (2603:10b6:805:9a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9; Thu, 9 Jul
 2020 19:23:39 +0000
Received: from SN4PR0501MB3757.namprd05.prod.outlook.com
 ([fe80::6175:9bc7:2811:cccf]) by SN4PR0501MB3757.namprd05.prod.outlook.com
 ([fe80::6175:9bc7:2811:cccf%5]) with mapi id 15.20.3195.009; Thu, 9 Jul 2020
 19:23:39 +0000
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Subject: [PATCH] serial: exar: Fix GPIO configuration for Sealevel cards based
 on XR17V35X
Cc:     jeff.baldwin@sealevel.com, ryan.wenglarz@sealevel.com
Message-ID: <473cc7ae-c870-ff0f-0c68-bdcfed19efde@sealevel.com>
Date:   Thu, 9 Jul 2020 15:23:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: BN7PR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:408:34::32) To SN4PR0501MB3757.namprd05.prod.outlook.com
 (2603:10b6:803:4e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.15] (12.18.222.50) by BN7PR06CA0055.namprd06.prod.outlook.com (2603:10b6:408:34::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 19:23:39 +0000
X-Originating-IP: [12.18.222.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c8322c-437c-4959-4897-08d8243d95a3
X-MS-TrafficTypeDiagnostic: SN6PR05MB4848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR05MB4848F1797216DEBE8A45C411F9640@SN6PR05MB4848.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbc6RzjDBWLbnr03NYBCiOOQJMtx9eOybVF9i0x8dMdSA/Rd9LqW21jNnPgXEnd3SUWR24t1atcH80BEJWsbSQzinxTVihdNaJ96Il9NCdmShq9ZAzLbuGP3Hm0DLnBNBdH+ld/yIDY85jmGAHUQ3Tt4khx3ewlaElaf5U8zgDWfgDvcULt2soci5k8/EGVQVzKhuylYNh7dWy/sRdtHQncI+OP4Mo2G3qG0ffOko7v0hxcqRLs7l3MJ9bRMSSixVj+P3OEDGqFrqUqYeyvu+lU4NoMwU68HpzxY8RkNJlUs+diRrcWi6Q6yKfxJ+uQnrSS5ec4eo2VLUYZ+majsXo7KJD0zuzQTfyeE0XIWLD9TOn7vNvqys9O9sn7NC5bJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0501MB3757.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39840400004)(2906002)(31696002)(186003)(4326008)(86362001)(36756003)(6486002)(44832011)(52116002)(16526019)(26005)(83380400001)(16576012)(316002)(956004)(31686004)(2616005)(478600001)(107886003)(8676002)(5660300002)(66946007)(66476007)(66556008)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BU9L2sFVRZt23WWM/NbuBzu/1mt/e6tEXORH44wGwUA7b/sU20VXDo2380wWWyACiLjqxnRCFb6PFrrWrpEGYXYX+7efKJ8Qjf2sXMnPL7iKUSeJvAz4gCVpYCyQhFLuP2igVX30Sgvf/HyhzxzXaU/h94/aepy33JfJhDCrEm+a/ghREFN2WbRVd7l5b8flG/d+mckN/kjz6U5+XZMVK+vZdG4RWqc/Inm5PKBHz7JFZVrlF7r7KvaT/KAptu442DSIbxCldER6T5x0VGUqwIxPJGAITH81i4oq8KGmqZhy72TApLei71Q6FDJTVRO2fYczijCIRzOiKRKkMb+nS4NQE6FP/bNMUqRbFvHuCxHomiaeeStA24UFlzcZTrDhpxkn97ty0XT/bab8i6pCSYY5hdludGxGxQ2NRllyB+nB1ikrUACLggu8roUCwFxNgRsAvo1DkUxS9WqFelLWbP0dk09TpbNq5aktI1FH24U=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c8322c-437c-4959-4897-08d8243d95a3
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0501MB3757.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 19:23:39.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWQLlggkIrNzqWWoIHa1IGKGO1XJxIqNuCHXkG9nzCkZnohznQ9lrBo/JoF3njYZJ6z53qIu5zFuADPn7jBgvrRRLlrheYcg93RqfM7OXj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4848
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


From: Matthew Howell <matthew.howell@sealevel.com>

FIXES: 7dea8165f1d("serial: exar: Preconfigure xr17v35x MPIOs as output")

Sealevel XR17V35X based devices became inoperable on kernel versions above
4.11 due to the GPIO preconfiguration change introduced in commit
7dea8165f1d. This patch fixes this by preconfiguring the GPIO on Sealevel
cards to the value (0x00) used prior to commit 7dea8165f1d

Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---

With GPIOs preconfigured as per commit 7dea8165f1d all ports on Sealevel
XR17V35X based devices become stuck in high impedance mode, regardless of
dip-switch or software configuration. This causes the device to become
effectively unusable. This patch (in various forms) has been distributed
to our customers and no issues related to it have been reported.

This is the first patch I have submitted so please let me know if anything
is incorrect, unclear, or if any changes to the patch are needed and I will
be happy to fix it.

--- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:03.9=
20060577 -0400
+++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-09 11:05:25.275891=
627 -0400
@@ -326,7 +326,7 @@ static void setup_gpio(struct pci_dev *p
      * devices will export them as GPIOs, so we pre-configure them safely
      * as inputs.
      */
-    u8 dir =3D pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
+    u8 dir =3D (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR && pcidev->subsys=
tem_vendor !=3D PCI_VENDOR_ID_SEALEVEL) ? 0xff : 0x00;

     writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
     writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);

Confidentiality Notice This message is intended exclusively for the individ=
ual or entity to which it is addressed. This communication may contain info=
rmation that is PROPRIETARY, TRADE SECRET, PRIVILEGED, CONFIDENTIAL or othe=
rwise legally exempt from disclosure. If you are not the named addressee, y=
ou are not authorized to read, print, retain, copy or disseminate this mess=
age or any part of it. If you have received this message in error, please n=
otify the sender immediately either by phone (864.843.4343) or reply to thi=
s e-mail and delete all copies of this message.
