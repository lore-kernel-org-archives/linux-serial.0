Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D970C433E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1BA20888
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LvtNh1jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHSQoo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:44:44 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:7860
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbgHSQoK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 12:44:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUzBiiJt8qSk92dvGVIduYQ9h/Z2WBBDjG4UR3Xa1v0e+aS0v9qEANqnmTPvzh2gltRJfdlTYEF2k4w2rifAG3/EEmE0hcM/9ITOuu+H9RmH+0R/pRmZ5DJN4+1Up6CMFaA1aIAJj+wVvv89XZ8g4bUcgvZa3oO/u++i9qXdDmybqpafyDkz82YajAM8vIJCbTVXcGzXdtoDgNG+OLlPgljIzXDDx4zlPLhHm/A1v+BSZ9yoFwlSUDXw8tA5vSV44sgk+2jC9cUdSwaV6aokHMl7vimv6/GLqPH7n7yqOQdfIoqM592wqStaXP1eYqyF5tkM1/3iC5ciCvs/hv3e/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqeJHA/xXfAWAX7KJIjKmv5iOE0qwEbz/F2EVqWPqXY=;
 b=bGS0JzwMJ/z1hcnbgWBY1yKyRoFEEvCG2QBpdeXlCXseamIYDi64h8KxHvTkMmjcqgNqYc12abazANAAFACJb0QKBjjYuY+IfGC6v6GbpL0Nb4qmdU8w20ZpocOx++YqLDPGi8D8JVfjLdEC6zeI/FfoNmohhuRh+hexxlbtnNs+0YEYJezROQjDiocbwwgNbKf7/KQRO3hlC57l3GfWuuOTL29wlseWPLK8Q11UNmUaMxwXxUZ38QDbluijGevUNEzLGQIGfiWVFBf2wBwj7K3CHv7GzJJpzXcP35Zgba8JcAKsUAOsZ4vZara3QUcN8qZdOsfTIgfbmy73WydpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqeJHA/xXfAWAX7KJIjKmv5iOE0qwEbz/F2EVqWPqXY=;
 b=LvtNh1jzUAY3PD6WI0RkbnHmf96PxLKmd9/ljsCfzRQ5fnIjdSGUB7dKq6fMO2iI4aWPLCoxdZ3PWg8xsor/Rg8+jucg4dP+GgqiSVXwh39/csMunRoTqjFMn5Mf6WX5hgnT5YDyWT7GhLbgcOLAsZUJ2ZpME0pRYUQ2jhWOBJU=
Received: from BN6PR11CA0051.namprd11.prod.outlook.com (2603:10b6:404:f7::13)
 by SN6PR02MB4317.namprd02.prod.outlook.com (2603:10b6:805:a7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 16:44:07 +0000
Received: from BN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::d5) by BN6PR11CA0051.outlook.office365.com
 (2603:10b6:404:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 16:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BN1NAM02FT042.mail.protection.outlook.com (10.13.2.153) with Microsoft SMTP
 Server id 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 16:44:06
 +0000
Received: from [149.199.38.66] (port=32986 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1k8RBj-0004Dj-0V; Wed, 19 Aug 2020 09:43:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1k8RC2-0002KD-Kz; Wed, 19 Aug 2020 09:44:06 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07JGi41N024618;
        Wed, 19 Aug 2020 09:44:04 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1k8RBz-0002IZ-RA; Wed, 19 Aug 2020 09:44:04 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jslaby@suse.com, robh+dt@kernel.org,
        git-dev@xilinx.com, gregkh@linuxfoundation.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/2] bindings: serial: Add xilinx compatible
Date:   Wed, 19 Aug 2020 22:13:58 +0530
Message-Id: <1597855439-746-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a7638732-bfe8-4115-906d-08d8445f16de
X-MS-TrafficTypeDiagnostic: SN6PR02MB4317:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4317C5EE05E2587155C189F3AA5D0@SN6PR02MB4317.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wReyuqxuCZH2e1t53kPO0XOAuKwpoFcKDzfOj93n6fMkPPC1GUCayGsohWGcI9X7thQes0C4J2Jz8xzKmNhBfoKnJWwjK/Yp4G5NwoSCc/4kOLBau9/h15bITJbAk2KX+cLkBHlyDCeLf9T866Lzrsyf1qolRYfJoBI1Heou1/CNroGs1SU38M45PNXTk8xPGnCHijwzLFSe+k3dL6WYoKKCnC8PVHvB6KIgHQBrRInSi6NqA6vRjujnIG9DdLU5Rr/cZ8FVsjt5LuopdRIJHVn5gD6EgScI7+hf1ETYXT3iklFdbHa75BHfN9hw1ztyvKm6HqWbmaONeRQrORdkgGnFV6y18DaWqH6A/9eCvccvgXVysyYKj2I0ZUQtyuASR6A8AwZMrakojk6Z4psJwA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(39860400002)(46966005)(82740400003)(82310400002)(426003)(2906002)(107886003)(9786002)(70586007)(70206006)(2616005)(478600001)(7696005)(336012)(6666004)(26005)(186003)(8936002)(36756003)(8676002)(4326008)(316002)(6916009)(47076004)(356005)(81166007)(44832011)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 16:44:06.9151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7638732-bfe8-4115-906d-08d8445f16de
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4317
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the arm,xlnx-sbsa-uart compatible.
Xilinx versal uart is similar to sbsa-uart except that it has
termios configurable.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 Documentation/devicetree/bindings/serial/pl011.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index c23c93b..6e123b1 100644
--- a/Documentation/devicetree/bindings/serial/pl011.yaml
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -20,6 +20,7 @@ select:
         enum:
           - arm,pl011
           - zte,zx296702-uart
+          - arm,xlnx-sbsa-uart
   required:
     - compatible
 
@@ -32,6 +33,7 @@ properties:
       - items:
           - const: zte,zx296702-uart
           - const: arm,primecell
+          - const: arm,xlnx-sbsa-uart
 
   reg:
     maxItems: 1
-- 
2.7.4

