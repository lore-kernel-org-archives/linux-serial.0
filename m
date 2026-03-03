Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474CD39151C;
	Tue,  3 Mar 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532389; cv=none; b=DzlzAfNys6TGFLZaTpKLStUvIqKCED/U8APfhizjt2iKQRwYAZ2cpisijDrEiryv37lsdm2i8A5yu8ZjSIXJgwgH0r/8K65eXjQNvb1SwAtaYKL2xskZQ4mVsJwsvYQMPRiuItcod7i4KYz9BWUjBmPvVt1FpgjMbMvoh4vvaQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532389; c=relaxed/simple;
	bh=dmYhvJWltKPlnfSCZp2xF0fuBjC8r/ExyToKNbYqzIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnJkhQCrhmuaAVG+ztCyGC88cDkNlAwCnnKs05J9o/0LTujd/hBuZb9zqlCJQEb3t0xgwARYUv2vicoIqwm31P1CZAB8qtg/q584qW46HJe3ojwyPNyhbxh1X7Q7JbzU9t2M4ak0h6caMIuJ4sGQWo16VBISTAxNSb73rae79t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaCu4tr4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaCu4tr4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4905C2BCB0;
	Tue,  3 Mar 2026 10:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772532388;
	bh=dmYhvJWltKPlnfSCZp2xF0fuBjC8r/ExyToKNbYqzIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GaCu4tr4gHStrYmUr3vpeilOFdpP/e11urbg7vsICcdResCJ312luR7rjX8JOHmND
	 Ii8g2UbIZaXjLyWatOAqesMtCBmg++cCxfmBwlD+V7P4gYRA085bTnTocyvZk3ZBRY
	 SeNZUDGz5cHOU6zyHqwH1MYj7QtSOy3kUChbpskXqHP4KAb0d7JfM2RrCqYDwCX6Ut
	 sEjRdEALm44/2IHwMXcGoZkrvRs1gA5W3vmKFgd/xGnFeb/+lEyHsZY6x133QzyokK
	 HfsufFlQv9ZjohU6KE2IAdWRkvdnJQoEsLtTcMfcSSfDEovQSoSCv311kR9RCv4wLA
	 my5x/iv5e6OWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9ABEC0489;
	Tue,  3 Mar 2026 10:06:28 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 03 Mar 2026 10:06:25 +0000
Subject: [PATCH v3 1/2] dt-bindings: arm: amlogic: add A311Y3 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-a9-baisc-dts-v3-1-4bf21001f05c@amlogic.com>
References: <20260303-a9-baisc-dts-v3-0-4bf21001f05c@amlogic.com>
In-Reply-To: <20260303-a9-baisc-dts-v3-0-4bf21001f05c@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772532387; l=1053;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=SsR9Sz9BWoMX3UnJeit5aTZNxRC651zrkqb0PjHBQcE=;
 b=NFoRKmD3u6sSIm7NWn9KHotS0WxQi1TGq80Xn2VsUKbbuGLGd2AE0zC3w6hhi8VgBr20TiT53
 c7tDv5UZdz9AX2li3cdUvptGm6qqwWQ86piLrNv2C6uGN6g5focMtpt
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add bindings for the Amlogic BY401 board, using A311Y3 Soc from
Amlogic A9 family chip.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index a885278bc4e2..9f73a0054fb2 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -234,6 +234,12 @@ properties:
               - amlogic,av400
           - const: amlogic,a5
 
+      - description: Boards with the Amlogic A9 A311Y3 SoC
+        items:
+          - enum:
+              - amlogic,by401
+          - const: amlogic,a9
+
       - description: Boards with the Amlogic C3 C302X/C308L SoC
         items:
           - enum:

-- 
2.52.0


