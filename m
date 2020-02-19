Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5050AC34022
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F5321D56
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgBSIBl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:01:41 -0500
Received: from [167.172.186.51] ([167.172.186.51]:35440 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgBSIBl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:01:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9DE79DFF72;
        Wed, 19 Feb 2020 08:01:55 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wFbC0oxnXs5M; Wed, 19 Feb 2020 08:01:55 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F15E1DFFFE;
        Wed, 19 Feb 2020 08:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UlSuSspOoMA7; Wed, 19 Feb 2020 08:01:54 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id ACCCEDFF72;
        Wed, 19 Feb 2020 08:01:54 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] serial: 8250_pxa: avoid autodetecting the port type
Date:   Wed, 19 Feb 2020 09:01:30 +0100
Message-Id: <20200219080130.4334-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If we're unlucky enough that this drivers binds to a mrvl,mmp-uart device
on a MMP3, the port type gets detected as 16550A instead of XScale, and i=
t
won't work. Other drivers that may bind to the same hardware are 8250_of
and, god forbid, serial_pxa.

Force the port type, we know it's a PORT_XSCALE.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/tty/serial/8250/8250_pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250=
/8250_pxa.c
index c47188860e325..11612d174716f 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -123,7 +123,7 @@ static int serial_pxa_probe(struct platform_device *p=
dev)
 	uart.port.regshift =3D 2;
 	uart.port.irq =3D irqres->start;
 	uart.port.fifosize =3D 64;
-	uart.port.flags =3D UPF_IOREMAP | UPF_SKIP_TEST;
+	uart.port.flags =3D UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	uart.port.dev =3D &pdev->dev;
 	uart.port.uartclk =3D clk_get_rate(data->clk);
 	uart.port.pm =3D serial_pxa_pm;
--=20
2.24.1

