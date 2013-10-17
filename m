From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 00/10] tty: xuartps: Update
Date: Thu, 17 Oct 2013 14:08:03 -0700
Message-ID: <1382044093-29905-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

This is a series of patches to update the xuartps driver. Most of these
are contributions to our vendor tree that I ported on top of the curren=
t
mainline tree.

The highlights are:
 - support magic-sysrq and kgdb by Vlad
 - a fix for a deadlock condition by Lars
 - support for suspend/resume
 - dynamic adjustment on input clock changes

	S=C3=B6ren

Lars-Peter Clausen (1):
  tty: xuartps: Force enable the UART in xuartps_console_write

Soren Brinkmann (6):
  tty: xuartps: Use devm_clk_get()
  tty: xuartps: Use devm_kzalloc
  tty: xuartps: Updating set_baud_rate()
  tty: xuartps: Dynamically adjust to input frequency changes
  tty: xuartps: Implement suspend/resume callbacks
  tty: xuartps: Update copyright information

Suneel (1):
  tty: xuartps: support 64 byte FIFO size

Vlad Lungu (2):
  tty: xuartps: Implement BREAK detection, add SYSRQ support
  tty: xuartps: Add polled mode support for xuartps

 drivers/tty/serial/xilinx_uartps.c | 543 +++++++++++++++++++++++++++++=
+++-----
 1 file changed, 469 insertions(+), 74 deletions(-)

--=20
1.8.4.1
