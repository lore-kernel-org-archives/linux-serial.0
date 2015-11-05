From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH v2 00/10] tty: xuartps: Fix lock ups
Date: Wed, 4 Nov 2015 23:21:09 -0800
Message-ID: <1446708079-1105-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Hi,

this is v2, hopefully without any build issues. The changes are the sam=
e
as before, just the warning reported by kbuild test robot about unused
variables have been fixed. And, I added one more patch with some
cleanup/refactoring.

I recently found my system locking up under some conditions. I dug
through the code a bit and the result is this collections of various
changes. Some of it may not be required and has just been created out o=
f
half-baked theories and re-reading the documentation. The actual failin=
g
scenarios seem to be:
 - RX IRQ conditions are handled while the receiver is disabled, leavin=
g
   the driver in an infinite loop
 - console_put_char seems to be interrupted by uart_shutdown disabling
   the transmitter while/just before printing

I.e. overall I tried to serialize all operations using the port lock to
avoid such interaction.

	S=C3=B6ren

S=C3=B6ren Brinkmann (10):
  tty: xuartps: Beautify read-modify writes
  tty: xuartps: Use spinlock to serialize HW access
  tty: xuartps: Always enable transmitter in start_tx
  tty: xuartps: Clear interrupt status register in shutdown
  tty: xuartps: Improve startup function
  tty: xuartps: Keep lock for whole ISR
  tty: xuartps: Acquire port lock for shutdown
  tty: xuartps: Move RX path into helper function
  tty: xuartps: Only handle RX IRQs when RX is enabled
  tty: xuartps: Cleanup: Reformat if-else

 drivers/tty/serial/xilinx_uartps.c | 247 ++++++++++++++++++++---------=
--------
 1 file changed, 136 insertions(+), 111 deletions(-)

--=20
2.6.2.3.ga463a5b
