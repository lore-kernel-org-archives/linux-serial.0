From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Date: Mon, 2 Jul 2018 14:40:26 +0300
Message-ID: <20180702114033.15654-2-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702114033.15654-1-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-serial@vger.kernel.org

HSP interrupts can be routed through exposed "shared interrupts". These
interrupts can be mapped to various internal interrupt lines. Add
interrupt properties for shared interrupts to the tegra186-hsp device
tree bindings.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v2:
    - Edited commit message to not say that doorbell interrupts cannot be
      routed to shared interrupts.
    - Added tegra194 compatibility string.
    
    v3:
    - Added Jon's A-b and Rob's R-b

 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
index b99d25fc2f26..620c249363ca 100644
--- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
@@ -15,12 +15,15 @@ Required properties:
     Array of strings.
     one of:
     - "nvidia,tegra186-hsp"
+    - "nvidia,tegra194-hsp", "nvidia,tegra186-hsp"
 - reg : Offset and length of the register set for the device.
 - interrupt-names
     Array of strings.
     Contains a list of names for the interrupts described by the interrupt
     property. May contain the following entries, in any order:
     - "doorbell"
+    - "sharedN", where 'N' is a number from zero up to the number of
+      external interrupts supported by the HSP instance minus one.
     Users of this binding MUST look up entries in the interrupt property
     by name, using this interrupt-names property to do so.
 - interrupts
-- 
2.16.1
