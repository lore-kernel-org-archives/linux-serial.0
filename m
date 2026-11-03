Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745860;
	b=eVA5g+AgwkwLechPqpclKjts94KKiLvRmVMY/Pnr6mZ8pz+hhqNC64xQU98i8B8U51xZ
	 q7eXW+87F+yigsvGPkWuFNGSlvcWH7Ym5cFxAvPR322x96Dbz/dQfIrLS6+xjQhCVt6Yl
	 4xMmzl8tIqwA9SODT9Z46rTYO3r7nfP/N3un89R4HlLzHuJQgQPc72xSgjG9idvAv5oJi
	 YyyuOoBuYr675K2aj5AMqYrR75mSh0P7+ufy7deXmjPfkcu+3mhMXI4PxfcgVg/cGzNG+
	 kvRyNjP5u5VpBZ0pgnVBeVO7fkOZ7Wvz9QdOXpqzbMiP4gqF7zagX8N8mRaiVBo/f6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745860;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ClY6VcM0L71u4TrDzO9N49R1pUiLahDL6t83GVy/u5o=;
	b=ZQJbh0keytEb678QAhQ0PCY7yGi1q5FYgruTLX5nQXz/4qdZ1RwsCU9f+iuLHo1Xaxhb
	 6rY40qvT5t4LNraD1nlY2LfMaCoOV6E3c8oNBn1gFZo9ZjAlIOWp+3655VM1X9xtkMFX/
	 SL7pW/BLxgQYp+lxg9BELQc7OJpbT4zjLxrPrygOBx2GVvRWTOblkuQDib9gCC3KMolL/
	 1OIsT7KpghbjyNLSxM9p671p0Ze5OebLJCUgYzSpJDAGEaoBm+03zzBKh4bvC66Lu27vR
	 9AihPJL+fXny1RrayC5nEw2nXsljkaa+MG8ylR6tzdCpMDJ2ttCbQ8rLLJUpGqo7jYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzMESGxU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850A606A31B;
	Tue,  3 Nov 2026 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzMESGxU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB11C1F00919;
	Tue,  3 Nov 2026 22:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745859;
	bh=ClY6VcM0L71u4TrDzO9N49R1pUiLahDL6t83GVy/u5o=;
	h=From:To:Cc:Subject:Date;
	b=NzMESGxUieHRhVlJc7P8DY1lAEMKYZSwhnQ8vj/8KILknBoYtxShqTn9TwwohTGo1
	 P9S0gH/lJH/jsPtuuYqxE2oeXegOmV/rSk4QbOHJX+vKS8Qv6+QjTWEHFxStpwxExV
	 TKS78X1FeGurmTLc0gpoC1BntuE5dbkSoyULT/1DzZzXeSe4q3R+e9+MWTLvbFjr9R
	 Dkn8HnUKaT6MSXCxBr42m02mb7ibLMb4Ud8sqeQZMx80smh6CZW43rBX/gvQgI1r8W
	 bnKHbCU4DxIWUiHqYeXTHuUuTMtKe3frztwrXaEfL/vrTPCi4m7ekTk5ZBvMlbVBVV
	 1IfG0OB6OIjeQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: 8250: Allow unconnected interrupts
Date: Tue,  3 Nov 2026 16:44:09 -0600
Message-ID: <20261103224409.865130-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

8250-compatible UARTs can operate without a connected interrupt, using
polling. Requiring interrupts rejects valid descriptions such as the
HIP06 LPC UART.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 50d5c977afa3..7bc3fa84d3d1 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -322,7 +322,6 @@ properties:
 
 required:
   - reg
-  - interrupts
 
 unevaluatedProperties: false
 
-- 
2.53.0

