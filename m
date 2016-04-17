From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH, RESEND] serial-uartlite: un-constify uartlite_be/uartlite_le
Date: Sun, 17 Apr 2016 02:12:47 +0200
Message-ID: <1460851985-1280235-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>, Maarten Brock <m.brock@vanmierlo.com>, Rich Felker <dalias@libc.org>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The patch to make uartlite_be/uartlite_le const was well-intended but
caused a new build warning:

tty/serial/uartlite.c: In function 'ulite_request_port':
tty/serial/uartlite.c:348:21: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
tty/serial/uartlite.c:354:22: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

It would be nice to allow passing const pointers through
port->private_data, but that would be way more work, so this
reverts part of the original commit for now.

A possible alternative might be to pass a structure in the private_data
that contains a const pointer to the operations, which introduces a little
extra overhead, or we could just add a cast to a non-const pointer, I'll
leave that to the maintainer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 2905697a82ea ("serial-uartlite: Constify uartlite_be/uartlite_le")
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

I sent this patch on March 10, but it never made it in.

Greg, could you apply the patch as a bugfix for 4.6? The warning is
annoying as it shows up in several defconfig builds and allmodconfig.

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index c9fdfc8bf47f..1474c5755140 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -72,7 +72,7 @@ static void uartlite_outbe32(u32 val, void __iomem *addr)
 	iowrite32be(val, addr);
 }
 
-static const struct uartlite_reg_ops uartlite_be = {
+static struct uartlite_reg_ops uartlite_be = {
 	.in = uartlite_inbe32,
 	.out = uartlite_outbe32,
 };
@@ -87,7 +87,7 @@ static void uartlite_outle32(u32 val, void __iomem *addr)
 	iowrite32(val, addr);
 }
 
-static const struct uartlite_reg_ops uartlite_le = {
+static struct uartlite_reg_ops uartlite_le = {
 	.in = uartlite_inle32,
 	.out = uartlite_outle32,
 };
-- 
2.7.0
