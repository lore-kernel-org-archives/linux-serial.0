Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF616C8301D
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E83822206
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgLBLkh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:40:37 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36566 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgLBLkh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 06:40:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id v14so4164867lfo.3;
        Wed, 02 Dec 2020 03:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qh172KviYxa9zp9+o3L4Po4UyIe5hNPQfMlxTZlddTg=;
        b=cFD3bSXVoBcOe3UDCQEXB9HMMyzavhkudtAmLKt+4TDbFstwHuuUXHxwtPn0O3lpxA
         K3A/KH/PdU8leRWYhEE7YKg8/ELpuSsHgx7bVJVZ7OyGIhUglziW2Mfexqo4fRm3bMLC
         vSg7v8KRE20V52ftKcMY4TkB+37qphVX8JM+6lDJOF8oSSY9s7FxxEe991jOYMDHz3Ur
         J4a5QeN6lJ5GavvQW3xXjAaVHpmQkLRus5zkLBxOk9W8wEAY7D9WrpVmsug/6v53S3qa
         cJjwKpwIz0HDT1+b6oM6DnK3pBC/zC9v5kcHc+ap293/WwbhN8oxmeeojTLdnT9MXgBq
         9uTw==
X-Gm-Message-State: AOAM532F/AZEX2eCm2ncO0LyRH5wfUAYp95gVTOHuoLAKIv8sPcoKsT0
        rY5UDHZNEI6ZSFIgee34Zms=
X-Google-Smtp-Source: ABdhPJwoVdp8m2G7eivVLWdlKmMT+Mkq9450XQZv3A0x9keCOk8Do2wAIMeotyIiIlPfZDcI8vM4Mg==
X-Received: by 2002:ac2:5087:: with SMTP id f7mr1174426lfm.369.1606909188621;
        Wed, 02 Dec 2020 03:39:48 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id r66sm379960lff.265.2020.12.02.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:39:47 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kkQUc-00072n-LD; Wed, 02 Dec 2020 12:40:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/7] tty: use assign_bit() in port-flag accessors
Date:   Wed,  2 Dec 2020 12:39:36 +0100
Message-Id: <20201202113942.27024-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202113942.27024-1-johan@kernel.org>
References: <20201202113942.27024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use the new assign_bit() wrapper in the port-flag accessors instead of
open coding.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/tty.h | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index a99e9b8e4e31..eca7fd5e9fd0 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -612,10 +612,7 @@ static inline bool tty_port_cts_enabled(struct tty_port *port)
 
 static inline void tty_port_set_cts_flow(struct tty_port *port, bool val)
 {
-	if (val)
-		set_bit(TTY_PORT_CTS_FLOW, &port->iflags);
-	else
-		clear_bit(TTY_PORT_CTS_FLOW, &port->iflags);
+	assign_bit(TTY_PORT_CTS_FLOW, &port->iflags, val);
 }
 
 static inline bool tty_port_active(struct tty_port *port)
@@ -625,10 +622,7 @@ static inline bool tty_port_active(struct tty_port *port)
 
 static inline void tty_port_set_active(struct tty_port *port, bool val)
 {
-	if (val)
-		set_bit(TTY_PORT_ACTIVE, &port->iflags);
-	else
-		clear_bit(TTY_PORT_ACTIVE, &port->iflags);
+	assign_bit(TTY_PORT_ACTIVE, &port->iflags, val);
 }
 
 static inline bool tty_port_check_carrier(struct tty_port *port)
@@ -638,10 +632,7 @@ static inline bool tty_port_check_carrier(struct tty_port *port)
 
 static inline void tty_port_set_check_carrier(struct tty_port *port, bool val)
 {
-	if (val)
-		set_bit(TTY_PORT_CHECK_CD, &port->iflags);
-	else
-		clear_bit(TTY_PORT_CHECK_CD, &port->iflags);
+	assign_bit(TTY_PORT_CHECK_CD, &port->iflags, val);
 }
 
 static inline bool tty_port_suspended(struct tty_port *port)
@@ -651,10 +642,7 @@ static inline bool tty_port_suspended(struct tty_port *port)
 
 static inline void tty_port_set_suspended(struct tty_port *port, bool val)
 {
-	if (val)
-		set_bit(TTY_PORT_SUSPENDED, &port->iflags);
-	else
-		clear_bit(TTY_PORT_SUSPENDED, &port->iflags);
+	assign_bit(TTY_PORT_SUSPENDED, &port->iflags, val);
 }
 
 static inline bool tty_port_initialized(struct tty_port *port)
@@ -664,10 +652,7 @@ static inline bool tty_port_initialized(struct tty_port *port)
 
 static inline void tty_port_set_initialized(struct tty_port *port, bool val)
 {
-	if (val)
-		set_bit(TTY_PORT_INITIALIZED, &port->iflags);
-	else
-		clear_bit(TTY_PORT_INITIALIZED, &port->iflags);
+	assign_bit(TTY_PORT_INITIALIZED, &port->iflags, val);
 }
 
 static inline bool tty_port_kopened(struct tty_port *port)
@@ -677,10 +662,7 @@ static inline bool tty_port_kopened(struct tty_port *port)
 
 static inline void tty_port_set_kopened(struct tty_port *port, bool val)
 {
-	if (val)
-		set_bit(TTY_PORT_KOPENED, &port->iflags);
-	else
-		clear_bit(TTY_PORT_KOPENED, &port->iflags);
+	assign_bit(TTY_PORT_KOPENED, &port->iflags, val);
 }
 
 extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
-- 
2.26.2

