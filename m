Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B998C83018
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A19722203
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgLBLkk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:40:40 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:36387 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLBLkj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 06:40:39 -0500
Received: by mail-lf1-f44.google.com with SMTP id v14so4165031lfo.3;
        Wed, 02 Dec 2020 03:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wpl3GUF0Lna+9aQ+M4y15hfBavFW+GP9gpBC+7GpH5Y=;
        b=D0t+JDpDGdYf2jOcYQV738Dd1nEa7yQK/hjNkEj1X5/NsBNPh53C9FAOwB1/JSwVAJ
         srCHFBnriqPxnpdZjsmnhUvTC1U+ealhXUQNxStn1Pp7FFy+OenFpoqgq8mt6NwdxuKX
         nMrvqsW8A49alLdn/XYVWGCwn4OFL4PwC+QJKVMc8OhqTNbpYo/mk5+V2P9ui/zUdDeh
         QDX1JMz5hOVOXtNnwXjGYZm3ZfBwwuhcpzFuuzcM4aKkzDri6AVb5MCG0x5/5P6pDmrH
         5HcS3IhmYvclU4HCeaewN/ICk6NC85Vsvy6oW421mCtfzLlvMih3+7V29S7zRFNVyzLm
         zRIA==
X-Gm-Message-State: AOAM530hMWDvbTW/4xB3jZAGKhNizzr0UtDebi1V8aWidI3oUkluUYmO
        jgSqMy6P/pZpwtdY6OWHkm0=
X-Google-Smtp-Source: ABdhPJwyUJNCE0J39vsIAzAyLSqtGSgb7f96Lf3Wll5DzpTzhWzBGG7xh1QqFM8hjsN1W7HbJXOZmg==
X-Received: by 2002:a05:6512:2151:: with SMTP id s17mr1074253lfr.287.1606909190549;
        Wed, 02 Dec 2020 03:39:50 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 136sm384688lfn.193.2020.12.02.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:39:48 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kkQUc-000733-VU; Wed, 02 Dec 2020 12:40:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 4/7] serial: core: add sysfs attribute to suppress ready signalling on open
Date:   Wed,  2 Dec 2020 12:39:39 +0100
Message-Id: <20201202113942.27024-5-johan@kernel.org>
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
 Documentation/ABI/testing/sysfs-tty |  7 +++++++
 drivers/tty/serial/serial_core.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index e157130a6792..2634b4bf9c7f 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -161,3 +161,10 @@ Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 Description:
 		 Allows user to detach or attach back the given device as
 		 kernel console. It shows and accepts a boolean variable.
+
+What:		/sys/class/tty/ttyS0/nordy
+Date:		November 2020
+Contact:	Johan Hovold <johan@kernel.org>
+Description:
+		 Show and store the port NORDY flag which suppresses raising
+		 the modem-control lines on open to signal DTE readiness.
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f41cba10b86b..7db1814b9d99 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2805,6 +2805,30 @@ static ssize_t console_store(struct device *dev,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t nordy_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", tty_port_nordy(port));
+}
+
+static ssize_t nordy_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct tty_port *port = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	tty_port_set_nordy(port, val);
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(uartclk);
 static DEVICE_ATTR_RO(type);
 static DEVICE_ATTR_RO(line);
@@ -2819,6 +2843,7 @@ static DEVICE_ATTR_RO(io_type);
 static DEVICE_ATTR_RO(iomem_base);
 static DEVICE_ATTR_RO(iomem_reg_shift);
 static DEVICE_ATTR_RW(console);
+static DEVICE_ATTR_RW(nordy);
 
 static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_uartclk.attr,
@@ -2835,6 +2860,7 @@ static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_iomem_base.attr,
 	&dev_attr_iomem_reg_shift.attr,
 	&dev_attr_console.attr,
+	&dev_attr_nordy.attr,
 	NULL
 };
 
-- 
2.26.2

