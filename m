Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD377A704
	for <linux-serial@vger.kernel.org>; Sun,  3 Mar 2024 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709502438; cv=none; b=A91cuoL3rHPuxbp8Bnl1ZqlDsh9IRGRjvQs51ILQ6GE5PVwQ4vQM5l3esSlH7ASLvU+UlqW3U2TNfa3hFiAn5Uo5XcEp3yhHWjmP/QZcik5fMBTggKjh7OtgF9VZ8L/gGTMZr2tuK6p20GDEI8JY4s/jNpeAPpo1UVRYDkTpyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709502438; c=relaxed/simple;
	bh=Zq+5zagzhB2NHWhKHr8j9QO7mYdLe3QH2ZYtRZ8duaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6mKzuM3gKBCZdLw6buLEMzT2TfzbxIaAAup2Q3KicuwKcLSDjVcQ99PHXAJSh4CMEPb1AOS22uj2PLXLNJgYPaZ2xCldGyDfQanMTscICesz/EuUQ8/pQRNMwkMCtGkg5iWjbt+3Fl6vnSVGbQ1ynQgrfN/cjGIEbgVD8r0HzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=Zl7vwCNQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="Zl7vwCNQ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33dcd8dec88so2386842f8f.1
        for <linux-serial@vger.kernel.org>; Sun, 03 Mar 2024 13:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1709502434; x=1710107234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f882JABaI9Ly7gOENyYukEMkN1PY3vIfQnIQ2FnKOeM=;
        b=Zl7vwCNQy7c9a+DY4d74RRtZnIDy/ZeQtlbP5mbhA4i/TRjAWfiNrTF8JLppxHtb5c
         lvqtBBoZBFKh6WCTrMqQZwWEpuIg4wwaPr2h4N4BJ6au2N/qf/yAcIMuYr4ooIu+P0kr
         4ffG4lbT2/jU3/GE9P8xXQuLFyU1ykL5+fK6CXL333A/E34NXzqdzgCjpKY70XGnO5RG
         SposUPvsnc3Ki/H8J4zacrLUmcYbspT0B+PCzoC+CDRSmkf4cYbPJY1yQ+kZUyecxktq
         eyxSRbCgADk7Tizq/cIII13MnRYwJjww2IYEYsQRZVPhDwdKqXCJ0oloLgxbqsdQmGwB
         hQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709502434; x=1710107234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f882JABaI9Ly7gOENyYukEMkN1PY3vIfQnIQ2FnKOeM=;
        b=t0GLsxLpbYQhEgEdAvZXmhihrPKwYXvcmJsDF7K+6Bz5eGavSw/eAz1NsQr3RTEx4i
         OAxd4jzgV+LVR3KOLZ7vY1QNwLesoALACXnnRuShL9YRAdZq1N0fFoBN72U7vdwIrNCs
         HuEdq77JdtTELL9HARhyl3q7c+mMygXIeO4ESjIqTTHI4TrlHzj9vo8ggj+/MTSbQIm6
         eJqI9CZChUJvMUex/bN4O8P37LzIotlkCwXHYv4U+t0c3zSLZGQerraKKoP+T915IqaY
         +lq7y5tHmldnsXjZqX5Vzs6MbB0aY/quuiLlXaTMJFB5KGsF80to1M8QfVKXdgEek7VP
         epWg==
X-Forwarded-Encrypted: i=1; AJvYcCWUujp7+jv/DIAZN8QItEvaFZDiPB0TASXipeXDzAf4yG35WOt8gkdBXCKGdNWPuuceeV23bcDtm/i/ZRKEBuLuzPTsauLjd2ynwpxl
X-Gm-Message-State: AOJu0YxLR3iS3WjZ+lW0X1CUO6o7HAGgG90xGAjxMKts3JpqCHWKWPQn
	LdY0MavNPItJxlCTTmWBQUPKDifgArDg+9ODove5JkdEEu8RG52i7RkcH8X7lN8=
X-Google-Smtp-Source: AGHT+IESx6M390D6dpYH+kYAnqnpNB5gV+Oyg59tLFLQGwO77v3Kgiba4g3K5zeXkeG22I+TT1+LFw==
X-Received: by 2002:a5d:6d8b:0:b0:33d:c657:6ae3 with SMTP id l11-20020a5d6d8b000000b0033dc6576ae3mr6830566wrs.7.1709502434489;
        Sun, 03 Mar 2024 13:47:14 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.numericable.fr ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id bu16-20020a056000079000b0033dc3f3d689sm10525236wrb.93.2024.03.03.13.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:47:13 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
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
Subject: [PATCH v6 1/3] printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled
Date: Sun,  3 Mar 2024 22:46:50 +0100
Message-Id: <20240303214652.727140-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240303214652.727140-1-yoann.congal@smile.fr>
References: <20240303214652.727140-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

