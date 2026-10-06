Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C149DBA8;
	Tue,  6 Oct 2026 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310662; cv=none; b=jbCIW8Cm0d6qVdF2Z5pQ97N30nQIMJ+tXOJNgT8vxngBVqFREdNy9Ug/yw+YtOr1kHxbZqUo1RGoTePX1uV+HWlnZ7I/E+m4XiJmJHtvwyXTW6PPkLGBN1SC7ei/wlCsWrpj7Tml/uGWBcX0DYSIpodEY+ZAFTeRK/iUce8kti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310662; c=relaxed/simple;
	bh=xNzlYm8hBtZ0j1oUxttURUDwmWfHwPAM0RqNrSVT3Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HelkLlU++A2Ds80SfE776UDX8zo/uQQM9YL+IQRUhAIhQQeu9kWgrzsf+twMBNE6EIjXRCEHwuDmK4Tg1BzFn2DEZvjOYFwvnae72gqcWcGrbevfpH9zZWhkLG/XLZXwtkpkSSnf7q//EB45aVcNpHX47bzu9cXbYdjxBxLFud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOHNI1Js; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOHNI1Js"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 134CFC4DDE3;
	Tue,  6 Oct 2026 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791310662;
	bh=xNzlYm8hBtZ0j1oUxttURUDwmWfHwPAM0RqNrSVT3Nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JOHNI1JswonYkBZR8qv8zgMSvNTPs6qnAXF0Wb4tCGcUwhTwHkB7WJxb3Cg0N0Ua2
	 wd5wfUcp90cet7SNmybTUK+rVVUnRfL9nIps7Xmp9QNXSMq18R+DLNraNqs/bpnkVU
	 tILAwxr62qMedJRM6+4277V7z0sYGS8JD7GRV08Wh+8R/ijumVicoMXRRlSO4qFD5q
	 GDjafofhlbtAKVsECO+Qa8AWhH9jLlKipWiuu2ihb++110vmKpVf5LDNmu6NuG89JN
	 6Rw81X/bw2Zb+ahQ66i2loa+ihbGQMc9MXJwFmAqSd2fQyMDjpkwjn2riCwy/bqb4a
	 Xb87IA9UwkXWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86EACA5FFC;
	Tue,  6 Oct 2026 18:17:41 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 06 Oct 2026 21:17:41 +0300
Subject: [PATCH RFC v2 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-cs75xx-v2-3-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
In-Reply-To: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791310659; l=1284;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=5AOAXUzosKDZHEZDxcfOQyKy1cJHFyhzY9zM3eY+qh4=;
 b=gVrT17FgKfjAEvCGctHj4jEqCwLS5ymZqdKA3kSE/W5iI8BbwUPsm6ywHxkDHlKNnKO0xOhAn
 utYo3yGaVocDeYNFWkg1Ho5UtMtqSaGVo2gG7W/eLbyHroDIsRkxHPE
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


