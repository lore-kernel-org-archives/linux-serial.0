Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844421E47B3;
	Fri,  6 Jun 2025 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749199149; cv=none; b=WFQFQr7IdijdQj6/GUC1KUdEtUIbvJEGH07Mtj36PzgyheskFu/ynsoYWbmMHjKccaeAhxFrNef/kvxED4EEkTjWSjVeLnZh7JjPSAffw8KiDslyNl4H+jbCnITmBUHdiTUx2lhh5onAWX0h5JLf6MLLnC9lSdPHu1gxHDRQ6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749199149; c=relaxed/simple;
	bh=L8i9F2CQBlUJYI7gLW6qhQGKoWZwPQYsYKDVaSpLmKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lRloawuLPiJAvai4i2bqet3QJS8NHtpOonZ5tp4Ov9rR6RR0WFthfjJHtPPkuZsKhB2wZdSbU0TBcOR7mg/7+ogvcoFw9p/otj+xLgDaNJCRc1GGsUry/RQ/n3r/OZhcA+lGYp0JDnU8UZwjIagjZ4JdzBIWUU9N3Bzf18eYKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SI2+wc3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SI2+wc3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9486EC4CEEB;
	Fri,  6 Jun 2025 08:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749199148;
	bh=L8i9F2CQBlUJYI7gLW6qhQGKoWZwPQYsYKDVaSpLmKA=;
	h=Date:From:To:Cc:Subject:From;
	b=SI2+wc3rbH3P4uLF2SAV+UJtWWpRKM+8PRNi6EMfifOP26GjiBKKRfXy5ZVzx+WQ3
	 IWvNjsOJ7sYrMBMdk7Valzvo22VVjPNNr4Sd8zIwgUtx7pH66vdmMxE7cmGNXNNrMh
	 ctGa+b1RvCBig7GXwrsojd9qheQbiJvrYP5/bvWs=
Date: Fri, 6 Jun 2025 10:39:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver changes for 6.16-rc1
Message-ID: <aEKpKk71YuLPPMZC@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc1

for you to fetch changes up to b495021a973e2468497689bd3e29b736747b896f:

  tty: serial: 8250_omap: fix TX with DMA for am33xx (2025-05-22 07:50:45 +0200)

----------------------------------------------------------------
TTY/Serial changes for 6.16-rc1

Here is the big set of tty and serial driver changes for 6.16-rc1.
A little more churn than normal in this portion of the kernel for this
development cycle, Jiri and Nicholas were busy with cleanups and reviews
and fixes for the vt unicode handling logic which composed most of the
overall work in here.

Major changes are:
  - vt unicode changes/reverts/changes from Nicholas.  This should help
    out a lot with screen readers and others that rely on vt console
    support
  - lock guard additions to the core tty/serial code to clean up lots of
    error handling logic
  - 8250 driver updates and fixes
  - device tree conversions to yaml
  - sh-sci driver updates
  - other small cleanups and updates for serial drivers and tty core
    portions

All of these have been in linux-next for 2 weeks with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alex Elder (3):
      dt-bindings: serial: 8250: support an optional second clock
      serial: 8250_of: add support for an optional bus clock
      serial: 8250_of: manage bus clock in suspend/resume

Alexey Gladkov (2):
      tty/vt: Use KVAL instead of use bit operation
      tty/vt: Gather the code that outputs char with utf8 in mind

Andy Shevchenko (7):
      serial: 8250_ni: Switch to use uart_read_port_properties()
      serial: 8250_ni: Remove duplicate mapping
      serial: 8250_ni: Switch to use platform_get_mem_or_io()
      serial: 8250_ni: Remove unneeded conditionals
      serial: 8250_ni: use serial_port_in()/serial_port_out() helpers
      serial: 8250_ni: Switch to use dev_err_probe()
      serial: 8250_ni: Tidy up ACPI ID table

AngeloGioacchino Del Regno (1):
      dt-bindings: serial: mediatek,uart: Add compatible for MT6893

Bartosz Golaszewski (3):
      serial: max310x: use new GPIO line value setter callbacks
      serial: sc16is7xx: use new GPIO line value setter callbacks
      vt: add new dynamically generated files to .gitignore

Chen Ni (2):
      serial: lantiq: Remove unnecessary print function dev_err()
      serial: tegra-utc: Remove unneeded semicolon

Dharma Balasubiramani (1):
      dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart

Dustin Lundquist (1):
      serial: jsm: fix NPE during jsm_uart_port_init

Faraz Ata (1):
      tty: serial: samsung_tty: support 18 uart ports

Geert Uytterhoeven (1):
      dt-bindings: serial: snps-dw-apb-uart: Simplify DMA-less RZ/N1 rule

Greg Kroah-Hartman (14):
      Revert "vt: fix comment vs definition mismatch"
      Revert "vt: remove zero-white-space handling from conv_uni_to_pc()"
      Revert "vt: pad double-width code points with a zero-white-space"
      Revert "vt: update ucs_width.c following latest gen_ucs_width.py"
      Revert "vt: update gen_ucs_width.py to produce more space efficient tables"
      Revert "vt: support Unicode recomposition"
      Revert "vt: create ucs_recompose.c using gen_ucs_recompose.py"
      Revert "vt: introduce gen_ucs_recompose.py to create ucs_recompose.c"
      Revert "vt: update ucs_width.c using gen_ucs_width.py"
      Revert "vt: introduce gen_ucs_width.py to create ucs_width.c"
      Revert "vt: properly support zero-width Unicode code points"
      Revert "vt: move unicode processing to a separate file"
      Revert "vt: minor cleanup to vc_translate_unicode()"
      Merge 6.15-rc4 into tty-next

Henry Martin (1):
      serial: Fix potential null-ptr-deref in mlb_usio_probe()

Jakub Lewalski (1):
      tty: serial: uartlite: register uart driver in init

Jiri Slaby (SUSE) (7):
      tty: simplify throttling using guard()s
      tty: use lock guard()s in tty_io
      serial: switch uart_port::iotype to enum uart_iotype
      serial: rename local uart_port_lock() -> uart_port_ref_lock()
      serial: use uart_port_ref_lock() helper
      serial: 8250: unexport serial8250_rpm_*() functions
      tty: serial: 8250_omap: fix TX with DMA for am33xx

Krzysztof Kozlowski (1):
      dt-bindings: serial: 8250_omap: Drop redundant properties

Kuan-Wei Chiu (1):
      serial: max3100: Replace open-coded parity calculation with parity8()

Nicolas Pitre (38):
      vt: minor cleanup to vc_translate_unicode()
      vt: move unicode processing to a separate file
      vt: properly support zero-width Unicode code points
      vt: introduce gen_ucs_width.py to create ucs_width.c
      vt: update ucs_width.c using gen_ucs_width.py
      vt: introduce gen_ucs_recompose.py to create ucs_recompose.c
      vt: create ucs_recompose.c using gen_ucs_recompose.py
      vt: support Unicode recomposition
      vt: update gen_ucs_width.py to produce more space efficient tables
      vt: update ucs_width.c following latest gen_ucs_width.py
      vt: pad double-width code points with a zero-white-space
      vt: remove zero-white-space handling from conv_uni_to_pc()
      vt: fix comment vs definition mismatch
      vt: minor cleanup to vc_translate_unicode()
      vt: move unicode processing to a separate file
      vt: properly support zero-width Unicode code points
      vt: introduce gen_ucs_width_table.py to create ucs_width_table.h
      vt: create ucs_width_table.h with gen_ucs_width_table.py
      vt: use new tables in ucs.c
      vt: introduce gen_ucs_recompose_table.py to create ucs_recompose_table.h
      vt: create ucs_recompose_table.h with gen_ucs_recompose_table.py
      vt: support Unicode recomposition
      vt: pad double-width code points with a zero-width space
      vt: remove zero-width-space handling from conv_uni_to_pc()
      vt: update gen_ucs_width_table.py to make tables more space efficient
      vt: refresh ucs_width_table.h and adjust code in ucs.c accordingly
      vt: move UCS tables to the "shipped" form
      vt: ucs.c: fix misappropriate in_range() usage
      vt: make sure displayed double-width characters are remembered as such
      vt: move glyph determination to a separate function
      vt: introduce gen_ucs_fallback_table.py to create ucs_fallback_table.h
      vt: create ucs_fallback_table.h_shipped with gen_ucs_fallback_table.py
      vt: add ucs_get_fallback()
      vt: make use of ucs_get_fallback() when glyph is unavailable
      vt: process the full-width ASCII fallback range programmatically
      vt: remove VT_RESIZE and VT_RESIZEX from vt_compat_ioctl()
      vt: bracketed paste support
      vt: add VT_GETCONSIZECSRPOS to retrieve console size and cursor position

Philipp Stanner (1):
      mxser: Use non-hybrid PCI devres API

Rengarajan S (1):
      8250: microchip: pci1xxxx: Add PCIe Hot reset disable support for Rev C0 and later devices

Rob Herring (Arm) (10):
      dt-bindings: serial: Convert cnxt,cx92755-usart to DT schema
      dt-bindings: serial: Convert nxp,lpc3220-hsuart to DT schema
      dt-bindings: serial: Convert arm,mps2-uart to DT schema
      dt-bindings: serial: Convert cirrus,ep7209-uart to DT schema
      dt-bindings: serial: Convert lantiq,asc to DT schema
      dt-bindings: serial: Convert marvell,armada-3700-uart to DT schema
      dt-bindings: serial: Convert snps,arc-uart to DT schema
      dt-bindings: serial: Convert arm,sbsa-uart to DT schema
      dt-bindings: serial: Convert microchip,pic32mzda-uart to DT schema
      dt-bindings: serial: Convert socionext,milbeaut-usio-uart to DT schema

Ryo Takakura (1):
      serial: sifive: Switch to nbcon console

Thierry Bultel (4):
      dt-bindings: serial: Add compatible for Renesas RZ/T2H SoC in sci
      serial: sh-sci: Fix a comment about SCIFA
      serial: sh-sci: Introduced function pointers
      serial: sh-sci: Introduced sci_of_data

Viken Dadhaniya (1):
      serial: qcom-geni: Remove alias dependency from qcom serial driver

Xianwei Zhao (1):
      dt-bindings: serial: amlogic,meson-uart: Add compatible string for S6/S7/S7D

Zijun Hu (2):
      tty: Remove unused API tty_port_register_device_serdev()
      serdev: Refine several error or debug messages

 Documentation/devicetree/bindings/serial/8250.yaml |   30 +-
 .../devicetree/bindings/serial/8250_omap.yaml      |    7 -
 .../bindings/serial/amlogic,meson-uart.yaml        |    3 +
 .../devicetree/bindings/serial/arc-uart.txt        |   25 -
 .../devicetree/bindings/serial/arm,mps2-uart.txt   |   19 -
 .../devicetree/bindings/serial/arm,mps2-uart.yaml  |   46 +
 .../devicetree/bindings/serial/arm,sbsa-uart.yaml  |   38 +
 .../devicetree/bindings/serial/arm_sbsa_uart.txt   |   10 -
 .../bindings/serial/atmel,at91-usart.yaml          |    1 +
 .../bindings/serial/cirrus,clps711x-uart.txt       |   31 -
 .../bindings/serial/cirrus,ep7209-uart.yaml        |   56 +
 .../bindings/serial/cnxt,cx92755-usart.yaml        |   48 +
 .../devicetree/bindings/serial/digicolor-usart.txt |   27 -
 .../devicetree/bindings/serial/lantiq,asc.yaml     |   56 +
 .../devicetree/bindings/serial/lantiq_asc.txt      |   31 -
 .../bindings/serial/marvell,armada-3700-uart.yaml  |  102 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |    1 +
 .../bindings/serial/microchip,pic32-uart.txt       |   29 -
 .../bindings/serial/microchip,pic32mzda-uart.yaml  |   53 +
 .../devicetree/bindings/serial/milbeaut-uart.txt   |   21 -
 .../devicetree/bindings/serial/mvebu-uart.txt      |   56 -
 .../bindings/serial/nxp,lpc3220-hsuart.yaml        |   39 +
 .../bindings/serial/nxp-lpc32xx-hsuart.txt         |   14 -
 .../devicetree/bindings/serial/renesas,rsci.yaml   |   78 +
 .../devicetree/bindings/serial/snps,arc-uart.yaml  |   51 +
 .../bindings/serial/snps-dw-apb-uart.yaml          |    4 +-
 .../serial/socionext,milbeaut-usio-uart.yaml       |   56 +
 MAINTAINERS                                        |    2 +-
 drivers/tty/mxser.c                                |    4 +-
 drivers/tty/serdev/core.c                          |    8 +-
 drivers/tty/serial/8250/8250.h                     |    6 -
 drivers/tty/serial/8250/8250_core.c                |    2 +-
 drivers/tty/serial/8250/8250_early.c               |    2 +
 drivers/tty/serial/8250/8250_ni.c                  |   89 +-
 drivers/tty/serial/8250/8250_of.c                  |   15 +-
 drivers/tty/serial/8250/8250_omap.c                |   25 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c            |   10 +
 drivers/tty/serial/8250/8250_port.c                |   16 +-
 drivers/tty/serial/8250/8250_rsa.c                 |    2 +
 drivers/tty/serial/8250/Kconfig                    |    2 +-
 drivers/tty/serial/amba-pl011.c                    |    2 +-
 drivers/tty/serial/fsl_lpuart.c                    |    5 +-
 drivers/tty/serial/jsm/jsm_tty.c                   |    1 +
 drivers/tty/serial/lantiq.c                        |    4 +-
 drivers/tty/serial/max3100.c                       |    3 +-
 drivers/tty/serial/max310x.c                       |    7 +-
 drivers/tty/serial/milbeaut_usio.c                 |    5 +-
 drivers/tty/serial/qcom_geni_serial.c              |   25 +-
 drivers/tty/serial/samsung_tty.c                   |    6 +-
 drivers/tty/serial/sc16is7xx.c                     |    7 +-
 drivers/tty/serial/serial_core.c                   |   95 +-
 drivers/tty/serial/sh-sci-common.h                 |  167 +
 drivers/tty/serial/sh-sci.c                        |  630 ++--
 drivers/tty/serial/sh-sci.h                        |    2 -
 drivers/tty/serial/sifive.c                        |   88 +-
 drivers/tty/serial/tegra-utc.c                     |    2 +-
 drivers/tty/serial/uartlite.c                      |   25 +-
 drivers/tty/tty_io.c                               |   96 +-
 drivers/tty/tty_ioctl.c                            |   48 +-
 drivers/tty/tty_port.c                             |   20 -
 drivers/tty/vt/.gitignore                          |    3 +
 drivers/tty/vt/Makefile                            |   34 +-
 drivers/tty/vt/consolemap.c                        |    2 -
 drivers/tty/vt/gen_ucs_fallback_table.py           |  360 +++
 drivers/tty/vt/gen_ucs_recompose_table.py          |  257 ++
 drivers/tty/vt/gen_ucs_width_table.py              |  307 ++
 drivers/tty/vt/keyboard.c                          |   37 +-
 drivers/tty/vt/selection.c                         |   31 +-
 drivers/tty/vt/ucs.c                               |  251 ++
 drivers/tty/vt/ucs_fallback_table.h_shipped        | 3346 ++++++++++++++++++++
 drivers/tty/vt/ucs_recompose_table.h_shipped       |  102 +
 drivers/tty/vt/ucs_width_table.h_shipped           |  453 +++
 drivers/tty/vt/vt.c                                |  242 +-
 drivers/tty/vt/vt_ioctl.c                          |   18 +-
 include/linux/console_struct.h                     |    1 +
 include/linux/consolemap.h                         |   24 +
 include/linux/serial_core.h                        |   30 +-
 include/linux/tty_port.h                           |    3 -
 include/uapi/linux/tiocl.h                         |    1 +
 include/uapi/linux/vt.h                            |   11 +
 80 files changed, 6909 insertions(+), 957 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/arc-uart.txt
 delete mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
 delete mode 100644 Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/cirrus,ep7209-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/cnxt,cx92755-usart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/digicolor-usart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/lantiq,asc.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32mzda-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
 delete mode 100644 Documentation/devicetree/bindings/serial/mvebu-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc3220-hsuart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/nxp-lpc32xx-hsuart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,rsci.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/snps,arc-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/socionext,milbeaut-usio-uart.yaml
 create mode 100644 drivers/tty/serial/sh-sci-common.h
 create mode 100755 drivers/tty/vt/gen_ucs_fallback_table.py
 create mode 100755 drivers/tty/vt/gen_ucs_recompose_table.py
 create mode 100755 drivers/tty/vt/gen_ucs_width_table.py
 create mode 100644 drivers/tty/vt/ucs.c
 create mode 100644 drivers/tty/vt/ucs_fallback_table.h_shipped
 create mode 100644 drivers/tty/vt/ucs_recompose_table.h_shipped
 create mode 100644 drivers/tty/vt/ucs_width_table.h_shipped
