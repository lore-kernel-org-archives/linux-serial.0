Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68E38E11A
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929039; cv=none; b=XrzSQjsgpbXkc/g3WYdlM3f3TwabYHwes3avaui33ocZMpcPK+zhUO04kpvb6QvvS4kngPRgpOU0UM+S2r4egxQD3YM0tF2ZJP1Kmy4f/GFE9wPsfFKtjgdDzKwEItz8RnoM24EeMfOFfaAVUX5e+9iclJ2jTBshjLG3NBze178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929039; c=relaxed/simple;
	bh=rXmESC+ogzRUoBCqexa0HRaaPKIP/aORjommBvUq5SU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHxyVif8ExfFvXvTQMPc6AmD2/9tWiREZVERE+rA11jav2w2IzPktFVm9Db2WPvzWMzeNqxjhNvuklkN8sPPsG85ftrN+bsUqcNbTbaQyvBxoa5pr/E8xf0tra2MqLPFsYEfSKnM6bUlLeBLvXkwMG0kncEVjP0qpdcIf7V6mL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s06Dc2w/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s06Dc2w/"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f97d310caso671054f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784929036; x=1785533836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nuZr0SzwEmaEHP8VYIwWfef2g2YTiEiEHZ6M99Shj8M=;
        b=s06Dc2w//fPcdmZ+fn7qrtNqyxtbyAXyNAvEKGAm0569RiDGIw7MlrD4dNfLft5h7M
         /sC9oPNAQe3WaCTzM+9xBXv2VWMLlpxIpjzWuAd8KRIg7/GUSdwvV7VCWvhpCytuS7J2
         j2P9VaKntNl20Z8yn5daA2aY/+7P2ij81LJKIQx63LXipXaJLKCaZHXFx5vI8zjKAY80
         FD3t+WwaRX38VKi46/V4B9B8B7WyXOoDjiKrZaJl+rW7z3OMsNZZnPaOKxNIyngtfm6i
         MDLleICM00CrrVKWdkXcnw30bp9gjA0D6PaJsjkJdWgh5kcWjD5wYlCqpY5KeivSUDpX
         Bdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929036; x=1785533836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nuZr0SzwEmaEHP8VYIwWfef2g2YTiEiEHZ6M99Shj8M=;
        b=BNoh0FqlCKfDZmS195ihv+om+9mIAbYW29FrPuxKlNDc+fdFdduCrm7coi5qf4p7aD
         2LNRYDeqV3bgSiaIC80nswotqTc2gA5xjpQhV9Dh+TMEbYgyS5bY0sL0bAJlIsL14ler
         WRYSkudbc/C6oV3ViYqdEjGlilD8mhRkhjyR3v4nRDdz/KnEDQLGyjCJsKXTI3/lynoR
         2aEWRrhoXIhfMBwN00A6/+nZVly44H+J+//wjYIzCPF20aX3iPVJWNJgB+kpzJBuQa6c
         qJSx62oo3EWuVWOm6zQsOpa8c7QDyLtsYfnq2tXwy5xbd9gk2i2An2fBbWY58/LoGIPY
         XVdQ==
X-Forwarded-Encrypted: i=1; AHgh+RoXSs1cxYrF6VNl5C3LdR3IEfGLGdwpdM7zLacQwsLZGnNXApKmn6SfGOKiseKvtQTr9U/1Z4kIvK1MDgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gJKPCKj6/Vq1ePQE6f4K3S5/RKq7Y0jwhE+KTVIAJXXqlxGG
	iORME24+6WwmjgTrRtE2qd210PH1a1ZUdrynzSRhm5DEPoQRK8xC/A0B
X-Gm-Gg: AR+sD10htTqcSenrP3OA+aFXu19KurtH2GbF0GtsbQFFzcoD6XBMqV1UkP2iAniTgQj
	vgXKfI9bVevK7juRr7r6iP68OtTkvgv0gIxyJyDvUCUuIXRWNygvL0Gj4eA4kN7cgv+EXdMYIEz
	UZQsvq8ah7f1d5bP5md2aVce1KaHnkDkZr9PAEAblHNKzVKwJBdwiA0llsJY3xnhocNaHgNpsEr
	HmSlWTgNao6ulty8EB0T/lnTjh/LaVf/WQ/mJp2r/0zG/U2/+JNJohzrudmkN/hJyDwnRGBOxmy
	wh3GpSHq0ApQchKULSbChclddR4i1HdmYJvp8Zgq9iaqt1jmdbbX+ad523luHtOty8yenOi25Be
	J/Q01w61DIPyebWE5RSgRblkOe5FVTpGPjiueD2FGAPiePzrGRBcIVEuB4fdRkXhKdbSq/Oiw1j
	1JC5QIauMN3L6LYG1BpjqyaCGGv0XE39OZ0N+IjC/U2oxitNlMupfyLErvlJ7jcIMVogBdVM/z6
	nEbmPGa7lUIq7KDYnbMEEF9H80B5TRRi+qmzSv892HhNTcq4hABQXfEvYRG109KR2nOIgTqUNxh
	EVS/N6RzdtGbYuZC+LlNgHgP
X-Received: by 2002:a05:600c:46cc:b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-496b57177d7mr363715e9.12.1784929036022;
        Fri, 24 Jul 2026 14:37:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae93-f301-cdd9-d5ea-080d-9131.310.pool.telefonica.de. [2a02:3100:ae93:f301:cdd9:d5ea:80d:9131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499cc49sm20754015e9.9.2026.07.24.14.37.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 14:37:15 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
Subject: [PATCH v2 1/2] serial: amba-pl011: unprepare console clock on unregister
Date: Fri, 24 Jul 2026 23:33:47 +0200
Message-Id: <20260724213348.77418-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260724213348.77418-1-kmehltretter@gmail.com>
References: <20260724213348.77418-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pl011_console_setup() calls clk_prepare() on the UART clock, but the
console provides no matching teardown, so the clock is never unprepared
when the console is unregistered -- via the sysfs "console" attribute or
a driver unbind. Each re-registration prepares the clock again, leaking
one prepare reference per cycle.

Even where preparing the clock has no hardware effect, the stale
reference leaves the clock framework's prepare count unbalanced. For
providers with prepare/unprepare operations or runtime-PM integration,
it may also retain resources after the console is unregistered.

Add a console .exit() callback that clk_unprepare()s the clock,
balancing the clk_prepare() in pl011_console_setup().

Fixes: 4b4851c65d92 ("clk: amba-pl011: convert to clk_prepare()/clk_unprepare()")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8ed91e1da22b..1aa43994a3cd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2552,6 +2552,15 @@ static int pl011_console_setup(struct console *co, char *options)
 	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
 }
 
+static int pl011_console_exit(struct console *co)
+{
+	struct uart_amba_port *uap = amba_ports[co->index];
+
+	clk_unprepare(uap->clk);
+
+	return 0;
+}
+
 /**
  *	pl011_console_match - non-standard console matching
  *	@co:	  registering console
@@ -2705,6 +2714,7 @@ static struct console amba_console = {
 	.name		= "ttyAMA",
 	.device		= uart_console_device,
 	.setup		= pl011_console_setup,
+	.exit		= pl011_console_exit,
 	.match		= pl011_console_match,
 	.write_atomic	= pl011_console_write_atomic,
 	.write_thread	= pl011_console_write_thread,
-- 
2.53.0

