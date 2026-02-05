Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF43346A2;
	Thu,  5 Feb 2026 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271446; cv=none; b=lFuNWoQrGE5zcf4TtY9u3rPYpLbo4kMQ/AEJxUDmcqdS6PgaX+DeXxon3LXJMMrurvdt24ZlTCHPA5Kmfc0mGLj6LmVVGFgEGcM1T2x5plTOYaHsLE1/in8Oco8pk1/fiadFjnW4d1xaKRrGHqiS7CIKa5aFk/OG/pWjHqADgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271446; c=relaxed/simple;
	bh=K9kgNOGc4L3iPmFJyzHMCUZIC9BQcUrCSOJH5wVch+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNYcy0Q4egh1NRiW/IyzoSSfTGSGQkIY/W1wyrLczicVIIPlPl03iPF5ZBxPmH/BGdFXKuOBHFBhfg+OmP8Sa08hw+WrIM8KnAeh+bZX401RW7fBAssZdVmgEviW4MeQ9VKUf8vKHRMoFeQK6S1LkU5GjXyLOawWXMj2xioiVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyjsQCpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyjsQCpW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0B7CC2BC9E;
	Thu,  5 Feb 2026 06:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770271446;
	bh=K9kgNOGc4L3iPmFJyzHMCUZIC9BQcUrCSOJH5wVch+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QyjsQCpWlpum+Oa2bQf19iN0bkI44uSRs6c7zUyTJ2QMOix8mUqlOQDqXxYoFMkuf
	 xdcrvWvPfnzO2mlsXz6zy5URhqFZ+UHogaaoTrssaRPzj+I+/41oP/YnC6eNMtjyou
	 i+QcUGbymb2xLgRqn/5Lg/Q5ljDWDJdUK36MG4L7JURcP2cqdcmV+aHzbqXvnvwD21
	 Aekd2ZTkIoSSB5NpCTw1u1XPvgdOYS5/8Jicb1eqVo07qL2Mi+E7Wep9Nn1Y6n7vUT
	 ykTspfRYsj3rT+QzlTk3odOpe4J9iVBF88laBdmDIhWj/lhUiGdM/p6cR74wzw3DzK
	 ov00sdo8cL6uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E477CE91264;
	Thu,  5 Feb 2026 06:04:05 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 05 Feb 2026 06:04:03 +0000
Subject: [PATCH 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A9
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-a9-baisc-dts-v1-2-1212b46f95a7@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770271444; l=924;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=RCJyzHs+o1Q4QHsgBLu74Jcqi27JmqRWixOLb0GImw0=;
 b=9Zs6E0IX/6RF0qH91Qy+YIFi1spTvkqTuhVlDJ6LTfSpAEC1qth+w636k9+VtPxzWdKVcSr15
 K78SBjYk7PbDQqVGXMBv16mWgjA3aQ0VplMhzboOOKH6TQ0qU35naHc
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


