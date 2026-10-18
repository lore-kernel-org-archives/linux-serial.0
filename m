Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D14C754C
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331377; cv=none; b=m0dCoIfCKt+6sEG9RNf9rGVQWgJ/Bq7o6ap5SdUjeR8XA8ZcBIWKi7pKdFxwKuQ5TaqmhJTIhFDFhpwSTAGlpVCuJ6Oz3zhWFXyl9915D/7uhv36v8fIWy48+Tha6d4bRg82uuacl223cNIu08Jj4eG9AFCh6rRps52SKQOm6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331377; c=relaxed/simple;
	bh=G1F+mYzfQRs8/KGGawcQwgU5uDFp2pGRLYCJ7R+lFk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el8js1UE7QgVdVkqmjIApRr2Id1Rdc/3QFpliG2+I9WRWfjRpQwZmaUmmpos14Z9R108hGic13twuV0J/FGKhqiJ7v+BSLh8pvXFTWcr56tFKSWEp1msrXcRwBPqdwDEJIaqG0JqdpHofC9h0o43GbUmKPES4a/eE0VCtaTAXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLSpp+ft; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLSpp+ft"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso185208666b.1
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331373; x=1792936173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q77PTRWOtCfp0qFp7JupQqKfjSSIE44rzpjVu0S51AM=;
        b=VLSpp+ftSBB82aGe0/Lkd/RfqraEpUZGje0VBXeLwN7SbzpCltXVlKdBkRLTLCdyvL
         hvesBKng28cvD2X+NrsYZBKvEM2bc82kR/cS+mBoy5SmuoAArXPoXMCiJXaqdf6liRof
         ARfk4vu/ldcOr4+7Z3Ap1N7UUiwKWVQUSd3KSQP9JpQp9N/c+YIOyFTU9QkYRqD4zad8
         yDo8Hc7v5+4UYyb9Xvlw0jpDtML9mSpWkX8O2lREWFYR8UuXMEh4WJKh06ZYZHVZzeB4
         z9wCOOjjPDF/Jk5y8qDaV5gZsnPp/5dphAanEI4L58Tteh5D1EOwvyUYUgYwi8r9kZmX
         nYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331373; x=1792936173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q77PTRWOtCfp0qFp7JupQqKfjSSIE44rzpjVu0S51AM=;
        b=WRJcjpiHcZgSXm0n8CnbKxZ7kUM2hFM5tvK62PFujABe4E1lwqfd5uCcSnqIwlQILa
         379EVc1hk+jJfFo0AtDQ109iUrlLY6kRAE8CLuLV02hzs+pYWbZ40J2F//OxVrKIKMWe
         TF3wSzrul5NKuP1G//mq4BKsOw0/obVhQ/qEm1nxgf0VUjNKJOeIWQKpr9ZQ72yCfXwv
         sO9d2SgIYQwz3Pf+gqwpyf+3qEHdwva7w0UK4sTO7/tF8U/2MP2377IRpeApoHIm04Og
         rni4GBHZFbC++2+edXEjwnmDz7L2aBDmoz534ZvdOXXX1sw58k0YzY5MMt9ZCKeWW88V
         Hvfg==
X-Forwarded-Encrypted: i=1; AKwUvByExvovTkWeKLYn++9jYe2LWZ9+5AhHF57BCc00kIAujE/910rWWglOnGjaFnTSrcvOqU1d3betxg/7nE4=@vger.kernel.org
X-Gm-Message-State: AFq9FYISJOoCf27oisFhnO+cfiU6aTzDkoiD1VYKXL083yihsdzxS9Am
	mfC3oft2Pj/gUbXsWqw5OgbBGD5LP3f/W4O4dvfLwhxlpVoE4HK5khuC
X-Gm-Gg: AYBFou08RIcvJpKUQVJQlNrJMg/+BEKXSgtVF0ttpT31o2Q9+1Yk1NM/E1W05nmiXcX
	BwxTT69E8FfkgcceJ5Ml0sVDG28SKyJ3TKC0YqmKvLwUNjQlOZ2nSPoHjPHAj6lj7swgovTn8wz
	6wnNMpD9Gs7rmne1g/kBsPquavfPcJpWfez7JJW99Brfy6UpdozTA2Tzox+PGK4HLiJr9BOJDA/
	9G6o1PSVbMImrZ3Xv8jESRGz4RGKi2zzZSKXM6pRsX7NdNUal8PGNFiZ0YS+x9C/1hQZ3dJLjue
	r0HFOO+roN9rBJRWYsR9BailAdVWL9WPnFa0SGH711XdjB2d3ctM1p3MrgEQH78VSPe+jKAma6O
	W+Dbccjl8q963+Ng2GYO0hAdilQPI707Y/Lcg1eZ+lwztlKBzAGMGXb2wtNYiRUBUeBuTbd6dd+
	R2BNX5iMZ4WzOhjTHYNpif0LkjECpWJIKkeYpFKFWgCMGcDQrM6F43TEnRjp+UDChqYQz/SXC6L
	1X//QUy8cef/f7YmQSjG2zg4xJEzHC2B6Att4rk
X-Received: by 2002:a17:907:60c8:b0:c43:a881:3f4b with SMTP id a640c23a62f3a-c43a8814361mr97331566b.47.1792331372603;
        Sun, 18 Oct 2026 06:49:32 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:30 -0700 (PDT)
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
Subject: [PATCH v4 02/10] sparc64: honor queued spinlock layout in secondary startup
Date: Sun, 18 Oct 2026 15:45:04 +0200
Message-ID: <20261018134738.1016106-3-linmag7@gmail.com>
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

The trampoline uses ldstub on byte zero of prom_entry_lock, which is a
queue-tail byte in the big-endian queued-spinlock layout. This writes
0xff000000; with NR_CPUS < 16384, a C locker can decode that tail as
CPU 16319 and access beyond the per-CPU table. Testing this byte also
fails to exclude a C holder of the locked byte at offset three.

Acquire the word with CASA, release byte three and poll while contended.
Retain explicit assembly ordering and the predicted branch for Spitfire
erratum 51; C unlock relies on TSO and compiler ordering.

See qspinlock_types.h and JPS2 A.10/A.35 for CASA/MEMBAR.

Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPARC")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/trampoline_64.S | 40 +++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 51bf1eb92a36..447334730122 100644
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
@@ -212,7 +222,13 @@ startup_continue:
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/*
+	 * Retain explicit assembly release ordering; C unlock relies on TSO.
+	 * The predicted branch protects Spitfire erratum 51.
+	 */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ba,pt		%xcc, after_lock_tlb
 	 nop
@@ -326,9 +342,19 @@ after_lock_tlb:
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
@@ -389,7 +415,13 @@ after_lock_tlb:
 	 add		%sp, (2047 + 128), %o0
 
 3:	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/*
+	 * Retain explicit assembly release ordering; C unlock relies on TSO.
+	 * The predicted branch protects Spitfire erratum 51.
+	 */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ldx		[%l0], %g6
 	ldx		[%g6 + TI_TASK], %g4
-- 
2.43.0

