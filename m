Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58763B19B7
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830932; cv=none; b=mk/bo+nG+aqclfiKNWTYxecWs4gBPgSs7wM2xOu7a3ciNEYFo1VHtCV1jkPbgjh2Oyz3WPr+J185rUa1cLr/YiIKWQQiXRMPmXimzuALC4bYe8Um6VftzPFuOjz+1gFSMQckcJXl0iWaRBKvWk6WmTWUKpZbw3MVXue4xb5iP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830932; c=relaxed/simple;
	bh=lHqcE6L/05Y5Gh1t1RuDhITcXofphAcppq5EmdQFuLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAx9iTQSa36fKCpzx+YcXyPufIwptxVYR4qgXZu9Bnkp3cJzEt3q2EY8LFPZWuRBcr0kW8ilP2+JpO+nsWnqvnHiXI5Gy/YfDXlkOCg4arz7DIQ4D3RLsZLrzO9PEVfj3KlV+IZbDKSkVlZofUH7zW5nGCykldZ0dE5us2aUsQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvuY6mhq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvuY6mhq"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2e3846d1caso369447466b.0
        for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830929; x=1792435729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gLypezyadrnh0M08opMU0Y8wfZpigwqaTEA/o05oR4=;
        b=EvuY6mhqmnypJ0n2Q2Fp++Ax9En4JybsvGIqnkiTt8bUda9JnoUgoEunpGUnUWIyQm
         7uhsxchtkzG2euYZly+A0xSeDs31XF6WBW2z8TaXC8IyS6bqcbvYdYoqQkLjnG2llp0M
         NmHazujB73v6dFUUFMZB8ebT1p9uQPe3D1oQ2efn0dE8cnHytpKz8IMhH6XjfBg+yUjT
         c99Ccu+hHpeMoK/LXmR/4NTIcrToEjNqnFa5e33Jhd9EyEN+/2VX+3gmwCD73XWF99bW
         VLEc6dv8UBfziVMiLqjed/UM3sSD38GghhQxxQM3vdd7gZB2o/FECwgM/vVbIEf5FQEB
         af5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830929; x=1792435729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9gLypezyadrnh0M08opMU0Y8wfZpigwqaTEA/o05oR4=;
        b=bJqJPAmj3lXdtx7kthLsOcpG21UXUz6v5cOQW/BJqrahuXrIRhiCQQ58YDz0Ycx7/r
         2ofxv/I73mwloey6Ygqgc5peqc+P0Tw1xACptp/j9FY5HWSKdkMJVd6c5ucKce0tye2O
         7jMUmI9pIX05VHXA3xLdH4yCSlqDgD5QcjCs3NtZ2p/HPLETV8ntM7FeqtI3ZNFllA8x
         HniimXbUpUivhmj3TV7MdLt1ty+ObogSI/9JUBHq7z6Rw6NXq/9quctsTSbUl5R/LjrC
         keP8wL0CegRtkMt6H9ZkSXQV+Tm3GBr3V2iujX0i4+ZaDS50FeZ2/qRptvxDebzBc67/
         aFeA==
X-Forwarded-Encrypted: i=1; AKwUvBzyV78BvLUHG2skgO+mIM1Pli/I6z/35AVQHPQ+ihON0sanTDDRooD9vRGoX2b44WKWjRRzqubZq7oXNFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOulVJ5DlEgYRXZP6BA2ei5zt6Ik4brmYXOaN2T9D2fsaLNgsu
	zPCSj62z3BLvhITHmGfsZ7/vokikBWrNwLoqGod0B5c6zmrwC67fSG+1
X-Gm-Gg: AYBFou17+dzjq4+BVCRipyjl0XVd1OnLW7BQzhKf58g9ehpRNCY0aVE5G/FCopkXjhx
	S5g5J6qJi8coZn65SkfWvbkl/kaqQj8OF4XkWrUpkrDQABfOav/o5SO/ebxlmDdBtZK6axrzLji
	LyR/k1gSGWM6aUxcJom6PZIIL8G2l6TUkLfq1gKXVWfyGCgO4FrjLceLHdGC+mqFe4pR94xtOli
	/Eigs2f7CHlnDboEmf4x7dTDIkW2efWfPY3yhyVP+h4iiynKplAqwDpKM9+7r5Ls632gm0JRbRR
	3lKo4ThEAijr3xNIbdzjN7gz0xsX93Jh/08Y7jxKghoBEXdtKnf6TDzmo5Wwb0IrWJESvJH1iZo
	WmZ1FKzILlWb9LLzHj1z7+DcnrPwd0JJPUQba6K+yrEyah6H+R7rAPpeB3pBbDM7msP9ORtKh4+
	WouYd1Ry37dba78GYuisaLLEAp+QgsKKG0ahJXBXuV/l8LQI4HVLnQ9cXy80nyAmypk5pbElQC4
	C4UZsWqPV5OMofK5/tMW3ejkhEdNPHfA5oJ7kfFqGm/VTiIcwP4
X-Received: by 2002:a17:907:3e0d:b0:c2e:80b0:deb3 with SMTP id a640c23a62f3a-c31a9a10e74mr1102093566b.7.1791830928881;
        Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
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
Subject: [PATCH v3 3/8] sparc64: avoid huge kernel PUD mappings on sun4u
Date: Mon, 12 Oct 2026 20:48:04 +0200
Message-ID: <20261012184826.986050-4-linmag7@gmail.com>
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
 
