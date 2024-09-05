Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028219DF4D;
	Thu,  5 Sep 2024 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545355; cv=none; b=glIc81rB/wgEcw1tNMc1DK1qw2JQmEqWX83veWvjHsYPhz1jwQnTVMpKD0kf0V3svSleBmfslGX0JfyYIOtidhn5R9P8sRFUZEc39R6AC/vDYqEGdE89M6Q8OaTo5kI6EtFApPLQjFYu8XooUHE9durU6Gfbxpyw6oFn3Tlh3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545355; c=relaxed/simple;
	bh=fLfEK5nmEj951+8kWCi5bB5LhgjnTjib2vsqlmyHJWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH/akKzLdmMALihKC5yoO2IGIWR4YpZbin654+ImLTAM4vdEZknw16Qq1L5A3sGFdmyJjmo/BAHlnWBSIDh5xosGKn+caTXRNEuKypV7oiODsjaZ7JCZaHhjM4RXEtaPlT9wSES/3lc9e0WYnsFQbrB94KreQMLpmfgZi2iGMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XMQtd0mZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XMQtd0mZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11A9C4CEC3;
	Thu,  5 Sep 2024 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725545355;
	bh=fLfEK5nmEj951+8kWCi5bB5LhgjnTjib2vsqlmyHJWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMQtd0mZyeO/vIHaf0ZTy/bsrsMSyqImF/BH7UuQOs+pXRtta5kCVv54BnDfJTPNM
	 iGipASz2XfNLuh1okn8YmHrr36AT5n5afGdO+vWn4hBaP6Byox8KzK9WY9CNu2Qxv9
	 Z2yRfRnn9jn3lf3TWGbKSldop+pFRqvquw8jF/II=
Date: Thu, 5 Sep 2024 16:09:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Derek Barbosa <debarbos@redhat.com>
Subject: Re: [PATCH tty-next v1 0/2] convert 8250 to nbcon
Message-ID: <2024090554-mating-humiliate-292b@gregkh>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905134719.142554-1-john.ogness@linutronix.de>

On Thu, Sep 05, 2024 at 03:53:17PM +0206, John Ogness wrote:
> The recent printk rework introduced a new type of console NBCON
> that will perform printing via a dedicated kthread during
> normal operation. For times when the kthread is not available
> (early boot, panic, reboot/shutdown) the NBCON console will
> print directly from the printk() calling context (even if from
> NMI).
> 
> Futher details about NBCON consoles are available here [0].

Really?  That link calls them "NOBKL", is that the same thing?

confused,

greg k-h
