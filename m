Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795296963;
	b=CYJY8eq3XFeg5pq0qaD6OD0jCACtyuE6ObpSL3RCYze8PvtQmYWf9u2qAWi+xd7uXG1V
	 BE3i24TqEnJBNsuU42N+p634ehN/DnOMFJ9LcHo46qSv2ABvQI1doiy1PjPl3GJd25rxq
	 tk5tc5vHsDWT7W9ojmcQYeJ7Ybv3UdF7qiBkk+nxdVV5zlvQoJyhMLeyn/tltN3KgB4VA
	 Uizr4FF1nZRahY0fNZZO+VltCxuzZlVR7KLAW6v4ej1GWG0yMuPuBR35wiFd96Gukyilv
	 a8jK4i6V7B26ex6G7FGWUnPJILdsUlN4WUaqxDpmhXWcjJIEyyqzcSpHoiX/ZJmqcGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296963;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2CbMbhj1YJKeMqmSmi9IRjYMrfEw9kWn4Z0tl8AznQs=;
	b=RTHNKolnaBBQ3VwSGDu85bHhzyEhs6zqCU/9Khd5t3nt4zLou5UmUOwxv0dPDnXrXjOz
	 G9poosFhZuAlHZzSWq3SvEnN6lARlukIzgYpTS+R2Q8Sw4j9yuJV01SKb+fryK5N51Dwb
	 zneOaPXElnQUMlO3EPyID3VC8k3Q0EsJHsCSEQvTbJl2dB/596sPC88yyumleMgrEBI5N
	 Iqz71jkT8N3RQzQLmj9DA8420XN6K6gkWMONCv24v1bMGchdaZec913krtdFAadwY+yb9
	 uWtP6ZvzeQ56II+QXx2h3Kr0/tBD+2FKATU7thS1Mv0pFJ3WSYA04+UQMB1r1kVu/SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T/VOIttv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6709D606A696;
	Sat, 21 Nov 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T/VOIttv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795296963;
	b=uiZCGt9wBguinVMaExFl/aVX6OKk0zrKR7CRmTMbIbEFPzu4vnlCE/gfdAMI9X71ua85
	 2/BALtiNgjYSwwe4xuogo3f8n8drARJOXh7GW/1aF6SrGvDsmPlqIoUGKftDHtwWgMm9H
	 vj+b2eTMASIeA0YLesHQsSsUB7P6UYKjPQ3ddCOTF1EbHx5yg/8tyXsGeDu+hKDxH068J
	 emyh5RRRz5IAE8qz5xpzupv4iOejL17fac/dVcrh1eABM2+zQYDvD39swEClelFlv+2KN
	 trCLmSJ5pf7hgdSs9nmu5xFKsqtT2UXUYE6O+OmAgV+eSB7QOti0Ze+GWSdjweokhSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795296963;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2CbMbhj1YJKeMqmSmi9IRjYMrfEw9kWn4Z0tl8AznQs=;
	b=T+g/xkWUaUVXlTf95pa+cVIJSaGPIds0rwnnBcmOknRs+DiE0K+sD8s1RuSkOrbiyHkE
	 +4KYQsB/gGcUCKhUlaJJpNEXyKQ1IMMz9KU3in20C1oi4vk8hp/564vBRAbAzx5hlq+VT
	 pjQZsXEmp7/Y1Uk2BNZfMRRrW8i3M5uZluXrF5NicDX5pCts9O7RRt8YwmfzG4yn3ViI8
	 nLsymIeoDlRogkY8R8UqLFMWYLBPkVY2E6MW3wPZ0Uf2ZZDhNwnZ755WLVPNfeClUG/SA
	 4lxmYZduqbFaB1dftPj4m71CDSIYVxVR91a8d9H4oIz6h/UFCoT4pXtUbrKnuuo5HRQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2DB0A1F000CF;
	Sat, 21 Nov 2026 21:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795296963;
	bh=2CbMbhj1YJKeMqmSmi9IRjYMrfEw9kWn4Z0tl8AznQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=T/VOIttv0gYaozbnXxiWK8KHwTnMx6VPcrO+J///M09GPY/knguNZRtXBbBb5Y/I7
	 /5tzmh0nA1rvX9ItV/LDN+37qWf6V3WbHEfrI144GJTV7KRqZhfaMyfTig+HBT4GU1
	 a6UvHQFvnwudzhf2PUvj0DaLyV+b/RtcuYuMS0RPK/bM5bWB5M/8QbFSIRL4MF/uta
	 ERp2fWBt56ASqlpSs2X2f45ALpW2pbpocr6qTSirpb+M/mubwj3C0MkfUiQJeVvuHx
	 yJOmsA3c/PZHVTLt+gYyTBW7dvXp0hzb9fTmV/+TwF8uh3OesfyzUCD7Yp7os0N1Fm
	 MIEEbWt/d1qxA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF1904BDF5;
	Sat, 21 Nov 2026 21:35:59 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:35:48 +0300
Subject: [PATCH v9 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-cs75xx-v9-3-1fc1b90bd097@gmail.com>
References: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
In-Reply-To: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795296958; l=1316;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=2pJil7R2I4RJ4Qw+FGFzoukNOQ10CC3HjRA0bSlNdco=;
 b=Sq6SE3O2HKGm6YN5KuSwcD57eTipqmlH8pLho31vj7nWfs5gWIOBEJ83OETuBPSPl2/PIjIYK
 M+9rVCpx+CyAzxPDXSgldCnOSCiz7nRRJS2dWMHcUyo5ckUcyDh4PpH
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

On the CS7542 the bootloader parks the secondary Cortex-A9 core in a WFI
loop that polls a global software register and jumps to the address
found there. Add the "cortina,cs7542-smp" enable method for it and,
as with the other release-address based methods, require cpu-release-addr
to point at that register.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


