From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3.18 19/52] MIPS: AR7: ensure the port types FCR value is used
Date: Mon, 29 Jan 2018 13:56:37 +0100
Message-ID: <20180129123629.035172662@linuxfoundation.org>
References: <20180129123628.168904217@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20180129123628.168904217@linuxfoundation.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Florian Fainelli <f.fainelli@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
List-Id: linux-serial@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

commit 0a5191efe06b5103909206e4fbcff81d30283f8e upstream.

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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>
Cc: linux-mips@linux-mips.org
Cc: linux-serial@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17544/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ar7/platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -581,7 +581,7 @@ static int __init ar7_register_uarts(voi
 	uart_port.type		= PORT_AR7;
 	uart_port.uartclk	= clk_get_rate(bus_clk) / 2;
 	uart_port.iotype	= UPIO_MEM32;
-	uart_port.flags		= UPF_FIXED_TYPE;
+	uart_port.flags		= UPF_FIXED_TYPE | UPF_BOOT_AUTOCONF;
 	uart_port.regshift	= 2;
 
 	uart_port.line		= 0;
