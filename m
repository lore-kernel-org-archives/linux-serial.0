From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/3] TTY: 8250_pnp, make checks bool
Date: Tue, 12 Jan 2016 10:52:49 +0100
Message-ID: <1452592370-24951-2-git-send-email-jslaby@suse.cz>
References: <1452592370-24951-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452592370-24951-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Since check_name and check_resources return only 0/1, switch them to
bool/true/false.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/8250/8250_pnp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index e813a874c26f..f6332de4e3e3 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -387,28 +387,28 @@ static const char *modem_names[] = {
 	"33600", "28800", "14400", "V.90", "V.34", "V.32", NULL
 };
 
-static int check_name(const char *name)
+static bool check_name(const char *name)
 {
 	const char **tmp;
 
 	for (tmp = modem_names; *tmp; tmp++)
 		if (strstr(name, *tmp))
-			return 1;
+			return true;
 
-	return 0;
+	return false;
 }
 
-static int check_resources(struct pnp_dev *dev)
+static bool check_resources(struct pnp_dev *dev)
 {
 	static const resource_size_t base[] = {0x2f8, 0x3f8, 0x2e8, 0x3e8};
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(base); i++) {
 		if (pnp_possible_config(dev, IORESOURCE_IO, base[i], 8))
-			return 1;
+			return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /*
-- 
2.7.0
