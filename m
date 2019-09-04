From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH V2 05/12] dt-binding: serial: tegra: add new chips
Date: Wed, 4 Sep 2019 10:13:00 +0530
Message-ID: <1567572187-29820-6-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Krishna Yarlagadda <kyarlagadda@nvidia.com>
List-Id: linux-serial@vger.kernel.org

Add new compatible string for Tegra186. It differs from earlier chips
as it has FIFO mode enable check and 8 byte DMA buffer.
Add new compatible string for Tegra194. Tegra194 has different error
tolerance levels for baud rate compared to older chips.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
index d7edf73..dab31d4 100644
--- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
@@ -1,7 +1,12 @@
 NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver.
 
 Required properties:
-- compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
+- compatible : should be,
+  "nvidia,tegra20-hsuart" for Tegra20,
+  "nvidia,tegra30-hsuart" for Tegra30,
+  "nvidia,tegra186-hsuart" for Tegra186,
+  "nvidia,tegra194-hsuart" for Tegra194.
+
 - reg: Should contain UART controller registers location and length.
 - interrupts: Should contain UART controller interrupts.
 - clocks: Must contain one entry, for the module clock.
-- 
2.7.4
