From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/7] i2c: i2c-qcom-geni: Add bus driver for the
 Qualcomm GENI I2C controller
Date: Wed, 17 Jan 2018 21:23:53 -0800
Message-ID: <20180118052353.GA12583@builder>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-6-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1515805547-22816-6-git-send-email-kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karthikeyan Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: corbet-T1hC0tSOHrs@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri 12 Jan 17:05 PST 2018, Karthikeyan Ramasubramanian wrote:

> This bus driver supports the GENI based i2c hardware controller in the
> Qualcomm SOCs. The Qualcomm Generic Interface (GENI) is a programmable
> module supporting a wide range of serial interfaces including I2C. The
> driver supports FIFO mode and DMA mode of transfer and switches modes
> dynamically depending on the size of the transfer.
> 
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig         |  10 +
>  drivers/i2c/busses/Makefile        |   1 +
>  drivers/i2c/busses/i2c-qcom-geni.c | 656 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 667 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-qcom-geni.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 009345d..caef309 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -838,6 +838,16 @@ config I2C_PXA_SLAVE
>  	  is necessary for systems where the PXA may be a target on the
>  	  I2C bus.
>  
> +config I2C_QCOM_GENI
> +	tristate "Qualcomm Technologies Inc.'s GENI based I2C controller"
> +	depends on ARCH_QCOM

Just depend on the GENI wrapper as well.

> +	help
> +	  If you say yes to this option, support will be included for the
> +	  built-in I2C interface on the Qualcomm Technologies Inc.'s SoCs.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-qcom-geni.
> +
>  config I2C_QUP
>  	tristate "Qualcomm QUP based I2C controller"
>  	depends on ARCH_QCOM
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 2ce8576..201fce1 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
>  obj-$(CONFIG_I2C_PUV3)		+= i2c-puv3.o
>  obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
>  obj-$(CONFIG_I2C_PXA_PCI)	+= i2c-pxa-pci.o
> +obj-$(CONFIG_I2C_QCOM_GENI)	+= i2c-qcom-geni.o
>  obj-$(CONFIG_I2C_QUP)		+= i2c-qup.o
>  obj-$(CONFIG_I2C_RIIC)		+= i2c-riic.o
>  obj-$(CONFIG_I2C_RK3X)		+= i2c-rk3x.o
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> new file mode 100644
> index 0000000..59ad4da
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -0,0 +1,656 @@
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */

Use SPDX license header.

> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>

Unused?

> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/qcom-geni-se.h>
> +
> +#define SE_I2C_TX_TRANS_LEN		(0x26C)

Drop the parenthesis, when not needed.

> +#define SE_I2C_RX_TRANS_LEN		(0x270)
> +#define SE_I2C_SCL_COUNTERS		(0x278)
> +#define SE_GENI_IOS			(0x908)
> +
> +#define SE_I2C_ERR  (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |\
> +			M_GP_IRQ_1_EN | M_GP_IRQ_3_EN | M_GP_IRQ_4_EN)
> +#define SE_I2C_ABORT (1U << 1)
> +/* M_CMD OP codes for I2C */
> +#define I2C_WRITE		(0x1)
> +#define I2C_READ		(0x2)
> +#define I2C_WRITE_READ		(0x3)
> +#define I2C_ADDR_ONLY		(0x4)
> +#define I2C_BUS_CLEAR		(0x6)
> +#define I2C_STOP_ON_BUS		(0x7)
> +/* M_CMD params for I2C */
> +#define PRE_CMD_DELAY		(BIT(0))
> +#define TIMESTAMP_BEFORE	(BIT(1))
> +#define STOP_STRETCH		(BIT(2))
> +#define TIMESTAMP_AFTER		(BIT(3))
> +#define POST_COMMAND_DELAY	(BIT(4))
> +#define IGNORE_ADD_NACK		(BIT(6))
> +#define READ_FINISHED_WITH_ACK	(BIT(7))
> +#define BYPASS_ADDR_PHASE	(BIT(8))
> +#define SLV_ADDR_MSK		(GENMASK(15, 9))
> +#define SLV_ADDR_SHFT		(9)
> +
> +#define I2C_CORE2X_VOTE		(10000)
> +#define GP_IRQ0			0
> +#define GP_IRQ1			1
> +#define GP_IRQ2			2
> +#define GP_IRQ3			3
> +#define GP_IRQ4			4
> +#define GP_IRQ5			5
> +#define GENI_OVERRUN		6
> +#define GENI_ILLEGAL_CMD	7
> +#define GENI_ABORT_DONE		8
> +#define GENI_TIMEOUT		9
> +
> +#define I2C_NACK		GP_IRQ1
> +#define I2C_BUS_PROTO		GP_IRQ3
> +#define I2C_ARB_LOST		GP_IRQ4
> +#define DM_I2C_CB_ERR		((BIT(GP_IRQ1) | BIT(GP_IRQ3) | BIT(GP_IRQ4)) \
> +									<< 5)
> +
> +#define I2C_AUTO_SUSPEND_DELAY	250
> +#define KHz(freq)		(1000 * freq)
> +
> +struct geni_i2c_dev {
> +	struct device *dev;
> +	void __iomem *base;
> +	unsigned int tx_wm;
> +	int irq;
> +	int err;
> +	struct i2c_adapter adap;
> +	struct completion xfer;

How about naming this "done" or something like that, gi2c->xfer doesn't
really give the sense of being a "we're done with the operation"-event.

> +	struct i2c_msg *cur;
> +	struct geni_se_rsc i2c_rsc;
> +	int cur_wr;
> +	int cur_rd;
> +	struct device *wrapper_dev;

This is already availabe in i2c_rsc, and in particular if you pass the
i2c_rsc down to the wrapper in the 2 cases you use the wrapper_dev you
don't need this duplication.

> +	u32 clk_freq_out;
> +	int clk_fld_idx;

Keep track of the const struct geni_i2c_clk_fld * here instead.

> +};
> +
> +struct geni_i2c_err_log {
> +	int err;
> +	const char *msg;
> +};
> +
> +static struct geni_i2c_err_log gi2c_log[] = {
> +	[GP_IRQ0] = {-EINVAL, "Unknown I2C err GP_IRQ0"},
> +	[I2C_NACK] = {-ENOTCONN,
> +			"NACK: slv unresponsive, check its power/reset-ln"},

Break the 80-char rule, to improve readability.

> +	[GP_IRQ2] = {-EINVAL, "Unknown I2C err GP IRQ2"},
> +	[I2C_BUS_PROTO] = {-EPROTO,
> +				"Bus proto err, noisy/unepxected start/stop"},
> +	[I2C_ARB_LOST] = {-EBUSY,
> +				"Bus arbitration lost, clock line undriveable"},
> +	[GP_IRQ5] = {-EINVAL, "Unknown I2C err GP IRQ5"},
> +	[GENI_OVERRUN] = {-EIO, "Cmd overrun, check GENI cmd-state machine"},
> +	[GENI_ILLEGAL_CMD] = {-EILSEQ,
> +				"Illegal cmd, check GENI cmd-state machine"},
> +	[GENI_ABORT_DONE] = {-ETIMEDOUT, "Abort after timeout successful"},
> +	[GENI_TIMEOUT] = {-ETIMEDOUT, "I2C TXN timed out"},
> +};
> +
> +struct geni_i2c_clk_fld {
> +	u32	clk_freq_out;
> +	u8	clk_div;
> +	u8	t_high;
> +	u8	t_low;
> +	u8	t_cycle;
> +};
> +
> +static struct geni_i2c_clk_fld geni_i2c_clk_map[] = {

const

> +	{KHz(100), 7, 10, 11, 26},
> +	{KHz(400), 2,  5, 12, 24},
> +	{KHz(1000), 1, 3,  9, 18},
> +};
> +
> +static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
> +{
> +	int i;
> +	int ret = 0;
> +	bool clk_map_present = false;
> +	struct geni_i2c_clk_fld *itr = geni_i2c_clk_map;
> +
> +	for (i = 0; i < ARRAY_SIZE(geni_i2c_clk_map); i++, itr++) {
> +		if (itr->clk_freq_out == gi2c->clk_freq_out) {
> +			clk_map_present = true;
> +			break;

Make this:
			gi2c->clk_fld = geni_i2c_clk_map + i;
			return 0;

> +		}
> +	}
> +

...then you can drop ret and clk_map_present and just return -EINVAL
here.

> +	if (clk_map_present)
> +		gi2c->clk_fld_idx = i;
> +	else
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +static inline void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c, int dfs)

Drop the "inline", if it makes sense the compiler will inline it, if not
it knows better than we do.

dfs is always 0, so drop this parameter and hard code the value below.

> +{
> +	struct geni_i2c_clk_fld *itr = geni_i2c_clk_map + gi2c->clk_fld_idx;
> +
> +	geni_write_reg(dfs, gi2c->base, SE_GENI_CLK_SEL);
> +
> +	geni_write_reg((itr->clk_div << 4) | 1, gi2c->base, GENI_SER_M_CLK_CFG);
> +	geni_write_reg(((itr->t_high << 20) | (itr->t_low << 10) |
> +			itr->t_cycle), gi2c->base, SE_I2C_SCL_COUNTERS);
> +
> +	/* Ensure Clk config completes before return */

That's not what "mb" does, it ensures that later memory operations
aren't reordered beyond the barrier.

> +	mb();
> +}
> +
> +static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)

Looking at the code in this function it's just a bunch of logic to print
various debug messages...except for the last line that uses the gi2c_log
lookup table to convert the error to a errno. Sneaky...and not very
nice.

> +{
> +	u32 m_cmd = readl_relaxed(gi2c->base + SE_GENI_M_CMD0);

Unless you have a really good reason, just use readl/writel in favour of
their _relaxed versions.

> +	u32 m_stat = readl_relaxed(gi2c->base + SE_GENI_M_IRQ_STATUS);
> +	u32 geni_s = readl_relaxed(gi2c->base + SE_GENI_STATUS);
> +	u32 geni_ios = readl_relaxed(gi2c->base + SE_GENI_IOS);
> +	u32 dma = readl_relaxed(gi2c->base + SE_GENI_DMA_MODE_EN);
> +	u32 rx_st, tx_st;
> +
> +	if (gi2c->cur)
> +		dev_dbg(gi2c->dev, "len:%d, slv-addr:0x%x, RD/WR:%d\n",
> +			gi2c->cur->len, gi2c->cur->addr, gi2c->cur->flags);
> +
> +	if (err == I2C_NACK || err == GENI_ABORT_DONE) {
> +		dev_dbg(gi2c->dev, "%s\n", gi2c_log[err].msg);
> +		goto err_ret;
> +	} else {
> +		dev_err(gi2c->dev, "%s\n", gi2c_log[err].msg);
> +	}
> +
> +	if (dma) {
> +		rx_st = readl_relaxed(gi2c->base + SE_DMA_RX_IRQ_STAT);
> +		tx_st = readl_relaxed(gi2c->base + SE_DMA_TX_IRQ_STAT);
> +	} else {
> +		rx_st = readl_relaxed(gi2c->base + SE_GENI_RX_FIFO_STATUS);
> +		tx_st = readl_relaxed(gi2c->base + SE_GENI_TX_FIFO_STATUS);
> +	}
> +	dev_dbg(gi2c->dev, "DMA:%d tx_stat:0x%x, rx_stat:0x%x, irq-stat:0x%x\n",
> +		dma, tx_st, rx_st, m_stat);
> +	dev_dbg(gi2c->dev, "m_cmd:0x%x, geni_status:0x%x, geni_ios:0x%x\n",
> +		m_cmd, geni_s, geni_ios);
> +err_ret:
> +	gi2c->err = gi2c_log[err].err;
> +}
> +
> +static irqreturn_t geni_i2c_irq(int irq, void *dev)
> +{
> +	struct geni_i2c_dev *gi2c = dev;
> +	int i, j;
> +	u32 m_stat = readl_relaxed(gi2c->base + SE_GENI_M_IRQ_STATUS);
> +	u32 rx_st = readl_relaxed(gi2c->base + SE_GENI_RX_FIFO_STATUS);
> +	u32 dm_tx_st = readl_relaxed(gi2c->base + SE_DMA_TX_IRQ_STAT);
> +	u32 dm_rx_st = readl_relaxed(gi2c->base + SE_DMA_RX_IRQ_STAT);
> +	u32 dma = readl_relaxed(gi2c->base + SE_GENI_DMA_MODE_EN);
> +	struct i2c_msg *cur = gi2c->cur;
> +
> +	if (!cur || (m_stat & M_CMD_FAILURE_EN) ||
> +		    (dm_rx_st & (DM_I2C_CB_ERR)) ||
> +		    (m_stat & M_CMD_ABORT_EN)) {
> +
> +		if (m_stat & M_GP_IRQ_1_EN)
> +			geni_i2c_err(gi2c, I2C_NACK);
> +		if (m_stat & M_GP_IRQ_3_EN)
> +			geni_i2c_err(gi2c, I2C_BUS_PROTO);
> +		if (m_stat & M_GP_IRQ_4_EN)
> +			geni_i2c_err(gi2c, I2C_ARB_LOST);
> +		if (m_stat & M_CMD_OVERRUN_EN)
> +			geni_i2c_err(gi2c, GENI_OVERRUN);
> +		if (m_stat & M_ILLEGAL_CMD_EN)
> +			geni_i2c_err(gi2c, GENI_ILLEGAL_CMD);
> +		if (m_stat & M_CMD_ABORT_EN)
> +			geni_i2c_err(gi2c, GENI_ABORT_DONE);
> +		if (m_stat & M_GP_IRQ_0_EN)
> +			geni_i2c_err(gi2c, GP_IRQ0);
> +
> +		if (!dma)
> +			writel_relaxed(0, (gi2c->base +
> +					   SE_GENI_TX_WATERMARK_REG));

Drop the extra parenthesis. And using writel() instead keeps you under
80 chars.

> +		goto irqret;
> +	}
> +
> +	if (dma) {
> +		dev_dbg(gi2c->dev, "i2c dma tx:0x%x, dma rx:0x%x\n", dm_tx_st,
> +			dm_rx_st);
> +		goto irqret;
> +	}
> +
> +	if (((m_stat & M_RX_FIFO_WATERMARK_EN) ||
> +		(m_stat & M_RX_FIFO_LAST_EN)) && (cur->flags & I2C_M_RD)) {

Some of these parenthesis are unnecessary, but more importantly the way
you wrap this line is misleading; the wrapping indicates that the two
latter conditionals are related, but the parenthesis says the first two
are.

The most significant part of this conditional is "is this a read
operation", so put this first.


> +		u32 rxcnt = rx_st & RX_FIFO_WC_MSK;
> +
> +		for (j = 0; j < rxcnt; j++) {
> +			u32 temp;
> +			int p;
> +
> +			temp = readl_relaxed(gi2c->base + SE_GENI_RX_FIFOn);
> +			for (i = gi2c->cur_rd, p = 0; (i < cur->len && p < 4);
> +				i++, p++)
> +				cur->buf[i] = (u8) ((temp >> (p * 8)) & 0xff);
> +			gi2c->cur_rd = i;

The two-range for loop with a line wrap isn't very clean and the wrap
calls for a set of braces - which will look ugly.

How about something like this instead?

			p = 0;
			while (p < 4 && gi2c->cur_rd < cur->len) {
				cur->buf[gi2c->cur_rd++] = temp & 0xff;
				temp >>= 8;
				p++;
			}

> +			if (gi2c->cur_rd == cur->len) {
> +				dev_dbg(gi2c->dev, "FIFO i:%d,read 0x%x\n",
> +					i, temp);

Who's the consumer of this debug line?

> +				break;
> +			}
> +		}
> +	} else if ((m_stat & M_TX_FIFO_WATERMARK_EN) &&
> +					!(cur->flags & I2C_M_RD)) {
> +		for (j = 0; j < gi2c->tx_wm; j++) {
> +			u32 temp = 0;
> +			int p;
> +
> +			for (i = gi2c->cur_wr, p = 0; (i < cur->len && p < 4);
> +				i++, p++)
> +				temp |= (((u32)(cur->buf[i]) << (p * 8)));
> +			writel_relaxed(temp, gi2c->base + SE_GENI_TX_FIFOn);

Same concern as above.

> +			gi2c->cur_wr = i;
> +			dev_dbg(gi2c->dev, "FIFO i:%d,wrote 0x%x\n", i, temp);
> +			if (gi2c->cur_wr == cur->len) {
> +				dev_dbg(gi2c->dev, "FIFO i2c bytes done writing\n");
> +				writel_relaxed(0,
> +				(gi2c->base + SE_GENI_TX_WATERMARK_REG));

The line break here is bad.  checkpatch.pl --strict will help you find
these.

Also using writel() and dropping the parenthesis keeps you below 80
chars.

> +				break;
> +			}
> +		}
> +	}
> +irqret:
> +	if (m_stat)
> +		writel_relaxed(m_stat, gi2c->base + SE_GENI_M_IRQ_CLEAR);

Is it okay for this to be re-ordered wrt above writes?

> +
> +	if (dma) {
> +		if (dm_tx_st)
> +			writel_relaxed(dm_tx_st, gi2c->base +
> +				       SE_DMA_TX_IRQ_CLR);

Use writel() and you don't have to wrap the line.

> +		if (dm_rx_st)
> +			writel_relaxed(dm_rx_st, gi2c->base +
> +				       SE_DMA_RX_IRQ_CLR);
> +		/* Ensure all writes are done before returning from ISR. */

That's not what wmb does.

> +		wmb();
> +	}
> +	/* if this is err with done-bit not set, handle that thr' timeout. */

Is "thr'" should for "through"?

> +	if (m_stat & M_CMD_DONE_EN)
> +		complete(&gi2c->xfer);
> +	else if ((dm_tx_st & TX_DMA_DONE) || (dm_rx_st & RX_DMA_DONE))
> +		complete(&gi2c->xfer);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int geni_i2c_xfer(struct i2c_adapter *adap,
> +			 struct i2c_msg msgs[],
> +			 int num)
> +{
> +	struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
> +	int i, ret = 0, timeout = 0;

No need to initialize these, first use is an assignment.

> +
> +	gi2c->err = 0;
> +	gi2c->cur = &msgs[0];

You're assigning cur in each iteration of the loop below, why do you
need to do it here as well?

> +	reinit_completion(&gi2c->xfer);
> +	ret = pm_runtime_get_sync(gi2c->dev);
> +	if (ret < 0) {
> +		dev_err(gi2c->dev, "error turning SE resources:%d\n", ret);
> +		pm_runtime_put_noidle(gi2c->dev);
> +		/* Set device in suspended since resume failed */
> +		pm_runtime_set_suspended(gi2c->dev);
> +		return ret;

With the questionable assignment above you're leaving the function with
gi2c->cur pointing to an object that will soon be invalid.

> +	}
> +
> +	qcom_geni_i2c_conf(gi2c, 0);
> +	dev_dbg(gi2c->dev, "i2c xfer:num:%d, msgs:len:%d,flg:%d\n",
> +				num, msgs[0].len, msgs[0].flags);

Use dynamic function tracing instead of debug prints for this.

> +	for (i = 0; i < num; i++) {

I suggest that you split out two functions here, one for rx-one-message
and one for tx-one-message. There are some duplication between the two,
but not too bad.

> +		int stretch = (i < (num - 1));
> +		u32 m_param = 0;
> +		u32 m_cmd = 0;
> +		dma_addr_t tx_dma = 0;
> +		dma_addr_t rx_dma = 0;
> +		enum geni_se_xfer_mode mode = FIFO_MODE;

No need to initialize mode, as the first use is an assignment.

> +
> +		m_param |= (stretch ? STOP_STRETCH : 0);
> +		m_param |= ((msgs[i].addr & 0x7F) << SLV_ADDR_SHFT);

Drop some parenthesis.

> +
> +		gi2c->cur = &msgs[i];
> +		mode = msgs[i].len > 32 ? SE_DMA : FIFO_MODE;
> +		ret = geni_se_select_mode(gi2c->base, mode);
> +		if (ret) {
> +			dev_err(gi2c->dev, "%s: Error mode init %d:%d:%d\n",
> +				__func__, mode, i, msgs[i].len);
> +			break;
> +		}
> +		if (msgs[i].flags & I2C_M_RD) {
> +			dev_dbg(gi2c->dev,
> +				"READ,n:%d,i:%d len:%d, stretch:%d\n",
> +					num, i, msgs[i].len, stretch);
> +			geni_write_reg(msgs[i].len,
> +				       gi2c->base, SE_I2C_RX_TRANS_LEN);
> +			m_cmd = I2C_READ;
> +			geni_se_setup_m_cmd(gi2c->base, m_cmd, m_param);

Drop m_cmd and just write I2C_READ in the function call.

> +			if (mode == SE_DMA) {
> +				ret = geni_se_rx_dma_prep(gi2c->wrapper_dev,
> +							gi2c->base, msgs[i].buf,
> +							msgs[i].len, &rx_dma);
> +				if (ret) {
> +					mode = FIFO_MODE;
> +					ret = geni_se_select_mode(gi2c->base,
> +								  mode);
> +				}
> +			}
> +		} else {
> +			dev_dbg(gi2c->dev,
> +				"WRITE:n:%d,i:%d len:%d, stretch:%d, m_param:0x%x\n",
> +					num, i, msgs[i].len, stretch, m_param);
> +			geni_write_reg(msgs[i].len, gi2c->base,
> +						SE_I2C_TX_TRANS_LEN);
> +			m_cmd = I2C_WRITE;
> +			geni_se_setup_m_cmd(gi2c->base, m_cmd, m_param);
> +			if (mode == SE_DMA) {
> +				ret = geni_se_tx_dma_prep(gi2c->wrapper_dev,
> +							gi2c->base, msgs[i].buf,
> +							msgs[i].len, &tx_dma);
> +				if (ret) {
> +					mode = FIFO_MODE;
> +					ret = geni_se_select_mode(gi2c->base,
> +								  mode);
> +				}
> +			}
> +			if (mode == FIFO_MODE) /* Get FIFO IRQ */
> +				geni_write_reg(1, gi2c->base,
> +						SE_GENI_TX_WATERMARK_REG);
> +		}
> +		/* Ensure FIFO write go through before waiting for Done evet */

That's not what mb does, drop it.

> +		mb();
> +		timeout = wait_for_completion_timeout(&gi2c->xfer, HZ);

As written you should just use "ret", but the return value of
wait_for_completion_timeout() is unsigned long, so change the type of
timeout instead.

> +		if (!timeout) {
> +			geni_i2c_err(gi2c, GENI_TIMEOUT);
> +			gi2c->cur = NULL;
> +			geni_se_abort_m_cmd(gi2c->base);
> +			timeout = wait_for_completion_timeout(&gi2c->xfer, HZ);

What if it takes a fraction above HZ time to complete the previous
operation, then you might end up here with the completion completed, but
from the wrong operation.

> +		}
> +		gi2c->cur_wr = 0;
> +		gi2c->cur_rd = 0;
> +		if (mode == SE_DMA) {
> +			if (gi2c->err) {
> +				if (msgs[i].flags != I2C_M_RD)
> +					writel_relaxed(1, gi2c->base +
> +							SE_DMA_TX_FSM_RST);
> +				else
> +					writel_relaxed(1, gi2c->base +
> +							SE_DMA_RX_FSM_RST);
> +				wait_for_completion_timeout(&gi2c->xfer, HZ);
> +			}
> +			geni_se_rx_dma_unprep(gi2c->wrapper_dev, rx_dma,
> +					      msgs[i].len);

Reduce the length of gi2c->wrapper_dev here by using a local variable,
so that you get below (or close to) 80 chars.

Also, in either rx or tx cases above I see only that you prep one of
thse, and then you're unprepping both.

> +			geni_se_tx_dma_unprep(gi2c->wrapper_dev, tx_dma,
> +					      msgs[i].len);
> +		}
> +		ret = gi2c->err;
> +		if (gi2c->err) {
> +			dev_err(gi2c->dev, "i2c error :%d\n", gi2c->err);
> +			break;
> +		}
> +	}
> +	if (ret == 0)
> +		ret = num;
> +
> +	pm_runtime_mark_last_busy(gi2c->dev);
> +	pm_runtime_put_autosuspend(gi2c->dev);
> +	gi2c->cur = NULL;
> +	gi2c->err = 0;
> +	dev_dbg(gi2c->dev, "i2c txn ret:%d\n", ret);
> +	return ret;
> +}
[..]
> +static int geni_i2c_probe(struct platform_device *pdev)
> +{
> +	struct geni_i2c_dev *gi2c;
> +	struct resource *res;
> +	int ret;
> +
> +	gi2c = devm_kzalloc(&pdev->dev, sizeof(*gi2c), GFP_KERNEL);
> +	if (!gi2c)
> +		return -ENOMEM;
> +
> +	gi2c->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;

Put this right before devm_ioremap_resource() and drop the error check.

> +
> +	gi2c->wrapper_dev = pdev->dev.parent;
> +	gi2c->i2c_rsc.wrapper_dev = pdev->dev.parent;

As suggested in the other patch, if you have an helper function in the
wrapper driver that initializes the i2c_rsc then this could fill out the
actual wrapper, instead of just the device.

> +	gi2c->i2c_rsc.se_clk = devm_clk_get(&pdev->dev, "se-clk");
> +	if (IS_ERR(gi2c->i2c_rsc.se_clk)) {
> +		ret = PTR_ERR(gi2c->i2c_rsc.se_clk);
> +		dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
> +		return ret;
> +	}
> +
> +	gi2c->base = devm_ioremap_resource(gi2c->dev, res);
> +	if (IS_ERR(gi2c->base))
> +		return PTR_ERR(gi2c->base);
> +
> +	gi2c->i2c_rsc.geni_pinctrl = devm_pinctrl_get(&pdev->dev);

Drop all the pinctrl stuff. You might still want to call
pinctrl_pm_select_{idle,default,sleep}_state(), in the various stages of
PM state though.

> +	if (IS_ERR_OR_NULL(gi2c->i2c_rsc.geni_pinctrl)) {
> +		dev_err(&pdev->dev, "No pinctrl config specified\n");
> +		ret = PTR_ERR(gi2c->i2c_rsc.geni_pinctrl);
> +		return ret;
> +	}
[..]
> +static int geni_i2c_runtime_resume(struct device *dev)
> +{
> +	int ret;
> +	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
> +
> +	ret = geni_se_resources_on(&gi2c->i2c_rsc);
> +	if (ret)
> +		return ret;
> +
> +	if (!unlikely(gi2c->tx_wm)) {

Drop the unlikely()

> +		int proto = geni_se_get_proto(gi2c->base);
> +		int gi2c_tx_depth = geni_se_get_tx_fifo_depth(gi2c->base);
> +
> +		if (unlikely(proto != I2C)) {

Has this changes since probe? Can't we verify that the proto is correct
during probe and then just trust that the hardware doesn't change
function?

> +			dev_err(gi2c->dev, "Invalid proto %d\n", proto);
> +			geni_se_resources_off(&gi2c->i2c_rsc);
> +			return -ENXIO;
> +		}
> +
> +		gi2c->tx_wm = gi2c_tx_depth - 1;
> +		geni_se_init(gi2c->base, gi2c->tx_wm, gi2c_tx_depth);
> +		geni_se_config_packing(gi2c->base, 8, 4, true);
> +		dev_dbg(gi2c->dev, "i2c fifo/se-dma mode. fifo depth:%d\n",
> +			gi2c_tx_depth);
> +	}
> +	enable_irq(gi2c->irq);
> +
> +	return 0;
> +}
[..]
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:i2c_geni");

What will reference the kernel module by this alias?

> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
