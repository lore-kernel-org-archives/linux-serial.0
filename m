Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106608;
	b=kXizq8273zgxgeJvPyxV0SwIX5zmVd7AzjdF9IsyZIqqFUabYQxOhvzvfg64/13MVDYm
	 soG9q8BJmguJCP+ypMhP2/qLJ5bqoc0UOdQUr5+irveoGK8tTzPEBeVfuN4YWzcwNI7s5
	 XMSavauw7nsBx2PJo5XuGjWlu721Huae5htYpWqUGOfGA1xSTPVKZEQpsrl0UbmTbWvHr
	 0cnvGdEkxvBvuqjJSaMuNY/UUe8m71jwKpOSCqEpDEIgHdgQs5dyVpI0qErJ/C5cx8ifi
	 krlI+fbE6tkL/WuIahGDJmvnHFLdxfInz2Vgzy7DyBffDLM68NwroiRpS55JNZY/uEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106608;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=855Irl/YTZlHxHj+4WNDjo6xdB3B4og4aS6vB5/n1Uw=;
	b=kuAqTYEgcfLUS/GD1DMg5YrOYZ6XwKLpkQ28NcYRPsyHg3JV7iBwwVXdX/djogLyc8VF
	 ETsiy1cvUvKkW90F1FCkmypoSZfbk53EwpHf5uFZm6m87Cegnu84ZWmrOFNHNOFx3/vxs
	 bLArmFlEzc7HgiOumB97VET/wFIgN/nNAYdAz+mU/FDhcffOl86g5dUzMohtHeQt5K/ui
	 lS8NNFkpSN2y38lFWgjbpXvyWLNZZOT0dJTp84kaL5KfV+L/T5Qq74qox6PJ/zx5LtreA
	 jCyQzvKhc3pvyvpygB9mBK63ci2SvvE4s1u23oLhj9WdTeCL9StUJlNLy9MuIOWdaJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sk4AlKbg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473E1606A31B;
	Tue, 27 Oct 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sk4AlKbg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D571F031E3;
	Tue, 27 Oct 2026 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793106608;
	bh=855Irl/YTZlHxHj+4WNDjo6xdB3B4og4aS6vB5/n1Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sk4AlKbgewgz9lqTJdn+ZG0/iw5HeGyjasOhjegB/BTKi3PEV9pjoEnQG6r/RVk7J
	 Zkp2Um+TQ7FIwN1vsNZMOrPhy7COiysJ8Af1RKor0xf4FgMLO8eKAXZN6XWZ9MHI+F
	 zuxS52J9XfD3HJkdTOWB8HTpFdN3s7J3yTUWVLmU=
Date: Tue, 27 Oct 2026 14:10:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Frank Li <Frank.Li@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Robert Baldyga <r.baldyga@samsung.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Al Cooper <alcooperx@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	stable <stable@kernel.org>
Subject: Re: [PATCH 14/24] serial: 8250: ioc3: store registered line number
 in driver data
Message-ID: <2026102727-challenge-unrest-8c83@gregkh>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-14-99b0202ae546@linuxfoundation.org>
 <37ad6cbd-3a66-17d7-4221-3814a9ae7b90@linux.intel.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37ad6cbd-3a66-17d7-4221-3814a9ae7b90@linux.intel.com>

On Tue, Oct 27, 2026 at 02:38:49PM +0200, Ilpo Järvinen wrote:
> On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:
> 
> > From: Joshua Rogers <linux@joshua.hu>
> > 
> > The registered line number returned by serial8250_register_8250_port()
> > was stored only in the local variable 'line' and never saved into
> > data->line, causing the remove path to always unregister line 0
> > instead of the correct port.
> > 
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Joshua Rogers <linux@joshua.hu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/serial/8250/8250_ioc3.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
> > index 088242de2eff..3ab50e04be45 100644
> > --- a/drivers/tty/serial/8250/8250_ioc3.c
> > +++ b/drivers/tty/serial/8250/8250_ioc3.c
> > @@ -63,6 +63,7 @@ static int serial8250_ioc3_probe(struct platform_device *pdev)
> >  	if (IS_ERR(uport))
> >  		return PTR_ERR(uport);
> >  
> > +	data->line = line;
> >  	platform_set_drvdata(pdev, uport);
> >  	return 0;
> >  }
> 
> Eh? Didn't Jiri just kill the entire line madness? In d6a0791098be 
> ("serial: 8250: make port operations work on struct uart_8250_port"):
> 
> -struct ioc3_8250_data {
> -       int line;
> -};
> 
> There's no "line" in the entire file anymore?!
> 
> On which commit you're basing these on? How was this tested??? ;-) ...I 
> hope you're not just wasting our time by sending unfiltered LLM output to 
> us.

I built this on top of Linus's latest tree, odds are I don't have a
.config option set somewhere, sorry abou tthat.

greg k-h
