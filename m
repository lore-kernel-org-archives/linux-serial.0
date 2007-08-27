From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] fix SERIAL_CORE_CONSOLE driver dependencies
Date: Mon, 27 Aug 2007 23:27:56 +0200
Message-ID: <20070827212756.GQ4121@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933094AbXH0Vby@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bryan Wu <bryan.wu@analog.com>
List-Id: linux-serial@vger.kernel.org

SERIAL_BFIN=m or SERIAL_MUX=m shouldn't allow SERIAL_CORE_CONSOLE=y.

Additionally, this patch fixes whitespaceinstead of tabs at the 
SERIAL_MUX_CONSOLE option.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/serial/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

d07b60e6784eb178d4ba7dd8ff9923f2e54d3ef1 
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 4e28992..7780d76 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -611,7 +611,7 @@ config SERIAL_BFIN
 
 config SERIAL_BFIN_CONSOLE
 	bool "Console on Blackfin serial port"
-	depends on SERIAL_BFIN
+	depends on SERIAL_BFIN=y
 	select SERIAL_CORE_CONSOLE
 
 choice
@@ -832,10 +832,10 @@ config SERIAL_MUX
 	    4. Change the kernel command console parameter to: console=ttyB0
 
 config SERIAL_MUX_CONSOLE
-        bool "Support for console on serial MUX"
-        depends on SERIAL_MUX
+	bool "Support for console on serial MUX"
+	depends on SERIAL_MUX=y
 	select SERIAL_CORE_CONSOLE
-        default y
+	default y
 
 config PDC_CONSOLE
 	bool "PDC software console support"
