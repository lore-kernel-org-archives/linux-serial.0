Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891F221DBA;
	Mon,  7 Apr 2025 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743998926; cv=none; b=Y/xPnKpXx3oO1zTA1OjGdnVu46XHe0yCLHp9U205R0+MdmktzaAlLHx3nntqAh9yW8HDw00QqJlJ25XPbqNSodpFoEhYZUNahCPPKtKRA+wPxw4g1D28jZrXKpB+BiRm8yGoDQJrDZakb+O0tlaj0Pl0AjFg+iScrSmB52GFJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743998926; c=relaxed/simple;
	bh=6mw6RbWWwm0KqSb/ZoEKOOwbcNSmybbfsi4eILBrR+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CI8RDa2Z4N4rwDfBn54RLj/E1N0hpiAszIlK0+I/iek0Hsv1UiLtKR39139csgMY3qxcu9+aSuUZ6w2tkPQWVYqlGSb+wB2fvAsXPg/LOj1lVYdx/8BXEeO3G+OLAie2r7POoIq2Mrf7Yr9Bs/NqlmK9nqZ9U1wZfcANkm9Ok1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACn3gbAT_NnBAjLBg--.10818S2;
	Mon, 07 Apr 2025 12:08:32 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	kkartik@nvidia.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] serial: tegra-utc: Remove unneeded semicolon
Date: Mon,  7 Apr 2025 12:07:12 +0800
Message-Id: <20250407040712.2577607-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACn3gbAT_NnBAjLBg--.10818S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DWF1rWw4Uurg_yoWxuwc_CF
	n7Wwn7Zr98CFZIywnxAFWfuFnIv34kZFs5Xw4I9FZ3W34qvF4rJryjgrs7Ww43W3y8uFyx
	WwnrWFy7Ar15WjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbVbytUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/tty/serial/tegra-utc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/tegra-utc.c b/drivers/tty/serial/tegra-utc.c
index 39b14fe813c9..0c70d3e7b9b9 100644
--- a/drivers/tty/serial/tegra-utc.c
+++ b/drivers/tty/serial/tegra-utc.c
@@ -434,7 +434,7 @@ static void tegra_utc_console_write_atomic(struct console *cons, struct nbcon_wr
 
 		outbuf += burst_size;
 		len -= burst_size;
-	};
+	}
 
 	nbcon_exit_unsafe(wctxt);
 }
-- 
2.25.1

