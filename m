Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BE38C2DF;
	Tue,  3 Mar 2026 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532328; cv=none; b=EJTvrNsBY0TU6VqkWb6lZCadv9Muj+s/WaR041Wjppuy5oazyMEakYdx413XUUABlBzb+rGy3dNmYss3nNM9/GzRGoPxMK2nOESHQNXxVOs4EMb86lHhTgzV/Q5qAgPeUAGBf7NI33SLGKpYsn5OoLE7oFFCAd+0IkY9OgE6ed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532328; c=relaxed/simple;
	bh=9dJ8qLLYIZAO2CG6AxPuvLdbo0/KEzaLIw6AaTJMJd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cu75CPHjQoYU2F4ODRXU3CCmRCbit+cNjms4qA95J+KFQ2XM5lQe6H4BH4hYvqpLMqcMHMG3tbCBy9nX8GIgzxi8GY/qlkR6Tu9Zt+x0pqNna/i3bfijaC0tFy+OIysNeDs80RWX0Zmje1VZe/V7CLLcr6LBY6HQF5LsUdCpwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNqIhFGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNqIhFGy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FCEDC116C6;
	Tue,  3 Mar 2026 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772532327;
	bh=9dJ8qLLYIZAO2CG6AxPuvLdbo0/KEzaLIw6AaTJMJd4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=tNqIhFGyv+8lZVoVDvwE8QvojLMCyfL2tmt84dEhbczmoEsco9rI+RloW/K61AoPY
	 6sf8b+59/9p6RLFKXl07xEJFLWUKPWBHUY9I0KSJ/Gy9CII0tdTm6BFSIrSqeifhfE
	 mOxZjcTAml3uhF+Hm+Ypjmvh8IKDOF+obV8bdNbWlrYziyaK3Zp4BGmzFb+LdWHLGu
	 u+jmEtA579IQ+hwWvWRaqQhgMqBL5HBtT2UaY4JqCZrnHkYqhrK0k99fBo16gRHDv+
	 p2zxJQOxQhCYbck+uGo/726uW4MMoBz9k8jgyNZrx9q0t4AyD+DQCEDPyHAGbex55s
	 H8IXvpS+PjfmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63220EC048B;
	Tue,  3 Mar 2026 10:05:27 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 03 Mar 2026 10:05:24 +0000
Subject: [PATCH] dt-bindings: serial: amlogic,meson-uart: Add compatible
 string for A9
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-serial-binding-v1-1-c3df2a8f6fa3@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAGOypmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNjXZD6xBzdpMy8lMy8dN20FEtDEwsTE3NDczMloKaCotS0zAqwgdG
 xtbUAB4QGzmAAAAA=
X-Change-ID: 20260303-serial-binding-fd9148447176
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772532325; l=1431;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=9mURwWMNKHKPj5DQwkxO2/oc3KhRCoTzoGeBobWkQYM=;
 b=JymmJL57wfD3WRuexnCQrwj4gWarkh2+sQtMISQ+nJ1d184MWywv+CAUTFEJ+63gky+C2/16m
 Q8gP9fwsZgFDGeltyP3ZIJJ6/77WPI0Z0i/jNaphv5N1Ab//xjCNCEa
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic A9 SoCs uses the same UART controller as S4 SoCs.
There is no need for an extra compatible line in the driver,
but add A9 compatible line for documentation.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
This patch is from the submission below(patch 2/3).
https://lore.kernel.org/all/20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com/

It is just sent again separately since it goes via the tty tree
---
 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index d8ad1bb6172d..a2702319685d 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -56,6 +56,7 @@ properties:
         items:
           - enum:
               - amlogic,a4-uart
+              - amlogic,a9-uart
               - amlogic,s6-uart
               - amlogic,s7-uart
               - amlogic,s7d-uart

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260303-serial-binding-fd9148447176

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


