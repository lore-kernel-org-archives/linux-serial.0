From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 15/16] h8300: dts: Rename the serial port clock to fck
Date: Thu, 19 Nov 2015 19:36:12 +0100
Message-ID: <1447958173-543-16-git-send-email-geert+renesas@glider.be>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The clock is really the device functional clock, not the interface
clock. Rename it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/h8300/boot/dts/edosk2674.dts  | 6 +++---
 arch/h8300/boot/dts/h8300h_sim.dts | 4 ++--
 arch/h8300/boot/dts/h8s_sim.dts    | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/h8300/boot/dts/edosk2674.dts b/arch/h8300/boot/dts/edosk2674.dts
index 4ce9fa874a577e55..6ae884bf66a5268c 100644
--- a/arch/h8300/boot/dts/edosk2674.dts
+++ b/arch/h8300/boot/dts/edosk2674.dts
@@ -88,20 +88,20 @@
 		reg = <0xffff78 8>;
 		interrupts = <88 0>, <89 0>, <90 0>, <91 0>;
 		clocks = <&fclk>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 	};
 	sci1: serial@ffff80 {
 		compatible = "renesas,sci";
 		reg = <0xffff80 8>;
 		interrupts = <92 0>, <93 0>, <94 0>, <95 0>;
 		clocks = <&fclk>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 	};
 	sci2: serial@ffff88 {
 		compatible = "renesas,sci";
 		reg = <0xffff88 8>;
 		interrupts = <96 0>, <97 0>, <98 0>, <99 0>;
 		clocks = <&fclk>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 	};
 };
diff --git a/arch/h8300/boot/dts/h8300h_sim.dts b/arch/h8300/boot/dts/h8300h_sim.dts
index 545bfb57af9a9f2e..9c733d920f1f0dc3 100644
--- a/arch/h8300/boot/dts/h8300h_sim.dts
+++ b/arch/h8300/boot/dts/h8300h_sim.dts
@@ -83,7 +83,7 @@
 		reg = <0xffffb0 8>;
 		interrupts = <52 0>, <53 0>, <54 0>, <55 0>;
 		clocks = <&fclk>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 	};
 
 	sci1: serial@ffffb8 {
@@ -91,6 +91,6 @@
 		reg = <0xffffb8 8>;
 		interrupts = <56 0>, <57 0>, <58 0>, <59 0>;
 		clocks = <&fclk>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 	};
 };
diff --git a/arch/h8300/boot/dts/h8s_sim.dts b/arch/h8300/boot/dts/h8s_sim.dts
index bcedba5a3ce7e8ae..97e1f4b17ef067d5 100644
--- a/arch/h8300/boot/dts/h8s_sim.dts
+++ b/arch/h8300/boot/dts/h8s_sim.dts
@@ -87,13 +87,13 @@
 		reg = <0xffff78 8>;
 		interrupts = <88 0>, <89 0>, <90 0>, <91 0>;
 		clocks = <&fclk>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 	};
 	sci1: serial@ffff80 {
 		compatible = "renesas,sci";
 		reg = <0xffff80 8>;
 		interrupts = <92 0>, <93 0>, <94 0>, <95 0>;
 		clocks = <&fclk>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 	};
 };
-- 
1.9.1

