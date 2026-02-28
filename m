Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D005C396D28;
	Sat, 28 Feb 2026 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772265411; cv=none; b=g6/I9JnDoEsiZgPB1rJ6Ke1lduXxNu7xrJFGIC6ZQCcE6qSg7HCIwb0zDUt1CjDY0Bc1CdTUOTVD1EX2vSqctUG1CIDTVvZRYBkn0LQGYzDjNj+VIj1T+J9dskNV/vDQpizrbw9TtO3mZLdYUjZVIacKCOTG9oxVvWhQUXQkxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772265411; c=relaxed/simple;
	bh=1sDzeoes75xwXJ7VUGZIFhW7VWqP9FhBjTm8+3+hMtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o7tqODLOpis+1+Hi7MefcAhSKJJandbo80cL93c2U2SIAdYliDMxF4fmZs8Gr8fzCVof/vvbKIdUe1GsdBA0njtDD5vrua5tKnoJNVRg+aKndlLe6o9fbkOGfaCEX8dlHaHQO4kFPkcos4dGtfeFO/qgkuSqNvpSnKkw4823/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ty0EuTiu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ty0EuTiu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B6ABC4AF09;
	Sat, 28 Feb 2026 07:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772265411;
	bh=1sDzeoes75xwXJ7VUGZIFhW7VWqP9FhBjTm8+3+hMtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ty0EuTiuKuqBzCk7UooM0bEhZi9vQm6n+Ipb52bnkGlYc+m/8FXUf4fiWhDGpQm9C
	 I1zCM0t32fyaBkgabNeHE5MMfZ0o2tHSCcJtrhpdOdX1jHMrHbr7CW8fsCKCFL8fe/
	 nYWk3VcUkcJStT8t2Qjs/Y8qrGM5xML2rjoMYw+1HyUC27aRf5/izrb1adLrLNHVs3
	 +eXQwJHBM1KHxBnAmpqyiU01+otwhwx7RMmkYJMMXvJVZ6JE6O8eRvlNcVaRfTZz6x
	 /e6QAs62fAR0eB/qPkPzhIqNL2zQ3vBKIukDhBfzUAWsMbYnGy6tGiO7w+PlzPV1Ab
	 y0Eb2PK5tFL/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7D3FEE4CA;
	Sat, 28 Feb 2026 07:56:51 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Sat, 28 Feb 2026 07:56:15 +0000
Subject: [PATCH v2 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A9
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-a9-baisc-dts-v2-2-47489d5cc1a8@amlogic.com>
References: <20260228-a9-baisc-dts-v2-0-47489d5cc1a8@amlogic.com>
In-Reply-To: <20260228-a9-baisc-dts-v2-0-47489d5cc1a8@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772265409; l=1065;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=GG2+tqcGh5gPHmuDgyTzLzwkbN2gsDbUKOMY7yAnDbc=;
 b=SdE8J/H9E6GHbGZm3hRNHAiA920OOqHG2MVxfERGdlqZ3fenopSCmEzxuw9oSbCnD+angO5Lb
 R+igIGF/be0DIriKSjtzT+WsJ7jsJrwrC3GW7+5FOzgq1y5LZ1vuXyQ
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

-- 
2.52.0


