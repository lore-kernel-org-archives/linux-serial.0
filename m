From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V2 0/6] serial: 8250_fintek: Fix the IRQ mode and code refactoring
Date: Tue,  4 Oct 2016 16:27:58 +0800
Message-ID: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, peter@hurleysoftware.com, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

The following patches will fix the Fintek LPC to UARTs IRQ mode mismatch
issue and code refactoring.

Some BIOS only use _OSI("Linux") to distinguish between Linux & Windows.
Apply Level/Low to UART trigger mode if Windows, Edge/High otherwise.
But since 2.6.23 the mainline kernel no longer returns true for
_OSI("Linux"). The BIOS ASL should avoid to use _OSI() to check system
type and use ACPI MADT override IRQ mode instead.

We'll try to refactoring the source code more readable with SuperIO
read/write register functions.

Changelog:
V2
    1. Code refacting. Suggest by Ricardo Ribalda Delgado.

Ji-Ze Hong (Peter Hong) (6):
  serial: 8250_fintek: Refactoring read/write method
  serial: 8250_fintek: Set IRQ Mode when port probed
  serial: 8250_fintek: Set maximum FIFO of F81216H
  serial: 8250_fintek: Add F81216 Support
  serial: 8250_fintek: Add F81866 Support
  serial: 8250_fintek: Add F81865 Support

 drivers/tty/serial/8250/8250_fintek.c | 231 +++++++++++++++++++++++++---------
 1 file changed, 173 insertions(+), 58 deletions(-)

-- 
1.9.1
