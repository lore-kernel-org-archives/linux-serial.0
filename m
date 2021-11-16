Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFE1C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B1A61A38
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 11:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhKPLUu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:20:50 -0500
Received: from mail-mw2nam08on2060.outbound.protection.outlook.com ([40.107.101.60]:11520
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234816AbhKPLUs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 06:20:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuRXYke86ZS8yGJENXn8/qT9k1s0h/QZQIHjfZZt07UBSQ3K8p2fJq9Gv848VGn/xmFu8h+t3ZNdkwr+JcdesQ4e1mjeCxL+zEs1eS8/XSd0GvteKNo/sVaGsKAlnSJYCCbatei7P0dQuLvYHt+cE5fqkimU1sX/LS+ZywIahYeKr9XPRne8UJk94Bj9aaGAeWmbC2Zenwp4bPPkWGA7e+vHuNz8SgFeJDpH8gOjZb3aYITrch1T3VrTb1hbEgxsvgRZlE3p4b9FQmGKyiOsL9BAFLLGTGRMBnqG1k8nF68uvpPTWfBrDGTaq6ETJY5ybwedBJYAaxxVEcgDxM+4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkpwTRDy25wYnk0NPEpblKPccNjfQB+gIJOYOwF7RB0=;
 b=OSxcqumnrpP1HPec4ijnGsnDJr5NL1inwvmA9TLqd8YvrlEDAWougKWkh7Zle4Yo9ZP9O0zzHKy/a5Pt5E7iwJk5Ct2nRpIUanNWxwRHVuwTIFNBGLD5VSOJX1Z7LmLsIG6xaY2qhJ+3VDw0UUuNV024uiPTe1GWG9HOHAdXZM+Xmp4jXbGhw0VDbGXyn1IQG28OEta98iROpgtArFB+4xqqAiRKavXHU35gXxTQQuffCUzh/Sz8JFeX/sFYO4pMJLSmfwm1ZLSfvi7ogqNkQkCnp4xfL3HJlfjOPVQ5vZv94v72Cgdp+GyQ6CSUGLSUGjqY+MXk6A9aVxpy+SRCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkpwTRDy25wYnk0NPEpblKPccNjfQB+gIJOYOwF7RB0=;
 b=XihPRBkvOo+bWJqRZlIl0Led6Sd67PmDwvy25RbrcAr9zbqxOzc0oklnk+NUeeS6Y076EIgC5lCpZOocNWFBP9S6T3eTX25cbHwyYW14QERj194Nfm3D4IU6JJoihBfZ93SKOiBgMEjw/NM1mVFsoxkEgWbPce/BGRcDZQaoNEk=
Received: from BN9PR03CA0352.namprd03.prod.outlook.com (2603:10b6:408:f6::27)
 by CO1PR02MB8347.namprd02.prod.outlook.com (2603:10b6:303:162::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 11:17:50 +0000
Received: from BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::1d) by BN9PR03CA0352.outlook.office365.com
 (2603:10b6:408:f6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Tue, 16 Nov 2021 11:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT020.mail.protection.outlook.com (10.13.2.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 11:17:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 03:17:49 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 03:17:49 -0800
Envelope-to: linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.140.6.39] (port=51454 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1mmwTE-0004ZS-Vl; Tue, 16 Nov 2021 03:17:49 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 0/2] serial: pl011: Add xilinx uart
Date:   Tue, 16 Nov 2021 16:47:44 +0530
Message-ID: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea32f901-d8d9-4094-672d-08d9a8f2b98d
X-MS-TrafficTypeDiagnostic: CO1PR02MB8347:
X-Microsoft-Antispam-PRVS: <CO1PR02MB834752FE2FA80873575C9CE2AA999@CO1PR02MB8347.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKiROb/pXrFzbokcN5zvZl7yyRxv+KZmIXrEnOyQVx6el53SueINyygngh+u2e3NJAvu9dO75EUdQ/o49AWeKKqKbJVycd1TCBc9n47TyfIIQyyD9EbluFBuV4RAz0YfQCV2ioN7K+530emApFiOSpcdVQvQJ1N+5Hp8q9liX0DtzalM4oLqfe8MlxhDdJ58EZ7gquzocdn/W7ileg75DXVsijMhUBOMuYX2RDAEqEEnDOnpCphttLy2K31rJaRSC7dEsZzMosyewsl9wc6oZMVLJoKdro2o0bYhuVe/5rv+a8yhGln5WzHOAsk2YUW+MrvuLRrJDxBbOZcmKidfW/UpBinaxFKzPD+mD3tLpZmyahMPTWrzZMKan6Myg5J295G6PUxMQqGi8e9S0mzsuwTmOrGoS8L3jfWR0VfPywNDvJ0xeo/tVC/V6jP+D88dFMHlXGwLGBX6eCR2yqJYdoR/SL7A0TzL9jlqTCC4fP3xEG1zXxTJy5jnALQOD8OqhsyEYlHuMYzb8En+V0DYtIDs4laJIfmc0LuR9aoOwCOnKybTFOhgGz3QLBmtSXzt3Ed0HNmnKaNoUIblnq12eXv675+J+GZLCDGsibALBHuETmPrTeVXhPo6UoxRu5mJs33PNbOAlO2d7F4u9xXteQlqOJoRKrCCjUYR1kCqQgQWSsGhMf1zmaGzFLAKC9aWHJvR5dwpDp4sjmMBV6tnKKSpHfEMHTRv1YIJnB842j0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(2906002)(36756003)(26005)(2616005)(82310400003)(107886003)(4744005)(36860700001)(316002)(508600001)(6666004)(336012)(8936002)(426003)(70206006)(54906003)(70586007)(6916009)(47076005)(83380400001)(5660300002)(9786002)(7696005)(36906005)(44832011)(186003)(8676002)(356005)(7636003)(4326008)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 11:17:49.6910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea32f901-d8d9-4094-672d-08d9a8f2b98d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8347
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-Support uart peripheral in Xilinx Versal SOC.
Add the dt-binding for the same


Raviteja Narayanam (1):
  serial: pl011: Add support for Xilinx Uart

Shubhrajyoti Datta (1):
  dt-bindings: serial: pl011: Add 'arm,xlnx-uart'

 .../devicetree/bindings/serial/pl011.yaml     | 10 ++++--
 drivers/tty/serial/amba-pl011.c               | 33 +++++++++++++++++--
 2 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.25.1

