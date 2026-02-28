Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017A39901C;
	Sat, 28 Feb 2026 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772265411; cv=none; b=DFSwx3cdcK5diiAfgaENm+X3FYNz/CPcCxMme9fkyX2dGI5kEVloCqAbLOWevdJMmN9/VtH2S9u6QhVezgAG3xFTHItjB1gcv9+vLA8p+OIh1Gzprzi7AM/5cKmN8WS5sIa2wjBVgHDhZEljzaBr+eSpFnO1pHvknAq3aQ5uwgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772265411; c=relaxed/simple;
	bh=OVzZ4dnEVWocRNtfND2tDhbl7RIBn27b3hByZQ/BmAw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g6NFvNJZc2UWMDcZw4UJSJuZjBp1hPpmuCRD2kOe0U5aVJk51ekcS/CEvbi12opHVe9iYi94KpT+Y6YTWHI7hY7BRAY4EKEzkT+Hw9m9TDD8/LXdkDvLwL6gejyKLCJauORRTJ0CfWvyQzHdKXUffW94lrnflAuoJ2iZoVox/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIfcP+q4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIfcP+q4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66F6FC116D0;
	Sat, 28 Feb 2026 07:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772265411;
	bh=OVzZ4dnEVWocRNtfND2tDhbl7RIBn27b3hByZQ/BmAw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rIfcP+q4k78lkohmaSrtESLBqm/EEuKHZhINLPjyN/U0bpfR8XfFSLJY14SIFbYB0
	 bmssZxLBf2jiNzARa1Efp2tWweQ8s5MBagKC/jxxaAvLGJHp5ObVHrkyzeQ6CW3+pb
	 5LXEeW1AQmGrm1v6ACksKjvyCF0srRciycqWHxN6/sATDgKNGtqvgvRqaAa2cCZsud
	 NSofUhGu5UAOX653MuCQwCJ+Llu0CHCxvaarRO9FVaeMyT4uoTWASWjMwIMb36i1L+
	 hdUwM88jvhJ9p1pTwvofklrfWN6/8LtN/xrsonSSVI01aiB1Yqibvu4zsEmfT3wjkR
	 BHmvnT1C4RitQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7D8FEE4CE;
	Sat, 28 Feb 2026 07:56:51 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] basic devicetree support for Amlogic A9
Date: Sat, 28 Feb 2026 07:56:13 +0000
Message-Id: <20260228-a9-baisc-dts-v2-0-47489d5cc1a8@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2fomkC/3XMQQ6CMBCF4auQWTumnQiKK+9hWLRlCpMIJS0hG
 tK7W9m7/F/yvh0SR+EE92qHyJskCXMJOlXgRjMPjNKXBlLUKFI1mhatkeSwXxM6ay0TK+1vCsp
 liezlfXDPrvQoaQ3xc+ib/q1/oE2jQk2a7KXxbW2uDzO9wiDu7MIEXc75C/aCAGGqAAAA
X-Change-ID: 20260205-a9-baisc-dts-cbbbe2e01f80
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772265409; l=1030;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=OVzZ4dnEVWocRNtfND2tDhbl7RIBn27b3hByZQ/BmAw=;
 b=LfbpQ1fdBBhJoJV0uW17gUrr4WPIh//xfGOnTRXHTvsk/AyKgS9It4f9KiyUA4g2mdNfhkwL+
 0vq6Q+WUSJ8DPR+KgC0bP5bGvdXPEQt2jdehos09j0lQ8nh42iP5zI+
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add the new A9 SoC/board device tree and related bindings.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- Move default interrupt-parent into dtsi.
- Link to v1: https://lore.kernel.org/r/20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com

---
Xianwei Zhao (3):
      dt-bindings: arm: amlogic: add A311Y3 support
      dt-bindings: serial: amlogic,meson-uart: Add compatible string for A9
      arm64: dts: add support for A9 based Amlogic BY401

 Documentation/devicetree/bindings/arm/amlogic.yaml |   6 +
 .../bindings/serial/amlogic,meson-uart.yaml        |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/amlogic-a9-a311y3-by401.dts   |  40 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi        | 129 +++++++++++++++++++++
 5 files changed, 177 insertions(+)
---
base-commit: e3194dfb772304a1b7ca3bcfccacefec3468b7bf
change-id: 20260205-a9-baisc-dts-cbbbe2e01f80

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


