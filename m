Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C018024;
	Fri, 18 Jul 2025 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851115; cv=none; b=NCXogkD4cFMUpo3SoB8PpZmUdD/jnyPOehviGh5NRndBGAtYQTi/kO4uVmpybD0uBqAHHLiO0ay9hBQm6ZkI793YDaWqM2IYmAqzT8tkMUkvG64fMfATn6oKA7i/haBzpDrvVaWAVXOQudQeidaBVnqTDhAxWRmF1GZjDDdkR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851115; c=relaxed/simple;
	bh=z5nzeOJWQR/Lo0Neg/++bHT0b0RJvmY2gZnAWASGbw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BscTXKVCRBHTBgheVbk+Bso38iH5BTKs10TydMoLz14cSTIZLI6AlBCFayXpSICuEfpEoXqDPPrFdkpNc42pJwKLm0eglIhURcjLLpiIHLktgh7fnRCwWa4NvDtEghTVFMRmxrl4UGe+SDadZHbvvg8k2EpQhcjovRLAJ7YUSy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 39350335DBA;
	Fri, 18 Jul 2025 15:05:08 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Fri, 18 Jul 2025 23:04:37 +0800
Subject: [PATCH] dt-bindings: serial: 8250: spacemit: set clocks property
 as required
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-01-k1-uart-binding-v1-1-a92e1e14c836@gentoo.org>
X-B4-Tracking: v=1; b=H4sIAIViemgC/x3MTQqAIBBA4avIrBtQIfu5SrSwHGsILLQiCO+et
 PwW772QKDIl6MULkW5OvIcCVQmYVxsWQnbFoKWuZaNalAo3hZeNJ04cHIcFje06MxnS3mso4RH
 J8/NPhzHnD4xyaCxkAAAA
X-Change-ID: 20250718-01-k1-uart-binding-6a996b6e2ff2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Alex Elder <elder@riscstar.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=z5nzeOJWQR/Lo0Neg/++bHT0b0RJvmY2gZnAWASGbw8=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoemKhu7vmN4TWmEvIpf6rS0cOUqAVIxlZjiV1l
 Iw/+y0hGlOJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaHpioV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277QwxD/9nW529zHpmqRW9pt
 C8kft28pmDPm5VspeYejobS1RqEXsDQxqc5lX2lYd77tX3pz1vD3t2PZWYrrOS3IRS7xad7xD6P
 y+8yj7TgnW9cRG3H4sQGE6wwI0bUycxeI9gUU314ZkuoESGJoEFOrS6BwrTGsuk6xSwv+SLPU5o
 fok2lvIPkefdL4y/RpxX9u7vQhrvyiwJxRrzNweXr2SztBhjMRlHf5JwwsbVmXByO8r/pm1FcRh
 nlWFXJyqPsaz7cIrewKxC2Qk/ph+CttRfEKpzU+3K2Ow9SghxklmESkSCHBM8lGSLnorzdqC8N7
 qZaxsI2hXgcWDuK4oX7+3co+EF6wrX/KIxcgk7Gr6drYLnnORKHesrq0eGaxS4Zup3DTOfIibtE
 waVgE9N15C3OMIbrDcx2Wbl9AVuaRfaSxoggmyWqfbbgre/t5/a6k5pgBsiyYh2JjhL4Q5YqDXX
 Y/vrtIMI30iYAcJBHrxNTzxeR6lK6bY4lg9cQsfh9Ch/yP81UPv8KICTo0ahjZxCkEyViM3NiIo
 AeIuFv/DKl1BMTRCF7SC1wYsrGS1rgtLQbddCyFicnCGB9X/jDjI/ihfJhX4H9zjcTo2CmyBSU8
 ZBx/ZWllNfCXF/jBInW7eMRnBAS12FyQa1c/iAC+DIJJsqIm9f1wTC5t/NH1lTneJMCQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

In SpacemiT's K1 SoC, the clocks for UART are mandatory needed, so
for DT, both clocks and clock-names property should be set as required.

Fixes: 2c0594f9f062 ("dt-bindings: serial: 8250: support an optional second clock")
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 33d2016b65090d0df257f9780ad8d5e05f7ce798..2c7604ed2a41d029276d3ebe9a3960a8dd44a9d9 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -239,7 +239,9 @@ if:
       contains:
         const: spacemit,k1-uart
 then:
-  required: [clock-names]
+  required:
+    - clocks
+    - clock-names
   properties:
     clocks:
       minItems: 2

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250718-01-k1-uart-binding-6a996b6e2ff2

Best regards,
-- 
Yixun Lan

