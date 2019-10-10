From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH v6 1/5] dt-bindings: arm: fsl: Add the S32V234-EVB board
Date: Thu, 10 Oct 2019 19:52:24 +0300
Message-ID: <1570726348-6420-2-git-send-email-stefan-gabriel.mirea@nxp.com>
References: <1570726348-6420-1-git-send-email-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570726348-6420-1-git-send-email-stefan-gabriel.mirea@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com
Cc: jslaby@suse.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@nxp.com>
List-Id: linux-serial@vger.kernel.org

From: Eddy Petrișor <eddy.petrisor@nxp.com>

Add entry for the NXP S32V234 Customer Evaluation Board to the board/SoC
bindings.

Signed-off-by: Eddy Petrișor <eddy.petrisor@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1b4b4e6573b5..c211f4f82e25 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -335,4 +335,10 @@ properties:
               - fsl,ls2088a-rdb
           - const: fsl,ls2088a
 
+      - description: S32V234 based Boards
+        items:
+          - enum:
+              - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
+          - const: fsl,s32v234
+
 ...
-- 
2.22.0
