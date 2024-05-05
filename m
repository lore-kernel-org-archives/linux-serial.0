Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B379E4
	for <linux-serial@vger.kernel.org>; Sun,  5 May 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714896259; cv=none; b=Dy+WLROwBp4qyQFu9RLB/r46ezARln0XAZH+MCF48iR9wXKm0elOt0nJZRI8B0Kj3smtT4MQAQHZkRxPSz4PFKVKj939r9Gnfk4gZlFGrsZsBLuyML7IgwgxHq+FwXuZyLpIg0TvbcnoP3vuFgqepSLunrzvvK07omahuSU5jA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714896259; c=relaxed/simple;
	bh=ulZeqyMK9SIzCAJwRgdu/XvQvdV7+I9mcGDrXJ3xQl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RkVvvpQvubG2QFN/1TmwAm5lPM/pQtvAU2iJ4gAbubURqU4YVXfsIJgzC8ezK6wpujBZ6HIbwQtYMJr1/mCBzt2pinkIg+tctCE3KQtlCvOyIGkwxJ6/hTlMl56PgEcLrsGZUoPQtDVDTuRnn6RR5KUAt0MzvAXpgeKovr0cqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=vQygRbFB; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="vQygRbFB"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e0a0cc5e83so9642191fa.1
        for <linux-serial@vger.kernel.org>; Sun, 05 May 2024 01:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1714896254; x=1715501054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7A8dE17N1A44dcO35ZoDRK7fDnlK9Qrxz49fhZ+FnQ=;
        b=vQygRbFBemTaFxNuEfbwj8eaibSHDDFoLOOIiZsUuvLcBcG53asbvrHYoLK8vTIh4c
         K5RpOTJpxpUkQGOQ6J6Nlt6OgitZjcIh79l5LGQvONg+XMA801CHG5IDHkUV9Vq285Zr
         FfBV3j0a5Zs3usxrJuGoQ9SWoTGkRwvYh4tx2bHdq+QSktnDw7jPQGAyuOMRXsmbAIE1
         uw0Q4DE/AjpPk7aH81AmE20suFb9g4vO/18f7A+94ZwfhAsDo53lpxSTGkU4QTH4hE5U
         lFr7O+WNJcK406JjTqtJjMalqP5ufb1uskb2eHURa7Wza+Uk7aoPcRLCeUkzKZeCE3yY
         pBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714896254; x=1715501054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7A8dE17N1A44dcO35ZoDRK7fDnlK9Qrxz49fhZ+FnQ=;
        b=B+KX+9Sp2y2fPNL6dMKWvpPI2xuGlqQwM/Q2twNT8nj6XgMPmCzNllFbjRMpJngqvz
         i0lf/rWkI2EQ3z3MiUOCi/l/TNOKdfK/SUBI0lsgtAOJxVcQ8S4XOZiWIuMuyPy+VLW7
         rG0dYUIbyhAO0cz/jsGXcMDd5AT2Xde+xMBXtmdf2FuJHFV8aY0LItuX4sPVIraf/Gxg
         ZIs5bL0zMTtb1Ac4UcfyZp9hlZDlpnDrjQkBKg6vnoQZ/Ts/4CqTG4JaVvx4haPW8s5Q
         jpoVkKs+QOucO0MsS9x+9Fo1mxugvz45p6mUXlNk5JH7JdomNSZ8Op2EkdgS7lbjaJeD
         yQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCULnxnNA3zVQm12smQT3PwEt3SSpgvERttYL/Bq2qoO+csXW2Y+Rtj+k4aJeEjxwQvQJ/F2G5cer432kNQkPwEyiVdtWqHcdbwCUVjb
X-Gm-Message-State: AOJu0YwaRaeDyi9M35xr/BFUcNMpcmpzRxbA2LdgQHJJQml2GHK+Vks6
	f8qZ4zmN8rLD0WPNssYRnjjcPQmekTFKayYloQ1ADoLT/K1BRUaKxmV8KXMjIIE=
X-Google-Smtp-Source: AGHT+IHlhlF8QkWlJ7vYCVUgO9xtdGRRC95kFl28TrrY562K6ff58dIStBolLqI3vj+3z1YJyXmPwA==
X-Received: by 2002:a2e:9e07:0:b0:2e2:7f2:9f9d with SMTP id e7-20020a2e9e07000000b002e207f29f9dmr3944919ljk.24.1714896254378;
        Sun, 05 May 2024 01:04:14 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id s3-20020adfe003000000b0034e8a10039esm4705295wrh.10.2024.05.05.01.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 01:04:14 -0700 (PDT)
From: yoann.congal@smile.fr
To: linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	x86@kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yoann Congal <yoann.congal@smile.fr>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RESEND v6 1/3] printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled
Date: Sun,  5 May 2024 10:03:41 +0200
Message-Id: <20240505080343.1471198-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240505080343.1471198-1-yoann.congal@smile.fr>
References: <20240505080343.1471198-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yoann Congal <yoann.congal@smile.fr>

LOG_CPU_MAX_BUF_SHIFT default value depends on BASE_SMALL:
  config LOG_CPU_MAX_BUF_SHIFT
  	default 12 if !BASE_SMALL
  	default 0 if BASE_SMALL
But, BASE_SMALL is a config of type int and "!BASE_SMALL" is always
evaluated to true whatever is the value of BASE_SMALL.

This patch fixes this by using the correct conditional operator for int
type : BASE_SMALL != 0.

Note: This changes CONFIG_LOG_CPU_MAX_BUF_SHIFT=12 to
CONFIG_LOG_CPU_MAX_BUF_SHIFT=0 for BASE_SMALL defconfigs, but that will
not be a big impact due to this code in kernel/printk/printk.c:
  /* by default this will only continue through for large > 64 CPUs */
  if (cpu_extra <= __LOG_BUF_LEN / 2)
          return;
Systems using CONFIG_BASE_SMALL and having 64+ CPUs should be quite
rare.

John Ogness <john.ogness@linutronix.de> (printk reviewer) wrote:
> For printk this will mean that BASE_SMALL systems were probably
> previously allocating/using the dynamic ringbuffer and now they will
> just continue to use the static ringbuffer. Which is fine and saves
> memory (as it should).

Petr Mladek <pmladek@suse.com> (printk maintainer) wrote:
> More precisely, it allocated the buffer dynamically when the sum
> of per-CPU-extra space exceeded half of the default static ring
> buffer. This happened for systems with more than 64 CPUs with
> the default config values.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com/
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Closes: https://lore.kernel.org/all/f6856be8-54b7-0fa0-1d17-39632bf29ada@oracle.com/
Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8426d59cc634d..ad4b6f778d2bd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -743,8 +743,8 @@ config LOG_CPU_MAX_BUF_SHIFT
 	int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
 	depends on SMP
 	range 0 21
-	default 12 if !BASE_SMALL
-	default 0 if BASE_SMALL
+	default 0 if BASE_SMALL != 0
+	default 12
 	depends on PRINTK
 	help
 	  This option allows to increase the default ring buffer size
-- 
2.39.2

