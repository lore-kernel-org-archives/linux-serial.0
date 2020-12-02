Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F24CC83016
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1953620709
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgLBLks (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:40:48 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33337 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgLBLkd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 06:40:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id l11so4202208lfg.0;
        Wed, 02 Dec 2020 03:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tP2HvplWRaMXdOrLEwAbMpgsLuB/LtE2K3OBH4UE6QM=;
        b=nBu7trBqYxRQlQbVfl9XsOSIEbGXmMrOXpSe718JzeiaJrprDBQDqo37xRRZl1CfPT
         V+0iltwTcp/2arRJQyw7K+/sLWajsm4gUUuYKOXqUllDR0NcvIQd/OIa9BO+YwyI1sWu
         ABtvH2PhT3fJ+ZEgZJH1Kjy0+dPZh/jdH3pIEgIa/Qohsgg3BmSUHAFy7ica2Jb/iqpA
         e5h04/5yoCPCqudWbhRLQkR+XYfc0VmFK7RiLA+4WNyY3xOiLIrEyL2vAtSwKb7FmtZ3
         owQdGkIbTa0JUjCmJaYsQeiMpMdVbpL084nQeMx1rhr4qd1eip7Vvu6yInG+2t4isS9c
         62pg==
X-Gm-Message-State: AOAM5314Y+K4C64lm/goOvkRFZR22R2n4F8PLBoo3Ugep2wqLfOH3/8R
        pwJusy3bRKctKXf2b7uszJs=
X-Google-Smtp-Source: ABdhPJwF4T7Ii6Rs+7XME3BIDjgfwitUBpk4MgYq1TJ2v9pWqbFWzDGtOvHDm3kXv6watTkD+U55tA==
X-Received: by 2002:ac2:5a47:: with SMTP id r7mr974435lfn.525.1606909191191;
        Wed, 02 Dec 2020 03:39:51 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id t20sm385034lff.153.2020.12.02.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:39:49 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kkQUd-000738-27; Wed, 02 Dec 2020 12:40:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 5/7] USB: serial: add sysfs attribute to suppress ready signalling on open
Date:   Wed,  2 Dec 2020 12:39:40 +0100
Message-Id: <20201202113942.27024-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202113942.27024-1-johan@kernel.org>
References: <20201202113942.27024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a nordy sysfs attribute to suppress raising the modem-control lines
on open to signal DTE readiness.

This can be used to prevent undesirable side-effects on open for
applications where the DTR and RTS lines are used for non-standard
purposes such as generating power-on and reset pulses.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/bus.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index eb0195cf37dd..db75cc5c3dfb 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -35,6 +35,37 @@ static int usb_serial_device_match(struct device *dev,
 	return 0;
 }
 
+static ssize_t nordy_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct usb_serial_port *port = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", tty_port_nordy(&port->port));
+}
+
+static ssize_t nordy_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct usb_serial_port *port = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	tty_port_set_nordy(&port->port, val);
+
+	return count;
+}
+static DEVICE_ATTR_RW(nordy);
+
+static struct attribute *tty_attrs[] = {
+	&dev_attr_nordy.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(tty);
+
 static int usb_serial_device_probe(struct device *dev)
 {
 	struct usb_serial_driver *driver;
@@ -60,8 +91,8 @@ static int usb_serial_device_probe(struct device *dev)
 	}
 
 	minor = port->minor;
-	tty_dev = tty_port_register_device(&port->port, usb_serial_tty_driver,
-					   minor, dev);
+	tty_dev = tty_port_register_device_attr(&port->port,
+			usb_serial_tty_driver, minor, dev, port, tty_groups);
 	if (IS_ERR(tty_dev)) {
 		retval = PTR_ERR(tty_dev);
 		goto err_port_remove;
-- 
2.26.2

