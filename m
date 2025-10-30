Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE436CA80
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846936; cv=none; b=RDjSVK5pivxgvap02k03wa9I9rCbYOlyyvE7g7aSjhsCyZee7y0T3pobkdj5Fu+Rw6VQdE8W6X9s2RlAlLDx8n8XQOaVB9cekvd+QqB1fa2kpZ5pjlCthyjiWolXfrvxR8y/02ZvzRGRmYIdHiYkWMhDZr+pyC3sodQ5uU6dWus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846936; c=relaxed/simple;
	bh=9jcJ345rfMMIxdlmZfAg0y+exXpCpE0R+jvegxv2zm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewOt+NYKnNjIqILYfTSuOtX4LLzgn0tv0i7OQRDlEWuPMo8hic2RvDe44fuWW+h5m312owluQo3Ei94TKHQnIyiYngRcv/2PSPUjp5u5g2fraKu3NBMiuACq4j32xrSHA7IYR/o9dAbvPhKK74dfdnfHXCEK4q7LCBCdLsiJ70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J82MttpW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J82MttpW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4270a3464bcso1051319f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846931; x=1762451731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbIsB+JA33Gj1io+1AAFvPQwYHrrul7tUKhFdp8JQ+s=;
        b=J82MttpWIRLzbNEEfH+3Ncrsg/jYUIIN1lQ9nT3qpprSyfwFZTx+k292qSqPOp0GRc
         BNmSaBB/F5m3Cb4K83iM2sAVIfjfN5+ofA+IPFv2CuSQlTzy2IV7sLV4W2Zm9Hwsai0x
         XmHQhD4zkjKv7FLeStCGweTQp4ynd6ZJvJHVJTIqRrC5jN5YOiQTWHJmakoBFJX9iQyG
         5b8GCp1sm4Wz5+A31X5yZqFW4v9nJvILLctnkZBTeR1ibpFO4DCiLnNB0nmTA+3Qbs74
         llsdnhZoFd0CYI30Wi08BmbQL7bzSPJxAeBTSmJCmM3kcMNkV4vKwxU/9Sj0n+4wiYpY
         qQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846931; x=1762451731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbIsB+JA33Gj1io+1AAFvPQwYHrrul7tUKhFdp8JQ+s=;
        b=hgPR/Dr9JLwaPpnrj2wAZPGTEm2LqiWVhKQwCaORRNSg2c4p0hf5OE4qkVhR9dHkL7
         RvPaey/lD9BU3wwPXigRzOMBvw+znBazT/62xeVtQ2WW08jdLfPV3VTAFCwg3dmN6LUV
         Kdu3nQNYhQlNcynpOH1GCuXWJ+dKyNDvhn8XjpxziAx4RKHeX2+xkOzKM7Oyp4fjRWeP
         g01PqOVEedZ0vxfCt/QSjp4Mkjzd70iJUeh6jAF89KtCtH9cNYZOKZqAVC3bUc2OYkOy
         3h/1cp7g9xxJB8oEP1g2OBILtlS8FPBGyGWI4KcKdee9/IMV4rAT73UZtCnszFw8O/Hx
         KMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBhaTVvdMCQHfru6HKZTsHK9j4cycRo8ZUkLdBXS75pvxXOZDR1y9V07JOPpvqD4vaP6Z4wbQy6S874YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV++4YagvXJHYLwKq59twpdy2TiVz8V6AqwkM0LJ8RTATaRZv4
	EtJuda99wU8I85cfZ6vYkuAuCJhsqwR6Qfz+0PmAy/YucxbuS29VMes5
X-Gm-Gg: ASbGncvGiFGQ09kQ8FK/DGVMe2WECQuTr1DKLboxh3u/2EqNPuk+Ic6VprGdR40acZp
	UrDTzD5EGfD0yCCwmiOdtPOHTeWHCU7NQ55rkagVWdR2LrH6FHmrYEeTnIi6r8hpP5o6/NfdRN1
	Qo+owH7Lw2uNFmsEie1No0Le1eS/y4cvibcr1cD/Q6olMQZ0sqFx05QC8aSAloBfY4cB7wBGfI0
	8yu1ILYXWyt01cWWQdFnUJKbkC/TD90E+H1p3wl8bjJ/FqDYyytVwtLTzC+ylV3YflDFIprsmzN
	aDy1jYlDrzWdmP/LrtZermG2glZhv0t1iZfnUS5HUs8LATE1wxEFHbp4Op81na83drChr65TukF
	Ci4gdw6qrQozgZxlVRei6wWw8JaB+dv0qFdujCE+mp11RL2JVdUC/L5jN6BPPB8ZbuKSCBqJRa3
	Gnj8dSvsg5vOAn6jl/KQ0s03Wm6zwvdoYBIGsvXFLx6j2+2svmRO9sdKqAqzyG+03/5zvnraQ=
X-Google-Smtp-Source: AGHT+IEF2L0p91EN9iLwnGMihS3zlarLJMg1F5IRe+iNrL7LAp7ExKgFdBKaDNHl4ZjJyQD8OKHXaQ==
X-Received: by 2002:a05:6000:25c2:b0:429:b718:167c with SMTP id ffacd0b85a97d-429bd68847fmr429373f8f.28.1761846931270;
        Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 05/13] serial: rsci: Drop unused TDR register
Date: Thu, 30 Oct 2025 17:55:09 +0000
Message-ID: <20251030175526.607006-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop the unused TDR register-related macros.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 470b5701cd67..ade5ee479e99 100644
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

