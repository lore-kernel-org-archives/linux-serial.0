Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E08328266
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083204; cv=none; b=WDjuCg3QsUw3msewcsRUlVHwz05Rvu95GeAh3mwnjApSx+/87NleCplI3GCiUdaoeAmERyosH4POIOWTwTAZlHitJbopj2qLH590xG6h0JkMSAFAwtWI55yGVz7TvJC+n6vVotl3+AmJ/q0X9KvxN+ev+TKvZNj2LMJF15n3tMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083204; c=relaxed/simple;
	bh=DlZPe72ydNmFt2C1zgFZyeOqdvbjTYNvnFfXWDM4wm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gttezdzqxIWQvpzPfSSxTDvo/o0PF1uR5jibTOGPTfDcx2jMvxFBRyeH8UC0HNQ/TnJzRgscSR59fW7tGA0exQbQolBoIJqthTUUvlPH0bYRuthEzCsJutb2GnOlYSxvQdOG/IrZC12vPudKKIODqBhkbiCa08szUsg/sQolnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFuC4iL5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFuC4iL5"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b31c610fcso4826794f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083200; x=1764688000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Rlluzn3/8wzTLB254D0PoF4PW+CvpntGETCkInCEuA=;
        b=KFuC4iL5dCo1diehnQGoNC7lsrZ9f/bGj753YyBfhKxWwN1up1H2aye736zmY9sQpO
         boH7kfYgqOXKQFYQvTgPwjOC5nRiN/zzqmBvNLymLzJx0vd0VOIwRyL4gAPtaWyS8lyZ
         J9fJ2wenEXIOjIU2If2/YdI3+9f5msTQvryBB5aDbD68tNdKHVh+Rm8rDeoGC6RbnMr/
         NZYmyyQo/652U7XhljHTkEfsIDOhaua/ShguZtF9oGiGImz/jzuYIiyKwMuTe8bwwU69
         vkINYHRvlyIdj2IeFegI6N57TjyR8jZmAuTkV41JFY82Qh5aZprWRgMOYzIFnS6667EB
         8BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083200; x=1764688000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Rlluzn3/8wzTLB254D0PoF4PW+CvpntGETCkInCEuA=;
        b=VQ/uW9fnjEpzvLDJz408vIWQs2hQU0O+8p9LlfnaczY9LZrH6W45KJwDqhxhbZuGAB
         kukJ9oaZlJeOVJViT3jt6XQrJhyQPyTzz8LiqcZnfUOi3b7lXAv21t/c2fr1FV0AcfqJ
         gxNQn5uVYx37D4qMhz20yD9bDlvnn2DIniqyPkZsJAFfBBpql9/mW6uC7ZkQIXfIGJ0I
         05kq2x2TBtwYqzBxX88FtCVUpvzwCGpMGM5uzrMzQJhvYGpOU2floXYM9YJGgmlUp3q5
         moxXJ2ad7gSDMnPA7P4sDcOF03TCjLIxH1oP7RD9bs+stKfnxzY8PE1oB7NZ7HfkZ38h
         BIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcqpe9nz4v6hRiatWq6dZC/Wbu3ZplIQPOk6OSudPLw3j8L6uclMsRZgZ8T4QYykL8xKoOXimZ+gVUtCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPRSimRvgmPyGDpKnYiz4UwWLdW2BUWrBgptYWyhDk7MHCbkF
	SXgKISImCIi2TjgHlIGWL+31PNPphYrZ2D6gUZGABzKMgEtYNq82J2ES
X-Gm-Gg: ASbGncu0B5xkMh4psElYMsIhW9SC2IWeLFF/NIwn8StNCDy8xjV/FHOWtBiNJf/2evD
	G6KbDIHM8wzL3i3624KK85vE3FPNgT0wYXXDFxEvZ+epieL4yZbZfzrVePHR282crji+e+0k73v
	gEVbtISlB/aRViub5dI+7+v30xadmbdAEAYz8rNQN+gUoh+B0bpk5ADQNX1Cw99pAMnN+pqNWvG
	MKgFJVfRUbYgk8a5GcugLmp78QL4Hg3mjZDYdkHaGTA3JWiN11xbSpQmPSeV6+usRpEat/dzbJ4
	6TOGPTniTEAzVNNF7GPACDKgq1m2zaoQ8Iq+pthqFtr15cmHXv088EOs9TU34oIjUEh87E0uCjx
	5gJmILSVtrk58+DFPPXehObG2UlKo+a4DWWLfLemwAt9UFR80GpflygXPaNEwoK8QpED1fTXOzS
	2InEcdaeIxr+IrPin0SudtKjnGJdFRBv4UWjDsvU36o4lVmuvYiMcVuDWyuQtvkTKCllG9cSQQp
	5GD2s09dL56F3ohu0Fn
X-Google-Smtp-Source: AGHT+IEYuuqBJt6IQ5SKugNqfguxbkVvrDhQV7s8xm7GSKb0ozEZv3+VMrcpsMtScekHxRwh+8JtJQ==
X-Received: by 2002:a5d:588c:0:b0:42b:2f59:6044 with SMTP id ffacd0b85a97d-42e0f21e9e4mr3204631f8f.17.1764083200346;
        Tue, 25 Nov 2025 07:06:40 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:39 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 06/16] serial: rsci: Drop unused TDR register
Date: Tue, 25 Nov 2025 15:06:08 +0000
Message-ID: <20251125150632.299890-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop the unused TDR register-related macros.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Collected tag.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 3ad6cb8e1d18..5d43e8cdbc0d 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -35,12 +35,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define RDR_FPER		BIT(11) /* FIFO Parity Error */
 #define RDR_RDAT_MSK		GENMASK(8, 0)
 
-/* TDR (Transmit Data Register) */
-#define TDR_MPBT		BIT(9)	/* Multiprocessor Transfer */
-#define TDR_TDAT_9BIT_LSHIFT	0
-#define TDR_TDAT_9BIT_VAL	0x1FF
-#define TDR_TDAT_9BIT_MSK	(TDR_TDAT_9BIT_VAL << TDR_TDAT_9BIT_LSHIFT)
-
 /* CCR0 (Common Control Register 0) */
 #define CCR0_SSE		BIT(24)	/* SSn# Pin Function Enable */
 #define CCR0_TEIE		BIT(21)	/* Transmit End Interrupt Enable */
-- 
2.43.0

