Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389040;
	b=ErH0u0ZLisIHr2zzcM59Hdfmas/5AxiMX9LAYuf7XazfJmwkCIw0ZwnTGtwVrQ6qiZ6b
	 kYigNJxWAYHQJdJJE4QLs3ZHnU0dTQ+EbFLkvEbWhD0WrZaTbXPzywYhKBNgcne+qDPWk
	 rZyeXpv21al/qp1iNuGyvWzYp6qJJwezdDK9FgDrcZYmyqsrIf42AxH1ZV7560zbHyV1C
	 54xb6atKBC1tGhmEHvwWkERQaSkWq/aUa7uCRi3XwEFHcDAYeymMuH0kTYnozoNTHt1xk
	 9bhqtNEl5G49D83Os5HsHodfqrOqSbqVnMWrMupAgf0zXP1YDekt5I0mv1A1Rk4y8aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389040;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=SY7OJM8ZG0Jh/SWQfrv9OLYQOe2MDLFzx0fnNRaTrzc=;
	b=Pj8wjGUwDtymfoOJ2ELEIE73ZQmCvRczG0GkoPLHZeInTXKu8/uWGW3PqRv4dUql4nCv
	 zJoxow/4cSjDjUOJqIYElz8nEMNwJZ7Akl0o9shtvMsb/XU7jco0WV3ti/Qwv2A4rWYjO
	 rJ1KgFmiRmWDmHDoV6F3TZzsNIF4VhHQnREhkKWwBQHVsN0SUQNwI1llWqGKYUHm0hE5J
	 NK7pzcjDFNVNt5NskP3Vtkd7WA5nakOyhr5iyxfOdw+SXl54WSC4hCvXUOIvW6ssClssF
	 6GtokxrgYs/2jSXyo5aBg3us21D64BZHl3g6Hl0f11sYuJW6khNtL+fAGDxJ0A1PFtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cryspen.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4224606A332
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 09:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4224606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryspen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so29246455e9.3
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 01:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389038; x=1794993838;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SY7OJM8ZG0Jh/SWQfrv9OLYQOe2MDLFzx0fnNRaTrzc=;
        b=calUI9sn0PUmR7Lf4DIyk7d1wotsdR7h08AwnW3aEIqc+5maRdrZNcLnrOv7JX6GCF
         1pNTNAnRtXsY7Vh8g09CMpPpnfoOOm1cskOovQWThDF5/blEiknia6miHoP1RMLYfRHB
         XmEqz6XnrzELF451GIhRYYC8ClxzGX04NPNFZjQbJvY3JPxv9qiMNHhgsXziQ95dqPqQ
         7Ll/f+JfIij9rFoUsI5F5dChbln22NQdCqwSdFkp7jH6eXZsIJqJc3jYolAi7NA5/vqA
         /hXSYAk4dj19IdM1/AEZs/gemCBHWfhtuMyeqkgCHE3CSJs4Vyw4f/qdusgmsM68Ea70
         k9Xg==
X-Forwarded-Encrypted: i=1; AL+hErFb62NXfK7EBm7dSXsJOL0+OjYVZmB1pGDu2tQQKGcOU2nI0IMaerWhmaRooZGlMwfWVKTb8GcWmHqvAMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/X1CtuGo61EApA65lrEXM8OA4VUo5J7PUPqESRnFmvatFzIuzG
	IheCeyD5bJHX5pEthsxsxsIebpM5JlLdWJQqZDAhwEI7V+eHHQjPDITcb5fPSJf8yavOjiTt
X-Gm-Gg: AYBFou2SOj6V9Xx7sXJMDnBEj7slW0UKywiLHO92KlAWakdv8VY6LvX9QDB5HmF7E+B
	GM9O+9bvJA7J4kqO4Vf/99HLsmaCr1DuH24UT8Hm49IlDgUV5h+asgVVIy2yKRbO+YzCSlm+lox
	pVbiMDfbZGeZ/6mR0PT6DNAMG5SiPqJGhRZFjdQG45O2eJ84/u5mMXdmcvSyx4HDqyt+7SmRXxm
	UzbUhcd1epyqHplPTwKBl2qgS2U372PJFQMk7+yrNqPnk87fgrja7cF0mYEOyTzako1aWPATYqJ
	cxVQOeJZMo2vcY/akeyFDatrSK9kbThK/CVp4JcEIaOTnNOMu/Tntni2TlkeKF0znT/7lxe9uQa
	K3NMkdqRdoUA5cGl6x1r222s4OuIbOEA+4+QH+S0IVWeFu/U3eTv55WV/9MhmPzJ/xyGV+PS5gp
	9iJGJhCZD4wJWYpc5MkiquCyXXO+sSSc+9/TR3IRpojT0jY4XRsBuk3PU7bE/isAdw6JmvFaVFx
	aRmQyLe9UMVoOg6SJFmhn76439y9u4Lx9i1H/QQm6Q41HAHiY/LgXpwRobaI4yq7tyjJfuvMHLb
	l7cvrA5vbHSu2+LxtgvJvklA9P5vuyV0lI1PcUGt4tOMvYUPlglAVoLwJHsaVsryKq4wDwV7KRe
	br+/gfsBW16vrzxmzNRBaWEW8CDAp3GuPZEdFuB/tMnd16wceJpUzyQGIIeeaUVTLuI4ci+1CvI
	8t6pvmjNhp8g==
X-Received: by 2002:a05:600d:82e5:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ba0939c32dmr35097815e9.27.1794389038186;
        Wed, 11 Nov 2026 01:23:58 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01feee1asm169263495e9.12.2026.11.11.01.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:23:57 -0800 (PST)
Date: Wed, 11 Nov 2026 12:23:54 +0300
From: Dan Carpenter <dan@cryspen.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kartik Rajput <kkartik@nvidia.com>,
	Nicolai Buchwitz <nb@tipi-net.de>, Fan Wu <fanwu01@zju.edu.cn>,
	Frank Li <Frank.Li@nxp.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger@gmail.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: amba-pl011: Fix divide by zero in
 pl011_console_get_options()
Message-ID: <6fdea544b2fb8f4226e296a952331cd42684474d.1794315353.git.dan@cryspen.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When you boot QEMU with -kernel and don't set a baud rate the ibrd and
fbrd values are zero and so clkdiv is also zero.  It results in a divide
by zero.  Most of the time people don't notice because on
qemu-system-arm64 when you divide by zero the result is zero and
everything works.  However, if you enable UBSAN, then the divide by zero
leads to a crash and the boot fails.

Return early when clkdev is zero.  This leaves the baud rate set to its
default value of 38400.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@cryspen.com>
---
 drivers/tty/serial/amba-pl011.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7b1f99395f6c..a630d4751628 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2600,6 +2600,9 @@ static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 		clkdiv = 64 * ibrd + fbrd;
 	}
 
+	if (!clkdiv)
+		return;
+
 	*baud = uap->port.uartclk * 4 / clkdiv;
 
 	if (uap->vendor->oversampling &&
-- 
2.53.0

