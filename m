Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE114AE109
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331381; cv=none; b=h6jHZNNuFwD4ex/e5gwiH+gfQRpNXP57OPjOAKjHD3LR8F+cuSryFL+x8GyL9tV1aW4qETqPceRR4CnaSOFI1NiYdklUQQLeIv0lhyFLZbrVAfuvTkgioTH+sS80jA3rkOkxuAPmE1d63768kQcQUg2SxFR4UuJDQuynIyh3xI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331381; c=relaxed/simple;
	bh=XS1hfUYBh3IHnLjqYMLanotOueCfYEigxxyKMp4yttk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxbl1VaL+U+B3kaZe0YIhtRSRnWmlqgr5tcg7p1r73/EhZWOPgWQPEG9OkwP1vTzBbgGhTE/duhFlXvsEoNmrlXbPdb6uZYWa/jHuzf5pVf/KrjRfb03Z8a4bO0yRjRC6ljZMqR6Xl5C16Aooz5lt2+GRWigqN3nlkq6NNDUIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj8PuAXi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj8PuAXi"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2dc63f8d8aso203961066b.0
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331377; x=1792936177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrgtN1CfIC918YQEqPq2f1RcPZ7legyk//5piQ8+dDY=;
        b=Uj8PuAXiQssCE/myuDDwafEFSpeV340x80XfFsgxdHrd+PxxleJDzx/TwHIqlmwp4+
         8U4EVOrpnDpIQzUtjR8WWuzvtCRYNuGT0Onwt0GFEtMjwhJCAWZ5oDRDiEYWU94zswH9
         eGpZyurIuSwm9/7UxN341UmN0YhqrCCxpXuqDAW8VNmxZLRybHX57+nEUInhfMYWuv0P
         AOqgdcbaBwTi8kE0dSCna0saVPC8w/fI6Gif77TBMUZKz9PZIukq7rmtHjQP3mzfhz9X
         Qw334Mx4BsYcPajENS3EoMN4L8CAbMkUb7El4VjE2Xc//oXymNaqMZJnj7P/rC7XfXOV
         z8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331377; x=1792936177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XrgtN1CfIC918YQEqPq2f1RcPZ7legyk//5piQ8+dDY=;
        b=TvhsAOrcoOG1YMJGT/MgLgnQtLwXn0CIZUt4fMS8hrit14272Y7NDHHWhq5URN33VS
         gTq0PbEPX+YeiF/1CmWXpfEKUC6WJF8woOz9PXRYi/rHFeq65A4JbkJPlbpqlz2PSpmn
         Ak2gz+u5hUjN8WmaW5/FaDvn82dygTSm/USvp6qAl7UXFWj638O3hQtwIrgLCe8Y9yxd
         anFe3ixrvlqdvLIo0Ju2RZrL7hSXJk/6HBtjPaJDieVMT+Mu5Um1uyywzaExCSB3lhqC
         zb6xkJZvF3KsQCdCxzARIkYknBu04xLwUX4wPz7LHk+X4Hmb0jEbnOpSl9fvOEnUblMg
         6ieg==
X-Forwarded-Encrypted: i=1; AKwUvBw+ynEVz9KKKIfFoTJnKMAoi3axFjJj2seTe7L4S7ldRobjnpze0MZ/7V4r6cBWB4ITwSvrrCNsEHpGd5c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLY501MF5XQr2aa6LJW+bydSPg557biO7buRrJB6tyIEWGoZjML
	WNGh4McMVyMova1U201LeIlsmTy0AyMZCEBGcB1jyPuUJ8aK7Jtlz6c0
X-Gm-Gg: AYBFou1ZlsX97IwxqeCVdYppnUqo+MskleTxEpKZpJb9/H3kMK+FN/BMgVdvIr9oxSr
	l1TfR27xZTv2C6MRBzhF1hkH7tnjKgwxVVrutiq6T1vGwqeY1ugNe99iFrOceL7jDmHOppeh77k
	eHdGf66cDhRGW6H9x41Wp4hEjgTSnSPrukk0AcCzmJdu8OeQlMisCYxSTC6RrL12zlBZ1zuAdci
	6zU9Eg3NlZ/f46A38yWoQ7iMnQvJQdk4iYfNbTUjEY3qB6Er2FNR8iATHGLEVVAvh4d9jdKsfV2
	sPEPoyMXt2fuY5rO365pldEbCg/4EkcpcgN/SiNUFGy8mP7pXjyDkR9Dy+y8mv3y2u6fCgUKfox
	LjRVIQ+idn2ZHGVRN4xQnZX8TTfmcx/KRkbqvUrFqQNVWSGUJsi11D3rlPHmqMvQfcgZnFk9zjk
	OooFEtK28vvFf59MOqvmt17DSQoo1MiHmS+jDM01UKa6VTIcAuWbmkCeZMATQwD5VzhMM/B3RGM
	os5mf/blhJIUAVwK4/D58bY/DMJpSedv8boeiD4fM5XQnJtuts=
X-Received: by 2002:a17:907:c605:10b0:c42:a326:78a9 with SMTP id a640c23a62f3a-c42a3267e26mr126187466b.42.1792331376760;
        Sun, 18 Oct 2026 06:49:36 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:35 -0700 (PDT)
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
Subject: [PATCH v4 04/10] sparc64: stop IRQ setup when descriptor allocation fails
Date: Sun, 18 Oct 2026 15:45:06 +0200
Message-ID: <20261018134738.1016106-5-linmag7@gmail.com>
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

irq_alloc() returns zero on failure, but build_irq() then configures
IRQ 0, which is reserved for the timer, as a device interrupt.

Halt before publishing the IRQ or changing its descriptor, matching the
existing fatal handler-data allocation path. Returning zero would let
callers continue treating the timer IRQ as a valid device interrupt.

Fixes: 8047e247c899 ("[SPARC64]: Virtualize IRQ numbers.")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/irq_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 3f55c69d5f3b..4cceeba726ab 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -619,6 +619,10 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 	irq = bucket_get_irq(__pa(bucket));
 	if (!irq) {
 		irq = irq_alloc(0, ino);
+		if (!irq) {
+			prom_printf("IRQ: cannot allocate interrupt descriptor.\n");
+			prom_halt();
+		}
 		bucket_set_irq(__pa(bucket), irq);
 		irq_set_chip_and_handler_name(irq, &sun4u_irq,
 					      handle_fasteoi_irq, "IVEC");
-- 
2.43.0

