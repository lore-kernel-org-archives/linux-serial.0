Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3531A807
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791784428; cv=none; b=MNsHr6SVTBUEtaAIkuaHBewD+JOaUCeT5PnHCi6v+Y0xVLsutGmf0JuIV4dJM3qsfpD05cloA4DKLA8uQ49k4r6TzjCYRJ2PGHsXDsYF9p40tL9mK4Jghn3/bMjVQU94YJuLNEHS4eodLDCOXSKCI+GccDbbq5tioK3H9y5qCo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791784428; c=relaxed/simple;
	bh=qswfbpQeqcrPhyuB29KsZjVoIGAnB+lHjaZ3nFk7l10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RH2sIVajRJ75pHjQYjal5ucnSJC3anwUQ9MhhKHxHhoOyo+NmJcigYlkpcSHAQLSbIE6ZecAM4AMot0XHr4bTqIO+mD4XFOfTzh0p3eU9R5m5KwyKYOTC/PcTDSapVIaz9gTPZxHN59KXw8cScUt7LaBp7qrlTA5hNuv3k7I0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOVA2eQQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOVA2eQQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so9561855e9.1
        for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 22:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791784425; x=1792389225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PothssnYOQBqU06oPmf6jtHUTyL9DrHCtzHqtSv9s2A=;
        b=fOVA2eQQN7BXC+t8TrO2PzmNbOiGSK9HvjILQkpSPQH+HfOqemTdtjS9oMVCNWVneK
         0peP0bMmBO2nnXic28jT/veYHgEghgpxaZbWw2pvoemE/2CvS3oiD1OqqbzD8mbtZxIo
         wiMUutDm6bi3LtQlh+uMNKV0caE7aQesl8CeFrFjQQTbzfPNVMtdT8OQ6u6CsiHGr2hs
         ZonUvQ9KBdh85lJBBkXNgXMG3ZJ5RS9itPfoRZSJq12UmR2Bd6GqsSIBCHKcV2Ae1VxU
         sCidaWwgQB89t9r2EO6n/Rtz4ofyhsMqlywBHR8GAwzUvBsC3IgDKUAAsMMNrVy2QkHI
         ilgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791784425; x=1792389225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PothssnYOQBqU06oPmf6jtHUTyL9DrHCtzHqtSv9s2A=;
        b=k8tQud5hnPg1Dlo16iBJ+7HuYI1nWYKavdg4ns1BNH7qm0pOQPl2Yxo2PhjN9nxBgK
         k/6ZpXDkxjizLGDWUn39LQUs6a/4gyXAxSUBe94uEOGok6FZauVE5hGU0yAtWMxV5IZe
         u4bh8a5xwrzazPKSIh5DelULfQx6Mg0tHEx0SDmm1towAG708Mgu+Nfgyuxq8UzRSZP0
         a9UDHEIdr35n9cE2OIxlazBdjjj4oMOex0PtdXT5UsURku7G7m80+pYUQbxS38bN9JKi
         /PM5YQoOKCXLo3VQJFdsfKeEBjsfudGTYm5OZtHPhcRMsny3QBnodmx1GNyQ15sPsj1z
         /tqg==
X-Forwarded-Encrypted: i=1; AKwUvBx5nvdTVKnBMG9vYPS3TVjF2ELdOksdcLSnMV8Kb68yKBqFQAGu2pzmhRh93H39x3n6Bi7+tlxaMbY0JMg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHndQpb4dZ48gtdV+UDwrRPK3xQBJxrT9HG+iOcmwkqnjOocjQ
	pA9muE5gjGsRlWHZFbeoxrCAHyQ3FevcIPxXfU1b5Qe8/1zYvDaJEAHh
X-Gm-Gg: AYBFou3vBMSQSi42x7vXsvrYJWj9UeNWXaAeAWrCp44tUsufAU9Wv+7Qu6cJobu/m+K
	SzyEOsncvZANrvmXaDOc4JGqznnViusRwGZUO6/VCjWk8zQhLlZ9Rq18HNVzgVp1b2V7WhrCIQD
	JSvQQ4nNYH1aaUARJpSD7CVWzkcJeJEyijs0NAQpZ7JyKy+eqGlnVnQOCc7de7QrU+HTpcRkK+J
	+jVbAaVlPaRqk9uZHF0Bmj4YPlU0XhTr6X07Yttevmnrm0ozaLWJOI6OBuLKXAMjv6zHoUlHnHX
	GkUdlDSOF1YXfjBO4g6xz/o7Pb2qzYdWtuzFNSgsFMO27SUzSkVg9I43/NremY8zvv6mg/71yO9
	IUDKTUyB+mDNNb6hOnN5lCUzoKUvUcPs4b/Ip7lVjbcOOt3qP2jyEBH3L5lL6PeHDVnY8HmhGAs
	T0eRWqEcqLiTqSKgWn4cb1qzaBtKeT6aF5J+jmdZvGqEqsVzq0JHyS5dzKXbM76PolQ2NoCcuL7
	AS463u3833uJk3YAsu7FlbacvFZnryg9kxy7pKRz/G2/E2vo82GoJoD4ksNaA6KbXgrRNeV/kMi
	oaoMd0s0ougD0zh8idBF6E95QBarjkahhz5UEhcV0XDqkLmhcQN6vyBQXimJL+lyzOvX8LQhPBQ
	=
X-Received: by 2002:a05:600c:6207:b0:49f:ff73:9971 with SMTP id 5b1f17b1804b1-4a18e4aff66mr150789045e9.18.1791784424879;
        Sun, 11 Oct 2026 22:53:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8ab-0f01-016a-c770-797f-eaee.310.pool.telefonica.de. [2a02:3100:a8ab:f01:16a:c770:797f:eaee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e49792bsm417935035e9.4.2026.10.11.22.53.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 22:53:44 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: ma35d1: Do not force-enable an unselected console
Date: Mon, 12 Oct 2026 07:53:40 +0200
Message-Id: <20261012055340.16719-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When another console is selected and there is no matching ttyNVT console
argument, the core accepts the MA35D1 console without calling its setup
function because it has CON_ENABLED set before registration.  Its index
remains -1 and printk repeatedly reports an invalid port, flooding the
console and preventing boot.

Let the console core enable it after successful setup.

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/ma35d1_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 0809655f4395..3be30fb05513 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -639,7 +639,7 @@ static struct console ma35d1serial_console = {
 	.write   = ma35d1serial_console_write,
 	.device  = uart_console_device,
 	.setup   = ma35d1serial_console_setup,
-	.flags   = CON_PRINTBUFFER | CON_ENABLED,
+	.flags   = CON_PRINTBUFFER,
 	.index   = -1,
 	.data    = &ma35d1serial_reg,
 };
-- 
2.53.0

