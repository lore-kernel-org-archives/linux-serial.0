From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 03/10] dt-bindings: tegra186-hsp: Add shared mailboxes
Date: Mon, 12 Nov 2018 16:18:46 +0100
Message-ID: <20181112151853.29289-4-thierry.reding@gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181112151853.29289-1-thierry.reding@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Mika Liljeberg <mliljeberg@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-tegra@vger.kernel.org, Pekka Pessi <ppessi@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Shared mailboxes are a mechanism to transport data from one processor in
the system to another. They are bidirectional links with both a producer
and a consumer. Interrupts are used to let the consumer know when data
was written to the mailbox by the producer, and to let the producer know
when the consumer has read the data from the mailbox. These interrupts
are mapped to one or more "shared interrupts". Typically each processor
in the system owns one of these shared interrupts.

Add documentation to the device tree bindings about how clients can use
mailbox specifiers to request a specific shared mailbox and select which
direction they drive. Also document how to specify the shared interrupts
in addition to the existing doorbell interrupt.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- describe in more detail how the mailbox specifiers are constructed
- encode mailbox direction in the device tree mailbox specifier

Rob,

you had already reviewed this and I've kept your tag for now, even
though there have been slight changes in this. If you don't mind taking
another look to verify that the changes I've made are still okay.

Thanks,
Thierry

 .../bindings/mailbox/nvidia,tegra186-hsp.txt  | 30 +++++++++++++++----
 include/dt-bindings/mailbox/tegra186-hsp.h    | 11 +++++++
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
index b99d25fc2f26..ff3eafc5a882 100644
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
@@ -29,12 +32,29 @@ Required properties:
     in a matching order.
 - #mbox-cells : Should be 2.
 
-The mbox specifier of the "mboxes" property in the client node should
-contain two data. The first one should be the HSP type and the second
-one should be the ID that the client is going to use. Those information
-can be found in the following file.
+The mbox specifier of the "mboxes" property in the client node should contain
+two cells. The first cell determines the HSP type and the second cell is used
+to identify the mailbox that the client is going to use.
 
-- <dt-bindings/mailbox/tegra186-hsp.h>.
+For doorbells, the second cell specifies the index of the doorbell to use.
+
+For shared mailboxes, the second cell is composed of two fields:
+- bits 31..24:
+    A bit mask of flags that further specify how the shared mailbox will be
+    used. Valid flags are:
+    - bit 31:
+        Defines the direction of the mailbox. If set, the mailbox will be used
+        as a producer (i.e. used to send data). If cleared, the mailbox is the
+        consumer of data sent by a producer.
+
+- bits 23.. 0:
+    The index of the shared mailbox to use. The number of available mailboxes
+    may vary by instance of the HSP block and SoC generation.
+
+The following file contains definitions that can be used to construct mailbox
+specifiers:
+
+    <dt-bindings/mailbox/tegra186-hsp.h>
 
 Example:
 
diff --git a/include/dt-bindings/mailbox/tegra186-hsp.h b/include/dt-bindings/mailbox/tegra186-hsp.h
index bcab5b7ca785..3bdec7a84d35 100644
--- a/include/dt-bindings/mailbox/tegra186-hsp.h
+++ b/include/dt-bindings/mailbox/tegra186-hsp.h
@@ -22,4 +22,15 @@
 #define TEGRA_HSP_DB_MASTER_CCPLEX 17
 #define TEGRA_HSP_DB_MASTER_BPMP 19
 
+/*
+ * Shared mailboxes are unidirectional, so the direction needs to be specified
+ * in the device tree.
+ */
+#define TEGRA_HSP_SM_MASK 0x00ffffff
+#define TEGRA_HSP_SM_FLAG_RX (0 << 31)
+#define TEGRA_HSP_SM_FLAG_TX (1 << 31)
+
+#define TEGRA_HSP_SM_RX(x) (TEGRA_HSP_SM_FLAG_RX | ((x) & TEGRA_HSP_SM_MASK))
+#define TEGRA_HSP_SM_TX(x) (TEGRA_HSP_SM_FLAG_TX | ((x) & TEGRA_HSP_SM_MASK))
+
 #endif
-- 
2.19.1
