Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D823D7E3;
	Thu, 23 Apr 2026 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936064; cv=none; b=X09TUSdbmkQNZC1Szv9Q9fE875nkiZe6S/D6CoUMz+QrkADf0YE/9S2hQ+69HCuFPotg/C72omy9WUc7PsMzLNQt+Ow+ftp8w3DInCKnNxqai2fFjO2VqL12pBQrtAlXP5D0rB9zOtXGg5HPMy7yfIBBvggynXrSe5Coi68o1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936064; c=relaxed/simple;
	bh=dmYhvJWltKPlnfSCZp2xF0fuBjC8r/ExyToKNbYqzIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+KUzrYzF1L5AMfl/4XEXI6dlNlIPYeZUAZITxh7q95QjhMBSrfCPJLZzTf80gylqUbHx0MzePkQ37diKJiy+ABdFNJqVtlWmn5Ci+h9UCh64cg0oqzzRWFcHzHnLW0Yj3+BW5ChAGeKKXvnU6ZAo6ddi7WLoByjDWodibzpQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLQClddp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLQClddp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6111AC2BCB2;
	Thu, 23 Apr 2026 09:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776936064;
	bh=dmYhvJWltKPlnfSCZp2xF0fuBjC8r/ExyToKNbYqzIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nLQClddprkUVMKpVt9a2wE3m6hEOaiGh+oudHhAd4ZR6GYADl6LhrqOqLSJmen+o5
	 iYOlkt2iFzhnHDlYKjUsPvtuhP7MbsL2dM88SABoV2k468zhRYL3uXEZvNrrMzrdQu
	 8zVKVsdRrY2W+zr4V/Rmze91hnMB4CbQoC2Os8071td1/uNk5vdqw8QzICBIGRqlp0
	 Q6E3hSlv+o3WZXBOf8NYVlQBG+2IiiQTZ3pygxFbbvuxujfM4QI4JlAQ1x/xUQ8VWi
	 qVwWKy2hIRQFg4BPWWBPHUB7aOMrxEAh3xx5iklQNpBR2uk/vpJnBXB+y1IDqZty9b
	 LpZiUc99xuIBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1DDF99344;
	Thu, 23 Apr 2026 09:21:04 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 23 Apr 2026 09:20:54 +0000
Subject: [PATCH v4 1/2] dt-bindings: arm: amlogic: add A311Y3 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-a9-baisc-dts-v4-1-c26b480a068c@amlogic.com>
References: <20260423-a9-baisc-dts-v4-0-c26b480a068c@amlogic.com>
In-Reply-To: <20260423-a9-baisc-dts-v4-0-c26b480a068c@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776936062; l=1053;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=SsR9Sz9BWoMX3UnJeit5aTZNxRC651zrkqb0PjHBQcE=;
 b=2xZ4O+8hT57J5j91NjRw5Dlj2y5ZaxGMnY2QTx6MK38mhBHKj/hHbfWLmCzkrake3HYZa2jyB
 7MdBkibXn76B+MtEWX1MY8XNwaT0I6BERkjTEKukkzIOjde/TBgzu0f
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


