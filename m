From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 09/12] tty: amba-pl011: remove ST micro registers from
 standard table
Date: Mon, 16 Nov 2015 17:40:47 +0000
Message-ID: <E1ZyNln-0003k4-3U@rmk-PC.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
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
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>
List-Id: linux-serial@vger.kernel.org

Remove the ST micro registers from the standard table.  These registers
should never be accessed in non-ST micro variants.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index f859aea50dbc..afa0de7d481f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -75,8 +75,6 @@
 
 static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
 	[REG_DR] = UART01x_DR,
-	[REG_ST_DMAWM] = ST_UART011_DMAWM,
-	[REG_ST_TIMEOUT] = ST_UART011_TIMEOUT,
 	[REG_FR] = UART01x_FR,
 	[REG_LCRH_RX] = UART011_LCRH,
 	[REG_LCRH_TX] = UART011_LCRH,
@@ -89,15 +87,6 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
 	[REG_MIS] = UART011_MIS,
 	[REG_ICR] = UART011_ICR,
 	[REG_DMACR] = UART011_DMACR,
-	[REG_ST_XFCR] = ST_UART011_XFCR,
-	[REG_ST_XON1] = ST_UART011_XON1,
-	[REG_ST_XON2] = ST_UART011_XON2,
-	[REG_ST_XOFF1] = ST_UART011_XOFF1,
-	[REG_ST_XOFF2] = ST_UART011_XOFF2,
-	[REG_ST_ITCR] = ST_UART011_ITCR,
-	[REG_ST_ITIP] = ST_UART011_ITIP,
-	[REG_ST_ABCR] = ST_UART011_ABCR,
-	[REG_ST_ABIMSC] = ST_UART011_ABIMSC,
 };
 
 /* There is by now at least one vendor with differing details, so handle it */
-- 
2.1.0
