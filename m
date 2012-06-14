From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 00/16] Enable SPARSE_IRQ support for imx
Date: Thu, 14 Jun 2012 10:00:19 +0200
Message-ID: <20120614080019.GK30400@pengutronix.de>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46710 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab2FNIAb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Jun 2012 04:00:31 -0400
Content-Disposition: inline
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Dong Aisheng <b29396@freescale.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>

On Thu, Jun 14, 2012 at 01:59:31PM +0800, Shawn Guo wrote:
> It seems that the lack of SPARSE_IRQ support becomes the last blocker
> for imx being built with multi-platform.  The series is to enable
> SPARSE_IRQ for imx by having all the irqchips allocate their irq_descs.
> Along with the change, a legacy irqdomain is added for each of these
> irqchips (except ipu_irq) to help the mapping between hardware irq and
> Linux irq number, which is required by DT boot but also benefits non-DT.
> 
> Based on v3.5-rc2.  Boot tested on imx3, imx5 and imx6, and compile
> tested with imx_v4_v5_defconfig.

I gave it a test on i.MX1 and i.MX27, so

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Also, nice move ;)

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> Shawn Guo (16):
>   ARM: imx: eliminate macro IMX_GPIO_TO_IRQ()
>   ARM: imx: eliminate macro IOMUX_TO_IRQ()
>   ARM: imx: eliminate macro IRQ_GPIOx()
>   gpio/mxc: move irq_domain_add_legacy call into gpio driver
>   ARM: imx: move irq_domain_add_legacy call into tzic driver
>   ARM: imx: move irq_domain_add_legacy call into avic driver
>   dma: ipu: remove the use of ipu_platform_data
>   ARM: imx: leave irq_base of wm8350_platform_data uninitialized
>   ARM: imx: pass gpio than irq number into mxc_expio_init
>   ARM: imx: add a legacy irqdomain for 3ds_debugboard
>   ARM: imx: add a legacy irqdomain for mx31ads
>   i2c: imx: remove unneeded mach/irqs.h inclusion
>   ARM: imx: remove unneeded mach/irq.h inclusion
>   tty: serial: imx: remove the use of MXC_INTERNAL_IRQS
>   ARM: fiq: save FIQ_START by passing absolute fiq number
>   ARM: imx: enable SPARSE_IRQ for imx platform
> 
>  arch/arm/Kconfig                                |    1 +
>  arch/arm/kernel/fiq.c                           |    4 +-
>  arch/arm/mach-imx/devices-imx31.h               |    4 +-
>  arch/arm/mach-imx/devices-imx35.h               |    4 +-
>  arch/arm/mach-imx/eukrea_mbimx27-baseboard.c    |    3 +-
>  arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c  |    6 +-
>  arch/arm/mach-imx/imx27-dt.c                    |   28 ---
>  arch/arm/mach-imx/imx51-dt.c                    |   27 ---
>  arch/arm/mach-imx/imx53-dt.c                    |   27 ---
>  arch/arm/mach-imx/mach-apf9328.c                |    7 +-
>  arch/arm/mach-imx/mach-armadillo5x0.c           |   18 +-
>  arch/arm/mach-imx/mach-cpuimx27.c               |   12 +-
>  arch/arm/mach-imx/mach-cpuimx35.c               |    3 +-
>  arch/arm/mach-imx/mach-cpuimx51sd.c             |    3 +-
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |    9 +-
>  arch/arm/mach-imx/mach-imx6q.c                  |   14 --
>  arch/arm/mach-imx/mach-kzm_arm11_01.c           |   20 ++-
>  arch/arm/mach-imx/mach-mx1ads.c                 |    1 -
>  arch/arm/mach-imx/mach-mx21ads.c                |   16 ++-
>  arch/arm/mach-imx/mach-mx27_3ds.c               |    7 +-
>  arch/arm/mach-imx/mach-mx27ads.c                |   12 +-
>  arch/arm/mach-imx/mach-mx31_3ds.c               |   18 +--
>  arch/arm/mach-imx/mach-mx31ads.c                |   63 ++++---
>  arch/arm/mach-imx/mach-mx31lilly.c              |   10 +-
>  arch/arm/mach-imx/mach-mx31lite.c               |   11 +-
>  arch/arm/mach-imx/mach-mx31moboard.c            |   10 +-
>  arch/arm/mach-imx/mach-mx35_3ds.c               |   18 +--
>  arch/arm/mach-imx/mach-mx51_3ds.c               |    3 +-
>  arch/arm/mach-imx/mach-mx53_ard.c               |    5 +-
>  arch/arm/mach-imx/mach-mxt_td60.c               |    6 +-
>  arch/arm/mach-imx/mach-pca100.c                 |    5 +-
>  arch/arm/mach-imx/mach-pcm037.c                 |   24 ++--
>  arch/arm/mach-imx/mach-pcm038.c                 |    4 +-
>  arch/arm/mach-imx/mach-pcm043.c                 |    6 +-
>  arch/arm/mach-imx/mach-qong.c                   |   10 +-
>  arch/arm/mach-imx/mach-scb9328.c                |    7 +-
>  arch/arm/mach-imx/mach-vpr200.c                 |   10 +-
>  arch/arm/mach-imx/mm-imx1.c                     |    1 -
>  arch/arm/mach-imx/mm-imx21.c                    |    1 -
>  arch/arm/mach-imx/mm-imx25.c                    |    1 -
>  arch/arm/mach-imx/mm-imx27.c                    |    1 -
>  arch/arm/mach-imx/mm-imx3.c                     |    1 -
>  arch/arm/mach-imx/mx31lilly-db.c                |   11 +-
>  arch/arm/mach-imx/mx31lite-db.c                 |    5 +-
>  arch/arm/mach-imx/mx51_efika.c                  |    3 +-
>  arch/arm/mach-imx/pcm970-baseboard.c            |   13 +-
>  arch/arm/mach-rpc/include/mach/irqs.h           |   12 +-
>  arch/arm/plat-mxc/3ds_debugboard.c              |   50 +++---
>  arch/arm/plat-mxc/avic.c                        |   26 ++-
>  arch/arm/plat-mxc/devices/platform-ipu-core.c   |    5 +-
>  arch/arm/plat-mxc/include/mach/3ds_debugboard.h |    2 +-
>  arch/arm/plat-mxc/include/mach/devices-common.h |    4 +-
>  arch/arm/plat-mxc/include/mach/hardware.h       |    2 -
>  arch/arm/plat-mxc/include/mach/iomux-mx3.h      |    3 -
>  arch/arm/plat-mxc/include/mach/iomux-v1.h       |    7 -
>  arch/arm/plat-mxc/include/mach/ipu.h            |    4 -
>  arch/arm/plat-mxc/include/mach/irqs.h           |   44 -----
>  arch/arm/plat-mxc/include/mach/mx1.h            |  111 ++++++------
>  arch/arm/plat-mxc/include/mach/mx21.h           |  107 ++++++------
>  arch/arm/plat-mxc/include/mach/mx25.h           |   72 ++++----
>  arch/arm/plat-mxc/include/mach/mx27.h           |  127 +++++++-------
>  arch/arm/plat-mxc/include/mach/mx2x.h           |   87 +++++-----
>  arch/arm/plat-mxc/include/mach/mx31.h           |  118 +++++++------
>  arch/arm/plat-mxc/include/mach/mx35.h           |  109 ++++++------
>  arch/arm/plat-mxc/include/mach/mx3x.h           |   77 ++++----
>  arch/arm/plat-mxc/include/mach/mx50.h           |  187 ++++++++++----------
>  arch/arm/plat-mxc/include/mach/mx51.h           |  209 +++++++++++-----------
>  arch/arm/plat-mxc/include/mach/mx53.h           |  217 ++++++++++++-----------
>  arch/arm/plat-mxc/tzic.c                        |   28 ++-
>  drivers/dma/ipu/ipu_idmac.c                     |    8 +-
>  drivers/dma/ipu/ipu_irq.c                       |   14 +-
>  drivers/gpio/gpio-mxc.c                         |   56 ++++---
>  drivers/i2c/busses/i2c-imx.c                    |    1 -
>  drivers/media/video/mx1_camera.c                |    1 +
>  drivers/tty/serial/imx.c                        |    6 +-
>  sound/soc/fsl/imx-pcm-fiq.c                     |    1 +
>  76 files changed, 1041 insertions(+), 1127 deletions(-)
> 
> -- 
> 1.7.5.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
