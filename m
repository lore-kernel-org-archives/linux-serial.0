Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEE8C3B18F
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 11:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0022E24649
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgBNLnp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:43:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:20672 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgBNLnp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 06:43:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 03:43:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="252614646"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Feb 2020 03:43:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F78D393; Fri, 14 Feb 2020 13:43:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/8] serial: core: Allow detach and attach serial device for console
Date:   Fri, 14 Feb 2020 13:43:35 +0200
Message-Id: <20200214114339.53897-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
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
index 7564bbd3061c..0415bb76efa0 100644
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
@@ -2749,6 +2749,56 @@ static ssize_t uart_get_attr_iomem_reg_shift(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.iomem_reg_shift);
 }
 
+static ssize_t uart_get_attr_console(struct device *dev,
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
+static ssize_t uart_set_attr_console(struct device *dev,
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
 static DEVICE_ATTR(type, 0440, uart_get_attr_type, NULL);
 static DEVICE_ATTR(line, 0440, uart_get_attr_line, NULL);
 static DEVICE_ATTR(port, 0440, uart_get_attr_port, NULL);
@@ -2762,6 +2812,7 @@ static DEVICE_ATTR(custom_divisor, 0440, uart_get_attr_custom_divisor, NULL);
 static DEVICE_ATTR(io_type, 0440, uart_get_attr_io_type, NULL);
 static DEVICE_ATTR(iomem_base, 0440, uart_get_attr_iomem_base, NULL);
 static DEVICE_ATTR(iomem_reg_shift, 0440, uart_get_attr_iomem_reg_shift, NULL);
+static DEVICE_ATTR(console, 0640, uart_get_attr_console, uart_set_attr_console);
 
 static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_type.attr,
@@ -2777,12 +2828,13 @@ static struct attribute *tty_dev_attrs[] = {
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

