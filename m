From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/3] TTY: 8250_pnp, constify tables
Date: Tue, 12 Jan 2016 10:52:48 +0100
Message-ID: <1452592370-24951-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Make modem_names and base static const.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/8250/8250_pnp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 658b392d1170..e813a874c26f 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -380,16 +380,16 @@ static const struct pnp_device_id pnp_dev_table[] = {
 
 MODULE_DEVICE_TABLE(pnp, pnp_dev_table);
 
-static char *modem_names[] = {
+static const char *modem_names[] = {
 	"MODEM", "Modem", "modem", "FAX", "Fax", "fax",
 	"56K", "56k", "K56", "33.6", "28.8", "14.4",
 	"33,600", "28,800", "14,400", "33.600", "28.800", "14.400",
 	"33600", "28800", "14400", "V.90", "V.34", "V.32", NULL
 };
 
-static int check_name(char *name)
+static int check_name(const char *name)
 {
-	char **tmp;
+	const char **tmp;
 
 	for (tmp = modem_names; *tmp; tmp++)
 		if (strstr(name, *tmp))
@@ -400,7 +400,7 @@ static int check_name(char *name)
 
 static int check_resources(struct pnp_dev *dev)
 {
-	resource_size_t base[] = {0x2f8, 0x3f8, 0x2e8, 0x3e8};
+	static const resource_size_t base[] = {0x2f8, 0x3f8, 0x2e8, 0x3e8};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(base); i++) {
-- 
2.7.0
