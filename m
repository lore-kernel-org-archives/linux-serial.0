Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0CBC761A3
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9322B20836
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgBQLkU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:40:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:21719 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728688AbgBQLkU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 06:40:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 03:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="382163694"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 Feb 2020 03:40:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AAF78211; Mon, 17 Feb 2020 13:40:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/6] serial: core: Switch to use DEVICE_ATTR_RO()
Date:   Mon, 17 Feb 2020 13:40:11 +0200
Message-Id: <20200217114016.49856-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Move device attributes to DEVICE_ATTR_RO() as that would make things
a lot more "obvious" what is happening here.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 57 ++++++++++++++++----------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7564bbd3061c..5444293fe2e8 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2614,7 +2614,7 @@ struct tty_driver *uart_console_device(struct console *co, int *index)
 }
 EXPORT_SYMBOL_GPL(uart_console_device);
 
-static ssize_t uart_get_attr_uartclk(struct device *dev,
+static ssize_t uartclk_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2624,7 +2624,7 @@ static ssize_t uart_get_attr_uartclk(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.baud_base * 16);
 }
 
-static ssize_t uart_get_attr_type(struct device *dev,
+static ssize_t type_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2633,7 +2633,8 @@ static ssize_t uart_get_attr_type(struct device *dev,
 	uart_get_info(port, &tmp);
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.type);
 }
-static ssize_t uart_get_attr_line(struct device *dev,
+
+static ssize_t line_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2643,7 +2644,7 @@ static ssize_t uart_get_attr_line(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.line);
 }
 
-static ssize_t uart_get_attr_port(struct device *dev,
+static ssize_t port_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2657,7 +2658,7 @@ static ssize_t uart_get_attr_port(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "0x%lX\n", ioaddr);
 }
 
-static ssize_t uart_get_attr_irq(struct device *dev,
+static ssize_t irq_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2667,7 +2668,7 @@ static ssize_t uart_get_attr_irq(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.irq);
 }
 
-static ssize_t uart_get_attr_flags(struct device *dev,
+static ssize_t flags_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2677,7 +2678,7 @@ static ssize_t uart_get_attr_flags(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "0x%X\n", tmp.flags);
 }
 
-static ssize_t uart_get_attr_xmit_fifo_size(struct device *dev,
+static ssize_t xmit_fifo_size_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2687,8 +2688,7 @@ static ssize_t uart_get_attr_xmit_fifo_size(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.xmit_fifo_size);
 }
 
-
-static ssize_t uart_get_attr_close_delay(struct device *dev,
+static ssize_t close_delay_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2698,8 +2698,7 @@ static ssize_t uart_get_attr_close_delay(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.close_delay);
 }
 
-
-static ssize_t uart_get_attr_closing_wait(struct device *dev,
+static ssize_t closing_wait_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2709,7 +2708,7 @@ static ssize_t uart_get_attr_closing_wait(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.closing_wait);
 }
 
-static ssize_t uart_get_attr_custom_divisor(struct device *dev,
+static ssize_t custom_divisor_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2719,7 +2718,7 @@ static ssize_t uart_get_attr_custom_divisor(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.custom_divisor);
 }
 
-static ssize_t uart_get_attr_io_type(struct device *dev,
+static ssize_t io_type_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2729,7 +2728,7 @@ static ssize_t uart_get_attr_io_type(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.io_type);
 }
 
-static ssize_t uart_get_attr_iomem_base(struct device *dev,
+static ssize_t iomem_base_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2739,7 +2738,7 @@ static ssize_t uart_get_attr_iomem_base(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "0x%lX\n", (unsigned long)tmp.iomem_base);
 }
 
-static ssize_t uart_get_attr_iomem_reg_shift(struct device *dev,
+static ssize_t iomem_reg_shift_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct serial_struct tmp;
@@ -2749,28 +2748,28 @@ static ssize_t uart_get_attr_iomem_reg_shift(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.iomem_reg_shift);
 }
 
-static DEVICE_ATTR(type, 0440, uart_get_attr_type, NULL);
-static DEVICE_ATTR(line, 0440, uart_get_attr_line, NULL);
-static DEVICE_ATTR(port, 0440, uart_get_attr_port, NULL);
-static DEVICE_ATTR(irq, 0440, uart_get_attr_irq, NULL);
-static DEVICE_ATTR(flags, 0440, uart_get_attr_flags, NULL);
-static DEVICE_ATTR(xmit_fifo_size, 0440, uart_get_attr_xmit_fifo_size, NULL);
-static DEVICE_ATTR(uartclk, 0440, uart_get_attr_uartclk, NULL);
-static DEVICE_ATTR(close_delay, 0440, uart_get_attr_close_delay, NULL);
-static DEVICE_ATTR(closing_wait, 0440, uart_get_attr_closing_wait, NULL);
-static DEVICE_ATTR(custom_divisor, 0440, uart_get_attr_custom_divisor, NULL);
-static DEVICE_ATTR(io_type, 0440, uart_get_attr_io_type, NULL);
-static DEVICE_ATTR(iomem_base, 0440, uart_get_attr_iomem_base, NULL);
-static DEVICE_ATTR(iomem_reg_shift, 0440, uart_get_attr_iomem_reg_shift, NULL);
+static DEVICE_ATTR_RO(uartclk);
+static DEVICE_ATTR_RO(type);
+static DEVICE_ATTR_RO(line);
+static DEVICE_ATTR_RO(port);
+static DEVICE_ATTR_RO(irq);
+static DEVICE_ATTR_RO(flags);
+static DEVICE_ATTR_RO(xmit_fifo_size);
+static DEVICE_ATTR_RO(close_delay);
+static DEVICE_ATTR_RO(closing_wait);
+static DEVICE_ATTR_RO(custom_divisor);
+static DEVICE_ATTR_RO(io_type);
+static DEVICE_ATTR_RO(iomem_base);
+static DEVICE_ATTR_RO(iomem_reg_shift);
 
 static struct attribute *tty_dev_attrs[] = {
+	&dev_attr_uartclk.attr,
 	&dev_attr_type.attr,
 	&dev_attr_line.attr,
 	&dev_attr_port.attr,
 	&dev_attr_irq.attr,
 	&dev_attr_flags.attr,
 	&dev_attr_xmit_fifo_size.attr,
-	&dev_attr_uartclk.attr,
 	&dev_attr_close_delay.attr,
 	&dev_attr_closing_wait.attr,
 	&dev_attr_custom_divisor.attr,
-- 
2.25.0

