Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A21514DA
	for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058344; cv=none; b=oQyF5QyOeDhadoqAwg/v13l8PR4fk4Qg6G81aSZWJuFUOkKuDNW/WQsraFv7R5t1sF1jvndblKpsyf8jLiu4QWS4diJFHvwbr8r1UP892po5uzBh78cMzpLsaWOdAkZBC0jbkGf1szg4JaTi9GvKTjvIIKGDjeVxk8SXRqDJ+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058344; c=relaxed/simple;
	bh=b/gmORW177pH358qwBll4nCzl18LhbdthrWxcEpd3WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHvMzacopFrDP0tQCVIrNJQzV/+T+kdkZgTEe8ZJwbS7jvLAQEhBLBMtb91Ael+s41Jo42HsJEhq4rx0evqu6+TeOX7jfMRk54dN5EzKPz23OCEzM13VwG19CcaeLDVnkpJnrEltfF+pGjSsgMlwKGZtQNIq4X2PB963SDA5R9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yl4MEXmL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yl4MEXmL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f6a837e9a3so29657295ad.1
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 15:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058339; x=1718663139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKk/Fcf4krWK/CutdJaQNqib/rpK58721OaB/B0Az0c=;
        b=Yl4MEXmLY1Hlh4sAr3wjNFtQ3BaO0gFGzAI7U5DW1fjXy6EpvqNrx5c/Iy1oucxc5N
         j/DnNXxi8fGqv0KcWHqj5dByyQvsT7zXM+pynSCjm2tJmvxk8BKNBBZ+CsqYoQUyIGQ+
         p1aH18VNQfC21BJV3maG+uPpiegxBXG+o9zZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058339; x=1718663139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKk/Fcf4krWK/CutdJaQNqib/rpK58721OaB/B0Az0c=;
        b=cCgtgE86DcLjD4aY+B0o20KRCQ41sSykZPDDtS3/LkKI4XoVFb/Bd+WrYaXZO5nKwu
         UaBltI0t9+7fYqEU+ItQpuCo1g1NuNQhWgzBAKmihgKxtxKseSHp8ra9hyYp1mXXaCJU
         YPpwcetcYKxxomzPoHzemxdufkbZpXB+hL1v29/PNrkzLaMqts21R88OfC+4UeBNJvsZ
         36FZEREGF930mMlDrHVsr04FYxWaJMZXBZIHnyettSN5AHRAqYxJcrtQG5mN8Ho/TtbL
         Q0uJBP5NWp9ZStIgs9NZX0tuIbbGl1j0ysX7ihmoc7luqz2nte4CgdvZhiCfI6CltEvZ
         J6jg==
X-Forwarded-Encrypted: i=1; AJvYcCX5bSsgTKuduoneH9DgMIOjG43RxBq3SQip6z/LCYTu3aFINqOQL25OkShjY/n/++goCJu72rraGN5MXWRh42QB4mT1TFVygHG/zD0O
X-Gm-Message-State: AOJu0YwFHnP9y3CyifaI29Fvye1tC7FzlUVp9q+d0+tpYqciZ6Hw3iSB
	HGskZ9gCY9REF34W6Jg4iBqHbTeF8MvUBtcO6I3pUfWSeV2x2yiKJ8juUSKahw==
X-Google-Smtp-Source: AGHT+IEPvKsxtcTKyVFqYj3DMCQNNVcrn0tqX55aDDTvedwEK+TaMY96o+XSdyorpL5zdw3WSjvBxg==
X-Received: by 2002:a17:902:dace:b0:1f7:2dca:ea39 with SMTP id d9443c01a7336-1f72dcaf3a1mr3583725ad.68.1718058338829;
        Mon, 10 Jun 2024 15:25:38 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:bba2:69f4:1b51:d0f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71029e223sm29212325ad.170.2024.06.10.15.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:25:37 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 2/8] tty: serial: Add uart_fifo_timeout_ms()
Date: Mon, 10 Jun 2024 15:24:20 -0700
Message-ID: <20240610152420.v4.2.I65a6430ab75f74d20c28b5c5f819dd5b8455933d@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240610222515.3023730-1-dianders@chromium.org>
References: <20240610222515.3023730-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current uart_fifo_timeout() returns jiffies, which is not always
the most convenient for callers. Add a variant uart_fifo_timeout_ms()
that returns the timeout in milliseconds.

NOTES:
- msecs_to_jiffies() rounds up, unlike nsecs_to_jiffies(). This is
  because msecs_to_jiffies() is actually intended for device drivers
  to calculate timeout value. This means we don't need to take the max
  of the timeout and "1" since the timeout will always be > 0 ms (we
  add 20 ms of slop).
- uart_fifo_timeout_ms() returns "unsigned int" but we leave
  uart_fifo_timeout() returning "unsigned long". This matches the
  types of msecs_to_jiffies().

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- New

 include/linux/serial_core.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 8cb65f50e830..97968acfd564 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -889,14 +889,21 @@ unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
 /*
  * Calculates FIFO drain time.
  */
-static inline unsigned long uart_fifo_timeout(struct uart_port *port)
+static inline unsigned int uart_fifo_timeout_ms(struct uart_port *port)
 {
 	u64 fifo_timeout = (u64)READ_ONCE(port->frame_time) * port->fifosize;
+	unsigned int fifo_timeout_ms = div_u64(fifo_timeout, NSEC_PER_MSEC);
 
-	/* Add .02 seconds of slop */
-	fifo_timeout += 20 * NSEC_PER_MSEC;
+	/*
+	 * Add .02 seconds of slop. This also helps account for the fact that
+	 * when we converted from ns to ms that we didn't round up.
+	 */
+	return fifo_timeout_ms + 20;
+}
 
-	return max(nsecs_to_jiffies(fifo_timeout), 1UL);
+static inline unsigned long uart_fifo_timeout(struct uart_port *port)
+{
+	return msecs_to_jiffies(uart_fifo_timeout_ms(port));
 }
 
 /* Base timer interval for polling */
-- 
2.45.2.505.gda0bf45e8d-goog

