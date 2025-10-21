Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAD32D0F9;
	Tue, 21 Oct 2025 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039957; cv=pass; b=kSkJNdBUsQrA6hFanCK/O1tLUvNzcgators6YEnWAnmZOKFBDL+IrBHqTj7Ry7g0CzjFa8PJe9T4bS/Fws+dnHDRYZ/DkL2AbSy9keybiXFLbuv1kohqhM3Ye5JwTSxzWIwwA/8GLyNFq5LpanwRKBbZ3iY+6FZtGgG8bU6CgHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039957; c=relaxed/simple;
	bh=Fpln/c7ViYj8ZfX4F0j41NWe9lauWJxk/Gt9COIjgLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yc3NEYjKtVoOjNIY3Rx1tqvbFul1r0EbiJvDQgRY3zsqjkp3ecntJvL+Uuh7B3r21s2PcONOZ2Zd+06rAdCM7UrI2hq3R+V+PtPqAv6/dcRvHq9FnHlyOzGD8l8ut64xqBW8YVokQ4MYp4Tvtb3BP5uRwfPwn+iqw1cPpoSc6Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=pqQ6rMfk; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="pqQ6rMfk"
ARC-Seal: i=1; a=rsa-sha256; t=1761039935; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HQkxjO5iKvKerkP31KU/PD9qvpi37bFi+/V4w27Fs1//eTTx8V24CjbTKVS1E2gADYCfsH0l5tnyRDlhYc9yKKFf3CY/WNN7B0BmlIHxkmmoX2YSbZq1QAke0eBFFgyDpsNL0I6dq0t8gm1gdsjkgy3heEBxoQlah0WgAuKXY+M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039935; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5rI5kYlc0kJFlzyj6FrlL3BrdxouM7Eoa2weCOJQey4=; 
	b=LVlxBy+T19swqdTKQAebVq5KKzXbeC6qv80h6PxM/7NjAUDNRzOx+QYVZmz0n42Gx12B8y+yblIbxPpcDfjDq2Ot+5hvbhz3O9KXLTIMjN6UxqlZ51yPSOYVr7UPOo4EVpbyTan3lC4+j7H/uSTtwGa4/WceeKcnQfAwiqApDPw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039935;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=5rI5kYlc0kJFlzyj6FrlL3BrdxouM7Eoa2weCOJQey4=;
	b=pqQ6rMfkwSxXcdYsUN2AvSq0XjhZgkPCQzEQtfVys83PIBER0PSR91a9dMDq+LZ5
	tniNzHgMoFcuyzcy4H2/omub8qBYi+8RaBv5bBU7YwXM8hV1wWFt4c+dyreTXD+G5eI
	s1z8bzsCgnljHgZTorRQGkddtWDek8yT9/3voVKw=
Received: by mx.zohomail.com with SMTPS id 1761039933613557.3508358472184;
	Tue, 21 Oct 2025 02:45:33 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:43 +0800
Subject: [PATCH v3 08/13] dt-bindings: serial: snps-dw-apb-uart: Add
 Anlogic DR1V90 uart
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-8-5478db4f664a@pigmoral.tech>
References: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
In-Reply-To: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, Inochi Amaoto <inochiama@outlook.com>, 
 sophgo@lists.linux.dev, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=995;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=Fpln/c7ViYj8ZfX4F0j41NWe9lauWJxk/Gt9COIjgLs=;
 b=Yt5fVqhedU/VD+SIsk26FcgaoStoJXGo0lAzMwTYEQmUXKYAxnfBjKdMwE95mTXMeHk5Eq22u
 NMztlh0taDeAmq+Dt+RXQ5PHF/awr1WndatmjzT0OFHGY9pco7VygTL
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
2.51.1

