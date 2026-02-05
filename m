Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E773346A7;
	Thu,  5 Feb 2026 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271446; cv=none; b=cHPQhNnewQQUhL/uzCupl0IeTO7zjT3mZBz9xmzUjdA4LpEsDGnlTeA5vuOOqWtztMNpGkJ12SKe4WEV6jsqwPc36lexEbqvY0aJv4ep+zPnoyK7NOMS1ET6UGOVTEBKn41++PUmU0VwPidAeaRJ2omKJwRsHhymZcA5CUx73r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271446; c=relaxed/simple;
	bh=/8ctvmeakP5gITWGA22K/VCIdEe+GIFB4PDMdxs3dp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHnONGCLTtcwTgzR7mUGPdIMjCMxHcTFS26i1BZ3R84IaBTsEA71vsl6Uk2323qU8MVwelpsvE1R8RHf4+80Q42mdtRP719QKDYq7j3sRnaiUhqTSQagJ/OjJbJYhLmN8Z5GXcIZJTf+7o30lr7JyvDDfFAx66ZHuEMtLDLx0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG7KJzR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG7KJzR0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBDCFC2BC86;
	Thu,  5 Feb 2026 06:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770271445;
	bh=/8ctvmeakP5gITWGA22K/VCIdEe+GIFB4PDMdxs3dp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hG7KJzR012Lijpw41otOqz7SbvorehYF9I6tR/Z9zYZ3JSGlBecOb9zfcxLjvVBJ7
	 qay2Z1iRzGEzmayI3AkiSQPXRC3cf84En/lz9bpLht33UDoJdCgj10C9S1NWOo+sFF
	 2I32D+Awcj850x8uPCmEJ0VZjOvS3wUqQbs5cSqzHySsGCpYsklaP37hDKxjra7/vk
	 vZBHiQbWSD4tHXu8B2S/XbVKbSQaggcZsRNHDtx1pl6dSHY8883UvACYZ8JOPdt3dw
	 JM7kTfU0bEUa6lCqizMhMU7uWDOu3JJRlJSnKrxiU2Oq+njkW1OmPADp8Bu0NJMpdK
	 UCZ/sUUelWlyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA284E91261;
	Thu,  5 Feb 2026 06:04:05 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 05 Feb 2026 06:04:02 +0000
Subject: [PATCH 1/3] dt-bindings: arm: amlogic: add A311Y3 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-a9-baisc-dts-v1-1-1212b46f95a7@amlogic.com>
References: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com>
In-Reply-To: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770271444; l=912;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=YqKkQKMdwWrvKEAOSja6X/Z+UdrbQ8sFtcO8Ce9oL3I=;
 b=t44pqp/4M5L4gAGj+JTodZvhV2jIt+7dz9SMNGrtRJc2H2Nh+Yw5T/GhK8Zo7sPh5niDd86Rh
 7dmN4TRwzgODz6OfWTPQK9clndrnTuuYvs8ANoGMZbEhul0DmHMAimk
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add bindings for the Amlogic BY401 board, using A311Y3 Soc from
Amlogic A9 family chip.

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


