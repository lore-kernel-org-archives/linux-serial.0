Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BBE2E0409;
	Mon, 21 Jul 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113090; cv=pass; b=eVQIG+ajdZQLgp2TU5eJPs5hzMfFTBairq40jGjsg8Vt86mOwRVoTJzUQEEP8XlbubWAL0SlVB/vFaQxL+QpBqOYl9/j/i5Anw/JZAGSeb3+tkhMN40NISg7aFnqMimu18b+MQajZBQ4qgBDdg3RKllb0CO6z8TXkbJy2opXntE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113090; c=relaxed/simple;
	bh=Q4JP768L5UngHiZEaNv9Wni5vgru+fkQYYIVeZVFiHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9sFJD97rhBJuw0cPVbOCDi+3z6a14tOB40GxdY538m9JqmepfeP7xiiptmSkFsHnygFaJe8LjttXhNf3sl82kvRQ46e59jjnivi3taLPUCIUqPulMs8rBe2Txr+Fi6r/BRfwrdiK3SzWdDKfbSp8CY69EzxyFmC6zSPnaqSt0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=eylocTIU; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="eylocTIU"
ARC-Seal: i=1; a=rsa-sha256; t=1753113071; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nnGOpLzATSMlxgUAeCcP0Nu4xEFH/NSHsO/mJMW8XNdyUuVbWkJj/90qASpjspBGvlsJf4NGncGuB6jOf7zz/MWTCnOjc/faEpQgHw4cHUKGjkjdmUmqvXFLkd3vVJSL3VxM/HnzytissmS2WxGpKesgwQscqtgS/LpvKUtDQqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753113071; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cTUMeXZ6zfhE4iVZbYAQjRm40x0zq7NDoaPUwJiy8dI=; 
	b=Hk3KUW+NKakKv0Den2zoqU+3KG8RmzQg3WEhLh6VcOiuSBrS3RnIc/56IGKWN3Tu+Bj+eTU+SopCuR8k034wfD7BuZh8wGIKtrRKeoaaEbDuelifkQrykfho4gQULC7NGGXIbvesyZ1VkvGYYhupv7HJ/McmaL0d/Oh5qoVGOOg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753113071;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=cTUMeXZ6zfhE4iVZbYAQjRm40x0zq7NDoaPUwJiy8dI=;
	b=eylocTIUjQCGS67Mfm7bYjf8LxJb659iORZj980tukGLfCU0ArmLZK1lV0xTtnvL
	BV3IVBtegODroEd2Xn9RntgtqnNVNp72x2UXQXObbfQADXob2wgkNjc+ei0aBKM6KQq
	XnLmVxSky5HXtJfTkbeh5UrBQpojvDaHIahY20uU=
Received: by mx.zohomail.com with SMTPS id 1753113069394763.0445044535313;
	Mon, 21 Jul 2025 08:51:09 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Jul 2025 23:46:11 +0800
Subject: [PATCH RFC 05/10] dt-bindings: interrupt-controller: Add Anlogic
 DR1V90 PLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-dr1v90-basic-dt-v1-5-5740c5199c47@pigmoral.tech>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
In-Reply-To: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753112991; l=928;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=Q4JP768L5UngHiZEaNv9Wni5vgru+fkQYYIVeZVFiHc=;
 b=MTRUxMvt1Tx1svRro/NXkIetBpLr5SVpel35TjuqdqEYdwd8ubCCKZWE7AFSEJsoyaWHQW7gA
 rHyl9eLfo26BKOMbAdjwH5iORPVhZWrnS+qQxVN+pT1NuXgZStQkO+Z
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

Add PLIC support for Anlogic DR1V90.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index ffc4768bad065276378d23d53d6e81efad0a6b66..cc6de8bb89937859e4405aac5d931b8586ac2ddd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -57,6 +57,7 @@ properties:
           - const: andestech,nceplic100
       - items:
           - enum:
+              - anlogic,dr1v90-plic
               - canaan,k210-plic
               - sifive,fu540-c000-plic
               - spacemit,k1-plic

-- 
2.50.1

