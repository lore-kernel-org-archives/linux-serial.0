Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C56EC433EF
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 06:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiCAGEk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiCAGEj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 01:04:39 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21BA160D84
        for <linux-serial@vger.kernel.org>; Mon, 28 Feb 2022 22:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1646114636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9IN5E8svo2s9/jUURPs22fmQ6amy9o1Ey56PjI/awko=;
        b=J465ClMe0fUnLfQ3383Q7tiDNXWdl0GL6MgQRSluJYRupyktBjGttvsKOESU6JHk+NnxAc
        qeHFnhKfoS6kQSaw4ecuSX7beob+hUmvNxKqkXmXaREpGw3cckfOm81o0XXwapCglyLP8P
        NWAyR0K6WMKI42Mftbb/cUdow1VjJF0=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2058.outbound.protection.outlook.com [104.47.20.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-15-7CU9LN-tPTGROlumn7XZkQ-1; Tue, 01 Mar 2022 06:03:55 +0000
X-MC-Unique: 7CU9LN-tPTGROlumn7XZkQ-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB2948.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 1 Mar
 2022 06:03:54 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 06:03:54 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-serial@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Daniel Mack <daniel@zonque.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH RESEND 2/3] sc16is7xx: Handle modem status lines
Date:   Tue,  1 Mar 2022 07:03:31 +0100
Message-ID: <20220301060332.2561851-3-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301060332.2561851-1-tomasz.mon@camlingroup.com>
References: <20220301060332.2561851-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO4P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::11) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fcfa6b5-de6f-43c2-51af-08d9fb494432
X-MS-TrafficTypeDiagnostic: CWLP123MB2948:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB2948F9D3BF83E6A1824A8A9D92029@CWLP123MB2948.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: LYQU9ieIi85BVHAdSK/hVAe9peHQ4KDxXhLAo/HUfYGuCD7qO8uTXGSzR9/kviilft+XpGCiRwEsvP2gJ9TTQHL3EmRO5pktGqNm+QzQg2WO9AaJnI22s1GR1Kwug39vinErr8Wv/l3NjU7O3007aJs8tcx00I5/CBVBYiJcQr6rz1zivfiR+3fdzzjmtWN9ZU80RPyDAuMBSqN7/5SHME1hKFlmAZgkjQN7LAzZPCfdeFM0EA+Vy5PvUsFH8z9wa128R4RZ8UK+P4qUzMJHNw3snaNEqa19Scss4h1vvKGu1F5XNJIV2FjOndPreWDk72ayg1BzhVkego8FFLlw2MXyhybgmZlAWXh/ogwdGLeVd6lBiihkCfc/kyMXfvLmsIUcc3viyQOjQYgSUt7AgkyGPQ7aoJzqLU2p9NWyhE/seauW1f/XBd2C7XaukBFetsyTLQjET+00GerUHaoAyvFwxumCXjpTzfyuFiVEVRoxQswD4OkRxJm6xmPoR8Mj1+Iw45iOjbzUaz+d0+EseI1LGiAhzZZ62s8WSXwgdqiII1+YCnr6JR0+Pkto26pm8nafkpqYsLLVaw/q4SIsFLAfHxjYWfoX84AJ2KMAZimEs4/XvfO8dxfjOq4A1+zTQE5Lkx+U3khwLLYxuUI8weFRXUotappyeuM/ob9ccCjvRaAFACcdiTzamXTgtKFOF1OyV091mv/Wpz2QL/0rMrfYECpZA4RGzqc6FtGPy7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(2906002)(1076003)(86362001)(26005)(186003)(52116002)(2616005)(6506007)(83380400001)(8936002)(6666004)(8676002)(4326008)(6512007)(66556008)(66946007)(5660300002)(66476007)(6916009)(316002)(54906003)(508600001)(6486002)(36756003)(38350700002)(38100700002)(326664003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1mQsDhyPl7UAoEFTgT+9vTThGF8vGEz4EJq5DYbaN7Y1CjOcKDd57El4EUNs?=
 =?us-ascii?Q?N7bZ3Zh2M6oaN5s04zj5biddtLxM2ZGAexsme+xQyfBr+SgXWDCqhE2DIk47?=
 =?us-ascii?Q?81s0kHcHto8jRhKapaGO6hlpi0Clo0AREXSDnzZKIz1ESQq1m/F2EVj2GTqo?=
 =?us-ascii?Q?5lfBgVSIt1fOiQE/GTKUjSejz3o15sdkvvRgQ8EEMTf/uEZ5nQq2ne/+ZObw?=
 =?us-ascii?Q?0H/ywCKDkiJqq7wnaNUgLTzXSQz6ShEQcEGXIQOTk7guJGlIJaDCs1kIuS0y?=
 =?us-ascii?Q?ScgiBgf0ryP1PX5/P7WyOP5HpuNoVGGI07UdLh2QGve+m/7ciqGsTQqGDjYm?=
 =?us-ascii?Q?WUF1Xx5VIP1OOIgrRE0m1AiyK1caivmSQ0Xet6d/qSWaktmVzV6McvnEgcmf?=
 =?us-ascii?Q?YRoaixMvrtVHYIwCZI1+ykj7zDKaRaMdv2Fxhh/m7ESN0R7gDCQLHTmoo7gV?=
 =?us-ascii?Q?udovU/x8WcGwpWBVZQhTtRR/36yX73tr2Flqoi5TjUWSmpazNZkl4ikxWfCE?=
 =?us-ascii?Q?tt3/zdmrWCfPpCOtVZsUjZFtBIGJ/LPysLg1cTafNXvpQ1XUC705/t5vT0hL?=
 =?us-ascii?Q?ZYltnYSfB7l+vsJIPCn5gUAnbhLBTz6Svt/MAnMWAxbyBot4UkmnjZfu9Zna?=
 =?us-ascii?Q?bEO+dPYNrXfUi29FGmPG7Nz1GtPzyMAQxDYD0FosFSfGeuFubtZXYiUjvW1/?=
 =?us-ascii?Q?6jA4xAd+G6Dlero/S/ZrpuJdO/yFawabncJx2+v6KzRYSy53q+2sNJVSmag/?=
 =?us-ascii?Q?G6OUnM7BCL/XMh4Ija+pJ5hcvcxjfWfs8uHE8iIrFZvyCYymmAmotItuq5lf?=
 =?us-ascii?Q?iGvt7VRUevgaOsgkqKdctAMbQ01GrQ+g46TpOY2s6ToMiQRr2B2el9nGAkVS?=
 =?us-ascii?Q?qMaV9T0fAGkpEIjqblJbI+1cR0yfpZUvSDuTebY6Dt7ytN78oJD1eh6M8OTm?=
 =?us-ascii?Q?SqRtBVljKMN+06utQH4/2xH/KaP4fUEKCVOY6tdpL/knxc3DMgPQlmoiXxzm?=
 =?us-ascii?Q?H+eU6Z1M1I5DhsfDwyONHUL6SLuMwuNIKrWK3sbw2MV5ED6feAu3xSAC6BcM?=
 =?us-ascii?Q?MheCxdoj3+U0phOtpelvTohXeB+t+ggrhzkAdSTyAf3bySTL3P7lkgyl+c9K?=
 =?us-ascii?Q?oihA1jpC4q9pr+I68BDXmhtZOjwTK3FuUND/3fXSbZRK22I0kb4RxdAG+vy0?=
 =?us-ascii?Q?g9FGwRkJwy3GVIoY0e7kTkd6Npz7BYCbmfiFwi59JFz2ah1tg/H3dyclQpPr?=
 =?us-ascii?Q?8QTzb0GUp5g1xxDw5giNrp/Sab9ZcFBxDMF2qg6DdrnfxFCvYkTJPkfjcjBl?=
 =?us-ascii?Q?Ix/YPr+sMmM7fJ+23qthAgY7dhPrXDYBRlcshvCuM/TLKEvYJGNridI8cBTH?=
 =?us-ascii?Q?vTEXpXXY5tB9diaCgImjoT3uoiILNm3e/z4DSTYJ+hgCBvCg+TJMJK+RdtV8?=
 =?us-ascii?Q?/G+EEtYjUyubpoP1P+BtrLoALVPvWq5SfcnWkoopOgwDQZ7ByNGtN5K85mwP?=
 =?us-ascii?Q?4aGSdT9BQk6w/jOa5UWQnRYVoDLuPoBcwE5kY4Mn81tjpoVaI+QjKRLaufyQ?=
 =?us-ascii?Q?+KnOspVKHFgtKepXWDm3gzSKD/CWXHA3Y+0+G079aDUAQnu7DbXPgOBmu2f+?=
 =?us-ascii?Q?4KDNY5tp7xzCQwj5sNzW22LS+GKx8w7ZPEp7SNMk2ngMSDL6nP/t6fgqcxwb?=
 =?us-ascii?Q?Nf5iBj+6dlJ9w15vGATd4ivgcBc=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcfa6b5-de6f-43c2-51af-08d9fb494432
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 06:03:54.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujK9w3ZFc045W/zZmRAaPDYzbHoV1kepQ/UJsLY52ukq0qzdCpWFEER8wv4axba1WSCHCDg6RCdYEDRHGPNkvCoIXUIEYl8aGKH/OlnMDcY=
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

The uart_handle_cts_change() and uart_handle_dcd_change() must be called
with port lock being held. Acquire the lock after reading MSR register.
Do not acquire spin lock when reading MSR register because I2C/SPI port
functions cannot be called with spinlocks held.

Update rng and dsr counters. Wake up delta_msr_wait to allow tty notice
modem status change.

Co-developed-by: Lech Perczak <l.perczak@camlintechnologies.com>
Signed-off-by: Lech Perczak <l.perczak@camlintechnologies.com>
Co-developed-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 120 +++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 17e79af36604..5c247b4a01a9 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -324,8 +324,10 @@ struct sc16is7xx_one {
 =09u8=09=09=09=09line;
 =09struct kthread_work=09=09tx_work;
 =09struct kthread_work=09=09reg_work;
+=09struct kthread_delayed_work=09ms_work;
 =09struct sc16is7xx_one_config=09config;
 =09bool=09=09=09=09irda_mode;
+=09unsigned int=09=09=09old_mctrl;
 };
=20
 struct sc16is7xx_port {
@@ -705,12 +707,56 @@ static void sc16is7xx_handle_tx(struct uart_port *por=
t)
 =09spin_unlock_irqrestore(&port->lock, flags);
 }
=20
+static unsigned int sc16is7xx_get_hwmctrl(struct uart_port *port)
+{
+=09u8 msr =3D sc16is7xx_port_read(port, SC16IS7XX_MSR_REG);
+=09unsigned int mctrl =3D 0;
+
+=09mctrl |=3D (msr & SC16IS7XX_MSR_CTS_BIT) ? TIOCM_CTS : 0;
+=09mctrl |=3D (msr & SC16IS7XX_MSR_DSR_BIT) ? TIOCM_DSR : 0;
+=09mctrl |=3D (msr & SC16IS7XX_MSR_CD_BIT)  ? TIOCM_CAR : 0;
+=09mctrl |=3D (msr & SC16IS7XX_MSR_RI_BIT)  ? TIOCM_RNG : 0;
+=09return mctrl;
+}
+
+static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
+{
+=09struct uart_port *port =3D &one->port;
+=09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+=09unsigned long flags;
+=09unsigned int status, changed;
+
+=09lockdep_assert_held_once(&s->efr_lock);
+
+=09status =3D sc16is7xx_get_hwmctrl(port);
+=09changed =3D status ^ one->old_mctrl;
+
+=09if (changed =3D=3D 0)
+=09=09return;
+
+=09one->old_mctrl =3D status;
+
+=09spin_lock_irqsave(&port->lock, flags);
+=09if ((changed & TIOCM_RNG) && (status & TIOCM_RNG))
+=09=09port->icount.rng++;
+=09if (changed & TIOCM_DSR)
+=09=09port->icount.dsr++;
+=09if (changed & TIOCM_CAR)
+=09=09uart_handle_dcd_change(port, status & TIOCM_CAR);
+=09if (changed & TIOCM_CTS)
+=09=09uart_handle_cts_change(port, status & TIOCM_CTS);
+
+=09wake_up_interruptible(&port->state->port.delta_msr_wait);
+=09spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
 =09struct uart_port *port =3D &s->p[portno].port;
=20
 =09do {
 =09=09unsigned int iir, rxlen;
+=09=09struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
=20
 =09=09iir =3D sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
 =09=09if (iir & SC16IS7XX_IIR_NO_INT_BIT)
@@ -727,6 +773,11 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *=
s, int portno)
 =09=09=09if (rxlen)
 =09=09=09=09sc16is7xx_handle_rx(port, rxlen, iir);
 =09=09=09break;
+=09=09/* CTSRTS interrupt comes only when CTS goes inactive */
+=09=09case SC16IS7XX_IIR_CTSRTS_SRC:
+=09=09case SC16IS7XX_IIR_MSI_SRC:
+=09=09=09sc16is7xx_update_mlines(one);
+=09=09=09break;
 =09=09case SC16IS7XX_IIR_THRI_SRC:
 =09=09=09sc16is7xx_handle_tx(port);
 =09=09=09break;
@@ -874,6 +925,30 @@ static void sc16is7xx_stop_rx(struct uart_port *port)
 =09sc16is7xx_ier_clear(port, SC16IS7XX_IER_RDI_BIT);
 }
=20
+static void sc16is7xx_ms_proc(struct kthread_work *ws)
+{
+=09struct sc16is7xx_one *one =3D to_sc16is7xx_one(ws, ms_work.work);
+=09struct sc16is7xx_port *s =3D dev_get_drvdata(one->port.dev);
+
+=09if (one->port.state) {
+=09=09mutex_lock(&s->efr_lock);
+=09=09sc16is7xx_update_mlines(one);
+=09=09mutex_unlock(&s->efr_lock);
+
+=09=09kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
+=09}
+}
+
+static void sc16is7xx_enable_ms(struct uart_port *port)
+{
+=09struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
+=09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+
+=09lockdep_assert_held_once(&port->lock);
+
+=09kthread_queue_delayed_work(&s->kworker, &one->ms_work, 0);
+}
+
 static void sc16is7xx_start_tx(struct uart_port *port)
 {
 =09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
@@ -893,10 +968,10 @@ static unsigned int sc16is7xx_tx_empty(struct uart_po=
rt *port)
=20
 static unsigned int sc16is7xx_get_mctrl(struct uart_port *port)
 {
-=09/* DCD and DSR are not wired and CTS/RTS is handled automatically
-=09 * so just indicate DSR and CAR asserted
-=09 */
-=09return TIOCM_DSR | TIOCM_CAR;
+=09struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
+
+=09/* Called with port lock taken so we can only return cached value */
+=09return one->old_mctrl;
 }
=20
 static void sc16is7xx_set_mctrl(struct uart_port *port, unsigned int mctrl=
)
@@ -920,8 +995,12 @@ static void sc16is7xx_set_termios(struct uart_port *po=
rt,
 =09=09=09=09  struct ktermios *old)
 {
 =09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+=09struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
 =09unsigned int lcr, flow =3D 0;
 =09int baud;
+=09unsigned long flags;
+
+=09kthread_cancel_delayed_work_sync(&one->ms_work);
=20
 =09/* Mask termios capabilities we don't support */
 =09termios->c_cflag &=3D ~CMSPAR;
@@ -1010,8 +1089,15 @@ static void sc16is7xx_set_termios(struct uart_port *=
port,
 =09/* Setup baudrate generator */
 =09baud =3D sc16is7xx_set_baud(port, baud);
=20
+=09spin_lock_irqsave(&port->lock, flags);
+
 =09/* Update timeout according to new baud rate */
 =09uart_update_timeout(port, termios->c_cflag, baud);
+
+=09if (UART_ENABLE_MS(port, termios->c_cflag))
+=09=09sc16is7xx_enable_ms(port);
+
+=09spin_unlock_irqrestore(&port->lock, flags);
 }
=20
 static int sc16is7xx_config_rs485(struct uart_port *port,
@@ -1052,6 +1138,7 @@ static int sc16is7xx_startup(struct uart_port *port)
 =09struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
 =09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
 =09unsigned int val;
+=09unsigned long flags;
=20
 =09sc16is7xx_power(port, 1);
=20
@@ -1102,16 +1189,25 @@ static int sc16is7xx_startup(struct uart_port *port=
)
 =09=09=09      SC16IS7XX_EFCR_TXDISABLE_BIT,
 =09=09=09      0);
=20
-=09/* Enable RX interrupt */
-=09val =3D SC16IS7XX_IER_RDI_BIT;
+=09/* Enable RX, CTS change and modem lines interrupts */
+=09val =3D SC16IS7XX_IER_RDI_BIT | SC16IS7XX_IER_CTSI_BIT |
+=09      SC16IS7XX_IER_MSI_BIT;
 =09sc16is7xx_port_write(port, SC16IS7XX_IER_REG, val);
=20
+=09/* Enable modem status polling */
+=09spin_lock_irqsave(&port->lock, flags);
+=09sc16is7xx_enable_ms(port);
+=09spin_unlock_irqrestore(&port->lock, flags);
+
 =09return 0;
 }
=20
 static void sc16is7xx_shutdown(struct uart_port *port)
 {
 =09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+=09struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
+
+=09kthread_cancel_delayed_work_sync(&one->ms_work);
=20
 =09/* Disable all interrupts */
 =09sc16is7xx_port_write(port, SC16IS7XX_IER_REG, 0);
@@ -1175,6 +1271,7 @@ static const struct uart_ops sc16is7xx_ops =3D {
 =09.stop_tx=09=3D sc16is7xx_stop_tx,
 =09.start_tx=09=3D sc16is7xx_start_tx,
 =09.stop_rx=09=3D sc16is7xx_stop_rx,
+=09.enable_ms=09=3D sc16is7xx_enable_ms,
 =09.break_ctl=09=3D sc16is7xx_break_ctl,
 =09.startup=09=3D sc16is7xx_startup,
 =09.shutdown=09=3D sc16is7xx_shutdown,
@@ -1341,7 +1438,9 @@ static int sc16is7xx_probe(struct device *dev,
 =09=09s->p[i].port.uartclk=09=3D freq;
 =09=09s->p[i].port.rs485_config =3D sc16is7xx_config_rs485;
 =09=09s->p[i].port.ops=09=3D &sc16is7xx_ops;
+=09=09s->p[i].old_mctrl=09=3D 0;
 =09=09s->p[i].port.line=09=3D sc16is7xx_alloc_line();
+
 =09=09if (s->p[i].port.line >=3D SC16IS7XX_MAX_DEVS) {
 =09=09=09ret =3D -ENOMEM;
 =09=09=09goto out_ports;
@@ -1353,9 +1452,17 @@ static int sc16is7xx_probe(struct device *dev,
 =09=09sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
 =09=09=09=09     SC16IS7XX_EFCR_RXDISABLE_BIT |
 =09=09=09=09     SC16IS7XX_EFCR_TXDISABLE_BIT);
+
+=09=09/* Use GPIO lines as modem status registers */
+=09=09if (devtype->has_mctrl)
+=09=09=09sc16is7xx_port_write(&s->p[i].port,
+=09=09=09=09=09     SC16IS7XX_IOCONTROL_REG,
+=09=09=09=09=09     SC16IS7XX_IOCONTROL_MODEM_BIT);
+
 =09=09/* Initialize kthread work structs */
 =09=09kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
 =09=09kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
+=09=09kthread_init_delayed_work(&s->p[i].ms_work, sc16is7xx_ms_proc);
 =09=09/* Register port */
 =09=09uart_add_one_port(&sc16is7xx_uart, &s->p[i].port);
=20
@@ -1439,6 +1546,7 @@ static void sc16is7xx_remove(struct device *dev)
 #endif
=20
 =09for (i =3D 0; i < s->devtype->nr_uart; i++) {
+=09=09kthread_cancel_delayed_work_sync(&s->p[i].ms_work);
 =09=09uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 =09=09clear_bit(s->p[i].port.line, &sc16is7xx_lines);
 =09=09sc16is7xx_power(&s->p[i].port, 0);
--=20
2.25.1

