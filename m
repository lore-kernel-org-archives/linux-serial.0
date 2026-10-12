Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E54436377;
	Mon, 12 Oct 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788313; cv=none; b=M4VqiFK8hpAe89Tst8Wx4MR1BFnebeTdXB+IRlW7m2YSQSxUlXMtZJ0l6LLPq1qze/O4l4hDJ+DXFM2TswO00ZgnQeEQS7ZDQUfpCq0OK/sqjOp6LDivG+nIz/idOo4phGvgXPnhKca5wYyosYn8HaXgWpS7vj46ApMlfFSy//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788313; c=relaxed/simple;
	bh=FGdKrLdjAm6HnyfgClKCSC4phcR13IbYQ7jKtBJyQUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lci7F54S/wtlbzXcNXQT2TmRz9YJX9Cbnpko0TMLQfGfB1ne5xA2kRHTCH/mGNFbFpmNwFYz7SnAhPXkjlwUDrvfe9b9X21Ngbxso5KaFZhPTxh6pvPQjhOccG6eiMESIFMwKlEYQpP62AKTQqft7ekMjhvo5OWu3RhcsFM/kTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2+ayVTN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2+ayVTN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04B4FC2BCFA;
	Mon, 12 Oct 2026 06:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791788313;
	bh=FGdKrLdjAm6HnyfgClKCSC4phcR13IbYQ7jKtBJyQUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b2+ayVTNgquF44ezvYRf87vD+znwlha5lzhdT0vroUX0vwORtuqot50ytHpDISIvj
	 ClLXRmCbzbpDExIkSuhJLK8C4wAPaF/0+PdoV8ikFAjjkVvcBqYMGdz79S79HN0OaG
	 /26SX4+xjmFeVoIEVkUQ63P8qR0V4RRdDAq4Pa+nJq007awJ+LTR7feFYrYSC0Y6Vc
	 WZEDQDsSWHwbQvgWSUgvth2MuizX1dHkxJrvFYWpVLfy274xFkv/RqyjC5YWgJyDnm
	 Vyb6KoKKrcrbALv7KjYmeXJ8NX9h3EFAyIZwzpULANpY3GkeBQqpqysFA5Le862FJa
	 euWfQtYcS8ojg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E02CA9ED1;
	Mon, 12 Oct 2026 06:58:32 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 09:58:31 +0300
Subject: [PATCH RFC v3 01/10] dt-bindings: vendor-prefixes: Add Securifi
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-b4-cs75xx-v3-1-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
In-Reply-To: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
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
 Conor Dooley <conor.dooley@microchip.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791788310; l=944;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=xgnzc7i7xTN4fotWpFnT0TA7w9z1wGvQ4nKXVlJT/zc=;
 b=WmEWz3M0vRaY+uUY8utsIdLUbnz9EI+gw52QoRE1/WkSxnzbp34uBtwIBH4CTa4bxkOAA7QEV
 vFEgOTE9W4/CXXWNkPld+v11bIpxx4fX0C0jrTApPyvUODEmWFo3tFd
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
Add a vendor prefix for it.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5ddeae3a6..71e6f82a7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1497,6 +1497,8 @@ patternProperties:
     description: SDMC Technology Co., Ltd
   "^seagate,.*":
     description: Seagate Technology PLC
+  "^securifi,.*":
+    description: Securifi Ltd.
   "^seeed,.*":
     description: Seeed Technology Co., Ltd
   "^seirobotics,.*":

-- 
2.53.0


