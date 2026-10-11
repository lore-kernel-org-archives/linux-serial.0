Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD290457E5E
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748673; cv=none; b=JNHiqP3GvpZncAXockYNlgS2HbgjKiEp9rZORZfKQ5qNIsxyhnhODRfz8hvTeEiqLjqij6jbPZgFzay+g0z3HWLw4LWzVBNh6jOMLCCu7rRhqTx3nS/3pC2vPogv6BD8t/uGweO6bUgY3036VrCMBxg2PJJfjOXIfJyzXQsfsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748673; c=relaxed/simple;
	bh=Nadl7HsFYXW6P9DTRKvVWpxRaLB4EMXS+QpbLsbVDjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfTxGEH0uQ0cMW74+HrQJ8VqupUzdKZcFPDK0ZTefQE0NHu9mSI8/mRc398bI2KsXnuxfiVKNKbbEsNJtTmnr7MhcNlZAcQuCfnySh5HjOWcBnuYoI2xrhP6esYJcRUfBJUnTQ52CG8NEPReWSNTfvamkmdGzAz2OydwECcNxjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROms9/7j; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROms9/7j"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c263415982eso145919466b.0
        for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748670; x=1792353470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bd3F/qTb7l7go4vsYHnwO4e8nInvYSKDA0ySqIxH6Y0=;
        b=ROms9/7jMiTg+0GA5yfz0ljiBokccfUoeyAvsZ8NCtoJuaiZ0e8CY8kZqz3M4J7XVU
         SSvM7hhTuiE03VeEwjdnWUUEoncUTXlWGSNxH9ppoFDtS5B07xMCxB2nzxnaz8sDE3i0
         4WQtTymxISjjAuvhSThEqzhHvyugiLwxgBm+uOt792Fk1wHGY/EXqlFL6voaDwjmh0Dd
         ua5nLoSOHFdAmjkltTlc3BXZPZdLJPN9abIKunM8EuIFcH1pIFxmtDkw/4hRA+3Xylvh
         hw8AgRfv0wdYi2dWZ8JatEs4lDvDOYDBqYixAqY8Rnp0xaIHPa9RhkO+6+W7sZc9b2WD
         Arjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748670; x=1792353470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bd3F/qTb7l7go4vsYHnwO4e8nInvYSKDA0ySqIxH6Y0=;
        b=SQqWxYtTtJnMQIKnslryJUP/t8eRc9IIJKLuRpf/BBSsFkG8kusBHJFC6UpDx5vRza
         Kp3qrvgQtkLqrxpWIuOvX05ZjcmkWAtJHOp38c/y7CODLP+M/C1kMui1tXtTbz6sqkaS
         9ZYQRCyux/vqtuyiZqKtPBrc92ax9vo5leCeb6t789MRGazW4pr5kkbENpJI253VyCE6
         muL9rUAFAXpdKjeYypgIMKfeLEKfjlJRaNjb/mmT4n2Id0NIXZsoUnuGPPlL9s0mhaWP
         Q7wtWQZFZXF2LaqCTp0umXDkUe7WnLjXpNXWiqXmxdhzHo3bLfi7R1VyLSUoOf7Sio3K
         Pd2A==
X-Forwarded-Encrypted: i=1; AKwUvBzOJzreHHGv5yZ+zwBUCu+VD15U0aOHUhi+9ZzartgX0R/2biPgOA3wVuhh1eLcgwPLN17JIdLfMgfI8y4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLTWoZIHYptS4TzZvDHGbhA1FXxsj1NNWtXOZMQM2t/QbjwW+r
	aQjo0X7OaxZ+o/mnH2c++7PbEFtH2w52M2QqQePKGOHkCfRGUGkf5h9Y
X-Gm-Gg: AYBFou3pdt13zYb4d10FPz7oThEssaSXXDAd+OLxP4xNZ94oti1VaH3V5dFNpFQ/8yo
	SJKMhcdl1OKcoPx3mkDF98oP6qm40ne91H8vRmcDsIhq33hTArV4sjrbeMf0DyrBm02St4jel1E
	VKvWuk7EMUzxZZAYyU6l0LAlPmuH3fOAAnXylNR9W5x+/QKJFdHPYXMR4yMsMtK/EtUIu2RgZZw
	iQuub1K5XJgr+x0OLmVMnmAV7RxwvgpFokfLsBHBorsX+sCnpUtS1H6K+uRT3yQieHmfPjGgluI
	2EHOtHFBCKRCkSX7v9o8Sf2+TX7/XmfEgVWflQtYXWh504QxyHXNrj457Nw6Q4X2DHuQpbKtiBL
	j51Kivyi650zo23sK4ALsToEx3KzJiRYIXtOpD3qO0Lm09TB3X7FSjXxsjISANgMACRyVi2ckqR
	Q8U6Q+B/hk7tvFc4FoVYEmfJQbMI1hmcubfzX9J2i8+3kYR2I425k+GDyJkUPnDpgjhcUfrXwsd
	MohPHPxZq2iaTdq89msF7ftnQe0EjzQKneuj1RC
X-Received: by 2002:a17:907:9694:b0:c20:9447:bd5e with SMTP id a640c23a62f3a-c31a9fa1d3amr847020866b.9.1791748670007;
        Sun, 11 Oct 2026 12:57:50 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:48 -0700 (PDT)
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
Subject: [PATCH v2 2/6] sparc64: honor queued spinlock layout in secondary startup
Date: Sun, 11 Oct 2026 21:55:54 +0200
Message-ID: <20261011195729.981243-3-linmag7@gmail.com>
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

The trampoline's ldstub modifies the queue-tail byte of prom_entry_lock,
not its locked byte, because SPARC64 uses big-endian queued spinlocks.
Acquire the word with CASA, release byte three and poll while contended.
Retain the predicted-branch barriers for Spitfire erratum 51.

See qspinlock_types.h for the layout and JPS2 A.10/A.35 for CASA/MEMBAR.

Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPARC")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/trampoline_64.S | 34 +++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 51bf1eb92a36..62f404b3079a 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -106,9 +106,19 @@ startup_continue:
 	 * We lock 'num_kernel_image_mappings' consequetive entries.
 	 */
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* Get onto temporary stack which will be in the locked
 	 * kernel image.
@@ -212,7 +222,10 @@ startup_continue:
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ba,pt		%xcc, after_lock_tlb
 	 nop
@@ -326,9 +339,19 @@ after_lock_tlb:
 	wrpr		%g0, 0, %wstate
 
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* As a hack, put &init_thread_union into %g6.
 	 * prom_world() loads from here to restore the %asi
@@ -389,7 +412,10 @@ after_lock_tlb:
 	 add		%sp, (2047 + 128), %o0
 
 3:	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ldx		[%l0], %g6
 	ldx		[%g6 + TI_TASK], %g4
-- 
2.43.0

