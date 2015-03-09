From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 -next 00/11]  Extensible console matching & direct earlycon
Date: Mon,  9 Mar 2015 16:27:11 -0400
Message-ID: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Changes from v2:
* remainder of unapplied series
* Changed the title and commit log for
  "serial: earlycon: Allow earlycon params with name only" to
  "serial: earlycon: Skip parse_options() for empty string" per Rob's
  comment.

Changes from v1:
* rebased on and requires "console: Fix console name size mismatch"


Hi Greg & Andrew,

This patch series implements:
  1. console-definable (aka extensible) matching
  2. generic earlycon-to-console handoff via extensible matching
  3. arch/prom support for direct earlycon


Extensible console matching

Extensible console matching enables the console itself to define the
conditions for a "command line" match. This mimics the design of
device matching in the driver model. Two important use-cases which this
feature enables are generic earlycon-to-console handoff and support
for driver migration.

Earlycon-to-console handoff was implemented in 2007. Console command
lines of the form:
   console=uart,io,0x3f8,115200n8
start an earlycon and later allow the 8250 driver console to takeover.
Unfortunately this implementation requires direct coupling between
the earlycon and the console and is facilitated by ugly hacks like
editing the console command line in-place.

Extensible console matching allows the 8250 driver to directly match
that console command line instead, and enables other serial drivers
to trivially support console handoff themselves.

In addition, extensible console matching allows a new driver to
provide support for a different driver's console. This requirement
stems from needing to minimize breakage when migrating serial drivers.
Since many devices are based on the original 8250/16550 designs
but sometimes have features incompatible with the existing 8250 driver
support, the initial driver is often standalone. When/if the standalone
driver is migrated to the 8250 driver, the problem of console names in
the command line remains. Extensible console matching enables a simple
migration path.


Direct earlycon

This feature enables arches and proms to start an earlycon directly,
rather than requiring an "earlycon=" command line parameter.
Devicetree can already do this via the 'linux,stdout-path' property,
but arch and prom code requires direct coupling to the serial driver.

This support is implemented by judicious refactoring and the same
construct that devicetree and early_param use: a link table containing
the necessary information (name and setup() function) to find and
bind the appropriate earlycon "driver".


NB: I combined these two features in this series because their
implementations heavily overlap in the same source files.

Regards,

Peter Hurley (11):
  console: Add extensible console matching
  serial: core: Fix kernel doc for uart_console_write()
  serial: 8250_early: Remove early_device variable
  serial: earlycon: Move ->uartclk initialize
  serial: 8250_early: Assume uart already initialized if no baud option
  serial: 8250_early: Fix setup() error code
  serial: earlycon: Ignore parse_options() error code
  serial: earlycon: Skip parse_options() if empty string
  serial: earlycon: Refactor earlycon registration
  serial: earlycon: Enable earlycon without command line param
  serial: 8250_early: Remove setup_early_serial8250_console()

 arch/mips/mti-malta/malta-init.c     |   4 +-
 drivers/firmware/pcdp.c              |   4 +-
 drivers/tty/serial/8250/8250_core.c  |  64 ++++++++++++++++------
 drivers/tty/serial/8250/8250_early.c |  51 ++++--------------
 drivers/tty/serial/earlycon.c        | 101 ++++++++++++++++++++++++++++-------
 drivers/tty/serial/serial_core.c     |   2 +-
 include/asm-generic/vmlinux.lds.h    |   9 ++++
 include/linux/console.h              |   3 +-
 include/linux/serial_8250.h          |   3 --
 include/linux/serial_core.h          |  19 ++++---
 kernel/printk/printk.c               |  52 +++++++-----------
 11 files changed, 185 insertions(+), 127 deletions(-)

-- 
2.3.1
