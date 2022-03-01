Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B00C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 06:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiCAGEj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiCAGEg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 01:04:36 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD78F60CFB
        for <linux-serial@vger.kernel.org>; Mon, 28 Feb 2022 22:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1646114633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NHgnWgzte7TRqCFshN3PUXCoAdl6QAwr1aOWK60390=;
        b=CmfnkV5/+ykh8BI9plTypOFogoIC2vLeyTcSuANgb4fc3AFvIuqto2WN5QECRqaQN/jlXn
        ZCD69JgC78Qlb1iyQvfY44vXywFlW/VMfiNyk7AWQxG5ct1lGGrauJl6OG0WvHWm0srD2j
        ywnQux0e6MaF3tX/CTSPWU6z1Z98NhM=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2057.outbound.protection.outlook.com [104.47.20.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-313-KXXWnvSoPLmV1rZlfejDpg-1; Tue, 01 Mar 2022 06:03:52 +0000
X-MC-Unique: KXXWnvSoPLmV1rZlfejDpg-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB2948.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 1 Mar
 2022 06:03:52 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 06:03:52 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-serial@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Daniel Mack <daniel@zonque.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH RESEND 1/3] sc16is7xx: Properly resume TX after stop
Date:   Tue,  1 Mar 2022 07:03:30 +0100
Message-ID: <20220301060332.2561851-2-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301060332.2561851-1-tomasz.mon@camlingroup.com>
References: <20220301060332.2561851-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO4P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::11) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1395bb35-f709-40e9-6052-08d9fb4942cc
X-MS-TrafficTypeDiagnostic: CWLP123MB2948:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB29483DDDD577D5E29701CCAB92029@CWLP123MB2948.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: Ghe7PCr/jqTuyVB+uqDQkOtv2BerzYb95sRZ1nshOMzmQU0NOtasQ5gMcGW1v1Sdhh4S7lSpPuJaoQSA5DYg2jeV9nuHMzZEDI74zvY/avkP1SDhwl0YzHKOFLofV0MPW5ps0/80UwBYlY1GOuhgGUuw4gZL46I/ZU6QHfj1Px5TCJjCBCrqZUAz7YFA9pjtQ7gkg9BRyDNPYEy1X66fvPMmzra9vdpxtkcBe3PpmMXEfNb1Zf8GEFmsoKuZy6r91CncL6+LsXrMoilX312jg6ai0JVzXmKdeIM+5dTvRogQFs2z/SbzmoR71YecaLl3tmwlLTFJADeyq7Py/XVfN/5Ups88PFqUwriGWubrP8hVY0dSVeirg4cm+vN44xxdREv21CMLi6KZyMbD23UAeQtlXJmWZNF5K/AWaLPbcLhAKT/zzsjeWNB/HmWafO2n2JdTDemDuI7kX8NprKXG7GmDxiHA7zoIXAEH71EAqxKkUiV4MTnSw6F1My63Zq6dtC6etbl1Yczgqs3h6wow269JX7Ygys2muvDFfm51ow/FfORq1xVOd9TFOdnYNHvuhOWhSB7JwcG/f8Ymwz/gqxZUBAgib7x/u+sSbBDMMmnPTpJM9GJJvFetJxO86e4j2xdL5ToYlABTvoDHX/1RfDV8KoBFg1ia5Z5LOdCDomzEnoOI4RpHtSv4kq57Zd35K4GRd9pN3qiwfvyQNuTiAtZPwuiw8RADGi26kxwMlqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(2906002)(1076003)(86362001)(26005)(186003)(52116002)(2616005)(6506007)(83380400001)(8936002)(6666004)(8676002)(4326008)(6512007)(66556008)(66946007)(5660300002)(66476007)(6916009)(316002)(54906003)(508600001)(6486002)(36756003)(38350700002)(38100700002)(326664003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JDVeEYQcJk2RsTMs+ssxCkMp97iad/2IWFCxXLnzPs2yAEZpr/nK8mi55Ert?=
 =?us-ascii?Q?FWshHgmSFbvot8Y/3PvRSaJGnykzy/d+nZIegawCohGNoHiYdt1YwhjbFi30?=
 =?us-ascii?Q?82G8+oQ8Tch4bcAUKBhLQ/KyeyjfKmH7PvM6ZSrvyqxRk/8h9gq/iOCVqmlx?=
 =?us-ascii?Q?t4MHTCcIoZ7UQ0f3/FjX/QchgURKKXTgvUkUJZHULlsj+B0v7g9AacuhMHyq?=
 =?us-ascii?Q?Xx43tqjSbZUhf9w1d5+t7c/HOuI6nPj3GGfrWveJD8Cm5B+l7QsNRJskoFri?=
 =?us-ascii?Q?t4pQu0kFxQpMr7a6+e7KTl1JsnROq+DHY6xI4oFzf2QzAHWUykmVi+1AK/hx?=
 =?us-ascii?Q?H4rOhdq3FaQu68SddVgtvpJs6e0HXRtfT3kslp8YpCdHBDhcXcvRVMVY4q9z?=
 =?us-ascii?Q?xoFZwczTz3zqf+Q88wcpzHYvJJMkDf3bIk0NRRGl07yt2nzsOIcZSwwDtisq?=
 =?us-ascii?Q?oCgZF4VVPYVfExm0CBCp4XSeRremRWxteoIejSgFEUC1wOLg4BCONUmCH+G2?=
 =?us-ascii?Q?7A8aj6U9HT3RH4zfBD7IFJqvqE9vbd4c7bXejp7QY2dU6amGZAzCQ55CAflU?=
 =?us-ascii?Q?ori31A9DIwJ9gbEpruYpA/0KGeUzFPJwk5KtvlYv0T2BWZkB3ZDIK8EdlcxT?=
 =?us-ascii?Q?5uH6TMPFMHSzlay3UCN32oUABJvPcdnaRvrh9ISQSXzgxwjZr+TFNeJlLcq8?=
 =?us-ascii?Q?S0bF6yfXtBP6J3hbuYdbw8wYtsNmKErLgi5M1X7kKvWPvxwjou+aIdmUm3k6?=
 =?us-ascii?Q?R02yD8W9M3mO6n9+0zcLEPaVH5sSzO8DWf/Ahm8RwkF3vkhCqkSLGdyZ7Sn0?=
 =?us-ascii?Q?+T52Icxc4YpT+W8zqsIoelDyR1bL9zpX0n9u8z4C6WMTAXuLnkl6fZLY7egI?=
 =?us-ascii?Q?ZciD3tZkT9mliXXG6VJPtiRNfb7vN0klMNWpMtLxl7p1xr7D/tBRGW08gTFj?=
 =?us-ascii?Q?/ECK2u1HyAQP4ldEmTl3QrTB2HIbF2pvyNOeX20GTj3zE4gwNeWuv16j0PaX?=
 =?us-ascii?Q?zRIyEs2SUr25rvMpMG1DFOYMefJjpo6spoz84/uzzmv0PQSwaT9UZm1vfoou?=
 =?us-ascii?Q?RxlB9r7CHuHZmDegkc2qb8Dw12sm0dZfF8rnBD9Rm9NoKTqOHNgyq5JLMMQC?=
 =?us-ascii?Q?7+5Pw0iXY63IX5w1adyMoUAxIdzS+h0tJTzm96mdIti0TzSVgNZkKMfQyeSm?=
 =?us-ascii?Q?k9z/Z6nyEJikUJhaglJWY8sN+pqJOKEq9F6kkHmUWrdEh5KzoHsH6KaJM4tK?=
 =?us-ascii?Q?NWV1ThgONSQ/Qs+Wd79qzuC9Ar/rCcMX9k0TtnYewkU5uECw+1t1awer9ILk?=
 =?us-ascii?Q?Hp4kTKTCbWI7Qzwle/ASmoVGqmQcFhphPtursr7V2KgwFuUTQghjjV74KVZM?=
 =?us-ascii?Q?Izhbx3LALMYEw42joFDfodcVMcgnArQPQrQVod5GtqmWdd2clt4T7x3wfrwg?=
 =?us-ascii?Q?yISTQzPqoslvQ99NsM2tj7LqVagwl5FFvIP97pXypQyjtMuaXCilIEjZHkpk?=
 =?us-ascii?Q?7Ot8dXBpyH0dR7GxwFnrGrQ/uNIkT6Wy3+Ysuf4399npnO7ihnM3OT8g8gDi?=
 =?us-ascii?Q?1oSjvMjRQPTsDX0KCSDZEorm9iiDQprBgwIRLfMJreJ0mNjusiAy4sYdtZ7t?=
 =?us-ascii?Q?2kl7y7uHyI5xYViEWDJ0J/2nfuvLn9ZRMXD8RJJ+qbSO/GaOiYK6ymaAeDsj?=
 =?us-ascii?Q?9qZ+t8VaNCwbrixhZHSRBecDNVo=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1395bb35-f709-40e9-6052-08d9fb4942cc
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 06:03:52.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbgsnQ8UQKexdRb97p96HsrGrlKRpz+Ink1iOnPhEILDFfeirIyOS9KtBRZ9sbUEMhEVjSFfGcQex44r9apLHqy9/zWxUJmyKLwcCDnjeoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2948
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

sc16is7xx_stop_tx() clears THRI bit and thus disables THRI interrupt.
This makes it possible for transmission to cease indefinitely when more
than 64 characters are being sent.

The sc16is7xx_handle_tx() call executed by sc16is7xx_tx_proc() can send
up to FIFO length (64) characters. If more characters are written to the
output buffer, then the THRI interrupt is needed.

Solve the issue by enabling THRI interrupt in sc16is7xx_tx_proc().

Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 47 +++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 21ae2c0b7bbe..17e79af36604 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -315,7 +315,8 @@ struct sc16is7xx_devtype {
=20
 struct sc16is7xx_one_config {
 =09unsigned int=09=09=09flags;
-=09u8=09=09=09=09ier_clear;
+=09u8=09=09=09=09ier_mask;
+=09u8=09=09=09=09ier_val;
 };
=20
 struct sc16is7xx_one {
@@ -349,6 +350,9 @@ static struct uart_driver sc16is7xx_uart =3D {
 =09.nr=09=09=3D SC16IS7XX_MAX_DEVS,
 };
=20
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
+static void sc16is7xx_stop_tx(struct uart_port *port);
+
 #define to_sc16is7xx_port(p,e)=09((container_of((p), struct sc16is7xx_port=
, e)))
 #define to_sc16is7xx_one(p,e)=09((container_of((p), struct sc16is7xx_one, =
e)))
=20
@@ -651,6 +655,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 =09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
 =09struct circ_buf *xmit =3D &port->state->xmit;
 =09unsigned int txlen, to_send, i;
+=09unsigned long flags;
=20
 =09if (unlikely(port->x_char)) {
 =09=09sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
@@ -659,8 +664,12 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
 =09=09return;
 =09}
=20
-=09if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+=09if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+=09=09spin_lock_irqsave(&port->lock, flags);
+=09=09sc16is7xx_stop_tx(port);
+=09=09spin_unlock_irqrestore(&port->lock, flags);
 =09=09return;
+=09}
=20
 =09/* Get length of data pending in circular buffer */
 =09to_send =3D uart_circ_chars_pending(xmit);
@@ -687,8 +696,13 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
 =09=09sc16is7xx_fifo_write(port, to_send);
 =09}
=20
+=09spin_lock_irqsave(&port->lock, flags);
 =09if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 =09=09uart_write_wakeup(port);
+
+=09if (uart_circ_empty(xmit))
+=09=09sc16is7xx_stop_tx(port);
+=09spin_unlock_irqrestore(&port->lock, flags);
 }
=20
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
@@ -751,6 +765,7 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
 =09struct uart_port *port =3D &(to_sc16is7xx_one(ws, tx_work)->port);
 =09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+=09unsigned long flags;
=20
 =09if ((port->rs485.flags & SER_RS485_ENABLED) &&
 =09    (port->rs485.delay_rts_before_send > 0))
@@ -759,6 +774,10 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 =09mutex_lock(&s->efr_lock);
 =09sc16is7xx_handle_tx(port);
 =09mutex_unlock(&s->efr_lock);
+
+=09spin_lock_irqsave(&port->lock, flags);
+=09sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);
+=09spin_unlock_irqrestore(&port->lock, flags);
 }
=20
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -813,7 +832,7 @@ static void sc16is7xx_reg_proc(struct kthread_work *ws)
=20
 =09if (config.flags & SC16IS7XX_RECONF_IER)
 =09=09sc16is7xx_port_update(&one->port, SC16IS7XX_IER_REG,
-=09=09=09=09      config.ier_clear, 0);
+=09=09=09=09      config.ier_mask, config.ier_val);
=20
 =09if (config.flags & SC16IS7XX_RECONF_RS485)
 =09=09sc16is7xx_reconf_rs485(&one->port);
@@ -824,8 +843,24 @@ static void sc16is7xx_ier_clear(struct uart_port *port=
, u8 bit)
 =09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
 =09struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
=20
+=09lockdep_assert_held_once(&port->lock);
+
+=09one->config.flags |=3D SC16IS7XX_RECONF_IER;
+=09one->config.ier_mask |=3D bit;
+=09one->config.ier_val &=3D ~bit;
+=09kthread_queue_work(&s->kworker, &one->reg_work);
+}
+
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
+{
+=09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+=09struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
+
+=09lockdep_assert_held_once(&port->lock);
+
 =09one->config.flags |=3D SC16IS7XX_RECONF_IER;
-=09one->config.ier_clear |=3D bit;
+=09one->config.ier_mask |=3D bit;
+=09one->config.ier_val |=3D bit;
 =09kthread_queue_work(&s->kworker, &one->reg_work);
 }
=20
@@ -1067,8 +1102,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 =09=09=09      SC16IS7XX_EFCR_TXDISABLE_BIT,
 =09=09=09      0);
=20
-=09/* Enable RX, TX interrupts */
-=09val =3D SC16IS7XX_IER_RDI_BIT | SC16IS7XX_IER_THRI_BIT;
+=09/* Enable RX interrupt */
+=09val =3D SC16IS7XX_IER_RDI_BIT;
 =09sc16is7xx_port_write(port, SC16IS7XX_IER_REG, val);
=20
 =09return 0;
--=20
2.25.1

