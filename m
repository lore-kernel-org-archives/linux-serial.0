Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCBCC433FE
	for <linux-serial@archiver.kernel.org>; Thu,  3 Feb 2022 14:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351151AbiBCOYF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:24:05 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.86.197]:46843 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241793AbiBCOYD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Feb 2022 09:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1643898242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JIyxdN1GZKcIlb1coKfUC1aRsHrZn/JF+uDSjqCaehA=;
        b=R7/visKTvRSI1uyOGaPSKuFDfEyMG0iEmu35bQlWV9b2QVBDEpH756MDnvS32vv5DEuJTO
        rzgUGOJfktS4N7d01G99lSQkAp8tvK4ox2+6yt5nzNpx+pYhreKpo5eXd4gjHTWGO+sSv+
        jCqB0/MM6Zqw5OWS7zVxUsLo2VHJhXc=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2054.outbound.protection.outlook.com [104.47.20.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-213-71wKAPr0NcCd7qOPMG5_4g-1; Thu, 03 Feb 2022 14:24:00 +0000
X-MC-Unique: 71wKAPr0NcCd7qOPMG5_4g-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWXP123MB3288.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 14:23:59 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%8]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 14:23:59 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     linux-serial@vger.kernel.org
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [RFC PATCH] serial: core: fix tcdrain() with CTS enabled
Date:   Thu,  3 Feb 2022 15:23:37 +0100
Message-ID: <20220203142337.1993024-1-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO2P265CA0461.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::17) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a438e1f-da7f-4479-cee7-08d9e720d1cd
X-MS-TrafficTypeDiagnostic: CWXP123MB3288:EE_
X-Microsoft-Antispam-PRVS: <CWXP123MB3288455E66508CA69831278D92289@CWXP123MB3288.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: /FB+BmVwfViK4iDLvlKb5biNiF652I9S1zmqbRlrkFUYmTy86yhqOSpnxmz23gSAEdmSIlIFWz5Melnmy0eo01C/YZp34YCaLS7yYewXbMq7soMJqa5zp3btv0R4kQVr84vwWEywov9Mgcs0aF7i5E2RIUridjQJsqwl9aWUHvpDO5E0nI/iFyPwYHw+8oDGXd7mSJ0BDONUX40YnSDmMPjDUgnwibwLXlqAHu6twHwTEspAREaEY5aXwQPx7BMTior5Qo6BDrgBSsaGFaS1snjdv3S7C5TR4FeWuh3dJ9bP05Zh+5ZN8NSCaEHaEKB0Wpus438bCQLUBWUxuInfPHhQyVWU4qhBrhji4RS1QbK+ZB+M5+1RiNef5va0b8ECPijdV+x1gajdfBGPrYZbXkZWHgCmE9Aj5uJ7iHAol7s0Xgmvyerz+XkddyekSCgDsbPMHYepmhWcBQMUR9bh8EuUDK7IE4/AMUn3AOdsZ66zwKVd6JykRg66poEbFMLWE6/q5q1p/ey6Q/xh0LAtTYphSnW1TknnC4CdbOcv2/0gOlD4Id9kGooRk+BXyoR9SAjtUepwJxZXN0AQqAoK7sIYrmR+NpscFMQenxtVrkceEM9vAtb31kzSWSX2xoKNcHDJ7cViEThDY6TxN3CnC3u3DxkSZc6+1oYkyQHV819q0EJARKbPmklspFvAYGz5FlztGVoIoTO8aOg9h2DnoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(2906002)(186003)(26005)(1076003)(36756003)(86362001)(6486002)(6512007)(8936002)(8676002)(38350700002)(6916009)(508600001)(66556008)(66476007)(66946007)(2616005)(107886003)(316002)(4326008)(52116002)(54906003)(6666004)(38100700002)(6506007);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lIlhoKVE0LZLfQql5i+78D5cXtbzIhe3cp01nYChmY48uzFTsTQLeue9M/Te?=
 =?us-ascii?Q?0U5imlBvshEZDxMZj0lTDHu1cV7SVe9NFAneC3mOIbL4uwSS4nlNtDEvrtDm?=
 =?us-ascii?Q?t8paBR+IDlHBb1LZ3eS5y4Bhf1wiP8MstglFao5JaDBJQ09GHCwD8Yl7jB5a?=
 =?us-ascii?Q?76YPDZSA89YUcSEWa+lO2HhAPat1css7gHhTFC5sLZwUteHKmSsqc5MT0f4j?=
 =?us-ascii?Q?UInW7ayLu/lkohZSinh3pVP8N85K8AinmMAwy2iHxDCvyXK7DC6um+PW9sle?=
 =?us-ascii?Q?mnNVi22VoLEtFbeMSK8kSNighLt0qu5dJqMtu3FZnr9hD+NJevDA2ZjGzndO?=
 =?us-ascii?Q?TxatKDJxEPTyEPO9vTUu6TttNP1d331QFmJT7IzDBw82XyZGm7gRqti9Qq/H?=
 =?us-ascii?Q?hDFzpCMLreirt2H7VxVj/x+z24Tkk0hZ4uMYERQn/FZ66pkyFzbiiZZczmJk?=
 =?us-ascii?Q?RZw+bNpiMjqfirfqN/NlFCt4N9+t3G5On9WGZui+a9YBj2vukcHnWG69DTt9?=
 =?us-ascii?Q?huzrA1H7shP5shB3SHJuw+imYOfFBQk48a7Pik/2Vu/ySAu2QoZ1kf5Xr+Y0?=
 =?us-ascii?Q?NPeWinFR0jCV6mlDMIyWLCkpATKxaBAhdNcwYtumi1SeQlWW+SLPpI9UFjHU?=
 =?us-ascii?Q?8jmOhT2EAIu4qAMJw+vgabGK2pw2h5Zk3KbXYFCgAvKPDn88au+tmDtFVFc4?=
 =?us-ascii?Q?mPTd0WJ2Cva/hEDdU0UNnyDMCwxZuxfwqP/wC8KtXcn7q/cK97B+0DcWmxyb?=
 =?us-ascii?Q?TJ5TL1KM6zpFKwjWBt/+L6ifkkpQiM+QDt3na0ah7THWLZrrJw8+50cCl8cg?=
 =?us-ascii?Q?je40rdjziJeirevd4YaY2J13raI7b/AFbs7mQAZt0lINvonD/A6UJp3s9ZzV?=
 =?us-ascii?Q?K9OjoD8So/nj8veAHNIwDY9izsSzixBlcmVJE9llDFTm6Sy9og0q6ZhGvM4Q?=
 =?us-ascii?Q?HDAjW2Ark+pCVWhnm2fy1ya77Mk3u+OCFXC2hpbo4BgyBYgX/KkGdhH2VL6O?=
 =?us-ascii?Q?1niziR4GgXgWtkUEZjC+vdIWbl8+jJNYxdUVpAA9RX04YwB3hLgI5LRbxtxh?=
 =?us-ascii?Q?8svZRmEk1qWnn+hxCxlX+lXnSs/evXEPbRTY1R0LlOtmVpHaT4ZmY8aAjYqZ?=
 =?us-ascii?Q?UG794oMaLacHYe/A1Zn5X3LM4uqX+M2eJtixswNYp90kPVK923zyadYtJC9Q?=
 =?us-ascii?Q?nc4AILIEc/6apUb6VLwVy4Ahd2fB/nRXW6rJ8B3p2Q3hexDzFaCnh90Djxi7?=
 =?us-ascii?Q?z8Vy5PMGmqZPf63kNplWSjWs6ACAO5fqhqhU5cxFca2w47Z0zf7rhEabKJy/?=
 =?us-ascii?Q?GCNtMNzn9woe0ZHPnezXzTCp2PBuMQ3KeQeMArNUaICoCuc3D9XLwGvQhnDG?=
 =?us-ascii?Q?eUMYizZuPhWVgtD2/3jql0m20DS+HW0MsmiFOs0N1LRaflCZtcfmL7cKILWV?=
 =?us-ascii?Q?Wnjo4e0rI5pm7IdzYj+05Yb10U9l9WflfX0wEDpUoo1z/w37IlvM1UDHAkOa?=
 =?us-ascii?Q?QE64fX0myUbvuWQgazp1B+DAAx62HxboEX64N+2749pbY9ctD5h9wUsxq3aw?=
 =?us-ascii?Q?GsZdrC1jObElrGVSDuTHypOqaqFYyj4hGxgL4AMClRSSY6IT41ZoAKyXAggj?=
 =?us-ascii?Q?tDv7igi4Zb9QTPigcNUsB0bvmfzHNKFDCP6r9EeSMuAmELAG1tQYthrQfJuj?=
 =?us-ascii?Q?2amY3g=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a438e1f-da7f-4479-cee7-08d9e720d1cd
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 14:23:59.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhTAU350Q04vA96p3Dl7NWQG9iyb6WdCF9SZVHcuHL0g3AADSY6DOc89AyDeLxybFFrnJbzaCJkj/HAPgDpiRiq8MCjfzpZ7em7yP47Hsy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3288
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Do not set timeout to twice the approximate amount of time to send the
entire FIFO if CTS is enabled. If the caller requested no timeout, e.g.
when userspace program called tcdrain(), then wait without any timeout.

Premature return from tcdrain() was observed on imx based system which
has 32 character long transmitter FIFO with hardware CTS handling.

Simple userspace application that reproduces problem has to:
  * Open tty device, enable hardware flow control (CRTSCTS)
  * Write data, e.g. 26 bytes
  * Call tcdrain() to wait for the transmitter
  * Close tty device

The other side of serial connection has to:
  * Receive some data, e.g. 10 bytes
  * Set RTS output (CTS input from sender perspective) inactive for
    at least twice the port timeout
  * Try to receive remaining data

Without this patch, userspace application will finish without any error
while the other side of connection will never receive remaining data.

Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/tty/serial/serial_core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_c=
ore.c
index ba4baa756d51..4687c9d586df 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1605,17 +1605,19 @@ static void uart_wait_until_sent(struct tty_struct =
*tty, int timeout)
 =09if (timeout && timeout < char_time)
 =09=09char_time =3D timeout;
=20
-=09/*
-=09 * If the transmitter hasn't cleared in twice the approximate
-=09 * amount of time to send the entire FIFO, it probably won't
-=09 * ever clear.  This assumes the UART isn't doing flow
-=09 * control, which is currently the case.  Hence, if it ever
-=09 * takes longer than port->timeout, this is probably due to a
-=09 * UART bug of some kind.  So, we clamp the timeout parameter at
-=09 * 2*port->timeout.
-=09 */
-=09if (timeout =3D=3D 0 || timeout > 2 * port->timeout)
-=09=09timeout =3D 2 * port->timeout;
+=09if (!uart_cts_enabled(port)) {
+=09=09/*
+=09=09 * If the transmitter hasn't cleared in twice the approximate
+=09=09 * amount of time to send the entire FIFO, it probably won't
+=09=09 * ever clear.  This assumes the UART isn't doing flow
+=09=09 * control, which is currently the case.  Hence, if it ever
+=09=09 * takes longer than port->timeout, this is probably due to a
+=09=09 * UART bug of some kind.  So, we clamp the timeout parameter at
+=09=09 * 2*port->timeout.
+=09=09 */
+=09=09if (timeout =3D=3D 0 || timeout > 2 * port->timeout)
+=09=09=09timeout =3D 2 * port->timeout;
+=09}
=20
 =09expire =3D jiffies + timeout;
=20
@@ -1631,7 +1633,7 @@ static void uart_wait_until_sent(struct tty_struct *t=
ty, int timeout)
 =09=09msleep_interruptible(jiffies_to_msecs(char_time));
 =09=09if (signal_pending(current))
 =09=09=09break;
-=09=09if (time_after(jiffies, expire))
+=09=09if (timeout && time_after(jiffies, expire))
 =09=09=09break;
 =09}
 =09uart_port_deref(port);
--=20
2.25.1

