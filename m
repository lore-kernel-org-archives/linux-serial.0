Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E22E0919;
	Mon, 21 Jul 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113101; cv=pass; b=W7vS9NUqA3TnMWMXISQLfA4NW59PAHk/vZEYXv9tVekNwx3QoV5WRRrz4cVdsBsVp2Lmdv1eE76kuNa8exR/WKEPsaW85dCKFLt3HebHwWS/6HN156HLFPEvUrXoMGRT7eeW1UkUQ3LL53O2BknwDmHVonf/Az7GFiOGCT8J9/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113101; c=relaxed/simple;
	bh=jNFRA/llS4U5KfG6ULgPecJZNDjUdexNLrl/DkZcBZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E962X+PZ1NLwqBdjH3EZftC+xe5a5xl3PMsgJQrgbVBS+c/Yzrtv23CunHCPAPaU3a1cZqZeQWj0eWGqrVGGxzBL7fq9kedBVkOT4yq5SNnXp6q5hL4CURfCbwzr9qqCsrEcr0Fwz1RuvO/csd78ScsOpwgWA2JHgHOhU5COhps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=En1M0SFo; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="En1M0SFo"
ARC-Seal: i=1; a=rsa-sha256; t=1753113083; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L96xQUmYl0cNVfockUxvD3K+HAHnBIZidDEvBUk7jWf+Xp/CgE4KdH6Cte0OnzcS8KyR3BH9Yz8TdoMOMoKQ757IW+8u9yZRCu0g2pCrlxeUwfaj1yufkmauNmXDULpqn7LzmRi1BAfiWsGs2TqsAIQoWy2DAqiYwmFmUUFSH/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753113083; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NmJkGyDYI14AaMaSvTmSGY4Uxj56rzD9WcCXfn09Yyw=; 
	b=DDhmTpKTenvERLr7VKZ1w5ZXQrcVlMOSZtHn0ncIPYPpA2gcqryBoRATCFGFRz5G+fFHAc/rz7ww/+ebfcInv1izS89t4wSyyoKwUpzwqmARQfFNZVZbLmo5YJyW6Ogasd0n+k7875NjYcmCXQPe8VHV7V0VcRlFi6TTnx50ZGE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753113083;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=NmJkGyDYI14AaMaSvTmSGY4Uxj56rzD9WcCXfn09Yyw=;
	b=En1M0SFokYBhqYYtLEscvS63SUQxamZ29AbxV9kvtX7bFSzjA0FwF3FHqXwyISIf
	tdT3hiAMPlX5dd1rVe7d4HlgfGAdFvn7thO4QmZKYqm0C0eiJjQwWeG4ri8RUNBKXcO
	Q7acHvYayjx5VP+NI6lFwSh2uxVyczjkDV+rZSuc=
Received: by mx.zohomail.com with SMTPS id 1753113081950103.5430234161762;
	Mon, 21 Jul 2025 08:51:21 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Jul 2025 23:46:12 +0800
Subject: [PATCH RFC 06/10] dt-bindings: serial: snps-dw-apb-uart: Add
 Anlogic DR1V90 uart
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-dr1v90-basic-dt-v1-6-5740c5199c47@pigmoral.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753112991; l=948;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=jNFRA/llS4U5KfG6ULgPecJZNDjUdexNLrl/DkZcBZs=;
 b=lSmRU0jW9pXdSHdptmP380xwUKv0VruypoQOEj1tP0tAVeQ309WIPD4uiUqndvP1UsgVIOggB
 cRfKMRb/cJKDsvtQ2QS4Le1JOtjdZp+K/Xs3VjnC4/NOAqZAl4WISzk
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

The Anlogic DR1V90 SoC integrates a UART controller compatible with
snps,dw-apb-uart, operating at a 50 MHz clock.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 8f1b7f704c5bc7cb9552b7d4825d96199cbc6c4f..ed00eefe17aa11200e0a10637d4cc10b68948699 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -51,6 +51,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart
               - rockchip,px30-uart

-- 
2.50.1

