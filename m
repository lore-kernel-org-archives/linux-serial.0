Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452DF1D9346
	for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769554566; cv=none; b=G0gbOrSBcUEFVMT0JGM72EWYvuqDMhoQbpxPb+gGRcO+4LTxaHg2X6KQnSrQFqNdCaCXIqQHJivmnguW+yHh0Cbcv2X3W1gp8jGobZiaeqrrAvTuu0pFKg4dc50IEIB5pEjmAVwuPZpIyq+Dx/aQ4d42XJ7QzeYolE7Orqug2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769554566; c=relaxed/simple;
	bh=BIqtV71O4b2nNBJ39pBWJei81bi2HK91qUvVgENdbQ0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=iFA/R3lutDdwEQ42rZUACf0RM1RAlsGZwqbbFKZJDC4kX43rZK+WxfziUQ1qu43IPElSY5K9jehjVPYt7zDACjpOzI25BMxnWY7x88mrF4MRPBb/FgSM3ckLAx+0t3PdCBUOA6JEXA5CmvirI8acnRsrYi+iAoC3KBBi5kF3GUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3f/m2CtP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3f/m2CtP"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c5349ba802so632197685a.1
        for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 14:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769554563; x=1770159363; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=be7rCfgGfMyw8VXlN7Q+qrUYUoCH9F4cDfmNDHeRxCI=;
        b=3f/m2CtPUNVolk2N69gEc7bviJ1m+nKBFeRmpYkkWYlWhrv8k/yqXOHeV6BvnPkSok
         aTl8yRpeifm4BgFvLWm91Bmax9M3zxi1xTKRUQkrNEgxCUo4rxv5XbPh8I9zS4lnQdY4
         U7m6EGV5wnHVLON91mq+kSA8KV3GWErvZu9cxnQyejMtrkB6BR2HsFpP/ufMBqhKSvvQ
         qfew+HXummM77l3xqfGaicL/sNE2NQ57b4wV4jxkxhYob7tviZJvDkgsHxNpUm5g3FrB
         IU3mYARufjGqRNLw7XHlP0G6keHF9HYMF7ZYoW+IG3Aj6Lrall/dsefb8CUafgsoN8wV
         qZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769554563; x=1770159363;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=be7rCfgGfMyw8VXlN7Q+qrUYUoCH9F4cDfmNDHeRxCI=;
        b=qlk/MkOUC5ma6AK32UBd+/w9IpWsodPdYGohTrTP8hnWTlFvCG0JhWPbUGGBu1FROj
         p+Zmn2SIaW/lJ2x2u1ArK0zkfobiT/F0xeg99Mp57DFqxGpKsc6LlK+kSqx0lEb3kvN+
         C8JP2QZ35Z0xT1Lhh2alPTytvP7CfttZjuvsv+I5vMcjk5LZL0od8rFx5KkIC6l/p7yk
         iL6evVVIhlvpqdyR2Xn2nWvTPeqAYoytLbXc7jer5idr0o57DTP1B70lqbL6XhVeezMA
         5aj5HOAmPo262Sn3Sm9QbJA7cdlMFTosAjtihmcxrbXhi2x/mpYouQcKB2BuL/mOI7Gq
         kHqA==
X-Forwarded-Encrypted: i=1; AJvYcCUuowEvDDQpT6yrbLHIXMYgpxPzKfYHHH2aKKdd2lVl3yOHr2gzbRkzeQAzaozPd00YCYu8t5/FzH0NTPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUN5GIOqhBa2HzISnBw0qs7FsamVVp8EZbqZEHTfENtToofGRX
	NglxiqDrhbS5L+DoUu1RxWgK5CdL38psGUpRpihmccZH2ikrUGBogIiGgR1g6awKPt3G/Zx7my6
	WNRpamJ8=
X-Gm-Gg: AZuq6aLTKSzNh/tcYFF67XOdwxO5dBtdqbwZhx7H7O07NRra/PYzhIoulk+t6o92sxB
	4IyUCn75LO3wY6BPnt6tCPLmaa6KmpxAbz4zTuPDhxOjNbY+uaP4/maqGDVJ/paEHoPljivztDZ
	uaixmmqaCVjr3K+uz9yxSp7lw9QEhE7EEOXHInjF/kdLFjWlBvDpIfmLP6zBPGJiOd1R82FjKsh
	LwWrntF6i+WfkiYTYgG9xMPXeiVtFK8oAQhXnLJBHpkQNcPVeI8btA/vK7wS/qovnZA/GlRe8/P
	lCuf6oXtRxTjnwNQz7A85t8KXqQbEAFKakoINVTWWHBqE2lBaq7HhfPkZHk6x7oWAc7XLAoWEnU
	rDGK1o+WuAnt+wEXLXwz10RZDjjZzkFZiSQyoEknaOdwoRjs14CuOAeyg1JEbG2Hz7iJIe2X73n
	zEXejUCzeOH+0ecTUQEmuUAkgyouEI+zVuleRPwfcfFOVwcxxWNog=
X-Received: by 2002:a05:620a:4624:b0:8b2:dcde:b670 with SMTP id af79cd13be357-8c70b918e63mr420739285a.70.1769554563190;
        Tue, 27 Jan 2026 14:56:03 -0800 (PST)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d2a2d4sm64282485a.32.2026.01.27.14.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 14:56:02 -0800 (PST)
Date: Tue, 27 Jan 2026 17:56:01 -0500 (EST)
From: Nicolas Pitre <npitre@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Calixte Pernot <calixte.pernot@grenoble-inp.org>
cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] vt: save/restore unicode screen buffer for alternate
 screen
Message-ID: <5o2p6qp3-91pq-0p17-or02-1oors4417ns7@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

The alternate screen support added by commit 23743ba64709 ("vt: add
support for smput/rmput escape codes") only saves and restores the
regular screen buffer (vc_origin), but completely ignores the corresponding
unicode screen buffer (vc_uni_lines) creating a messed-up display.

Add vc_saved_uni_lines to save the unicode screen buffer when entering
the alternate screen, and restore it when leaving. Also ensure proper
cleanup in reset_terminal() and vc_deallocate().

Fixes: 23743ba64709 ("vt: add support for smput/rmput escape codes")
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c            | 8 ++++++++
 include/linux/console_struct.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 59b4b5e126ba..83a285577708 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1345,6 +1345,8 @@ struct vc_data *vc_deallocate(unsigned int currcons)
 			kfree(vc->vc_saved_screen);
 			vc->vc_saved_screen = NULL;
 		}
+		vc_uniscr_free(vc->vc_saved_uni_lines);
+		vc->vc_saved_uni_lines = NULL;
 	}
 	return vc;
 }
@@ -1890,6 +1892,8 @@ static void enter_alt_screen(struct vc_data *vc)
 	vc->vc_saved_screen = kmemdup((u16 *)vc->vc_origin, size, GFP_KERNEL);
 	if (vc->vc_saved_screen == NULL)
 		return;
+	vc->vc_saved_uni_lines = vc->vc_uni_lines;
+	vc->vc_uni_lines = NULL;
 	vc->vc_saved_rows = vc->vc_rows;
 	vc->vc_saved_cols = vc->vc_cols;
 	save_cur(vc);
@@ -1911,6 +1915,8 @@ static void leave_alt_screen(struct vc_data *vc)
 		dest = ((u16 *)vc->vc_origin) + r * vc->vc_cols;
 		memcpy(dest, src, 2 * cols);
 	}
+	vc_uniscr_set(vc, vc->vc_saved_uni_lines);
+	vc->vc_saved_uni_lines = NULL;
 	restore_cur(vc);
 	/* Update the entire screen */
 	if (con_should_update(vc))
@@ -2233,6 +2239,8 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	if (vc->vc_saved_screen != NULL) {
 		kfree(vc->vc_saved_screen);
 		vc->vc_saved_screen = NULL;
+		vc_uniscr_free(vc->vc_saved_uni_lines);
+		vc->vc_saved_uni_lines = NULL;
 		vc->vc_saved_rows = 0;
 		vc->vc_saved_cols = 0;
 	}
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 13b35637bd5a..d5ca855116df 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -160,6 +160,7 @@ struct vc_data {
 	struct uni_pagedict **uni_pagedict_loc; /* [!] Location of uni_pagedict variable for this console */
 	u32 **vc_uni_lines;			/* unicode screen content */
 	u16		*vc_saved_screen;
+	u32		**vc_saved_uni_lines;
 	unsigned int	vc_saved_cols;
 	unsigned int	vc_saved_rows;
 	/* additional information is in vt_kern.h */
-- 
2.52.0

