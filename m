From: Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for GENI QUP
Date: Tue, 22 Jan 2019 12:03:31 +0530
Message-ID: <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: georgi.djakov@linaro.org, dianders@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org, Alok Chauhan <alokc@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Add documentation for the interconnect and interconnect-names bindings
for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index dab7ca9..44d7e02 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -17,6 +17,12 @@ Required properties if child node exists:
 - #address-cells: 	Must be <1> for Serial Engine Address
 - #size-cells: 		Must be <1> for Serial Engine Address Size
 - ranges: 		Must be present
+- interconnects:	phandle to a interconnect provider. Please refer
+			../interconnect/interconnect.txt for details.
+			Must be 2 paths corresponding to 2 AXI ports.
+- interconnect-names:	Port names to differentiate between the
+			2 interconnect paths defined with interconnect
+			specifier.
 
 Properties for children:
 
@@ -67,6 +73,10 @@ Example:
 		#size-cells = <1>;
 		ranges;
 
+		interconnects = <&qnoc 11 &qnoc 512>,
+				<&qnoc 0 &qnoc 543>;
+		interconnect-names = "qup-memory", "qup-config";
+
 		i2c0: i2c@a94000 {
 			compatible = "qcom,geni-i2c";
 			reg = <0xa94000 0x4000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
