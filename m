From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/6] tty: serial: msm: Add RX DMA support
Date: Wed, 30 Sep 2015 14:30:36 +0100
Message-ID: <20150930133036.GJ10997@leverpostej>
References: <1443614906-2196-1-git-send-email-ivan.ivanov@linaro.org>
 <1443614906-2196-6-git-send-email-ivan.ivanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443614906-2196-6-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frank.rowand@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Sep 30, 2015 at 01:08:25PM +0100, Ivan T. Ivanov wrote:
> Add receive DMA support for UARTDM type of controllers.
> 
> Tested on APQ8064, which have UARTDM v1.3 and ADM DMA engine
> and APQ8016, which have UARTDM v1.4 and BAM DMA engine.
> 
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> ---
>  .../devicetree/bindings/serial/qcom,msm-uartdm.txt |   3 +
>  drivers/tty/serial/msm_serial.c                    | 232 ++++++++++++++++++++-
>  drivers/tty/serial/msm_serial.h                    |   4 +
>  3 files changed, 236 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> index a600023d9ec1..182777fac9a2 100644
> --- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> +++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> @@ -29,6 +29,9 @@ Optional properties:
>  - qcom,tx-crci: Identificator <u32> for Client Rate Control Interface to be
>             used with TX DMA channel. Required when using DMA for transmission
>             with UARTDM v1.3 and bellow.
> +- qcom,rx-crci: Identificator <u32> for Client Rate Control Interface to be
> +           used with RX DMA channel. Required when using DMA for reception
> +           with UARTDM v1.3 and bellow.

My comments on qcom,tx-crci apply to qcom,rx-crci too.

This does not deel like it belongs in the UART binding and/or driver.

Mark.
