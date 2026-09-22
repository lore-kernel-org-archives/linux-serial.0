Received: from mail-pj2-f28.google.com (mail-pj2-f28.google.com [74.125.227.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436034F24A
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065919; cv=none; b=W5guLalecTk8E8g5kjrNMEm0TFAjpx+TvsTss88MSMfcYp3iBRFdizNi/1IuaCgghXuj9RRnvDTQPPxoVjxFRs88cwfVD0+tSw+2tYvU4Bawog06P5GKiYfuwXR/CfvCOh7alJ+aVA4SvBy8nVxlEJFVluX0mFtO0B+D9mm5Kk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065919; c=relaxed/simple;
	bh=BreWabxS1IgcOVfBlTLTzSYVlReuPHPcupRntXaUElQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guC8lVx5kT94fKlWbBbm+rDfBbt3r1Sv8YhQTn3s1nKRh6v30XvBmuFRIKRwSKhJCGWkfKC+hb7KZmNY9FpmNzPXKKiID1/Y4Y6rVB8mWSAPXyANB1Zj7hY8Xfsu8/SGk++RSZ9ANB+2qKlOVgB+WOj1VzoFQR4h/8d4SIcFveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQjpVUdG; arc=none smtp.client-ip=74.125.227.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQjpVUdG"
Received: by mail-pj2-f28.google.com with SMTP id d9443c01a7336-2d91c22d27dso22771295ad.1
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065915; x=1790670715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TSWCHr4BZPj+fsKkGeyMKL1NbC35VprK/V45h09li18=;
        b=gQjpVUdGYCtnnUQUJuc3dn72/8SrsyKTiGo13H2mTMxAXvel5o0H2PTjcRa/zw+Chd
         RKNm68IN/MUCBilscJyoRgEsJvVJrAnHdUYzPwLpiBMlLgcNn/wW/LEXH+wbGCSJnqxr
         r8VDZKbjqjbMXVp0Gda3qG0XUdxMqdTxOt5hftspDAK3dsxf9oWhOv1SeftdtqHLC3kr
         cgtTkDXvuNkgYfjiZNaLr0/FtyN45hv8vnxjWfLKOzOj/+QCj+op93BLZvIKJ/k0k7m+
         8qNhzKIqdQFAfbC1Zo6/r/bcpiFPhzz3GDHpe1N3/gMpqOJjrpXq2A72xsYDazDJHwRe
         40yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065915; x=1790670715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TSWCHr4BZPj+fsKkGeyMKL1NbC35VprK/V45h09li18=;
        b=1LcVNNBVYXsuxXvfEe1pmyA8t3pp7+op+fscKxcQgRf0feidtaxa8U2my/TbPr7IyT
         Q1Rm+w5+YS22DWEK6J1pmlImgXgZkE0T94/oRExYjEaUT/Xd7XcIqis04XssRrdLArI+
         p22aRpwg03DIKd34L3MqRFujljRXsiOZV0DEQZi/tEjDQNXl/Wv7TKg42pwCWpDFEm/q
         kuzds9ZrpZVsjAYYvLF7wSVcl3XYYqjcnFx5RgddsxS3SIbi/Z6shNFQ//R4cB4RFF0w
         j0Bd5omFlIePQQW2YopeKcAAeD6Mr9x8lAEZcshr2gAsz6mudIQt+hg/VD6gqkvhFi+7
         IsIQ==
X-Forwarded-Encrypted: i=1; AKwUvByFLn+dcESUtCSJxZ6RWaKoUOfhVvC5l+1PG3a8XkBLRUtkh5JPoh9+xuOlq+Fl/Pshv1PUB/yRTi8Kd+8=@vger.kernel.org
X-Gm-Message-State: AFuF++mJLW3MYmcyhqyhX2c686NutFpFj/C2n/xfYtWxXcS+e7xEnak+
	FMdld4rTgGV+mwkCK1oB303r4hJaVFshCbItb87pIfjx2oTtTnphhql1
X-Gm-Gg: AYBFou04MUhy9EOmRb1oZRv55/Pb77+lVv3c+k3T5avskkeVfO6z3gViJeCku/47OKp
	EuQ9J0NpEAoPap06KLQU5IwelOcUu3OBHkAHSV8QGVX3QyUIVZRBhGPdaR/epBfJy/oedrliXFk
	NJ2pxLFVQPKAX/XezFUEr9uZeufSnFAqNmMOvBANrCYKPr/eEfYPFZD4jUQVjz51PCoyqWgwcQG
	95BTvmdd3TqTHsq31z0vUEaYydcl8cqW0BxV73uxq2SKriSZ39RLKnlfaIApZg6fmKzPFmnxD8h
	fjVj4LOez4k0w2Mo97jBcC/FKX9jTlmjYFBqOQTnr6wDRwgwHKQ7yQ7+GAfB14k7cVqFB3Zl2WQ
	HXlJBS4MCW9BbvDH8kuSAWwVTcfhqgVk5GtEIiBqYcvxVBnmbw2aqAl9v+G+aGu+vEPI68nv5L3
	vYDM1+jcBoB9N5pexLD0TBBHQTNYpjXV76AKR/t5Ew3Iy29RbUy3upJoHt3+Qet8xCtaHcua3Dg
	3Go4aubEDDa+E00+HfkEA3xVBVMnJPjBV6p5D5hBL+otLblznhRfW9o3RT1mvH3136o4QmfYbb9
	IYlcCgJ7ElKRfD3fmVMw
X-Received: by 2002:a17:902:f60c:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2df609b1b44mr6069175ad.5.1790065915093;
        Tue, 22 Sep 2026 01:31:55 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0197d3sm5848175ad.13.2026.09.22.01.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:31:54 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hui Peng <benquike@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] serial: 8250: hold hash_mutex across IRQ chain linking in serial_link_irq_chain()
Date: Tue, 22 Sep 2026 08:30:49 +0000
Message-ID: <20260922083152.4055969-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260922083152.4055969-1-benquike@gmail.com>
References: <20260922083152.4055969-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In serial_link_irq_chain(), serial_get_or_create_irq_info() acquires and
releases hash_mutex before returning struct irq_info *i to the caller.
Before serial_link_irq_chain() links the port into i->head, a concurrent
serial_unlink_irq_chain() on the same shared IRQ line can observe a
single-port i->head under hash_mutex, remove i from irq_lists, and
kfree(i), causing a use-after-free when serial_link_irq_chain() accesses
i->lock and i->head. In addition, if request_irq() fails at the end of
serial_link_irq_chain(), serial_do_unlink(i, up) calls hlist_del(&i->node)
and kfree(i) without holding hash_mutex.

Move guard(mutex)(&hash_mutex) from serial_get_or_create_irq_info() to its
sole caller serial_link_irq_chain() so that hash_mutex is held across the
lookup/allocation of struct irq_info, the insertion into i->head, and any
error-path serial_do_unlink() cleanup.

Tested in QEMU against Linux 7.3.0-rc3 by configuring /dev/ttyS1 and
/dev/ttyS2 to share IRQ 3 with ASYNC_SHARE_IRQ via TIOCSSERIAL and
concurrently opening and closing both ports from two threads in a tight
loop with KASAN enabled, verifying 0 KASAN faults or warnings.

Fixes: 25db8ad5c567 ("serial, 8250: remove NR_IRQ usage")
Fixes: 99fc860fae83 ("serial: 8250: extract serial_get_or_create_irq_info()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- No changes.

Changes in v2:
- Split the 8250_core.c and serial_core.c fixes into a 3-patch series,
  add Cc: stable@vger.kernel.org, and document how the patch was tested,
  as requested by Greg Kroah-Hartman.

 drivers/tty/serial/8250/8250_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index b875d394796f..0bc810f285a4 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -134,8 +134,6 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
-
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			return i;
@@ -156,6 +154,8 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 	struct irq_info *i;
 	int ret;
 
+	guard(mutex)(&hash_mutex);
+
 	i = serial_get_or_create_irq_info(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);
-- 
2.49.0
