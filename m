From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] serial: mux: Convert to uart_console_device instead of
 open-coded
Date: Sat, 19 Sep 2015 11:43:07 +0800
Message-ID: <1442634187.28089.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The implementation of mux_console_device() is very similar to
uart_console_device(). Setting .data field in mux_console then we can
convert to use uart_console_device().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
I don't have this h/w to test, so I'd appreciate if someone can test it.
 drivers/tty/serial/mux.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index dd26511..8a4be4b 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -412,19 +412,14 @@ static int mux_console_setup(struct console *co, char *options)
         return 0;
 }
 
-struct tty_driver *mux_console_device(struct console *co, int *index)
-{
-        *index = co->index;
-	return mux_driver.tty_driver;
-}
