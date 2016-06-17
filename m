From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 0/4] tty/serial: atmel: rework tasklets and shutdown sequence
Date: Fri, 17 Jun 2016 12:05:45 +0200
Message-ID: <cover.1466157015.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

We experienced some issues with how the atmel_serial driver was dealing with
tasklets.
First, a single tasklet was used for both RX and TX paths which was leading to
calling DMA residue checking routines frequently without reason. So I split the
RX and TX paths with one tasklet for each.
Secondly, as we experienced some deadlocks, I reinforced the shutdown function
of this driver by following the recommended sequence that is described
here:
https://lwn.net/Articles/588457/

The first 3 patches have already been posted on May 12th. The 4th patch is
built on top of them, this is why make a series with them...

Bye,


Ludovic Desroches (1):
  tty/serial: atmel: add comment for the ring buffer size macro

Nicolas Ferre (3):
  tty/serial: atmel: re-integrate status check in irq handler
  tty/serial: atmel: split tx and rx paths
  tty/serial: atmel: enforce tasklet init and termination sequences

 drivers/tty/serial/atmel_serial.c | 129 +++++++++++++++++++++++---------------
 1 file changed, 78 insertions(+), 51 deletions(-)

-- 
2.9.0
