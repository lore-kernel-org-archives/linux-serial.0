Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7353FC433F5
	for <linux-serial@archiver.kernel.org>; Sun, 14 Nov 2021 18:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3AD604DC
	for <linux-serial@archiver.kernel.org>; Sun, 14 Nov 2021 18:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhKNSmI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 14 Nov 2021 13:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbhKNSmH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 Nov 2021 13:42:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A80C061767
        for <linux-serial@vger.kernel.org>; Sun, 14 Nov 2021 10:39:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so12059596pjb.4
        for <linux-serial@vger.kernel.org>; Sun, 14 Nov 2021 10:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuzSRLtM/3fmTKXQ2R84gnWt2v8TS0BEYenwKOqGvYk=;
        b=oX6Zew9JvlcpOc/re8nyHX/mY+Bj4c6xxbzvHY42A7xPndjvggO3HSNBPssCdDkGqD
         HXz2NBDYRgnhskoUYXK+xKjT2eDKQgdanYquu/w/HPqdTsK7A6v1QTQkWMeMbkJK9l5w
         ABKr2PAL5QlP2QkaLcPbnrdN06y8DJQYIyh6zLfXb5Z2upZjm4TL4bGWQ0uE0PvyrfhO
         sUcRknFMnK9tUJ5fupVw7jaCh7j7LuMjxSaGlzPWdvvXFVCYdNdUT95Gzd8T70bZhbkG
         ax4EwlYT9A/P3ViB4vVCcJLMJwRlNq+uGz60SDAFxGRswwz+W5qaKlY6ni/7CweR/8o+
         tHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuzSRLtM/3fmTKXQ2R84gnWt2v8TS0BEYenwKOqGvYk=;
        b=ZSNAVjjhdUhPn1qDIcVpxikuaDBAxe1M8UBehqwuraNQSQgt3N739WYSmgT6MuxLAE
         KUSNvzisvFm5YzN0NdNAtqmKfGL0p2atop+GIBd3pX45a+gHE8x9A0t4+w0bCy7coEVD
         sLq1Io4mfME/b0sVlSb5o1ck37qMIOCksqyvvg6J2hAeqdxCxJbDPjmQJH9U2hJXXTVX
         8Cg5log+vi8YfmUJ5eWAmgZkDZVz07DYEbj/wg+iN3O0lJNyIGAsZImx5qBtA9CYTDv9
         T8x8lLoOHC39d++80u7e3WqxjjD6nKG6uFHreXo2tH43PZ3i0vA/dSNJGpZkdkmXxXUo
         BaPQ==
X-Gm-Message-State: AOAM533gWXZ0+YFKkh4tauuSI6m/LHNNl+lfObtw2rrR+eCNZZ+HJkzm
        EESxNHI977AHSc4BpfY7UYaOBi4heGKBjl0v956rCvSQ8r92EUQyuCy1K5Ehjb3JbPhYkJzzJ6L
        E8XcjJfvNf6adXyk7ZYdkGUAb5FPcCJQojClDipWRqf/70olwl8KJF9oMkvWwqk6iDpKbVgKbOk
        dv8Kw=
X-Google-Smtp-Source: ABdhPJxBJ5zxlftewT+ZpsGBhkp5Z3t2tonVFjnE4crS0KWPBJnbKzoIOpO7weXAmgkMMRGiBizlmw==
X-Received: by 2002:a17:90b:4a50:: with SMTP id lb16mr39601124pjb.147.1636915152682;
        Sun, 14 Nov 2021 10:39:12 -0800 (PST)
Received: from work-laptop.dolannet.net ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id y130sm12551642pfg.202.2021.11.14.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 10:39:12 -0800 (PST)
From:   Jay Dolan <jay.dolan@accesio.com>
To:     linux-serial@vger.kernel.org
Cc:     Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH 2/3] serial: 8250_pci: Re-enable higher baud rates on Pericom chips
Date:   Sun, 14 Nov 2021 10:39:07 -0800
Message-Id: <20211114183908.444923-3-jay.dolan@accesio.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211114183908.444923-1-jay.dolan@accesio.com>
References: <20211114183908.444923-1-jay.dolan@accesio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add UPF_MAGIC_MULTIPLIER to Pericom serial ports since there is now
range checking in serial8250_get_baud_rate() in 8250_port.c

Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
---
 drivers/tty/serial/8250/8250_pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index aea43683b76d..5615ac1d2352 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1352,6 +1352,11 @@ pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
 		}
 	}
 }
+static int pericom_do_startup(struct uart_port *port)
+{
+	port->flags |= UPF_MAGIC_MULTIPLIER;
+	return serial8250_do_startup(port);
+}
 static int pci_pericom_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
 		  struct uart_8250_port *port, int idx)
@@ -1372,6 +1377,7 @@ static int pci_pericom_setup(struct serial_private *priv,
 		return 1;
 
 	port->port.set_divisor = pericom_do_set_divisor;
+	port->port.startup = pericom_do_startup;
 
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
@@ -1398,6 +1404,7 @@ static int pci_pericom_setup_four_at_eight(struct serial_private *priv,
 		return 1;
 
 	port->port.set_divisor = pericom_do_set_divisor;
+	port->port.startup = pericom_do_startup;
 
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
-- 
2.25.1

