Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477843859EB;
	Tue, 13 Oct 2026 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863166; cv=none; b=XpvuVvV/rKqZKAqQab0IvtfbpleCVSImX9qYMvrdbbO5hxUW1yBjsYBWS+g8Z40g/TGTG7xlKDW3TdpRBALVZ7246Y0IbIo3MzSw6/GRjc7jUZEFF5hg5yp7QQ5/4Ggg1N945YBhL2q0sS+k/TzttzIsDx2YK4K4Wslrm0ZsB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863166; c=relaxed/simple;
	bh=kbzWEJG3RS0uRhAVKboubU+SQaTYUAE0pi1FzWvqMkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abX2WfcVxMb8jqy3AarVehXYt8pXf1SHsSBW2aMOwWkSPIqn5zDI+y/VMjVswNtq6ncqtHWGCjKK0Ery29zGjKcoi/0IhTdLX/L8f5CABlyZ6dkffhYxkfJMd/N+Mv7xqQ4btKY3nqXAqwh7ZPelAK55CJOB7JiUrwwKEoLMD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+jsmyVr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+jsmyVr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF5ECC2BCFD;
	Tue, 13 Oct 2026 03:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791863165;
	bh=kbzWEJG3RS0uRhAVKboubU+SQaTYUAE0pi1FzWvqMkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K+jsmyVrwBxmJXXa5jnK6y+9yPjIPqA52EkB/ejlC3RbaKStkmUleK/+kf3Ieo7bA
	 UFM1QX/SawRATv0W2d6q3Tgqrc7WRsyiT3Ijz7OuHSlmMFuO8abgVRcVXt+kO2Fb53
	 cW4Gro/Pqt0HdewkBu0CNfNrRT0Sj4POwGx9iCE73pVpPC4k4TqCEkX585Qa/sMJfR
	 KyvyAHn/PwRLmtkT9G0vjj83Or+vF7ljdMlUDxyRj3zUErs38SyeeAwW3vyOS13esG
	 3GJZ5UvD+454flj69lwh9A0TKbApXwzhL4rkSW8wmPaKd/LnPW0iQlJQGffkS5PMx3
	 U2cIqN1UuHf7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A049CCC6B0A;
	Tue, 13 Oct 2026 03:46:05 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 06:46:06 +0300
Subject: [PATCH v5 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-v5-3-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
In-Reply-To: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
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
 Jason Li <jason.li@cortina-access.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791863163; l=1280;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=zDmn+esXces7eieK+stPpF5FV5ebbgc0xe7in2CfHQ8=;
 b=sTeD9+Q8xSJusPWUSgycCMgDHn0q5b1tBSWFfhcKH4Mq4KeZQ+vYah9qbVFyY5Cioh7jX10U+
 Lom84BvRQCXBoG3VY//MAfS7tS37rZaTK1SoZQ2Xx7tAPX8M8ZCljlN
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

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 96136b70d..7a394c500 100644
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


