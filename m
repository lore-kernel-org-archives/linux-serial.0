From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: ifx6x60: avoid uninitialized variable use
Date: Thu, 25 Feb 2016 21:47:57 +0100
Message-ID: <1456433283-3761559-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Russ Gorby <richardx.r.gorby@intel.com>, Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

gcc warns about a potential use of an uninitialized variable in this driver:

drivers/tty/serial/ifx6x60.c: In function 'ifx_spi_complete':
drivers/tty/serial/ifx6x60.c:713:6: warning: 'more' may be used uninitialized in this function [-Wmaybe-uninitialized]
   if (more || ifx_dev->spi_more || queue_length > 0 ||

Unlike a lot of other such warnings, this one is correct and describes
an actual problem in the handling of the "IFX_SPI_HEADER_F" result code.

This appears to be a result from a restructuring of the driver that
dates back to before it was merged in the kernel, so it's impossible
to know where it went wrong. I also don't know what that result code
means, so I have no idea if setting 'more' to zero is the correct
solution, but at least it makes the behavior reproducible rather than
depending on whatever happens to be on the kernel stack.

This patch initializes the 'more' variable to zero in each of the
three code paths that could result in undefined behavior before,
which is more explicit than initializing it at the start of the
function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/ifx6x60.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 88246f7e435a..2085a6cfa44b 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -395,8 +395,10 @@ static int ifx_spi_decode_spi_header(unsigned char *buffer, int *length,
 
 	if (h1 == 0 && h2 == 0) {
 		*received_cts = 0;
+		*more = 0;
 		return IFX_SPI_HEADER_0;
 	} else if (h1 == 0xffff && h2 == 0xffff) {
+		*more = 0;
 		/* spi_slave_cts remains as it was */
 		return IFX_SPI_HEADER_F;
 	}
@@ -688,6 +690,7 @@ static void ifx_spi_complete(void *ctx)
 			ifx_dev->rx_buffer + IFX_SPI_HEADER_OVERHEAD,
 			(size_t)actual_length);
 	} else {
+		more = 0;
 		dev_dbg(&ifx_dev->spi_dev->dev, "SPI transfer error %d",
 		       ifx_dev->spi_msg.status);
 	}
-- 
2.7.0
