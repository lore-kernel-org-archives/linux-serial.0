Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C1ECAAD5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Aug 2022 12:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiHZMGS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Aug 2022 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiHZMGQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Aug 2022 08:06:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F317052FD6;
        Fri, 26 Aug 2022 05:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1jbW0r26Ilwz+EDG6m9KwOxBofodn5G2CDii8Lr7VM9oy9IuWSH3Sv1rHCNOTQ1gmuzR9PrlpSXdIq+8eXima/aaQH2Cjf4V/SzoxxedzMm0qHCiUebrtkjdLcdpZflHEHvKOIEm6EkzlNpxFhn7KC9C+Ziz6IhboS+Rlp/+wKFQnOfC9bEQK4QQG3mdz/SrlRASM72/wbPVHP+EbT9+rkU+IT1s22UyomS4c0LV8oFtqQ676etH2A8I+g+Ud6hhsdLxKGR2brTq/BSEuFIu+XmPn7biyrZjPjSadxQbVIrb0uodPSzn8yuTIG5bxpk5rvfErPW7KajaCizKi3YFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPzu8dVUrSfrtWN0hqaprjSFhJDHzO3lmmkEWATwOKQ=;
 b=oZ+O2QxibA30f7HZPiT63AqW1/89gNlggN3MgsWV6RdwglzsllKr88OdtRG7ng7IlB9LZVARLhFXf4bbLJuyW9qgEMfUX/zyIqyxiZx9ry67JcR+72MIXElHRKVke4G+lOVld3nh4yR/bUKZ4GDvEOqeAQGuf6So+wxiRBnE1YZRAUnBr4+MCX3066I/ugDLxEeM6yJ8ZY2P3QQGr4KJSJwr7gKAxiKOOqXRHH3fF/GGHeS1QXc+Cg2SqKsEMUa8+Fq+OlSe53ybdMFR2eiL69DQyNI2B+9/ph6JqurMszLUFwkMNKwONjiRZBCFsfue+VgVM6jptFnc3VD87wXndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPzu8dVUrSfrtWN0hqaprjSFhJDHzO3lmmkEWATwOKQ=;
 b=X4CCCwdyfuArgQ4pIoCcFRgaxzFOdKnGdYkfqYZUGnqG0UbMMz7fZXVmo7nIKKCn93qYdHH5Nntp+UPXbrkoTtvE8N9XQwUgmndmBuOVU0MjsHoSJelxx7vh6kmSmS57+FQxJRpif7KAU36aNcRT7OHxJWt0mDbIpf7cSysIPiI=
Received: from DS7PR03CA0228.namprd03.prod.outlook.com (2603:10b6:5:3ba::23)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 12:06:05 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::d9) by DS7PR03CA0228.outlook.office365.com
 (2603:10b6:5:3ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Fri, 26 Aug 2022 12:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 12:06:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 07:06:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 05:06:03 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 26 Aug 2022 07:06:01 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <jirislaby@kernel.org>, <linux@armlinux.org.uk>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH v4 0/2] serial: pl011: Add xilinx uart
Date:   Fri, 26 Aug 2022 17:35:57 +0530
Message-ID: <20220826120559.2122-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb232308-81bc-432e-08f5-08da875b5a26
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5610:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRj2Fkysh19kzBY4z6Qo/xPjJVfRque9jUoYuBEPwTmXK0O2Yqam4wVu4oOyyt9qww2759ueA6fDQ4VqEzpU02JqaGzxQQL2ZoFsgoht7On+4HL4JjA8g4tZYFa6cNRhqZMYc/gfViiDpskhznpBqh2c/Xajd8sohXZYe1Hx1dADsxXN35z9NFw7BlnTyUTu9GN4ZOqPxgKOWCGCtdZIdWgvFm3wXmA3PeR7s4G70mDdvE3pZrBl3bFptycP+hhCKKRvipUduxQdH7CQn1KvnRlMjZxaLN4Q8tsIQU9A+RpZE/OcmX3/jX6r9bIMZuXpTadIb1YAIqp40FdAUZVGhcB4kMV3cHI6dT0kYMAVoFedTAlZgBNEZZOTihQjWFyuLPclZttLEhv/C16SaTzhaW9GAvhdXxLLgXGQDLQ2mmmodSFMZ8VwF+A1DEw1i7kL2Y0TlPXyys5eZI7T4u09viv5onloxdtKIoAZHEBebU7N+99JvVJu3IZSc2UCyZlG1KJT4x4c6Vrw4+fOCFFzFoyl4RFznCxYTrzpnDWswiAPLMAQIj2g+mI7RviiozHiOZ36kB0bhE8sP+ytxhWmMK3gcCXFljvQJ1sOk4TaumXSfJcABY0KlybWp8/+jRyocbtFV21FtrnIVlJIZpJzjnfbCwUttLM9yggz3epoPGq2+nf3dbVYBoU5w+JMT3a6EoPjcFw66grX42YJFgbi8KsQtYD9JiqrrIc9h5T0PrSzHfEbJODLDKWrW2W8MNx8pU2NfW7vOxDMacXaNiIqY/bNCxPs2Naesra4fv104lz0Efx+giWE/AVgs/8BVBOD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(36840700001)(46966006)(40470700004)(26005)(426003)(41300700001)(83380400001)(2906002)(1076003)(2616005)(336012)(186003)(36860700001)(82740400003)(81166007)(40460700003)(47076005)(356005)(40480700001)(86362001)(4326008)(82310400005)(8676002)(70206006)(70586007)(478600001)(8936002)(5660300002)(316002)(36756003)(54906003)(4744005)(6916009)(6666004)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 12:06:04.9468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb232308-81bc-432e-08f5-08da875b5a26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-Support uart peripheral in Xilinx Versal SOC.
Add parameter reg-io-width.
Add the dt-binding for the same

v2: 
Update the commit message to reflect the AXI limitation.

v3:
Add reg-io-width.

v4:
Fix the binding comments

Shubhrajyoti Datta (2):
  dt-bindings: serial: pl011: Add a reg-io-width parameter
  serial: pl011: Add reg-io-width parameters

 .../devicetree/bindings/serial/pl011.yaml        |  6 ++++++
 drivers/tty/serial/amba-pl011.c                  | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.17.1

