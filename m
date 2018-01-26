From: Doug Anderson <dianders@chromium.org>
Subject: Re: [v2,3/7] soc: qcom: Add GENI based QUP Wrapper driver
Date: Fri, 26 Jan 2018 11:38:51 -0800
Message-ID: <CAD=FV=XRvf+LYzrc8FX11dTG5KKbRyp5mTaP-39nC7SgjkZV_w@mail.gmail.com>
References: <1515805547-22816-4-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1515805547-22816-4-git-send-email-kramasub@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, andy.gross@linaro.org, david.brown@linaro.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>, evgreen@chromium.org
List-Id: linux-serial@vger.kernel.org

Hi,

On Fri, Jan 12, 2018 at 5:05 PM, Karthikeyan Ramasubramanian
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
> ---
>  drivers/soc/qcom/Kconfig        |    8 +
>  drivers/soc/qcom/Makefile       |    1 +
>  drivers/soc/qcom/qcom-geni-se.c | 1016 +++++++++++++++++++++++++++++++++++++++
>  include/linux/qcom-geni-se.h    |  807 +++++++++++++++++++++++++++++++
>  4 files changed, 1832 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom-geni-se.c
>  create mode 100644 include/linux/qcom-geni-se.h
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index b81374b..b306d51 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -3,6 +3,14 @@
>  #
>  menu "Qualcomm SoC drivers"
>
> +config QCOM_GENI_SE
> +       tristate "QCOM GENI Serial Engine Driver"

One tiny nit here: maybe it makes sense to add:

depends on ARCH_QCOM

...like all the other stuff in this file?  Otherwise this ends up
polluting .config files for non-Qualcomm architectures.


-Doug
