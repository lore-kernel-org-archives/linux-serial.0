Return-Path: <SRS0=HSIU=4I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E09C11D1A
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB03324673
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="MEukQMfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgBTRxp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:53:45 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:50563 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgBTRxp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:45 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A0AFB23E3C;
        Thu, 20 Feb 2020 18:46:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582220774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xj3LA1zTH4SsCJX7PLfeOExLfpbX8EjlKGUE5mqKsd8=;
        b=MEukQMfiV14G/weO9PYFD4BkGkrXnCEd2ZGUufJFPC/3g9i9Wgvp5KMzva/nz1O0qvYQFY
        qHO724Q8somCA5+jvxOdR3ToH3slHjS/S8HoxcXn4D5HRV7TIXDLrzIt4KMmhWqo3113Js
        LV5oZGkmGyFeeusdSuvsXjvdmMFmRDQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] serial: earlycon: prefer EARLYCON_DECLARE() variant
Date:   Thu, 20 Feb 2020 18:46:07 +0100
Message-Id: <20200220174607.24285-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: A0AFB23E3C
X-Spamd-Result: default: False [4.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM(0.00)[0.411];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If a driver exposes early consoles with EARLYCON_DECLARE() and
OF_EARLYCON_DECLARE(), pefer the non-OF variant if the user specifies it
by
  earlycon=<driver>,<options>

The rationale behind this is that some drivers register multiple setup
functions under the same driver name. Eg.

OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);

It depends on the order of the entries which console_setup() actually
gets called. To make things worse, I guess it also depends on the
compiler how these are ordered. Thus always prefer the EARLYCON_DECLARE()
ones.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/earlycon.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index c14873b67803..2ae9190b64bb 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -170,6 +170,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 int __init setup_earlycon(char *buf)
 {
 	const struct earlycon_id **p_match;
+	bool empty_compatible = true;
 
 	if (!buf || !buf[0])
 		return -EINVAL;
@@ -177,6 +178,7 @@ int __init setup_earlycon(char *buf)
 	if (early_con.flags & CON_ENABLED)
 		return -EALREADY;
 
+again:
 	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
 	     p_match++) {
 		const struct earlycon_id *match = *p_match;
@@ -185,6 +187,10 @@ int __init setup_earlycon(char *buf)
 		if (strncmp(buf, match->name, len))
 			continue;
 
+		/* prefer entries with empty compatible */
+		if (empty_compatible && *match->compatible)
+			continue;
+
 		if (buf[len]) {
 			if (buf[len] != ',')
 				continue;
@@ -195,6 +201,11 @@ int __init setup_earlycon(char *buf)
 		return register_earlycon(buf, match);
 	}
 
+	if (empty_compatible) {
+		empty_compatible = false;
+		goto again;
+	}
+
 	return -ENOENT;
 }
 
-- 
2.20.1

