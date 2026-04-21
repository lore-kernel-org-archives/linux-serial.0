Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C5367F3A;
	Tue, 21 Apr 2026 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776751205; cv=none; b=d8RjYSdu1l2j+f7vLEedwFsK//lYQTk7TG5f1r9RLmqYJfiQQu+hhtuN6RJpGlzkvkWpgZSttaJ3i3/xoH9pXFSWeYuEr+M3S+KcbyYcpkJz6//vW6RiniK0SxlBRiWW5M3mqDnVphyhDQnDg9cTWoTImKbPUDo3XfuHHtRBVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776751205; c=relaxed/simple;
	bh=fd/GPuODvz6hEyhIIX23mIspVD0bj+TwDCa2egzIms4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/xaJaMroRLRTIl0mJ1ESDceGCTwsTtz48+4/DNbk4szPu8RAlFTltHQagJhKaoK1OaHNPQYYCaOajiWbJMe1ScdJ6GcleW2OQNEMloz+5tQO32L+zGk/nhM8x67m7LqPjZFG+SiO7eSvanIhNQXRSvTfXWg5E87sbTXnXVia/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=EdX6J9y4; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="EdX6J9y4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=IunV+g35Iv9Wif8Qwna4P1wIGXGPiiv
	nhH77S5h3sg8=; b=EdX6J9y4HTiBMUySpQhe1eugOQ72YhI5kFxFAHXJLD0CRIO
	2ILuWwUpBZ4YsVeTU5jWKKB0Do+4guWPdvyAQzGxJcRiMk7Ck48QY2oK8H5Ljqvn
	Ax2i/CGcHOmHWbf0YGqOLPteZhQF89SPwhU8MF24kwLj9u2VMtacYp7N/Qrw=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkNyEudpn5ACAA--.1518S3;
	Tue, 21 Apr 2026 14:00:22 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Tue, 21 Apr 2026 13:58:51 +0800
Subject: [PATCH v3 1/2] dt-bindings: serial: snps-dw-apb-uart: Add
 UltraRISC DP1000 UART
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-ultrarisc-serial-v3-1-3d7f09c2420e@ultrarisc.com>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
In-Reply-To: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776751174; l=887;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=fd/GPuODvz6hEyhIIX23mIspVD0bj+TwDCa2egzIms4=;
 b=2i7l2Hj3OGIs9vN1NC2cl2JWvsa6EaJM3B89Sp0O3lq6L/V1p0srR3MIXU0B0TT+Z6dI+9ne7
 +m29PGkjIXOASIdgDWTJQ48tm4Kgovs+hTxcjjGfIT9uRw7dJwEBGz7
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnEkNyEudpn5ACAA--.1518S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1UuFWkJF48CFWxXw43Jrb_yoWfGFb_C3
	4xuayDXF45AFWFva1DAF4xtr1rZF47WF4rCrn8t3WDC34DZa98KFykKr90yw1rKr1rur4f
	ur93CryqkrsxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQADEWnlor4ACwAHsP

UltraRISC DP1000 integrates a Synopsys DesignWare APB UART, but it does
not provide the standard CPR and UCV registers.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 6efe43089a74..f84600f66df8 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -77,6 +77,7 @@ properties:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
               - starfive,jh7110-uart
+              - ultrarisc,dp1000-uart
           - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
 

-- 
2.34.1

