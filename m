From: Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [v2,3/7] soc: qcom: Add GENI based QUP Wrapper driver
Date: Wed, 24 Jan 2018 15:06:18 -0800
Message-ID: <CAE=gft6vjPRpNAg4sivt_r3Ynf5jkg=h8fsrAcP1c4q5jF-x+g@mail.gmail.com>
References: <1515805547-22816-4-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515805547-22816-4-git-send-email-kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: corbet-T1hC0tSOHrs@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: Karthikeyan Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 12, 2018 at 5:05 PM, Karthikeyan Ramasubramanian
<kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> This driver manages the Generic Interface (GENI) firmware based Qualcomm
> Universal Peripheral (QUP) Wrapper. GENI based QUP is the next generation
> programmable module composed of multiple Serial Engines (SE) and supports
> a wide range of serial interfaces like UART, SPI, I2C, I3C, etc. This
> driver also enables managing the serial interface independent aspects of
> Serial Engines.
>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/soc/qcom/Kconfig        |    8 +
>  drivers/soc/qcom/Makefile       |    1 +
>  drivers/soc/qcom/qcom-geni-se.c | 1016 +++++++++++++++++++++++++++++++++++++++
>  include/linux/qcom-geni-se.h    |  807 +++++++++++++++++++++++++++++++
>  4 files changed, 1832 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom-geni-se.c
>  create mode 100644 include/linux/qcom-geni-se.h

I'm a newbie here, just starting to get up to speed. Please forgive
any indiscretions. But I am interested in this driver, so I'm throwing
in my minor comments.


> +/**
> + * geni_se_setup_m_cmd() - Setup the primary sequencer
> + * @base:      Base address of the serial engine's register block.
> + * @cmd:       Command/Operation to setup in the primary sequencer.
> + * @params:    Parameter for the sequencer command.
> + *
> + * This function is used to configure the primary sequencer with the
> + * command and its assoicated parameters.
> + */
> +void geni_se_setup_m_cmd(void __iomem *base, u32 cmd, u32 params);
> +
> +/**
> + * geni_se_setup_s_cmd() - Setup the secondary sequencer
> + * @base:      Base address of the serial engine's register block.
> + * @cmd:       Command/Operation to setup in the secondary sequencer.
> + * @params:    Parameter for the sequencer command.
> + *
> + * This function is used to configure the secondary sequencer with the
> + * command and its assoicated parameters.
> + */
> +void geni_se_setup_s_cmd(void __iomem *base, u32 cmd, u32 params);
> +

s/assoicated/associated/ (twice)


> +/**
> + * geni_se_tx_dma_prep() - Prepare the Serial Engine for TX DMA transfer
> + * @wrapper_dev:       QUP Wrapper Device to which the TX buffer is mapped.
> + * @base:              Base address of the SE register block.
> + * @tx_buf:            Pointer to the TX buffer.
> + * @tx_len:            Length of the TX buffer.
> + * @tx_dma:            Pointer to store the mapped DMA address.
> + *
> + * This function is used to prepare the buffers for DMA TX.
> + *
> + * Return:     0 on success, standard Linux error codes on error/failure.
> + */
> +int geni_se_tx_dma_prep(struct device *wrapper_dev, void __iomem *base,
> +                       void *tx_buf, int tx_len, dma_addr_t *tx_dma)
> +{
> +       int ret;
> +
> +       if (unlikely(!wrapper_dev || !base || !tx_buf || !tx_len || !tx_dma))
> +               return -EINVAL;
> +
> +       ret = geni_se_map_buf(wrapper_dev, tx_dma, tx_buf, tx_len,
> +                                   DMA_TO_DEVICE);
> +       if (ret)
> +               return ret;
> +
> +       geni_write_reg(7, base, SE_DMA_TX_IRQ_EN_SET);
> +       geni_write_reg((u32)(*tx_dma), base, SE_DMA_TX_PTR_L);
> +       geni_write_reg((u32)((*tx_dma) >> 32), base, SE_DMA_TX_PTR_H);
> +       geni_write_reg(1, base, SE_DMA_TX_ATTR);

Bjorn touched on this, but as someone trying to understand what's
going on it would be great to see #defines for the magic values in
here (7 and 1)

> +void geni_se_get_packing_config(int bpw, int pack_words, bool msb_to_lsb,
> +                               unsigned long *cfg0, unsigned long *cfg1)
> +{
> +       u32 cfg[4] = {0};
> +       int len;
> +       int temp_bpw = bpw;
> +       int idx_start = (msb_to_lsb ? (bpw - 1) : 0);
> +       int idx = idx_start;
> +       int idx_delta = (msb_to_lsb ? -BITS_PER_BYTE : BITS_PER_BYTE);
> +       int ceil_bpw = ((bpw & (BITS_PER_BYTE - 1)) ?
> +                       ((bpw & ~(BITS_PER_BYTE - 1)) + BITS_PER_BYTE) : bpw);
> +       int iter = (ceil_bpw * pack_words) >> 3;

Is the shift by 3 here really meant to divide by BITS_PER_BYTE? It
might be clearer to divide by BITS_PER_BYTE and let the compiler
convert that into a shift.

> +       int i;
> +
> +       if (unlikely(iter <= 0 || iter > 4)) {
> +               *cfg0 = 0;
> +               *cfg1 = 0;
> +               return;
> +       }
> +
> +       for (i = 0; i < iter; i++) {
> +               len = (temp_bpw < BITS_PER_BYTE) ?
> +                               (temp_bpw - 1) : BITS_PER_BYTE - 1;
> +               cfg[i] = ((idx << 5) | (msb_to_lsb << 4) | (len << 1));

...more magic numbers here. These are register bitfields? It would be
great to get the field shifts defined.

> +               idx = ((temp_bpw - BITS_PER_BYTE) <= 0) ?
> +                               ((i + 1) * BITS_PER_BYTE) + idx_start :
> +                               idx + idx_delta;
> +               temp_bpw = ((temp_bpw - BITS_PER_BYTE) <= 0) ?
> +                               bpw : (temp_bpw - BITS_PER_BYTE);
> +       }
> +       cfg[iter - 1] |= 1;
> +       *cfg0 = cfg[0] | (cfg[1] << 10);
> +       *cfg1 = cfg[2] | (cfg[3] << 10);
> +}

...more magic shifts here.

> +void geni_se_config_packing(void __iomem *base, int bpw,
> +                           int pack_words, bool msb_to_lsb)
> +{
> +       unsigned long cfg0, cfg1;
> +
> +       geni_se_get_packing_config(bpw, pack_words, msb_to_lsb, &cfg0, &cfg1);
> +       geni_write_reg(cfg0, base, SE_GENI_TX_PACKING_CFG0);
> +       geni_write_reg(cfg1, base, SE_GENI_TX_PACKING_CFG1);
> +       geni_write_reg(cfg0, base, SE_GENI_RX_PACKING_CFG0);
> +       geni_write_reg(cfg1, base, SE_GENI_RX_PACKING_CFG1);
> +       if (pack_words || bpw == 32)
> +               geni_write_reg((bpw >> 4), base, SE_GENI_BYTE_GRAN);
> +}

...Same here for the bpw >> 4.

Thanks,
Evan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
