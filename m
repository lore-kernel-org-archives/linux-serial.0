Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5489C433E1
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 16:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC1B208A9
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PHjNfMR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgHSQml (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:42:41 -0400
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:39553
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgHSQmj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 12:42:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpDPMGvlOo410Tj8KtVHniQOM95hOQp9hJCbQTMix5cApUVahJ+ZEJsvlBNweO7qaOGiyJ+TQzLBWYyo5YuC43OsQnE46/gZYzJ55gvXkMKyu+iyVu1oLk2yu7qO9zp6UrXkYv55HS04E0b1GaiB60Rd9Xe+W5/totpNv38/Le0I57XLAgrMHgyxd2h0IsguJwbTbUC7uwKxeTG6J2u98hw3MRFG7/Go9NWJONw29Es+mILf1cQlVHWBsCykpFTxf0LBhKvYVrX7g5+VGsqYZJEFRvLhk8QtK0B/Ohwv5DHz0V4CKlPKhZB3GmygpASfEuQA5HBxJ4eUuFZPpNs62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqeJHA/xXfAWAX7KJIjKmv5iOE0qwEbz/F2EVqWPqXY=;
 b=VkHndEuUmr29KhOcU7umMAgxiu6RWb8yO1otLBlr7G6cGrhwOng9Vw9+dwClGmaNZCpPlei/GCI9AfoemAoF/Nx+vMRKQt2sb1KH1dL/uOHwT+cIp1KLexQNG6+Gr28BcRNxk/suRjOhYj3CPo56hmYAEG1bWgPg3R7OZ2re1KBE2vxJyuYrcYuaccttEH7ijmD0fu950VfHqttlV7vVGXPsO2zMe3cNg2wzCVrR/9rA3v9+o82dmJbOe0MMeh6zNJ9GEhV1Wc7HKxmDjA4DrIGfuQg39LEg/DNReagB2dLUUx3hlpZFxj2EztW0mUBycy0vJx7EOdLbDYKkscNC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqeJHA/xXfAWAX7KJIjKmv5iOE0qwEbz/F2EVqWPqXY=;
 b=PHjNfMR7WAZ9UPZz00vgGbV8vTclH3VB8zB71r/IwFZZkDK26gDMAUImmZZOIkYXV7q7fBcde1GvwHgqb3q10GskViK3nIO+H2MzhTl7dg4kEh7/Hp9ftOO7+l6etfQamFRbPyugzYmScUfSHlWi+mLhTOciQyh9+8PHhH8FyE8=
Received: from DM5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:4:2::17) by
 CY4PR02MB2455.namprd02.prod.outlook.com (2603:10b6:903:74::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.18; Wed, 19 Aug 2020 16:42:36 +0000
Received: from DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::8b) by DM5PR10CA0007.outlook.office365.com
 (2603:10b6:4:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 16:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 DM3NAM02FT016.mail.protection.outlook.com (10.13.4.77) with Microsoft SMTP
 Server id 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 16:42:36
 +0000
Received: from [149.199.38.66] (port=60048 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1k8RAG-0004CV-MT; Wed, 19 Aug 2020 09:42:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1k8RAa-00023h-Af; Wed, 19 Aug 2020 09:42:36 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07JGgZfl024321;
        Wed, 19 Aug 2020 09:42:35 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1k8RAY-00023U-L0; Wed, 19 Aug 2020 09:42:35 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jslaby@suse.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/2] bindings: serial: Add xilinx compatible
Date:   Wed, 19 Aug 2020 22:12:30 +0530
Message-Id: <1597855351-30817-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 88fda95a-5dba-4169-3f09-08d8445ee102
X-MS-TrafficTypeDiagnostic: CY4PR02MB2455:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2455D6E3CC19BC9CFD7F7BCEAA5D0@CY4PR02MB2455.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sg3KvgZQa1XBS/XXWWdHhoLen81ToqdL4tOJ3suoU7IRH6DHERXqTh3EA6oQN+sXgb/uk1UjnIdWKvBQ6ZhkX7rXXncVBP9nxI9DrEgdU/3Ce3oy9y5jt3rBDE5oPWXPJreDDSvf5I4SUBkxaskTl95MuMVXSSXfAmbzgJfAeerRmz8Jo3mjYDAycHeJGewwtdA77C2fe7aryNLu88ngjaUNcFGfpMmtgs18Q1pSw7syvKXqJQdbgNLwoDn9oFEEhCu3Hs54ZdTBJHdTRSoz2qfetr2tbjQrgROXw2wNvlMHBjEFGvTryJU1zgk1MaaCaWt7i8EKiOVvxqG33u5Ljyh0WvuZO5+PZCFpZHOkHkckp2kk0k3mQMAqsO0YHVaTaos06s0IhswnboRtYx7pXA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(396003)(346002)(136003)(376002)(46966005)(81166007)(426003)(6666004)(478600001)(356005)(2906002)(4326008)(8676002)(47076004)(2616005)(7696005)(5660300002)(8936002)(82310400002)(316002)(70586007)(36756003)(107886003)(70206006)(6916009)(44832011)(82740400003)(186003)(9786002)(336012)(4744005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 16:42:36.5520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fda95a-5dba-4169-3f09-08d8445ee102
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2455
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

