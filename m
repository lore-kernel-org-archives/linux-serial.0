Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A34244686;
	Fri, 29 Aug 2025 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497344; cv=none; b=u7M5C2LWLgKNn6nfCDTI2s9Nv3Komo7OosnS9n3mo34RNG7y7rFYI3C2oNz/LwHdEFZbkWr/n+AKpJwCONIFUII6jOsmaORb3m7HRtLrGZZgBZJKi8qDcZ0TcFkvALeRxprezt4OqLB8utZSx5btPONtVHkt5boDvB3RaZ/ULcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497344; c=relaxed/simple;
	bh=SoCvVi7OJnVw9E9cO4xqZc/vI2WkXK5NWlgbtf0h6dM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpfnPAD9mK1JLD4wsp84qtMRRRTthRXKtbaY4D6rrkpRfeEuwYVbKAcTXTlEuE4ycoLkPdhIL9dHFDX/qFeZ9vg22kDlE3+NrntnsjkhxbB413e0B9RuXNrcu+D7VCZkPuRxsrN7KNhPpKZQAhJLSwyicBPyjeBkdHnVEfRXUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 2BFA910339; Fri, 29 Aug 2025 21:55:17 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH 3/3] tty/vt: Fix unreadable kernel messages on vgacon
Date: Fri, 29 Aug 2025 21:49:08 +0200
Message-Id: <20250829194908.24852-4-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250829194908.24852-1-soci@c64.rulez.org>
References: <20250829194908.24852-1-soci@c64.rulez.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a 512 glyph font is loaded on vgacon and the bold attributes are in
effect then the kernel console output (printk) becomes unreadable. It is
because the brightness bit (used for bold) is at the same place where
the 8th bit of the glyph index is. This patch adds the missing masking
to ensure the output will be displayed using the lower half of the font.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/tty/vt/vt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index d54f4d24e..4c8c87f21 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3356,7 +3356,8 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 				continue;
 		}
 		vc_uniscr_putc(vc, c);
-		scr_writew((vc->vc_attr << 8) + c, (unsigned short *)vc->vc_pos);
+		scr_writew(((vc->vc_attr << 8) & ~vc->vc_hi_font_mask) | c,
+			   (unsigned short *)vc->vc_pos);
 		notify_write(vc, c);
 		cnt++;
 		if (vc->state.x == vc->vc_cols - 1) {
-- 
2.30.2

