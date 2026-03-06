Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6F324B1E
	for <linux-serial@vger.kernel.org>; Fri,  6 Mar 2026 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772761871; cv=none; b=OZB6+bKUJMS/fxybWlujCxPQ+4Py1IeCa4rtpViNENE2nKkCEWAFQsJMFiV7zfoMbBuben7sDMFEyg6YpIBOL61Dla1kKYgGbhTW1crL3ROX5UD6+tT5U0MPYh4zB0cHE+vC/sjJ8Gn/OCbptbwtqL+2RFDWgY/iwcW0jL5Izho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772761871; c=relaxed/simple;
	bh=tXNu4K2qwxQZWqVrmJaj8+HnAS6ukw2OelG6cwxhfp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4QqqZQQFGilLZCvDmooRKbHhaR8AAufhIF+JWThw7Oj4CXpOtvEQhuc2LBNJeX26nzl+L+Q8jSXaHOoLmi4OUvOGIY8TtbkCzrnNurpPmt2ufkReyRH+HDJZUnDEz+VB5kyzgeLn6piLAOfPpPKqJ36oc9kG8p1b+sg21VlwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TESTeWDT; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TESTeWDT"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4645dde00a7so9129578b6e.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Mar 2026 17:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772761869; x=1773366669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUT8OXayauJDeUXGjkmGNUpTYIk2PPPOV9CpVsGLhj0=;
        b=TESTeWDTv967lCziSUvostSRTQYHlkcB/+wyqeKvt9MYYLxFzC2+Fa0v/k/e+ypi/j
         OFxN5qkb9h6n1EPWo9QiWtZqGgFVll9kgGM24FWQKlpADk8NcAhGokyZFiCA0vR0bUS/
         BKBh9ECIkYMTv2E7WJj69uZgEwhHGFHpcqtH5MVjpLgKTnAG2GNxpSYgjvgvaBjU06Hq
         076LjmGT2K5lp9tRoHdD86mTwlGNHUo9xDS+5cxZXvrqj6cxjXITYJqYKNFxHc7hROR7
         Ku02Go1UzijzlMzszL3sBlIZaoZmFphciZ1Cmx6qSl33dXYMoVAyGQR8Eo2G/aKV1as6
         4NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772761869; x=1773366669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUT8OXayauJDeUXGjkmGNUpTYIk2PPPOV9CpVsGLhj0=;
        b=nConxAr1LFxJGqKY/arbl7atsJm8xkz6AwFKBpwu1twZcpU9IYuHBxJ677kbywA8be
         GhyqGO+1PIJAvX7ZoNSqFISm2E5mIZIbw6SFCfY6B5jg53Uzigf+OXIiRD9d/e/j0J4T
         QPfvL07Lt0ZihbgMAiUG1OCIVftGdrJBWdwAF4I46K2eA1EHoHhotydeK5gXgW3nU6HM
         Czr4/tnHkYPaChySYHunF9iVc7qH95BxgXz3DKS3OFmePNipVccwSSNnJRPRF+xfK6Hr
         fgTxqyRUWnP6f0QVt1I+EDYNqJRmwTXOZm8n98cxXVbwgVWYicyVFMN53ufRT8T+SR5I
         VuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv9kbPIW6jodT8E6Vao260OTlFElPyd6PvCI891d8dyFcQVgfc58PfwbR22Dy6radIx++kxDP/zWR56Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWaOWKEXKN1qKrfZYoXxVx3h0pAHmG1meeIqOlEzyxKfSkHHwh
	r1OEq0UgxBJ3bFOCiShfwBdmf60Im2RmKWEco/XQYcrTymnKxRbL0tkJ
X-Gm-Gg: ATEYQzz3zhOUanq7S1/fOHnpPmXtV+k6QEAYu6A12tPia+D2GOBbcluayMC80Hyx9AK
	063jfhnCdqrGvVSPbbShWPk+BXDvf4ZA2Pj9GxxrkhrIveV5fyVZt8LlxXIIUFAGIzE57zV9jmm
	tY8lyQXp0gXfaratksGheO+ov8+U+Kt2DvqKtHx4b6dhmHuysZ2C0K2SGt44eLo0FDE+RULh5Ql
	eI4h8rWcIn+1T/PX9WuYMDW+bqq4F5hi2+AP5kw6/dR2W5xtls6Omi0f4gge7yqMX7jJ0ahttcM
	5QKHUDFxUkhUX0xNduGCk+lWEi9OikFlNaX+gTf24n87cYNu04g5FMDmGG1uynZGHKfhbcwPwp5
	ATaYJbPVkKOLIq6eC2tDmyaVyj9ZDmsNN5CHeHDGiJwXhX1EvkmbCU4i1qdzUCz7yzEbVYxzHRg
	Ezi7byKXBQu/fwVEZ7gupbbsxRv+JrfrdZjSBmMooWS0oedQOe
X-Received: by 2002:a4a:ee14:0:b0:677:3b8f:43a4 with SMTP id 006d021491bc7-67b9c485db9mr276619eaf.36.1772761868900;
        Thu, 05 Mar 2026 17:51:08 -0800 (PST)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-67b9cc1a627sm115245eaf.6.2026.03.05.17.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:51:08 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Jim Cromie <jim.cromie@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Joseph Tilahun <jtilahun@astranis.com>,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH 3/7] drivers/tty/serial/serial_core: ratelimit uart_wait_until_sent
Date: Thu,  5 Mar 2026 18:50:06 -0700
Message-ID: <20260306015022.1940986-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306015022.1940986-1-jim.cromie@gmail.com>
References: <20260306015022.1940986-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ratelimiting these pr_debug()s can reduce the console flood during
bulk dynamic-debug activation, in environments where a serial console
is used.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 487756947a96..6db465619c70 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1790,8 +1790,8 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 
 	expire = jiffies + timeout;
 
-	pr_debug("uart_wait_until_sent(%u), jiffies=%lu, expire=%lu...\n",
-		port->line, jiffies, expire);
+	pr_debug_ratelimited("waiting on (%u) jiffies=%lu, expire=%lu...\n",
+			     port->line, jiffies, expire);
 
 	/*
 	 * Check whether the transmitter is empty every 'char_time'.
-- 
2.53.0

