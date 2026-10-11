Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60645D939
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748681; cv=none; b=lzK1HOM67pKDFdEBc8avSop5HWEqCwCxzq4/AsP3t1xhEegsgyuScgSt1rS7Wf9hzE09MNHyejRybj5e3ribg3Aq79FRLv9O3MllFOZFlFwOdkYPycwDX8d3iElEF+Y1Vq8r52TG95SrlqSrYTTiroCDCJyeMhSfplYF6OiFjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748681; c=relaxed/simple;
	bh=9F9PqYLol8RYefMryvIE9X8WcFhHN+25KlDi07fHopY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOtzZ9yZ2DkLqI5vLulRIQzFHVaen1r3SgCEUWt2swljfoADrmaTnuNCm+pW/iX3yGwod2i0nVXC2fUKgm02mFBmE7Gm1ToQkhzu1NUJlmLYVH+hrvzFr7ETgG26QduCpxKAjRg389O5IQBgzkzEfkj/aBQGTBrK3EFoHW3cnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu6MxJgG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu6MxJgG"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso218585566b.2
        for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748672; x=1792353472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
        b=gu6MxJgGhJ5fAuNey0baEcOvMpS/TXv1PMlzICuUjfuRcIWwg7oXnNfZbT2TBx+8oH
         zghvz02xttXd3lmZDw/J2j2tb2Tnx09itP7Hx8INrhakLgmg+MhFOXExPokaZo4pBaK/
         gvN+PlzsAbR/5z0JjcZRUb5rFA+UyZI4RbNUfVBHSm/oGlGtSFcJeJIHKjJXamzbj/Xn
         q9FLJMUiYdkWphP+YOUeamzsHFX7Cfd6dWZ2Jm66Ki51kGI5vWpdz/8rom54bV/j70CY
         r1Y674ahs10SCFMtmngXAhDdwDwwPga6G6N/x/8yduQA5bTv+XwAm3zPUPGpYJ2W1FLi
         ChCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748672; x=1792353472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
        b=XcfVfX5kvjsZo75YO1194L5/EUDUK6O40QqYW5RVSx38tbH3vOvG8LT15r73fXT2ph
         QMK/4qVevVMkBIJymtInr/UbcKEW84neyFCH20vU+JIh6+pGWx9Fj4VRgD/VsqRwKnQc
         P3sM6RwItgm07/weJV4hQIpkxZ3D3+wFvFNrGp5afKfDDJQgRDp5+dvJImqJKO6SrLti
         Bnd2r/W/fmFsFy/gp2LPsX8K4rfImJl05jQuDw6LYEnT3Hodcs04QboYgVfvD4XtYuVk
         CLMJnY3v5kef1a6Jz+jro9MSJ2AIxJzyj/FzbPeOQZOnsBUhZUDlDqcoLMIzPTvnR+Q5
         /TRg==
X-Forwarded-Encrypted: i=1; AKwUvByHHX/pDvg3HZAvwiS3zdDfsJbdIf7eRAqBeMoU3nMSQucwICP689mGkDP6L02gq6rQK86fE9L1sKIhzyo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtbp/uCYkb3IFyr68lS01LyLsWuOJKe8iox21YoF8Vo3NRfVn5
	X7IyG/K72Bm7trueGBIBoO95uZP9wqhSBs8MUhzjD+y58BkE8UEMhJNm
X-Gm-Gg: AYBFou24ZMp6s69cqD7J8+89XOZ9EP1ZvhpXoWIGJI2uS8F/MXEl27adMVQhPP1u4/C
	fSAbrLjWZaPcu3Kt0BYGJmbB07odltQgF1KMI5KysUDKKffiwik/jrxDB1qmIgzPLWZYnaBLLZj
	vLt/FFlmvKss0L1VYdgY/6iKQjbF/Ug+r1XKyjNnef3MoTi4RdxZs0OyGT74TEusp+llR3bfLZ9
	0uQFhsJgjvOu3wUEv64Bqa6ekvlkDzFdS03v4NjS0NsLUpStBlsLeHLHBhAJQAcMxPviP0xqfr+
	s7Ry/+5CVRIhgEKBxlAoT8ctzJhw/PCMgHN1TMCwNA6peg4W3oa4van6NVfKLkySJa0mDpHF4v3
	Wek/9rT46CXWNxUjMtm6JEsJJwnx/8mcmizIhq7lAArP0gy7vLTjPrc01OfRfGrrEb8qCP1S1dB
	CwTupHXSrlJ30VcwCeM7VVCloxGrBc/4HrmLGVBfttfhfzkOfY51+IStlge12ERr2SP7gxz5Xkx
	OP793OZTSTmAWpvsJHZeRh8lX6f1GUmQlHIGUH3
X-Received: by 2002:a17:907:7fab:b0:c26:1691:b368 with SMTP id a640c23a62f3a-c31a9f6b728mr805802966b.33.1791748671740;
        Sun, 11 Oct 2026 12:57:51 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:50 -0700 (PDT)
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
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 3/6] sparc64: avoid huge kernel PUD mappings on sun4u
Date: Sun, 11 Oct 2026 21:55:55 +0200
Message-ID: <20261011195729.981243-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel PUD refill path merges virtual address bits 32:28 into a
TTE, requiring a hardware page size of at least 256MB. On sun4u,
kern_linear_pte_xor[2] and [3] instead select the 4MB fallback TTE.
Consequently address bits 27:22 are lost when refilling a huge PUD.

Keep the kernel linear mapping at PMD granularity on sun4u. Its refill
path preserves bit 22, as required by the 4MB TTE. Leave the sun4v
mapping selection unchanged.

Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions with large max_phys_bits.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..0ae97e616435 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1696,6 +1696,14 @@ static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 static bool kernel_can_map_hugepud(unsigned long vstart, unsigned long vend,
 				   bool guard)
 {
+	/*
+	 * The PUD miss path propagates VA bits 32:28, assuming at least
+	 * 256MB hardware pages. Sun4u uses 4MB pages here: retain PMD
+	 * mappings so bits 27:22 are not lost during TLB refill.
+	 */
+	if (tlb_type != hypervisor)
+		return false;
+
 	if (guard && !(vstart & ~PUD_MASK) && (vend - vstart) >= PUD_SIZE)
 		return true;
 
-- 
2.43.0

