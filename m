From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/4] tty: 8250: constify parisc_device_id
Date: Sat, 19 Aug 2017 23:24:55 +0530
Message-ID: <1503165296-31801-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, deller@gmx.de, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

parisc_device_id are not supposed to change at runtime. All functions
working with parisc_device_id provided by <asm/parisc-device.h> work
with const parisc_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/serial/8250/8250_gsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_gsc.c b/drivers/tty/serial/8250/8250_gsc.c
index 63306de..0c078cc 100644
--- a/drivers/tty/serial/8250/8250_gsc.c
+++ b/drivers/tty/serial/8250/8250_gsc.c
@@ -80,7 +80,7 @@ static int __init serial_init_chip(struct parisc_device *dev)
 	return 0;
 }
 
-static struct parisc_device_id serial_tbl[] = {
+static const struct parisc_device_id serial_tbl[] = {
 	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00075 },
 	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x0008c },
 	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x0008d },
@@ -94,7 +94,7 @@ static struct parisc_device_id serial_tbl[] = {
  * which only knows about Lasi and then a second which will find all the
  * other serial ports.  HPUX ignores this problem.
  */
-static struct parisc_device_id lasi_tbl[] = {
+static const struct parisc_device_id lasi_tbl[] = {
 	{ HPHW_FIO, HVERSION_REV_ANY_ID, 0x03B, 0x0008C }, /* C1xx/C1xxL */
 	{ HPHW_FIO, HVERSION_REV_ANY_ID, 0x03C, 0x0008C }, /* B132L */
 	{ HPHW_FIO, HVERSION_REV_ANY_ID, 0x03D, 0x0008C }, /* B160L */
-- 
2.7.4
