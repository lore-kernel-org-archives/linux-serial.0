Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB7FC433FE
	for <linux-serial@archiver.kernel.org>; Mon, 21 Feb 2022 11:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355786AbiBULRU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:17:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356098AbiBULPv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:51 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCE4F63EB
        for <linux-serial@vger.kernel.org>; Mon, 21 Feb 2022 02:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1645441017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N70pF1EaMXNZt6MNzvjBufnX9i+FKEFLF923zMoJmFs=;
        b=VbfJ+JoTtPmBCTa9rgQIk2tJFxfc1ELUqGKWVGBU5ZtLOlzk1h03/farZwqTRkgrIAxokC
        TWf4VJM97z/JZc7AefDKki9CatqAHRAMl9aKaQb7y66YyX7mkJ08fZI+xa62m1zDIajh1H
        ZD6eendSsp3Vrixwa5wE+stxZZqEpp4=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2057.outbound.protection.outlook.com [104.47.21.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-186-EHkzo4pPPDSWAscC7Ox4tQ-5; Mon, 21 Feb 2022 10:56:56 +0000
X-MC-Unique: EHkzo4pPPDSWAscC7Ox4tQ-5
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 10:56:53 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%8]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 10:56:53 +0000
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
Subject: [PATCH 6/6] sc16is7xx: Set AUTOCTS and AUTORTS bits
Date:   Mon, 21 Feb 2022 11:56:18 +0100
Message-ID: <20220221105618.3503470-7-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
References: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4deb4af-de20-477b-6262-08d9f528de6f
X-MS-TrafficTypeDiagnostic: CWLP123MB6574:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB6574D3292CCBF665B19AD4C5923A9@CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 2FtKaerXfdd+hhCxa1+jhTGvYyyoxgXylAYQde1j1hHWT8hNwfFGFZkC/1LVZQovoNUTibcDZxj3ZUNldT2TaTBI2/bv8Pie37trG3uVjnkEGKAFiIEZPs1CNGGFRecfntF2M8R+9sCyy3u+AmF9PGHXBF58NqyfEjCvRVZg7JPl9uKVm7+3rY2/MwveU1CVarbP4UtbAwctD/XK/fUblCPEx7NFU4DhZavyRxHTxvz0Zb8Mj7YulIvS+EQwjiL8XP/lhA13QsUsVV9gL7QoEbzYuzqPwSvTmjxrq0j/TuVjSKGs6XIXrHMqG6b/6O+dP9+BtApVHfY9F6gpMSMrOd2IPi1cXhHGE9rN8uaBp/kTpDAt5TV6tPHCILs82yrtBVviT4kvm1CcB0sgALVP2cwYyHtgZCYv72nTPo2YSugBgerS3qZ5F1Zc5HWZ82tFxLOVCMwOc6e6BwgT8MEtUpvKyC50XEwSz72FQq74p7kJV9RZhzm5czd8wKNCgFLI7G+AsIMSVqGsFnXqJD8VHbMg2iYgVauFKc4SDFhlriyF5kHH6yD5utV4i9tJOjmYRXaTl1oVli7hZyuD1tb20jMn7+2AffEdhlKb1ySERPZ/nclOZFdx52zOBFt/7oBnf7GQIwEYzDnzaHPogP8S5e0u7vZGCSO++1slKNVfZbQqenVJCG5aLSA4pN0SJMyH4cbPeDO87B/7zpv4LTGg+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(52116002)(6666004)(6512007)(6506007)(5660300002)(508600001)(8936002)(38350700002)(38100700002)(36756003)(2906002)(86362001)(4326008)(8676002)(6486002)(54906003)(2616005)(83380400001)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(186003)(1076003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hn59grffIpbE9FnVz52AS3XJXICFYeV6wOYahjk0ntHePOPla0j7/uEMtNjB?=
 =?us-ascii?Q?OdlaBu5cs4ziOfykVE8tJT3z0ezLNL/h2751YBVBVwDidWs9+WqfFQlx7N4J?=
 =?us-ascii?Q?yQaIiAOQfnJSx7PIxvfnW62hXEO26x+6bP8LP/xlpN7SZyegpa/BXsiQqGvk?=
 =?us-ascii?Q?qcC6o1sxesxZxsLLlUu+sloOOO5IohhH6halrJiKR7hClV4D1FiL7diEHSoH?=
 =?us-ascii?Q?glS7rsUOr9bWzj5WgHH0PZ4jga42KxLdDZ84IoTMCLIuyR7M8keDU7CQ3ijJ?=
 =?us-ascii?Q?S6/ERQWN6BzF/dav3t3spAtPfJ2WOaqQUCneMFI3I6fO30eAqWp41d4Wpq5P?=
 =?us-ascii?Q?+9Qxb470foKePwZ5l7kuoQdEeIbqWq6gY5wWLcIUECfImHfioPiKo0SxyzGb?=
 =?us-ascii?Q?ijdBB8sXrNNQyoHe2iGEpRHGcS9G/v9TyaJpWewOCvYXMXeTLtdH8zbERUOe?=
 =?us-ascii?Q?bYpx5zgXLxZevFPEMchX/FjJ0UgUfgJ9jK9bDYIwOQ86TyIu2KyTs3LbLjLd?=
 =?us-ascii?Q?BAczzl5tgzH+NKpOVIoEOg/6TlpczBDgWxroHpgu52tKpqMIBiUQMKmBk7zO?=
 =?us-ascii?Q?BlHJmdFbSJCXhBq8e9abpqqNI5YJi6gkBJjfN7PN+n4CGD+aQ0Q19A4x1hh/?=
 =?us-ascii?Q?LB6d9gqtTCnCndSilmTCMw3yDAToO204ztDRpzodmbXEqfw9MjNGQg/SD/QM?=
 =?us-ascii?Q?kL9yv/rbW6LwdgAyHfBvCZnRy9s7ThLFfdRsnhSdTl0pR6brHlhkyJ9Hu9gx?=
 =?us-ascii?Q?xXZHdUCfOyttNPMPrwOfwBxztS44V2vXYa71G3ixM0w5iVPCVHKlds3MQhN6?=
 =?us-ascii?Q?ez4Da4uHzSI5TzT00rzXkMy1Hj3siXK+fQmsSsg2L/FVFKH7HZY5VUF+J5Vj?=
 =?us-ascii?Q?SqiQ9BmZZ3NuxgFyIUCg+CwX1fLVyl7oP3jcS/M8qkNXYxA5q/nDhAx2O/K0?=
 =?us-ascii?Q?c/ZktHR5QmJ+d3zHhsZdvgLXgZ6UhYm8JlUHvLTDFX3N1Py9+FIdyRqGM9Of?=
 =?us-ascii?Q?yQnAYhfWs5I7v6ROkIHkUTcDznK8dEOs3X8/ZI+BrlzwZ3nfVPwjNkWmQLBM?=
 =?us-ascii?Q?NERiVT1yJMPSsLulwDwoGwnsRBZYUXtXnaZyNX/ESOGy+UCu7XvPvt8NTENN?=
 =?us-ascii?Q?fAiJkn7yNcHmyyxZiOB8OC9uOey6U4SU/4rerXtFwOtWR1khSsZ+aFFGTkzh?=
 =?us-ascii?Q?9DxLE1ImC7oB1IgmI+6vWPmf6xho9BMdomwKHR/cR0ACz8jD4/OPZ8Q4YLnB?=
 =?us-ascii?Q?AAoscuDfPSduQfI7KvOnykGf7uST9t5FT3Z5/oKr4KGIlVYzLqPLB/aRL3gm?=
 =?us-ascii?Q?oYcr3Y+ObSs/vWFwmjnuo6+0aoPFmb0bD5iD75k2vJCLZ2HkQmgsToFQrReh?=
 =?us-ascii?Q?H7gRije4IuJS6srYomy1N2aJnBNwHxGR3mWH6wl0DTMaLXWUPYidmPVpRfcJ?=
 =?us-ascii?Q?TjMxJfYvv/FdGu12pfjgKOPXmP38ydKrfWu8MgEWPP6HAcDsOSUuyATk4fuk?=
 =?us-ascii?Q?elxHLAHBRn8cJEkyXWbmOe2j1WqrXBOv0xEon5MQl5f+ydvKrJK9rouljVxc?=
 =?us-ascii?Q?DhfMtcfk+WX0Az2eo5t3u/QVw+TqDxsL/xBs88DJVrlM1pEzFYULPUDEQeCw?=
 =?us-ascii?Q?ZciWx/8CPQW4UV2zEiATIYsP454C2mtPa10cS/uiUPqveMQQaavRgS57TDU7?=
 =?us-ascii?Q?WsjRb3M8+sMcpdX9VIawsior0W8=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4deb4af-de20-477b-6262-08d9f528de6f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:56:53.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N75e4iXfj8L68PMDG+aR8FOu6VJFJt88tbLLPUhUQNtsITBd4h4iGSgTl5+FLx2IpCmxgF0kAdM3l0cmuiGhlCjQhECfQkVc4IFU7xTZqQs=
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

