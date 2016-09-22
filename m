From: <tthayer@opensource.altera.com>
Subject: [PATCHv2 1/4] Documentation: dt: serial: Add TX FIFO threshold parameter
Date: Thu, 22 Sep 2016 14:56:14 -0500
Message-ID: <1474574177-4984-2-git-send-email-tthayer@opensource.altera.com>
References: <1474574177-4984-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474574177-4984-1-git-send-email-tthayer@opensource.altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, lftan@altera.com, jslaby@suse.com, arnd@arndb.de, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, yegorslists@googlemail.com, matwey@sai.msu.ru, mail@maciej.szmigiero.name
Cc: peter.ujfalusi@ti.com, jonathanh@nvidia.com, dongsheng.wang@nxp.com, luis@debethencourt.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, tthayer.linux@gmail.com, tthayer@opensource.altera.com, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree binding needed to support the TX FIFO threshold
parameter.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  Change parameter name from tx-loadsz to tx-threshold
---
 Documentation/devicetree/bindings/serial/8250.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 936ab5b..f86bb06 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -42,6 +42,8 @@ Optional properties:
 - auto-flow-control: one way to enable automatic flow control support. The
   driver is allowed to detect support for the capability even without this
   property.
+- tx-threshold: Specify the TX FIFO low water indication for parts with
+  programmable TX FIFO thresholds.
 
 Note:
 * fsl,ns16550:
-- 
1.7.9.5
