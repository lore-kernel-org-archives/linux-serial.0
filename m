From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 49/56] MIPS: AR7: Ensure that serial ports are properly set up
Date: Mon, 13 Nov 2017 13:56:13 +0100
Message-ID: <20171113125604.053557173@linuxfoundation.org>
References: <20171113125557.613444087@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171113125557.613444087@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Jonas Gorski <jonas.gorski@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Nicolas Schichan <nschichan@freebox.fr>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, James Hogan <jhogan@kernel.org>
List-Id: linux-serial@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

commit b084116f8587b222a2c5ef6dcd846f40f24b9420 upstream.

Without UPF_FIXED_TYPE, the data from the PORT_AR7 uart_config entry is
never copied, resulting in a dead port.

Fixes: 154615d55459 ("MIPS: AR7: Use correct UART port type")
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
[jonas.gorski: add Fixes tag]
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: linux-mips@linux-mips.org
Cc: linux-serial@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17543/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ar7/platform.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -576,6 +576,7 @@ static int __init ar7_register_uarts(voi
 	uart_port.type		= PORT_AR7;
 	uart_port.uartclk	= clk_get_rate(bus_clk) / 2;
 	uart_port.iotype	= UPIO_MEM32;
+	uart_port.flags		= UPF_FIXED_TYPE;
 	uart_port.regshift	= 2;
 
 	uart_port.line		= 0;
