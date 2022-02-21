Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0CEC433FE
	for <linux-serial@archiver.kernel.org>; Mon, 21 Feb 2022 11:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355764AbiBULRR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:17:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356340AbiBULQ0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Feb 2022 06:16:26 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1657E019
        for <linux-serial@vger.kernel.org>; Mon, 21 Feb 2022 02:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1645441081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A59/DCztyWyzNgQ/wHkqQ5Zrjg2ROP9ly2YMhz8oVCk=;
        b=ApJETYhgK0oXYNESqwv85NfYCNPrl34+o9SNOPHnzyat/V0kBQttom/zYfcoNlZy4DB0Lp
        G/Y1N9rE4MEPpJhcGrqD5men2M2nmV1rb4XMixtQIEQktBuQ9+60ALDvzXt1153tpdWNyB
        JuQE/av2gvRXnZy4Uvwc+derPTbqocQ=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2058.outbound.protection.outlook.com [104.47.21.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-27-rEKKXXNwPH2_Xo-1FWvXpg-1; Mon, 21 Feb 2022 10:56:50 +0000
X-MC-Unique: rEKKXXNwPH2_Xo-1FWvXpg-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 10:56:49 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%8]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 10:56:49 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     linux-serial@vger.kernel.org
CC:     Phil Elwell <phil@raspberrypi.com>,
        Daniel Mack <daniel@zonque.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH 0/6] sc16is7xx: Hardware flow control fixes
Date:   Mon, 21 Feb 2022 11:56:12 +0100
Message-ID: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca0aa08a-f4c0-4d70-5eff-08d9f528dc0a
X-MS-TrafficTypeDiagnostic: CWLP123MB6574:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB6574097DFE798D9BFBA063CE923A9@CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: tvKWhIzatnjB9O6TFGeeJhi/fajf4Jlewza+SQHu+gQIlZSliqvyiQ+MqHLg0SgPdWPQ3Fs/ui6+mi6MPLfSB+NwQCXqAu6hus4S9ha4/3huK5Om4Dh7uRsH7ixTrWK/zOxg7v/qy9UKzqVZxWQ4/lcDgcMenjwHb6nd2f8wSJpN1LbjNG1lpOpSZbEP95NAiK4EcDgpy2AimqT52MetUc17+jdoJwYmVqFrO51hB9MSK/tJr8rh/FWJ0mXMGKgHPdIfTo15cktP2Geg0HCGEUviOLjDU7UQvoKfdUyHev2KgbKnc4xApofDj8MPTujMBtFcukJGW1IzW3CX6UHozXE/8SIrs7oqXmJBtNg5/baXsWgZUhZuUMkGQzEzlEkSKLqLozEPXR4VyK+1KfOe+OlSVUk0NZb3p20O64bmcaInGmz3vjMyTpF6H00Vg1s8sLbKp7XVG08opNzezcgEYqFgqG1YwIwRzzjB52i/pwHMjkVGSsZt9i2BZeUQJBQg5ppYmOa5S44q8fKx+BV+1unFfaom1r7+yDVq+d7WRep1eGpMKSdyaI4jeIqK1ATYwdnRhCLob4ErmkKlCa7n9uAbAFsI0dpHWTPdYq2VO3B4Wmm+8VUy8tRxyCfLyD7O6shdmQCImb5AsIY5FP9SehAQkjgny6xRA9UtcLoSCuNandMq5NwaV3qhC+ta5QamgMK1JzZjoNtzmhffdkSUBcGKmCQuKAH/H7Ti0hJeJ0L9KlQxPy3/G9N5ZSagw1/xKNHazIukl4HJ3m+GQBJ/xmBeY1v/KiVgMtxYw/aLGPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(52116002)(6666004)(6512007)(6506007)(5660300002)(508600001)(8936002)(38350700002)(38100700002)(36756003)(2906002)(86362001)(4326008)(8676002)(6486002)(966005)(54906003)(2616005)(83380400001)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(186003)(1076003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RAnxKISVMa8RAKpucSscE8x4FA/b8rTOQw600rjP8XWZPpEfGV82mkDiFAi+?=
 =?us-ascii?Q?Z06lWiTCtcPVplzN3a1L7pW3ZR6M+I4YxguOl3yQZ1n+9jLxjdMkCP6C670J?=
 =?us-ascii?Q?Cp4OxnFQYBGujgM56HD3K8Ph47JsvF6a5ifNCOpOQxnOMb9eehCNzJkKXJ0/?=
 =?us-ascii?Q?dHQQSYJbXQcEkz+GZU4b9Mbd9vqijo/3S9f86ddx4RdLiCsLu9p8TxF8koCv?=
 =?us-ascii?Q?GrVGL85GAlF+ya3PKPPf/iwxT5/ok6Z1ns4OmMEiI5Ep5gPeoDFrrEV0mBqu?=
 =?us-ascii?Q?+7ShqdzidRJ0lit5jyrKwpqs+juRSWTUDSCyPVUM87jZY9nl2q8pwYanIX/T?=
 =?us-ascii?Q?A8utMnIhqNcSVzrnjDkhoA2LiFAswh90+94pb3t7O0x0gDpwpND+awNe12pf?=
 =?us-ascii?Q?E+6bPU3XzOmhTtdo6lxWXOGLsYnGcv4GZP4ncMfufXU8AUfeIxIh/fZvVqNz?=
 =?us-ascii?Q?RqWx+4vL5TDQzxbY83vUpG3txmp1/495660v/mnKURJ6rHQnJ20t8DXTdEMR?=
 =?us-ascii?Q?8w46zKSlaDdeN1yyenKRUyPhDHLSn3fINUr8Bvfy3W7/KNcWCxp+YWzhBb1K?=
 =?us-ascii?Q?aqpM0H4XPC3pHyxE/fCVwphehvEArHMpjo1/Rd5mSle+sM1xilgimfxAtq0E?=
 =?us-ascii?Q?EvFqtbI5ppu6Haq7qSzRp8rAJTGPANEJV2n5DLygO7krA0ORKYkijTPbh5LG?=
 =?us-ascii?Q?rQUdWzbLEjCSMC5L33cb4s+py0fvPuFiZ+YWQTYm/LfZqRAei/BtNs9h0uJZ?=
 =?us-ascii?Q?V0hhqccZ1VT7K93sS1Di5q3HLWfKstJgSf5vWE5O6Uu3mc9v7gQ7lyT0GLJS?=
 =?us-ascii?Q?UAXFtMrcpUpNfGpgpKh0JHXFeDwHb55mYdAnsYTGm1LV2gLJVJvdc9HkGIQH?=
 =?us-ascii?Q?0wrlENKh/VsCk8iTWhJ/Zt5q4m/gLUAD7DxUAxJNSWuGPz0Qr1RfOuJOtplA?=
 =?us-ascii?Q?CJs/wLMEqa896MoXI9UBytrJSfQ8P4KFPmYApByE1tQGNqd3NGZbIg7rm1db?=
 =?us-ascii?Q?uGaipZn0sAD8KwzPxuwNwQxLhveQOQYSNnzABtS/ECyrIdn1myeONaaeB6Lj?=
 =?us-ascii?Q?yJMfJ06YW9iA3A/DBVadfAZpdEU15oANG6OyDUeo14TDW8p4a+NPl8TMfpBo?=
 =?us-ascii?Q?XzyS97cM0CvtF7s8VedB5dMVS6/8iomUXTr3lRJWChO33eTbWv8iXRa4smqX?=
 =?us-ascii?Q?3dgWcnLWKYBI46V2o1DXy52deTxaBK9VwmIbUGcJV/wSBxG/MARaGCxFSqOg?=
 =?us-ascii?Q?zZaPTU8WA4Ef446jqlJdd9joOD2HHOW1t0S7WTK4XGH7hrRkfYPNXt5poRD9?=
 =?us-ascii?Q?ElHjjJcPpaqrGlKKROsiKDQ8EbM9j8v+jdEMHDTZ+INxqUcf/r10pHDVS+oK?=
 =?us-ascii?Q?dcLhhykXy8zSfNgFbZdIrxnFFwA1XUdROaxkPmpoVeKnAM4c3ZmzQ9PR+ui1?=
 =?us-ascii?Q?8CrAM2b77tkKWH3wLa/5ya4B6q2VgBakBszb4Ek054IF81yO8y8+8RX4yqKn?=
 =?us-ascii?Q?EGwosM0yOFLNtfAMQg78ui1hc50dUWpo/fUu3mPxZTs3JVJOv/zuilC3HL3u?=
 =?us-ascii?Q?KxELtyqX38NW9pS3LKX/GTvnvVPSivkAHjmMcMuwmMaEWuOgN5bsXw/15f2r?=
 =?us-ascii?Q?shhLcmuadwQlrIL2RVpDV+At+1UT1rrQb/BA1NeAFSXPZjm/z6uWv0kWdFJB?=
 =?us-ascii?Q?kyQb1sCIswJfHSm1NWTCkZv25eA=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0aa08a-f4c0-4d70-5eff-08d9f528dc0a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:56:49.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX/bWoQGurg6SRIr32Ilm7p41mVoDLtXZ25e03683Wg9AGoPCq1Z3wr8QOw/1H6GatBuJtpixmqQJONpEWktCza9PEYF+UBlMuF4kFM6T7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6574
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

sc16is7xx driver assumes that the device handles hardware flow control
automatically. This is not really true as the driver does inadvertently
clear the bits that enable hardware flow control.

This patch series solves multiple issues present in the driver. While
the patches are fairly independent, there are some dependencies. The
"sc16is7xx: Properly resume TX after stop" adds IER bit set function
that is later used in "sc16is7xx: Set AUTOCTS and AUTORTS bits". Also
the patches that control which interrupts are enabled are dependent on
each other.

Patches should be applied respecting the order in the series. The whole
series applies on top of "sc16is7xx: Fix for incorrect data being
transmitted" [1].

Patch series has been developed and tested on a board with SC16IS760
connected via SPI bus.

[1] https://lore.kernel.org/linux-serial/20220216160802.1026013-1-phil@rasp=
berrypi.com/

Lech Perczak (3):
  sc16is7xx: Preserve EFR bits on update
  sc16is7xx: Update status lines in single call
  sc16is7xx: Separate GPIOs from modem control lines

Tomasz Mo=C5=84 (3):
  sc16is7xx: Properly resume TX after stop
  sc16is7xx: Handle modem status lines
  sc16is7xx: Set AUTOCTS and AUTORTS bits

 drivers/tty/serial/sc16is7xx.c | 257 +++++++++++++++++++++++++++++----
 1 file changed, 227 insertions(+), 30 deletions(-)

--=20
2.25.1

