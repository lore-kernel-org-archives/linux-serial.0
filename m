From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH 0/7] serial: 8250_fintek: Fix the IRQ mode and code refactoring
Date: Thu,  1 Sep 2016 11:39:49 +0800
Message-ID: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, peter@hurleysoftware.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

The following patches will fix the Fintek LPC to UARTs IRQ mode mismatch
issue, code refactoring and this series patches should follow by patch
rename IRQ_MODE macro on
'commit 87a713c8ffca ("8250/fintek: rename IRQ_MODE macro")'.
with tty-linus branch.

Some BIOS only use _OSI("Linux") to distinguish between Linux & Windows.
Apply Level/Low to UART trigger mode if Windows, Edge/High otherwise.
But since 2.6.23 the mainline kernel no longer returns true for
_OSI(“Linux”). The BIOS ASL should avoid to use _OSI() to check system
type and use ACPI MADT override IRQ mode instead.

We'll try to refactoring the source code more readable with SuperIO
read/write register functions.

Ricardo Ribalda Delgado suggest fixing a potential NULL pointer
dereference with applied patch
fix the mismatched IRQ mode on
'commit 4da22f1418cb ("serial: 8250_fintek: fix the mismatched IRQ mode")'.
had been implemented with 8250_fintek: Set IRQ Mode when port probed.

Ji-Ze Hong (Peter Hong) (7):
  serial: 8250_fintek: Refactoring read/write method
  serial: 8250_fintek: Set IRQ Mode when port probed
  serial: 8250_fintek: Set maximum FIFO of F81216H
  serial: 8250_fintek: Rearrange function
  serial: 8250_fintek: Add F81216 Support
  serial: 8250_fintek: Add F81866 Support
  serial: 8250_fintek: Add F81865 Support

 drivers/tty/serial/8250/8250_fintek.c | 233 +++++++++++++++++++++++++---------
 1 file changed, 175 insertions(+), 58 deletions(-)

-- 
1.9.1
