Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745C3D3002
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578695; cv=none; b=kVqfVeEMclJMs1aOOW7lT2MAOsqJhYbY9xXZ1BiE7th4IIF4JMB4kwFgvbDdw2QEF1N8XtsQO4CbJoN4iSCKB6PEy2xR6n5jg8TebryWMw8T0MnzljPXYehB+VzfwrPwVJaAtzxiePfcL7ltYNHCNE5SRn1BAtSS7Ud1UkIkPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578695; c=relaxed/simple;
	bh=5bNR+v+vU3f1vP1S/Nlxk0QKH2vWG864BQ7ldM2IM0Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PR7yrRKdDH/oNkDoiHR8UhHU3BCFOY04OeTv6KUrWxr5bn+xcRAOw1Y8RWTEJGyHzKRbh/xpKCwlfl7sloWhy4aODXh3dQtUZ6jepAW8qw6x1qgVzj1+RSg5gn7VVzGNgAo5C1+LpAGjnqT+wFjr8Etqb1koug6mN/N2HkZeuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bpigeooc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nf08qqot; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bpigeooc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nf08qqot"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 85425EC012D;
	Thu,  9 Jul 2026 02:31:32 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 02:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783578692;
	 x=1783665092; bh=NHEqFUzgGuUH7Rt9Kyq5q2dhYfpUZW24+wCZYMJWUog=; b=
	bpigeoocVxl8BY/ry2qOQfB6Cz7cz0RKyhnAl5UpFTWxxYrbCFZaBmNmh41R9w7i
	vTMnZL8HXMgUhnFX35kBZfvaPjLFHz2FCAAtZhfe3mQZeY788OThGTUpopTvIIl+
	ktDQ0588uIFeyYI2oLM5mf+0gUTtLcQ7401lsF7eqOiAW4fuGWu0iemoxDq0H+cQ
	lL0Px/jZqrEdEV8q6w0n9FE9D/9+D8zcfDAkvbitFEU/R1Rrjas2/mSZl0rmbDnG
	/OYXQqMYeQsQIeS7sfMSZ5kpuGmo0qDuCk/EPhfzBcl2HlbRHdUC22YdXY73uFyi
	IlX4rAS9HleIrOmK71rX7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783578692; x=
	1783665092; bh=NHEqFUzgGuUH7Rt9Kyq5q2dhYfpUZW24+wCZYMJWUog=; b=N
	f08qqotbXSviRpPz8DF/Qp4Gg35x5ciWmz6xHXiaJaUt3EM8SlILEAss+mHWj4MY
	TZ9+Or8spUMlAHAYgKal7amOxrPd46lv6iPtguE02+c3ul8DiiSbIx6h0QypwaKa
	GLWqg43vpmYUFVguokgZRJmRRJZAgAGG36ptRsA7ekhlmxeGgMfvqXoqFTEhrpWA
	gyxnzKFG821A4XQ6y84gvt7oYrAE8svSBu9igTy0cYkfHnAKQtoRaK/h/eZwAB5+
	3ralX03dDN/12RneVo3wk5ZW5F2RfSF1C0U2i18q2R/YHYr4pkTEQC4Q05iz1C8O
	4U7QAtzJVkbKq0F/3f2sQ==
X-ME-Sender: <xms:REBPaiuAouJKTwvNCXVyNr3n-qA1Qs01l9gOI8TcR7_D8w5s6m3y8Q>
    <xme:REBPaiQIisv8EyNFroadB6dGC30VUi2YjeC1dSWfw5aEtlaY7Vd1azzf5lkJJcQBB
    BnimskiUpUbkZvzlE-fd497XO25QCYHPG9dBUISHVgo2MyJX-ZJ5kA>
X-ME-Proxy-Cause: dmFkZTGba0J+XKfIW76mmLc+czUnTDwffbl8cPaAot1756l/RSxRZNQZk8F03CM7pAh8S/
    ccNJcnvl6fbFEGR6OYLqfs8TYuIiqFRZylJP3h+6nau8xNxazOoq24sXEMkJrV8qLThNcb
    lX8cSNVEH8rYxnysaRlwZMgvp8OROGaXdS/oTKhhUFxOPaC5yOnrkBwEfXf+nQVCQlphgy
    1xPXiMRgTcXD8ESch9z7DY0f3mW8zUNKqyvPihYCdrLqyRGNGMXv8gm6Z1MQu9paYaMQ1t
    AXJyO9/Irgbt8WdsFaj71Qj9h+XDB5dQuUPwZRb3/3y/iiS7UTfke4GJrAE9ry54naWNLJ
    OdW/g9n7YBN7XmwfEvL3XDQGkQWCwXc30R93n9Tn0n8WCtLgfX6dL8DVrk8ACBvA0lwcjk
    DLdmFWOQMru55WVY261+Yyarq7PR2mWmmclcmRd+2oUX0kCKo01ZGo5/hm96jq5sHLek5I
    Ct9IlshOpjLWKOTUKvGcpM6tE74EVfAYoSpMg8iFnEGN5pQgAJYkQz1j/gciLn3j8qJSam
    BZ1DcppB02WO7FPibmExFpQhDgSw/efbS+LCVEjRUToersbmwynUUb0HzFkoFNDWTDrqOR
    dITHoY0OGHg0FYrVJb8aIQAdO0JNQCrhztVc48G+OwI28RUjNz8QMQGAxDZg
X-ME-Proxy: <xmx:REBPakb8DAELJJrxoN2tpvM2DgTuk2kwcgPMrrkUWzAIPv-YZLBkqA>
    <xmx:REBPao2D9w6X4FlSoeuGopnFSUThcWnc1he_Umtx1A8NwLrw1n3FlQ>
    <xmx:REBPauj-JZrZKXcYPOKedLLin5QGo1fByJsOSteXkUYrAhPC9Qk0DA>
    <xmx:REBPakYM_XoDh-Wf58Won3LwHhhoQHJ9rkOd4646FeQnJeRVR3KQ4A>
    <xmx:REBPamT6Ru26Ahh1JZDM5LhxJL1Of-08F5JWtbQU41xek9DJ7ulYsPLp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1FAC7182007E; Thu,  9 Jul 2026 02:31:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUvWS1vDS7x-
Date: Thu, 09 Jul 2026 08:29:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linusw@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Message-Id: <2ac8f8b2-996d-42c1-b6fb-d319141325f2@app.fastmail.com>
In-Reply-To: <20260709-ixp4xx-serial-hackfix-v1-1-cd1c29d02183@kernel.org>
References: <20260709-ixp4xx-serial-hackfix-v1-1-cd1c29d02183@kernel.org>
Subject: Re: [PATCH] serial: 8250: handle ixp4xx register endianness correctly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 9, 2026, at 01:05, Linus Walleij wrote:
> @@ -122,6 +122,17 @@ static int of_platform_serial_setup(struct 
> platform_device *ofdev,
>  	if (ret)
>  		goto err_pmruntime;
> 
> +	if (IS_ENABLED(CONFIG_CPU_XSCALE) && type == PORT_XSCALE) {
> +		/*
> +		 * Adjust for BE32 register accesses: drop any hardcoded
> +		 * address for the big endian byte target, add it explicitly
> +		 * if running on BE32.
> +		 */
> +		port->mapbase &= ~3;
> +		if (IS_ENABLED(CONFIG_CPU_ENDIAN_BE32))
> +			port->mapbase += 3;
> +	}

I tried to adjust my original patch the same way yesterday, but
got stuck after I noticed that a similar change is needed
for the earlycon side that runs before of_platform_serial_setup().

I think I've come up with a simple enough fix, essentially putting
the same change in a second location, see below.

The other thing I realized is that I had the incorrect
"port->regshift = 0" in my broken patch at first, which
would mean that UPIO_MEM32 couldn't work either even if
the hardware could do it after all.

     Arnd

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index dc0371857ecb..bfe8232e0ebb 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -177,16 +177,24 @@ OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
 OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
 OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
 
-static int __init early_serial8250_rs2_setup(struct earlycon_device *device,
+static int __init early_serial8250_xscale_setup(struct earlycon_device *device,
 					     const char *options)
 {
+	/*
+	 * Adjust for BE32 register accesses: drop any hardcoded
+	 * address for the big endian byte target, add it explicitly
+	 * if running on BE32.
+	 */
+	port->membase &= ~3;
+	if (IS_ENABLED(CONFIG_CPU_ENDIAN_BE32))
+		port->membase += 3;
 	device->port.regshift = 2;
 
 	return early_serial8250_setup(device, options);
 }
-OF_EARLYCON_DECLARE(uart, "intel,xscale-uart", early_serial8250_rs2_setup);
-OF_EARLYCON_DECLARE(uart, "mrvl,mmp-uart", early_serial8250_rs2_setup);
-OF_EARLYCON_DECLARE(uart, "mrvl,pxa-uart", early_serial8250_rs2_setup);
+OF_EARLYCON_DECLARE(uart, "intel,xscale-uart", early_serial8250_xscale_setup);
+OF_EARLYCON_DECLARE(uart, "mrvl,mmp-uart", early_serial8250_xscale_setup);
+OF_EARLYCON_DECLARE(uart, "mrvl,pxa-uart", early_serial8250_xscale_setup);
 
 #ifdef CONFIG_SERIAL_8250_OMAP
 
