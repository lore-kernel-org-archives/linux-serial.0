From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/4] tty: mux: constify parisc_device_id
Date: Sat, 19 Aug 2017 23:24:56 +0530
Message-ID: <1503165296-31801-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503165296-31801-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503165296-31801-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, deller@gmx.de, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

parisc_device_id are not supposed to change at runtime. All functions
working with parisc_device_id provided by <asm/parisc-device.h> work
with const parisc_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/serial/mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 8a4be4b..6afe83d 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -536,13 +536,13 @@ static int mux_remove(struct parisc_device *dev)
  * This table only contains the parisc_device_id of known builtin mux
  * devices.  All other mux cards will be detected by the generic mux_tbl.
  */
-static struct parisc_device_id builtin_mux_tbl[] = {
+static const struct parisc_device_id builtin_mux_tbl[] = {
 	{ HPHW_A_DIRECT, HVERSION_REV_ANY_ID, 0x15, 0x0000D }, /* All K-class */
 	{ HPHW_A_DIRECT, HVERSION_REV_ANY_ID, 0x44, 0x0000D }, /* E35, E45, and E55 */
 	{ 0, }
 };
 
-static struct parisc_device_id mux_tbl[] = {
+static const struct parisc_device_id mux_tbl[] = {
 	{ HPHW_A_DIRECT, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x0000D },
 	{ 0, }
 };
-- 
2.7.4
