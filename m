Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02135C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 06:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiCAGEl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiCAGEk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 01:04:40 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93FC960CFB
        for <linux-serial@vger.kernel.org>; Mon, 28 Feb 2022 22:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1646114638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N70pF1EaMXNZt6MNzvjBufnX9i+FKEFLF923zMoJmFs=;
        b=Vh9zx7HFFFfiVsuNjKEy1G+E7CIBRSFWVCydSXF10ul29DQhzLKop5FrqeN96weah1a/Oz
        mkBjuNqtVICewXEIm802f8frJ2s/LAK7ixXoKBXd/IpEQqt3wk8AgcFdMMxleS0b2XZO31
        EmpxJ3fprvmYaDTePq0QPjCpI+uMqzo=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2054.outbound.protection.outlook.com [104.47.20.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-273-vE0RNuGqNOOmzej-U4bImA-1; Tue, 01 Mar 2022 06:03:57 +0000
X-MC-Unique: vE0RNuGqNOOmzej-U4bImA-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB2948.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 1 Mar
 2022 06:03:56 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 06:03:56 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-serial@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Daniel Mack <daniel@zonque.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH RESEND 3/3] sc16is7xx: Set AUTOCTS and AUTORTS bits
Date:   Tue,  1 Mar 2022 07:03:32 +0100
Message-ID: <20220301060332.2561851-4-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301060332.2561851-1-tomasz.mon@camlingroup.com>
References: <20220301060332.2561851-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO4P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::11) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca740dfd-f7fd-4697-63fc-08d9fb494568
X-MS-TrafficTypeDiagnostic: CWLP123MB2948:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB2948AC6E62975436074A161992029@CWLP123MB2948.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: F8XijRybBPIe4Ck85JMl6/s4Pa9eskmBW2TI4nROJ0XYkTxMuWYny1uJZRy6DvnvPvTHmuLyRA7LmHz+qafsPWuxng2RhmHg/S4IN0RkqpgyWHHjrjrtdJJmv/ZkV2NcdqjDtUsFhUWIvrf6IF1QMllWWDFunvZhfZUPIlgdDsOYzPROMxWMuQuQXooRvqKcBED2kbIRujIptIEQAzrEIaTG4XTBL39dttZdVd9hXYxB8idovdfUq9I/2FnZDdaPFxEbzknbC4bLbgcCQB7xEZMsIDlQTOyP+MdCzG0tt4nCCt0eihpYIcnDi8kYI2NtR7qwR76RG4lMjjJgdbkgAB25BZ1eUB3+cWaSedG4SS6cPtnz0F2yaSb4icTndNmuC4ZhcsI1/Yc9jCXj4V75S/2NOrsNJ1AeFCPDYVHIjdCmnTYqlJyIgXAsYXdMKXK06ZCRDoHKT0tlXH2E5peSVGhv6Ur6dOIdhecYlJh4gbf8+pdvhsIggR30N66POshKgwNngsPhiD2B/X623OeVCb8Al3K4SBqUGOZyg5QoHVZuqF4TtjE2mJ4T0ofBx4aZCxunxC1l46l0CjTziL/OR3Ipv/QJ5X2dgy87OX44EdausF6VXrK/mQXTq+2NYm1LGHBpJCC2t7mn7PCK8pO/IprnMHL6j/oT9VTEtH6V6o8g67AhFXqah7BDhnAdEx0colziFjPVOn1md505iYmW/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(2906002)(1076003)(86362001)(26005)(186003)(52116002)(2616005)(6506007)(83380400001)(8936002)(6666004)(8676002)(4326008)(6512007)(66556008)(66946007)(5660300002)(66476007)(6916009)(316002)(54906003)(508600001)(6486002)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U73N87kceHzAAF5HoKvuMFb26gBy5NDSRiSBvSLADrFTeP9llHIR+WGhRXhE?=
 =?us-ascii?Q?y8kFApFLasfkfAur2PTOphokLh9dT55BGa09pRBwDkbyVLzEaXe+IrrDOY6W?=
 =?us-ascii?Q?nGnLP4ILKXiFZm++6oX5C2W6xaVDnEMWkYM7JoDILYIFnFob5wq4Dax1OZVV?=
 =?us-ascii?Q?ifMBYTBHQHOh5wM/Kg7dHi3WSQxmuyzc3EVQYUkekbxf3ig+zstBxyKw3PxV?=
 =?us-ascii?Q?3zv3isEq1Bv1JCLHLisAcWOfbVDQEVkdILJabKUaWqwimsb1OArBvwdldpdB?=
 =?us-ascii?Q?M0IJLYtTrIHfEafZCI619ooqM2B6bSE9D9S1DMi/SsDgDJCPVcVRMQVy0FAr?=
 =?us-ascii?Q?fynp1XLJU2LAIeZ7AqK2RK2bRqES7eLBa7IgdbZ+c6lbHHZez+aSBECy4Da9?=
 =?us-ascii?Q?Y7ENyHtjfMrFDB6MiPTMJq9fdpZFWULsr9aGBYxDLl/z7t8mj+MG0IIUKdF0?=
 =?us-ascii?Q?eBnpgUy8pyJ8EluMktBEIQRo0v5UcQQkaWOODBQ7A5DUkpX8JYJU7wYkEOFk?=
 =?us-ascii?Q?GRbP+uF/Bi4qxfuz5X/+EmbTyrxuAQ3xr+NpT/Y6dIr8NZ+9hQ4H6LPRVccZ?=
 =?us-ascii?Q?SFssrOnCDTuZybC7POxET02TEZvmaKK/3KiU9R7UAURTf7PBB5YPUlIzuHKN?=
 =?us-ascii?Q?14JQ7fJU8ZaLF129/+w6z2qVuSBfnSG9/vNlwBOQaASs25wmrAwm1GFHsJqB?=
 =?us-ascii?Q?kMf4N/BthOs8xJvduWeoIbzJfB7dAhljY8smxqVpRVqJwfipOwNK6pmR1m0t?=
 =?us-ascii?Q?EIqYPBeniAZ4V5XiW/YGVFfxuNkJQrLl8aUVS3Zmwvms2e3KLEJpyi51Ty4N?=
 =?us-ascii?Q?RDql3cNKtURUo/1rpMUwnpuiken8sT1jXzzD4L/w8glKCCq+0mnnHgWFi+yE?=
 =?us-ascii?Q?hGAECPqF3xdqIvbdpLMho/16sXfzc2FcT37Al5dWmsQyzpTNPeIafRDQ/3Ie?=
 =?us-ascii?Q?MPp9BDaTKpDUUAkRmiY7l4U2RIMGLtSuGag5RtcA59zOYSY9EZVzBtYFaScW?=
 =?us-ascii?Q?FHiLJunIjE4/qhFm/hLn+OPBjXwPLJXotblkXVIlSXUXHqSOhd32vcYguceX?=
 =?us-ascii?Q?vn3ZOfbLcRKKr3UPc+H94eNSoJHp0WVRtNsky3QBf+Yiy6stp4DjnXtEC+Uu?=
 =?us-ascii?Q?eFdqKqDCK1+gDM2MLJ+66RGa7as1UROZZ0rD2C+uFigE/igRN3+dmtYYsY/M?=
 =?us-ascii?Q?mwCJATgX5aDnu5YDl6NED7ixMKGMRqlclczgQ/nfxtMROYwI5NyZae3x9mR/?=
 =?us-ascii?Q?hpsKR0T8fxqPirMwbjUwAF0XbPQL8JNILRI3UKEs2pdRvCUNmEyS2KTW85Yn?=
 =?us-ascii?Q?wdLdY3i9GqxiYuOx/YElquKhAHsCHJlTofIB0UY20ifaZtKSFFPdIaD4qXxp?=
 =?us-ascii?Q?DfEmoZ9C8tN54MP75Sbbmk9xPiopYxUth4kAvNilTN52Ha3h+tiXGLNjiChb?=
 =?us-ascii?Q?hcSmXR3PItSvoMhT1v65TVJW0NmeGWl3zKY9Ruu6VF/5iU+IPv8tqAKzmlC1?=
 =?us-ascii?Q?KBUUwRYFFO+In+IPHZZ0RjLfQNQq4OVn8/bR0zTGwNttQB2EI6uLosrdnyxU?=
 =?us-ascii?Q?n+M06/wofcu/ks7t2JvOCVZQKzmHoIpxorGYJEdxjVPRDQrtD7/qW4hDJ/pX?=
 =?us-ascii?Q?Uz6n4V81VvkXK5FzBNwkqAKoGeBuogkJ7iXg3gOd9zOSb4MjI6g3WXCGMF+q?=
 =?us-ascii?Q?WtprkmbUXvH/CKEw5bOGnFP8qMU=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca740dfd-f7fd-4697-63fc-08d9fb494568
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 06:03:56.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4iBvLgvceFp95yXE7H2Bcp9dPgkR9xtQScUlse1nqKasWlH+0bJG9RcNoFDsPOn2TXy4qERBFy7vmgqTo0LMoxrpgejM1oT/W+OGaFLHyE=
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

Let serial core know that the chip automatically handles RTS/CTS signal.
This elimines completely unnecessary I2C/SPI bus traffic.

Cease reading from RX FIFO (by disabling RDI interrupt) when throttled.
Eventually the FIFO will fill up and the device will drive RTS output
inactive. Unthrottle by enabling back RDI interrupt.

Indirectly controlling RTS via RX FIFO state seems to be the only option
because RTS bit is ignored when hardware flow control is enabled.

Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 5c247b4a01a9..683dd3be010d 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -957,6 +957,29 @@ static void sc16is7xx_start_tx(struct uart_port *port)
 =09kthread_queue_work(&s->kworker, &one->tx_work);
 }
=20
+static void sc16is7xx_throttle(struct uart_port *port)
+{
+=09unsigned long flags;
+
+=09/*
+=09 * Hardware flow control is enabled and thus the device ignores RTS
+=09 * value set in MCR register. Stop reading data from RX FIFO so the
+=09 * AutoRTS feature will de-activate RTS output.
+=09 */
+=09spin_lock_irqsave(&port->lock, flags);
+=09sc16is7xx_ier_clear(port, SC16IS7XX_IER_RDI_BIT);
+=09spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void sc16is7xx_unthrottle(struct uart_port *port)
+{
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&port->lock, flags);
+=09sc16is7xx_ier_set(port, SC16IS7XX_IER_RDI_BIT);
+=09spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static unsigned int sc16is7xx_tx_empty(struct uart_port *port)
 {
 =09unsigned int lsr;
@@ -1062,9 +1085,13 @@ static void sc16is7xx_set_termios(struct uart_port *=
port,
 =09regcache_cache_bypass(s->regmap, true);
 =09sc16is7xx_port_write(port, SC16IS7XX_XON1_REG, termios->c_cc[VSTART]);
 =09sc16is7xx_port_write(port, SC16IS7XX_XOFF1_REG, termios->c_cc[VSTOP]);
-=09if (termios->c_cflag & CRTSCTS)
+
+=09port->status &=3D ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
+=09if (termios->c_cflag & CRTSCTS) {
 =09=09flow |=3D SC16IS7XX_EFR_AUTOCTS_BIT |
 =09=09=09SC16IS7XX_EFR_AUTORTS_BIT;
+=09=09port->status |=3D UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
+=09}
 =09if (termios->c_iflag & IXON)
 =09=09flow |=3D SC16IS7XX_EFR_SWFLOW3_BIT;
 =09if (termios->c_iflag & IXOFF)
@@ -1270,6 +1297,8 @@ static const struct uart_ops sc16is7xx_ops =3D {
 =09.get_mctrl=09=3D sc16is7xx_get_mctrl,
 =09.stop_tx=09=3D sc16is7xx_stop_tx,
 =09.start_tx=09=3D sc16is7xx_start_tx,
+=09.throttle=09=3D sc16is7xx_throttle,
+=09.unthrottle=09=3D sc16is7xx_unthrottle,
 =09.stop_rx=09=3D sc16is7xx_stop_rx,
 =09.enable_ms=09=3D sc16is7xx_enable_ms,
 =09.break_ctl=09=3D sc16is7xx_break_ctl,
--=20
2.25.1

