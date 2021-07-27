Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6542CC4338F
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DE860F9C
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhG0WSN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:18:13 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:30900
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232171AbhG0WSN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Jul 2021 18:18:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ+FHUlSh8wtkDJCuzJWSXk/duma/0V4EqgmUbU6vlNu6oX1sQEEqkCtUQ2sDs56ROHi2GfolOIDw7RQwuWU1xzaJpQCU6j1ISsTgAQHE+iXGQa3g9L7LZqQNF8GivmPVhMTCE5iIqlBiONMlpWFiUyajWpA0wosFTYvi1HqRKTaWQQG5vLLNITfZm9aw0h3jM5KyXP2sG1VehKOYKmlXQ/2g4zZDLzZKYN7+I5KyiJuMz9i3pmozYpY+ovm9AUmcaMlD5sWWseprHYHokIBbEGu57EmgvhNYm8n7+fX4MdcQT9fpLRNMoOv3FqcUdTToQV11UV5qchOW1g7Nnqucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF+hw+8p95CK8ODvtkuM9nJbnX0nd15+xFfAXdBqsXY=;
 b=HE+vczLJNIp8/RWNNyHQEBLNn1UZbjk0AoWgODQbI+4zEZznculYbm2YU8oJ3aRAuKShL2uKtTovuFhvITd/5h+yIxjEdPcR86kTTSI84A21APdoqX5tAjj/2DiCMm+4aI74ncJMuqExgVpTrbExoXbrcLpCbVELzGnlIO4M0kFSWnuPE6aDTDMxQTcLOtTcvcJPu+xcz5yMHvREsinfH0BJUIrWsu0pNa6nIbi9tuNCK9ne+ccE7frZxHHeHQwPaBbkhowQuEUVzr45IHmQ67JN5YHWCua6bGqJfJtYK/AUSuP719LNkenT62C/A78+GSBoU/hmgVjMWhdiC6hgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF+hw+8p95CK8ODvtkuM9nJbnX0nd15+xFfAXdBqsXY=;
 b=HuABlwOkJmLq/q5PVmQq1ZglQLB5xohUKbbMRwzjjNKcCeOBzyEikF+xlbzmJPpwjf9osemxBHdvLTrLuxLNHmjf/wYBm+oCPVnqhMkRsHdj4yuHqabEgETU8wbkBXMvc6oDhQUe+t7815R9HOHd5dZLwdOVdXYDydPYqmlVy3I=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5141.eurprd03.prod.outlook.com (2603:10a6:10:f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 22:18:08 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.032; Tue, 27 Jul 2021
 22:18:08 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] tty: serial: uartlite: Disable changing fixed parameters
Date:   Tue, 27 Jul 2021 18:17:36 -0400
Message-Id: <20210727221740.1997731-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR06CA0008.namprd06.prod.outlook.com (2603:10b6:208:23d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 22:18:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84e8d66-2412-480c-98c7-08d9514c69dc
X-MS-TrafficTypeDiagnostic: DBBPR03MB5141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB5141BF0B1F2EC784B9A6927196E99@DBBPR03MB5141.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0jlWKpvFg1aeHybn0VRVVL/GsQ2mTzArRQbsG/OHp7CiQMvOVkV37oqart3k7PMQqoDzrdLBEozDRien+ykm0Et7guJrTNb6NmZNdvvkwbol/tviIbOo7b0uh15uKnmSldLMj+by2eSNL9fLdBwV7pN+4N31HXhUrNn94qBN1ZA+RWwwJ0hGwp4cG5KN9VVOIK9ejxerFWg2IF1ARocdpGSZPzGcsBwJodksa/Of2JTBbEZ4LYYt7BMn4f6gvChxCXoGJiuoLDXDZ42MUqy7WFYdkmhRnwyOelZ/Bu6dYN5xseg1w16suNyDPgrrz3emjIIal+x5rF3euq0QewXuIEvXhN+awdBLwQORcnZRK/F8bm8kfUxvwBSnXiv31lNnT8G9+nhihStt+jzhf9w4j4YX2bO+SMXa4B9jeLyo3zP7PS4CVp14IRU2RY/75Ngaj/QViUdmicJf9lwbFTKFIbTjRlEA+MNRtDtwo7i+LqSf0sRZhsllAmaPXDQ1giSBersfclRcm9kdrMjD2IdOYma3hnHG5SROe9hqVzwwEV4VDVBzRIynJbfoIsT7bc7kIBTqg/jlGBJ4+wDFjbIc6kzZmpHqd9uTVyaguOklT+wB0zWGvzAS+r4kAabvb9VKWo+1SsLMNS5MUghi0JO1Ed9UNayoHgoFZspzf9ZfDPN+QCy98ZsGBb8TcZWd057eKwQeri0wAzShWCzFVy8Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39830400003)(346002)(366004)(8936002)(38100700002)(38350700002)(66946007)(1076003)(6666004)(316002)(44832011)(86362001)(26005)(6486002)(4326008)(956004)(186003)(6506007)(5660300002)(54906003)(110136005)(2616005)(83380400001)(66556008)(66476007)(7416002)(36756003)(2906002)(478600001)(52116002)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8mJPkf0b8Afye9P9ngFdLiW4GqmXo/Ybx+43t9P3ihVfF/PbdDUIr7CVFIR?=
 =?us-ascii?Q?8sUfFmQ+1r7SoKVboUssOIhTgw9fB74iltzGe9wZGOIsWaqPGXCFxq3M88Yy?=
 =?us-ascii?Q?YClD1ddT+H4jTIjMQMlfSqMd68Fep8ktPU8yzBLN3T5eM2hwh3YNdzBCAvjO?=
 =?us-ascii?Q?/Kj/srnR6nsCY5vUCCl/HaKZCCEsD8IcC4tRCQD21H+Fgv390GLTgqVzQTWC?=
 =?us-ascii?Q?IM/I3ENtKCg0rmRYks4zRf0QrfjhDuk3tbQwisfgrpuQ6YrTyFqEW6A1gEhd?=
 =?us-ascii?Q?B3blXuHcqFlyxs9cDjKdxl6J+YWFgU+e3A+ZD04NmvaYmApUOwQqOqFq1qNn?=
 =?us-ascii?Q?0wnJOj7qwGb6Zno7u7QO91Fyi3e13jCOgcaewDMHXI/C6ZEqWiIdUsPRzI9w?=
 =?us-ascii?Q?PyYxoBCfEcGdX+YTvX8RyFvFGhXAUVVQTTtvyzmUQRnhQ6zry64K1AoT6luJ?=
 =?us-ascii?Q?LD+cqQaoaG5ROXVXso//SdczpamSvOrJ1DeZiX6oPPIo2bq+a9xVkMycrViN?=
 =?us-ascii?Q?YkGAsAB55iNMC4J4TaaAwZEfrNNJx7ppZK1WrF9tsBL8EU292C6WlYivg7fm?=
 =?us-ascii?Q?MxhRPFOw/n5ZesIqgczQUyPsAQN41shFR4vLLe+ypkOhdxqI4oWMcARrbWfX?=
 =?us-ascii?Q?lCNwtOl/Sc39Y7pqv173Ir1PjEjJXWG+SmGxdax3zc83zx423s/a1hDS7DiE?=
 =?us-ascii?Q?c/8iH7XJop8KPWS/8eALJJCmQArdYuGbukg0p/9v6gLnNvU2G4NfTfu5Qdpd?=
 =?us-ascii?Q?gGft/Wp0T0F0dunOR4J377LMkPKqWD2HlE5gjxKTrUxiAQGhx6VMf3NGAE4H?=
 =?us-ascii?Q?D/VNkmutCjB+bVa1Bz3FPatQyi5zHwucWRVNHId5u3qYMotutyK8KukDFmWe?=
 =?us-ascii?Q?BBUIWhQ0hzI6JalaQ5KrwJIuhdYiFLP+WVzWhX3mkwefb656kYu0v28zg3ON?=
 =?us-ascii?Q?HaSYjyBwQ2X4q/AYiFf6gLopXsxLZX+3hKiZKshBAWqM7YXSZAoOZm6W+bzY?=
 =?us-ascii?Q?P258lns277G6GBt+0bn/qNB6xPRR8bgMGQsBMINcTVAr+f5xcAR4OdOybs8I?=
 =?us-ascii?Q?VVEekTH8nRu+fAW6SGig9D0d3OCvDwXbqHHKfjN6olRlxa8TTzjMuStGms6U?=
 =?us-ascii?Q?RU5wz+bbBpNNng9bpuEgNjSzwsmgAO70zfYbaOBt2q5TbxPaJX5pcLS2titS?=
 =?us-ascii?Q?8rs0awY84S269DEKUCYA+j5RgqG1u0M+Fsmd2o7iRrimU88QMiCW85B5O5XK?=
 =?us-ascii?Q?PoiKzWGpc+4bGzG2eIgwTwIZENgSfJw5UklV7ysgoG1ai+6NaJnltAyhccYZ?=
 =?us-ascii?Q?GHvFciPtM9rT71PYphOX4fMo?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84e8d66-2412-480c-98c7-08d9514c69dc
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:18:08.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kxa5WPjcb/JEC0CxWYuE97EapZVGjOLdAwyShr7HywX7+p0WJRoPys/GaQznk550BMz3JMQR3z74DW1HaykipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5141
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
recieves an error message the first time they try and change these
termios:

    # stty parity
    [    7.221696] uartlite 84000000.serial: only 'n' parity supported
    [    7.222139] uartlite 84000000.serial: only 8 data bits supported
    stty: standard input: cannot perform all requested operations

In addition, the configured baud/parity/bits/etc. are exposed through
the standard termios ioctls, instead of using the default termios for
unconfigured ttys.

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

 .../bindings/serial/xlnx,opb-uartlite.txt     |  23 ----
 .../bindings/serial/xlnx,opb-uartlite.yaml    |  92 ++++++++++++++
 arch/sh/boot/dts/j2_mimas_v2.dts              |   2 +
 drivers/tty/serial/uartlite.c                 | 120 ++++++++++++++++--
 4 files changed, 203 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
 create mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml

-- 
2.25.1

