Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C99FC71156
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 15:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F042206C0
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 15:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgK3Pih (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Nov 2020 10:38:37 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44194 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgK3Pig (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Nov 2020 10:38:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id d20so22404584lfe.11;
        Mon, 30 Nov 2020 07:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+aLtio6V1+D5pI+gfBa6W9Kw54KOG0u5ylBdBluGMXY=;
        b=NVsWMmwKOMOtHCSGfbUU6ETtlwnj0vE0ZtyqNkZoPF6SKylswybsq390UbD5eqKZh+
         fprl7nCh14ZKchOUnQhPubJJ7ZEBc2CS4S4E+UwP0G3D3jRBTZTmB2+amsx4z/Cz8Wd6
         aTK3Aib5Jca6f2aUWm6FLYA9Zklevqh5JQ7s4OT9FyVG3igScEbEf8hFWdhEBmrkKN8U
         kC+lrtrE2LqdfJ4q97CduVymDvMZeMnEaHUQ/FvfUkLq62C/lSxpCwmbFQEzNkG3Z8N0
         U/3wHY2suki9K/uKd1kSZhsS78Pq82SZLPPkGJUQr8EEr/3CnJVcKm4+JnIuObfrCXBq
         m8Pw==
X-Gm-Message-State: AOAM532b8Vi1bmGKt2aIbcYBlMq+wB33w/Nn6Xatqn3GDLBf5C9lqule
        bh/3odCkzBLL8nI+3/6BFpd0uodSU9afBA==
X-Google-Smtp-Source: ABdhPJyK//aBOsqAM2W2TFUh6Gj+kw5QM+xj4FI9UtZblb9pLbYEAsTUAl2xtclS10ebD23bLMN34A==
X-Received: by 2002:a19:711:: with SMTP id 17mr9667668lfh.131.1606750674171;
        Mon, 30 Nov 2020 07:37:54 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id t6sm2498672lfk.207.2020.11.30.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:37:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kjlFu-0002Oh-Lm; Mon, 30 Nov 2020 16:38:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/5] tty: add port flag to suppress ready signalling on open
Date:   Mon, 30 Nov 2020 16:37:38 +0100
Message-Id: <20201130153742.9163-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201130153742.9163-1-johan@kernel.org>
References: <20201130153742.9163-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a NORDY port flag to suppress raising the modem-control lines on
open to signal DTE readiness.

This can be used to implement a NORDY termios control flag to complement
HUPCL, which controls lowering of the modem-control lines on final
close.

Initially drivers can export the flag through sysfs, which also allows
control over the lines on first open.

This can be use to prevent undesirable side-effects on open for
applications where the DTR and RTS lines are used for non-standard
purposes such as generating power-on and reset pulses.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_port.c |  2 +-
 include/linux/tty.h    | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index ea80bf872f54..2613debc1d06 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -415,7 +415,7 @@ EXPORT_SYMBOL(tty_port_carrier_raised);
  */
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
-	if (port->ops->dtr_rts)
+	if (port->ops->dtr_rts && !tty_port_nordy(port))
 		port->ops->dtr_rts(port, 1);
 }
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index a99e9b8e4e31..31414efd8661 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -267,6 +267,7 @@ struct tty_port {
 #define TTY_PORT_CHECK_CD	4	/* carrier detect enabled */
 #define TTY_PORT_KOPENED	5	/* device exclusively opened by
 					   kernel */
+#define TTY_PORT_NORDY		6	/* do not raise DTR/RTS on open */
 
 /*
  * Where all of the state associated with a tty is kept while the tty
@@ -683,6 +684,19 @@ static inline void tty_port_set_kopened(struct tty_port *port, bool val)
 		clear_bit(TTY_PORT_KOPENED, &port->iflags);
 }
 
+static inline bool tty_port_nordy(struct tty_port *port)
+{
+	return test_bit(TTY_PORT_NORDY, &port->iflags);
+}
+
+static inline void tty_port_set_nordy(struct tty_port *port, bool val)
+{
+	if (val)
+		set_bit(TTY_PORT_NORDY, &port->iflags);
+	else
+		clear_bit(TTY_PORT_NORDY, &port->iflags);
+}
+
 extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
 extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
 extern int tty_port_carrier_raised(struct tty_port *port);
-- 
2.26.2

