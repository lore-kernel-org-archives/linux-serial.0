From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] tty: amba-pl011: constify vendor_data structures
Date: Fri, 11 Aug 2017 13:47:28 +0200
Message-ID: <1502452048-3444-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>
Cc: kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-serial@vger.kernel.org

These vendor_data structures are only stored in the vendor field of
the uart_amba_port structure, as defined in the same file, and this
field is declared as const.  Thus the vendor_data structures can be
const too.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

There are some other vendor_data structures in the same file, but
they are used in a different way.

 drivers/tty/serial/amba-pl011.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1888d16..ba4e795 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -128,7 +128,7 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
 	.get_fifosize		= get_fifosize_arm,
 };
 
-static struct vendor_data vendor_sbsa = {
+static const struct vendor_data vendor_sbsa = {
 	.reg_offset		= pl011_std_offsets,
 	.fr_busy		= UART01x_FR_BUSY,
 	.fr_dsr			= UART01x_FR_DSR,
@@ -143,7 +143,7 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
 };
 
 #ifdef CONFIG_ACPI_SPCR_TABLE
-static struct vendor_data vendor_qdt_qdf2400_e44 = {
+static const struct vendor_data vendor_qdt_qdf2400_e44 = {
 	.reg_offset		= pl011_std_offsets,
 	.fr_busy		= UART011_FR_TXFE,
 	.fr_dsr			= UART01x_FR_DSR,

