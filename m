Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEB23BF9C;
	Tue, 21 Oct 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040004; cv=pass; b=dxR+BhQGkEjy4cc846K5QSIlvoeYKpt/UXfZONiROw6h0dmMf6GdK7xnFIQIPTFJsffFYr/nUUIvboQAUQZsSIpfgiBAUTcQ89xaqkgOovoLL571X7lB/jOR+j7IC1L53j2pwSRtDsUs5JcGd/luTj999z8zomkn8tCZNRk+Pes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040004; c=relaxed/simple;
	bh=BT1BbYf1Y5yXL3hJlz/v6ZRCueJkWknoQha5McKnBcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5r+yPrF2VBrdkxVuwm5a6/ibAJXEFOdOwmstmCyQ47C6BkmGHngX2fV1hoI9O532HarQIdHZhtHhTrsy2J7OUqbBFKT5yK93/SLRuQt2M0Aw3tj9U5MyKrzlybCyfaJwFy30V47Z7dLV0rLOcngUT8T8CgUuFO/r5VZ1CA1SEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=j/wRoNwR; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="j/wRoNwR"
ARC-Seal: i=1; a=rsa-sha256; t=1761039979; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mSP5o11emiP2ro00kcTDnJIawgB51rtVQfA//mCOOsvGn1ArSHWMVlvbA79H9zeRwZsRdXNBUtDSYTYRug5W9/gJ451tx/s/4jt2huNIJ4wm1zVwSMj7+ujmvAiSHX9k6fSIu1EC6Ix2yGClH2BECsXJo0SBw6gEuzm0W011m8g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039979; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fM/OFmnj6so77IHYlA1fi4R93kba5pRm23lZo7zfC2g=; 
	b=gXeLq88jQe415g4hLSIb8sa9cLHPByswYiqYZZdE9M5JcDsAQd2QeXe9thQxKBaN+rxM1kIfR7wpAuf3iIjvlIgSMnKocrBAdtZyDR+HI2m4PblBHq0r1YApLANTjzKCUsgzu6Nm7lXiPjTFC66qu8Nt+FoSm/D1ElhgkXSWemw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039979;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=fM/OFmnj6so77IHYlA1fi4R93kba5pRm23lZo7zfC2g=;
	b=j/wRoNwRzVGbWhyuuP5wJ3+hG3OY9kc3SreZFpaBr4/jbGPhMn7jTBQ2y+3Hv+Cp
	85XjVIultHSc8GviJdenuXONcPaoR2EgMkEZlQ3NQDYnFvHyvq2GjqLwcKgoWESueDv
	aiyk8lQaaJmxGr6YzuTNs8eftvSZUw4yR2e9RlO8=
Received: by mx.zohomail.com with SMTPS id 176103997777640.235295843942595;
	Tue, 21 Oct 2025 02:46:17 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:48 +0800
Subject: [PATCH v3 13/13] riscv: defconfig: Enable Anlogic SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-13-5478db4f664a@pigmoral.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=773;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=BT1BbYf1Y5yXL3hJlz/v6ZRCueJkWknoQha5McKnBcs=;
 b=jcnGaIRVMmeBHgf8lPTP3BWGl5CDI1pC/z14YdPdQ5DLNGbyxSnAFXo+G1X3o/6cqyFe0nlOZ
 6vuZFktycyWCCFp4fUDiPh/HVNOxMJAchZ3OH302AXEO3yUlN118mig
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Enable Anlogic SoC config in defconfig to allow the default upstream
kernel booting on Milianke MLKPAI-FS01 board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc2725cbca1879c181d179a3d59ac3a0ce206061..14b82f770efe1dc8abe1ef68b523023d89d1f4e5 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -23,6 +23,7 @@ CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_ANDES=y
+CONFIG_ARCH_ANLOGIC=y
 CONFIG_ARCH_MICROCHIP=y
 CONFIG_ARCH_SIFIVE=y
 CONFIG_ARCH_SOPHGO=y

-- 
2.51.1

