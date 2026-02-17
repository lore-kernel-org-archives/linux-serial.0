Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A628151C;
	Tue, 17 Feb 2026 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338584; cv=none; b=kBGRuKQuARiFpQPyonY9cztMIhYQhpJnNwws4Ihn+AetqlKdxwZeeAEaXC0h298VAV0U16t2XGQFGw8GId6YUgNjaXS5uh28vOt7qfUaj2WYdjqFEVPqf8sgv+kJ0B8fzoOZlxPS3gEfomOx7KtMzv3M8drVqMF9e7rI4No7KMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338584; c=relaxed/simple;
	bh=quQrCw8z5CLxvblNDdBLNr5zqN99RiLOinCRO+F1n+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NWElSaD6+Pxxb5Utb93f8YJUUwMRC5N8W+PadIdIAzYT/Wf08kjTHcchPHSAHKivuNf8tB0IMBg2/GWnBw3YF7MHBJgyyNXIabqbqQ4h9DqKoFt6QIlOdzo5T5M4MmRSL8Th8Gxi6QAc5T6W5RjoAV2IUIPvALeZBI2SiYO4jrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OBhQ6ft9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OBhQ6ft9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDECC4CEF7;
	Tue, 17 Feb 2026 14:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771338584;
	bh=quQrCw8z5CLxvblNDdBLNr5zqN99RiLOinCRO+F1n+w=;
	h=Date:From:To:Cc:Subject:From;
	b=OBhQ6ft9IbRhwZF2mm2vq8HPn7dY3JSiYZqfoGWMmqTTvzCsoAcEpdQ9zX7/VkKp8
	 eEjMSMwxno2CpJXMG+Se3ePp2Xpz9uHuRxo1s4ky5RWDa/7+z7un7D7z7E6q5Px2Id
	 len0rkrcDPu3KFWouzWjVNrGKsWdUMBvLgZwQH74=
Date: Tue, 17 Feb 2026 15:29:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 7.0-rc1
Message-ID: <aZR7VPj-GDiNMcX9@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da:

  Linux 6.19-rc3 (2025-12-28 13:24:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.0-rc1

for you to fetch changes up to 0a15f43b92ddaa2fdb476891a12ac2e207c7fcd2:

  Revert "tty: tty_port: add workqueue to flip TTY buffer" (2026-01-27 13:58:21 +0100)

----------------------------------------------------------------
TTY / Serial driver updates for 7.0-rc1

Here is the small amount of tty and serial driver updates for 7.0-rc1.
Nothing major in here at all, just some driver updates and minor tweaks
and cleanups including:
  - sh-sci serial driver updates
  - 8250 driver updates
  - attempt to make the tty ports have their own workqueue, but was
    reverted after testing found it to have problems on some platforms.
    This will probably come back for 7.1 after it has been reworked and
    resubmitted
  - other tiny tty driver changes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      serial: 8250_omap: Remove custom deprecated baud setting routine
      serial: 8250_pci: Remove custom deprecated baud setting routine

Artem Shimko (2):
      serial: 8250_dw: handle clock enable errors in runtime_resume
      serial: 8250_dw: fix runtime PM initialization sequence

Bartlomiej Kubik (1):
      tty/n_hdlc: Fix struct n_hdlc kernel-doc warnings

Biju Das (18):
      dt-bindings: serial: renesas,rsci: Document RZ/G3E support
      serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
      serial: rsci: Add set_rtrg() callback
      serial: sh-sci: Drop checking port type for device file{create, remove}
      serial: rsci: Drop rsci_clear_SCxSR()
      serial: sh-sci: Drop extra lines
      serial: rsci: Drop unused macro DCR
      serial: rsci: Drop unused TDR register
      serial: sh-sci: Use devm_reset_control_array_get_exclusive()
      serial: sh-sci: Add sci_is_rsci_type()
      serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
      serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
      serial: sh-sci: Add support for RZ/G3E RSCI clks
      serial: sh-sci: Make sci_scbrr_calc() public
      serial: sh-sci: Add finish_console_write() callback
      serial: rsci: Rename early_console data, port_params and callback() names
      serial: sh-sci: Add support for RZ/G3E RSCI
      dt-bindings: serial: renesas,scif: Document RZ/G3L SoC

Filip Jensen (1):
      serial: 8250_men_mcb: Clean defines

Geert Uytterhoeven (1):
      serial: rsci: Convert to FIELD_MODIFY()

Gerhard Engleder (3):
      serial: 8250_keba: Add missing includes
      serial: 8250_keba: Add ICR defines
      serial: 8250_keba: Use dev_err_probe()

Greg Kroah-Hartman (2):
      Merge 6.19-rc3 into tty-next
      Revert "tty: tty_port: add workqueue to flip TTY buffer"

Guodong Xu (1):
      dt-bindings: serial: 8250: add SpacemiT K3 UART compatible

Heiko Carstens (1):
      tty: hvc-iucv: Remove KMSG_COMPONENT macro

Jose Javier Rodriguez Barbarin (2):
      serial: men_z135_uart: drop unneeded MODULE_ALIAS
      8250_men_mcb: drop unneeded MODULE_ALIAS

Kendall Willis (1):
      serial: 8250: omap: set out-of-band wakeup if wakeup pinctrl exists

Kuan-Wei Chiu (1):
      dt-bindings: serial: google,goldfish-tty: Convert to DT schema

Lad Prabhakar (2):
      dt-bindings: serial: renesas,rsci: Document RZ/V2H(P) and RZ/V2N SoCs
      dt-bindings: serial: sh-sci: Fold single-entry compatibles into enum

Moteen Shah (2):
      serial: 8250: 8250_omap.c: Add support for handling UART error conditions
      serial: 8250: 8250_omap.c: Clear DMA RX running status only after DMA termination is done

Nathan Chancellor (1):
      tty: vt/keyboard: Split apart vt_do_diacrit()

Randy Dunlap (4):
      serial: imx: change SERIAL_IMX_CONSOLE to bool
      serial: 8250: fix ordering of entries for menu display
      serial: Kconfig: fix ordering of entries for menu display
      serial: SH_SCI: improve "DMA support" prompt

Uwe Kleine-König (4):
      serdev: Provide a bustype shutdown function
      Bluetooth: hci_aml: Migrate to serdev specific shutdown function
      Bluetooth: hci_qca: Migrate to serdev specific shutdown function
      platform/surface: Migrate to serdev specific shutdown function

Xin Zhao (1):
      tty: tty_port: add workqueue to flip TTY buffer

 Documentation/devicetree/bindings/goldfish/tty.txt |  17 --
 Documentation/devicetree/bindings/serial/8250.yaml |   1 +
 .../bindings/serial/google,goldfish-tty.yaml       |  41 +++
 .../devicetree/bindings/serial/renesas,rsci.yaml   | 105 ++++++-
 .../devicetree/bindings/serial/renesas,scif.yaml   |  16 +-
 Documentation/misc-devices/oxsemi-tornado.rst      |  26 +-
 drivers/bluetooth/hci_aml.c                        |  16 +-
 drivers/bluetooth/hci_qca.c                        |   5 +-
 drivers/platform/surface/aggregator/core.c         |   6 +-
 drivers/tty/hvc/hvc_iucv.c                         |   5 +-
 drivers/tty/n_hdlc.c                               |   2 +
 drivers/tty/serdev/core.c                          |  21 ++
 drivers/tty/serial/8250/8250_dw.c                  |  23 +-
 drivers/tty/serial/8250/8250_keba.c                |  27 +-
 drivers/tty/serial/8250/8250_men_mcb.c             |  15 +-
 drivers/tty/serial/8250/8250_omap.c                |  43 +--
 drivers/tty/serial/8250/8250_pci.c                 |  85 +++---
 drivers/tty/serial/8250/Kconfig                    |  95 +++----
 drivers/tty/serial/Kconfig                         |  34 +--
 drivers/tty/serial/men_z135_uart.c                 |   1 -
 drivers/tty/serial/rsci.c                          | 309 ++++++++++++++++++---
 drivers/tty/serial/rsci.h                          |   3 +-
 drivers/tty/serial/sh-sci-common.h                 |  10 +-
 drivers/tty/serial/sh-sci.c                        |  80 +++---
 drivers/tty/vt/keyboard.c                          | 233 ++++++++--------
 include/linux/serdev.h                             |   1 +
 26 files changed, 801 insertions(+), 419 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/tty.txt
 create mode 100644 Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
