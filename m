Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C54C9D;
	Thu, 16 Oct 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628086; cv=none; b=MjOronKNqYcDOZqphmjKh4GV0wwFr3lSoofX0+KSTOXEGLpCTD2mSU2NfuQsN5XprbrDx8QFOFyMlKPYXYlHDTB3hnaqWAyYJlRCMvUP9Wjbkx6xRcFQ4kQvdYiHZJfSZ1vJ0CITq3LTh26GnBmqKoPqCLtIy7lgm0Hm0y3UoV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628086; c=relaxed/simple;
	bh=z8MA8LUyae+lGsjF1gwHLGWRBNQCFSy54sXprN2LxaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LySeApiiYDWI2kJxPCQWX3W3gE/HhmuhsVZbYwkJEaYkqq/a5SYN4xatd2hQJL0k/b5GBVPK1rnF7t71EeE47SNDoJZv4lF600eQKXBlfPRJvymujJRKPFTCES9ejG+DLJvqSs/R+SdKQM2GnStVgvSs+S5q8Km44DQ5wQVsOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vx1Go4EP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vx1Go4EP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zufCpAXCVEwDc/8p4UXog53BnP9tM+43qUpcW1f09iM=; b=Vx1Go4EP3OHyeVIlzAQWHe7TrA
	q4PyEtofbcg/a89657ONYBOhGme8m01o1I4N46htjcrOUWTIS1p0SAFYDwisxemju5McrvW2L416n
	5n8LYFZkwTfi0eFEWEZmAbMvNlJkCT5NnT6FaFRcVUEWGRRdUh/GjTkOramECPR1pCz3g5C8Qswte
	OwJX/mInR0Yhwg3khITa/XhHcy3PEKxW8KogItiPrJSjyOJahDKru1jM/BG+BJ/PHMtqfkxvxt5ax
	SThwSwUPE4eUEBMVn+vMFMohFFliLU5O44lKMpVZRChieBgc4IlYMUQLXtotPU2knjiWFkcQKd2v+
	2OCeEeng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56116)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v9Pn3-000000006dM-2UPG;
	Thu, 16 Oct 2025 16:21:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v9Pn1-000000003NP-2Vov;
	Thu, 16 Oct 2025 16:21:15 +0100
Date: Thu, 16 Oct 2025 16:21:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH] serial: imx: allow CRTSCTS with RTS/CTS GPIOs
Message-ID: <aPENa90OS4ZZA5Rc@shell.armlinux.org.uk>
References: <20251016113730.245341-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016113730.245341-1-matthias.schiffer@ew.tq-group.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 16, 2025 at 01:37:30PM +0200, Matthias Schiffer wrote:
> -	if (!sport->have_rtscts)
> +	if (!sport->have_rtscts && !sport->have_rtsgpio)

This is fine...

> -	} else if (termios->c_cflag & CRTSCTS) {
> +	} else if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts) {

This adds extra parens that do nothing to aid readability. Too many
parens actually hurt readability.

> -	if (termios->c_cflag & CRTSCTS)
> +	if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts)

Same here.

Maybe change these to:

	if (sport->have_rtscts && termios->c_cflag & CRTSCTS)

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
