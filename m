Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AA5C83019
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D26E206C0
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 15:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgK3Pim (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Nov 2020 10:38:42 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:41724 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgK3Pih (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Nov 2020 10:38:37 -0500
Received: by mail-lf1-f45.google.com with SMTP id r24so22430174lfm.8;
        Mon, 30 Nov 2020 07:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vS6wFzkkLhX1TVsecDayO/AB9FKfg+OLWHQOURPFz3E=;
        b=KzT3A2a0J/CwmqpJisiZQ0+SYcqGDb/Vg3v8pIancuxMUMCL/DfRNTy3MXNALt03+9
         8jZ9TfJM6NwlBfCHUfEy+4e3bMuzamDxLqNsXV+TMNl8FLMuiLKwl/s8AFGNI74cyuIJ
         kk36c65X4jK/jUw7/GAEGhBW5LtuxVtqiCjE6x2DSuSL2f1v9egPgqvVuxB+MqQ6aUnX
         pYFMcY0bDIHgDFpGGKya9FhITlhqL2U0FCrghieC+OPytoq4mBx0t87g5bgJYHeKoFML
         +O85nuEojoH6CdW6KGXhxuWr0WLoYZZ/5LhB37zIgUBDM+R7KqXEqHERc3o0ymHpHaOA
         LTmw==
X-Gm-Message-State: AOAM532tYPCAdecwGvYhA86G+tVoZxd0EtY6TgcPri9ZS4fFCRGT5S0X
        qRxuOe6bzLP1o/bMzKJHejs=
X-Google-Smtp-Source: ABdhPJyepEmOBOqOlRQr+/nG28rnh9kHVvQL/4zx7facwSuG+BUHciKJV+0kqUzfLRBaOMx0PDdEKQ==
X-Received: by 2002:a19:fc0f:: with SMTP id a15mr9469592lfi.248.1606750674784;
        Mon, 30 Nov 2020 07:37:54 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id q16sm2950131ljj.32.2020.11.30.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:37:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kjlFu-0002Ol-Ob; Mon, 30 Nov 2020 16:38:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/5] serial: core: add sysfs attribute to suppress ready signalling on open
Date:   Mon, 30 Nov 2020 16:37:39 +0100
Message-Id: <20201130153742.9163-3-johan@kernel.org>
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
 Documentation/ABI/testing/sysfs-tty |  7 +++++++
 drivers/tty/serial/serial_core.c    | 29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

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
index f41cba10b86b..063a617182ce 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2805,6 +2805,33 @@ static ssize_t console_store(struct device *dev,
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
+	tty_port_set_nordy(port, val);
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(uartclk);
 static DEVICE_ATTR_RO(type);
 static DEVICE_ATTR_RO(line);
@@ -2819,6 +2846,7 @@ static DEVICE_ATTR_RO(io_type);
 static DEVICE_ATTR_RO(iomem_base);
 static DEVICE_ATTR_RO(iomem_reg_shift);
 static DEVICE_ATTR_RW(console);
+static DEVICE_ATTR_RW(nordy);
 
 static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_uartclk.attr,
@@ -2835,6 +2863,7 @@ static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_iomem_base.attr,
 	&dev_attr_iomem_reg_shift.attr,
 	&dev_attr_console.attr,
+	&dev_attr_nordy.attr,
 	NULL
 };
 
-- 
2.26.2

