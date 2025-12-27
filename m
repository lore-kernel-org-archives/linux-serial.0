Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D123164C3
	for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837931; cv=none; b=utH+xSjVsUwcOUp/APZg7QNRm81qGe40VXnEf9JSbYRQIC6JR2Z7j3sttbRZbXBIBS+ujw/8rNKeuaiJ1T073rmqman9cxkv8dSgbjYOV8Sq+2iTOmGlsBEZNLBaAIWfMdvmhvj8fHIOsNOM129pQ+J5DA5OOYBNDQkP7vThoU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837931; c=relaxed/simple;
	bh=9A3Brx5a3gQ0NUhTGZ1ViMT9HfTuP00Tgzee1GwnjVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G8Mk3B7t7IN0lH22+z0g6B292yCVsBC6edYOOZgY6+XX87RK6eN2rV8KQT4Kj7DYxqRfCiXFhjW8A/yxhGUGTVu7lI0KEzaXJJlirzuA2CwKawm8I7XDFm0K507bkhaKONHs6+fwLvR/wDA7mW1bvPtTeJL3WCt6WZUb/U2+bew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J0FA9L3E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J0FA9L3E"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so59045995e9.1
        for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837928; x=1767442728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=;
        b=J0FA9L3EEmy+IH7mL6HrvsAU2J8mMSuJmz6c7amiBc6l2t5p3f62JdTCtKxVbVw5tv
         zuNS8vF1S+3BpGWqsjsvt4ONGTmjMi/I3YD222xJdfKU3h4VJfUslK/EeDgLn42ewU0j
         LmFaia6d73wWqXt/KgBZ5iFETl+z6Rh9R0DQN/rMwXBfnCoWzcyGp4OYHq2TLfwXr2YW
         QctsoL79xnhZYvgAc/ZHZCjw/UuAClU8c2kW/VmOPYGJFt21JADcG2l5JUTrhu5ga03I
         +AJKNR7KieNZIm41zxSYT3sOU92LGB7G83JtmI3WGHaz3MQWgZVnsoOHQGzODtYm02LZ
         d4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837928; x=1767442728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=;
        b=HI5ofmLQgpPGUX8REuS9m+LiILdLo6i/gE1CbxAvpRjyjcQiQCiP+cVl75iKiUrMeM
         yIxfQr2tHJu/d/7hu5VRu9Y1SmGsd9sWiOLgCFLfN5n0IuA1tKrVc09HRa5fmySxSmJx
         no95VhfFPSTjCBkCghOeO/gi/Q+n4TiQXesaQQ++yo+YnUAWWT8628rKagOwQRU+B6zR
         krOw8v608vRFhX2U+fBvOhaI7wCTzaqzm/HFvmdd5W8eLDdZMuA1FtzhGFvSaaMB4OSd
         2adDdrYAqCEaqTF8U6jIKxsCmOi5+oAn5+3KKtsOW2kqlS4Wyu7ZKMKai04K18BNvJ7I
         hQEw==
X-Forwarded-Encrypted: i=1; AJvYcCWg1arz8+3NriEx2TDOj7vsW8HyXCHzHoC14s2FKqrskc9UPtQjfPL4Pe2ZlU7fufboJEpokIiqYm4Fd1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx612YvJfZ/klev3xG3W1YxDfXrvoEC9NvmL70q/V8hkvTjoK+F
	Y9czzKmRjVjSxQcr8lmWvFWk7mZiZ5l0l0L18aKV4ctbb0MX5d8MelFoA5YyoGjY2wI=
X-Gm-Gg: AY/fxX7e37xSZ1013bN/JwQTmHfdRX8xlSR8cB2B7ZoBsMUf0homCpbi7XhOrHFWt7p
	TYrOq9FmnHERll1PDOwoankzGbhyjXk5Bw1/UZfSlNsSzXBpR0JG9mnng9rEcyLG3RoDcnepaBv
	Y5HcH4ktNU7/92a/FDJyL88Nw3Ttnr9bpOHd0w/23CHUXu1AeSm9M/YBZ2p2DezM2dUwvEVdK9c
	LK2m2O+ZbWg759HLLWSOXf0Mb0uL+3sGdrSERHgZjd50VwGYxVTx/NQWRp8hoE1emgcx91RsPiM
	ammwPLKKV7sThh0zlz9nOPgTR2rvfsNEEsuNa1431st0VKwLyNScQYIYRumBCNam1nvOEMErtMY
	ed+zXqFuEPJl4kUsQWTd9ySS92WVsisixw2YFjzFYsd7exCRu/2iquTUEXBbGQaYlacGvj5TOjl
	fk0u07snCk
X-Google-Smtp-Source: AGHT+IFbCGvkCxGExFQLBl5yaU008gmiVvRdmeb7k0sjyaCh7Z1nYJocCXv7ZLYKC/Juko66305eyA==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr270395745e9.34.1766837927833;
        Sat, 27 Dec 2025 04:18:47 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:47 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:20 -0300
Subject: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=961;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=9A3Brx5a3gQ0NUhTGZ1ViMT9HfTuP00Tgzee1GwnjVM=;
 b=gNLF1CEZIFvupLFUy4kgNSgx2QLue8Fjf3sjVi+zSBhpSIWUfb0laNahgF6qahlq6x3pophwD
 dRykPPu3R/nALZM8P2pCpkq//4oDFgsmNLGc4Tixc+Z0JIXH+9rAGGe
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/drivers/mconsole_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index ff4bda95b9c7..ce4f4ceb7f27 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -582,12 +582,11 @@ static void console_write(struct console *console, const char *string,
 
 static struct console mc_console = { .name	= "mc",
 				     .write	= console_write,
-				     .flags	= CON_ENABLED,
 				     .index	= -1 };
 
 static int mc_add_console(void)
 {
-	register_console(&mc_console);
+	register_console_force(&mc_console);
 	return 0;
 }
 

-- 
2.52.0

