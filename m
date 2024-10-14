Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE62914;
	Mon, 14 Oct 2024 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728865441; cv=none; b=RYr3lLdl0kunmEL8me39WyPh5YpIVNUMy84OY5UqsHpm07IF88wmocyBzb0/qT1SKahqALiTt8ucZ0BkiOsLhqL9cZfJPqjF2hf5WBFPy4AS/nhwlgNBdqIpyunLqlu3RMre2l4UekYF2kMQFdTqPX+tCNezbClcSQpFxB93aQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728865441; c=relaxed/simple;
	bh=XBA2lRucLBPpWkMjO2VOWMYeRT+1cy4biQFRbLH41Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5avIQ1JTvfUARrE20Fu2nPbnTcdunb5M1pMgF0Gf2u1MBG5YUKGHItlZ+uULjmFqXBCLr1K7y9jFL0LET83FPYYIDV5uZL6ubTS2V560bEY6BwObqRdbUVgehBn+EHsQh86qGD4MDWebsfGlh3Pv60z68aQSinAVKuOJHE1myM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZOhFITt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZOhFITt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB7FC4CEC5;
	Mon, 14 Oct 2024 00:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728865441;
	bh=XBA2lRucLBPpWkMjO2VOWMYeRT+1cy4biQFRbLH41Yo=;
	h=From:To:Cc:Subject:Date:From;
	b=pZOhFITtIdwiQajF702TjukbYHq5I+EqHaLsOmmhzdw7G4XUtV2L/c1Oa65JRv44e
	 PHrWCLlxGEOUsXCWynkPynV3XYx+tiDbn0X97w4YzGaJhlVBpbfBWQ4mEIvyNw/qYb
	 jD6/lDef1qhFdw0oo48CEQktfq7DaxSTxBc/QDM29+xclZWT6wR+QjcMCsXoptLQKc
	 ppwEdTduJuIACNKFv1pDLojBPGT7dpK1ItuvzT2NYZKi9brg12ocJ3vudhKxXyC5Qu
	 FsHm0xqgjrm5w2NQbI/+I5lsfwUAwvRBVg5owkQ/+6VyrbOOY1wk2Pdaw5bKZk16Tv
	 mDfhkzxA2h1Xg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] tty: hvc: riscv_sbi: instantiate the legcay console earlier
Date: Mon, 14 Oct 2024 08:08:57 +0800
Message-ID: <20241014000857.3032-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hvc_instantiate() is an early console discovery mechanism, it is
usually called before allocating hvc terminal devices. In fact, if
we check hvc_riscv_sbi's hvc_instantiate() return value, we'll find
that it's -1. So the calling hvc_instantiate() is too late.

We can remove the hvc_instantiate() to only rely on the hvc_alloc() to
register the kernel console. We can also move its calling earlier so
the kernel console is registered earlier, so that we can get kernel
console msg earlier. We take the 2nd choice in this patch.

Before the patch:
[    0.367440] printk: legacy console [hvc0] enabled
[    0.401397] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled

After the patch:

[    0.004665] printk: legacy console [hvc0] enabled
[    0.050183] Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)

As can be seen, now the kernel console is registered much earlier before
the BogoMIPS calibrating.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/tty/hvc/hvc_riscv_sbi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
index cede8a572594..d2ecfbf7c84a 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -68,12 +68,10 @@ static int __init hvc_sbi_init(void)
 		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_dbcn_ops, 256));
 		if (err)
 			return err;
-		hvc_instantiate(0, 0, &hvc_sbi_dbcn_ops);
 	} else if (IS_ENABLED(CONFIG_RISCV_SBI_V01)) {
 		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_v01_ops, 256));
 		if (err)
 			return err;
-		hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
 	} else {
 		return -ENODEV;
 	}
@@ -81,3 +79,18 @@ static int __init hvc_sbi_init(void)
 	return 0;
 }
 device_initcall(hvc_sbi_init);
+
+static int __init hvc_sbi_console_init(void)
+{
+	int err;
+
+	if (sbi_debug_console_available)
+		err = hvc_instantiate(0, 0, &hvc_sbi_dbcn_ops);
+	else if (IS_ENABLED(CONFIG_RISCV_SBI_V01))
+		err = hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
+	else
+		return -ENODEV;
+
+	return err < 0 ? -ENODEV : 0;
+}
+console_initcall(hvc_sbi_console_init);
-- 
2.45.2

