From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5] tty: serial: add Freescale lpuart driver support
Date: Mon, 3 Jun 2013 10:29:08 -0700
Message-ID: <20130603172908.GA3272@kroah.com>
References: <1369893217-27809-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38296 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759230Ab3FCR3J (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 13:29:09 -0400
Content-Disposition: inline
In-Reply-To: <1369893217-27809-1-git-send-email-b35083@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingchang Lu <b35083@freescale.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, s.hauer@pengutronix.de

On Thu, May 30, 2013 at 01:53:37PM +0800, Jingchang Lu wrote:
> Add Freescale lpuart driver support. The lpuart device
> can be found on Vybrid VF610 and Layerscape LS-1 SoCs.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> changes in v5:
>  Coding style fix, remove redundant code.
>  Checking clk_prepare_enable return value.
>  Using devm_ioremap_resource instead of devm_request_and_ioremap.
> 
> changes in v4:
>  Change Vybrid VF610 SoC compatible string to "fsl,vf610-lpuart"
> 
> changes in v3:
>  Use general driver name lpuart instead of mvf for further share between SoCs.
>  Add bind doc in Documentation/devicetree/bindings/tty/serial.
>  Remove unused #include header lines and clean up code.
> 
> changes in v2:
>  Remove unused variables and clean up the code.
> 
>  .../devicetree/bindings/tty/serial/fsl-lpuart.txt  |  14 +
>  drivers/tty/serial/Kconfig                         |  14 +
>  drivers/tty/serial/Makefile                        |   1 +
>  drivers/tty/serial/fsl_lpuart.c                    | 873 +++++++++++++++++++++
>  include/uapi/linux/serial_core.h                   |   3 +
>  5 files changed, 905 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-lpuart.txt
>  create mode 100644 drivers/tty/serial/fsl_lpuart.c
> 
> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-lpuart.txt
> new file mode 100644
> index 0000000..6fd1dd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-lpuart.txt
> @@ -0,0 +1,14 @@
> +* Freescale low power universal asynchronous receiver/transmitter (lpuart)
> +
> +Required properties:
> +- compatible : Should be "fsl,<soc>-lpuart"
> +- reg : Address and length of the register set for the device
> +- interrupts : Should contain uart interrupt
> +
> +Example:
> +
> +uart0: serial@40027000 {
> +	       compatible = "fsl,vf610-lpuart";
> +	       reg = <0x40027000 0x1000>;
> +	       interrupts = <0 61 0x00>;
> +       };
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 7e7006f..aee7030 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1484,6 +1484,20 @@ config SERIAL_RP2_NR_UARTS
>  	  If multiple cards are present, the default limit of 32 ports may
>  	  need to be increased.
>  
> +config SERIAL_FSL_LPUART
> +	bool "Freescale lpuart serial port support"

Why can't this be built as a module?  I can't force users to only build
this driver into the kernel, sorry.

greg k-h
