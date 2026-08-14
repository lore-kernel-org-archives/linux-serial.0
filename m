Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1444570C3
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699199; cv=none; b=dHqI0I/fxE8jwrm8r6X/OmPGPZqaec2Vhgw97cHDY1d3JdTgTv3lb0alWdc7UABiFyvYLcpJELb0atCR5D+JY9gjlHCyCH7nFDed9gx4Y4hZXtNW0Vu9PyGwiq+zX4hno5n99kZlsdNrWYqj9rwTPptKOcITpSvCQuyCCGkAv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699199; c=relaxed/simple;
	bh=1Tf/eLztcajZ7S8Q0F+FjtJiQzvzesbS3paGTmNNuxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PinD2m+tfahZ9GLPskOy4dEGKg16WH+ZZ3FkUDLQARjXtjdb/VwptQeraQilBaiPHsLLW4MFizKqCM8I+cZxscJn0WKOSDivYnhTGKeQMmxz7Z6w+DivEQJQ9ZjFA//VjEQk0XsXWPhbnyustD4s4GbQ4vne8aavXrPMtaQrKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=o6PXVG70; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="o6PXVG70"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f904e80eeso748210f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786699195; x=1787303995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3xLyJAYPS0unz+4dcq3L1U9sMIMO3rlmUhONpX0XaOA=;
        b=o6PXVG70Mx27qFe4P0gF8afUDYWmroX4zp6bmsFxyCBX3h4V6fjX+/BymCs6J8iasI
         2hbquThdBdhBOqpLE2QF26MhTbd5Ruwu0nkRjlSo6Be5Mi6Agr48EP0iezCHxfi8e0Kv
         eUoAU8nzHr08TxjjqRhN2XmK2oEfnXfqDrfD8jnTL/5htf6PTRjHKtpW8oa5nS6zwT0Y
         +hEKoCrNK7xoTPEtLtdoBIsXC98iw+oeo8w1EUC6K4QL5ZZwOt9DSC0yPNcFpz5sF7RS
         LoBBDy5Os7VBAh83tEFnA6EMl2O+ndbVWuykEb8ztz2ltq5aCppWz4+dhKYTotj5FzqN
         0a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699195; x=1787303995;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xLyJAYPS0unz+4dcq3L1U9sMIMO3rlmUhONpX0XaOA=;
        b=W1eouP/xuHslI6/PT2DwnCLdLL754yAQOrvCuQlrF4yelXryVCR5sN9ixV15g+tgoU
         OQk0DYL4UTXHsG1ElLcfgsAGCYmsRHUsnsDpUMmKdV+kBWhF97SRnvfibR5Av5sjUt3h
         NVnrTLwLUfjeqdxp7fX77i0JgkC8bOcb3wic6+fLX1MXJyU1wQ6H7g8XjcU1AVftEae5
         mmtGrBoaRCnNqoW6WmVbMk2JJHArUtCvjUz4Dhcez9L9EyEDerjLeyCGPKlbQuUSh8xf
         i/MGBGtdZHDjn9ThMX37YzllIBla+L12C49o0Z/u8VdL7W7b+you1SOvfQFJ0G5M9uNd
         cPYw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0mp7Mb9L0p2rxbSeRyzG1JZrj+Yvt7fR6DqiCHLGQfNWNlW7+bAXP6yMHGaP1mQ8yUCWy/JPhsnbNI8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz/2LZuX72+f+3aJwG51Zs/ymr+MV+g8Db32D+6NOHK5AHHWSs
	mH5Ygpewlkpe2wdhhhhs7qwnerzCaN00o+wsm3NHamI+f4BAQnrVDCJ3v3P2ATge4Dw=
X-Gm-Gg: AR+sD137rpwiaEOcmWa9ZCHvWUMw7CTZiLCyi8Dx+KJpX0nRa7A+7fMHEegU5zU0K8h
	nNP+B0U6Xcxg8xG5B3a7drFbJWoUOnVjfZygVylfYFRqqKHe6TLV81UZJkmObaCx8JGaJmpVdo5
	40102KkCF696r7nyB2w/BYR2EeWYY5pHY/Eo9f6Z5iXkLdKEb/92wxGJrLFWFvSzDs2v2gbfvRL
	EU80qQy36yiA6uceaGk26LMiNs0dVmTbkptAIHbOdj7aQ85QVYVZTvYBzjfXfO5BBfFrBzIGkzp
	0g6ilPOcAUr8DjtlMYrOAAaOvTPe5fOOdW9ybCCIdifJWtbu7bgL74cbjQNjaqTL1XX6XdkkBT5
	Jv6QWrEfXiXC4ysoY8RZQ8IVF4sF4SlU6IUbdrCZ596JxXtk98Xe9UIf6FhIAZbAXHQ8A7T+QpC
	ucEkDadyXZeFQT/LVVJETXln8wq6SI+hxT9oP+o63BXY4avs4KuGO4eeZAoBOlxp2UwtX8o4dwJ
	5xIP7OMWDjoHpsdNYiB6w9j1zorjLkhxCjM5J8TiZ66dqCc4VY89oJIJbzVY7I=
X-Received: by 2002:a05:6000:260c:b0:47f:97e9:fe60 with SMTP id ffacd0b85a97d-481607540e2mr6284706f8f.15.1786699195567;
        Fri, 14 Aug 2026 02:19:55 -0700 (PDT)
Received: from localhost (p200300f65f017104e65cfeae4f257a65.dip0.t-ipconnect.de. [2003:f6:5f01:7104:e65c:feae:4f25:7a65])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4815f2c6115sm6510009f8f.32.2026.08.14.02.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:19:55 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 2/7] serial: txx9: Drop usage of uart_match_port()
Date: Fri, 14 Aug 2026 11:19:28 +0200
Message-ID:  <b9287ba4b13b32a11765c0532db5d34843227373.1786697789.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
References: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=1Tf/eLztcajZ7S8Q0F+FjtJiQzvzesbS3paGTmNNuxI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqft2lBdej6+oWxYZYWWKZtZlB7quUTjW42xBkf fniCEVsD0uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCan7dpQAKCRCPgPtYfRL+ Tu7gB/9BYIkVUopJOi02OxCh2FlG546H2RnSQZKMV/e9NSPryOfGiVxUSv+azmGgE1ZpOv3tuxP W1fCx2ny3EL7d2nKmp3SZgwdbH0N57UEr6mKZqeLU0/JWqtvoc57RYCmtXPJmvC5xYY6KggVeWq faws/y1Bz+ru+0LHghFRTK9FCnVW7FixKhFa9kXcOHbBU5wUihu3RI9CZqw5CdNIZVPces1ZQpT yH2xraUH4DujgeRmzJxroAr4zsA0EcCptoLdykM3O7yepFRIi2TyNxZiaRbK8As05e49CLwz/E/ M8d7yJ0PwX6EotQMhU5wABNrjkuglUbI07n4OBHPZRf7E9Yg
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Where the uart_match_port() function is used it's known that .iotype is
UPIO_PORT. So uart_match_port() is equivalent to comparing .iobase.
Remove the call to uart_match_port() which then only has a single caller
that is handled in the next commit.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/serial_txx9.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index ef56979321b9..5b574ed276b2 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -965,7 +965,12 @@ static int serial_txx9_register_port(struct uart_port *port)
 	mutex_lock(&serial_txx9_mutex);
 	for (i = 0; i < UART_NR; i++) {
 		uart = &serial_txx9_ports[i];
-		if (uart_match_port(uart, port)) {
+		/*
+		 * serial_txx9_register_port() is only called from
+		 * pciserial_txx9_init_one(). So .iotype is UPIO_PORT and
+		 * comparing .iobase serves to distinguish ports.
+		 */
+		if (uart->iobase == port->iobase) {
 			uart_remove_one_port(&serial_txx9_reg, uart);
 			break;
 		}
-- 
2.55.0.11.g153666a7d9bb

