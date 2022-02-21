Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA4CC43217
	for <linux-serial@archiver.kernel.org>; Mon, 21 Feb 2022 11:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355756AbiBULRP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:17:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356320AbiBULQW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Feb 2022 06:16:22 -0500
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 02:57:59 PST
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93587DF52
        for <linux-serial@vger.kernel.org>; Mon, 21 Feb 2022 02:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1645441077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lyk1Iv2AyEpdVklKZ/IDwiuJJEQ9EyrVIcrOte333Ag=;
        b=PyGTaF7MvLH44pmxWWwXpN364NyqtlrgNNRk+8ujwre//pBSJhQGhbDO+tT3ocp6nN+hhk
        Ok51Mx6RZmmfaUaZKqySNLVvnGL+Gd0dAeh2P6poPxj3YaGVuG++aPaf476pb1L705+67s
        GRmtwRSBXmfjzvenRfOZ4OVcjJVgfYM=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2058.outbound.protection.outlook.com [104.47.21.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-27-0W8be5_rNGatXmzuGt-v3Q-2; Mon, 21 Feb 2022 10:56:50 +0000
X-MC-Unique: 0W8be5_rNGatXmzuGt-v3Q-2
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
Subject: [PATCH 1/6] sc16is7xx: Preserve EFR bits on update
Date:   Mon, 21 Feb 2022 11:56:13 +0100
Message-ID: <20220221105618.3503470-2-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
References: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 271ac456-7c74-480c-3e7b-08d9f528dc92
X-MS-TrafficTypeDiagnostic: CWLP123MB6574:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB657455024F694F8193655712923A9@CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 5HRViof0OKNF0L9wYMRjP+4OZjx1fw8gjWZxZC1a+Hblqi32cbY68XA2HJCd3IAt1w9BLWhLoOw9RrqqoUuPT+2wALtI8s2wMktOjuQGoZkvW8Si92GYOF0KlHje5adIns5krAuzsc+1RiRGxFRJPVwWOU5LEhetYEWIVeWuwFxg3QAfCaULnjAq/d+IzwrC4ey7C6IrQNeIT7QttAc1kdSmHjMRnVAIHN9Sl8ZP2ItJGwAJlhnVubZtM3bqAWO8LwQyeBY8Evg8Wvl1r9br81ghlB1K2ZcoRx0L/GoQZtgO2NPGzhz7U05x7HUqHGB/WxbWPcqLQ8VEI1KaenvEUWqST3sj5Yhoypx4HbPEx9RVOYxUwJ5trNRtneClkuH9/ngZHgul7F2tpul2uPQ8gpJIB6fmvFg6yW2zOkyYi7rRSUuNPcSNnuhsWFB6N6qdWJCh7CYE0+2a1L4QzEa0zWwkignd68VJexMy3VQ9N+fp3osp+555q8akT1sP8peSL5vgY1VZR4jMdlQjPBicQS+TXQwPjgys0b4vHPJ+uSLGA8yshuqJHsWX+FCyU7igTZ3exEgWDGPY4KIlBu0gR6y4IGFIm5SvKjfSDGcDFLHt8/xyx1n7rIbBqCwO6xnlI5UT+Iivj/Qmv5hRQKTOd4XIJM8/2aHIg9FXUovoeXANvzn3TgDvrapJd7EzgXxqKGdTcB7uJ3NSoLfh/15pYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(52116002)(6666004)(6512007)(6506007)(5660300002)(508600001)(8936002)(38350700002)(38100700002)(36756003)(15650500001)(2906002)(86362001)(4326008)(8676002)(6486002)(54906003)(2616005)(83380400001)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(186003)(1076003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bC8G89OeoTGJ7C48fMMvFuS67Q6jKt5VDBmL4EdRr9Avydj2/nou+XBeOdpd?=
 =?us-ascii?Q?Ha5LmSabpdoXpHJr3MtUmtGve9uBm/7/YhlmPg+K5BV45TzD1iK+WGglVtSD?=
 =?us-ascii?Q?dIN8wvhoVcRDneduQ+cnv3+xHowMbx1uKV9cKQ2P3x3UXMusJ4A+RwPf9jJm?=
 =?us-ascii?Q?kaKk9ca3X5XzqYChpcKa/8Agwlf//SCsmp4nXX5h2rG40/VqRM7FfQ8I0/Ak?=
 =?us-ascii?Q?XUJs8QAc5UZ7uTufwy13QmEG3fBUK8dyq0wKaQa3nD/a4ZHJDTjkmG7XOimW?=
 =?us-ascii?Q?rc8k+3CISJNNvke40ZQWK7Ar4EPELXGzyobcuuhPxAY9ZqDljBNjnn3VJtt/?=
 =?us-ascii?Q?i6s0GQpzyVHF4jMjIK5D8mWN4uzPzhhWeI+umrkeIZwJKA9Hn/FFeBr6W3df?=
 =?us-ascii?Q?YpLL6nhfVHAk6dnrDRElQniSt93MHguR9PL92to3BdNEBGllmUerGYqWc9nF?=
 =?us-ascii?Q?0Jh2q2PBeudP4zmRoF2TZ9ssOFBaBbZIW3v0eeMdA/GAMEA6HbTfFBgZfwiB?=
 =?us-ascii?Q?Wrp2+jtec7fH/3/Zt/eFghGu6yvku8pea0LroJix3UTg4r/nC09ZzAIOGAbE?=
 =?us-ascii?Q?wJXxi/tYcmm1apQH6qcHJtmCBSrl+VeT8sNml9NW6kC2zVyS5UIufbMP76l/?=
 =?us-ascii?Q?MHJHnIYLMr6+3Tq5i7QKSKf58UiJrYG2WkMb6nlvxs700gG5Jh2lebzQRuzz?=
 =?us-ascii?Q?6YliYe4HFKit7O77VyBifUMsHDFmehcsuXWfkKDBXUL4iYP/x5NrbALP/yHL?=
 =?us-ascii?Q?RWmZqydY17rlUrx1+YiVpELieHI4BdGavFTnO7yhC94/7cdU9cyrhLTes819?=
 =?us-ascii?Q?ys22G7ilppm/p1nB20qJrce8t+COOv7TpYJAP/LWglQKfKjsn8XlxctYltRm?=
 =?us-ascii?Q?ELdn7V5ZbOKwYXpzv7/5biC96oasP7fiJYo0OJ+lOh61Y8xSeh7LyroYobfk?=
 =?us-ascii?Q?mOed4SHlo8j8/DZSTyfIPwvZM8e+Oi4ZiP9Je7QA4XnWsH/w9OaSHMrP78f+?=
 =?us-ascii?Q?krNWanWMj+LnUnSMGY4R04l1qR9TD95OmACi6sEmPUtDV2BnSBa4FBWgKc6p?=
 =?us-ascii?Q?vPon1lkuv2f6WgOx/WVrpkOu4gydkkxi9dYv5+2o0zPYstxkWGARcdPtDOUe?=
 =?us-ascii?Q?2fQE9344QmzP5I6EjgVvPUpKFYq73DyqYxl9x3G/OC3dvFsJbuI/p115uTAt?=
 =?us-ascii?Q?J/JMKffg2tEnNNu3v5E9gqQeahBjDeAEqoJwpcXORBa41hV1Tkuoyp0WZ9gH?=
 =?us-ascii?Q?uo6I/TxrSTzX4h8osvBRgCyRU8ShjMDz6F5tGXNpQeVul9q3j7QwLThkos+6?=
 =?us-ascii?Q?4pfhp8eT7pydDB409CsCyF6Pxx9P/mwidzMbu+XQW+mSrzLJlmI1rYKbHdyF?=
 =?us-ascii?Q?nFc0DF095j1kZ9RCGyxF7gQ9beRwF4OwpUSWEcpmULexhx9ADyA/b48qEEFB?=
 =?us-ascii?Q?Sb1H43nsVklWYrFjwr14Qw72u61tc2HZHXcvnP4DH6BnAQNGwCkSj3bxNKXP?=
 =?us-ascii?Q?cSaPjnmYPSW0E0QYAT2qEEgS8pXZyYqnBZkL/SJznK9MIOfBNVOAoUDpEtev?=
 =?us-ascii?Q?6PBafXI/bgj7yQM56WAQir4YyJJem7YFzk7aRmYh+RP670pXrDuGpbuOEAcV?=
 =?us-ascii?Q?bdgq/h+CAnyz+qN1VQANKtCMUyTOiczXrmTX7jponpIIiZvsIQHgNbX2KT2o?=
 =?us-ascii?Q?EaZxdeqMC0iFkpFVwf8CTviyvdU=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271ac456-7c74-480c-3e7b-08d9f528dc92
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:56:49.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+rZ03km6qkU44kTRA6fIEhG49yYCGy1G04ab3ymGCCbM7kqdenCpHr+6qm1CADd59o5screprn9zw7QmcY5Z8ryNiit/e8FdxzGUeU3hng=
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

From: Lech Perczak <l.perczak@camlintechnologies.com>

Preserve unaffected bits state when accessing EFR register. This
prevents hardware flow control bits from being cleared on enhanced
functions access.

Signed-off-by: Lech Perczak <l.perczak@camlintechnologies.com>
Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 38d1c0748533..3800733452fe 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -289,6 +289,14 @@
 =09=09=09=09=09=09  *       XON1, XON2, XOFF1 and
 =09=09=09=09=09=09  *       XOFF2
 =09=09=09=09=09=09  */
+#define SC16IS7XX_EFR_FLOWCTRL_BITS=09(SC16IS7XX_EFR_AUTORTS_BIT | \
+=09=09=09=09=09SC16IS7XX_EFR_AUTOCTS_BIT | \
+=09=09=09=09=09SC16IS7XX_EFR_XOFF2_DETECT_BIT | \
+=09=09=09=09=09SC16IS7XX_EFR_SWFLOW3_BIT | \
+=09=09=09=09=09SC16IS7XX_EFR_SWFLOW2_BIT | \
+=09=09=09=09=09SC16IS7XX_EFR_SWFLOW1_BIT | \
+=09=09=09=09=09SC16IS7XX_EFR_SWFLOW0_BIT)
+
=20
 /* Misc definitions */
 #define SC16IS7XX_FIFO_SIZE=09=09(64)
@@ -523,8 +531,10 @@ static int sc16is7xx_set_baud(struct uart_port *port, =
int baud)
=20
 =09/* Enable enhanced features */
 =09regcache_cache_bypass(s->regmap, true);
-=09sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
-=09=09=09     SC16IS7XX_EFR_ENABLE_BIT);
+=09sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
+=09=09=09      SC16IS7XX_EFR_ENABLE_BIT,
+=09=09=09      SC16IS7XX_EFR_ENABLE_BIT);
+
 =09regcache_cache_bypass(s->regmap, false);
=20
 =09/* Put LCR back to the normal mode */
@@ -935,7 +945,10 @@ static void sc16is7xx_set_termios(struct uart_port *po=
rt,
 =09if (termios->c_iflag & IXOFF)
 =09=09flow |=3D SC16IS7XX_EFR_SWFLOW1_BIT;
=20
-=09sc16is7xx_port_write(port, SC16IS7XX_EFR_REG, flow);
+=09sc16is7xx_port_update(port,
+=09=09=09      SC16IS7XX_EFR_REG,
+=09=09=09      SC16IS7XX_EFR_FLOWCTRL_BITS,
+=09=09=09      flow);
 =09regcache_cache_bypass(s->regmap, false);
=20
 =09/* Update LCR register */
@@ -1010,8 +1023,9 @@ static int sc16is7xx_startup(struct uart_port *port)
 =09regcache_cache_bypass(s->regmap, true);
=20
 =09/* Enable write access to enhanced features and internal clock div */
-=09sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
-=09=09=09     SC16IS7XX_EFR_ENABLE_BIT);
+=09sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
+=09=09=09      SC16IS7XX_EFR_ENABLE_BIT,
+=09=09=09      SC16IS7XX_EFR_ENABLE_BIT);
=20
 =09/* Enable TCR/TLR */
 =09sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
--=20
2.25.1

