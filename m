Return-Path: <SRS0=pwFA=5Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D5C2BB1D
	for <linux-serial@archiver.kernel.org>; Thu,  9 Apr 2020 06:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E082072F
	for <linux-serial@archiver.kernel.org>; Thu,  9 Apr 2020 06:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fSQJ2aeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgDIG00 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:26:26 -0400
Received: from mail-eopbgr750045.outbound.protection.outlook.com ([40.107.75.45]:17476
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgDIG00 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Apr 2020 02:26:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR2xFY1fZXMWycJ5Gwd8lb1a/zsKmTG7vkI+aR5rJDn1xjgImZdNhFMtCZV52MOguzLP5PGiOS1SXVPIYeaTQZKVvKSql8E08eIhw62cdaOllRhYwG2e/DTTkTgSLfTYkXv/T/+ni55tG1vTvwVco7EmS6A3vUrCCoUZmH/qmLSc+bRTmjewi7qkUJJrcPQTSoqUPi6b7LRzOqhzTMrdO7i1qtB+VlbazjMsysmpRX3L+zymM2kvtYiMxWLUAyUrA6VfnOC4AgioxOJItMqDpImnwJT2K+nQ2vROmONqgekBvqYE8/tC4E7OiqmITFFzkEXRTU4v31JwEp9ZEdIbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKuKpoe6hh1QX4TgtNYZISjBL0mlRHdI5azSZg5JJ+s=;
 b=XtSQgArLheu0cIcBbNdie1znG4jvbu5mMbyaPcl6z4r6c2ObCH39AOZve89UKeJHac23h8C7gS5HLYOIjyErg164RbdHkfsx9PrMUlUlZVRDmFqwOWjX6pLkJyacAcUpe4gDfki18eUn+KU+ZWuVQj7EkLMJ7DkTvwWRioIXaQsM4MsMpvd2HgfyOhRu3Kj4N/+EOCLFX+rK5y3Vjpej7acUiOib8a+KcriEJUy0ouviiQS4gIPiRpHV8IK9kitueJiHTNxV2yVkGh0TR1DFhmuXrZsCHfY/KGRH5ooy7rFsHcTbJj6aCa3Ae0mkVW8bXFQ6T1jXKE/NKscPGKu1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKuKpoe6hh1QX4TgtNYZISjBL0mlRHdI5azSZg5JJ+s=;
 b=fSQJ2aePXRN+WBj6YVBNHIOlOpJvpoJaULKXXTcjxvFu4b7DTn07pcdG+KxZ92QTwBWLBzpJJ1am5XzXPlzdnpU1y52sMPJxng7GcePdtUMLdT112IdrNG/UhTF0JWzPiIBTDemxJflFVEYd1UowGMBsZaR8di2VRb3D1uLW1W4=
Received: from CY4PR22CA0064.namprd22.prod.outlook.com (2603:10b6:903:ae::26)
 by DM6PR02MB5546.namprd02.prod.outlook.com (2603:10b6:5:35::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 9 Apr
 2020 06:26:23 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ae:cafe::7e) by CY4PR22CA0064.outlook.office365.com
 (2603:10b6:903:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend
 Transport; Thu, 9 Apr 2020 06:26:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 06:26:23
 +0000
Received: from [149.199.38.66] (port=46429 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jMQdR-00086K-Sn; Wed, 08 Apr 2020 23:25:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jMQdq-0004Wo-QA; Wed, 08 Apr 2020 23:26:22 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0396QCGa027217;
        Wed, 8 Apr 2020 23:26:13 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jMQdg-00046h-7C; Wed, 08 Apr 2020 23:26:12 -0700
From:   Raviteja Narayanam <raviteja.narayanam@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Subject: [PATCH v2 0/2] serial: uartps: Add tx_empty checks
Date:   Thu,  9 Apr 2020 11:56:01 +0530
Message-Id: <1586413563-29125-1-git-send-email-raviteja.narayanam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(7696005)(6916009)(47076004)(8676002)(9786002)(107886003)(356004)(6666004)(26005)(81156014)(5660300002)(81166007)(70586007)(316002)(478600001)(4744005)(2616005)(426003)(82740400003)(70206006)(186003)(2906002)(36756003)(44832011)(8936002)(336012)(4326008);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 567a3e74-a6a2-491c-b491-08d7dc4eec94
X-MS-TrafficTypeDiagnostic: DM6PR02MB5546:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5546B66725C8C23346FB8B84CAC10@DM6PR02MB5546.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWfAEwZKz9OLl8dSfhr2ALWUXGK9b9BLHRpUUyax/dHqUWp8twUqUd8Rw1ZjJerfmudRMMD/pQdgSsrV45RKWTrWWBVbz4edi/e5whcZ7jpzOGojYgtlePv865cGt2N8ZvXOG9L9ZDiak/94Z1Ks3SbbItiJOmAm1SoScb24sxmCO9ngRopD43IWgbfoCblnENqLZAj01sywIAOCXom+OTlF/3plIab/w2nrSYHo18a76ur/pD5ZuoXhyeFgrP9Kznp8Cez7ABBHR2ztPn2Fm2RA1VIXyf5280QCFa2d1/pduY9QxfTMqP3Zphouov0VFXRGGDdj/uwkV2ya04DY1lBljP6tRBWZvv82kI5DcMbgOVAzT7RaaOYRQ8w5IUCRHo66saQzutMSV8i4w0gnSqJWWSgkZWkpTT4rEf8QmgfayqiU3Y70VoaMQIPX/zAuw9bcP3+pLAaiuL0OepjlHj1P/nKwzYl1CBRgjuL+NQT61XE6WEPD53o+fW6aLzq+IP/vIcRTqinr40h0oJ5fxg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 06:26:23.0862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567a3e74-a6a2-491c-b491-08d7dc4eec94
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5546
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series does the following:
Use cdns_uart_tx_empty function in the driver.
Wait for empty.

v2:
Modified the wait in console setup and used cdns_uart_tx_empty function
in console_write as suggested by Maarten.

Raviteja Narayanam (2):
  serial: uartps: Wait for tx_empty in console setup
  serial: uartps: Use cdns_uart_tx_empty in console_write

 drivers/tty/serial/xilinx_uartps.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.7.4

