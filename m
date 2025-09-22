Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4C309EF6;
	Mon, 22 Sep 2025 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545694; cv=pass; b=nmCH5QONWAVGbg9OcCotCNOZ1OjDcgRz8+68AicdZJxwfKVxwbni9F1nH4NLjsj5EaQyxKZW2GgzpE2aX4/Nqcw9v861wFiAMbbzCKins0yWqkiaBkLG6HqFWkQD6kt35g4oWko7mFLf35KSHrXbYqM9Ow+jQT2iqAWY1dPOmwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545694; c=relaxed/simple;
	bh=2duqhJJfa3OWCSE0ZYgcGXeD6NGxJzujcMjbQJAxiO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4NeBrR810kNcUU3X6dKQPBbW1WR27GiqERtCdrOIk6JOGiYzly03tmr2RWgr0xZNy+Pa5Io/ld8fUQn1I8Vjs4NZqxF/B//m/h//Lil/tsSG3PYKnLXZbrGnwpaLliXWodfWXWu4OvAu9dJneYRO+WOzaOw2p9ZLZquoCG9PIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=EOuZafm4; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="EOuZafm4"
ARC-Seal: i=1; a=rsa-sha256; t=1758545676; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fKXsmQQOHLxpCKowArx0qWxjlqz35dv/c4ohWJ3WsbDHH75+0d7s1z/hS78hiyDpQs/GoluloEHJmAZF+1+otJFQHyp7/Xb2h3xa1Fi2YfDnLF3MS3ov22AamHbaBFpiFzyyPiOvv8X776Dlje4ga0MzKyTBQ/vr+VR7psz9sow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758545676; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wO22W9vle4i5bEyr0Bi4hKWmH4mcCxrcklcIbBfbcws=; 
	b=OSfa/c3zJULQ1LzZ92I9tuyFeHtVFB1UpTP7MTY8JoXzBhwZmTXoFZN50JTDGcmYL+eu5e2XqCpFLB+KynzbRMXQ3im9ZwzxQZmOdHCLGboBhc5Yt1HKafG68TfP2vsVXE0icQz4qwn3E8FffeyW6eolppdSQP4aVJbehsvlSBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758545676;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=wO22W9vle4i5bEyr0Bi4hKWmH4mcCxrcklcIbBfbcws=;
	b=EOuZafm4h/hsy0QD9YcLFF4TqzOe0jIWS5A63/3jQHhivAgZj7UI/4sgn78nXbgI
	4aFEiloVzBcjSuxz5aAu945aTnItGbR/KivVWsli4vwCnsOnt898tCGxkJVKuyNRQVh
	VM/2y2W2VgXe9KjOMMj9g2ECyTATQmMUEKEdzO+s=
Received: by mx.zohomail.com with SMTPS id 17585456750162.658580432733288;
	Mon, 22 Sep 2025 05:54:35 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 20:46:36 +0800
Subject: [PATCH v2 06/11] dt-bindings: serial: snps-dw-apb-uart: Add
 Anlogic DR1V90 uart
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-basic-dt-v2-6-64d28500cb37@pigmoral.tech>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
In-Reply-To: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=995;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=2duqhJJfa3OWCSE0ZYgcGXeD6NGxJzujcMjbQJAxiO4=;
 b=VBUHAMSHO09Ry2leHmRfzhpQE5vY/EH5hoSJ1OEQ993DTBLwsoC4M2LtvSyzXY+B77YEcdM6/
 d6tYVM5spvJAREhNvHnj/eDM5Jd8X2yL4ct3YO96C9uDqjjVWooUBoR
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

The Anlogic DR1V90 SoC integrates a UART controller compatible with
snps,dw-apb-uart, operating at a 50 MHz clock.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index cb9da6c97afcfd27a315414959b2b17beb4454cf..691bd0bac6be449516e213b550415acd37badad6 100644
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
2.51.0

