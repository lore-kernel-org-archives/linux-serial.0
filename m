Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED078F59;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195815; cv=none; b=bD+PCbViZQu9AM9wjx1rxnlstWfrxktWznZ65dPZFffCtCPOXoec0LsIoys18FmR52ynxm6CT9itH+YpGOPa5DGJ3umKlSMrPOOws5pGkJECdSPJRzA48qiNdpqJsIjTwUxi1QCq9BTjfFEiffAFQPu8KomcBhzmlM3i1Mn5XlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195815; c=relaxed/simple;
	bh=oxoucKNcYzlokTUMj0RVOyzYN7CVa0nZcJ14gXbMUjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZ7y+yrTjk8BbC0BmFl2rU3D4GhBZMiNoIQpfR93sOSNpbYRiSfMTc6LHzXlv2PA9ci+rOsjqB/I7z64ps8gnXSi6rnbpcOzIoKfWFdH+TexfgLdirqIjtDBMayGNOeB6C8Avtfm+qPP/P+v3E+XFAr8i6Mu2K9mrjiXrd4uF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwKLSESh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwKLSESh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E058C4CEF5;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742195814;
	bh=oxoucKNcYzlokTUMj0RVOyzYN7CVa0nZcJ14gXbMUjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cwKLSESh3mV4ir0uJW47nVWadAarSWPK/0+sHQ8lb7GazxW9bwSFR0IujDOmboaHy
	 MDciwZQ64UrI98ObW78jIBEqf3JDJsrwkrpYR50WIgKkRw4hguv+v2em9QD7jdhQGA
	 +SzdqOWy2Dzk054JZ3dZPiCllQ48Zvzs4LQBk3+41Kdo/GZH1ixby3+mKUnXzNvajT
	 IYkjoRljboobMOvimGdgjC848p5RlCwzlvZI5NyKNGBXFb0D8qFxeq0uwj7S3rgpyy
	 MPZktxMiyPRJ3aGwfEQBVNnKfgoNyjHS+VnsfMLYzHmGggdbfI+TaGB9/AvqP/4cqi
	 h9/dRA3qdlmog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E38DC35FFA;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 17 Mar 2025 15:16:55 +0800
Subject: [PATCH 4/7] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for S6/S7/S7D
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-s6-s7-basic-v1-4-d653384e41f3@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742195812; l=995;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=8tWndSz2wgG4AKPpBkmzvXgp+1cbCi/8NB7D0Mgsh2s=;
 b=oGCmPQDQlNKAJdrYHGunPq9vAAqeWtaF/57Ac1nzwBMiRecNx7K5knkP/r7VuG6g1CavemmhE
 s6r9Mv9O4g6CvZVdRwyi7GI4Y+Y8Th7g2vtT8rIXbQA5R59TNBzWjGM
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic S6/S7/7D SoCs uses the same UART controller as S4 SoCs and G12A.
There is no need for an extra compatible line in the driver, but
add S6/S7/S7D compatible line for documentation.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 0565fb7649c5..d8ad1bb6172d 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -56,6 +56,9 @@ properties:
         items:
           - enum:
               - amlogic,a4-uart
+              - amlogic,s6-uart
+              - amlogic,s7-uart
+              - amlogic,s7d-uart
               - amlogic,t7-uart
           - const: amlogic,meson-s4-uart
 

-- 
2.37.1


