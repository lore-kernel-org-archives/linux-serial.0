Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98E37DBC0
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847103; cv=none; b=njSbJbsQ4Sf+UgF8IX/95YzGKLQhW7BT0c6hJc8k5O7jPI8yvxYzwAzFb14sXMlciRO7ItPSmCaEsgq/xu+SpooO8NMm9pEsJr/Yrp2WXL+uwba3qhBJpsP/A31IpeTkTTsk1JvnuiWGO42YxYCPXjeVcBprgERzJK77clBT3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847103; c=relaxed/simple;
	bh=FUUpdN5VqPaa0AglNAM37NGlXaHlU8F1s0H5S0bhfxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYspIev4BPZHOMbZ4mOwUkn2kp3761c+eHzQ+4fNWO8MgIZJF9PJDgIIawVkFVcpKr9O3mS6cddlEhc3ZuWPLTdZWii7CR0bPYz61BgFCerpvc5PKOLrznrBV9RHtj+JvpLUbydQ+g+mlVq9Wjv31rBJzCwyPZ5yEBqgw9fpbAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHk3RpWK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHk3RpWK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-474975af41dso10114765e9.2
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847099; x=1762451899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx09GhYIQEqgtyHYb9x3QHdYCDiDGK8KkivjnJ7GUsM=;
        b=KHk3RpWK07Tx5yE+KFd36Erln8/MJ5GLnQUmV/VepNXLQltC6ou5pNnkrpjSqeSg9l
         rFsNAhnluyEz9/5Mhzrs9tC5s2FvRvVjcB6litomKpG5Iiivebtq3al07fOri/hs2Vvq
         9CUPgEqk71JIw/mqABJ8Gp1qPKannJk3QgHh1Qn6UKB56I1dfVzA4c34RO62bjk5u3Hp
         xl17l6lq/bygbBGxYMeAjlRTRVJ9WZIlhPRxW5RdXmQQXBetmPHqJ5+QOzTDS6f9CEvi
         gXK6750S1CPJgy6JJD67zBUFTcuz4vhhuIzih9DaElLeww9TLWXyN7Zq8MHJnS9PDBtQ
         /L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847099; x=1762451899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx09GhYIQEqgtyHYb9x3QHdYCDiDGK8KkivjnJ7GUsM=;
        b=eIEtkARFHxryCWycjbmLoA6UPCBcZt3d6SwG6xKa40pOwbNa9JoPfuYIsjoVN9ZECl
         gPE3vfSJ9dnQs9L96Im5+cN3sVzHNwUrXupvFBGIcwHzdGulZ6dZfoadUN+4u/13k3Ay
         qYGoGpukSSMReqRbxAEREvx0ykNKDcjkrpJ8sdwW1aawBEb+gsXUbKNYuj7cc8rNG9X2
         xa5Ca+l7tq/Oek8eIRQOaH45lLK109uaILdatauuOCFm0zVCy505v1NbnwKd/WMc99PZ
         gUO8cAZvbqol9p92Wh+i/Aw9Qn5QX2A976gs4QyxLcs2f8VGjl8+SmXFgj+fj2dnFLh8
         s73Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe2xv1EdaaWaOYC0enVKf9CbcNsDHokFpX/+wDnEXze9tiB+o6Lz8QQnPow3HGgpWoZewzRxzY9V+03rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPrNi0lAt/qpeIAR3xW/l0E+xGrA9H9jgpEgH6FANgi/tltYr
	INFDkk6y0HCn/oeU/9060zXQUsnHeakH/LuBEhmQ1q2qU+hHVfJbJ9qq
X-Gm-Gg: ASbGncsMsKrcSPqwObWnEJ5AfRTvIyzGIYsqYMyc+jGGptz5K4J4AdBRz2f+zOWW7zm
	C798ShiCotKqmzkLKFtuk02sn9d/QhaY+ptMny201DmmlveXj0sww8K5bkscRvc0+5wNPvvmJ/1
	L9qxF89HRpjVjbW5+SGwKwrLsYE2cEy0NM2fbX13f1rpeBd3MSaeqDhRl5By6O3h3uYEzSevufk
	NolC71hiBbCoq4HppLwyBJV72pXiWFW91tHa9dIZNC7wLFwF5aZJ8YRtXHQfddAKI9ZJ0l+w0rW
	tXcOGwdrWfbVmUrOQ3Vo+KUFemFJF/UvFvsNHPcb9bcqlVFqGTIt94EMD8zgSDJAE9wZgDEtK1d
	Y3HKtUXWukT/5ORHjnn5lDf3BD6hSKUnFUprvWsp69nabvPxe6prr/I6RFNCqYIcqFNh/2XutoD
	4ICyyZfz1N1MEWxU2CrVrFdiEjLTGICeIWV2br7grxUDLRIJyqaWonTfFqlDo1KJox9ioZLsY=
X-Google-Smtp-Source: AGHT+IEM7c5w5v0aGKFjPUDUh4EvuTkOKmjFdioWbv9NSqY6m/OatijGxXMTlQm1Adm4IZf0xwqM/w==
X-Received: by 2002:a05:600c:1c93:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-47730794401mr6582545e9.4.1761847099337;
        Thu, 30 Oct 2025 10:58:19 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:19 -0700 (PDT)
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
Subject: [PATCH v2 10/13] serial: sh-sci: Make sci_scbrr_calc() public
Date: Thu, 30 Oct 2025 17:57:58 +0000
Message-ID: <20251030175811.607137-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Make the function sci_scbrr_calc() public for code reuse to support RZ/G3E
RSCI IP.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 3 +++
 drivers/tty/serial/sh-sci.c        | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index f730ff9add60..a3f4a76cdecb 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -171,6 +171,9 @@ void sci_port_enable(struct sci_port *sci_port);
 int sci_startup(struct uart_port *port);
 void sci_shutdown(struct uart_port *port);
 
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks);
+
 #define min_sr(_port)		ffs((_port)->sampling_rate_mask)
 #define max_sr(_port)		fls((_port)->sampling_rate_mask)
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 67eba7feea9f..ca4915c1e2e6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2395,9 +2395,8 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
 }
 
 /* calculate sample rate, BRR, and clock select */
-static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
-		   unsigned int *brr, unsigned int *srr,
-		   unsigned int *cks)
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks)
 {
 	unsigned long freq = s->clk_rates[SCI_FCK];
 	unsigned int sr, br, prediv, scrate, c;
@@ -2461,6 +2460,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 		min_err, *brr, *srr + 1, *cks);
 	return min_err;
 }
+EXPORT_SYMBOL_NS_GPL(sci_scbrr_calc, "SH_SCI");
 
 static void sci_reset(struct uart_port *port)
 {
-- 
2.43.0

