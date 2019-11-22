Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26D4C432C0
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 10:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABED920707
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 10:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sHc5+4Aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKVKA6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:00:58 -0500
Received: from mail-eopbgr00055.outbound.protection.outlook.com ([40.107.0.55]:41475
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfKVKA6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 05:00:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJNyIcZhsdck3Kh0KXQJdo6wMpg4ph9wUhV01yoCJmBVgWTR+KvwITADzI6uXRPlcOxROI+PlB33dx7p7SRY/SnyfRed2abWYESdeyfQlsyZ/MdeX4JL0WZycK1GnNwqdqp4ivn0+pi/Ti3ejIoP8K/KC/AEyThaYntRLHv276s9jP3Ma92fzUChHU2XiyAMYloF4SbsoN3X4DUmdvmIby6dq3EBr8onw+5lMQJR/KGSBPzBkfvnySJZcL3Xadclj1tukXfN3+JjsQ9V/aFGYESNprn+T/LfLL2OuzU4mefn30S0zhtlrhEoTH1szJp1J4zQCiKhV1RVkymbBohbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xwoYCFqi0ewOmjG2pAGoRO1UYkvwc2rZqYWT8ApOGI=;
 b=gi2iYyDHOjEL/3Wk5rhJp7Jy/zH9EVA241zq5BtUUajlfLR/l/DGUQc3K+iRVGAkTk3PXB/a/avuQYaOrVfLRPN9Q4HsP1JXnEE7wzF+mUVdN+I3Gq4K8SjgQ1uYgJbEvurW92Xmq6IMPKqfTv+zpM60iT5ituGPa1RTtCWnEnhc5Re34P06SmBFi3zUsyZx+OUj6fPyJ26PguUBhN+oeLKjKayu4RiUQoTNVx8T6UvbQ4YXAqFQJu43fJAFSTajrG7LdIOp3pjQaFHQa50W/hWE4hPes3HEKNkUWu1tst3vGgu0+/ChnELFaShjfJVZFR36dMD+s37+d/c9zXBrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xwoYCFqi0ewOmjG2pAGoRO1UYkvwc2rZqYWT8ApOGI=;
 b=sHc5+4AjEFNWglaIEh/GuEo4GJd2XtRea5iTgU8xqqm1CJL3ssdXUwQHuJbwKw2uBLXoxUGOFAMXRVw34ysDVucsqkQ/mdDqH3Ghs1HSTOQxrPupCzGZ3FP7DlK1efqWXXGLGK40q5so0cYpEF67TD3or68+YKY5ZxWHBjGDQKQ=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB3423.eurprd04.prod.outlook.com (52.134.4.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Fri, 22 Nov 2019 10:00:53 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::30e0:6638:e97c:e625]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::30e0:6638:e97c:e625%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 10:00:53 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        Andy Duan <fugang.duan@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: [PATCH tty/serial 1/1] tty: serial: imx: fix sysrq lockdep issue
Thread-Topic: [PATCH tty/serial 1/1] tty: serial: imx: fix sysrq lockdep issue
Thread-Index: AQHVoRu6Bk8vNebpvUC1GhrGJLMZuQ==
Date:   Fri, 22 Nov 2019 10:00:53 +0000
Message-ID: <1574416632-32321-1-git-send-email-fugang.duan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0046.apcprd04.prod.outlook.com
 (2603:1096:202:14::14) To VI1PR0402MB3600.eurprd04.prod.outlook.com
 (2603:10a6:803:7::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 966098bc-9103-4e92-fcef-08d76f32dc6b
x-ms-traffictypediagnostic: VI1PR0402MB3423:|VI1PR0402MB3423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB34238FED0395EFFB74C095E5FF490@VI1PR0402MB3423.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(36756003)(6512007)(54906003)(6486002)(14454004)(52116002)(305945005)(64756008)(66556008)(8936002)(66446008)(66476007)(50226002)(25786009)(5640700003)(2501003)(6116002)(2906002)(66066001)(316002)(3846002)(2351001)(6436002)(81166006)(71190400001)(71200400001)(4326008)(6506007)(186003)(386003)(256004)(86362001)(7736002)(2616005)(478600001)(5660300002)(81156014)(6916009)(99286004)(26005)(102836004)(66946007)(8676002)(1730700003)(5024004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3423;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s40+nKV4xcUZHA9BEqDBzeArWPVauYC4svXdsJaQolDtRC57mBm2XuRBaptckzP14WYcnYKFApjIVn3Ovjid9NF1/2dAl6hO31atrbwTTbymrnVCOcti9+XLcOaQjsSQH0qKsvtQBKSNHsb7YHiYXydZWawIzz9ocw3zxtyIm640A0SUjpI8hDlqsplXJRmbXkLn4LYR4gX9KQWMqvhwXBK01gWIUU+cnxC6e7JPwKkzK2e7sq/Gk993ro/LBWkqfdujj/bKF1Syrb9vMf5VV6voAJtGQt8zvEdqIDtsJ1KYSkMlwSbb6DN4b8+oAWviMRE+IJxyinScCnEm+tu+lg5pFQOSAS7LJZGAUxpcuaWD7QsDnUGy35ccJqo+GnJ86h2fjyGqCdJ0MCN4Hpd9KprgC3Mr9p+MX5VtVIsP60nx5/YwZNZNucFDN32cb7Mc
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966098bc-9103-4e92-fcef-08d76f32dc6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 10:00:53.7604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /LBfY1nMPGrdb/4YuG6PjVmsX5p5AK3L4Nltqwhc+FoKW4kPBEFA0h7TauH5X1BUPFCvS6T4bf6PZwB623omdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3423
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

commit dbdda842fe96 ("printk: Add console owner and waiter logic to
load balance console writes") introduces the lockdep issue for imx
serial driver in sysrq case:
     CPU0                    CPU1
     ----                    ----
lock(&port_lock_key);
                             lock(console_owner);
                             lock(&port_lock_key);
lock(console_owner);

It should unlock port_lock_key in handle_sysrq().

lockdep splats:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
------------------------------------------------------
swapper/0/0 is trying to acquire lock:
c141e540 (console_owner){-...}, at: console_unlock+0x180/0x5e4

but task is already holding lock:
d864e450 (&port_lock_key){-.-.}, at: imx_uart_rxint+0x18/0x294

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&port_lock_key){-.-.}:
       imx_uart_console_write+0x1b4/0x1dc
       console_unlock+0x2a4/0x5e4
       register_console+0x1ec/0x3b4
       uart_add_one_port+0x480/0x4e8
       platform_drv_probe+0x48/0x98
       really_probe+0x1d8/0x34c
       driver_probe_device+0x5c/0x168
       device_driver_attach+0x58/0x60
       __driver_attach+0x58/0xd0
       bus_for_each_dev+0x74/0xbc
       bus_add_driver+0x150/0x1dc
       driver_register+0x74/0x108
       imx_uart_init+0x20/0x40
       do_one_initcall+0x84/0x348
       kernel_init_freeable+0x11c/0x1e0
       kernel_init+0x8/0x110
       ret_from_fork+0x14/0x20
       0x0

-> #0 (console_owner){-...}:
       lock_acquire+0xcc/0x204
       console_unlock+0x208/0x5e4
       vprintk_emit+0x108/0x2c8
       vprintk_default+0x20/0x28
       printk+0x2c/0x58
       __handle_sysrq+0x178/0x1f0
       imx_uart_rxint+0x234/0x294
       imx_uart_int+0x210/0x2f0
       __handle_irq_event_percpu+0x48/0x34c
       handle_irq_event_percpu+0x2c/0x88
       handle_irq_event+0x38/0x5c
       handle_fasteoi_irq+0xc8/0x180
       generic_handle_irq+0x20/0x34
       __handle_domain_irq+0x64/0xdc
       gic_handle_irq+0x48/0x9c
       __irq_svc+0x70/0x98
       cpuidle_enter_state+0x16c/0x520
       cpuidle_enter_state+0x16c/0x520
       cpuidle_enter+0x28/0x38
       do_idle+0x1dc/0x2b0
       cpu_startup_entry+0x18/0x1c
       start_kernel+0x404/0x4cc

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&port_lock_key);
                               lock(console_owner);
                               lock(&port_lock_key);
  lock(console_owner);

 *** DEADLOCK ***

3 locks held by swapper/0/0:
 #0: d864e450 (&port_lock_key){-.-.}, at: imx_uart_rxint+0x18/0x294
 #1: c141eb88 (rcu_read_lock){....}, at: __handle_sysrq+0x0/0x1f0
 #2: c141e4c0 (console_lock){+.+.}, at: vprintk_emit+0xfc/0x2c8

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[<c0112e30>] (unwind_backtrace) from [<c010cdc0>] (show_stack+0x10/0x14)
[<c010cdc0>] (show_stack) from [<c0d2a73c>] (dump_stack+0xe0/0x114)
[<c0d2a73c>] (dump_stack) from [<c018f744>] (check_noncircular+0x138/0x1ec)
[<c018f744>] (check_noncircular) from [<c0191730>] (__lock_acquire+0xe00/0x=
2418)
[<c0191730>] (__lock_acquire) from [<c01935c0>] (lock_acquire+0xcc/0x204)
[<c01935c0>] (lock_acquire) from [<c019e41c>] (console_unlock+0x208/0x5e4)
[<c019e41c>] (console_unlock) from [<c019fd38>] (vprintk_emit+0x108/0x2c8)
[<c019fd38>] (vprintk_emit) from [<c019ff18>] (vprintk_default+0x20/0x28)
[<c019ff18>] (vprintk_default) from [<c01a04e0>] (printk+0x2c/0x58)
[<c01a04e0>] (printk) from [<c061e990>] (__handle_sysrq+0x178/0x1f0)
[<c061e990>] (__handle_sysrq) from [<c0635cb0>] (imx_uart_rxint+0x234/0x294=
)
[<c0635cb0>] (imx_uart_rxint) from [<c06376a8>] (imx_uart_int+0x210/0x2f0)
[<c06376a8>] (imx_uart_int) from [<c01a1cdc>] (__handle_irq_event_percpu+0x=
48/0x34c)
[<c01a1cdc>] (__handle_irq_event_percpu) from [<c01a200c>] (handle_irq_even=
t_percpu+0x2c/0x88)
[<c01a200c>] (handle_irq_event_percpu) from [<c01a20a0>] (handle_irq_event+=
0x38/0x5c)
[<c01a20a0>] (handle_irq_event) from [<c01a6930>] (handle_fasteoi_irq+0xc8/=
0x180)
[<c01a6930>] (handle_fasteoi_irq) from [<c01a0e10>] (generic_handle_irq+0x2=
0/0x34)
[<c01a0e10>] (generic_handle_irq) from [<c01a1418>] (__handle_domain_irq+0x=
64/0xdc)
[<c01a1418>] (__handle_domain_irq) from [<c054bcd0>] (gic_handle_irq+0x48/0=
x9c)
[<c054bcd0>] (gic_handle_irq) from [<c0101a70>] (__irq_svc+0x70/0x98)
Exception stack(0xc1401ed8 to 0xc1401f20)
1ec0:                                                       00000001 000000=
06
1ee0: 00000000 c140c600 00000001 5b0881e8 c140f934 db6eadb8 c1504668 000009=
8b
1f00: 0000098b 5c28eb3d 00000000 c1401f28 c0194520 c0938fcc 20070013 ffffff=
ff
[<c0101a70>] (__irq_svc) from [<c0938fcc>] (cpuidle_enter_state+0x16c/0x520=
)
[<c0938fcc>] (cpuidle_enter_state) from [<c09393bc>] (cpuidle_enter+0x28/0x=
38)
[<c09393bc>] (cpuidle_enter) from [<c016f6a4>] (do_idle+0x1dc/0x2b0)
[<c016f6a4>] (do_idle) from [<c016fb2c>] (cpu_startup_entry+0x18/0x1c)
[<c016fb2c>] (cpu_startup_entry) from [<c1300e20>] (start_kernel+0x404/0x4c=
c)

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/imx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a9e20e6..a665439 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -736,6 +736,7 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id=
)
=20
 	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
 		u32 usr2;
+		int sysrq;
=20
 		flg =3D TTY_NORMAL;
 		sport->port.icount.rx++;
@@ -749,7 +750,11 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_i=
d)
 				continue;
 		}
=20
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		spin_unlock(&sport->port.lock);
+		sysrq =3D uart_handle_sysrq_char(&sport->port, (unsigned char)rx);
+		spin_lock(&sport->port.lock);
+
+		if (sysrq)
 			continue;
=20
 		if (unlikely(rx & URXD_ERR)) {
--=20
2.7.4

