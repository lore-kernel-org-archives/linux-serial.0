Return-Path: <SRS0=su8x=3S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87EDC33CB2
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jan 2020 11:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3142071E
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jan 2020 11:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo3mryy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgA2LVu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:21:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33083 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2LVu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jan 2020 06:21:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so18069606lji.0;
        Wed, 29 Jan 2020 03:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NPCUdLAYmbEspRBF05xZGb8x0Dpqva/T+gPsfhkFeOA=;
        b=lo3mryy3EPGV3wjla57jjaGExvmgGbLwskoGo2f4aETMXTnZY4n8y3V4MVs5q8uuVn
         0g33CDZIii/tmXcz40l8nSLVuHtSey5IcN88fgqai2D3Of2cf7pCNbb+thaEFxBB8CQf
         4ktOVU2JIMVE9X2pEogqYMGScv63jddu2RiRv0hR5iPB7HI8EZY8tXTHHwO+sr8z0e3z
         lBbv+KwyISNeEuOHs/oRvt3ynNR2+cnw+Yac7MqxruZH5vFi9wXHbLTZRKhYTZ5ai+Dq
         OWktIQQvL2ywRr9jTZ4WnC2ZT5bwZPPYH2rROmp+ngU219FDIS2873/x4Fu+a+xFQV0r
         Z0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=NPCUdLAYmbEspRBF05xZGb8x0Dpqva/T+gPsfhkFeOA=;
        b=N6u64a4aLyKDduxLyCxpMrgK4kjHpQ0uKd+ThXLp3Wh6QVPD2CdfQSevlJeElvfjMu
         p+MuACZRWVFVH+5lMkuey0zufTVIlbATZKbiZUD74KFUPjeDO1kvluNottLb9/DBy7yz
         Lk457QDzUSKvdiZVutQpiMUgiGv22iVVjSq9oILpLM6WGX1rGBvPB9Prb+zv88sCju2I
         T6whYgBCq6BbwNP/rNEN0E6gVR607Eqr1sYybEZ1LDqo9fg9BJhIAM/zzOlTo+QqjOjd
         4lAajKOyy/QtsW/UGqiO4edD36yL7CGSEjB+KyuV7EhqzhhMBoiUKEVI2zZq4XzvxJW7
         JmhA==
X-Gm-Message-State: APjAAAW1Pc2zsK8DTeCUI+gn1VJP4CQZADOAbH4/q45M7UBYF6eo6XfE
        Gg3sli+FoSYwp9eChbSp/a6jAEwc
X-Google-Smtp-Source: APXvYqxNVehRNwku/wPhP1/6tlzSibCQ47vVcHhXNMgzbVJn6j32BloCUTvoaCwPYWpa+82n49fcJg==
X-Received: by 2002:a2e:844e:: with SMTP id u14mr3111213ljh.183.1580296907910;
        Wed, 29 Jan 2020 03:21:47 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z7sm764137lji.30.2020.01.29.03.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 03:21:47 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        linux-serial@vger.kernel.org
Subject: [PATCH v3] usb: gadget: serial: fix Tx stall after buffer overflow
References: <87pnfi8xc2.fsf@osv.gnss.ru>
Date:   Wed, 29 Jan 2020 14:21:46 +0300
In-Reply-To: <87pnfi8xc2.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        17 Jan 2020 08:29:33 +0300")
Message-ID: <87sgjyzewl.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Symptom: application opens /dev/ttyGS0 and starts sending (writing) to
it while either USB cable is not connected, or nobody listens on the
other side of the cable. If driver circular buffer overflows before
connection is established, no data will be written to the USB layer
until/unless /dev/ttyGS0 is closed and re-opened again by the
application (the latter besides having no means of being notified about
the event of establishing of the connection.)

Fix: on open and/or connect, kick Tx to flush circular buffer data to
USB layer.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---

Changes in v3:

- Add Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Changes in v2:

- Add comment to document why tty_wakeup() is kept in place
- Don't add debug print
- Remove NOTE from description

 drivers/usb/gadget/function/u_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index f986e5c..8167d37 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -561,8 +561,10 @@ static int gs_start_io(struct gs_port *port)
 	port->n_read = 0;
 	started = gs_start_rx(port);
 
-	/* unblock any pending writes into our circular buffer */
 	if (started) {
+		gs_start_tx(port);
+		/* Unblock any pending writes into our circular buffer, in case
+		 * we didn't in gs_start_tx() */
 		tty_wakeup(port->port.tty);
 	} else {
 		gs_free_requests(ep, head, &port->read_allocated);
-- 
2.10.0.1.g57b01a3
