From: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Subject: [PATCH 0/2] tty/serial: atmel: Fix RS485 half duplex operation
Date: Fri, 15 Mar 2019 11:23:32 +0200
Message-ID: <20190315092334.13246-1-razvan.stefanescu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Using a loopback serial cable with RS485 protocol shows that data is
received:
$ stty -F /dev/ttyS3 raw -echo speed 4800
$ cat /dev/ttyS3 &
$ echo "Hello, world" > /dev/ttyS3
Hello, world

Last line should not be displayed, as it indicates that RX was started
before TX finished.

This happens because driver activates RX when the DMA transfer
completes, but that does not necessarily mean the TX FIFO was emptied.

First patch will add a helper that checks if the transmission is
half-duplex and uses it throughout the driver, replacing multiple lines
of code.

Second patch implements the fix by adding a variable to the port struct.
This is used to indicate that RX needs to be started. When the DMA
transfer completes, the variable is set and the ATMEL_US_TXEMPTY is
reactivated. In the interrupt handler, if the variable is set, RX is
started.

Razvan Stefanescu (2):
  tty/serial: atmel: Add is_half_duplex helper
  tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

 drivers/tty/serial/atmel_serial.c | 52 +++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 16 deletions(-)

-- 
2.19.1
