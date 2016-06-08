From: Matthew Leach <matthew@mattleach.net>
Subject: [RFC PATCH 05/15] tty: serial: samsung: fixup accessors for endian
Date: Wed,  8 Jun 2016 19:31:00 +0100
Message-ID: <20160608183110.13851-6-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Matthew Leach <matthew@mattleach.net>, linux-samsung-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Fix the serial access code to deal with kernels built for big endian
operation.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
---
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/samsung.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index fc5deaa..8818bdd 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -118,9 +118,9 @@ struct s3c24xx_uart_port {
 	((unsigned long *)(unsigned long)((port)->membase + (reg)))
 
 #define rd_regb(port, reg) (__raw_readb(portaddr(port, reg)))
-#define rd_regl(port, reg) (__raw_readl(portaddr(port, reg)))
+#define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
 
 #define wr_regb(port, reg, val) __raw_writeb(val, portaddr(port, reg))
-#define wr_regl(port, reg, val) __raw_writel(val, portaddr(port, reg))
+#define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
 
 #endif
-- 
2.8.3
