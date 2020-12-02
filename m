Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43BFC64E7C
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814CC20709
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgLBLkt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:40:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38673 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgLBLkc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 06:40:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id j10so3215626lja.5;
        Wed, 02 Dec 2020 03:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fraB3Wh6hPdE3o2D/kX730gDe4KdALMn6rjz8MjFR5Y=;
        b=kuSrcro6hA/CdMYb9NHG/rq68skl4PEM8q2C9EFL+Dx8NRXtzTCemsqRNDruvl6sWs
         vMhegOj1pZbHULJvAKv1q+mt2zolC3H9+pnW+eAVyHfgr5P8JVuWqnHi6TgR8DS2yHao
         8QdCKiOlj+NIC5R7k5y2VzMMjvu8D07Qbutc1Rv1bjYdLfAuQ1mlLM/GQrEEL1IpAVN2
         MLlANNxARA/gsj1Iy4jhQ2WRwwolcpzw7YT3RdyKc1BBnxRmlY8Ge166Wp5/yCG0ibws
         g7tTXH73l6B1l7wzB2kFV/P5feZvE8iZ4XHlgzaeCevlnB3fPmgsoVvDu++Xui4Lzwae
         D6lA==
X-Gm-Message-State: AOAM533usAVaxiYjbazTWk2NlaM2lo3pamiEYOpfVrnlT/+AYZUlK2VR
        mY3btDf3fsboKk60XR+rnbA=
X-Google-Smtp-Source: ABdhPJzFuHZC0BBruoFMX/bNpSx/Oa1Q4cpNr2kFh2u5qgBIcDBgDESdWMu+lIpVAMOj6C2u3LOENw==
X-Received: by 2002:a2e:86da:: with SMTP id n26mr981641ljj.124.1606909189958;
        Wed, 02 Dec 2020 03:39:49 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id s23sm401265ljs.75.2020.12.02.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:39:48 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kkQUc-00072y-SU; Wed, 02 Dec 2020 12:40:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/7] tty: add port flag to suppress ready signalling on open
Date:   Wed,  2 Dec 2020 12:39:38 +0100
Message-Id: <20201202113942.27024-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202113942.27024-1-johan@kernel.org>
References: <20201202113942.27024-1-johan@kernel.org>
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

This can be used to prevent undesirable side-effects on open for
applications where the DTR and RTS lines are used for non-standard
purposes such as generating power-on and reset pulses.

Reviewed-by: Mychaela N. Falconia <falcon@freecalypso.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_port.c |  2 +-
 include/linux/tty.h    | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

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
index 3ebeb7fbe332..05bec5837b51 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -267,6 +267,7 @@ struct tty_port {
 #define TTY_PORT_CHECK_CD	4	/* carrier detect enabled */
 #define TTY_PORT_KOPENED	5	/* device exclusively opened by
 					   kernel */
+#define TTY_PORT_NORDY		6	/* do not raise DTR/RTS on open */
 
 /*
  * Where all of the state associated with a tty is kept while the tty
@@ -665,6 +666,16 @@ static inline void tty_port_set_kopened(struct tty_port *port, bool val)
 	assign_bit(TTY_PORT_KOPENED, &port->iflags, val);
 }
 
+static inline bool tty_port_nordy(const struct tty_port *port)
+{
+	return test_bit(TTY_PORT_NORDY, &port->iflags);
+}
+
+static inline void tty_port_set_nordy(struct tty_port *port, bool val)
+{
+	assign_bit(TTY_PORT_NORDY, &port->iflags, val);
+}
+
 extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
 extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
 extern int tty_port_carrier_raised(struct tty_port *port);
-- 
2.26.2

