Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9BE4B9217
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331377; cv=none; b=Pr52PjULNTQ/yr5IJwxLzEbFjzgeYZsHdLJO71rhZSxQe2pC2dpKltYfM9gSOdnA46E+6s2kCmUd+8ZXjdjYFdlQR50srG2GguPCZkAH//IhN0ysrHSjcGc780QbYsFMMJ+iGOFo+DHZGwTn1BAw+9Gj1I3C5nof1gjJxOYFhxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331377; c=relaxed/simple;
	bh=vjNze9pFwuYamoQe8DimXqpx4yhAb8nyRLguv8W/FP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOwWhJQ8F46o+vePu1m4Ow0cxQXjDG0wStBcyyOTqSoNGVDcvxnbxzogfFaiHT+1aWA6UjXhRk3mQX3LQKrQwHTQthATHxNckECi3jaUlOcvEX3cnVv+00wSK+roICzibtflxSSG1Q59TIxLZomSI6FCEG7Rvjrw2lKlXA+UgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIekOHqz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIekOHqz"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2a4e013a44so147302766b.2
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331374; x=1792936174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JW5bZpm7GPoO7pVkcm3aweioHrkQpRkv3vtqxcRc/ZU=;
        b=VIekOHqzIRhKs/C4R/JDeFuMMl2BBAk/QJPyrEUuub4wIKK6DCAJ0ysmbpXvRfOHUX
         W/0hPAKkRR34mTC2yl0iZIzfjMVV6CAsCWH9dbirEeCWY9zbNBIKvRRtA37n5AwC0xlM
         2tbdXenbcIIXBkLwI/kNQNk9bqXplpcPxJ/JAidmboPipC8F42GTCZM4xAyTjkXViIEp
         ER82YaRMy3SJ/DWp0/yp2OfNW/CbqpAgZFaFLKxwY5b99MNNJ34VVfxvkLP0xFgMThEc
         ydP4crIoEYS35t56+SR1rmlLkf/0b0Y666S9O+zMRX4PO4oEOq2SXAhxzgVoFbOnkiM6
         6Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331374; x=1792936174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JW5bZpm7GPoO7pVkcm3aweioHrkQpRkv3vtqxcRc/ZU=;
        b=GvBqm7e/1fTFoZnAri6YkrazZvxZ5gb4jxWI/VuXgsijn65rrZaU7UiqyCHR6SI1yE
         96GMsNY7I/c4qjEYwZjkqaHJCZyFpWQ2CgbaPeneJicHF3xGFiszHCPzXtzhOaokOZIw
         MNVT6KDjl4vXl6Fezd7THFDolnd0jYRigSGhDor+qEx1oPp2IgBtRaeau2lk+25PjArU
         gWQPMbKUK23Q1k6CYhIevW/tUHpPlAJaFS0KMqPidIYhEW4vH/70D+a+491uqK4U3eFK
         JD11/e6DyBwT3L9h6Ck8sY74ig+iQmn5UD8lO/Bh1iKv+/z2BJhJgPeno/6p8iwj7DgR
         opXA==
X-Forwarded-Encrypted: i=1; AKwUvBxptpZPig7G4gBxWCg+CUGXJGSGRMxCgkjtOsw7X+I1vi3+Qcp49MRYRcrnH0cOaZbJmt9P1mrqjWhzD4s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ9zPn/OzL5AwVSOkAPlnXl5jW03nwTaNEzgJ2gjSOBaWhdEiN
	DMUKploBsKDdDQzlixWCKdU0yFyn1RuLFCibCaIQBtZKFLeUL6Qhj6lF
X-Gm-Gg: AYBFou38bNzPloHxYu5WpyGUAQvqo23j0g83UsDmxBH1u75IxTKoA+vNGJotWT4HtBu
	H0yp/e0Cb9mO6gNhgDU2a4rZYvmDbRJasGzdv8QChp5mYBJuUdbL2HiXrBi1w9wMLLYnZuoc2PK
	4fAvAikLKccLmRMEX4tuojWNFdzyHE+CMkM9F76Bu6yLXE1XVi/njPWYcoFN3z4eJXjEZ598QHS
	iAm6uakpxDyVqD0MjFSUau1oAcm0CXrmydZk2+iL/P439IM5dizV/azDGgFTrizcIY60tRukZm7
	PM3RSMi/TK+ApSswc2QJHsIm7rSpiShgS9Yob4VBJmqvuENX6jh6JFjE2jO3QVRRYxWdajXhuHo
	wMWdunV6TaBGYFQEzCH0uIXCbnkDPBePHrg+q5aE1L2arRTqdHCGXwBOW4oRcifpFzReVd7p7w2
	uz9OTh95MMgGNL5fPkv9IBeMQHVAbFxuZE6ucKzaxm4Ze1x33VGFOXie7lL396qQuiVJj3U0zs+
	RWyk6NUvz5VPbRMOqucd1UqYB1HrLpeLdYcZJiF
X-Received: by 2002:a17:907:d2a:b0:c41:21ef:26ef with SMTP id a640c23a62f3a-c419ef2407fmr317025966b.20.1792331374388;
        Sun, 18 Oct 2026 06:49:34 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:33 -0700 (PDT)
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
Subject: [PATCH v4 03/10] sparc64: avoid huge kernel PUD mappings with small hardware pages
Date: Sun, 18 Oct 2026 15:45:05 +0200
Message-ID: <20261018134738.1016106-4-linmag7@gmail.com>
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

The kernel PUD refill path merges virtual address bits 32:28 into a
TTE, requiring hardware pages of at least 256MB. Sun4u instead selects
4MB pages, losing bits 27:22 when refilling a huge PUD. Sun4v also falls
back to 4MB pages when neither 256MB nor 2GB pages are selected.

Keep PMD mappings when the selected PUD encoding matches the small-page
entry. The PMD refill path preserves the bits needed by the 4MB TTE;
sun4v selections of 256MB or larger remain eligible for huge PUDs.

Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions with large max_phys_bits.")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..f3f7eba08469 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1696,6 +1696,14 @@ static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 static bool kernel_can_map_hugepud(unsigned long vstart, unsigned long vend,
 				   bool guard)
 {
+	/*
+	 * The PUD miss path propagates VA bits 32:28, assuming at least
+	 * 256MB hardware pages. Retain PMD mappings when the selected PUD
+	 * encoding falls back to the small-page entry.
+	 */
+	if (kern_linear_pte_xor[2] == kern_linear_pte_xor[0])
+		return false;
+
 	if (guard && !(vstart & ~PUD_MASK) && (vend - vstart) >= PUD_SIZE)
 		return true;
 
-- 
2.43.0

