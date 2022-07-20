Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16A8C43334
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jul 2022 14:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiGTO0Y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGTO0X (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jul 2022 10:26:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974AB3A488;
        Wed, 20 Jul 2022 07:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS+2NDdew2BUG1ILktHu+OihAwQUb2v2nMovr6mkLon+vA+o4hbT+zWMBM7zKqwhslOkzuiPiPESgaDJ05Wd9dbYyvq+bxxFQWGq8Ycb7OvafL0pZVdywNqox1o5gKLDZ0UvIfwM+ZwIkE8OJgx7rv8Goi5ELosLIbEL+bbU6/2J23SAD/BFO91SPfssRGYR5ZwmCGWB7AtFWjvkm/UBuqnKtou1LRCyaygCcQqCJUDeO9M5xAH/zAI8k++40Jo2NU5mziNj/3V/6lVGdWNIe4IjWFVYI61t5OqLZ/exCK02pk9XqI6bzp/JY05X6ohnQ7EJN7I8hDgUUb59DxG4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb4cM63m45JrwZId0nr/zqGXW/4GoV4GCAACaLcVhG4=;
 b=Utt7TZuV370VU12YMf7RiQJxXm05lWNFZBkT2NIccMOwV767GbYhEBGoBb4wGhMAEptd92gRXq0JT3VlO+yUd0eIym9TcCiR/i8JxLecFlAGsqlcyHXvv/jM44iZ0bCltFNao37CaJW8Q7YwmSNUgDoo28tLDhGfp8cWg7tXoDJaje9USjemrG4RW/jJusweH3sqlgvO1KLvHi3w7j2Ah+wgFVM+72l/1L0tvIOcr39bA5hj+/mOyHvE/Gj66dO4jUnW+NajKRGpBmRSEPKzFHXqQlwhXFzgq4b5Yrk7iA+BJhEavZd97L9Z+hQBE4J3GMUMO8QcteBhnk2/t47hRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb4cM63m45JrwZId0nr/zqGXW/4GoV4GCAACaLcVhG4=;
 b=WZiPvC26gFUNnrHueCMpCSQTWJDuV0QGbY2UVD0pCk1G8ypWUqzK/wz7WmYS5o9KwXQ9ygfnv6UF/lP2bEzdoxSsuvmro92K/USyrzBcthNYrFLhURiJDRhuTkt7O0arlZI50q8sQrBRJzxbvsGiZHvsXBRKpvU2lesBh8bd7bY=
Received: from SN4PR0501CA0001.namprd05.prod.outlook.com
 (2603:10b6:803:40::14) by DM6PR02MB4459.namprd02.prod.outlook.com
 (2603:10b6:5:29::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Wed, 20 Jul
 2022 14:26:17 +0000
Received: from SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::5) by SN4PR0501CA0001.outlook.office365.com
 (2603:10b6:803:40::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.11 via Frontend
 Transport; Wed, 20 Jul 2022 14:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0060.mail.protection.outlook.com (10.97.4.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 14:26:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Jul 2022 07:26:16 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Jul 2022 07:26:16 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 gregkh@linuxfoundation.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.59] (port=55844 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oEAeV-0000jg-BZ; Wed, 20 Jul 2022 07:26:15 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@xilinx.com>, <shubhrajyoti.datta@xilinx.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] serial: pl011: Add xilinx uart
Date:   Wed, 20 Jul 2022 19:56:10 +0530
Message-ID: <20220720142612.19779-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b577f6e-0f16-4426-8b6c-08da6a5bcf23
X-MS-TrafficTypeDiagnostic: DM6PR02MB4459:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbXxSUy5UYpL51nf4h5Ji+yYRLeEvms50gC8FG95eyXSnylZ5J0ZzxIn7Yf+tS5ynMQrxDfC6uK/Bcrw6mBEpv/6Ebxy1kCDKqjXU2NgprQpnK1RCikeMDImGnPaeLH8HtZ4uz13S722RxmJBQV2hFRimI0zbjHQolSkyvddAai2WvfqEBnWKrPQeu/OaIZ102L1u0bftNfdOril3bX8WiOM0RxffTy+ekbVPMosKfE9bVL77ldg8xzUXwes4fZQD0ZZgajXIISnkp9l8ktpUikKPPGIHWBs4qkk9nqmycKf5W1XTMhBhUuFf2Dzc6mzwx25o6aZi5+KoAn9R8WRhTClDDh4mb3U2cdSrT9z9T8p6G7+6aYic1+XOoxilWb19c9QF06ksHyUaty5+6Uvi00Gy6XMOoLm93JA7Dff5eeu0+8IAXCQE4evm0BAhUKcwwDwlSUNEc4XaHNZ78GcAdO951WSF2Fcu++ot2dEApE5ZnYwMw5rvyb7ejWyy1Gf0DxorTIM5jWohFRBLHpC3lC68W/hheDlQSX92PqOSZ51VnV9Mc2TCPaQeEk1dl3yke9Fmo/skCqlvdzsDNm1zLF4jr6jd/VvQP5WApbuPZC2MsCVBUxTFQ9/uUh1yekY7GcVW/hMQGw1/0YjOyvoLsQFjwUf8yl2jMZHmEaplk9tvCmkW8TPlHsQHQkYBqXVGRsg9sinxUc4PWxtB4KyyNsLKhicDGUAdTC8BRlx6rk/3WXFY+Nd+6F3AylizOZT5MpPEa3NbxqMka6+QC9xZZYuD/0Oqy2n5P366lQfGZRrol5xSaAwoD8PRPTU4QQKPK5Tw6Q45P4+akL3OrfkPQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(8676002)(70206006)(70586007)(9786002)(8936002)(4326008)(356005)(316002)(54906003)(4744005)(6916009)(36860700001)(7636003)(36756003)(2906002)(82740400003)(5660300002)(26005)(40480700001)(7696005)(47076005)(41300700001)(6666004)(186003)(2616005)(40460700003)(44832011)(426003)(478600001)(83380400001)(82310400005)(1076003)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 14:26:17.5346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b577f6e-0f16-4426-8b6c-08da6a5bcf23
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4459
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-Support uart peripheral in Xilinx Versal SOC.
Add the dt-binding for the same

v2: 
Update the commit message to reflect the AXI limitation.

Raviteja Narayanam (1):
  serial: pl011: Add support for Xilinx Uart

Shubhrajyoti Datta (1):
  dt-bindings: serial: pl011: Add 'arm,xlnx-uart'

 .../devicetree/bindings/serial/pl011.yaml     | 10 ++++--
 drivers/tty/serial/amba-pl011.c               | 33 +++++++++++++++++--
 2 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.17.1

