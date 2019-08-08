From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Date: Thu, 8 Aug 2019 09:08:33 +0100
Message-ID: <20190808080832.nleult5bknmzr3ze@willie-the-truck>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, Larisa Ileana Grigore <larisa.grigore@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:
> Introduce support for LINFlex driver, based on:
> - the version of Freescale LPUART driver after commit b3e3bf2ef2c7 ("Merge
>   4.0-rc7 into tty-next");
> - commit abf1e0a98083 ("tty: serial: fsl_lpuart: lock port on console
>   write").
> In this basic version, the driver can be tested using initramfs and relies
> on the clocks and pin muxing set up by U-Boot.
> 
> Remarks concerning the earlycon support:
> 
> - LinFlexD does not allow character transmissions in the INIT mode (see
>   section 47.4.2.1 in the reference manual[1]). Therefore, a mutual
>   exclusion between the first linflex_setup_watermark/linflex_set_termios
>   executions and linflex_earlycon_putchar was employed and the characters
>   normally sent to earlycon during initialization are kept in a buffer and
>   sent afterwards.
> 
> - Empirically, character transmission is also forbidden within the last 1-2
>   ms before entering the INIT mode, so we use an explicit timeout
>   (PREINIT_DELAY) between linflex_earlycon_putchar and the first call to
>   linflex_setup_watermark.
> 
> - U-Boot currently uses the UART FIFO mode, while this driver makes the
>   transition to the buffer mode. Therefore, the earlycon putchar function
>   matches the U-Boot behavior before initializations and the Linux behavior
>   after.
> 
> [1] https://www.nxp.com/webapp/Download?colCode=S32V234RM
> 
> Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> Signed-off-by: Adrian.Nitu <adrian.nitu@freescale.com>
> Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
> Signed-off-by: Ana Nedelcu <B56683@freescale.com>
> Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
> Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
> [stefan-gabriel.mirea@nxp.com: Reduced for upstreaming and implemented
>                                earlycon support]
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   6 +
>  drivers/tty/serial/Kconfig                    |  15 +
>  drivers/tty/serial/Makefile                   |   1 +
>  drivers/tty/serial/fsl_linflexuart.c          | 956 ++++++++++++++++++
>  include/uapi/linux/serial_core.h              |   3 +
>  5 files changed, 981 insertions(+)
>  create mode 100644 drivers/tty/serial/fsl_linflexuart.c
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 46b826fcb5ad..4d545732aadc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1090,6 +1090,12 @@
>  			the framebuffer, pass the 'ram' option so that it is
>  			mapped with the correct attributes.
>  
> +		linflex,<addr>
> +			Use early console provided by Freescale LinFlex UART
> +			serial driver for NXP S32V234 SoCs. A valid base
> +			address must be provided, and the serial port must
> +			already be setup and configured.

Why isn't earlycon= sufficient for this?

Will
