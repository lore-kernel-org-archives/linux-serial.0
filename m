From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH 1/3] MIPS: AR7: defer registration of GPIO
Date: Sun, 29 Oct 2017 16:27:19 +0100
Message-ID: <20171029152721.6770-2-jonas.gorski@gmail.com>
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

When called from prom init code, ar7_gpio_init() will fail as it will
call gpiochip_add() which relies on a working kmalloc() to alloc
the gpio_desc array and kmalloc is not useable yet at prom init time.

Move ar7_gpio_init() to ar7_register_devices() (a device_initcall)
where kmalloc works.

Fixes: 14e85c0e69d5 ("gpio: remove gpio_descs global array")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Text shamelessy stolen from commit 2ec459f2a77b8.

 arch/mips/ar7/platform.c | 4 ++++
 arch/mips/ar7/prom.c     | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index df7acea3747a..f2c9f90c5f13 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -653,6 +653,10 @@ static int __init ar7_register_devices(void)
 	u32 val;
 	int res;
 
+	res = ar7_gpio_init();
+	if (res)
+		pr_warn("unable to register gpios: %d\n", res);
+
 	res = ar7_register_uarts();
 	if (res)
 		pr_err("unable to setup uart(s): %d\n", res);
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 4fd83336131a..dd53987a690f 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -246,8 +246,6 @@ void __init prom_init(void)
 	ar7_init_cmdline(fw_arg0, (char **)fw_arg1);
 	ar7_init_env((struct env_var *)fw_arg2);
 	console_config();
-
-	ar7_gpio_init();
 }
 
 #define PORT(offset) (KSEG1ADDR(AR7_REGS_UART0 + (offset * 4)))
-- 
2.13.2
