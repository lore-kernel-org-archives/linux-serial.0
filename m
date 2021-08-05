Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EE5C4338F
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FF060EE8
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhHEGzL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:55:11 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:23961 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235050AbhHEGzK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 02:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628146495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SOuE3CAg8m7EHm/pql9C0d+QwSCZCi69gDOj9zil+Iw=;
        b=e1HPeRDytimf+TsnTOJJvkayE31LUTuK1FmuPc7JFCiRjMNkDebzmcbUBj4pD4xErZXk51
        Iqs8CZOe5Ti69aViPvl8L+9hvpiu5SHle5BsuZiNBtbx3D5P9Ss8qbOtTh8UzAAK9MHV/i
        mC1/yRcIhonA/6sT0hHef/R09i5TaaY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-KvGEXwZOPCujhTHHI3Rzcg-1; Thu, 05 Aug 2021 08:54:53 +0200
X-MC-Unique: KvGEXwZOPCujhTHHI3Rzcg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaY6FmydatjCmbnFQPWjYMDEiyAR9Nj7YO+EW8smCufzlG04dhLe2ntCaqEIvb9lHbtd0hqt1zgLuRGccn0fTEPQLsI6PsVR/ojjq/YHwF89M3lAZg0UfTA5/Ft9mtkwkkpehifmwdMComL9T0sUWvZsFKdqhwSYj0JU+/E1KyMbeaBmVWPm3YiqW47lL1JQq0rn+BO/paY3Fox+QCz2pvOq3hMpKew3mCPTJLoMGcCBv46BmRzXTF6Du6Vjuol+D3CgCHhE82p2s1UHAXTIKBWcidy4Lr7baXVNeIxK9aRTbxbXlv17hw/WLJbrDihmKwk5BbksPmrnApw+bPrHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzRNSDdCIIn6wmRE4TSNmBTg0vbvPShmuAHeqoy7rig=;
 b=JLyEtkJPIeKGMdp3Tp0tD2x+dFMBSYmzLrMcOWf/ez/3HTSiQLY1IoYwlFgbWp43DbgB2+juoWxGJvCzd4pfP4YOPz/fxgCcbmJOPwoGWbDBiGFGI/qYv4msbzYwJ39RgysloDAV0QzncpB4s2Med0aDFJHHUM9eW8SAciiexothLHJBZeXWWqa1FYlE1kHzybMRMW4t5KnP7FDPoIlogJ41HjXlrz6u4s0WINB5tUqHIbQHBYCJUZKOh/jFCd1O60w9lhGym0foGf/hFHmo9L8pii6Gpc0oqQMcVUIbp5nAWPpYgE9eTM8z9jWej7HB5yraBFjwXrrO/QotHAvlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0401MB2368.eurprd04.prod.outlook.com (2603:10a6:800:29::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 06:54:50 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667%5]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 06:54:50 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s32@nxp.com
CC:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH 0/8] arm64: dts: initial NXP S32G2 support
Date:   Thu,  5 Aug 2021 14:54:21 +0800
Message-ID: <20210805065429.27485-1-clin@suse.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:205:1::21) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (118.166.54.149) by AM4PR07CA0008.eurprd07.prod.outlook.com (2603:10a6:205:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Thu, 5 Aug 2021 06:54:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8a7a140-3bf4-4a06-fce9-08d957ddebc0
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB236839B16D3F6F5C7FD1AD12ADF29@VI1PR0401MB2368.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tp4qgogmG8Mf5CfvR/p66zWik6XpQt9J213CXs/W3a9masGoX2PPoP2HguzSAJsCThfJQHc60s8EiZtw2ASYqd8wOn7n6b5B0ird7otm2KMRvBH6n8coCcdeJ2NuW3s3t7tCZf+xFZyN+ewxwUXaahouy5PtAP9hukeHJUVFvU9V7WdSkaQv9G42kekA0dVlMoXC4xFSAdvguqFHar2kEGB6BZa1ng3FSuKVYx+eLQq3RkcK1RaBeI3A1GoIX0UpAsJZURpdsIgqkzuhC0WlHqrj09t6uS7Z0zYBBxqMNdtNyh+8C5d82nGICoIDBTaCD1VWBprZbgnJvijpkz+t/syYgFQPwIglTTL2rm1Dpjp6kWdFDseTnpjE1Lf5oITDghoIW5JL1eMtGY05lj2SRXXbhRtnWNuESMr7oOqx+n/71iXZdVRo9q7lUQw5CObrACDJmgnzb0RIoEy/ACUI3+AHWbs16V+Is0SHoYy9daLHMh2l7erjEuBDaA5OC9hbUIijfqC2GFkdbH9b3uo2yk750aa5YnjGXL/Fd/LVw0/HXVwFCahj14gGorohmdvUMLrQOgyDOd1NlgfsuYQjpRXfw1KV/6avawUucipdqnnaecwF4Bq/GpohuAAH9xJM8Gpl4tOMkUTC1MDKow+ALUuukFlW+tZSQ/OvADxbbVwwN+RMPymMGuKgoitPr3Ga9GbqQ81ssPV4ff11iDhqqA/jqh1BwCTVXg/cYwRaYcNE3XMUysas2KzjV4rTKgpqE8o0uEePjfoLor//2LNP4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(6666004)(8936002)(66946007)(66476007)(66556008)(966005)(956004)(2616005)(508600001)(83380400001)(1076003)(5660300002)(26005)(4326008)(7416002)(6486002)(186003)(36756003)(107886003)(2906002)(54906003)(38100700002)(55236004)(110136005)(316002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LpQzKP6/WoBz81LoFr0m4vbVozMIb9s06K5pSVgMCI9u58ioeLSzWtgUaNvk?=
 =?us-ascii?Q?c5G11iUrBKSF9tTe7JOUwAlNvlf0EBlyBIzmVc9kCz3GKRJ8gAQazOtRBgME?=
 =?us-ascii?Q?4mXlf878zRoCbnGPihNSdz3RbqZLizuuNdpDV9pfo53VgNIC2bzCzC0at1+p?=
 =?us-ascii?Q?EN4Zzk1u2S1ffh3gk/O1LGR/Vk/+SXTqbh9CitXLCBZ1CTsTUtDrCx1+SVHa?=
 =?us-ascii?Q?BqBosYDzQbQbbVmpXVf76VXc9qg/yybJYlR0UTysREltynJrPgwjF1i4EUAV?=
 =?us-ascii?Q?bfrPNvles5LHXx17kIFKBKcYmH5tt1nKVaUrOAjkF5ZvEEM/WjXJiH9C7cQ9?=
 =?us-ascii?Q?QJj8c0FW30t2iEDZy0jr340KQncNkXcZlCgcvdzBC5ICGLU8XMY6FvwyAlxn?=
 =?us-ascii?Q?+q6tdEuf3D/Q+4VTGjJhGYmrOqQ4ASP8USq94rMENB3gM/feyOLtvjXApsJk?=
 =?us-ascii?Q?VH3yDjs8s0qGjWCHVmXUOYYRiOWv+8gpTbSCQ+gHNPfR7W+KtmV6500o0eTF?=
 =?us-ascii?Q?n4I+0wJknbMI7GEUOvxr2Wpu0dhBrCExBHPAzI/+bw9lXZ96ok8cNYboM3O0?=
 =?us-ascii?Q?ymQRYKtHr3agmCajRD1LpvggAlN1NTqWtB/VN8qQ3qEW9vxlq/FcTZvcr39N?=
 =?us-ascii?Q?0G7m8sqgYx+Aipeefetv3OVHbZ/fLMW/oSySTBoj44EAHpE0RL/9X0QwSVoV?=
 =?us-ascii?Q?JcWCLhmCGESGCObStSRbmB3v6uuR4d/+IVLLj9pCk7aIjnLwcZaygwL7Xvgy?=
 =?us-ascii?Q?oLRejMXY/tgMvSXf6EWYJUNXItSnkWiReMIsMYqpXmKQ74CD/BvjWedgc4YT?=
 =?us-ascii?Q?XMsJ6+Dfdq5tOaql8j+TgP5SAwln/cPhy+DxYxxCsMbeU25ZrHhbZkb6qXTq?=
 =?us-ascii?Q?uWfXe8c+/XjS/F0DLnKZvP5qeHL5g+Q8pdInMuwmkj5zhKwtp//Ik4h6U8BZ?=
 =?us-ascii?Q?XkSuOUced4lPptaJGJgS0cYvFehp9QmAEJX2pwV/KZUba4WH06W1RRBU4WkT?=
 =?us-ascii?Q?Qzl/qIgZJBKwmjKqxFmBvVnLFinni+zJBv+20cjyAbQqcxFTnY0Zwuo9AkKZ?=
 =?us-ascii?Q?aJENiQeZ7o5scXfWuDMO3yzx72hbv2iII/V0Z9yQvogp4r2fTOKmHSGNt2wp?=
 =?us-ascii?Q?K2HIlAUhBpD23JdQXKHKGNre3B7eicwMU7oL4qmm5WlPUP4AKdxHrzkDaX0Q?=
 =?us-ascii?Q?i8kFPUGjid2/n2SpbfC5pRICd1omd7LBAkRZAWQudhYTjAx3wCaAYq3d/0Ig?=
 =?us-ascii?Q?AFbLaZtaiYotherrzKfdwvfMkNujK0LjHtNNDQf1CPXDDH+bCJNGdW9N7m16?=
 =?us-ascii?Q?jxmiG/14n5Ehh8JLDSisjdce?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a7a140-3bf4-4a06-fce9-08d957ddebc0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:54:50.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rK8Icl1pn7iao+OqPmkPFwkHjRUieiTrAM/MfcN2P0hc/Kq6Mi9exscAzuoJpYqv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2368
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

Chester Lin (8):
  dt-bindings: arm: fsl: add NXP S32G2 boards
  dt-bindings: serial: fsl-linflexuart: convert to json-schema format
  dt-bindings: serial: fsl-linflexuart: Add compatible for S32G2
  arm64: dts: add NXP S32G2 support
  arm64: dts: s32g2: add serial/uart support
  arm64: dts: s32g2: add VNP-EVB and VNP-RDB2 support
  arm64: dts: s32g2: add memory nodes for evb and rdb2
  MAINTAINERS: Add an entry for NXP S32G2 boards

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 .../bindings/serial/fsl,s32-linflexuart.txt   |  22 ---
 .../bindings/serial/fsl,s32-linflexuart.yaml  |  66 +++++++++
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 129 ++++++++++++++++++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |  29 ++++
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  33 +++++
 8 files changed, 272 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/s32g2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-evb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts

--=20
2.30.0

