Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CC48F843;
	Tue, 13 Oct 2026 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871564; cv=none; b=gYTFLA/a0fXg4nBntq1qLixYhhawMMHcszn9ro2SpH2yyEq2pUTrhv8za7J1Sl5V7em7NoXI2fxLqaLHzZf6czk8gMh5XwnOrRFtOvmTEnqsFjX5EGJ0d7B4A6n+9d9As6yu2yt8n9SuguvyGutP2a3cMX0joWP7W0xw98XoSjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871564; c=relaxed/simple;
	bh=kbzWEJG3RS0uRhAVKboubU+SQaTYUAE0pi1FzWvqMkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qkmj6J7nwIUZwCQfRBfIOEbCtdD15c2qAPZOq5v0XqLZwT1CFARwSu8QNJuayCqDUzbL7bDt4Ah5Ft9zZhLRpgIowDFInc3VTykbG0YCZNZL9hHZZ3ozQ/OJ52PKwxCuBH3ajxRMlaqqD2/VpiyQs9qm+7/MmGI0ZZKfs/ua6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdrGo1O9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdrGo1O9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BBD9C2BD00;
	Tue, 13 Oct 2026 06:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791871564;
	bh=kbzWEJG3RS0uRhAVKboubU+SQaTYUAE0pi1FzWvqMkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mdrGo1O9oOYDxeUyEa8vpsnrzJvMew9fw3oMrtgrLQX4HPEPHZ23LmL6vru0Cu3xQ
	 sv4cx1LPsgBh7+Q1vauuAZoKlfIFCrjse5ZTsmXdZ6BcSUXJbiTFTwI94lGT0irz59
	 lA+nrSYbmvj3rLZ2qlj7oDzGAOpn2EEkCeWAJV4okOMWL5kFer3QmuG+9tB7QcKl/w
	 0pCVUVlFdxLoQKj5wwYunja1ElBtuNvtCXfjsTlzdKexUvYmoY8mq6C0j/TyhxkkwE
	 sbuadP9alZLPQ+Phi5yIxjMYkFmPLm1fbdOCMFzfrKD1cSnmiQCaG69yTb9Bzsn6Ba
	 t11DCbTQx+asg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D3BCC6B0E;
	Tue, 13 Oct 2026 06:06:04 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 09:06:04 +0300
Subject: [PATCH v6 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-v6-3-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
In-Reply-To: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791871561; l=1280;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=zDmn+esXces7eieK+stPpF5FV5ebbgc0xe7in2CfHQ8=;
 b=9LGV7UgybgYGhg9nQi5GUVPfuZp9V7a/Cqtl9cvzDgbBb/Jc4JXv+/2Ua8QzB1LXudinIMakB
 rvdu2GaHUV5AnjQh+QO6DqnSxONV2fgQ5PwFjGTskREcpb95NzKT22j
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


