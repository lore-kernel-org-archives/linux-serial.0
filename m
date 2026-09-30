Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80317457E4A
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754806; cv=none; b=ltrT4U8tn03bDEi81x5/oZtm0Cj3gr2ZhqCRYflxQ4SpXIj7WfcqlYZE5Y0kJ3+EJdeRvxs6nlcYDpYMB9HfvkygMC5l6Ki9l2bwPjbySRRScNqsCYg3Kg+G36pA1DtQARY6PgkUfUijnwzSnkOD0bDfZzDwXAERG8nIHzioMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754806; c=relaxed/simple;
	bh=6DKatlxffhk1Ma2S0NPaHdERsrMNfgFOEbtCWhR/2HY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZfFgl+eJ0JhGsuSeKSj29LMcvuE2B83vPBXyyFvfOXEZsDoTd7lulBZDj/kkY8eIyCxXeYkzTf6oJvi4iX/74RFe85O2CeBtlc/Yk7MMxaZGBhlvEHkOMx0Kn8A7BSwE/Rzv8UqSpizxfVC7x78D9J/yM5V+dwfREe36q0r7AoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjRZDD/h; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjRZDD/h"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso20741215e9.3
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790754803; x=1791359603; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAVEwX1cbG2Scf8aznTJisEUwviOCJejkET+NM0/PLQ=;
        b=sjRZDD/hv6awRoJ1I8LMw5ZOcjx7ARAQAOBmSJR2APPmHVUImwbI0HW8EOnY1t+xBv
         PwpEa3QRlH3m4fjFF0JYQo4CZ1T+qtOyEltAo3S/RWLdA82/5zgrAT8RzL21fvcJ5gI4
         KL0Axtl2hVou0ltofDYkKVzMZkgOKkRS7KMEmURfvUR5QLvOVQQ6PGDaK/n/xtWz0uf7
         eSqwDi0Sh8Z8lb3ZU7H7Amv1ckowd9zVQBjvGoEGMDN1Xbic7tteT/8vquTfCBDqbQ/k
         rrk3VJyMFktreafSDrGg4Icm7r4FVkkt2Ww2h4fuLK8skxkvmQyYFm/MnvE5i7FU4r0c
         qg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790754803; x=1791359603;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wAVEwX1cbG2Scf8aznTJisEUwviOCJejkET+NM0/PLQ=;
        b=2kY2DXGcUIsMMTRGkQ+sD1litqSoga+AfNf1JfIJOWmGcfxIBUXCQ52Ws4ZS8ER5Hc
         +hmig0er6/V9vB9AZc3XqiP78E2c/yaylVenuqIKf4E1KbU+dOGJERf6Z9KoT+XvaIPz
         dsEvAztLSXaxWO6yN7Mq5+nVEHUEL9FJ/1pj6pk+Go/r+D08qcLb/2tfdkPd5vcgEhcy
         zXXirm1vcnEnUUjQFxiu8iq5mStwMON4q1KDJni+/THUR5iBF9Ski5hM0kV0fwbGJB+p
         Z8/lfF4xf4XYEpEBF/H0KxoFrsuETQe4OGDNRE+/XRzcDpKrDDoMKDXZ2/qpWFs3SjMQ
         FPhQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9iFBfYMhtlNBz3cErnaB+GGs7KmNYrNaTeu10y3ChTYDBESgjz/nKEW3az1QpTVmWT74nrPCADZsPpcI=@vger.kernel.org
X-Gm-Message-State: AFuF++l8E/rVDo5KL7l+IRso5v/g3WPAuYQKkS4Yxz2TKkLMDUslOBrD
	PeoOcjA8Ue9bPb2PNVNTs4wPHu3P+JE2NKwu1c4aFgV6omnjERL1yTM0
X-Gm-Gg: AYBFou2nVlDNbu7zN1ROauy7e4bAp/KxWH9u5GUBrx0AuE3/ORDTXqnINmAyu6MfGcP
	O+wdzZytiF/piRW4ehBkFysbYWXZ+U7EtElGS3V1UpJxIQRKXRS73YKO6IHwBSiFVX2pg6VZupw
	b7MBAumA6gF00wLmXWPXRAVxILECPxHFW3D1HNKuby+4F0nHzMfb9sRlGzHCsD5Jr6XENQyrRjK
	/uiCKhuS22zt3UAaEgO2vVy6o94qhMpyGvgcchpvAX6z3xSAa7qJ5uWk3Kl+SLWCvgJpIMLrktq
	60K9qaIbaDqJv8SzLz0QwF8smpbb92zEgp2Bpt/xEpcqhHzY6tXC3dn+NbzVs89JkGeVpnJWhXY
	nW0vRW8Td7XmY928395DQmByk0BaqAcspTDL7rmfnvv0k5XFkVlhYKciBMP7HE3Dj0dfBUhoKMa
	32kARiH33uUYav196d2gTF57272W/lPimlE+cblC6WrfR8JTCYppidurIzB94KEDix4AqyZF6YZ
	j7Jin+c+0TnLL4AnHB1S0o13m5F/Z9E
X-Received: by 2002:a05:600c:6206:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a01b01b8c0mr8229045e9.19.1790754802651;
        Wed, 30 Sep 2026 00:53:22 -0700 (PDT)
Received: from [127.0.1.1] ([92.241.26.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0175208e0sm32306225e9.7.2026.09.30.00.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:53:22 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject:
 Re: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART driver
In-Reply-To: <2026093046-scheme-fastball-59c4@gregkh>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
 <2026093046-scheme-fastball-59c4@gregkh>
Date: Wed, 30 Sep 2026 10:52:24 +0300
Message-ID: <179075474429.2320278.397112083512309038@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On Wed, Sep 30, 2026 at 09:14:34AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 30, 2026 at 10:00:06AM +0300, Fil Dunsky via B4 Relay wrote:
> > The ports are named ttyCS so that the driver can coexist with the 8250
> > driver in multiplatform kernels, and PORT_GENERIC is used rather than
> > allocating a new port type.
>
> But even if you build a multi-platform kernel, only one of the uarts is
> going to be on the system, so why have a new name for it?  Can't you
> just use the "default" name instead?  If you do that, what happens?

I tried it on the board: multi_v7_defconfig with the driver renamed to
ttyS. The 8250 driver registers its runtime ports (ttyS0..ttyS4) even
though there is no 8250 on this SoC, so the probe fails:

  sysfs: cannot create duplicate filename '/class/tty/ttyS0'
  ...
  cs75xx-uart f0070110.serial: Cannot register tty device on line 0
  Warning: unable to open an initial console.

That is why I went with a separate name, like ttyAMA or ttymxc. If
there is a better way to share ttyS with 8250 I am happy to change it.

> > +/*
> > + * UART driver for the Cortina Systems CS75xx (Goldengate G2) SoCs
> > + *
> > + * Based on the Cortina Systems vendor driver.
> > + */
>
> No copyright info?

The vendor file (serial_cortina.c) carries no copyright notice, only the
GPL-2.0 statement and MODULE_AUTHOR("Cortina-Systems"). I will add mine
and name the vendor file as the origin in v2.

> > +static void cs75xx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> > +{
> > +}
>
> Why an empty function?  Can't you just leave it out?

The block has no modem control lines. serial_core calls ->set_mctrl()
without a NULL check (uart_update_mctrl() and others), so it has to
exist. I will add a comment saying so.

> > +static void cs75xx_uart_break_ctl(struct uart_port *port, int break_state)
> > +{
> > +}
>
> Same here.

That one is optional, I will drop it.

> > +static void cs75xx_uart_release_port(struct uart_port *port)
> > +{
> > +}
>
> This feels wrong.
>
> > +static int cs75xx_uart_request_port(struct uart_port *port)
> > +{
> > +     return 0;
> > +}
>
> As does this.

Both are optional and the resources are managed in probe, so I will
drop them in v2.

Thanks for the review,
Fil

