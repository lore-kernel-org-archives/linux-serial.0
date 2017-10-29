From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH 2/3] MIPS: AR7: ensure that serial ports are properly set up
Date: Sun, 29 Oct 2017 16:27:20 +0100
Message-ID: <20171029152721.6770-3-jonas.gorski@gmail.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20171029152721.6770-1-jonas.gorski@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Florian Fainelli <f.fainelli@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
List-Id: linux-serial@vger.kernel.org

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

without UPF_FIXED_TYPE, the data from the PORT_AR7 uart_config entry is
never copied, resulting in a dead port.

Fixes: 154615d55459 ("MIPS: AR7: Use correct UART port type")
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
[jonas.gorski: add Fixes tag]
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/ar7/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index f2c9f90c5f13..4674f1efbe7a 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -575,6 +575,7 @@ static int __init ar7_register_uarts(void)
 	uart_port.type		= PORT_AR7;
 	uart_port.uartclk	= clk_get_rate(bus_clk) / 2;
 	uart_port.iotype	= UPIO_MEM32;
+	uart_port.flags		= UPF_FIXED_TYPE;
 	uart_port.regshift	= 2;
 
 	uart_port.line		= 0;
-- 
2.13.2
