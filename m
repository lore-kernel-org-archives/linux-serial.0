Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8F30648D;
	Mon, 22 Sep 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546070; cv=pass; b=ConWViZ7Awsl2881hpKOtySg6QlNWXfSLcg2Cp/2kPQKxKKds9j85y+u1XsnAmSBClhplp5vIyInbIkkCm01IPr2/RWFsNlmuEQaAxQBCGmuev8f6FfRglv2VVNOE7If7XQpoHB2En3UZwyl3cNaejQFtzt+/T0s9SudjgD0oOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546070; c=relaxed/simple;
	bh=ZH5mj7Si1pInidDDRccHQdYBENMYV9CAGFNeoheRne4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpCVfpelg14AAqkqnTUYYcBbDoLBf1U9vdR5PQHtmxpVozeO+rK5rGbil2S/W+W/tcTPv4Cak5byn1roiQwq6TayBXqL76WMsac66pZDLLWAE9IVmn5z/daixeHeJCxNl8A2xxOFgiBN2JhauXd0TF8cKXSfn91yb90JNt3yqDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=ZEuFMvP3; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="ZEuFMvP3"
ARC-Seal: i=1; a=rsa-sha256; t=1758546042; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FhQErGUCqPYuz8npt0QoLiU5orGG6kD0p8QBIVD2h5piCbiTyR19zJ3+mVTnpRXzSj/T1o9zT0KAjsPwiIi7oNcOp8EPJ0LPPEP19pwoQqjTOcF9fPHPD937HlKwExcrK4MJjwq9DCzJLDwQoGIa+phPYM4I5B3uuC16ZPRv3hE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758546042; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f3nvmSiet2Q3DR2SkZE1/iC4vHuWkyp+B7sW2U6MWUk=; 
	b=W5oQpcLINEHHqmO9KNiTob8R/AIHiGaqBw+5ndGyu7EfNI6YCY314+jCeTbxtIKKv0E3a9aJj8bOWy4k/esFSfJrLob1XVS7gG798sOFm+mpg3WqH1jJ6HqCNPVuM73ggovpaN3FRYDGQBcb5PbddJ5alQDj8KtVgrRZuFsFiYQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758546042;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=f3nvmSiet2Q3DR2SkZE1/iC4vHuWkyp+B7sW2U6MWUk=;
	b=ZEuFMvP3rKqUeMkyCV2WYaBd18AeO3dKUJaNX2qQq4c3Uf9RJ/PAs3HoXgaKuBaG
	6nuZ0kf0RQqRKTHEmAN/hpcfJ8IjM5cPVjpbDwWqLqYec2us/TnR25KdFkeC8Lwnr9L
	w5xG+qvX3ZsOiAn/Bg0P7DQsz3yXtxJp+yww1RB8=
Received: by mx.zohomail.com with SMTPS id 1758546039179166.5139405502831;
	Mon, 22 Sep 2025 06:00:39 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 20:46:40 +0800
Subject: [PATCH v2 10/11] riscv: defconfig: Enable Anlogic SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-basic-dt-v2-10-64d28500cb37@pigmoral.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=720;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=ZH5mj7Si1pInidDDRccHQdYBENMYV9CAGFNeoheRne4=;
 b=qRIMklpcFF+PHU4aYCJ+gt+lGgQSvdln6gwtn7JDuJKqTsdYp4BAXa/pkad0L/eLgfGn4Y6Iq
 c9FjHQ1kNwdCr/nBXCL9h9wR9NUV+B927Fet6s/HO1oGUVB1xGu06m4
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Enable Anlogic SoC config in defconfig to allow the default upstream
kernel booting on Milianke MLKPAI-FS01 board.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 7b5eed17611ad2260a28f9fe9985b88682eb1ebe..889a9f779c94a33b0164626b3726e11ac8cf357e 100644
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
2.51.0

