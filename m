Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794663673;
	b=K98XHG0B5FOhidfA9D2JVQJQGDznbOaBAjUpF3wf095t5RpJq+ZFFkmpUYgE4Cc2BjYQ
	 CvjOP7jiyg6HYwlaG6PYqcl9FsrsBcHBDQ0YBQChoH5tafrF6MfN5jPII6ruVXvGyuZCR
	 +3Ax+o+GGORQoJPdUdm1BdhnHMUQbMIE88IeGUxJwaZP33z5UT7LswzQ99vDxy6T20nK/
	 HdUgLBdkDkUthQdVK5ttLs52ZfE8tD9ee37ecnbdO+6qb+DO4a27WD42VtorolDc5STbX
	 kVVaYBLNslyCK67z/3hjBKw8asVTxRkJDigi5MPkpHp034osaqjUePRd+QVQ95C7lsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663673;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=La2K15nDGTc5QdvSUYADH/M3UC5c5ws+911+TdMxDuM=;
	b=M1jvZLsOhFyryxuDs0kc/iE6Kf87d1UhDi7LIicPYYkqtCLb/0HDeyE+lrc8bFe9xVEo
	 BknXI7b0IkVoTABSE78zl0NpvEw8pqxP/x3zVUjeHptv3ZvAfbQBDk3hVZ8g1T1WDV7ua
	 ZtzrUYpM2ozcx1zPkV9cOmIiQvB4bqvsY1G8bDOOgnrkfX1Z6fHmvNeWMcY3pp2bqSyDb
	 wFFGeLJNDJZeJDqKlzGcA16a5hYexDRembrfeu0Mrw4I9mU8Q5UxBDWHr/kaaQtoyD6q0
	 z0v0RK75riFHpkDj0FhwamlngUq9STYewMiIem68daYXC72iqN/NQhOsWjv94Xtnr6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inwP6GsY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80123606A8AE;
	Sat, 14 Nov 2026 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inwP6GsY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794663673;
	b=Te7Wp/vfzYxzQnhXJtFrlHJTjhqjUT7yUMvHsYlth6C199qgx85s5jcS52/sSMMpKBtG
	 IFCLn2haLRwOSa42uzsRTCystE4qYBVlKUaZXrgx9E7RFSMQ9+75vmvsx5o16mYqN4cGe
	 i5cxxcPWEhzx7VhL08UcXYy7mPtGslqhRAODeAIKqNGVXqRf80VGyl1vEkW19UPjXNgmZ
	 5ErRQqDq+2OVki3CGhb68TxX0ft961QTClCewoNsPcw+CQS2/qoFg8TfLbJqo7awRJj3I
	 b3uBVKsb0CcL26XQKSq8WvitN+8Cox9JyaICCMoPvQetxt856Oz3sx4k1rHRPhFUYcw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794663673;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=La2K15nDGTc5QdvSUYADH/M3UC5c5ws+911+TdMxDuM=;
	b=iyUAIz+WJyltdTydrGtQFb6oib6kbyChBdmxExzhw0rs/T0QifidwaVJX5n8i7iaV2jA
	 6Xf7OUfxrLy6vreCACci/XnY7bJY3uhRcqpNkrfmKu9jrVSme4RibXhxI55WtBXTpLHG4
	 GJCrAgzvoW4IVjJvPm0bRE1xSckjzXN8SZ1BTHO5uUKndmf/r5ssooNWgwlpYEost4PmD
	 Ugg9tbMHTNFkM42D7AG7WeUGIBYYXiQ9gMfxx9LaqmL7CePXFFLQifaALeulINVtxfksx
	 t2mHcpkrzQBALsGTc7RO+kdUnkA6tZJtcGXzToNhU5dj8uOHSjTChNUqEw77pIXIWgw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7BF871F000CD;
	Sat, 14 Nov 2026 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663673;
	bh=La2K15nDGTc5QdvSUYADH/M3UC5c5ws+911+TdMxDuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=inwP6GsY63kgRyoN2NK7vrDU5sKhI2v60hVzFNVPz4G20pRSSb3fFQpGuSpv6IAWh
	 P4mt7biYeLJVWLOBo3u4nES1fdTDrw+RSiOOp/6oiytool9Womvd06+dQIV0u3/Dfn
	 OZ/PoOfdcXTl/NP+n62m0s8O0/ynhYtIaQBbJxZhEMprfcjUCW4/yDpgtCM/zymxuT
	 KyW5XxjaUMlO3EGWN654wXtE5feu16bo/EE8nYBq5ntSHc3sV3h3k2Lbm3VoITK8CH
	 9QH7b3BxUXhMgVY6mDDu9OXsmrP1nQoTaCikZry+oGPaxpZBnwerS2zy/pWNQBubGJ
	 3iIT+gguPZMXw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DC2B449DE2;
	Sat, 14 Nov 2026 13:41:09 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 16:41:15 +0300
Subject: [PATCH v7 10/10] MAINTAINERS: Add entry for Cortina Systems CS75xx
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
Message-Id: <20261114-b4-cs75xx-v7-10-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
In-Reply-To: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794663665; l=1124;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Kv86vwete327NDTNam7eZzSsG2pJVcHBfV+Z7+P5PJ4=;
 b=m2had9+YtFJAFxsUTBdOtFg+zAyQGUi9ToreJH5JmO741fEqcImTkHNVWv6nPWa1K5XeYAxCB
 pXdOPXJ7JNUBFWgI+hCrYNJ9sUH5cvLHmV0g7+fHRBUHuFS9ZBYXU3f
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


