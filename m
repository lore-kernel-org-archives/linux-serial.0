From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 0/8] Misc serial cleanups
Date: Sun, 10 Jan 2016 20:23:54 -0800
Message-ID: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Apologies for the earlier mixed series; this is the proper series.
This series contains accumulated cleanups for the serial core.

Several of these patches were in earlier series that were not applied
so I split the simpler ones into this series to form a basis for
follow-on series (especially the "Fix unsafe uart port access" series
and another that addresses the tty_port->flags problem).

Regards,

Regards,

Peter Hurley (8):
  serial: core: Fold __uart_put_char() into caller
  serial: core: Fold do_uart_get_info() into caller
  serial: core: Use tty->index for port # in debug messages
  serial: Fix ASYNC_* => UPF_* flags misuse
  serial: core: Cleanup uart_open() exit
  serial: core: Remove cast from void ptr in uart_open()
  serial: core: Unfold < 80 char lines
  serial: core: Perform RTS signalling before soft flow ctrl

 arch/alpha/include/asm/serial.h      |  8 ++--
 arch/frv/include/asm/serial.h        |  2 +-
 arch/m68k/include/asm/serial.h       |  8 ++--
 arch/mips/pmcs-msp71xx/msp_serial.c  |  2 +-
 arch/mn10300/include/asm/serial.h    | 10 ++---
 arch/xtensa/platforms/xt2000/setup.c |  2 +-
 drivers/tty/serial/serial_core.c     | 71 ++++++++++++++----------------------
 drivers/tty/serial/serial_ks8695.c   |  2 +-
 8 files changed, 44 insertions(+), 61 deletions(-)

-- 
2.7.0
