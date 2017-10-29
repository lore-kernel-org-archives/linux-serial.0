From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH RFC 3/3] MIPS: AR7: ensure the port type's FCR value is used
Date: Sun, 29 Oct 2017 16:27:21 +0100
Message-ID: <20171029152721.6770-4-jonas.gorski@gmail.com>
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
Cc: Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Florian Fainelli <f.fainelli@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: linux-serial@vger.kernel.org

Since commit aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt
trigger I/F of FIFO buffers"), the port's default FCR value isn't used
in serial8250_do_set_termios anymore, but copied over once in
serial8250_config_port and then modified as needed.

Unfortunately, serial8250_config_port will never be called if the port
is shared between kernel and userspace, and the port's flag doesn't have
UPF_BOOT_AUTOCONF, which would trigger a serial8250_config_port as well.

This causes garbled output from userspace:

[    5.220000] random: procd urandom read with 49 bits of entropy available
ers
   [kee

Fix this by forcing it to be configured on boot, resulting in the
expected output:

[    5.250000] random: procd urandom read with 50 bits of entropy available
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level

Fixes: aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt trigger I/F of FIFO buffers")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
I'm not sure if this is just AR7's issue, or if this points to a general
issue for UARTs used as kernel console and login console with the "fixed"
commit.

 arch/mips/ar7/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 4674f1efbe7a..e1675c25d5d4 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -575,7 +575,7 @@ static int __init ar7_register_uarts(void)
 	uart_port.type		= PORT_AR7;
 	uart_port.uartclk	= clk_get_rate(bus_clk) / 2;
 	uart_port.iotype	= UPIO_MEM32;
-	uart_port.flags		= UPF_FIXED_TYPE;
+	uart_port.flags		= UPF_FIXED_TYPE | UPF_BOOT_AUTOCONF;
 	uart_port.regshift	= 2;
 
 	uart_port.line		= 0;
-- 
2.13.2
