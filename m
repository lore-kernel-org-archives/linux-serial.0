From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/4] serial: 8250_uniphier: drop !defined(MODULE) conditional
Date: Mon,  6 Jun 2016 18:41:01 +0900
Message-ID: <1465206063-1018-3-git-send-email-yamada.masahiro@socionext.com>
References: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Paul Burton <paul.burton@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The !defined(MODULE) conditional has been added to the
OF_EARLYCON_DECLARE() define.

Now we can revert commit a2d3ea2f2399 ("serial: 8250/uniphier:
fix modular build").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index efd1f9c..b8d9c8c 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -35,7 +35,7 @@ struct uniphier8250_priv {
 	spinlock_t atomic_write_lock;
 };
 
-#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init uniphier_early_console_setup(struct earlycon_device *device,
 					       const char *options)
 {
-- 
1.9.1
