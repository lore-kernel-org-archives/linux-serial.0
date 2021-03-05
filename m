Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22A9C433E0
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 11:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B41764F76
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 11:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCELv2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 06:51:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37336 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCELvU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 06:51:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 491251F469FF
Received: by jupiter.universe (Postfix, from userid 1000)
        id D964D4800C3; Fri,  5 Mar 2021 12:51:16 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Ian Ray <ian.ray@ge.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, kernel@collabora.com
Subject: [PATCHv4] serial: imx: Add DMA buffer configuration via sysfs
Date:   Fri,  5 Mar 2021 12:50:58 +0100
Message-Id: <20210305115058.92284-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fabien Lahoudere <fabien.lahoudere@collabora.com>

In order to optimize serial communication (performance/throughput VS
latency), we may need to tweak DMA period number and size. This adds
sysfs attributes to configure those values before initialising DMA.
The defaults will stay the same as before (16 buffers with a size of
1024 bytes). Afterwards the values can be read/write with the
following sysfs files:

/sys/class/tty/ttymxc*/dma_buffer_size
/sys/class/tty/ttymxc*/dma_buffer_count

This is mainly needed for GEHC CS ONE (arch/arm/boot/dts/imx53-ppd.dts),
which has multiple microcontrollers connected via UART controlling. One
of the UARTs is connected to an on-board microcontroller at 19200 baud,
which constantly pushes critical data (so aging character detect
interrupt will never trigger). This data must be processed at 50-200 Hz,
so UART should return data in less than 5-20ms. With 1024 byte DMA
buffer (and a constant data stream) the read operation instead needs
1024 byte / 19200 baud = 53.333ms, which is way too long (note: Worst
Case would be remote processor sending data with short pauses <= 7
characters, which would further increase this number). The current
downstream kernel instead configures 24 bytes resulting in 1.25ms,
but that is obviously not sensible for normal UART use cases and cannot
be used as new default.

The same device also has another microcontroller with a 4M baud UART
connection exchanging lots of data. For this the same mechanism can
be used to increase the buffer size (downstream uses 4K instead of
the default 1K) with potentially slightly reduced buffer count. At
this baud rate latency is not an issue (4096 byte / 4M baud = 0.977 ms).
Before increasing the default buffer count from 4 to 16 in 76c38d30fee7,
this was required to avoid data loss. With the changed default it's
a performance optimization.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
[reword documentation and commit message, rebase to current code]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
I excluded Fabien from the Cc list, his mail address is no longer valid.

Changes since PATCHv3 [*]:
 * rewrote commit message to provide a lot more details why this is needed
 * rebased to torvalds/master (5.12-rc1-dontuse), also applies on top of linux-next
 * use sysfs_emit() instead of sprintf

[*] https://lore.kernel.org/lkml/1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com/
---
 .../ABI/stable/sysfs-driver-imx-uart          | 12 +++
 drivers/tty/serial/imx.c                      | 98 +++++++++++++++++--
 2 files changed, 103 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-imx-uart

diff --git a/Documentation/ABI/stable/sysfs-driver-imx-uart b/Documentation/ABI/stable/sysfs-driver-imx-uart
new file mode 100644
index 000000000000..27a50fcd9c5f
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-imx-uart
@@ -0,0 +1,12 @@
+What:		/sys/class/tty/ttymxc*/dma_buffer_count
+Date:		March 2021
+Contact:	Sebastian Reichel <sebastian.reichel@collabora.com>
+Description:	The i.MX serial DMA buffer is split into multiple chunks, so that
+		chunks can be processed while others are being filled with data.
+		This represents the number of chunks.
+
+What:		/sys/class/tty/ttymxc*/dma_buffer_size
+Date:		March 2021
+Contact:	Sebastian Reichel <sebastian.reichel@collabora.com>
+Description:	This represents the size of each DMA buffer chunk. Total DMA
+		buffer size is this number multiplied by dma_buffer_count.
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8257597d034d..1c5eb7be0c07 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -225,6 +225,8 @@ struct imx_port {
 	struct scatterlist	rx_sgl, tx_sgl[2];
 	void			*rx_buf;
 	struct circ_buf		rx_ring;
+	unsigned int		rx_buf_size;
+	unsigned int		rx_period_length;
 	unsigned int		rx_periods;
 	dma_cookie_t		rx_cookie;
 	unsigned int		tx_bytes;
@@ -1193,10 +1195,6 @@ static void imx_uart_dma_rx_callback(void *data)
 	}
 }
 
-/* RX DMA buffer periods */
-#define RX_DMA_PERIODS	16
-#define RX_BUF_SIZE	(RX_DMA_PERIODS * PAGE_SIZE / 4)
-
 static int imx_uart_start_rx_dma(struct imx_port *sport)
 {
 	struct scatterlist *sgl = &sport->rx_sgl;
@@ -1207,9 +1205,8 @@ static int imx_uart_start_rx_dma(struct imx_port *sport)
 
 	sport->rx_ring.head = 0;
 	sport->rx_ring.tail = 0;
-	sport->rx_periods = RX_DMA_PERIODS;
 
-	sg_init_one(sgl, sport->rx_buf, RX_BUF_SIZE);
+	sg_init_one(sgl, sport->rx_buf, sport->rx_buf_size);
 	ret = dma_map_sg(dev, sgl, 1, DMA_FROM_DEVICE);
 	if (ret == 0) {
 		dev_err(dev, "DMA mapping error for RX.\n");
@@ -1326,7 +1323,8 @@ static int imx_uart_dma_init(struct imx_port *sport)
 		goto err;
 	}
 
-	sport->rx_buf = kzalloc(RX_BUF_SIZE, GFP_KERNEL);
+	sport->rx_buf_size = sport->rx_period_length * sport->rx_periods;
+	sport->rx_buf = kzalloc(sport->rx_buf_size, GFP_KERNEL);
 	if (!sport->rx_buf) {
 		ret = -ENOMEM;
 		goto err;
@@ -1786,6 +1784,85 @@ static const char *imx_uart_type(struct uart_port *port)
 	return sport->port.type == PORT_IMX ? "IMX" : NULL;
 }
 
+static ssize_t dma_buffer_size_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	unsigned int plen;
+	int ret;
+	struct device *port_device = dev->parent;
+	struct imx_port *sport = dev_get_drvdata(port_device);
+
+	if (sport->dma_chan_rx) {
+		dev_warn(dev, "RX DMA in use\n");
+		return -EBUSY;
+	}
+
+	ret = kstrtou32(buf, 0, &plen);
+	if (ret == 0) {
+		sport->rx_period_length = plen;
+		ret = count;
+	}
+
+	return ret;
+}
+
+static ssize_t dma_buffer_size_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct device *port_device = dev->parent;
+	struct imx_port *sport = dev_get_drvdata(port_device);
+
+	return sysfs_emit(buf, "%u\n", sport->rx_period_length);
+}
+
+static DEVICE_ATTR_RW(dma_buffer_size);
+
+static ssize_t dma_buffer_count_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	unsigned int periods;
+	int ret;
+	struct device *port_device = dev->parent;
+	struct imx_port *sport = dev_get_drvdata(port_device);
+
+	if (sport->dma_chan_rx) {
+		dev_warn(dev, "RX DMA in use\n");
+		return -EBUSY;
+	}
+
+	ret = kstrtou32(buf, 0, &periods);
+	if (ret == 0) {
+		sport->rx_periods = periods;
+		ret = count;
+	}
+
+	return ret;
+}
+
+static ssize_t dma_buffer_count_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct device *port_device = dev->parent;
+	struct imx_port *sport = dev_get_drvdata(port_device);
+
+	return sysfs_emit(buf, "%u\n", sport->rx_periods);
+}
+
+static DEVICE_ATTR_RW(dma_buffer_count);
+
+static struct attribute *imx_uart_attrs[] = {
+	&dev_attr_dma_buffer_size.attr,
+	&dev_attr_dma_buffer_count.attr,
+	NULL
+};
+static struct attribute_group imx_uart_attr_group = {
+	.attrs = imx_uart_attrs,
+};
+
 /*
  * Configure/autoconfigure the port.
  */
@@ -2189,6 +2266,10 @@ static enum hrtimer_restart imx_trigger_stop_tx(struct hrtimer *t)
 	return HRTIMER_NORESTART;
 }
 
+/* Default RX DMA buffer configuration */
+#define RX_DMA_PERIODS		16
+#define RX_DMA_PERIOD_LEN	(PAGE_SIZE / 4)
+
 static int imx_uart_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -2257,6 +2338,9 @@ static int imx_uart_probe(struct platform_device *pdev)
 	sport->port.rs485_config = imx_uart_rs485_config;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	timer_setup(&sport->timer, imx_uart_timeout, 0);
+	sport->rx_period_length = RX_DMA_PERIOD_LEN;
+	sport->rx_periods = RX_DMA_PERIODS;
+	sport->port.attr_group = &imx_uart_attr_group;
 
 	sport->gpios = mctrl_gpio_init(&sport->port, 0);
 	if (IS_ERR(sport->gpios))
-- 
2.30.1

