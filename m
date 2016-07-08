From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 2/3] tty: amba-pl011: add .get_fifosize for ZTE device
Date: Fri,  8 Jul 2016 17:00:40 +0800
Message-ID: <1467968441-4056-3-git-send-email-shawn.guo@linaro.org>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, Timur Tabi <timur@codeaurora.org>, xie.baoyou@zte.com.cn, linux-serial@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

ZTE PL011 device has a fixed FIFO size 16.  Let's add a .get_fifosize
hook for it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e09354e6bcb7..8b7fb3689ee7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -204,6 +204,11 @@ static const u16 pl011_zte_offsets[REG_ARRAY_SIZE] = {
 	[REG_DMACR] = ZX_UART011_DMACR,
 };
 
+static unsigned int get_fifosize_zte(struct amba_device *dev)
+{
+	return 16;
+}
+
 static struct vendor_data vendor_zte __maybe_unused = {
 	.reg_offset		= pl011_zte_offsets,
 	.access_32b		= true,
@@ -212,7 +217,7 @@ static struct vendor_data vendor_zte __maybe_unused = {
 	.fr_dsr			= ZX_UART01x_FR_DSR,
 	.fr_cts			= ZX_UART01x_FR_CTS,
 	.fr_ri			= ZX_UART011_FR_RI,
-	.get_fifosize		= get_fifosize_arm,
+	.get_fifosize		= get_fifosize_zte,
 };
 
 /* Deals with DMA transactions */
-- 
1.9.1
