Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE4493D49;
	Tue, 13 Oct 2026 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871565; cv=none; b=S9Wc7vREV1Ttu6nGLN9i1CnF76jQ9kdv6bK+4P1K+mYigwHkD/aVLL/IBqIAPhiy80KJDc5+Kp+aC8hxkubdi7MpfkL4puQLc1SJDIccrphSW6vz5lLE73cDTVUEe1lIVecFUVVk7c1V6QSoD1CXl/PITDYMSJlx8Q6qMKrqopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871565; c=relaxed/simple;
	bh=GCubckKkvtS/EOiOIxWc0YpDQoyEYzgiiDMrguNF01I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3QcAHiwxZFGcZ92ijpptsndL2dBKIiUdOjUtcxkcxAi11Pot1CnlSyJRT9XZmFW7gI0sTizQa9itj/oTFZjbBg72CZ5n9tsCjwuwYPRqlhQeD5RRImrYZT3oFoariV3g8oYioQvNBq+bXMryjYfA5V0+nOhmGWNtOpTFzFjqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3SqOs6N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3SqOs6N"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5CEFC2BD05;
	Tue, 13 Oct 2026 06:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791871564;
	bh=GCubckKkvtS/EOiOIxWc0YpDQoyEYzgiiDMrguNF01I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g3SqOs6NLzQD48/dhjDm/OyNn+i/4ddae7nPTq4svH7IyWCDG96EcNpcsGvlWoryT
	 DznOaDgn2tRq3Rf1va11pe9rw06OpdVo6m5o1SMDitSIFG2Eh6hUovfSkubguiI9N5
	 fMr48fZnKB1x4MA0ewEOUJE/vvqQbtIrK5+APN2Gvzha92dkJC0zBqD28vsqCXiot6
	 RIYAE3z1DXvR+bWo/pxukQ/BOxO2k6mMlHOkHLAQAzwOxLKaBbVW9Y0bKPoJ2C89Gl
	 AtdSm982HE54aeodxiU450hbPxPcr8MFXBTpaFWZqV+R7Zg2qUpTDqlme7wprrg3bB
	 +w1nRZsCWHENg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E4ECC6B03;
	Tue, 13 Oct 2026 06:06:04 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 09:06:11 +0300
Subject: [PATCH v6 10/10] MAINTAINERS: Add entry for Cortina Systems CS75xx
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-v6-10-37e8f3969b7c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791871561; l=1124;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=NwAetqwg8dZTsEYKE0lK90ntL9PQOHqCts3OMdvEgqE=;
 b=xo1XP3gkLC0HMoVbk0evrUE44urUoG5F0+NhAqZiIU9oWTAlaj4RtvuCI/Ysn+QNQZJe4Y9MC
 SS9P1Z2rrCFBQy/QE4nGUgGPPmCek+dcBfzMwbFigui1ogV/PpBxpG5
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add an entry covering the Cortina Systems CS75xx platform code, device
trees, bindings and UART driver.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d137a339..176046436 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2914,6 +2914,17 @@ F:	tools/perf/tests/shell/coresight/*
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


