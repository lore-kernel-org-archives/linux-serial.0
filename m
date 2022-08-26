Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D9EECAAD6
	for <linux-serial@archiver.kernel.org>; Fri, 26 Aug 2022 12:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbiHZMGT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Aug 2022 08:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHZMGQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Aug 2022 08:06:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7E74DF22;
        Fri, 26 Aug 2022 05:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL6ehli6tQrExzFK89LRViuYmZTT/gBGP1FDV8UeODk2ZYqBLApGPowWeXEpSH0je6ucGwDh1sZL7u/xfXhFOgVNGLi3e5ZcPs4eXP4QNb3mvCtImjuPloeY48bxGAS/xamfMc0ulca+h7ZI2FsPaIl3su8exnGWz6BczBBnmo3NI5YjbfqrNCcjC1Ce3zKtPHV79ksW67mxNm+RhNoBvcYLruM5xiysq6x/NfXNlQB/FNaUP31mOtcN5/i8xzVgsscpfVk0lTaRTZijqgrnyyP5z+5qvtckYnjQqUVY741SRtVOULU8uZ7xJqix5Fupe/FEvAyErBE54/yEPQqTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BE6kmLZjjOuYfCZuooX51vldedCWAKPwxjQIv9Qpb0=;
 b=jbKdhCzt0oQz1wwe1qgO2pPfmiUt+jvdXO5NAqW4NOwhgsqrAcmXJLImd82NXos7IAf71GujAn2K1R6GYvB+vhgzrAhw3HrHX734l71ECt4KIFWeYAkUxRWL1FSXGU9LwMt5TcXtv6+e3Uqeppb/RnW9RcguILoYc2RTN7kPmkWMEBJRNA+bOrFHSVtUHRKf+JajrKigXUWrejBLSTF/Z2lKAXMF6fD685ecuCmsamcVlg/MFu69+lBR9v5IehsOS3cY8YCGzU1M42r2d2uVnBRIA/9aY3sJeWBkc8zF+NfZuZbQ5PBPpVsiLjIrkHAZRi3MHcubDOzKW14JH0ztSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BE6kmLZjjOuYfCZuooX51vldedCWAKPwxjQIv9Qpb0=;
 b=VbOBkobIzaVY8BQLnwQHdAdgUDRJmU+HIOpvtomduWWDg4xro3iUhReZ7ZN49I/lu1m4ffRgczE6EB2DwUaJvtVjkjh7wQ+sR0jyNMuKRwDGYZomkSdm3Si31FwAlGHCmhQC9YrCnqyZrNInO8ppSDWw9BEb+qzDpdodM/iSgKg=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 12:06:11 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::69) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 12:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.13 via Frontend Transport; Fri, 26 Aug 2022 12:06:11 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 07:06:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 05:06:06 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 26 Aug 2022 07:06:04 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <jirislaby@kernel.org>, <linux@armlinux.org.uk>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH v4 1/2] dt-bindings: serial: pl011: Add a reg-io-width parameter
Date:   Fri, 26 Aug 2022 17:35:58 +0530
Message-ID: <20220826120559.2122-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220826120559.2122-1-shubhrajyoti.datta@amd.com>
References: <20220826120559.2122-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b158f0c-eb2c-40dc-9bea-08da875b5e32
X-MS-TrafficTypeDiagnostic: MW3PR12MB4540:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6zCb6mShKnROuddz+515e5PDdcT75gvf8N5vd0eHN8ADoru/R6iHIjOvGsfmV7WAbtnFbEBuXzxQuyYc1HIEc3972qmeFbiEDsKC0Sk4Mrf8yNscLM9hcmNtiqBPvZKq0XGZaPNl4O9ID/ILEOgYoov1axZga2tUvjfesLHNeN9/MsDywT6kkByqyAwAjLmZNWPlVR2y25Z09Eo8Zmz2PvFXwfiLfbuzegKowan+4mH0+zsJDgGlRyn1Qbt38B4hCp+KHcUFDxeqxiud1fqEOXEYFFBpx3ven+APLlt9lvN1kzbb7Tj92LoMWQMNXw9rW9PPGC25af+SyTuFgKqt7z8dnTqNNMGzup72T7jZiPbHfdE9EPDJTXNtWuduVOITPk22Z8fqWSmEoQIy+xiXbMWd+j29H0ixNj6rwR5D+NiochB2/Sp1qE2ZpEuTtCiHxYPyTDSfXT2/x/9hW8Q6Su1ljdmm5uBom1enno7xRSi46rjIrnSwFJv3h3+3KUO0zR0OUHEJ4sIg/zxpm7XQGvzQsKWiDjEKtEJxvMhA07ymnyTOTTxpcgZH0CRW/sKgTxnOCa8/KWTyMNBVKyxGvD1oMg68i1uBPdGfRF05mgNQOupErnrFJTDCJh17T6agr8jCX3VOqj47TKsmI/W5yeGzALYU1UhD1mQewYfr2QnSxE/YgU+I0kA/qUOd2gnc6Yi734jyGWjPBMXSjMW8Dl7qX2N1Tve13ASGSOwgo5FbCRC5h4fEKY8cWEZ/FGXDj8rm2E+FfVQft5GFLm1LeQE8WZY5yHdkKjsV7z4T2q4PmdXLwp8VMatbMQDtvja
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(478600001)(6666004)(41300700001)(426003)(47076005)(83380400001)(186003)(336012)(2906002)(2616005)(1076003)(44832011)(8936002)(4744005)(5660300002)(26005)(82310400005)(40460700003)(40480700001)(6916009)(54906003)(316002)(4326008)(8676002)(70206006)(356005)(81166007)(82740400003)(36756003)(86362001)(70586007)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 12:06:11.6620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b158f0c-eb2c-40dc-9bea-08da875b5e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some of the implementations support only 32-bit accesses.
Add a parameter reg-io-width for such platforms.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
v4
Fix the bindings

 Documentation/devicetree/bindings/serial/pl011.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index d8aed84abcd3..80af72859876 100644
--- a/Documentation/devicetree/bindings/serial/pl011.yaml
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -94,6 +94,12 @@ properties:
   resets:
     maxItems: 1
 
+  reg-io-width:
+    description:
+      The size (in bytes) of the IO accesses that should be performed
+      on the device.
+    enum: [1, 4]
+
 required:
   - compatible
   - reg
-- 
2.17.1

