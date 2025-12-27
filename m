Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0432694C
	for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837959; cv=none; b=MVNU1GIsBdlCslfm9AeC+6HdjlJPSVMdMZDe/1NaSkP5ptE9+7r7lVjVYU/aNYKNRa9BHhcJIbNnln3dC6KQ6NcgaTdTo2FG0hZkFBDYqpOnqXnn4M6Nwqj6iwXJW1Wb/3tBBTHfRZNjIc+Wn7eiY88uTxDYxn5rhD5IsS5x5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837959; c=relaxed/simple;
	bh=jiVyzdGaYwwOjViBefbG/4tnbA+IZ6VTt4S6NyPkSWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMRp4qu44FSVQV/LJdT9OOARGZnH60wF9RDSjw4wN07BPPC6x6x54RJ0FChMFZH/XX7f18aWM4+Ghwomn0S0wBRWHNQn6n91gophsNgiDKR2VeMFDHd+/BPibPN6Flw28OXLWuP08GGFjFe6WSIpv6vL06NXqhVSNEM6GrKSNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ghn6Avrh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ghn6Avrh"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso49248065e9.3
        for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 04:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837956; x=1767442756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejU77izjbpiitWXY1CFRfcJAx1qt+ylV9tDV0w1mOdk=;
        b=ghn6Avrh0U6kMfO+5wJOF4f/N22GT+6BCEdnma2ARj7cjiBJII/bAR9TXLNQR/klXt
         5Mebni8IvxVeUnTcUFi/xOSEhHiC7gCV4CutFUuj6L/sM9gUrxV4fM8USDZtpTEWUoCu
         KGI7WV65EBYMJHsTa8EzxqKFj7AtXhZCWuSqJVZ3VE8u/xxhAxJEZn5nwhna1APHp2wj
         //qavCHO9/PFj6NNimxI7avd5S7n1KOvlN2T+5zsJ0yV8++LiPEBCY4LGArsTCJY31no
         XKzL7Yo/av90eXg1HWBBJTATR5EwXEC1sP8dbDldmERYWejvpXrl8+BDFO1r6bK5oQfZ
         BHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837956; x=1767442756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ejU77izjbpiitWXY1CFRfcJAx1qt+ylV9tDV0w1mOdk=;
        b=CcFrSwAckTfuFhiAXfJ349v/+WuQGQWDOShe/SpjlmeH95WiuuH/zJMO4hauPPAd5Z
         AhRtRkEpVap96DDdLBAn3UYaSJxSUts3Y7E5phI1i2zF/NYpCTSs6k9a6X7qeQTFwOF+
         jCgsx/5PPiQc5FuTf7Ofau+Dc3xUw8P8z5LVu/Ic9GnFLqWijvCX1rF4+2BUixF6Q2tm
         kau8KK6gUlzSmvv2OjyN069PolYIR2DVJwG65LRbR3FLZtdg1ilFS2UrUSPZ1TpyhFrW
         87USBFCtjyxDMA9rO7uOxJ1b/nAVUHEUv/RWg8fMhxocq59EkZ8NRgqLnVDdHNDG761L
         WOFA==
X-Forwarded-Encrypted: i=1; AJvYcCXf24g5cYsrV1Qo+VAhCUdDzGRiBcBrDWASNDDA7jXZGDgCFEBm8PBYlP/NEvfI7qQUk22+ODTGcA8VLV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVLuhtHkAoop8kesVy8ECm8cGX32rApUJPzAGr//Un22x1bSM
	FYteH/+hk6sv//2NyD2srhPKWSaglpLzb6i5NfqIJI3CmpILzuJ24Kpvs+skEerN72w=
X-Gm-Gg: AY/fxX4mOMQfG2NJhfzPEsTApKlFC/7l/0Eta2nJKE1DLIUis2kZC34mW5Z4s/8J6Yl
	H6RrSA5cm4T4vytuubz6ARy4wQazdenUAg/SwaFLx0T6uutbtn5s9+u/Yy+f/QfHfIetVTiEGGG
	cUmho3knHDoqTFy/JfTe7pI5d816xHaR2uMQm5SyLnR07GP7m2k94yJZFVAXkqEWW7uSDyKh7z/
	GLZ2sB2zSCCWRgvIlREYqIkVRdTbCKNP5s+dxjyz9rmt1rt2L4A/9pwVx0++JT/dIoN7mVhmFw6
	wC8hp/GfApFncTh36LYqHes/fHDb+TUd9X4/SNf+zCmamkmatFuQwIvKynANpo6ekrlG05c/npc
	+WS298GPBOC0d0M1OX0QKAjHEWNAu24seP8JJbgAqtoICZ+hp23TXtmmr/KP1MTk4jis9ncP0qz
	ipp2HQ8+dn
X-Google-Smtp-Source: AGHT+IGcVRETU5SGb8qIhgBdGnot/sm969/AEg3tWF/SLDrOBPXwM9NZtaV8oGtTOpkC0w9sxSvHbQ==
X-Received: by 2002:a05:600c:3148:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-47d1958e459mr275597435e9.36.1766837955551;
        Sat, 27 Dec 2025 04:19:15 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:15 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:23 -0300
Subject: [PATCH 16/19] drivers: tty: serial: ma35d1_serial: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-16-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1239;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=jiVyzdGaYwwOjViBefbG/4tnbA+IZ6VTt4S6NyPkSWY=;
 b=Y3ytKQigesyzk6xu3oPXbBS5mHTUJ1mX1rT6WRhai16pDTDKrILE6MzhKcIyuYvYQYYU9QQLY
 +jUI84bHhmDDBPQbqZ6BL7ROSTnYW/5U7XoL9eZmy1wASQ14fgiWD4j
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/serial/ma35d1_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 285b0fe41a86..d1e03dee5579 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -633,7 +633,7 @@ static struct console ma35d1serial_console = {
 	.write   = ma35d1serial_console_write,
 	.device  = uart_console_device,
 	.setup   = ma35d1serial_console_setup,
-	.flags   = CON_PRINTBUFFER | CON_ENABLED,
+	.flags   = CON_PRINTBUFFER,
 	.index   = -1,
 	.data    = &ma35d1serial_reg,
 };
@@ -657,7 +657,7 @@ static void ma35d1serial_console_init_port(void)
 static int __init ma35d1serial_console_init(void)
 {
 	ma35d1serial_console_init_port();
-	register_console(&ma35d1serial_console);
+	register_console_force(&ma35d1serial_console);
 	return 0;
 }
 console_initcall(ma35d1serial_console_init);

-- 
2.52.0

