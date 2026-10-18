Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C314AD4CE
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331384; cv=none; b=G4EBzezIBzoeEXVp4z1LDElKURMls8iq5Ki6ecdbkaywXFZWtV0xiqgFpnANRIbicoG1UEn8Ur0Vkxlwm35JWVc8DcitKTJlXAx+9lzHnwz5Xl+Lymag5K1rGl0SJ12HI3QwyXl86MC36oYes1yST4/UTRlETVoNY1a7PuK5CfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331384; c=relaxed/simple;
	bh=7MGTJdk+4Foua3uK4fT3tosb12DKYulonOLvYMkMDW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXqM/kVVIIREepMNwAiRXpovjk5EC2OALPfMlysy7XF2FpiQPZTZGHDqGYdBQf/wNC8M6T+3EZHfRLMDceUsBbQC2OxKfk4ig9uH3oMYJIklGbUUy/7OcXgokxWV4kAey/zwZm0LuyzLRKJ/WYI8pYDAGnWD+s0d4ctINO7x1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa2FZ2+L; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa2FZ2+L"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c43373ae89aso51006766b.3
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331378; x=1792936178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgyOpAgwDJcgNK32/9PGTXHO9coJXI+TEruCjzlJ5Mk=;
        b=Pa2FZ2+L/iITeJOAk5eZ7nVtdjgLS0dBf1QrSKg19f+7gHyFMXPWwzmuUBeyqVr5Ur
         VJ9pi10ckWgzDpWG7C9v5FJGqaJSPeSNtXrQgIiRONz8ha/z5t95QUy9zX08VJ1FmOgF
         7E4ox0cqAhHaF58Jc8JqGln5rVHykaqijkk7QBjvySH2udGVAoJxbEno9peE1W4Ejlz/
         U31Th+AqB4V9r5HlFRRM3fxpHW3ecFEUYr5Nx0gkcO9YBgQ4uxoUzMG0a95WKWNbxhWy
         vkiUktCMsGw90p6Wy0jefQ95At39fqHibmzN8Y4qNwmwR2Qnv+0I7KSjWQkwBPIMZPhS
         5QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331378; x=1792936178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QgyOpAgwDJcgNK32/9PGTXHO9coJXI+TEruCjzlJ5Mk=;
        b=SOPJoZ6fpYLAqYdGrDYSrWAWW+GdA042IZAsRzxP87wyJnoAPK22D/m6gGfLDaKtUo
         MvDGdvH3XL1D7gK6ub2gIO2dTNqHsEXAghJmXCLl9iN95dco1UT9gdza2xInPSvuqY+L
         5DSZCX8QqtFo5G6ftpP3JcCeRa7/DuOvNCiNR6PIYN3lQUiYA8iM93xkyEzMnUNzW4Z9
         AVPWNJLOx2BvCHiQwVxAc3qJfCJykTxCiTqSRlX9VugV/Q8+tBmRXEJOwto8IhRE16Sv
         lhiBrq2B/1sM16mkQZa5j0C+s5qdQ2fF3fh957K3CIZZwZ0LHf3rWncVzEX+h1ginfVd
         ZZuQ==
X-Forwarded-Encrypted: i=1; AKwUvByY4RTh6TGlEkNe4NnxmNC9vVEFC6L8X9k4zJQCkQpubGrxAY9p8B1kxP0GuuABPcNiwjDWAJ8PjmjMoJ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYPE/d+zHhRDua16XNvhXR2lEEZyp1KGrwDSUORRzai8jI7FYv
	GdlMmmIgdVOVsxXKgOlL5e4j4t0qPhMQXrbZfHJXR4t0WeElNwOdbRuS
X-Gm-Gg: AYBFou0w1xENrYnLNrADO3XIJ0e/UqqzzrXllGtecNvEzTxPLvIfVTemZuGLVzXArct
	v1xH86W4t5LXDbxq8NPZCguXr91YQ6KK/KGEtHS0d8nFwxFc8agnjwIFxUzGYD8YSJPy60cM84U
	o5kXkvAxjLawrZS9ubU1U1tJfXkXOZ0BinWiD2neZjph+abgUR23DVG8W5YMQsMm1S/H2F2pdH1
	V9azY0SnZyJ8lbVjT114IJPh2g0ww7BeJOIp9V779QE+piicpWW/nYXKPMoyxJDW0gGDXwTEDKv
	bbgWJ+hYPWSD/Pe0Pm5ViJI7yng8oJuuAtA9uO+DfSbkOT0/k+pC8lY0FJ1g8x5tfY5R7T8D+ao
	k/nKOX1OKWlGOX5I7CwmCUViHKAHotyBvboHOP/cM7P+8xryZ5/NbCGls/c6U1J8/F2XO1CTG88
	twLefdX/Dog/SeUObP/0vts1pQS2Ub6VAfbVViF2ChwdtNu3F0WLXmvlNk53e14SqEvPNhPvkBn
	H6f1jyPQpbYS6h9QR3rnpiU7nFSwh64wFsgoi3L
X-Received: by 2002:a17:907:d86:b0:c29:f5d5:5aa4 with SMTP id a640c23a62f3a-c41a08dbe04mr331615566b.46.1792331378553;
        Sun, 18 Oct 2026 06:49:38 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:37 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v4 05/10] sparc64: validate Fire register properties before initialization
Date: Sun, 18 Oct 2026 15:45:07 +0200
Message-ID: <20261018134738.1016106-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Fire interrupt translator reads one reg entry, and PCI PBM setup
reads two, without checking that the firmware supplied enough data.

Check the property before allocating the translator or changing PBM
state. Halt early translation on invalid firmware data rather than leave
raw interrupt numbers untranslated. Return an error from PBM setup so
probe can release its allocations.

Fixes: 861fe90656b8 ("[SPARC64]: SUN4U PCI-E controller support.")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/pci_fire.c      | 9 +++++++--
 arch/sparc/kernel/prom_irqtrans.c | 8 +++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index c35a8e3c1eae..db160eeb0ffe 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -416,7 +416,13 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 {
 	const struct linux_prom64_registers *regs;
 	struct device_node *dp = op->dev.of_node;
-	int err;
+	int err, len;
+
+	regs = of_get_property(dp, "reg", &len);
+	if (!regs || len < 2 * sizeof(*regs)) {
+		dev_err(&op->dev, "missing or short reg property\n");
+		return -EINVAL;
+	}
 
 	pbm->numa_node = NUMA_NO_NODE;
 
@@ -429,7 +435,6 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 	pbm->op = op;
 	pbm->name = dp->full_name;
 
-	regs = of_get_property(dp, "reg", NULL);
 	pbm->pbm_regs = regs[0].phys_addr;
 	pbm->controller_regs = regs[1].phys_addr - 0x410000UL;
 
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index 5752bfd73ac0..558ed5114664 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -544,13 +544,19 @@ static void __init fire_irq_trans_init(struct device_node *dp)
 {
 	const struct linux_prom64_registers *regs;
 	struct fire_irq_data *irq_data;
+	int len;
+
+	regs = of_get_property(dp, "reg", &len);
+	if (!regs || len < sizeof(*regs)) {
+		prom_printf("%s: missing or short reg property.\n", dp->full_name);
+		prom_halt();
+	}
 
 	dp->irq_trans = prom_early_alloc(sizeof(struct of_irq_controller));
 	dp->irq_trans->irq_build = fire_irq_build;
 
 	irq_data = prom_early_alloc(sizeof(struct fire_irq_data));
 
-	regs = of_get_property(dp, "reg", NULL);
 	dp->irq_trans->data = irq_data;
 
 	irq_data->pbm_regs = regs[0].phys_addr;
-- 
2.43.0

