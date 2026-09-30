Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745B44F56D;
	Wed, 30 Sep 2026 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751604; cv=none; b=uFaBgFB7pPRJGvqZqsCEHqA5UjTmfCDbf4pqIcsduvviDHW/LGYkg+f0OdzPgV3XialTYHBWVTjL1w57e8YG5d3jTOl+729SbwsChYX3s9mqgL/KZVsqSd5pG0M0riKSe4v91VpHzZGxqGwMDx0KBGp8cUh8AC/h9rODAWB1XTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751604; c=relaxed/simple;
	bh=me0/GaYRhRGsLTRt0o/xOAdYgAPd8saMs5gs1pazfMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbQX0Y9DN6UT0/dddcjqoW1UbeKTDtRUFuEtct5rSKFP8Hw+YdI92+Uf2KpfyxU9T3zP+JzdH/8zEZhZyCk6TYSwhwLmG316Y70H0fL/yV0fP/0MHthph2dy001MxtWfr6QRCCBAtAazp2XhsXkwxMn0JuWSr9ED0Y0/ewLLYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBiiYx1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBiiYx1i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0F0CC4AF14;
	Wed, 30 Sep 2026 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790751603;
	bh=me0/GaYRhRGsLTRt0o/xOAdYgAPd8saMs5gs1pazfMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eBiiYx1iUpFLgCs3jPyyLsZR9BoZkOENFXPvq3ecvlkQNGSeSI9XWjINwi7BrTAdp
	 55IgCDowjZJjY3pPgWvzwrMoPILR41AIfffMjNYCVZVQ0YGTx8CgoQY5K1V0vg9iPp
	 g6Hop6zLVODjowEapVFM/1RPcp8KB6P7hmWdVSRLC/ZjZa3EPF++b0Gf0k9cyXZ/Od
	 WdmT7LsPkYoKNkWvx4PWQ4Ak/qtwR9oXmOXRx4gn+kyc0eszAwRvc6t7wyMtqaHbD3
	 naZqyen/S57ZYy/PFrRus7h/YKQEPSquC72/73x9JAztVR+ayXQeY8HFAfHLhkryGa
	 Qfh2XOeslNuwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC888CA5FC2;
	Wed, 30 Sep 2026 07:00:02 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Wed, 30 Sep 2026 10:00:02 +0300
Subject: [PATCH RFC 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-b4-cs75xx-v1-3-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790751600; l=1236;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=zHs4d0oCr/fkCjW2IncoLpYzn3PsYpvSJVPGzM+249Y=;
 b=5NGp1Z9mv2h2Aiqk1msw4SDQyLOh8bIopneUpk9z2/71v/F+jOsc6UszjLI5N6VAxuYLJ8g2j
 aJRpOJj1wZlB3JO04HulAycLiCjFcGXIKZCahBcJ84HQ+Wlbe5HNL3d
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

On the CS7542 the bootloader parks the secondary Cortex-A9 core in a loop
that waits for an event and then jumps to the address found in a global
software register. Add the "cortina,cs7542-smp" enable method for it and,
as with the other release-address based methods, require cpu-release-addr
to point at that register.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 96136b70dac..7a394c500d6 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -269,6 +269,7 @@ properties:
           - brcm,bcm63138
           - brcm,bcm-nsp-smp
           - brcm,brahma-b15
+          - cortina,cs7542-smp
           - marvell,armada-375-smp
           - marvell,armada-380-smp
           - marvell,armada-390-smp
@@ -484,6 +485,7 @@ allOf:
         enable-method:
           enum:
             - spin-table
+            - cortina,cs7542-smp
             - renesas,r9a06g032-smp
       required:
         - enable-method

-- 
2.53.0


