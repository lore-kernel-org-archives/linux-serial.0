From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v7 00/15] tty: serial: 8250: Fix checkpatch warnings
Date: Thu, 14 Jan 2016 16:08:09 +0100
Message-ID: <1452784104-30840-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Joachim Eastwood <manabian@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phillip Raffeck <phillip.raffeck@fau.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hung <hpeter@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anton.wuerfel@fau.de>
List-Id: linux-serial@vger.kernel.org

This patch set fixes several checkpatch warnings in tty/serial/8250.

Patch 1/15:  Adds missing spaces (mainly to function/macro headers)
Patch 2/15:  Replace spaces with tabs wherever possible
Patch 3/15:  Slight patch which moves an opening curly brace
Patch 4/15:  Fixes multiline comment style
Patch 5/15:  Removes else blocks after return statements
Patch 6/15:  Slight patch which moves EXPORT_SYMBOL macro to correct
position
Patch 7/15:  Slight patch which removes an unneccessary line continuation
Patch 8/15:  Slight patch which adds parentheses to a macro definition
Patch 9/15:  Merges user-visible multiline strings to a single line
Patch 10/15: Replace printk by dev_* or pr_* where appropriate
Patch 11/15: Remove orphaned debug macro
Patch 12/15: Fix warnings in dev_dbg by adding two casts
Patch 13/15: Refactor a switch/case statement
Patch 14/15: Fixes code indentation
Patch 15/15: Add a generic port macro

Remaining checkpatch warnings after applying this patch series:

-line over 80 characters
	This error mostly occurs in serial_cs.c, which contains long-lined
	macro calls. However, splitting these calls into multiple lines would
	not increase readability.

-externs should be avoided in .c files
	This occurs in 8250_hp300.c. There is no corresponding header file
	the extern statement could be moved to. It could be moved to 8250.h
	but this would affect other .c files.

-Use #include <linux/*.h> instead of <asm/*.h>
	This warning has been left open for more experienced kernel hackers.
	This patch series is about style issues. We do not intend to alter
	the code behavior.
-struct uart_ops should normally be const
	This warning only occurs in 8250_core.c. The corresponding struct
	cannot be declared as const because it is altered in
	serial8250_isa_init_ports(). Maybe a checkpatch exception should
	be added for this particular warning.

-quoted string split across lines
	These strings were ignored because they otherwise would exceed
	80 characters in a single line. These particular strings use
	format specifiers, which break the ability to grep for them anyway.

Anton Wuerfel (15):
Phillip Raffeck (15):
  tty: serial: 8250: Fix whitespace errors
  tty: serial: 8250: Replace spaces with tabs
  tty: serial: 8250: Fix braces after struct
  tty: serial: 8250: Fix multiline comment style
  tty: serial: 8250: Remove else after return
  tty: serial: 8250: Move EXPORT_SYMBOL to function
  tty: serial: 8250: Fix line continuation warning
  tty: serial: 8250: Add parentheses to macro
  tty: serial: 8250: Fix multi-line strings
  tty: serial: 8250: Correct conversion specifiers
  tty: serial: 8250: Merge duplicate conditions
  tty: serial: 8250: Fix indentation warnings
  tty: serial: 8250: Add generic port init macro
  tty: serial: 8250: Suitably replace printk
  tty: serial: 8250: Remove SERIAL_DEBUG_PNP macro

 drivers/tty/serial/8250/8250.h               | 12 ++++
 drivers/tty/serial/8250/8250_accent.c        | 13 +---
 drivers/tty/serial/8250/8250_acorn.c         |  2 +-
 drivers/tty/serial/8250/8250_boca.c          | 41 ++++++-------
 drivers/tty/serial/8250/8250_core.c          | 15 ++---
 drivers/tty/serial/8250/8250_exar_st16c554.c | 17 ++----
 drivers/tty/serial/8250/8250_fourport.c      | 28 ++++-----
 drivers/tty/serial/8250/8250_gsc.c           |  7 ++-
 drivers/tty/serial/8250/8250_hp300.c         | 27 +++++----
 drivers/tty/serial/8250/8250_hub6.c          |  2 +-
 drivers/tty/serial/8250/8250_ingenic.c       | 12 ++--
 drivers/tty/serial/8250/8250_pci.c           | 60 ++++++++++---------
 drivers/tty/serial/8250/8250_pnp.c           | 28 +++++----
 drivers/tty/serial/8250/8250_port.c          | 47 ++++++++-------
 drivers/tty/serial/8250/serial_cs.c          | 90 +++++++++++++++-------------
 15 files changed, 203 insertions(+), 198 deletions(-)

-- 
1.9.1
