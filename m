From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 11/41] drivers: tty: serial: sb1250-duart: fix formatting error
Date: Sat, 27 Apr 2019 14:51:52 +0200
Message-ID: <1556369542-13247-12-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, andrew@aj.id.au, andriy.shevchenko@linux.intel.com, macro@linux-mips.org, vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com, liviu.dudau@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk, linux@prisktech.co.nz, matthias.bgg@gmail.com, linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

checkpatch complains:

    ERROR: space required before the open parenthesis '('
    #659: FILE: drivers/tty/serial/sb1250-duart.c:659:
    +	if(refcount_dec_and_test(&duart->map_guard))

Just add this missing space to make checkpatch happy.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index ec74f09..0023ed0 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -656,7 +656,7 @@ static void sbd_release_port(struct uart_port *uport)
 	iounmap(uport->membase);
 	uport->membase = NULL;
 
-	if(refcount_dec_and_test(&duart->map_guard))
+	if (refcount_dec_and_test(&duart->map_guard))
 		release_mem_region(duart->mapctrl, DUART_CHANREG_SPACING);
 	release_mem_region(uport->mapbase, uport->mapsize);
 }
-- 
1.9.1
