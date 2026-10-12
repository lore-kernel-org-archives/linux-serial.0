Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC14BE457;
	Mon, 12 Oct 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826277; cv=none; b=d+jcRQOxLTabMiTg/D7WVsBT1s24QMYOFKO/eLBC9L2FkxPvQw30ja9F4g/d6zuG9nu+Wg0ScqOYhagE1cD0OGJmWNyLxH5ZUWlzTRP7pH+mqSLV+0asZnCYqMtewJHELssKGFwsGs8YyGi0eKG9UZQgAODZkjfLOaU85H7ANVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826277; c=relaxed/simple;
	bh=kbzWEJG3RS0uRhAVKboubU+SQaTYUAE0pi1FzWvqMkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SO7Q6d+9qCuKf0+Uh6Htgl76iTPc8ZusZw5QzS2CbXu7BBAq9+E8UeMcxThTPpFXmqT05cxOAYyrTLtAKL+O+VksAvT8CmcZkYAXwYkzZcjrM1r6lubg5zOh+gInxNTgnFHPEqyjsSb1NarbRHMcNmcPMk5ViddoE6osL0q0mZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsJEVF03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsJEVF03"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77A92C2BD05;
	Mon, 12 Oct 2026 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791826277;
	bh=kbzWEJG3RS0uRhAVKboubU+SQaTYUAE0pi1FzWvqMkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JsJEVF03Xz8dqTAxdRvssQd9z/8cgxGeZKYmEzaI+iFOxe5WpVx84uwEmtyEAAHUV
	 phFqLSuF036Z945E4sQMV9/k1X5ufphC02CC2fLdFHA1yX3pBfivxEoKaCr0s8iXIv
	 SskIKp0sU43smoB9AU9d0a3cpMVrS/u985qf9S07Gw3Yn3RDPr0bnYtuGoi/u+T6JV
	 AMx4WA+dM7T3F5ZNvQqj4PfRLtn+xRq2AuyroOv8PhamofVLeKsrkzNyOQdkEBblnT
	 fVnHSCqVmoZbGsYVT+YNJ6s3xoSz5+CM2qtSDlae/e5MR6CVxjTuaRDNK0JFYzdMsq
	 CcUi3kYNL6Pfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB85CA9ED1;
	Mon, 12 Oct 2026 17:31:17 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:31:17 +0300
Subject: [PATCH v4 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-b4-cs75xx-v4-3-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
In-Reply-To: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791826275; l=1280;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=zDmn+esXces7eieK+stPpF5FV5ebbgc0xe7in2CfHQ8=;
 b=bMhS+FwAEWOLWMu5qm+wilIo7udsaPzaTZuJVYrYmvHxjygkGP2cbamqGwXggwmb4p2iM2QUf
 L9PntJwNiBmAlQiN0FjPSWHhhNTIwIvNtEgtPJwdoWdXBubWTAV4jsF
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


