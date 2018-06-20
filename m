From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 2/8] dt-bindings: serial: Add bindings for nvidia,
 tegra194-tcu
Date: Wed, 20 Jun 2018 15:20:36 +0300
Message-ID: <20180620122042.10950-3-mperttunen@nvidia.com>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180620122042.10950-1-mperttunen@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Add bindings for the Tegra Combined UART device used to talk to the
UART console on Tegra194 systems.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v2:
    - Added Rob's Reviewed-by.

 .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
new file mode 100644
index 000000000000..a8becf6efd2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
@@ -0,0 +1,35 @@
+NVIDIA Tegra Combined UART (TCU)
+
+The TCU is a system for sharing a hardware UART instance among multiple
+systems within the Tegra SoC. It is implemented through a mailbox-
+based protocol where each "virtual UART" has a pair of mailboxes, one
+for transmitting and one for receiving, that is used to communicate
+with the hardware implementing the TCU.
+
+Required properties:
+- name : Should be tcu
+- compatible
+    Array of strings
+    One of:
+    - "nvidia,tegra194-tcu"
+- mbox-names:
+    "rx" - Mailbox for receiving data from hardware UART
+    "tx" - Mailbox for transmitting data to hardware UART
+- mboxes: Mailboxes corresponding to the mbox-names. 
+
+This node is a mailbox consumer. See the following files for details of
+the mailbox subsystem, and the specifiers implemented by the relevant
+provider(s):
+
+- .../mailbox/mailbox.txt
+- .../mailbox/nvidia,tegra186-hsp.txt
+
+Example bindings:
+-----------------
+
+tcu: tcu {
+	compatible = "nvidia,tegra194-tcu";
+	mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
+	         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
+	mbox-names = "rx", "tx";
+};
-- 
2.16.1
