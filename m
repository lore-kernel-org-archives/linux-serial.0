From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH v2 7/7] tty: serial: msm_geni_serial: Add serial driver
 support for GENI based QUP
Date: Wed, 14 Feb 2018 16:34:39 +0530
Message-ID: <CAHLCerNN_U7z7xNWSHXPwaazokGhctaQH2Z70tokB7O7n2fLVA@mail.gmail.com>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org> <1515805547-22816-8-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1515805547-22816-8-git-send-email-kramasub@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: corbet@lwn.net, Andy Gross <andy.gross@linaro.org>, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Girish Mahadevan <girishm@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 13, 2018 at 6:35 AM, Karthikeyan Ramasubramanian
<kramasub@codeaurora.org> wrote:
> This driver supports GENI based UART Controller in the Qualcomm SOCs. The
> Qualcomm Generic Interface (GENI) is a programmable module supporting a
> wide range of serial interfaces including UART. This driver support console
> operations using FIFO mode of transfer.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> ---
>  drivers/tty/serial/Kconfig            |   10 +
>  drivers/tty/serial/Makefile           |    1 +
>  drivers/tty/serial/qcom_geni_serial.c | 1414 +++++++++++++++++++++++++++++++++
>  3 files changed, 1425 insertions(+)
>  create mode 100644 drivers/tty/serial/qcom_geni_serial.c

> +       if (!uport->membase) {
> +               ret = -ENOMEM;
> +               dev_err(&pdev->dev, "Err IO mapping serial iomem");
> +               goto exit_geni_serial_probe;
> +       }
> +
> +       dev_port->serial_rsc.geni_pinctrl = devm_pinctrl_get(&pdev->dev);

You need to include linux/pinctrl/consumer.h for devm_pinctrl_get

I couldn't compile test it w/o it.
