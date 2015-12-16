From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 00/11] tty: serial: 8250: Fix checkpatch warnings
Date: Wed, 16 Dec 2015 16:36:06 +0100
Message-ID: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Peter Hurley <peter@hurleysoftware.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anto>
List-Id: linux-serial@vger.kernel.org

This patch set fixes several checkpatch warnings in tty/serial/8250.

Patch 1/11:  Adds missing spaces (mainly to function/macro headers)
Patch 2/11:  Fixes code indentation
Patch 3/11:  Slight patch which moves an opening curly brace
Patch 4/11:  Fixes multiline comment style
Patch 5/11:  Removes else blocks after return statements
Patch 6/11:  Slight patch which moves EXPORT_SYMBOL macro to correct position
Patch 7/11:  Slight patch which removes an unneccessary line continuation
Patch 8/11:  Slight patch which adds parentheses to a macro definition
Patch 9/11:  Merges user-visible multiline strings to a single line
Patch 10/11: Replaces printk by corresponding variant of pr_*
Patch 11/11: Removes code which has been commented out

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

Anton Wuerfel (11):
Phillip Raffeck (11):
  tty: serial: 8250: Fix whitespace errors
  tty: serial: 8250: Fix indentation warnings
  tty: serial: 8250: Fix braces after struct
  tty: serial: 8250: Fix multiline comment style
  tty: serial: 8250: Remove else after return
  tty: serial: 8250: Move EXPORT_SYMBOL to function
  tty: serial: 8250: Fix line continuation warning
  tty: serial: 8250: Add parentheses to macro
  tty: serial: 8250: Fix multi-line strings
  tty: serial: 8250: Replace printk by pr_*
  tty: serial: 8250: Delete commented code

 drivers/tty/serial/8250/8250_accent.c        |   2 +-
 drivers/tty/serial/8250/8250_acorn.c         |   2 +-
 drivers/tty/serial/8250/8250_boca.c          |   2 +-
 drivers/tty/serial/8250/8250_core.c          |  16 ++-
 drivers/tty/serial/8250/8250_dw.c            |   6 ++
 drivers/tty/serial/8250/8250_exar_st16c554.c |   2 +-
 drivers/tty/serial/8250/8250_fourport.c      |   2 +-
 drivers/tty/serial/8250/8250_gsc.c           |   6 +-
 drivers/tty/serial/8250/8250_hp300.c         |  22 ++--
 drivers/tty/serial/8250/8250_hub6.c          |   2 +-
 drivers/tty/serial/8250/8250_ingenic.c       |   6 +-
 drivers/tty/serial/8250/8250_pci.c           |  60 +++++------
 drivers/tty/serial/8250/8250_pnp.c           |  16 +--
 drivers/tty/serial/8250/8250_port.c          |  49 +++++----
 drivers/tty/serial/8250/serial_cs.c          | 153 ++++++++++++++-------------
 15 files changed, 181 insertions(+), 165 deletions(-)

-- 
1.9.1
