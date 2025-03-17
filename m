Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8727701;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195815; cv=none; b=qGlEMBceqQ8nYcSka1UWuZxBydo0LKxUZoRmK1nhjp5qYmHSsgIsFhx/QEFwurBTudLwa8GNpEV6RlFAHtioEz+QWfeTYHTaIIRxoJPNIQ/Yd/Z+Nq2UUC+u442EFwHFPHY7fLG+0ONLuWRJTP4tSMC79ns7CBcBU7/Q2XEYDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195815; c=relaxed/simple;
	bh=vm35cYIdAhLZq9LNk3261kdI5GbsmTAMDzIyENxuRJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kY152CnxmkQcdx3ANj5bf5pXU4zJBGTxFFyikjmEaFZOdVpqbng1WJUYYUOnZmZfV9v4qsek7w692mDAYEVMpPcgOE6nvMzKCuCnLwVu3i09gtDsNOApdmM5psqUEFrVv7WQ5NBcIEunaw0YCs12A9M9oHlygICYoWSZ78GMtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuYRya4M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuYRya4M"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61D85C4CEEE;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742195814;
	bh=vm35cYIdAhLZq9LNk3261kdI5GbsmTAMDzIyENxuRJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CuYRya4MtqPW5aQokT/AowMMGNqOeVSyMdLBZT9ZXNYYfcxr8MyFqWWEMa9FDPXZ6
	 62GDvdbo0Sm9S4vusf2+wgYc+7xnHKOp+x6aVP81XDoVsZl0ltJSq1hpMs35x32O/o
	 xctFIBNwDGog2rMXRGSFnb9/T0QI+iVUfGRqrZehCQCl4UzkoatZ/EFCXQuIJMgkGo
	 dxgcDfE7He77+uyDL1MN+vITIG15lxrlODeR+GOTQ9R8KBhaJvCkw4nUSe+kPDCAwM
	 CAqkJvoz3DaLa7VSgn3uKmPF/0hxn9BGXvtSq8yClcZs9WtVNqfh2EqmGAJR3RM9Tp
	 lR//b8MvT4vGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CE7C35FF3;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 17 Mar 2025 15:16:52 +0800
Subject: [PATCH 1/7] dt-bindings: arm: amlogic: add S6 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-s6-s7-basic-v1-1-d653384e41f3@amlogic.com>
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
 bh=Wj7jFeJyWB1as0Aiyf81qr7pjy4df2QQR553NSdpnoU=;
 b=JrHEbgLFxYtq3HcI4cNA/1nztKjg13wf2WuB6PsRL0fk2ileEs2wg9KNTq6LoaPhb3MiMp7CJ
 x1cG10+F0TNCw7hdt91ntyn6yuWBsfRYag3hwNUMrQm+sTsuAr0zfcn
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the new S6 SoC/board device tree bindings.

Amlogic S6 is an advanced application processor designed for
hybrid OTT/IP Set Top Box and high-end media box applications.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 0647851ae1f5..67423c838719 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -237,6 +237,12 @@ properties:
               - amlogic,aq222
           - const: amlogic,s4
 
+      - description: Boards with the Amlogic S6 S905X5 SoC
+        items:
+          - enum:
+              - amlogic,bl209
+          - const: amlogic,s6
+
       - description: Boards with the Amlogic T7 A311D2 SoC
         items:
           - enum:

-- 
2.37.1


