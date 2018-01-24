From: Evan Green <evgreen@chromium.org>
Subject: Re: [v2, 5/7] i2c: i2c-qcom-geni: Add bus driver for the Qualcomm
 GENI I2C controller
Date: Wed, 24 Jan 2018 15:07:24 -0800
Message-ID: <CAE=gft43TbHVfQrMnqFnWmmc7XVy-cmV4DQy-u5GTmtCmwFjLQ@mail.gmail.com>
References: <1515805547-22816-6-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1515805547-22816-6-git-send-email-kramasub@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 12, 2018 at 5:05 PM, Karthikeyan Ramasubramanian
<kramasub@codeaurora.org> wrote:
> This bus driver supports the GENI based i2c hardware controller in the
> Qualcomm SOCs. The Qualcomm Generic Interface (GENI) is a programmable
> module supporting a wide range of serial interfaces including I2C. The
> driver supports FIFO mode and DMA mode of transfer and switches modes
> dynamically depending on the size of the transfer.
>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  drivers/i2c/busses/Kconfig         |  10 +
>  drivers/i2c/busses/Makefile        |   1 +
>  drivers/i2c/busses/i2c-qcom-geni.c | 656 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 667 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-qcom-geni.c

Newbie again, throwing in my two cents.

> +static inline void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c, int dfs)
> +{
> +       struct geni_i2c_clk_fld *itr = geni_i2c_clk_map + gi2c->clk_fld_idx;
> +
> +       geni_write_reg(dfs, gi2c->base, SE_GENI_CLK_SEL);
> +
> +       geni_write_reg((itr->clk_div << 4) | 1, gi2c->base, GENI_SER_M_CLK_CFG);
> +       geni_write_reg(((itr->t_high << 20) | (itr->t_low << 10) |
> +                       itr->t_cycle), gi2c->base, SE_I2C_SCL_COUNTERS);

It would be great to get these register field shifts defined, as
they're otherwise fairly opaque.

> +static irqreturn_t geni_i2c_irq(int irq, void *dev)
> +{
> +       struct geni_i2c_dev *gi2c = dev;
> +       int i, j;
> +       u32 m_stat = readl_relaxed(gi2c->base + SE_GENI_M_IRQ_STATUS);
> +       u32 rx_st = readl_relaxed(gi2c->base + SE_GENI_RX_FIFO_STATUS);
> +       u32 dm_tx_st = readl_relaxed(gi2c->base + SE_DMA_TX_IRQ_STAT);
> +       u32 dm_rx_st = readl_relaxed(gi2c->base + SE_DMA_RX_IRQ_STAT);
> +       u32 dma = readl_relaxed(gi2c->base + SE_GENI_DMA_MODE_EN);
> +       struct i2c_msg *cur = gi2c->cur;
> +
> +       if (!cur || (m_stat & M_CMD_FAILURE_EN) ||
> +                   (dm_rx_st & (DM_I2C_CB_ERR)) ||
> +                   (m_stat & M_CMD_ABORT_EN)) {
> +
> +               if (m_stat & M_GP_IRQ_1_EN)
> +                       geni_i2c_err(gi2c, I2C_NACK);
> +               if (m_stat & M_GP_IRQ_3_EN)
> +                       geni_i2c_err(gi2c, I2C_BUS_PROTO);
> +               if (m_stat & M_GP_IRQ_4_EN)
> +                       geni_i2c_err(gi2c, I2C_ARB_LOST);
> +               if (m_stat & M_CMD_OVERRUN_EN)
> +                       geni_i2c_err(gi2c, GENI_OVERRUN);
> +               if (m_stat & M_ILLEGAL_CMD_EN)
> +                       geni_i2c_err(gi2c, GENI_ILLEGAL_CMD);
> +               if (m_stat & M_CMD_ABORT_EN)
> +                       geni_i2c_err(gi2c, GENI_ABORT_DONE);
> +               if (m_stat & M_GP_IRQ_0_EN)
> +                       geni_i2c_err(gi2c, GP_IRQ0);
> +
> +               if (!dma)
> +                       writel_relaxed(0, (gi2c->base +
> +                                          SE_GENI_TX_WATERMARK_REG));

The writes to the TX_WATERMARK_REG here and a little further down in
the irq handler stick out to me. A comment as to why poking at the
watermark register is necessary here would be very helpful.

-Evan
