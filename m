Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795294937;
	b=mD5Q0Mzoa6eRg5Iso8c3qBk70qlOAYkZ4BKAQ+y9EgOmC/02N+IuXZK3RUZRNVnESKOu
	 XtVIrHUCSbeLTbtZG4OB0mPIGHDkawzY3ibzlalMs4qo4/WimWEeIWJ4Ce3gsbZVOwtp5
	 vGoev0T3jkGD5DtKW8niL/V8yrUbwZWt/LBRgz3bspkKaFS+++g+I3G//5Q5iam1vdmrE
	 WOGpUK74Jm79ZOWtijABc+/HPTghhtPLwbi4H2bqgIdK7jNGCXzcMxsYHFGDhiss/U+iF
	 dv63rjmylXum5+JgGZV86AjgyTFl/0WdSdipn6vNWo8AuMyGoMEqbM5o8Cqhdjugh6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294937;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=La2K15nDGTc5QdvSUYADH/M3UC5c5ws+911+TdMxDuM=;
	b=KKTE7hP40CHyj/1X7WfvoxyiG0hfEjsKrCFGrOnQaamFy1qCs22Z7ChbSqm02MTZwf1/
	 zyojDTJ0kv0cWQWpV+5zHz46eat0Yg55Dv3kl3t3b7o6rwzps7FrMkwIy5QM5n2AXMOhV
	 P/in3O6Q3ea8PJQ0pNU1IcKuDy/Df4ATzH19hIizDOPl1xxNiEtMM3PYzphIRNXEB/v2Q
	 vCL732sBeP3t+kJD+D/lYPXEM03tkfuprJbO62nX3ZnOldZygVAHxl/GIq0p4uDLI/4/4
	 uTJX8HPilNaTWhcnv45UVrvLRO9dvu4Q74pvWiyUFYz7S3Nj+Y0iVMO1BTPS+45zvZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoDvZ9jK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32CF606A69D;
	Sat, 21 Nov 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoDvZ9jK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795294937;
	b=dmUfLDP0Fmnu1hI/Z6XGxF4Y9BTUDoZPwjeZ7ZZ3UR9+VEZzejz/T1twhsApS87vwv04
	 cAgmKLAI7evCWftAWkP73dfDuYotQXp2Tbv7mErpDGoL5fM+xkbkzUILmn11TvO0/TvBT
	 ZqzHKlKwh9avh/y0ZVAYmV+5VKqUfakUy2i16rtcVID1LA2kHO+PGbyA30ff2i4VPYyHp
	 XL4yKR9dCddV5hPvCsGrFgw8Xy6EhJPNqiY8CxDzTF9VTlA+2H1DqUD8Om/7k2Z+5yVz5
	 7W8iQzRFdAP074liTvaIort+aFXKyIyMkRkLbF4phE2fhV0JWfsgXs5gTLqjKLpttoA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795294937;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=La2K15nDGTc5QdvSUYADH/M3UC5c5ws+911+TdMxDuM=;
	b=LULoYJO71vY4OO2Z3CXIDoZ7nwzqw/J0ejPUbB3OWGrbG0JXo8Ra2Wh5gVdfc3iu00AN
	 6wb1hP5VTZRuFBDEHNGYuXffCvI8iOWI9ktw724EpaKiHrzwt2PJKByvf2rYZefPS6cr5
	 ufrkQvZBora05CQQ9OnoxuE3wqbK/xkQ/ShHWSMqN+Gh6YzfhEk1CZRUJsEJdHs/74Yaf
	 vARXL/Z1ihgXXzpmSZKplBqeuJycW6xmaflt0Y3cwqGvc9AQ+NTO9v1LUEjiIpg7Nw6mH
	 rfF+nct5VMHbFbQL7k3APSWf/RjK/BqL48VJZ7MygCUN1GUNg+pHrqGLo0o0qomzLLA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DEF351F000D2;
	Sat, 21 Nov 2026 21:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294937;
	bh=La2K15nDGTc5QdvSUYADH/M3UC5c5ws+911+TdMxDuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YoDvZ9jKT3rilfKg9+ZzUqcJiC2ClE3ZfNOeuGmDkZcIsjfhBh2vWL6g78MOgw7ga
	 uNjjzgTGGbUZ5xvDcguM2SJQhc0PD16GgnU4FrwLgx0jcBAHhf3ESRpRI+3cWYR1zP
	 JQweXUPy9TitwdxNf6dH8anmO+voeUAvYE7iAajjIp34XL+PV9HCLgjpH2/W5T8PBS
	 eG8RNy/YE5CbuAyyLs5P3QubQ+Uizo20hTB7qyX70IsoErBRoEm2em4SD/Jd4HIlg3
	 Kkqvnrc7AeltrEcoSDq6hRzA9ilq/qzGz6xVjb0lmdCN/pMxPkVgk2ReziKRlMa3/b
	 ZCtpE/YArbF6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3E1C04BDCA;
	Sat, 21 Nov 2026 21:02:12 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:01:55 +0300
Subject: [PATCH v8 10/10] MAINTAINERS: Add entry for Cortina Systems CS75xx
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
Message-Id: <20261122-b4-cs75xx-v8-10-5f971b0dc69c@gmail.com>
References: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
In-Reply-To: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795294929; l=1124;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Kv86vwete327NDTNam7eZzSsG2pJVcHBfV+Z7+P5PJ4=;
 b=T6gapxMc4xFsr7/3sTZXvWhELPnQ1tchYsr4K9QMYEetJB4wCQjf5XKc404fLs7AsmUDnmgoI
 lViaO9eBq4dCI5Cma4jw6qGwsysMF7tbAniD8wBnPkfoWnlZdbv1FoK
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add an entry covering the Cortina Systems CS75xx platform code, device
trees, bindings and UART driver.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315..deb2ca570 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2950,6 +2950,17 @@ F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
+ARM/CORTINA SYSTEMS CS75XX ARM ARCHITECTURE
+M:	Fil Dunsky <filipp.dunsky@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/cortina.yaml
+F:	Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
+F:	arch/arm/boot/dts/cortina/
+F:	arch/arm/include/debug/cs75xx.S
+F:	arch/arm/mach-goldengate/
+F:	drivers/tty/serial/cortina-uart.c
+
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 M:	Linus Walleij <linusw@kernel.org>

-- 
2.53.0


