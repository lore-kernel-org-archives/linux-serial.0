Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5B8F4A;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195815; cv=none; b=FRQcnauRiLkHEEck1tR4XsZLel/gDVh0rZnCi7/H0+Er4flev90zQhOVI/Qd22A5sMFtw+YnYKkb7Ho+FxfwvlCcl/eTouIqDaGxcaNpnlIAw8r+yczAbQPjAtrlTWqMCE6zRZGkkbxMAm2aYtHLSszC9CpO1nfwDMo2kEdSlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195815; c=relaxed/simple;
	bh=AtXdg7fv4Nvh7n+GmhWzaXo98BKNPF5xcm2CSeoK81Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZ+8XT2+wTP/G/+JDfJSUE+fa+FhI8ZdZ3tyPHc7hqcq8iU1CoIXrceNMOHOisb6+2SOLvLcKVDsb+g3eqBcfaPOz9sSCZwbB6byfFKqzDhB3ZmkMpqdcXTtAv9kVjFQYwBVtRAMscRrrYza37cz47b5U3OJ8dHEILbrBtdfAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiYcquXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiYcquXh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75135C4AF09;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742195814;
	bh=AtXdg7fv4Nvh7n+GmhWzaXo98BKNPF5xcm2CSeoK81Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QiYcquXhnB6J7dvuAwXo4q6mH7CBMF2bO75d2SOT9WH/NRbxBRv2GFg8cemgfkK0t
	 M+IFAC1Vls72trWUCv/uyZFce5NJIx3NkpkaJq0n5+UaRzW4LrUigcGAZMJNWPiUdV
	 q994nUkJb4scjDdGwmrXhVoB4OML2GA6T2V9lqVk+mpkxHtFV2jrw73+p9h/P4mCQp
	 jG65k0WRJ1OOYnjbOxUEkorADk9k1XfnJz4BVbi1V4fs6y4tJlhjO/lwKQG8IiilHa
	 z/e9pRWBU1iOPxFjQaXweb8zt8NoQJsqxPpQAXC6bt1cpDGIGWUp54+yQdpdX5tMOs
	 l+hoXgWVSRZbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B10FC35FF8;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 17 Mar 2025 15:16:53 +0800
Subject: [PATCH 2/7] dt-bindings: arm: amlogic: add S7 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-s6-s7-basic-v1-2-d653384e41f3@amlogic.com>
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
In-Reply-To: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742195812; l=998;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=SuYt3SPoeTkST/7nafCrM6pqpJlyHyKx8BG3DDj/KIA=;
 b=Apl3d1DPL3LCKBjCh3w+1SB/OltSWVfoAJK89P+JuF7UlqiWMsvhkKSRjlej6mZJz+XoLE/dE
 Dx023e0I0ubDS4+CB3oiimPfuxp40XlQVf9xgWxR4gjHlPALJs4i0vJ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the new S7 SoC/board device tree bindings.

Amlogic S7 is an advanced application processor designed for
hybrid OTT/IP Set Top Box and high-end media box applications.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 67423c838719..9a6e98b55685 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -243,6 +243,12 @@ properties:
               - amlogic,bl209
           - const: amlogic,s6
 
+      - description: Boards with the Amlogic S7 S805X3 SoC
+        items:
+          - enum:
+              - amlogic,bp201
+          - const: amlogic,s7
+
       - description: Boards with the Amlogic T7 A311D2 SoC
         items:
           - enum:

-- 
2.37.1


