Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376229DB65
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751067; cv=none; b=XP/2A7ZFCrd0VDO/mqRN7N1gPfAguVTZxv7LbCFdcU+py+b/b+R9G4WHiBC0Q05rT5A3APsarjKeF5eqb3PxXYDDO355dgeu3wAOdNQu/lp+07bOZm0uXWAIfPMJM6gPdEzJJxY5RtDmjcL+UnlFpQGrHFQFjQJF1eDzcZ5zlKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751067; c=relaxed/simple;
	bh=TNAGn41MV021H2aUeZwKlB7H00LNs29SUKDaNMAUfzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxwI0XysgiEBgmPZPkOnKcLUcfPqIg54J26aV5icVaZHa+85F6pb4h0FHe3XZDyyyFIyqnW30Bt4WBMh23irFIEtGvAblf4+qAaF0l85Y67kTQT1hFlRkOYi4KLkDwxxnBaAtVgqbQH8Ts3TsjMkP5y9o2DmPZvMvj9wftJdNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DNE/n8hd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DNE/n8hd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso25788795e9.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 10:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763751060; x=1764355860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKpU+JVEo8jImM4RsWriqSa3YyacHuZk4xRkxS0guks=;
        b=DNE/n8hdGlb9F0alx6lX9Ixlwirw3r1xBm1Tiz2sQPiUMbCukFaPVLtHhQoM4zXi2v
         ZFvSIIPs3TU2H6RW0DuL49ckFNGdrEUiXbP1sk2zlzKRiqHXupgFOJqeq0PDeio0TYz9
         uHOVngmkuzHq3Ut4f2zQD5aEcKwabBtRiK6VgO0Sa+jHO3AAx3ZSoNOQEAD0dzhs/s/D
         eD+HHNdk0krzpxmKStRvy6qD3YpmHv2e8+KyYlqPYLl3GOMCumhgf4THHyRZDnBuwD0s
         nOuYk5SltpZQhsxqdAA6ckKLxDhWXXdGIQRtX/qcRXr56FX7x4rYKNfoofoy3xnFEI/L
         CsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751060; x=1764355860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IKpU+JVEo8jImM4RsWriqSa3YyacHuZk4xRkxS0guks=;
        b=MgKLjTocD39OBFH1F4jAhPSy4mgDlGvMsH6K4ZaOIhyjWhMPd+5OCdnbol4s8DQeTY
         wV9GXAiwG0QkygjuTwhakVuCJtzLZxiVSGKYM4ztPsU19YB+EIgoz+1yYblpEvd2CTvb
         dN0Qd5BGojh45gruSOLGCMUmN9GB+CRoFQMukBVD253r9kExRWKZfWSHsRuVzrP0cNjv
         UFCfzBsuvnDA07+KNy/cVgXrcfR8AIwrYDNcsccQChsbjIZJ6FLYsL8jy7WXwcVgp/TT
         ZDf4zIWsFqqdUpIo+J63eqexEYWkUfiiJdqrYLXodjyMBMrjvC35MhYn9HSiyjeHXro2
         23LA==
X-Forwarded-Encrypted: i=1; AJvYcCWrXl52o31Q6p6fgvZAO8Z8T1DC0M87TsU2g7hfMGVH43YTSai4hHP1P1iBxU6gyTXDBmEoGKYIjzzs3no=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfHCkBbP0zXQW+fMhRB/+VnWcOwMCtmFd/HZfptmM1suJnCfgE
	+KyzM+FMe+7P604BECXlw7LSm/c7hPC73P5NAuwMwQbdNFfBHs6m+UfpNbxSCHjc1/M=
X-Gm-Gg: ASbGncvlv1ftoapa11/+IoFwSQxgEvs3S2M4Nzp7pFcswJLRmnaq2Zz+tet8EcE/yvK
	qvDtWZMnOKElZHYNzFp0QhT5vEpVT/WAtmIuPSQX4S/lm6otqcmzl/YJD1gQzUahKNigwSmHaAT
	U8U+IHJMbRB4T2yhRqgsnk+YuOhu70uMTZQY5XC4g07w2NPOkNSytId8HK0AC2axrMa1UX96ZiG
	9gfEnlUGZ1VJKAHjsurHMDTXiWZXiBSos/l+gEUfCKgPaYgvN4Gy5Ao9AJp5t2egXGzysI+w/er
	GLGY93DIaKejf0wmrGy53DpfkaNkZEG0lIBKMgC1wiWMbbZFC/nZv0flA+RlNY09DXR7azyPzpP
	qNSPMml8DDNOaDhugsBd9s0+yd7RUM4O4RCWWNMEC5DYd7BJMVQPGanUx+Dl9t8LagTGEgDoxW5
	v6NNDABohyZWQwFgPxgq2vgw4V+EtH0ohmMp8Y98jvQADeYw==
X-Google-Smtp-Source: AGHT+IEp7w0ciNVkPyG6KJveUGftNTpGrWBeH1bxscHmBcc3IXgFsFDEhjsS1npeT4GimD56otbUpA==
X-Received: by 2002:a05:6000:1a8f:b0:42b:3c25:cd06 with SMTP id ffacd0b85a97d-42cc1cee419mr3544639f8f.22.1763751059776;
        Fri, 21 Nov 2025 10:50:59 -0800 (PST)
Received: from [127.0.0.1] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm12473639f8f.39.2025.11.21.10.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:50:59 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 21 Nov 2025 15:50:33 -0300
Subject: [PATCH v2 1/4] drivers: serial: kgdboc: Drop checks for
 CON_ENABLED and CON_BOOT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-printk-cleanup-part2-v2-1-57b8b78647f4@suse.com>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
In-Reply-To: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763751050; l=1305;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=TNAGn41MV021H2aUeZwKlB7H00LNs29SUKDaNMAUfzg=;
 b=44EC1mGND1ysTRERb+Is2jw0ncg0VNA7gddxT3UyAFKxKAz8occNwGH/6zo30HTuKMjRMAhop
 twSzNFMCXkUByZW8HmxONIKjpn1N/Dp+wJcwjrr3eEm01IAp44DV16a
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The original code tried to find a console that has CON_BOOT _or_
CON_ENABLED flag set. The flag CON_ENABLED is set to all registered
consoles, so in this case this check is always true, even for the
CON_BOOT consoles.

The initial intent of the kgdboc_earlycon_init was to get a console
early (CON_BOOT) or later on in the process (CON_ENABLED). The
code was using for_each_console macro, meaning that all console structs
were previously registered on the printk() machinery. At this point,
any console found on for_each_console is safe for kgdboc_earlycon_init
to use.

Dropping the check makes the code cleaner, and avoids further confusion
by future readers of the code.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/serial/kgdboc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 85f6c5a76e0f..5a955c80a853 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -577,7 +577,6 @@ static int __init kgdboc_earlycon_init(char *opt)
 	console_list_lock();
 	for_each_console(con) {
 		if (con->write && con->read &&
-		    (con->flags & (CON_BOOT | CON_ENABLED)) &&
 		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
 			break;
 	}

-- 
2.51.1

