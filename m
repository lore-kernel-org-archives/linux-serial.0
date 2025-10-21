Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533F313539;
	Tue, 21 Oct 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040041; cv=pass; b=jgQ2ZfWR39a7VCFBGjaKmLdcOfsvEzhxJ+1qe9SGbpSdQ6sJdn4FM+p9R3AWsTeCvqPI7/5A7CEk7aWSfTQbb5D/XXQb8Qwvffmf382EuuXrVeq6ZggqXvUOJHm2diZiqmsmWkEdKR3Y0aRAs21TGUj/AfqH7rfR8nZ0E5ilaUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040041; c=relaxed/simple;
	bh=aL8VQaPRJAjxauni7+ank2K5a+1YkvZipzoMxURVk3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vs0DprEzKEFs+u5vjBmjiTA8hThSaCS3e8cu55EJGrhHgK/wORqumEFf9bzGtLDbPT40A1mFCI+mPk52qMVJa04t41mpD4M8bcjGSGxxedsdJ3iPOy8iHK+XYZnblVvVwk3me9zB+kr+nxb5jeJ6WCTgiBuE5jGBZXXjqUUINlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=XqeRRzht; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="XqeRRzht"
ARC-Seal: i=1; a=rsa-sha256; t=1761039943; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TDfUGAfYpRcT0urFw9+bzmbLLer4gRTlbNQjslKH4C4uYZCQsMnsLiXhUGWd3VvKbhjax7QtGWaP7UsyrccIdpbYGcRpvKSVAoG+1AH57saR0NPpiqFkKyRZUfHHPN87f/21M68oXf7VLI2mJqbnMZ3IgcOUwqnmsdmA50Twa3o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039943; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CUl4Oz1AaENiLJK0HdSL1flO7p1OM/HO2y+DaZArucw=; 
	b=Sos5YwWOuUVA+P/vcU/k1y7RDhfa09AeHxTLTLgFAFySMBajsZt3lv5P/zqDI3oQMfdiHs3HGVkrtOgqtnyo0+VLEvujh2sMgISEaxRwhoVYK3pGPvTtYJrldrTvMlG7kVGgv7NfqRcuwdHfcY9a/E+EhQrGCxOwIEFGdcKFfNA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039943;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=CUl4Oz1AaENiLJK0HdSL1flO7p1OM/HO2y+DaZArucw=;
	b=XqeRRzht9vIjZG8W62JOtVxgaxTApwHwwKO/nUoFQp1ON0T2VWanLPsN6fZh9mHP
	hjVM5oiNuyH+7CQpYc6M1a5a0XyCrqVhfd29IE+IP/nz0bhil217lYG5VG7b3BViQ4Z
	WP5pC5EkM/vo2XbfwbaTLHjSsB2jrqI6Piw/ur/o=
Received: by mx.zohomail.com with SMTPS id 1761039941047323.07553784607876;
	Tue, 21 Oct 2025 02:45:41 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:44 +0800
Subject: [PATCH v3 09/13] irqchip/aclint-sswi: Add Nuclei UX900 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-9-5478db4f664a@pigmoral.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=1059;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=aL8VQaPRJAjxauni7+ank2K5a+1YkvZipzoMxURVk3A=;
 b=t89Ai7cypoy3Jeymaxc7PSarsJr/Zf3m7GyW+zepjdaWbL1sFwJacXsafuIBH0i4nzOLUhRdu
 MfnJR8Q/uo0CBuWeCUy7ZisosK7sRWa4yNDIyuTc1aineA4eP3K5Abe
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Reuse the generic ACLINT SSWI probe for Nuclei UX900 since it is
compliant with the ACLINT specification.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/irqchip/irq-aclint-sswi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-aclint-sswi.c b/drivers/irqchip/irq-aclint-sswi.c
index 93e28e9f281f64da4568be37dc57b414354c3f56..fee30f3bc5ac252b236078bf13df8c04e7327eaf 100644
--- a/drivers/irqchip/irq-aclint-sswi.c
+++ b/drivers/irqchip/irq-aclint-sswi.c
@@ -175,7 +175,8 @@ static int __init generic_aclint_sswi_early_probe(struct device_node *node,
 {
 	return generic_aclint_sswi_probe(&node->fwnode);
 }
-IRQCHIP_DECLARE(generic_aclint_sswi, "mips,p8700-aclint-sswi", generic_aclint_sswi_early_probe);
+IRQCHIP_DECLARE(mips_p8700_sswi, "mips,p8700-aclint-sswi", generic_aclint_sswi_early_probe);
+IRQCHIP_DECLARE(nuclei_ux900_sswi, "nuclei,ux900-aclint-sswi", generic_aclint_sswi_early_probe);
 
 /* THEAD variant */
 #define THEAD_C9XX_CSR_SXSTATUS			0x5c0

-- 
2.51.1

