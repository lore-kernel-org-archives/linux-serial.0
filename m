From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 5/5] drivers/tty: make serial 8250_lpc18xx.c Kconfig a tristate
Date: Wed, 19 Aug 2015 17:48:09 -0400
Message-ID: <1440020889-12120-6-git-send-email-paul.gortmaker@windriver.com>
References: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joachim Eastwood <manabian@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

8250/Kconfig:config SERIAL_8250_LPC18XX
8250/Kconfig:        bool "NXP LPC18xx/43xx serial port support"

...meaning that it currently is not being built as a module by anyone.

When targetting orphaned modular code in non-modular drivers, this
came up.  Joachim indicated that the driver was actually meant to
be tristate but ended up bool by accident.  So here we make it
tristate instead of removing the modular code that was essentially
orphaned.

Suggested-by: Joachim Eastwood <manabian@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index e1de1181b322..f5c4b01f6f1d 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -337,7 +337,7 @@ config SERIAL_8250_FINTEK
 	  through the PNP driver. If unsure, say N.
 
 config SERIAL_8250_LPC18XX
-	bool "NXP LPC18xx/43xx serial port support"
+	tristate "NXP LPC18xx/43xx serial port support"
 	depends on SERIAL_8250 && OF && (ARCH_LPC18XX || COMPILE_TEST)
 	default ARCH_LPC18XX
 	help
-- 
2.5.0
