From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH v2 3/7] soc: qcom: Add GENI based QUP Wrapper driver
Date: Wed, 14 Feb 2018 16:37:05 +0530
Message-ID: <CAHLCerOf3WMUind8-5Z+c6iXyyYvdjS7MaMbO8WzNU2-VaREPg@mail.gmail.com>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org> <1515805547-22816-4-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1515805547-22816-4-git-send-email-kramasub@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: corbet@lwn.net, Andy Gross <andy.gross@linaro.org>, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 13, 2018 at 6:35 AM, Karthikeyan Ramasubramanian
<kramasub@codeaurora.org> wrote:
> This driver manages the Generic Interface (GENI) firmware based Qualcomm
> Universal Peripheral (QUP) Wrapper. GENI based QUP is the next generation
> programmable module composed of multiple Serial Engines (SE) and supports
> a wide range of serial interfaces like UART, SPI, I2C, I3C, etc. This
> driver also enables managing the serial interface independent aspects of
> Serial Engines.
>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>


> +int geni_se_resources_off(struct geni_se_rsc *rsc)
> +{
> +       int ret = 0;
> +       struct geni_se_device *geni_se_dev;
> +
> +       if (unlikely(!rsc || !rsc->wrapper_dev))
> +               return -EINVAL;
> +
> +       geni_se_dev = dev_get_drvdata(rsc->wrapper_dev);
> +       if (unlikely(!geni_se_dev))
> +               return -ENODEV;
> +
> +       ret = pinctrl_select_state(rsc->geni_pinctrl, rsc->geni_gpio_sleep);

You need to include linux/pinctrl/consumer.h for devm_pinctrl_get

I couldn't compile test it w/o it.
