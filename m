Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F80C5ACD7
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 00:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D978A20663
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 00:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q4i8AVJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCRAkp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:40:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46828 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgCRAko (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 20:40:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id r3so2337334pls.13
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2020 17:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jSbB96gkV6Tq9N4yd+/6U22oTUdE4djX3cq7LX6uJm8=;
        b=Q4i8AVJ9A1SoTGlrYcj+L5E847pgBsUOZ6oAfz3D/2mHb3uNG0AJGoLwj+/REWBfaE
         WJKyKvl2cBWGYH6iHg4KaiRCQIAAnKDsK4YS0PEG5EZRYaOXGsGRDbNAs9Nnb5nLRxom
         UPW4qsXPzjZFrRd55LOK9MNwKghLSjMgTxZwMI8XJr+jWQo2lcPUGgJhaGzeR2Rh1Gmq
         iiYP4lkpZdOtJFSXhhjN8hYvhM5jF082ITaKLam0V56MJWBDUrTBChH0pMLDuOFai6vz
         TguUKzJsBq1CLucOJSGxjykf4yE0z8zxgY6IiEGVEPHBjUyIESf9e5aZ2JBn57oFpo2X
         yYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jSbB96gkV6Tq9N4yd+/6U22oTUdE4djX3cq7LX6uJm8=;
        b=I7D64Cln4VzMIcRmY9W5pLPWxNE918kyseHlP6kW+4EIzrvLrknSW6AaLNaWG5+6l6
         9wkaexJ2OW/YFOsl+CaJngsCXPyulYhz2MAk9zO0tg1l/HhwgPa4oj9c2t5hEP5AuChp
         RHRaD0BAjvJTK4o06/103wxYy37gxM4To6ytFtLgQIJ4JNWoktI0J2W6qgQfLlqbEPXl
         4FmbVPnzU6zI0qTHErVjHZzYJ/7dmEVNXDKr8LCYD3z/9HHyRJgxLzVc6RncV4b78hO9
         6wkTBrXO2AYjpY5MWus/4At1OvCN4LxQ6rkAOvmjS5NRUEd0zZeyfvmE7R9fM/YUQLq7
         O5iA==
X-Gm-Message-State: ANhLgQ3XAPDw/Lsdt9nxBYIPv7xpf8/GrDFXWAZNBo98lHaA09I+11oj
        W5IVkP7k1W3XqPiKsXjq459zuQ==
X-Google-Smtp-Source: ADFU+vtJN1cKuL2W6AG44CrmWFVctlDq2q9vTUlV18N6VWQ9U5rAT9b0PiF2pMIuFqLoXJuzpE377A==
X-Received: by 2002:a17:90a:1d4:: with SMTP id 20mr1805533pjd.95.1584492042613;
        Tue, 17 Mar 2020 17:40:42 -0700 (PDT)
Received: from VincentChen-ThinkPad-T480s.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id p4sm4258526pfg.163.2020.03.17.17.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 17:40:42 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.co, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v2] tty: serial: Add CONSOLE_POLL support to SiFive UART
Date:   Wed, 18 Mar 2020 08:40:27 +0800
Message-Id: <1584492027-23236-1-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add CONSOLE_POLL support for future KGDB porting.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

Changes since v1:
1. Fix the compile error reported by kbuild test robot
---
 drivers/tty/serial/sifive.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index d5f81b98e4d7..f46b5dba0661 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -709,6 +709,29 @@ static const char *sifive_serial_type(struct uart_port *port)
 	return port->type == PORT_SIFIVE_V0 ? "SiFive UART v0" : NULL;
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int sifive_serial_poll_get_char(struct uart_port *port)
+{
+	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	char is_empty, ch;
+
+	ch = __ssp_receive_char(ssp, &is_empty);
+	if (is_empty)
+		return NO_POLL_CHAR;
+
+	return ch;
+}
+
+static void sifive_serial_poll_put_char(struct uart_port *port,
+					unsigned char c)
+{
+	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+
+	__ssp_wait_for_xmitr(ssp);
+	__ssp_transmit_char(ssp, c);
+}
+#endif /* CONFIG_CONSOLE_POLL */
+
 /*
  * Early console support
  */
@@ -877,6 +900,10 @@ static const struct uart_ops sifive_serial_uops = {
 	.request_port	= sifive_serial_request_port,
 	.config_port	= sifive_serial_config_port,
 	.verify_port	= sifive_serial_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= sifive_serial_poll_get_char,
+	.poll_put_char	= sifive_serial_poll_put_char,
+#endif
 };
 
 static struct uart_driver sifive_serial_uart_driver = {
-- 
2.7.4

