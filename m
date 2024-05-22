Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7518B14;
	Wed, 22 May 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389415; cv=none; b=MrPXrwmqbAlC4vJIm1/MfZx/uTWjULhQFGwm89VdqGwFTcUIZJ4JO+vzJF4LWd4f1d0qRdb/C3q6m05RJcpFhpgY8it2xixozlLGwx3QK/OJkJZvJAS0BZ7ZZoXDIWE6valmPDyNhzQauveqJ/CMan4A/U+tVJV9PeMs8g1iacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389415; c=relaxed/simple;
	bh=lcyK8YlB3+agK2qtzyDEv5gpptgn6odTr7rOTaYt68I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p5CvN0YRbEG9av2xidDtBdDlSHs6BAdHUNpFgcfEkR5R0SgKee4IXA+GVK9j/OWQRaczuImtENnBP9TWs+aXThgrg1KciNXcJ8QP8yp+zySfNdK/28tv2Zxfhs+/xpO/qu3YcIAER7KCydAtm0On5OVmaWusy7L4ahqBtDGJb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKoDNOqZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKoDNOqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFABC32782;
	Wed, 22 May 2024 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716389415;
	bh=lcyK8YlB3+agK2qtzyDEv5gpptgn6odTr7rOTaYt68I=;
	h=Date:From:To:Cc:Subject:From;
	b=qKoDNOqZqVzZUqAws9ieH/HbJCF8bW5NQu0k/8hAee6Ok48ZERzYjlt7BlUN4wm9D
	 9h4JIMXnitlhTTVD4cSlnT1PCKbWTv9LUVBPfzbsxYyWDchmZikVuD/KSkaUjfxYh0
	 EAjWLRV98bpwJJqnPLWU/87Tc7JX/VwEtzMxM8LY=
Date: Wed, 22 May 2024 16:50:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 6.10-rc1
Message-ID: <Zk4GJDYPNVCsz7AE@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc1

for you to fetch changes up to e21de1455a721a0cb4217b18589ede846f5b0686:

  serial: Clear UPF_DEAD before calling tty_port_register_device_attr_serdev() (2024-05-10 11:49:23 +0100)

----------------------------------------------------------------
TTY/Serial changes for 6.10-rc1

Here is the big set of tty/serial driver changes for 6.10-rc1.  Included
in here are:
  - Usual good set of api cleanups and evolution by Jiri Slaby to make
    the serial interfaces move out of the 1990's by using kfifos instead
    of hand-rolling their own logic.
  - 8250_exar driver updates
  - max3100 driver updates
  - sc16is7xx driver updates
  - exar driver updates
  - sh-sci driver updates
  - tty ldisc api addition to help refuse bindings
  - other smaller serial driver updates

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Stein (1):
      tty: serial: fsl_lpuart: use dev_err_probe for clocks

Alexey Gladkov (1):
      VT: Use macros to define ioctls

Andy Shevchenko (36):
      serial: 8250_omap: Remove unused of_gpio.h
      serial: pic32_uart: Replace of_gpio.h by proper one
      serial: max3100: Lock port->lock when calling uart_handle_cts_change()
      serial: max3100: Update uart_driver_registered on driver removal
      serial: max3100: Fix bitwise types
      serial: max3100: Make struct plat_max3100 local
      serial: max3100: Remove custom HW shutdown support
      serial: max3100: Replace custom polling timeout with standard one
      serial: max3100: Remove unneeded forward declaration
      serial: max3100: Update Kconfig entry
      serial: max3100: Enable TIOCM_LOOP
      serial: max3100: Get crystal frequency via device property
      serial: max3100: Remove duplicating irq field
      serial: max3100: Switch to use dev_err_probe()
      serial: max3100: Replace MODULE_ALIAS() with respective ID tables
      serial: max3100: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
      serial: max3100: Extract to_max3100_port() helper macro
      serial: max3100: Sort headers
      serial: max3100: Convert to_max3100_port() to be static inline
      serial: core: Extract uart_alloc_xmit_buf() and uart_free_xmit_buf()
      serial: 8250_dw: Deduplicate LCR checks
      serial: 8250_dw: Hide a cast in dw8250_serial_inq()
      serial: 8250_exar: Don't return positive values as error codes
      serial: 8250_exar: Describe all parameters in kernel doc
      serial: 8250_exar: Kill CTI_PCI_DEVICE()
      serial: 8250_exar: Use PCI_SUBVENDOR_ID_IBM for subvendor ID
      serial: 8250_exar: Trivia typo fixes
      serial: 8250_exar: Extract cti_board_init_osc_freq() helper
      serial: 8250_exar: Kill unneeded ->board_init()
      serial: 8250_exar: Decrease indentation level
      serial: 8250_exar: Return directly from switch-cases
      serial: 8250_exar: Switch to use dev_err_probe()
      serial: 8250_exar: Use BIT() in exar_ee_read()
      serial: 8250_exar: Make type of bit the same in exar_ee_*_bit()
      serial: 8250_exar: Keep the includes sorted
      serial: 8250_pnp: Switch to DEFINE_SIMPLE_DEV_PM_OPS()

Bastien Curutchet (1):
      serial: 8250_of: Add clock_notifier

Claudiu Beznea (1):
      serial: core: Call device_set_awake_path() for console port

Colin Ian King (2):
      tty: hvc: Remove second semicolon
      serial: omap: remove redundant assignment to variable tmout

Esben Haabendal (1):
      serial: imx: Introduce timeout when waiting on transmitter empty

Greg Kroah-Hartman (1):
      Merge 6.9-rc5 into tty-next

Guanbing Huang (3):
      PNP: Add dev_is_pnp() macro
      serial: port: Add support of PNP IRQ to __uart_read_properties()
      serial: 8250_pnp: Support configurable reg shift property

Hans de Goede (1):
      serial: Clear UPF_DEAD before calling tty_port_register_device_attr_serdev()

Hugo Villeneuve (5):
      serial: sc16is7xx: add proper sched.h include for sched_set_fifo()
      serial: sc16is7xx: unconditionally clear line bit in sc16is7xx_remove()
      serial: sc16is7xx: split into core and I2C/SPI parts (core)
      serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_lines)
      serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_regcfg)

Ilpo Järvinen (1):
      serial: 8250_pnp: Simplify "line" related code

Jiri Slaby (SUSE) (18):
      kfifo: drop __kfifo_dma_out_finish_r()
      kfifo: introduce and use kfifo_skip_count()
      kfifo: add kfifo_out_linear{,_ptr}()
      kfifo: remove support for physically non-contiguous memory
      kfifo: rename l to len_to_end in setup_sgl()
      kfifo: pass offset to setup_sgl_buf() instead of a pointer
      kfifo: add kfifo_dma_out_prepare_mapped()
      kfifo: fix typos in kernel-doc
      tty: 8250_dma: use dmaengine_prep_slave_sg()
      tty: 8250_omap: use dmaengine_prep_slave_sg()
      tty: msm_serial: use dmaengine_prep_slave_sg()
      tty: serial: switch from circ_buf to kfifo
      tty: atmel_serial: use single DMA mapping for TX
      tty: atmel_serial: define macro for RX size
      tty: atmel_serial: use single DMA mapping for RX
      serial: meson+qcom: don't advance the kfifo twice
      serial: drop debugging WARN_ON_ONCE() from uart_put_char()
      serial: msm: check dma_map_sg() return value properly

Justin Stitt (1):
      tty: n_gsm: replace deprecated strncpy with strscpy

Kanak Shilledar (1):
      dt-bindings: serial: actions,owl-uart: convert to dtschema

Lino Sanfilippo (4):
      serial: amba-pl011: get rid of useless wrapper pl011_get_rs485_mode()
      serial: amba-pl011: move variable into CONFIG_DMA_ENGINE conditional
      serial: 8250: Remove superfluous sanity check
      serial: ar933x: Remove unneeded static structure

Linus Torvalds (1):
      tty: add the option to have a tty reject a new ldisc

Manikanta Guntupalli (3):
      dt-bindings: serial: cdns,uart: Add optional reset property
      arm64: zynqmp: Add resets property for UART nodes
      tty: serial: uartps: Add support for uartps controller reset

Matthias Schiffer (1):
      serial: imx: Raise TX trigger level to 8

Nghia Nguyen (1):
      dt-bindings: serial: renesas,scif: Document r8a779h0 bindings

Parker Newman (8):
      serial: exar: adding missing CTI and Exar PCI ids
      serial: exar: remove old Connect Tech setup
      serial: exar: added a exar_get_nr_ports function
      serial: exar: add optional board_init function
      serial: exar: moved generic_rs485 further up in 8250_exar.c
      serial: exar: add CTI cards to exar_get_nr_ports
      serial: exar: add CTI specific setup code
      serial: exar: fix checkpach warnings

Pratik Farkase (1):
      dt-bindings: serial: brcm,bcm2835-aux-uart: convert to dtschema

Sebastian Andrzej Siewior (1):
      serial: sifive: Remove 0 from fu540-c000-uart0 binding.

Sreenath Vijayan (2):
      printk: Add function to replay kernel log on consoles
      tty/sysrq: Replay kernel log messages on consoles via sysrq

Tony Lindgren (9):
      printk: Save console options for add_preferred_console_match()
      printk: Don't try to parse DEVNAME:0.0 console options
      printk: Flag register_console() if console is set on command line
      serial: core: Add support for DEVNAME:0.0 style naming for kernel console
      serial: core: Handle serial console options
      serial: 8250: Add preferred console in serial8250_isa_init_ports()
      Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial ports
      serial: 8250: Fix add preferred console for serial8250_isa_init_ports()
      serial: core: Fix ifdef for serial base console functions

Uwe Kleine-König (3):
      tty: vt: conmakehash: Don't mention the full path of the input in output
      serial: ami: Mark driver struct with __refdata to prevent section mismatch
      serial: pmac_zilog: Drop usage of platform_driver_probe()

Wolfram Sang (4):
      serial: sh-sci: protect invalidating RXDMA on shutdown
      serial: sh-sci: describe locking requirements for invalidating RXDMA
      serial: sh-sci: let timeout timer only run when DMA is scheduled
      serial: sh-sci: simplify locking when re-issuing RXDMA fails

wangkaiyuan (2):
      tty: serial: max310x: convert to use maple tree register cache
      tty: serial: sc16is7xx: convert to use maple tree register cache

 Documentation/admin-guide/kernel-parameters.txt    |   19 +
 Documentation/admin-guide/sysrq.rst                |    9 +
 .../bindings/serial/actions,owl-uart.txt           |   16 -
 .../bindings/serial/actions,owl-uart.yaml          |   48 +
 .../bindings/serial/brcm,bcm2835-aux-uart.txt      |   18 -
 .../bindings/serial/brcm,bcm2835-aux-uart.yaml     |   46 +
 .../devicetree/bindings/serial/cdns,uart.yaml      |    3 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |    1 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |    2 +
 drivers/tty/amiserial.c                            |    8 +-
 drivers/tty/hvc/hvc_xen.c                          |    2 +-
 drivers/tty/n_gsm.c                                |    2 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |   14 +-
 drivers/tty/serial/8250/8250_core.c                |    8 +-
 drivers/tty/serial/8250/8250_dma.c                 |   31 +-
 drivers/tty/serial/8250/8250_dw.c                  |   45 +-
 drivers/tty/serial/8250/8250_exar.c                | 1059 ++++++++++++++++++--
 drivers/tty/serial/8250/8250_mtk.c                 |    2 +-
 drivers/tty/serial/8250/8250_of.c                  |   37 +
 drivers/tty/serial/8250/8250_omap.c                |   49 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c            |   50 +-
 drivers/tty/serial/8250/8250_pnp.c                 |   65 +-
 drivers/tty/serial/8250/8250_port.c                |   29 +-
 drivers/tty/serial/Kconfig                         |   54 +-
 drivers/tty/serial/Makefile                        |    2 +
 drivers/tty/serial/amba-pl011.c                    |   62 +-
 drivers/tty/serial/ar933x_uart.c                   |   18 +-
 drivers/tty/serial/arc_uart.c                      |    8 +-
 drivers/tty/serial/atmel_serial.c                  |  146 ++-
 drivers/tty/serial/clps711x.c                      |   12 +-
 drivers/tty/serial/cpm_uart.c                      |   20 +-
 drivers/tty/serial/digicolor-usart.c               |   12 +-
 drivers/tty/serial/dz.c                            |   13 +-
 drivers/tty/serial/fsl_linflexuart.c               |   17 +-
 drivers/tty/serial/fsl_lpuart.c                    |   45 +-
 drivers/tty/serial/icom.c                          |   25 +-
 drivers/tty/serial/imx.c                           |   63 +-
 drivers/tty/serial/ip22zilog.c                     |   26 +-
 drivers/tty/serial/jsm/jsm_cls.c                   |   31 +-
 drivers/tty/serial/jsm/jsm_neo.c                   |   38 +-
 drivers/tty/serial/max3100.c                       |  340 +++----
 drivers/tty/serial/max310x.c                       |   37 +-
 drivers/tty/serial/men_z135_uart.c                 |   26 +-
 drivers/tty/serial/meson_uart.c                    |   12 +-
 drivers/tty/serial/milbeaut_usio.c                 |   15 +-
 drivers/tty/serial/msm_serial.c                    |  122 ++-
 drivers/tty/serial/mvebu-uart.c                    |    8 +-
 drivers/tty/serial/mxs-auart.c                     |   23 +-
 drivers/tty/serial/omap-serial.c                   |    1 -
 drivers/tty/serial/pch_uart.c                      |   21 +-
 drivers/tty/serial/pic32_uart.c                    |   17 +-
 drivers/tty/serial/pmac_zilog.c                    |   33 +-
 drivers/tty/serial/qcom_geni_serial.c              |   34 +-
 drivers/tty/serial/rda-uart.c                      |   17 +-
 drivers/tty/serial/samsung_tty.c                   |   54 +-
 drivers/tty/serial/sb1250-duart.c                  |   13 +-
 drivers/tty/serial/sc16is7xx.c                     |  303 ++----
 drivers/tty/serial/sc16is7xx.h                     |   41 +
 drivers/tty/serial/sc16is7xx_i2c.c                 |   67 ++
 drivers/tty/serial/sc16is7xx_spi.c                 |   90 ++
 drivers/tty/serial/sccnxp.c                        |   16 +-
 drivers/tty/serial/serial-tegra.c                  |   43 +-
 drivers/tty/serial/serial_base.h                   |   30 +
 drivers/tty/serial/serial_base_bus.c               |  129 +++
 drivers/tty/serial/serial_core.c                   |  154 +--
 drivers/tty/serial/serial_port.c                   |    9 +-
 drivers/tty/serial/sh-sci.c                        |   68 +-
 drivers/tty/serial/sifive.c                        |    4 +-
 drivers/tty/serial/sprd_serial.c                   |   20 +-
 drivers/tty/serial/st-asc.c                        |    4 +-
 drivers/tty/serial/stm32-usart.c                   |   52 +-
 drivers/tty/serial/sunhv.c                         |   35 +-
 drivers/tty/serial/sunplus-uart.c                  |   16 +-
 drivers/tty/serial/sunsab.c                        |   30 +-
 drivers/tty/serial/sunsu.c                         |   15 +-
 drivers/tty/serial/sunzilog.c                      |   27 +-
 drivers/tty/serial/tegra-tcu.c                     |   10 +-
 drivers/tty/serial/timbuart.c                      |   17 +-
 drivers/tty/serial/uartlite.c                      |   13 +-
 drivers/tty/serial/ucc_uart.c                      |   20 +-
 drivers/tty/serial/xilinx_uartps.c                 |   35 +-
 drivers/tty/serial/zs.c                            |   13 +-
 drivers/tty/sysrq.c                                |   13 +-
 drivers/tty/tty_ldisc.c                            |    6 +
 drivers/tty/vt/conmakehash.c                       |   15 +-
 drivers/tty/vt/vt.c                                |   10 +
 include/linux/kfifo.h                              |  143 ++-
 include/linux/pnp.h                                |    4 +
 include/linux/printk.h                             |    7 +
 include/linux/serial_core.h                        |   49 +-
 include/linux/serial_max3100.h                     |   48 -
 include/linux/tty_driver.h                         |    8 +
 include/uapi/linux/kd.h                            |   96 +-
 kernel/printk/Makefile                             |    2 +-
 kernel/printk/conopt.c                             |  146 +++
 kernel/printk/console_cmdline.h                    |    6 +
 kernel/printk/printk.c                             |  100 +-
 lib/kfifo.c                                        |  107 +-
 98 files changed, 3141 insertions(+), 1808 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.yaml
 create mode 100644 drivers/tty/serial/sc16is7xx.h
 create mode 100644 drivers/tty/serial/sc16is7xx_i2c.c
 create mode 100644 drivers/tty/serial/sc16is7xx_spi.c
 delete mode 100644 include/linux/serial_max3100.h
 create mode 100644 kernel/printk/conopt.c
