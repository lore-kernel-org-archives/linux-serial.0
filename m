Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16035C64E90
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BD722249
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgLBLke (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:40:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34231 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLBLkc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 06:40:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id y16so3247160ljk.1;
        Wed, 02 Dec 2020 03:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01vHtzx/5aEVlHEVhq/PMF1AoVHq8PWDJZfl0akHsik=;
        b=KEpQBNlPZ/0JC6t0QmcsaXPH4Vh8x77zoMbnpzOQLBVpfYWSkjtXTS9IV8UiBNfbdo
         uEkMJjBHkZ9qRb7WXvBwdxlKlbcyUWuogbglBysSEXRwhsuY1zX1l47hsmuBAf0aUy6e
         92dRUA03f/uj04NZH21Yuk7sDkQaw4/MDjgVhXsl+BfXZg4piAYWE/JNCIm9w9ED93xZ
         K/OSM3WHWVP56Wo5yTJIiX2vj6ZxAHyvi1sObve1Vv7Pk7TBexK0lq8s9N5FE6zy6aHh
         4RU4fGHC5EUaFcgevTol/HNgQYerLOagi6bbzZhkz20bDRP+dBIJfF+KV2Em2nU3Fsin
         4Ffw==
X-Gm-Message-State: AOAM531UUR8uOn3tOK2uaZuK2BznwbJn4+BkGT+u2J2c4wYgck4t0T0x
        PqrNGwj9eTINOLR0wkkQAsOCRblauzEjbw==
X-Google-Smtp-Source: ABdhPJxOqwspvf/MmAVckgjGG6+2wsOWl7R7BrdrJxygrukymZb8YLK6+3N4jhC7EqalwUGrJGESWQ==
X-Received: by 2002:a2e:3518:: with SMTP id z24mr1019450ljz.310.1606909189303;
        Wed, 02 Dec 2020 03:39:49 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x11sm379239lfe.96.2020.12.02.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:39:47 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kkQUc-00072t-Or; Wed, 02 Dec 2020 12:40:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/7] tty: use const parameters in port-flag accessors
Date:   Wed,  2 Dec 2020 12:39:37 +0100
Message-Id: <20201202113942.27024-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202113942.27024-1-johan@kernel.org>
References: <20201202113942.27024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Declare the port parameter to the flag-test accessors as const.

This is currently mostly cosmetic as the accessors are already inlined.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/tty.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index eca7fd5e9fd0..3ebeb7fbe332 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -605,7 +605,7 @@ static inline struct tty_port *tty_port_get(struct tty_port *port)
 }
 
 /* If the cts flow control is enabled, return true. */
-static inline bool tty_port_cts_enabled(struct tty_port *port)
+static inline bool tty_port_cts_enabled(const struct tty_port *port)
 {
 	return test_bit(TTY_PORT_CTS_FLOW, &port->iflags);
 }
@@ -615,7 +615,7 @@ static inline void tty_port_set_cts_flow(struct tty_port *port, bool val)
 	assign_bit(TTY_PORT_CTS_FLOW, &port->iflags, val);
 }
 
-static inline bool tty_port_active(struct tty_port *port)
+static inline bool tty_port_active(const struct tty_port *port)
 {
 	return test_bit(TTY_PORT_ACTIVE, &port->iflags);
 }
@@ -625,7 +625,7 @@ static inline void tty_port_set_active(struct tty_port *port, bool val)
 	assign_bit(TTY_PORT_ACTIVE, &port->iflags, val);
 }
 
-static inline bool tty_port_check_carrier(struct tty_port *port)
+static inline bool tty_port_check_carrier(const struct tty_port *port)
 {
 	return test_bit(TTY_PORT_CHECK_CD, &port->iflags);
 }
@@ -635,7 +635,7 @@ static inline void tty_port_set_check_carrier(struct tty_port *port, bool val)
 	assign_bit(TTY_PORT_CHECK_CD, &port->iflags, val);
 }
 
-static inline bool tty_port_suspended(struct tty_port *port)
+static inline bool tty_port_suspended(const struct tty_port *port)
 {
 	return test_bit(TTY_PORT_SUSPENDED, &port->iflags);
 }
@@ -645,7 +645,7 @@ static inline void tty_port_set_suspended(struct tty_port *port, bool val)
 	assign_bit(TTY_PORT_SUSPENDED, &port->iflags, val);
 }
 
-static inline bool tty_port_initialized(struct tty_port *port)
+static inline bool tty_port_initialized(const struct tty_port *port)
 {
 	return test_bit(TTY_PORT_INITIALIZED, &port->iflags);
 }
@@ -655,7 +655,7 @@ static inline void tty_port_set_initialized(struct tty_port *port, bool val)
 	assign_bit(TTY_PORT_INITIALIZED, &port->iflags, val);
 }
 
-static inline bool tty_port_kopened(struct tty_port *port)
+static inline bool tty_port_kopened(const struct tty_port *port)
 {
 	return test_bit(TTY_PORT_KOPENED, &port->iflags);
 }
-- 
2.26.2

