Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50327C35254
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F93020836
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgBQLkT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:40:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:11231 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbgBQLkT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 06:40:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 03:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="229172390"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Feb 2020 03:40:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BDF19554; Mon, 17 Feb 2020 13:40:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/6] serial: 8250_port: Switch to use DEVICE_ATTR_RW()
Date:   Mon, 17 Feb 2020 13:40:13 +0200
Message-Id: <20200217114016.49856-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Move device attributes to DEVICE_ATTR_RW() as that would make things
a lot more "obvious" what is happening here.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 0325f2e53b74..4f5d4cce4c8e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2880,7 +2880,7 @@ static int do_serial8250_get_rxtrig(struct tty_port *port)
 	return rxtrig_bytes;
 }
 
-static ssize_t serial8250_get_attr_rx_trig_bytes(struct device *dev,
+static ssize_t rx_trig_bytes_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
@@ -2926,7 +2926,7 @@ static int do_serial8250_set_rxtrig(struct tty_port *port, unsigned char bytes)
 	return ret;
 }
 
-static ssize_t serial8250_set_attr_rx_trig_bytes(struct device *dev,
+static ssize_t rx_trig_bytes_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
@@ -2947,18 +2947,16 @@ static ssize_t serial8250_set_attr_rx_trig_bytes(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(rx_trig_bytes, S_IRUSR | S_IWUSR | S_IRGRP,
-		   serial8250_get_attr_rx_trig_bytes,
-		   serial8250_set_attr_rx_trig_bytes);
+static DEVICE_ATTR_RW(rx_trig_bytes);
 
 static struct attribute *serial8250_dev_attrs[] = {
 	&dev_attr_rx_trig_bytes.attr,
-	NULL,
-	};
+	NULL
+};
 
 static struct attribute_group serial8250_dev_attr_group = {
 	.attrs = serial8250_dev_attrs,
-	};
+};
 
 static void register_dev_spec_attr_grp(struct uart_8250_port *up)
 {
-- 
2.25.0

