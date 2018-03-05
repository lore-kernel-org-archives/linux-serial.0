From: <patrice.chotard@st.com>
Subject: [PATCH 1/2] ARM: dts: STi: Fix aliases property name for STi boards
Date: Mon, 5 Mar 2018 16:00:24 +0100
Message-ID: <1520262025-21088-2-git-send-email-patrice.chotard@st.com>
References: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: patrice.chotard@st.com
List-Id: linux-serial@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Since dtc v1.4.6-9-gaadd0b65c987, aliases property name must
be lowercase only.
This allows to fix following warnings when compiling dtb
with W=1 option :

arch/arm/boot/dts/stih418-b2199.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih407-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih410-b2260.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih410-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
 arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index c8ad905d0309..fa1186af6574 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih407-b2120", "st,stih407";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "console=ttyas0,115200 clk_ignore_unused";
 		linux,stdout-path = &sbc_serial0;
 	};
 
@@ -24,7 +24,7 @@
 	};
 
 	aliases {
-		ttyAS0 = &sbc_serial0;
+		ttyas0 = &sbc_serial0;
 		ethernet0 = &ethernet0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 9830be577433..00258212b6fb 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih410-b2120", "st,stih410";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "console=ttyas0,115200 clk_ignore_unused";
 		linux,stdout-path = &sbc_serial0;
 	};
 
@@ -24,7 +24,7 @@
 	};
 
 	aliases {
-		ttyAS0 = &sbc_serial0;
+		ttyas0 = &sbc_serial0;
 		ethernet0 = &ethernet0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index c663b70c43a7..3d122c3a1ad6 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -15,7 +15,7 @@
 	compatible = "st,stih410-b2260", "st,stih410";
 
 	chosen {
-		bootargs = "console=ttyAS1,115200 clk_ignore_unused";
+		bootargs = "console=ttyas1,115200 clk_ignore_unused";
 		linux,stdout-path = &uart1;
 	};
 
@@ -25,7 +25,7 @@
 	};
 
 	aliases {
-		ttyAS1 = &uart1;
+		ttyas1 = &uart1;
 		ethernet0 = &ethernet0;
 	};
 
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 4e6d915c85ff..8459a3766b7c 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih418-b2199", "st,stih418";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "console=ttyas0,115200 clk_ignore_unused";
 		linux,stdout-path = &sbc_serial0;
 	};
 
@@ -24,7 +24,7 @@
 	};
 
 	aliases {
-		ttyAS0 = &sbc_serial0;
+		ttyas0 = &sbc_serial0;
 		ethernet0 = &ethernet0;
 	};
 
-- 
1.9.1
