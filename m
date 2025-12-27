Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C2316192
	for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837891; cv=none; b=RHLeFhKpcCReaHaswHrfPe2hG+xbyUTVsusty13xNZUxn2JXMyEXu6+/7esBfczjCu8AR6qk8d1GUkOrKMfsjFuw5xTpDz0K9Y4j2l9cr3/FWHODY8hdImb/KzAfvRNhEEE8NjZnjoccnLlv3BOkJgZcVOq+uMTMyOmU5gJWrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837891; c=relaxed/simple;
	bh=i+edMET6/ej5N2K5avM5O831EcMojt2VSHcuUrQdfTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nv6VqSl0n35BI+yiz9VyzDI5hfWxd5di35FNLi4t69Kb7qsScd53zcIT9RANlBx+wzzpv19sWPlBOEEF853V+Df7llSBQiHD2ciagCxb353ZGZzcWJB9GUtzsS4Ud1iiuV3UkkahgU39k9JPOVXWC1lfcXJAhPwf2GkhyHdZLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eBo2H9F7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eBo2H9F7"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so13337305e9.3
        for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 04:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837882; x=1767442682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPj481dav1h3nWeyVMYXYXTPRZgLS1US6KZdyNyRyzc=;
        b=eBo2H9F7jsvmaK92/XVdbdEGM9Tdcx4wgE+kCCLtUhDw4tiFGEFwrffvmJg3Cjflr4
         lLVjUhZChvFwikE0XJxcYjf0zBktHsHCPeQ1eRdVm52B1/xes6ShF/BI6rU3QvrL5sSM
         7jUR3QpNP5VGu1rAaHCctimiqxfroEiKYvmlv99XtG3FfaXc2C8SLHlvl87kAxKq3Jva
         ETdrsaBZZY0yjMUvbD+hJFiwLigqRz/RW3FlZQ8BcDTHnJ+LTxi77x5xGrYYwApC3/HC
         qy10hdktZ51gFdtI6Ure5hOa6dcgq/XZ2kbj+ggfexvJq8+uWpi7mf1SOoyl/T+MexXY
         2uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837882; x=1767442682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YPj481dav1h3nWeyVMYXYXTPRZgLS1US6KZdyNyRyzc=;
        b=PHQtkZR5+XB0CEWjGolPs9+T+QHKTz5DaOtv0jp8rPhAOx3xohjaVxLbik6AsZL60W
         EI/Q/6pZc26X+bChUkuJI0RRw/qpcptkkiazaUSFqCTgXkW/O4jvmhtvzUT5f1x1CXje
         1GPV0H48obwuT2CkYWLyObJwzv7oh/0ZBuplIY/Bcf/EPWuPDQF56mv7AP/fvPtjXAoU
         J6fZfAeMpzD3pjHnH8jJgbgbRnQO2y3NTt+IiOv3zKr7VweI+dp7E1gSlS+UTWlHsYuA
         +l01IxXyGdglr81AETAg7kEgYbGGTLtjsS9OF0ixQjyfGegt5fxEktRjIt5GViXghbO6
         Yk0g==
X-Forwarded-Encrypted: i=1; AJvYcCWFzXH5waujkgo5RG/DGr4Cb5tyfjh6H2VNB/QhVB+gn/vVXo+SFiUAUkLv4jGpmFtMS0Sr8BC+VO+RVFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlwKOrfXNIyXMqbz0+/wnosFwujQgReXUzSPU9O0dxNsMCSorY
	cegI20sJ5h2GvhJ7sLwlnKAIQjMAjFr22YiJh/L+tPJ4k5KM2IWyb859w6zDE1ivfc0=
X-Gm-Gg: AY/fxX6Lg+W3oPl6iupSEQR68STw6jNAFsbjEKsAoFHxRButc945LtefZJmGZC3Nlx9
	Ro+/4OJF/pOOM3vHJsrmLHJXIXLT/cuuY+KXBzUVIeixzg6luevVDGQe3tco6jGNXFN7wpL7jW8
	AO0c2FZEixQ8QCBGPQdAR1+Znw12UY6TJtW+CfdEp+WmIIGzRF5m2ir1AMOeLJ29U/+XhV7ansn
	e/uj/mE3nY89FWp1mmZAyJrq23g5+fL+Uzm3MrX8UONKSVg0vqbCm/HHCmWb+iLSa0/rbFel/uB
	MvuWwJF1kDoRH0yQlesf8VHEfwdSR+3B5xW5EEMN4tAUVeuAyXKzww3YjmXQVaHb9MRg4Az7OXX
	rQQ/VW5prtsQhUUCbTlI6VN8CRccWQ4XhebdPfPdXbLobNUbAzTCQModX1uWEM7oPXdPpHxOsp7
	qrVqiOD7Kk
X-Google-Smtp-Source: AGHT+IG0mR7FQaw+l23lNeDI3HZ2oGPwNQnJRaTrq28MQwyhH5VRn+b1LrDgTvBXBb163N6NepB/tA==
X-Received: by 2002:a05:600c:198b:b0:477:9fcf:3fe3 with SMTP id 5b1f17b1804b1-47d1df12f84mr272520785e9.0.1766837881680;
        Sat, 27 Dec 2025 04:18:01 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:00 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:15 -0300
Subject: [PATCH 08/19] debug: debug_core: Migrate to register_console_force
 helper
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1369;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=i+edMET6/ej5N2K5avM5O831EcMojt2VSHcuUrQdfTw=;
 b=frjUdDlkDnmz9ghHbQI85g3SWQC6r698VmLv/vY5BaR0ZhD0fZI/A4RKNedga5QpYNhkZRCmF
 1wOfSuqi/z5ASQwxAphrFcarhmThsZ8zA4jjeiyha2OJh22t8WzJ4PJ
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/debug/debug_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 0b9495187fba..4bf736e5a059 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -941,7 +941,7 @@ static void kgdb_console_write(struct console *co, const char *s,
 static struct console kgdbcons = {
 	.name		= "kgdb",
 	.write		= kgdb_console_write,
-	.flags		= CON_PRINTBUFFER | CON_ENABLED,
+	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 };
 
@@ -950,7 +950,7 @@ static int __init opt_kgdb_con(char *str)
 	kgdb_use_con = 1;
 
 	if (kgdb_io_module_registered && !kgdb_con_registered) {
-		register_console(&kgdbcons);
+		register_console_force(&kgdbcons);
 		kgdb_con_registered = 1;
 	}
 
@@ -1071,7 +1071,7 @@ static void kgdb_register_callbacks(void)
 		register_sysrq_key('g', &sysrq_dbg_op);
 #endif
 		if (kgdb_use_con && !kgdb_con_registered) {
-			register_console(&kgdbcons);
+			register_console_force(&kgdbcons);
 			kgdb_con_registered = 1;
 		}
 	}

-- 
2.52.0

