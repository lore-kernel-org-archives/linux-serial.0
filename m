Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85528C7619F
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F7720836
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgBQLkU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:40:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:26496 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbgBQLkT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 06:40:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 03:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="268386933"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Feb 2020 03:40:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B2CA748B; Mon, 17 Feb 2020 13:40:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/6] serial: core: Allow detach and attach serial device for console
Date:   Mon, 17 Feb 2020 13:40:12 +0200
Message-Id: <20200217114016.49856-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In the future we would like to disable power management on the serial devices
used as kernel consoles to avoid weird behaviour in some cases. However,
disabling PM may prevent system to go to deep sleep states, which in its turn
leads to the higher power consumption.

Tony Lindgren proposed a work around, i.e. allow user to detach such consoles
to make PM working again. In case user wants to see what's going on, it also
provides a mechanism to attach console back.

Link: https://lists.openwall.net/linux-kernel/2018/09/29/65
Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-tty |  7 ++++
 drivers/tty/serial/serial_core.c    | 60 +++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index 9eb3c2b6b040..e157130a6792 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -154,3 +154,10 @@ Description:
 		 device specification. For example, when user sets 7bytes on
 		 16550A, which has 1/4/8/14 bytes trigger, the RX trigger is
 		 automatically changed to 4 bytes.
+
+What:		/sys/class/tty/ttyS0/console
+Date:		February 2020
+Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+Description:
+		 Allows user to detach or attach back the given device as
+		 kernel console. It shows and accepts a boolean variable.
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 5444293fe2e8..20ab89300a98 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1919,7 +1919,7 @@ static inline bool uart_console_enabled(struct uart_port *port)
  */
 static inline void uart_port_spin_lock_init(struct uart_port *port)
 {
-	if (uart_console_enabled(port))
+	if (uart_console(port))
 		return;
 
 	spin_lock_init(&port->lock);
@@ -2748,6 +2748,56 @@ static ssize_t iomem_reg_shift_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.iomem_reg_shift);
 }
 
+static ssize_t console_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport;
+	bool console = false;
+
+	mutex_lock(&port->mutex);
+	uport = uart_port_check(state);
+	if (uport)
+		console = uart_console_enabled(uport);
+	mutex_unlock(&port->mutex);
+
+	return sprintf(buf, "%c\n", console ? 'Y' : 'N');
+}
+
+static ssize_t console_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport;
+	bool oldconsole, newconsole;
+	int ret;
+
+	ret = kstrtobool(buf, &newconsole);
+	if (ret)
+		return ret;
+
+	mutex_lock(&port->mutex);
+	uport = uart_port_check(state);
+	if (uport) {
+		oldconsole = uart_console_enabled(uport);
+		if (oldconsole && !newconsole) {
+			ret = unregister_console(uport->cons);
+		} else if (!oldconsole && newconsole) {
+			if (uart_console(uport))
+				register_console(uport->cons);
+			else
+				ret = -ENOENT;
+		}
+	} else {
+		ret = -ENXIO;
+	}
+	mutex_unlock(&port->mutex);
+
+	return ret < 0 ? ret : count;
+}
+
 static DEVICE_ATTR_RO(uartclk);
 static DEVICE_ATTR_RO(type);
 static DEVICE_ATTR_RO(line);
@@ -2761,6 +2811,7 @@ static DEVICE_ATTR_RO(custom_divisor);
 static DEVICE_ATTR_RO(io_type);
 static DEVICE_ATTR_RO(iomem_base);
 static DEVICE_ATTR_RO(iomem_reg_shift);
+static DEVICE_ATTR_RW(console);
 
 static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_uartclk.attr,
@@ -2776,12 +2827,13 @@ static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_io_type.attr,
 	&dev_attr_iomem_base.attr,
 	&dev_attr_iomem_reg_shift.attr,
-	NULL,
-	};
+	&dev_attr_console.attr,
+	NULL
+};
 
 static const struct attribute_group tty_dev_attr_group = {
 	.attrs = tty_dev_attrs,
-	};
+};
 
 /**
  *	uart_add_one_port - attach a driver-defined port structure
-- 
2.25.0

