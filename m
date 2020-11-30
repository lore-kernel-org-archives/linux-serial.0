Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630EDC83014
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131A620725
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 15:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgK3Pii (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Nov 2020 10:38:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46096 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgK3Pii (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Nov 2020 10:38:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id t6so22414180lfl.13;
        Mon, 30 Nov 2020 07:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wX/I1sXDrWB17nXmZ4/VUTNk1RGewCzBNozxf+IPcvs=;
        b=Lg6IdV5x2TAYVPD8+hlZ8Ggtc1TbruqJbN0tqzfcE37zwDguLpBdnxDC9zNyot9nVS
         AAR/IpD64zEt11Tr3LZbgD4Mx/oGbv20xbt/IKMXAIPu3IbMkxxGvXndXkxIGR9Ps95I
         JkvDdbiopj2pkM67JSljTRVkM5LZaWnpHG2Mv+KVJRE4WJmfmC0WU9FOaGQ6k5Ka5naQ
         86JlKKO+sQX3aMmoOcUnRR7Dm8KPFBGD5Nfca7F2uCoJnfSg/frA1yYlKFBmdFfczPto
         dXslRNK7HLsFIZhrEKSR/XqVr3UZykWked94NdWl3g+AVOMkRBLiN08wJIANFbl2gxV5
         dLnA==
X-Gm-Message-State: AOAM532SntCEQe39izRNbFoGQfRIOWBw7dH77is7i3YC22+Pjz5e/DGz
        8Ak17YwM/MwvPGSNGyMl6YE=
X-Google-Smtp-Source: ABdhPJxvScOcMYD7Tt8YWHK2qbhuamWyLHg0NrITzgg3eak3+wQeEhys0HE0qxd5qn8dNo2FOY6fGg==
X-Received: by 2002:ac2:53bc:: with SMTP id j28mr9680680lfh.39.1606750675410;
        Mon, 30 Nov 2020 07:37:55 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 84sm2491995lfa.39.2020.11.30.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:37:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kjlFu-0002Oq-RT; Mon, 30 Nov 2020 16:38:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/5] USB: serial: add sysfs attribute to suppress ready signalling on open
Date:   Mon, 30 Nov 2020 16:37:40 +0100
Message-Id: <20201130153742.9163-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201130153742.9163-1-johan@kernel.org>
References: <20201130153742.9163-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a nordy sysfs attribute to suppress raising the modem-control lines
on open to signal DTE readiness.

This can be use to prevent undesirable side-effects on open for
applications where the DTR and RTS lines are used for non-standard
purposes such as generating power-on and reset pulses.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/bus.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index eb0195cf37dd..37bbeab6666e 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -35,6 +35,40 @@ static int usb_serial_device_match(struct device *dev,
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
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > 1)
+		return -EINVAL;
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
@@ -60,8 +94,8 @@ static int usb_serial_device_probe(struct device *dev)
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

