Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400483B4EA1
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830935; cv=none; b=UhRVKPEQmbZ9c/bYu1iCVkPVflBjrftMrKWz2vCeczL4+9l0Xd87ml9tvKs4dZIhYMKc5N2wGjpM4/TJ9zqOCVNM7RZIkJeLVTbNBoaB+7zdunpV5m2bzVj3ocxCDQUvSmPqCeJqoay5oetSXLtnSwpxUJTsQ5HSvxOOJV3hiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830935; c=relaxed/simple;
	bh=ytqbOVvXrJO6eXGr1gEj/F4d+JQaBqdQ4fhCdMycmpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxYGQ3zaizgBQS4Gt9d6P/TqybQ+cvrvfvvxd4RMim5bXUBj2tSDuicF2JIfS97/DI5cGb5rnzr0KB2FgzzGTFDxQgcedKv5MkB8vS8fDVtTgKI/LEythTM1YtTC8oJBItqX55vqBn/sG20Ge360cN5Ms7oZLN6zM6Uq8moa4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHAHO+L/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHAHO+L/"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c31745ad205so686195266b.0
        for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830931; x=1792435731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJQ3Hg947nYGt/YgtzMTiRanQurATHC6+G3Zb6saEl8=;
        b=OHAHO+L/oIlGbhrvFO9sx3GmCkpPxx/dUFtSJmn184TLk/WzkE+eDUvolJrTILtsSX
         Y94YQBg6D0vifPosVtoavLljqtvdgCKXcrUs+nOKnh88uv9i2wAmw149AYeEc3Mps/vS
         Ht54VSX4On9f8yMBCcK9/oQfVGDe2h+LjNKNraQf2QjehJNaZa3Dsl//EVEUYywyVJy8
         LABvZLJwsDD93UsL/jD9G9cBwn2pwLM40VKag2qB7iXjKsREzzoh9BThtFt5vJlkW8ki
         rsSeggGhgboIVcTM1AjbK7COcjxpJwjPoHr5xbGdWK8C/OA0tl8RD5Cf+wybJe3duTQI
         Y05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830931; x=1792435731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJQ3Hg947nYGt/YgtzMTiRanQurATHC6+G3Zb6saEl8=;
        b=HCxuX88M7X5+OjcqQ5o3EhXBuR9GGQSWbUuupeF7AVbNNXgBsWFhkG9gybrTS9qLzT
         rH/aC+neBwT8r+1dKwtPZnzAt9LnByPi5W2vi2/ODMXbXXFh1kCQeTQ/+312krRNgoP0
         pYF+utARZZjYYkPcqTFswL1p+Jk8HDPgUnmi3eldZSX/c24W8iRHLbVRFR3BTn3VhB/J
         KIuH64NCUaCEIMabFOA6S0rkruprb011yraoE5AWhKmo5Mjccp6MisdcVp1d0jgETuab
         X/nUXBOkqkZaaSRcHR+hLVpVLIteRQ1M8cJFpY4ac1yVosb3DLMoaqAXsWLpQTePo6Pm
         nWiw==
X-Forwarded-Encrypted: i=1; AKwUvBwPZB5eHb9T1CGDaxa9hUZ2cd5dFquyPxDmm6m4dKxed7VPzxKoldqoYHMbCyiPcbA5OuhUbHy3YGSct14=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEKzFPABgyKgmKYLQ8KL6VB231vLCATqTWQBh0bfiMJkpzBEE5
	17eAY5zCZ4XHw9ZDch9pICPo0NPLGiiNxaCFaz1CCuAvIohTT1Cbh0/bX8aXUuRe
X-Gm-Gg: AYBFou3uq6fv2EyybxLrHN6u/qP8K38HSf8RxZdF0RRouh8E/UWDzrtFr5T90KgMYlE
	U5Tl2JDl3OYiIOCkqrjVpx7RnOspd/GPdetLqUgWsj2GNUq8bS89S0Y9vdGAoRh5ta8c59djvz0
	he/pECCl3nm4Swwr9WaVMC9kCOVnf1fvGjbm4W15sx8sUe7F0vMPt93zXEic3SJsByUykrM+7Ya
	6d5eIMgKGwiLyFPJIme4+W7psb7mL9aSReNP1GhByRjyqxYDoqythWsycy+tjd8T3RVcMEVKqwm
	5zBqYDgONWPHGckP8sjDXZnBxqYs5RvJpAbPH6rlbgrNisCML3Wy6ECtaFD2dJGHDKpz67pDY6F
	3t8SiEPJCY01DCdfDLCjLNkzjyjsaEnvIl/gBaNvRw7zwBDb+Il4qDrzBbuTV9rdQXMmqd+5D4E
	EXbPTau6k9ciW11nU1WYjRt0ohSs3dRmXD+N7aacadQySlvwcaZRG3lQB+telxfkdT4q7qxJ9Oh
	wBW5Nvdx+IE8KGYW88SwW73G0uLEGyYox5ovaGuGdptip6J2Is=
X-Received: by 2002:a17:907:e105:b0:c32:465f:826d with SMTP id a640c23a62f3a-c32465fa3cemr482522366b.17.1791830931322;
        Mon, 12 Oct 2026 11:48:51 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:50 -0700 (PDT)
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
Subject: [PATCH v3 5/8] sparc64: validate Fire register properties before initialization
Date: Mon, 12 Oct 2026 20:48:06 +0200
Message-ID: <20261012184826.986050-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
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
