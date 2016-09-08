From: <tthayer@opensource.altera.com>
Subject: [PATCH 4/4] nios2: dts: 10m50: Add tx-loadsz parameter
Date: Thu, 8 Sep 2016 11:12:21 -0500
Message-ID: <1473351141-9239-5-git-send-email-tthayer@opensource.altera.com>
References: <1473351141-9239-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473351141-9239-1-git-send-email-tthayer@opensource.altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, lftan@altera.com, jslaby@suse.com, arnd@arndb.de, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, yegorslists@googlemail.com, matwey@sai.msu.ru, mail@maciej.szmigiero.name
Cc: peter.ujfalusi@ti.com, jonathanh@nvidia.com, dongsheng.wang@nxp.com, luis@debethencourt.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, tthayer.linux@gmail.com, tthayer@opensource.altera.com, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

From: Thor Thayer <tthayer@opensource.altera.com>

The tx-loadsz parameter sets the TX FIFO threshold level of
the Altera 16550-FIFO32 soft IP.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 arch/nios2/boot/dts/10m50_devboard.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nios2/boot/dts/10m50_devboard.dts b/arch/nios2/boot/dts/10m50_devboard.dts
index 3e411c6..6be1502 100755
--- a/arch/nios2/boot/dts/10m50_devboard.dts
+++ b/arch/nios2/boot/dts/10m50_devboard.dts
@@ -83,6 +83,7 @@
 			fifo-size = <32>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
+			tx-loadsz = <16>;
 		};
 
 		sysid: sysid@18001528 {
-- 
1.7.9.5
