From: Laura Abbott <labbott@redhat.com>
Subject: [PATCH] kgdboc: Fix restrict error
Date: Mon, 10 Sep 2018 16:20:14 -0700
Message-ID: <20180910232014.2642-1-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Laura Abbott <labbott@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

There's an error when compiled with restrict:

drivers/tty/serial/kgdboc.c: In function ‘configure_kgdboc’:
drivers/tty/serial/kgdboc.c:137:2: error: ‘strcpy’ source argument is the same
as destination [-Werror=restrict]
  strcpy(config, opt);
  ^~~~~~~~~~~~~~~~~~~

As the error implies, this is from trying to use config as both source and
destination. Drop the call to the function where config is the argument
since nothing else happens in the function.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/tty/serial/kgdboc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index b4ba2b1dab76..dd503743bbff 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -154,15 +154,13 @@ static int configure_kgdboc(void)
 {
 	struct tty_driver *p;
 	int tty_line = 0;
-	int err;
+	int err = -ENODEV;
 	char *cptr = config;
 	struct console *cons;
 
-	err = kgdboc_option_setup(config);
-	if (err || !strlen(config) || isspace(config[0]))
+	if (!strlen(config) || isspace(config[0]))
 		goto noconfig;
 
-	err = -ENODEV;
 	kgdboc_io_ops.is_console = 0;
 	kgdb_tty_driver = NULL;
 
-- 
2.17.1
