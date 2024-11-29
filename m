Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0B2914;
	Fri, 29 Nov 2024 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854414; cv=none; b=VxHTF8PDTbXOG/E7tjgLPl2uWlCql4c6oE3+B9JoHuTqAT5ArzTI7jI1FUM3GybXew0vfnKVdH2KDjVs2OZ1wcPUOpWUVMxnpuZ0vVoh9Y2K1d25mezG+S6ammKaORg+EC3F9CjNzgsFK+1rLOKo+PjbuRWLLGEZyZN/0SJvu9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854414; c=relaxed/simple;
	bh=bviNBKgkJYePutF4Hc011Wxh+UECjeCdWR26Fs+vGWs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S83RW9xXxtsbJeI7YCeLzj6HCIFOCIh9l5GNPWSp/8bRJCvwKwT76STs9vdJbyB6rkgjuZpvhPX031NoqfYXoIybmRo0/3gXwCw86W3cgjtM2WYrXAON1ihPaSqjQ060XiTWgxmEk+wcuU6CBPg2khZhksAP6HrTMuuoksJELlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fzMzxtSG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fzMzxtSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1097C4CECF;
	Fri, 29 Nov 2024 04:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732854414;
	bh=bviNBKgkJYePutF4Hc011Wxh+UECjeCdWR26Fs+vGWs=;
	h=Date:From:To:Cc:Subject:From;
	b=fzMzxtSGsZih8v+8QUWowPT3PMwGmBPoQjW8Q47xG5w/m5eY8h+DfRuMA8YHfAUQs
	 Poi4sohu1474UAy2hhzJn226jCiWRWY/ulPPmI3WoW9GTeY9smET0HY5sCc9dPjWsS
	 qFZXtq4ahh+Y/LD3VHIWMr1SuRWRKMxpcrNemSMc=
Date: Fri, 29 Nov 2024 05:26:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
Message-ID: <Z0lCihhE75lE9Zjd@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc1

for you to fetch changes up to b5a23a60e8ab5711f4952912424347bf3864ce8d:

  serial: amba-pl011: fix build regression (2024-11-16 09:52:55 +0100)

----------------------------------------------------------------
TTY / Serial driver updates for 6.13-rc1

Here is a small set of tty and serial driver updates for 6.13-rc1.
Nothing major at all this time, only some small changes:
  - few device tree binding updates
  - 8250_exar serial driver updates
  - imx serial driver updates
  - sprd_serial driver updates
  - other tiny serial driver updates, full details in the shortlog

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250_exar: Group CTI EEPROM offsets by device

Arnd Bergmann (1):
      serial: amba-pl011: fix build regression

Bin Liu (1):
      serial: 8250: omap: Move pm_runtime_get_sync

Christoph Hellwig (1):
      kfifo: don't include dma-mapping.h in kfifo.h

Claudiu Beznea (1):
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit

Detlev Casanova (1):
      dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3576

Esben Haabendal (3):
      serial: imx: Grab port lock in imx_uart_enable_wakeup()
      serial: imx: Add more comments on port lock status
      serial: imx: Switch to nbcon console

Filip Brozovic (1):
      serial: 8250_fintek: Add support for F81216E

Greg Kroah-Hartman (1):
      Merge 6.12-rc4 into tty-next

Hugo Villeneuve (1):
      serial: sc16is7xx: announce support for SER_RS485_RTS_ON_SEND

Inochi Amaoto (3):
      dt-bindings: serial: snps,dw-apb-uart: merge duplicate compatible entry.
      dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2044 uarts
      serial: 8250_dw: Add Sophgo SG2044 quirk

Ivaylo Ivanov (2):
      dt-bindings: serial: samsung: Add samsung,exynos8895-uart compatible
      tty: serial: samsung: Add Exynos8895 compatible

Kartik Rajput (1):
      serial: amba-pl011: Fix RX stall when DMA is used

Luke Wang (1):
      tty: serial: fsl_lpuart: add 7-bits format support on imx7ulp/imx8ulp/imx8qxp

Michal Simek (1):
      dt-bindings: serial: rs485: Fix rs485-rts-delay property

Mihai Sain (1):
      tty: atmel_serial: Use devm_platform_ioremap_resource()

Nicolas Bouchinet (1):
      tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler

Parker Newman (4):
      misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle
      misc: eeprom: eeprom_93cx6: Switch to BIT() macro
      serial: 8250_exar: Replace custom EEPROM read with eeprom_93cx6
      serial: 8250_exar: Remove old exar_ee_read() and other unneeded code

Shivam Chaudhary (1):
      tty: atmel_serial: Fix typo retreives to retrieves

Tobias Klauser (4):
      altera_uart: Use dev_err() to report error attaching IRQ handler
      altera_jtaguart: Use dev_err() to report error attaching IRQ
      tty/serial/altera_jtaguart: unwrap error log string
      tty/serial/altera_uart: unwrap error log string

Uwe Kleine-König (1):
      serial: Switch back to struct platform_driver::remove()

Wenhua Lin (2):
      serial: sprd: Add support for sc9632
      dt-bindings: serial: Add a new compatible string for ums9632

Yanteng Si (1):
      serial: clean up uart_info

Yao Zi (1):
      dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528

Yu Jiaoliang (1):
      serial: 8250: Fix typos in comments across various files

 .../devicetree/bindings/serial/rs485.yaml          |  19 ++-
 .../devicetree/bindings/serial/samsung_uart.yaml   |  14 +-
 .../bindings/serial/snps-dw-apb-uart.yaml          |  13 +-
 .../devicetree/bindings/serial/sprd-uart.yaml      |   1 +
 drivers/mailbox/omap-mailbox.c                     |   1 +
 drivers/misc/eeprom/eeprom_93cx6.c                 |  15 ++-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   2 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |   2 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |   4 +-
 drivers/tty/serial/8250/8250_dw.c                  |   7 +-
 drivers/tty/serial/8250/8250_em.c                  |   2 +-
 drivers/tty/serial/8250/8250_exar.c                | 142 +++++++--------------
 drivers/tty/serial/8250/8250_fintek.c              |  16 ++-
 drivers/tty/serial/8250/8250_fsl.c                 |   2 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   2 +-
 drivers/tty/serial/8250/8250_ioc3.c                |   2 +-
 drivers/tty/serial/8250/8250_lpc18xx.c             |   2 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   6 +-
 drivers/tty/serial/8250/8250_of.c                  |   2 +-
 drivers/tty/serial/8250/8250_omap.c                |  10 +-
 drivers/tty/serial/8250/8250_platform.c            |   2 +-
 drivers/tty/serial/8250/8250_pxa.c                 |   2 +-
 drivers/tty/serial/8250/8250_tegra.c               |   2 +-
 drivers/tty/serial/8250/8250_uniphier.c            |   2 +-
 drivers/tty/serial/8250/Kconfig                    |   1 +
 drivers/tty/serial/altera_jtaguart.c               |   6 +-
 drivers/tty/serial/altera_uart.c                   |   6 +-
 drivers/tty/serial/amba-pl011.c                    |   9 +-
 drivers/tty/serial/ar933x_uart.c                   |   2 +-
 drivers/tty/serial/atmel_serial.c                  |  16 +--
 drivers/tty/serial/bcm63xx_uart.c                  |   2 +-
 drivers/tty/serial/clps711x.c                      |   2 +-
 drivers/tty/serial/cpm_uart.c                      |   2 +-
 drivers/tty/serial/digicolor-usart.c               |   2 +-
 drivers/tty/serial/esp32_acm.c                     |   2 +-
 drivers/tty/serial/esp32_uart.c                    |   2 +-
 drivers/tty/serial/fsl_linflexuart.c               |   2 +-
 drivers/tty/serial/fsl_lpuart.c                    |  23 +++-
 drivers/tty/serial/imx.c                           | 137 +++++++++++++++++---
 drivers/tty/serial/lantiq.c                        |   2 +-
 drivers/tty/serial/liteuart.c                      |   2 +-
 drivers/tty/serial/lpc32xx_hs.c                    |   2 +-
 drivers/tty/serial/ma35d1_serial.c                 |   2 +-
 drivers/tty/serial/mcf.c                           |   2 +-
 drivers/tty/serial/meson_uart.c                    |   2 +-
 drivers/tty/serial/milbeaut_usio.c                 |   2 +-
 drivers/tty/serial/mpc52xx_uart.c                  |   2 +-
 drivers/tty/serial/msm_serial.c                    |   2 +-
 drivers/tty/serial/mxs-auart.c                     |   2 +-
 drivers/tty/serial/omap-serial.c                   |   2 +-
 drivers/tty/serial/owl-uart.c                      |   2 +-
 drivers/tty/serial/pic32_uart.c                    |   2 +-
 drivers/tty/serial/pmac_zilog.c                    |   2 +-
 drivers/tty/serial/qcom_geni_serial.c              |   2 +-
 drivers/tty/serial/rda-uart.c                      |   2 +-
 drivers/tty/serial/sa1100.c                        |   2 +-
 drivers/tty/serial/samsung_tty.c                   |  15 ++-
 drivers/tty/serial/sc16is7xx.c                     |   2 +-
 drivers/tty/serial/sccnxp.c                        |   2 +-
 drivers/tty/serial/serial-tegra.c                  |   2 +-
 drivers/tty/serial/serial_txx9.c                   |   2 +-
 drivers/tty/serial/sh-sci.c                        |  30 ++++-
 drivers/tty/serial/sifive.c                        |   2 +-
 drivers/tty/serial/sprd_serial.c                   |  43 ++++++-
 drivers/tty/serial/st-asc.c                        |   2 +-
 drivers/tty/serial/stm32-usart.c                   |   2 +-
 drivers/tty/serial/sunhv.c                         |   2 +-
 drivers/tty/serial/sunplus-uart.c                  |   2 +-
 drivers/tty/serial/sunsab.c                        |   2 +-
 drivers/tty/serial/sunsu.c                         |   2 +-
 drivers/tty/serial/sunzilog.c                      |   2 +-
 drivers/tty/serial/tegra-tcu.c                     |   2 +-
 drivers/tty/serial/timbuart.c                      |   2 +-
 drivers/tty/serial/uartlite.c                      |   2 +-
 drivers/tty/serial/ucc_uart.c                      |   2 +-
 drivers/tty/serial/xilinx_uartps.c                 |   2 +-
 drivers/tty/tty_io.c                               |   2 +-
 include/linux/eeprom_93cx6.h                       |  11 ++
 include/linux/kfifo.h                              |   1 -
 include/linux/platform_data/sa11x0-serial.h        |   1 -
 samples/kfifo/dma-example.c                        |   1 +
 81 files changed, 413 insertions(+), 245 deletions(-)
