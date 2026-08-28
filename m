Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94E3793C1
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939900; cv=none; b=Uho/sKOunpCEkfYb3OmNgUTEgaLTjg4EhiQxxWd+g+uV77jp8uZ2U7lggBcA2i4C6u1VBWExtmASHvnqaG4k7fLC2R+EihuWASMqZ+AXF5zf4dxyHkDmE71vtN6xg9RZMbkwkoxd1kkYvDmVJMRWGxPirap33Cp9D5IZ9hpGVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939900; c=relaxed/simple;
	bh=/aoZ3pzX2YkJW/byRykTVvjh8aaWWZMSSd/pLvnGslM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=hvXHuzVHaTFIrc6/SmnFqjUhkDMxLE8pY0sDHZXgSfeToawuArOb+VvBjWDJDLXuzUMeqkiYasXr4sG1qlWxUp5ZEu8KCdPDFh8a356IHQ7E1NXCYwviiNHJK5B9KS7oahjA843DpXOFvro6Dyb6CLR5MdYR4z+gM8n9VZ0TMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=cUopStk0; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cUopStk0"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-396b3d0df94so1363017a91.1
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 10:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939897; x=1788544697;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+S170kBki6nof9YgiTY8IcFN3wYGUx1ViOy9GFjSO8=;
        b=sXUJHxKg/QtXJaGep/42jxXpLnjQESsugwVBuVkgkKbQ5IFYsLCEFDm6n7AJHZZYpe
         rTdXJ/zSNHNrM2Rpyz96EHK4fV28iXBPmV+NJ5lfV98t4sZ3L3YKQUuHqhGOPGAA9nV9
         d8vPgDCOLN41Uxv/doCqGgNnMyH4rK1cAEjpCxs/GtfP4Ajh9YxdZH6DynZlLkkNKeNx
         MPrlMfqmG9zKnEHb4hFI8r5YrBpyVPMdORy2297Ntac5ZXkhlxQaZGJ4Atre2a9bciUF
         udZkqpD4eZUebJMu+QlTLpVNODutp/Q9VO8D1w9wEbloyOTPF080RKxtNB2sP0lnMW3e
         NrvQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/B4OD0RcnXz448ekZTBsuPN0jqb8FHFGBlmMX/7ZTs/k8xGW0N224HAqbc1anA4I0YoCrso9hhM4s0JQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lYEUM+zDo7dVCo35/NnMb3dWhXNhCZZqrK6U3K6RlCyk5H0F6L
	fH+REj6HY7Ex2LA8OxfslqEGYrfwq0+3SEO9L5yfIZ1UjB0O8HlMUBxU9ZlLyjqPMyTgR9s+9yy
	eEIsN7m69SaGm8/aVJl70L7q8nx3QY/AQUQ==
X-Gm-Gg: AYBFou3PNQGlTkaLEi0sk4bQeriZS10eCK59CxlNCSk9WusDNmqLgSWazKSj7U1/8e9
	OmjlPPnCaLN3/ttUU0X/7FpL6JeE6NRtMdAqyOS8zkpNrHcFKysMSRCeZKMBJWVNbdb7l+zXVdc
	QMDzL1E8SSCYDJH6hYhR+Qo9utt/AGwJw4HarucBDVSNRWiATdwun4Aut5DtQo/GmB3QKPusHQg
	V17m6S612IBoRxRQzDbzd1HZj0ogHC7NqQHht4kYINnqdBuJKYsLkBjmgHkJzS1pRNImbvN2hXd
	h6jOLhuZGYdi/J+K+mbH94AxGKXKHhIdtj3tsFupTms0uiadjEULIEKVfSLoMx6r60TKuXUC0t9
	r84k6mGiHIMMYOQ1mwHZ2/4tFKcbfN6QKSzQIr4PMBmb8vzuez3U+yPUEAG0J
X-Received: by 2002:a17:90b:28c3:b0:398:9be6:f996 with SMTP id 98e67ed59e1d1-3989be6faa2mr2182996a91.21.1787939896866;
        Fri, 28 Aug 2026 10:58:16 -0700 (PDT)
Received: from smtp.aristanetworks.com (ec2-54-84-120-176.compute-1.amazonaws.com. [54.84.120.176])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-396ddc75f55sm1045887a91.8.2026.08.28.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 10:58:16 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1787939895;
	bh=g+S170kBki6nof9YgiTY8IcFN3wYGUx1ViOy9GFjSO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUopStk0BSjLV/nFM526oJz7y4siHrHbP6VmPz47ng644mMM6cW/keapMPp7BVGpj
	 FNcJWT7F7ptwzzq+UrVbpXEGo6mjCtpdGhfO1dMB1wI6e84VZ62xuiRUTcN3jpgJTl
	 Po4Z8wKrA5xfcWae+80vSYk0Izf9A2FfGntJ+0w1eEOPocai8hn8eZGF4ecbPYtxx2
	 VjatMsK9JKp2reUkEIyl0xIwBO5HEVpDvxDNgsBpXuWsMKFD8JjCcUNX2W1gxlvE9P
	 /4Xwfx2NOfW9K6bofKl69D6Yx8ZXtcdOhW/0W0oXKZrxkTruknbTW8DAKVukZR1wvS
	 ynwrHLAFMZXQA==
Received: from vm-whiteberg-ubuntu.aristanetworks.com (dhcp-244-90-77.sjc.aristanetworks.com [10.244.90.77])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 16C8FC0CE0;
	Fri, 28 Aug 2026 17:58:15 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Tate Whiteberg <whiteberg@arista.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tate Whiteberg <whiteberg@arista.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 2/2] serial: 8250_mid: wait for LSR tx empty before setting termios
Date: Fri, 28 Aug 2026 17:57:28 +0000
Message-ID: <20260828175733.1650267-3-whiteberg@arista.com>
In-Reply-To: <20260828175733.1650267-1-whiteberg@arista.com>
References: <20260828175733.1650267-1-whiteberg@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

If mid8250_set_termios() is called while data is still in transmission,
the corresponding register updates will corrupt the transmission.

Fix this by locking the port and and waiting for the transmitter to
empty before performing updates. It is necessary to wait for both
UART_LSR_THRE and UART_LSR_TEMT to ensure the final character is sent.

Fixes: d9eda9bab237 ("serial: 8250_pci: Intel MID UART support to its own driver")
Signed-off-by: Tate Whiteberg <whiteberg@arista.com>
---
Changes in v2:
  - Separate changes to 8250.h and 8250_port.c into prerequisite patch,
    as recommended by andriy.shevchenko@intel.com
  - Apply feedback from andriy.shevchenko@intel.com to 8250_mid.c

 drivers/tty/serial/8250/8250_mid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 82656645b8a6..ce792888acfe 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -209,6 +209,7 @@ static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,
 				const struct ktermios *old)
 {
 	unsigned int baud = tty_termios_baud_rate(termios);
+	struct uart_8250_port *up = up_to_u8250p(p);
 	struct mid8250 *mid = p->private_data;
 	unsigned short ps = 16;
 	unsigned long fuart = baud * ps;
@@ -231,12 +232,18 @@ static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	}
 
 	rational_best_approximation(fuart, mid->board->freq, w, w, &mul, &div);
+
+	uart_port_lock_irq(p);
+
 	p->uartclk = fuart * 16 / ps;		/* core uses ps = 16 always */
+	serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 
 	writel(ps, p->membase + INTEL_MID_UART_PS);		/* set PS */
 	writel(mul, p->membase + INTEL_MID_UART_MUL);		/* set MUL */
 	writel(div, p->membase + INTEL_MID_UART_DIV);
 
+	uart_port_unlock_irq(p);
+
 	serial8250_do_set_termios(p, termios, old);
 }
 
-- 
2.43.0

