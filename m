Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F8FC432BE
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355DE61037
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbhHZTXJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:23:09 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:10016
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243356AbhHZTXJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Aug 2021 15:23:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGNh9EuUYsZtv5fDDNX23xEg8BuWok2pMpUN7BEWCed8aiGdFa/Pu32HMkhUQeiH4xIoBtFN1gRDT19EeNsgqjq1pU8fsQ1yUB6SnTQTkAFWpBQCzrlEMxUxeFaQD61zO4nVfqA4BBOLv8/KaFttRfOyV2y8mH4iVUpU7xJjJWla06sqG0a7ZplDMv9srGHyZaEhYJfoARiD0il44wCybsJspzl+dugPrKP3UWHAj0dGZ5kvzl6nC5LO/zfrpMk5gyRVVDlWp2qgCHSvZpnarW5Cb8PjCd84yqNlaWiRnvwY3WVqGjx/WvaE3a6Wv+/ge4zhdX6k90kAlsg820vRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uWZ9CfbQNyHLva/vkGrfYmIwP3/toXaJz3rcXogjBM=;
 b=DjDCKqfTHaczC9rpkJfx0h2Bh/uDvxSmON3Fpyt2ubXIkPoaCjoWORw3HPordW8wKoaGuTuBzh017saSdPeIjIv9OZIZFCHzBVNJb1HVLcunK6avaIMhbsUxLMpRx+Ii9mEzMgj2+vi+sRfuiQAJmHMOcGR/FdxjWFqjWEitOuT0hFtsDGL9Tz98nvjk3nxo0lsNF+wxEkj6VqPXMmF40jntf62kz42rHZiEffP9yfKuri8uoUfNPv6H0Vb2YC/NbmK3LOe0AI0R2zd+kb08iw6qlbXjNKutuaZXrwieJsio0c5Lx/v355Fx61Nzx+9u7rN2oLFexn5Dnk9yER361Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uWZ9CfbQNyHLva/vkGrfYmIwP3/toXaJz3rcXogjBM=;
 b=GDjMz4GU9NGNAJibPq5c1CmTTlE/2tRd76HpFirrldzsx+QPY/Gvo/CILJNH+f0bEfHzZ0VjELRU2QSbMQ3JfGB5+1q3K7evv7RUxTFoG/fo+LGask/OciqLR6LA8/vx29v8xhDJ2rCXfLBNqZ4eJ13aOkBntCN8oqP/v6eX5eM=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6748.eurprd03.prod.outlook.com (2603:10a6:10:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 19:22:12 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 19:22:12 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/4] tty: serial: uartlite: Disable changing fixed parameters
Date:   Thu, 26 Aug 2021 15:21:50 -0400
Message-Id: <20210826192154.3202269-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:208:257::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0046.namprd13.prod.outlook.com (2603:10b6:208:257::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Thu, 26 Aug 2021 19:22:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72eda558-a091-4ff7-82e9-08d968c6ce2d
X-MS-TrafficTypeDiagnostic: DBBPR03MB6748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB674876AC1382234C0F43778D96C79@DBBPR03MB6748.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InaGx+gmxaxuc3iEzSTusd3I8fr8hqzP2NPEbq9d5H+r146hjKkxeAVbG3ljiSiLbPEgfOwrdySWSYylixCtKQ3fvrhk2XRwtDdhoik9Ec0huxfGQzExIaIzASa7Tg7ppw3OaC+ak5zKXr4uq+O9pNfjoSrlkLmk2C23knX7Z2zk/U4lryLfvqMw7ExRVAmzvGzzg8d0DxElKsPDF9kHWMPWps86VfhQ6NziRjUvSKKgK3NVO6XEyZHRHwi3YPhLZBgq8olTxT0ULtVnfF4IGjHlScKwfjtQ3UJMwlFp2BShzrHVQEMGWWwLOmL15ODC5IwF7RbvuIxoqd6PE91VpaNZLRBLBPO43U3a9DC3TBNVMnF2VVNP4AfDjGXyoywEBdTsgNAsgZO4R8AnED+KZRN0l1hPs6q1eBzZbKE81cds6GAA1VU6UYPO7F0QxQZjJXlEx+LdiQK4K8bbzCoZ6fgIIub6gbACQ/bYO2EWAMVenPHPcuvLWtMB3uW3YfVaetPWWif9XyEgn0Ej3+avCvpH4wjS3XeyfhkCme+aFOzKpuMlzWTnmizwgiAJI2Mobk0KOEFNmtfU/EN3LdwUoAuEBIfO1YtjqlybiddDAssUmv/xzPyV0In6qyy1xAnYfmLtE6eQJqw8w8OlpXe0DG0jXjl1XIxZ2B9z5P409uyc9ueF5x6RdI+w8qHEpnRIG7OGgnFer2YybRxSWQRyvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(366004)(396003)(376002)(83380400001)(6512007)(66476007)(86362001)(478600001)(110136005)(186003)(66556008)(4326008)(54906003)(38100700002)(36756003)(38350700002)(316002)(6486002)(52116002)(8676002)(26005)(6506007)(6666004)(2616005)(44832011)(956004)(5660300002)(66946007)(2906002)(1076003)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmGRqBNsy7AFK75UujNhLIUvfQGtp9kgSsHQhwB+mK1tyNzo1Mo1HfyvNrHF?=
 =?us-ascii?Q?Y2m9SLWOvLx1DStBEbg4b4xjr8SbmxZqM48MgxSXzy6uajIGJPHKmp3snpKa?=
 =?us-ascii?Q?l94TeDY1ybNCbesWBPYICA4P5iKfXLnj9Wq3yqiV863GI7AeCltpyVuimLxF?=
 =?us-ascii?Q?UzrpbU4ARx66NwLcuEIsfglhQ1j9lFZ/V7BuF4h0WT05fId749QAuSaX0LDB?=
 =?us-ascii?Q?cJikRyqbd3XWlS5SrvhM0msNo8F6UepjTIINjLzzu9f/E3ptJWsfu+Qrnkgy?=
 =?us-ascii?Q?LkexvxV0cHtKnj4J7bC9uNpdvyWTAg0xTPG/FfJVFNvnkBsnxDisPKumtrTM?=
 =?us-ascii?Q?EtBozsMErJ3a0R0PmXD7o0j/yulu4JLICBxjvrEookOvhua/9ZRf/zGVsIQK?=
 =?us-ascii?Q?8MI0eQi89MTA36Zo8GLajVVMXlBnds9c2NzDUdtdv+pcpqgrsVNdOdfiSHBi?=
 =?us-ascii?Q?i6EyEYkIj0fYOMVqhL433LnDu3Olou+/W3J5cvOZ0qBkBD5wA3sZ9dX2rTzH?=
 =?us-ascii?Q?M/qngSAkEtwqTgILBXvd344dPrEiGrdMLQXlccZOt9p245/cVEuLe0tLa9qr?=
 =?us-ascii?Q?QTigXOzDWOYplyWqWeo61VwVJ4nDWh2TW1hweXlmIFSG0yygamcqNQeDtjea?=
 =?us-ascii?Q?Vt+Zc2dqgBsDJVOjJhF0L/H/sCnSn3azUC43nC+v9Ew8u1PKO07wsjzBD2Xe?=
 =?us-ascii?Q?/BuwF7CHXWGqaFbD2GliNXPcKhT5mgh01hnl4hq3qF3hIweJgwzahQ6xJLTU?=
 =?us-ascii?Q?GxJ0rsF79qSToSK5NBUa58u5YAfsorUMsQsXZTzCNZ27bYmeYEllSu8pWyfJ?=
 =?us-ascii?Q?61Z0A3iainfCrtwyt8H6TX4rrBw/prcyjV4Odobh5zLMEOfsyqvndifirUHD?=
 =?us-ascii?Q?09wBrGRRW6HrqjJsKDT8C7f8My7/l/U8FzaxGLfVgxlF9wqQP2U71bPM06b8?=
 =?us-ascii?Q?qkUl50XL99kp2ow5ncGA31jys1V995Aww34PW2QHsS4l/s7/nFclxJDCtYdU?=
 =?us-ascii?Q?qWAHD7zECiv9w6wTobINqgBSC4qKzpq4MGq8C4AxSQKo2ozsVui31OplrQY9?=
 =?us-ascii?Q?jqyddwmkWxq/2yIUWoL1wz3imLzXm4C0tkZIPxLs8nR16WLm5/HSWw1kDZqN?=
 =?us-ascii?Q?+8hQ95qvSygOz7vMV4qPvMz/l/nqvMtncfG1Q15gQTxxyj+uJqURwwFVOQLA?=
 =?us-ascii?Q?oIYVWYWBUpXQfHXe1xZxqQtVOMljv8W0surSzxcE9c6dKozu91LKl+1FafnQ?=
 =?us-ascii?Q?6m2o3w40ecgNjh4Kf65t7RDrXZcwt58Uc0AVr4MqhLWMohxZ/lGXB5pumTe/?=
 =?us-ascii?Q?XAQn9TFqlFuL/ZO3AM9poer0?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72eda558-a091-4ff7-82e9-08d968c6ce2d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 19:22:12.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufiTRKGXgVAHKQdpVOgVqmwb0WAY/iGrp7tOQ0T3ZEikHLZejPJDHzEiLwImltuKuuVRpv/nCXvDpgO9QpFwHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6748
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The uartlite device is a "soft" device and certain parameters (such as
data bits, parity, and baud) are configured at synthesis time, and
cannot be discovered at runtime. Fortunately, bindings for this device
typically include some of these parameters (especially baud rate).
Instead of silently letting Linux's termios drift away from what the
hardware is actually doing, make the termios reflect the hardware, and
prevent them from being changed. With this series applied, the user
recieves an error message when they try to change these parameters:

    # stty parity
    stty: standard input: cannot perform all requested operations

Changes in v3:
- Use unevaluatedProperties: false instead of additionalProperties
- Removed defaults for required properties
- Remove warnings about unsupported termios
- Set defaults for xlnx,data-bits and xlnx,use-parity

Changes in v2:
- Compare the baud computed with uart_get_baud_rate to pdata->baud,
  instead of just checking c_cflag. This will catch anything that messes
  with ispeed and ospeed.
- Don't bother trying to set the initial termios. Instead, just skip
  warning if old is NULL.
- Because we no longer use uart_set_options, just convert the devicetree
  properties directly to clflags.

Sean Anderson (4):
  dt-bindings: serial: uartlite: Convert to json-schema
  dt-bindings: serial: uartlite: Add properties for synthesis-time
    parameters
  sh: j2: Update uartlite binding with data and parity properties
  tty: serial: uartlite: Prevent changing fixed parameters

 .../bindings/serial/xlnx,opb-uartlite.txt     | 23 -----
 .../bindings/serial/xlnx,opb-uartlite.yaml    | 90 ++++++++++++++++++
 arch/sh/boot/dts/j2_mimas_v2.dts              |  2 +
 drivers/tty/serial/uartlite.c                 | 91 ++++++++++++++++---
 4 files changed, 172 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
 create mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml

-- 
2.25.1

