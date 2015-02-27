From: Leilei Zhao <leilei.zhao@atmel.com>
Subject: [PATCH v2 0/5] tty/serial: at91: fix bugs when using multiple serials
Date: Fri, 27 Feb 2015 16:07:13 +0800
Message-ID: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Leilei Zhao <leilei.zhao@atmel.com>
List-Id: linux-serial@vger.kernel.org

The series of patches fix bugs when using multiple serial ports at the same time:
 - The using rx ring buffer in DMA is inconsistent with its allocation.
 - The serial port can't send and receive data when it's opened the second time
   and the later if it switches to PIO when DMA channel is not available.
 - The serial port can lead to kernel crash when data is sending and receiving
   and the program is killed.
 
The patches were made from branch tty-next of gregkh/tty.git repository, and 
tested on a SAMA5D36 VB boards with 5 serial ports enabled.

Changes from v1:
 - Use macro PAGE_ALIGNED to simplify the expression.

Leilei Zhao (5):
  tty/serial: at91: correct check of buf used in DMA
  tty/serial: at91: correct buffer size used in DMA
  tty/serial: at91: revise the return type of atmel_init_property
  tty/serial: at91: set ops in property init each time
  tty/serial: at91: correct the usage of tasklet

 drivers/tty/serial/atmel_serial.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
1.7.9.5
