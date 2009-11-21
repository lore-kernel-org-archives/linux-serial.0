From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [RFC PATCH 1/9] Serial: Enable build of sc26xx driver for embedded
	platforms
Date: Sat, 21 Nov 2009 14:39:55 +0100
Message-ID: <20091121133955.16090.84664.stgit@srv002.fuzzey.net>
References: <20091121133951.16090.74411.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755365AbZKUNpU@vger.kernel.org>
In-Reply-To: <20091121133951.16090.74411.stgit@srv002.fuzzey.net>
Sender: linux-kernel-owner@vger.kernel.org
To: tsbogend@alpha.franken.de, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index e522572..d9a98d4 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1395,7 +1395,7 @@ config SERIAL_QE
 
 config SERIAL_SC26XX
 	tristate "SC2681/SC2692 serial port support"
-	depends on SNI_RM
+	depends on SNI_RM || EMBEDDED
 	select SERIAL_CORE
 	help
 	  This is a driver for the onboard serial ports of
