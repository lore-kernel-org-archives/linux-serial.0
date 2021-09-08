Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A9FC433EF
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71EF61104
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbhIHGrI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:47:08 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:27779 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234658AbhIHGrI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Sep 2021 02:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631083560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=96XUoOOR+n8URO+VbxQ15UyVfC9VmW9gnfdIEBGaxVI=;
        b=EECZjVM7vSOo/T+ALfkgWQ6LZUWb5LgjniU55eMDaz4ZKK1TFEt3SLhV36WeBYAASv68BT
        4QGgvl5zxoOhKEYWhwSMB4L2QaL73Tc70hEz20q2kIaSKG6HZD5yzZxwidI5rzf5t3+r5b
        +qYN19HEd5CARu9vI/0B1JC9V8XrUvI=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-qC-11fIMPlKq9Zh6N4Vm8Q-1; Wed, 08 Sep 2021 08:45:59 +0200
X-MC-Unique: qC-11fIMPlKq9Zh6N4Vm8Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgVxYsgW2ukFKlfQEw/w3QazIYvsnMyPwRh+cqxnkbruMH78ahHySJbQWK3dL3FHz6Ly0DsjKCLSICqeCI0J2KX9Vt0xGHkZxUjRMV5+FPo8xvhgtn9HwBW/wftKkJ/mo80RQVZON8R4+KricGPD7mSNk0lzqjVtj8spXYedf/JwPAqsvHe9wmhRWvMX0V+LRCMQmQRO8pOzpJvLbRoWD3tdeuE5dx97RvpOuAb3GzdOrUeiBFK7d+OWDUbgdEZKti7YZbk3oMReBrFs5v2zZqHIdQ8A8zaKCYxsCHejvTnGs04ipTH7SWzcZGpgwxEbPMvG9HIFKPJI09R9CNjlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EuKQjVZEFVoqMyl70j1cENi71otdqBRnDeIRT6J1lc0=;
 b=mU/YFeHO3JfXOiYBFPyfDp+lc2pKM+UXafGvGqq7pqz/p3qZIY66/6IRTPWsFL3WJJhza0uU2e8MDSwafUhyPEHOX8TalJnyJr+7sh19VNs800Ba/XfOQGqZWA6q/7dAAseUbFa+4kT9X+M1hv6ktFdIlZ+jxlKWS1tHmfkWu0P8FOmslmz6zFKNGxMVyJrK48ekCmZt6xoZfDJeC8Q2Fl+tWl2QsCty43FdOfPsPtQvPRLeVga1o2suaRAhpYaF/X+j46oWhY0TIhGyLDSHwOjzQl92GBJZbHTK0tCwwNFRNSllEPXasLBHIrsAQzZc3bYfM8iUUa5CtlwGR7pHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4000.eurprd04.prod.outlook.com (2603:10a6:803:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 06:45:56 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 06:45:56 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s32@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>
CC:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        ghennadi.procopciuc@nxp.com, "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH v2 0/8] arm64: dts: initial NXP S32G2 support
Date:   Wed,  8 Sep 2021 14:45:20 +0800
Message-ID: <20210908064528.922-1-clin@suse.com>
X-Mailer: git-send-email 2.30.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR03CA0032.eurprd03.prod.outlook.com
 (2603:10a6:208:14::45) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (36.224.129.215) by AM0PR03CA0032.eurprd03.prod.outlook.com (2603:10a6:208:14::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:45:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07bef97b-b25b-4b4e-6c1c-08d972944ee5
X-MS-TrafficTypeDiagnostic: VI1PR04MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB400062A82FAD715E50C6F1DEADD49@VI1PR04MB4000.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PSroSdVfZBQNsfL905Wt2qSZTBfVCwEpAh1jombNnxNXzcFkzh9NLK7PquBntdG3zwSy4NdxI6u6Q0wrFLrRL/kNQ+ZTzDj9MqhFB7h09AnfOfiEYj6bztGimGWubtKXtMqRqfFsoKElDJVe1Xu4bnKm9/1k/qkoh35/S3enPsMNPlhAtLa6iwUUmWh6BxBTMHqknRL8fd4BXb32pVSuQLvbg46+uTi5EvPV0ufcNjmAJ5S50SUu3SQcflBsK3q3gN0Y37uYZkvZZjTe5vB6KiyYk4lV0kUYxwZp9CF+ZM7JGbuUxAyksazJmMTnKiXQhnjzx29p58b0TvirVHFcoB3YQtRGYApt0BLad/t4SL2Q8mrrGQRHfu56JCsRDPsSmh9LoYB1CqAbrMs7bGg4ihygvm79d0Dpl9BBGk0AtvYuGjfL6CzbXrdf/EU4H3aTWtpNLY/+DQj04UKWN1ZtpC4xW317vqUTgXqGrlcbn+StlsJ5RqXZJXltR4H6FJQj4CSUIL2TOZN6aN6s6+Wc6arUe8bV+fqsfmjbnqCzOY+SMGKtqB0me60tiuGJ8rx6viSu2DEyWeElFNyJUy7MwVueOlrbeOBUTSGnYhWnbkXqpnnjxOHtpU4NhXO7i38vdJCQqWdWzKazev/GZNwYHwDX2hxp8FbJoDTaEi8Hxafr0BoFEe+oOO73LVEZzHbLJEljv0YbTIWuGk0a52AjaGgpUPsPu80NA/SMMtpKCmyANPl3iJ/xSXTfgCmXwnOfpHwV1WAgjJXstpcrZyJHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(66946007)(38100700002)(66556008)(66476007)(86362001)(7416002)(478600001)(2906002)(8936002)(83380400001)(2616005)(110136005)(186003)(5660300002)(6486002)(54906003)(107886003)(8676002)(36756003)(1076003)(26005)(6496006)(921005)(966005)(956004)(316002)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kMwZZkRQ4KIrlK+lxpjSOJo2BzP48Gyl5U8/yJKZutMOXkuBiHW63b6rK2BX?=
 =?us-ascii?Q?kzfussxwZ9uAu1h2mZ8p/0NSDiMrJL8nPP8WtQe0+grHqpS2SUWgt8zuxZ06?=
 =?us-ascii?Q?vAlc6lR/2jYsUXvbOG+HbT6Uyg1ZBnZJFuYW3hJRKHO9DIxPHSpRafb15jGu?=
 =?us-ascii?Q?ZpPD9s3g6tk5DmOAdvTZi3yyqz5lnD+MuKXAgMq7j++GHJQyh0+02JDvyRjf?=
 =?us-ascii?Q?QqmPeJxDpS0ZfAMDCmeWsKWoXOTL+6hK9WBcLPOU/AY6ySm4r5IszzsjW6Eo?=
 =?us-ascii?Q?7fSj6Pr6SCCGLJpwNBtln6gUs0jdjvUA5mnk5cIb4eu9+l3Sc/uJN6M+Z6Un?=
 =?us-ascii?Q?zsl6mjNuA0sV50hnfI3mfjiMPCtZTohPQVUtLEp4VCyfs2yBseD7oWMj7nHa?=
 =?us-ascii?Q?79D6y3u6c9e92rN5PbEPuVhrNJJj851b5BImJj4yyyFgVp6H4/YsAngJVxZA?=
 =?us-ascii?Q?Z7q3FFt7/7B3QmJzbGINo2Ijf2M7WwXU8PhvWcImjqXKl4n3lGz6JIWmbzHU?=
 =?us-ascii?Q?mVzCg+eD8TdfOYL9shtaYc2vezbsHPg0qIESVsffl8n7DkRGYZVKcVqcEZvE?=
 =?us-ascii?Q?5SJdn7Ww3TABR5FKSoekUZ2XlHsYkWLNFLEUj/cGi8H6kH8I2f48oV98Y31y?=
 =?us-ascii?Q?ID9ZJBn99HZ3vD3eK5p6bbAmXALBpBoxSNUevu+JPYhAgjvKusW/WtgtQIQ0?=
 =?us-ascii?Q?YOwjTEH7fB3pZpeQGNSuSOQbJ8SGb09thQRO8cmUUBMOu6HJlRp2X7k3+5g9?=
 =?us-ascii?Q?/HlTL9px37B0k27mbhpkC5cLO3q0tpSU45WO9wD6dA8meYYImsyvAXPalMid?=
 =?us-ascii?Q?vbrp4uYM1LjqX5KY9MbGZpy1iL/INjrSinO5tuhxGMjSsPWTgosDFkHUt5sS?=
 =?us-ascii?Q?1m4j0s+RAfrrEPAlbZPrM+gUVCYU3/uwgQ2ubXn6va95NIDT+ZmhedjKZBMc?=
 =?us-ascii?Q?b7JhXmaUWWiMM2oH5DlZ5N6PVU2rU4RxumIEKcxNtpQVMsD/mqYbKTgPTYEJ?=
 =?us-ascii?Q?y0nEb/BOHIgsc6r4CZcfgrwQk9uH2aDH07vrUFzCpwyzObaDiwijv6DFnkgS?=
 =?us-ascii?Q?WpseD8vrbGu+cjctLNkRBXjMC99HmWRJwhinYmCpVgau+KM4u3MvEYxcT8Z9?=
 =?us-ascii?Q?gzYmi9Irv1YSYTUAlUY9CKjpqQvrT6yhld5l4DbuarkX7jAAA8ORedzq1SyL?=
 =?us-ascii?Q?RYT/HvdTphPYHX0DvYDW+JUDNv8nPpZJ4bilXWjXZSptP4WIcin+1yuLWb9G?=
 =?us-ascii?Q?IhMBOQ7lywb+6kq70v9t1uB+PnrgY1EUfqCX4DsuChE53yAaNr30KhrEHVJ7?=
 =?us-ascii?Q?A1aKIDXn5xWIZEBtpYwyXm4R?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bef97b-b25b-4b4e-6c1c-08d972944ee5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:45:56.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hlizc3gyy4Kj9cFGdjOhQd0IiEGPKqrRFAI0/ZasEpl4sKWK+qqVKVkdlmYNukd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4000
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

Here I'd like to propose a patchset, which is initial upstream support for =
NXP
S32G2. S32G is a processor family developed by NXP for automotive solutions=
,
such as vehicle networking and automotive high-performance processing. This
series focuses on S32G2, which is the latest generation we can find at the
moment. As the first round to support S32G2, this patchset only enables bas=
ic
components and interfaces the SoC must have while kernel booting, which aim=
s
to have minimum hardware enablement for these two boards, S32G-VNP-EVB and
S32G-VNP-RDB2. The concepts of how these boards work are originated from th=
e
downstream kernel tree[1] developed by NXP, which provides lots of details
about the SoC S32G274A and its integrated boards. This series has been
verified with downstream ATF[2] & U-Boot[3] based on the ATF boot flow.

Thanks,
Chester

[1] https://source.codeaurora.org/external/autobsps32/linux/
[2] https://source.codeaurora.org/external/autobsps32/arm-trusted-firmware/
[3] https://source.codeaurora.org/external/autobsps32/u-boot/

Changes in v2:
- dt-bindings:
  - Rename the compatible vendor string to "nxp," for s32g2.
  - Drop the specific description "S32V234 SoC".
  - Fill my name in the maintainer field. I tried to contact the authors
    of fsl,s32-linflexuart.txt but got no response.
  - Remove redundant minItems/maxItems from compatible properties.
  - Remove the redundant example from fsl,s32-linflexuart.yaml.
- dtsi/dts:
  - Add a SoC description in s32g2.dtsi.
  - Add an interrupt-affinity to the pmu node.
  - Move the psci node into the "/firmware" node.
  - Remove the redundant properties and white lines in DT.
  - Remove the wrong interrupt specifier from the gic node.
  - Specify the range and cell-size of /soc [0 - 4 GiB].
  - Correct the reserved size of GICR to 512Kbytes [0x80000].
  - Add new Signed-off-by to the DT uart patch.
  - Fix copyright strings.
  - Revise reg properties based on new cell-size.
  - Move the serial/uart aliases from the SoC .dtsi to board .dts files.
  - Correct the model string of RDB2.
  - Add comments for the uart markings on PCB.
  - Adjust RAM size comments of memory nodes.
  - Convert reg addresses of memory nodes into hex format.
- MAINTAINERS
  - Add information of reviewers.

Chester Lin (8):
  dt-bindings: arm: fsl: add NXP S32G2 boards
  dt-bindings: serial: fsl-linflexuart: convert to json-schema format
  dt-bindings: serial: fsl-linflexuart: add compatible for S32G2
  arm64: dts: add NXP S32G2 support
  arm64: dts: s32g2: add serial/uart support
  arm64: dts: s32g2: add VNP-EVB and VNP-RDB2 support
  arm64: dts: s32g2: add memory nodes for evb and rdb2
  MAINTAINERS: add an entry for NXP S32G boards

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 .../bindings/serial/fsl,s32-linflexuart.txt   |  22 ----
 .../bindings/serial/fsl,s32-linflexuart.yaml  |  48 +++++++
 MAINTAINERS                                   |   9 ++
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 124 ++++++++++++++++++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |  34 +++++
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  40 ++++++
 8 files changed, 264 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/s32g2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-evb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts

--=20
2.30.0

