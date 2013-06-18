From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH 0/5] MIPS/tty/8250: Use standard 8250 drivers for OCTEON
Date: Tue, 18 Jun 2013 12:12:50 -0700
Message-ID: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-serial@vger.kernel.org

From: David Daney <david.daney@cavium.com>

Get rid of the custom OCTEON UART probe code and use 8250_dw instead.

The first patch just gets rid of Ralf's Kconfig workarounds for the
real problem, which is OCTEON's inclomplete serial support.

Then we just make minor patches to 8250_dw, and rip out all this
OCTEON code.

Since the patches are all interdependent, we might want to merge them
via a single tree (perhaps Ralf's MIPS tree).

David Daney (5):
  Revert "MIPS: Octeon: Fix build error if CONFIG_SERIAL_8250=n"
  MIPS: OCTEON: Set proper UART clock in internal device trees.
  tty/8250_dw: Add support for OCTEON UARTS.
  MIPS: OCTEON: Remove custom serial setup code.
  MIPS: Update cavium_octeon_defconfig

 arch/mips/cavium-octeon/Makefile          |   1 -
 arch/mips/cavium-octeon/octeon-platform.c |   9 ++-
 arch/mips/cavium-octeon/serial.c          | 109 ------------------------------
 arch/mips/configs/cavium_octeon_defconfig |   4 +-
 drivers/tty/serial/8250/8250_dw.c         |  45 ++++++++++--
 5 files changed, 48 insertions(+), 120 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/serial.c

-- 
1.7.11.7
