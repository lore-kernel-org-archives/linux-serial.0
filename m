From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Date: Tue, 8 May 2018 14:43:56 +0300
Message-ID: <20180508114403.14499-2-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508114403.14499-1-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: araza@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-serial@vger.kernel.org

Non-doorbell interrupts are routed through "shared interrupts". These
interrupts can be mapped to various internal interrupt lines. Add
interrupt properties for shared interrupts to the tegra186-hsp device
tree bindings.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
index b99d25fc2f26..9edcdf82d719 100644
--- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
@@ -21,6 +21,8 @@ Required properties:
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
