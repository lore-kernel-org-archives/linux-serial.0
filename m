From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4/6] ARM: sa1100/badge4: remove commented out modem control
 initialisers
Date: Fri, 31 May 2019 12:14:03 +0100
Message-ID: <E1hWfU3-0003fk-9R@rmk-PC.armlinux.org.uk>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Remove the commented out modem control initialisers.  These are doing
nothing useful.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/badge4.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 63361b6d04e9..17d28b4dab5e 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -315,8 +315,6 @@ badge4_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 }
 
 static struct sa1100_port_fns badge4_port_fns __initdata = {
-	//.get_mctrl	= badge4_get_mctrl,
-	//.set_mctrl	= badge4_set_mctrl,
 	.pm		= badge4_uart_pm,
 };
 
-- 
2.7.4
