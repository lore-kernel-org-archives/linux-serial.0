Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD38C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 21 Feb 2022 11:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355778AbiBULRT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:17:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356099AbiBULPv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:51 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2C3B63E4
        for <linux-serial@vger.kernel.org>; Mon, 21 Feb 2022 02:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1645441016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9IN5E8svo2s9/jUURPs22fmQ6amy9o1Ey56PjI/awko=;
        b=ILFObbSPrLnDVEpPqIcjtiX3zy1tsruyADnD1Z0SxrjH2x9f5Uqa5j49elq8vUapWQCbd2
        ZZmPbPnKsXBcP2+hoXwNrMtEE5AK6fiPkVJ1O0suGTNLcQ3Oqi7/hbnwn26hQI23mW8mSL
        +rWMhv2LRA3OQUz1VHm2aD/fsYC4FRo=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2057.outbound.protection.outlook.com [104.47.21.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-186-6sEc884mMz64zYl4nT9zAg-4; Mon, 21 Feb 2022 10:56:55 +0000
X-MC-Unique: 6sEc884mMz64zYl4nT9zAg-4
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 10:56:52 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%8]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 10:56:52 +0000
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
Subject: [PATCH 5/6] sc16is7xx: Handle modem status lines
Date:   Mon, 21 Feb 2022 11:56:17 +0100
Message-ID: <20220221105618.3503470-6-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
References: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36dc41ba-a9cc-4787-d5b4-08d9f528de0f
X-MS-TrafficTypeDiagnostic: CWLP123MB6574:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB6574A2C3132BC0B302DCB4C5923A9@CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 2bh9EqyvekNanNcJfwx9CIGSqwR3yVirHojSPjMVOBl4c0vioU8lGaOdYxcZm5JltlJkyLeXOhabJOPSTlnLDcmbC/Y42H4YbiSo2jn4wAnkUVzfT1vmea7K0FoXMmCg635xmb/+11ffvFouTKvHNvSxy2cbHiAhzO7Mtt2uOof1u3ctOjHRMm0QlTc1+fJLVIUUXEY7/Jjyht4hXYLCnggdEM5xqiUXXMCDbTw8jHdmloG4ND8rpcjfpwSL/JUl8USMwAwYxJ/atpWvVqZ78fL08jje2UtI0R/puGfJGk0WtfUuO4RM8z8GMe5ivp3M7BqW//V1SJwuTXpXo90LmpMJ16JGyBiKbmk9NXSCd11JJknC/dpzq7euZGr6O1HsWYfNKyLyP2MMeca8UdBG+L3PrgZXDcQcwCsE/qUxMUHMYBONXM1LxgBiwo53gYb0vYVStRZAInX8hbhyCr/jHZ+AiVK8AgL5InjdmVWa5m7xUJoh7X6QfVZnq7M4IvuQK5i7cGGikN8GV7ZPSVKqz5emgbKzJnKch+g3s+0afrXJZ0i272MMTE7RWObNfBVKUdl/Gj9SR6F68WyHT4Z6eqUyS0K5xppYG31aXGTb8c0kjoAVeKdF58UDKxgF97fTBBVyWHr9WdRRvCRh95YxQXGv9LGGSg5xr9wiaR+63+bswB9loVZLjK7Muu39EolQVXAQTNiAm51LCvi7iVX/pZq/Mpf2b1fNdsNCkBeOupk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(52116002)(6666004)(6512007)(6506007)(5660300002)(508600001)(8936002)(38350700002)(38100700002)(36756003)(2906002)(86362001)(4326008)(8676002)(6486002)(54906003)(2616005)(83380400001)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(186003)(1076003)(326664003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtT1dFveJpcfsrPt87n0uSij8LgZsgrtoX5dXScQuyggM2DiktZBADYDMDte?=
 =?us-ascii?Q?LdlDUdgDfkPeenR+eeGvceaczywLcqBA5QWRkgkqKgmV9TeokrEsc76nx3ZZ?=
 =?us-ascii?Q?cLtQdx83MnvLy7qo5ZPIdDV18KcZtnapEFWDfa79744CrmTXvJZseJXHzSYE?=
 =?us-ascii?Q?D/YBiIxV2PHJ2pp0J5AG5NJ91fPafmBpVpHmP+BzrKPGYsvjr9U4v8GYiYT9?=
 =?us-ascii?Q?FxXUIugynPoA33HIqbrgqQ6tdJTsXPHRnTn68YM3u1tjdv8DlEH7+Nk3Adp1?=
 =?us-ascii?Q?dS08T2B3jVCOtWcAaBQ/U/wCRhVcol5yC3QYjDpLsQaFR2PgI73VnsBP0XPo?=
 =?us-ascii?Q?XdmhpsZvKMXPcoYjOsn32k9uzIlMy+UydgvyaaG/RFZGnBDIMK2ujgJ2ROst?=
 =?us-ascii?Q?1+Inq6wog3uuC/Yzy09liJ5E+72J5KgbV9vyDqlK94wKuScSEx2sdGuBd+m+?=
 =?us-ascii?Q?FIud44RHbbbF4HEaei1vOK91iV8VU/tbFCKEvOYMDdagLcjannqoPyKOVi6v?=
 =?us-ascii?Q?V6LzmXNhejAuLII/9QpgwzvfNgRor6/Tsd7LMFgH1EIl2D/t/1AEFQDDxXFd?=
 =?us-ascii?Q?4LoUdALDUcLzKBeqlG25k1iavMddFuJRyfpJARuvnOU47Ws/HERxUvuQQR2S?=
 =?us-ascii?Q?AT7EQ1Ky6TJNwb9CHuLMOHFRzSKgtrqsJ3tSTR/nzIDzFRri9tmMm7yjIF0S?=
 =?us-ascii?Q?eMX7wv/kwMK74ajPGHKf2FRNcarC2+qkwmqhjFiFivQtwL3Jo+T1gfXq1DKO?=
 =?us-ascii?Q?zHK4fjCH3/gEGyEEWoF2f/ceqCJhmzXzW8p6xsNehlxa9stuO885N+3W1j31?=
 =?us-ascii?Q?k75q6P9042Jl5loL/Q2JWHXzOIO6wgTpIs1nY7lToVnqfgpz8M/93cltVR8K?=
 =?us-ascii?Q?VR+1mWLNBzv1teY8xxO9hg48HB5IZSzvaBQeJ5kijZ/r7nxAyEETTqoSdioI?=
 =?us-ascii?Q?tUcAzgR9x7Tdc+evS6/A/gs9lyA6b/aF5O3R13sxtEH6Gwm+sjiUOoO/hm43?=
 =?us-ascii?Q?tgCA5dhOeWXgoNNz+4PZjVtcc5U0jbRJc1jtS9cBmt/oL9WiaALp9Dx7+f+F?=
 =?us-ascii?Q?isyVoSXmyuaSjg1gj1yVzzeq/IQBMLPXk777CqJ6V88jP14vu5Np0Mj7YoyL?=
 =?us-ascii?Q?jmPmfkTWau5HdojNFCOf72EPmhIo5MMtDkMY0sYQkdBu7s8J1HucpUrRx3oK?=
 =?us-ascii?Q?0H+Du/16ezyMytpOzhwzznJVCi+FsJNQF8HSZ0E74m8iNGFErsrc0SMvvAFj?=
 =?us-ascii?Q?68h0F/yAN5fJ1K+dxKleBU3xWpW8eByjqPoix1UYyGQvLtpUWbhsFSGF6uVY?=
 =?us-ascii?Q?bRjh5cgCCE0Ui9BIek7lghXekG9ViSgYw1nGolVM0Kh8q4Utm3p7AOqPuAKI?=
 =?us-ascii?Q?WMbVLQNjavdmqFhZmnIMXPQOc0oxeWmS+b7NTgUOpQmIDdHWbcHwSa+xu+qK?=
 =?us-ascii?Q?DXGyevRwkqHyWqmjfZeqeHONGOuEOZEk9H/d5J9GXELpxg8mxsJJS/9ry5hL?=
 =?us-ascii?Q?pWxbZd5GVl919l+zY4/mOVLlP8l2UGOtffCzRZaU2SqXZDyI1+C2lKYNlWc4?=
 =?us-ascii?Q?AU0Uq/X3tROtGJSFXGTeZsoxx/W+W8AvouV+d3M41drYf0jZw6OlGx+CKlmd?=
 =?us-ascii?Q?BBc2Qe7NIBxL1F37ylHS1OFMf7LTsAD+6WfubQTTcz4Epl3QDqj/ttJ5BS8c?=
 =?us-ascii?Q?EsACQuQZHnasNQp/9FHGY/uj2XQ=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dc41ba-a9cc-4787-d5b4-08d9f528de0f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:56:52.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peg+jPE7WDyscpk0wSPMfMs3bmvrmskzbEU13ezSX5bar2GxTdHRfmgKYJwY487mfWaBnEDNKOEiDLN2hKoWwNJSD6RpHiL4ike/tK6rrbo=
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

