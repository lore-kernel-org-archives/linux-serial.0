Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593C32B9AD;
	Tue, 21 Oct 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039977; cv=pass; b=juPU0E+YRen38IVWiW/8Lje1hyzChJhIunLeWr4e38QF+bB79iGWbvvaQY6xsT+4QJOIqbR9jpWXGt7IL5neAbf2AwE2zS8rXJNuU3BEBmSVBPB100PNBrQb4oLmHlAG1FDbRyx5BrW3iObL8S5EG2vGmWgvYqZSyhOWP4uAp0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039977; c=relaxed/simple;
	bh=9OdYZIcHYCn1T72Knpz+3UUuf/Imgss8DndocK825yM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKByAbh7eOpwQNIur4KjJ71LRWTG+Q/f+bpBci7nzLEWU5BRq7AgIm3B5trP/AOI7I+03BPtt0dEHjG3hzv+C16S4eVG95Sv596xlZqnJYse9080BxnTgNxXT6Qo4UTOPy0SqHbgrk1isfq/g/FjPsDKTKYd42pMEfl7tvOB8LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=mByfwOmN; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="mByfwOmN"
ARC-Seal: i=1; a=rsa-sha256; t=1761039951; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dDLRGvoAMkowcfjxfLWZ4mq++uaRgBwkogOkMVbtU7kCjEUarkfQKfY88+7yH55hbyRVObXV6PwU2C7nt1PGNTujXwFYiXZ9Q3+xXl3WYe4rd8pfmx9r/HkYZjPmSRlFymLK7HOBgY0B2PjVy45RgzRzJvIzmfai3KZEZkB65Xk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039951; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AH1+SqtWbfAt+P6KqNKSczwkQpAkG3TFhMGHQUWfOAk=; 
	b=QWGKPJ/Nv3EZ5TXK13rFbIb4ek5+R7ZyyITtQ3hVee91WKkOcvIXjqOUivUwa0qkN8mwkAgAt4DxcQwc5ambQ5vHW2LIkEgsW/d0EBIE9/qEDfR98x0MhapGMGnwnmVxi7zHvL/kd57DhfakEEPbMGPqvsa8mwyxf0f7UgqX/1M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039951;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=AH1+SqtWbfAt+P6KqNKSczwkQpAkG3TFhMGHQUWfOAk=;
	b=mByfwOmNsDutV2riePCycGrncRlxYusDCRJa1xMuSiHZDMcZDe4tlb3VKto8Dycg
	9kIi2bFKruxvFaT/ZH+pw9dibYb2s7DClde39QIV3lvCAfxi0fK8QwptUm2K7n6MZRh
	oblR9DIQJ02DwbaLCObeJzWaWDdcbR9R7AUco0Vo=
Received: by mx.zohomail.com with SMTPS id 1761039949164800.4672868226596;
	Tue, 21 Oct 2025 02:45:49 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:45 +0800
Subject: [PATCH v3 10/13] riscv: Add Anlogic SoC famly Kconfig support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-10-5478db4f664a@pigmoral.tech>
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
 sophgo@lists.linux.dev, linux-serial@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=787;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=9OdYZIcHYCn1T72Knpz+3UUuf/Imgss8DndocK825yM=;
 b=bLTQf4SKPLAwRKBHjWe/Q34iFXG0eLXcOppTb6SOYA745MZRviDD126BIdzyczBEuSMf1A3MQ
 OQzdbE5iNuiB48oQhPtHlUCgFIX/MPlDOYWdfSrbM0SpI8Ql+iCTWPT
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

The first SoC in the Anlogic series is DR1V90, which contains a RISC-V
core from Nuclei.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 848e7149e4435ad3ca138b62bc3b3c8efb594a18..25f7e58cbf745a78b0e946749aa2a770dae3eb2b 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -7,6 +7,11 @@ config ARCH_ANDES
 	help
 	  This enables support for Andes SoC platform hardware.
 
+config ARCH_ANLOGIC
+	bool "Anlogic SoCs"
+	help
+	  This enables support for Anlogic SoC platform hardware.
+
 config ARCH_ESWIN
 	bool "ESWIN SoCs"
 	help

-- 
2.51.1

