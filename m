Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8FA41A55B;
	Wed, 30 Sep 2026 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751604; cv=none; b=FcBNFEu307Ue1yL25pINjM2dxmwaGR/GFvWnj4qwLbgEtfC3ngzBQHjVbgxfjwZhq/rOIT28Gko6rOGsdDZutLMMIKIrJ+XE66/wY6/S/8BELDlg4RkbhulH6Hvwb167B6TJt32Uuric32bBK8fY9BRL9H7xeomhecB1V9Q724A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751604; c=relaxed/simple;
	bh=LiAjQBHjVirdn0YRmRwgIbGnfAG7HvFyBQXHGccJw1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXi4UhtKR0IsnR3WB70DU5ddKFEz/knrbzevpKGYCsAyld2pAObLFHuMkE3TmZ+xxyvv17cOW+24552zc4L6clCaWbkceaPRup26H1OGbtV8XmeCeD1RWG3nAr7/fLkwfu5RKWk3aO4PfIo2nNoi+P88T7iL9/Prl0f3zkB7j5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4uku7+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4uku7+n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79E32C4AF17;
	Wed, 30 Sep 2026 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790751603;
	bh=LiAjQBHjVirdn0YRmRwgIbGnfAG7HvFyBQXHGccJw1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H4uku7+n6zNDE1CnDNdPeIEtzhoGnXnLGOKBObPMgCoBiYXwwsXqD4NVq9C34OQ+2
	 6UikhcJ+8pDXaaQlxYo2FuzJOvepwurvtTJNMJV7WKlJfTS/tuiV2Bal9vledDHPg6
	 8aTG/wTUCy25aUTaYx0GF+8DEzxo2mq043NF/Sy3qFxChqlBKwUZxPseIjOr4gCDg1
	 r8zhuRbYCXoyA2p3mvMeqDUiY85Ubhz1Xb5SS4rpzinkB68fZ5uI3ASU404FBOi7db
	 6caiZSHqp9TCSRm1bfTrM9YJthyhtZtrF1On4lU6lMv+UbL4Lg4EKjb+iQNm+afdgu
	 4HdbEx0pUJD/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58537CA5FC6;
	Wed, 30 Sep 2026 07:00:03 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Wed, 30 Sep 2026 10:00:09 +0300
Subject: [PATCH RFC 10/10] MAINTAINERS: Add entry for Cortina Systems
 CS75xx
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-b4-cs75xx-v1-10-4617c4463529@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790751600; l=1076;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=CR3H/exDhjF8FhcH6KCg+Z/+8Hyd2wHn7pcoqKD3Yt8=;
 b=TUl/S3W6Zlftmd5R5m5DaF5PeO3BAhZ4p3AtL9/1hsbMBw7Po9yNNebrJwW/aoPcYrhmJVzip
 ditmvJn9RzVCPqM7Gk5Pft4smiETHz2dXi9GFNEi5Hbf71xhXFVzXS+
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add an entry covering the Cortina Systems CS75xx platform code, device
trees, bindings and UART driver.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d137a33994..7ef9de36ffc 100644
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
+F:	arch/arm/mach-cortina/
+F:	drivers/tty/serial/cs75xx-uart.c
+
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 M:	Linus Walleij <linusw@kernel.org>

-- 
2.53.0


