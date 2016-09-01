From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] serial: 8250_dw: Use an unified new dev variable in probe
Date: Thu, 1 Sep 2016 10:24:19 +0800
Message-ID: <1472696659-38719-1-git-send-email-wangkefeng.wang@huawei.com>
References: <20160831134407.GA8067@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160831134407.GA8067@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, guohanjun@huawei.com, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

Use an unified new dev variable instead of &pdev->dev and p->dev
in probe function.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

Hi Greg, updated, based on tty-testing branch :)

v1->v2:
1) Add Heikki's reviewed-by
2) Rebase on tty-testing branch of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

 drivers/tty/serial/8250/8250_dw.c | 45 ++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index b022f5a..47e6d08 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -360,18 +360,19 @@ static int dw8250_probe(struct platform_device *pdev)
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int irq = platform_get_irq(pdev, 0);
 	struct uart_port *p = &uart.port;
+	struct device *dev = &pdev->dev;
 	struct dw8250_data *data;
 	int err;
 	u32 val;
 
 	if (!regs) {
-		dev_err(&pdev->dev, "no registers defined\n");
+		dev_err(dev, "no registers defined\n");
 		return -EINVAL;
 	}
 
 	if (irq < 0) {
 		if (irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "cannot get irq\n");
+			dev_err(dev, "cannot get irq\n");
 		return irq;
 	}
 
@@ -382,16 +383,16 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->pm		= dw8250_do_pm;
 	p->type		= PORT_8250;
 	p->flags	= UPF_SHARE_IRQ | UPF_FIXED_PORT;
-	p->dev		= &pdev->dev;
+	p->dev		= dev;
 	p->iotype	= UPIO_MEM;
 	p->serial_in	= dw8250_serial_in;
 	p->serial_out	= dw8250_serial_out;
 
-	p->membase = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
+	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
 	if (!p->membase)
 		return -ENOMEM;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -399,57 +400,57 @@ static int dw8250_probe(struct platform_device *pdev)
 	data->usr_reg = DW_UART_USR;
 	p->private_data = data;
 
-	data->uart_16550_compatible = device_property_read_bool(p->dev,
+	data->uart_16550_compatible = device_property_read_bool(dev,
 						"snps,uart-16550-compatible");
 
-	err = device_property_read_u32(p->dev, "reg-shift", &val);
+	err = device_property_read_u32(dev, "reg-shift", &val);
 	if (!err)
 		p->regshift = val;
 
-	err = device_property_read_u32(p->dev, "reg-io-width", &val);
+	err = device_property_read_u32(dev, "reg-io-width", &val);
 	if (!err && val == 4) {
 		p->iotype = UPIO_MEM32;
 		p->serial_in = dw8250_serial_in32;
 		p->serial_out = dw8250_serial_out32;
 	}
 
-	if (device_property_read_bool(p->dev, "dcd-override")) {
+	if (device_property_read_bool(dev, "dcd-override")) {
 		/* Always report DCD as active */
 		data->msr_mask_on |= UART_MSR_DCD;
 		data->msr_mask_off |= UART_MSR_DDCD;
 	}
 
-	if (device_property_read_bool(p->dev, "dsr-override")) {
+	if (device_property_read_bool(dev, "dsr-override")) {
 		/* Always report DSR as active */
 		data->msr_mask_on |= UART_MSR_DSR;
 		data->msr_mask_off |= UART_MSR_DDSR;
 	}
 
-	if (device_property_read_bool(p->dev, "cts-override")) {
+	if (device_property_read_bool(dev, "cts-override")) {
 		/* Always report CTS as active */
 		data->msr_mask_on |= UART_MSR_CTS;
 		data->msr_mask_off |= UART_MSR_DCTS;
 	}
 
-	if (device_property_read_bool(p->dev, "ri-override")) {
+	if (device_property_read_bool(dev, "ri-override")) {
 		/* Always report Ring indicator as inactive */
 		data->msr_mask_off |= UART_MSR_RI;
 		data->msr_mask_off |= UART_MSR_TERI;
 	}
 
 	/* Always ask for fixed clock rate from a property. */
-	device_property_read_u32(p->dev, "clock-frequency", &p->uartclk);
+	device_property_read_u32(dev, "clock-frequency", &p->uartclk);
 
 	/* If there is separate baudclk, get the rate from it. */
-	data->clk = devm_clk_get(&pdev->dev, "baudclk");
+	data->clk = devm_clk_get(dev, "baudclk");
 	if (IS_ERR(data->clk) && PTR_ERR(data->clk) != -EPROBE_DEFER)
-		data->clk = devm_clk_get(&pdev->dev, NULL);
+		data->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(data->clk) && PTR_ERR(data->clk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 	if (!IS_ERR_OR_NULL(data->clk)) {
 		err = clk_prepare_enable(data->clk);
 		if (err)
-			dev_warn(&pdev->dev, "could not enable optional baudclk: %d\n",
+			dev_warn(dev, "could not enable optional baudclk: %d\n",
 				 err);
 		else
 			p->uartclk = clk_get_rate(data->clk);
@@ -457,11 +458,11 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
-		dev_err(&pdev->dev, "clock rate not defined\n");
+		dev_err(dev, "clock rate not defined\n");
 		return -EINVAL;
 	}
 
-	data->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
+	data->pclk = devm_clk_get(dev, "apb_pclk");
 	if (IS_ERR(data->pclk) && PTR_ERR(data->pclk) == -EPROBE_DEFER) {
 		err = -EPROBE_DEFER;
 		goto err_clk;
@@ -469,12 +470,12 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!IS_ERR(data->pclk)) {
 		err = clk_prepare_enable(data->pclk);
 		if (err) {
-			dev_err(&pdev->dev, "could not enable apb_pclk\n");
+			dev_err(dev, "could not enable apb_pclk\n");
 			goto err_clk;
 		}
 	}
 
-	data->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
+	data->rst = devm_reset_control_get_optional(dev, NULL);
 	if (IS_ERR(data->rst) && PTR_ERR(data->rst) == -EPROBE_DEFER) {
 		err = -EPROBE_DEFER;
 		goto err_pclk;
@@ -506,8 +507,8 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
 	return 0;
 
-- 
1.7.12.4
