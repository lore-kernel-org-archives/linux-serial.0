Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B85A0FD;
	Sat,  4 May 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714838923; cv=none; b=XMnr61MSks1ZS1H57fA0nb7gnLBuDJj+FISRJYfde4BFCzYqdG7lupAwcq8uf+gaDhLuFv8wOgmkR0DPCGHju/SjwvDVG7uDKK+xaeVRpI3d6HFpQaj8T6StW9YpOOw/rAwJ98A2PVVk8IY3jsM5k7yHP6sWvhTXTrSrv0rfSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714838923; c=relaxed/simple;
	bh=UfoLjGrBm2lN/mmh5+2DWvcNqyPXEVFl9WPA1Hf3pu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdvEO4PE7u5Qeqq8lJZqOLwRxHxmzQbwgxnVe/XOKwFzFgF0+gdfrExQtpdaDj6+FU/yNoDats2r0eb8TTypgdP1mGSlxAHiHnnIFwpAQKmnIvNwRBiScGiv2AK0BAqQ/2dh6pgHta3A9rsNpvRTILbnpdN2Es93gGVjsuHV7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jO5p2qxh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jO5p2qxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755A1C072AA;
	Sat,  4 May 2024 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714838923;
	bh=UfoLjGrBm2lN/mmh5+2DWvcNqyPXEVFl9WPA1Hf3pu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jO5p2qxhVldXa/ws23/u63WO46a3i1yMzjwt5V/o0PiO6mMry1wn0WML252v/osDX
	 dMr2uQc0/1pHS4VqdKdssI4hnoHC5lRWCCRYZ2ltpWdPpmzI8+PXcdZR8hMbm5iJ9f
	 287E1fQUqDrm92SvAtKjf4rnmDw1dGFE4RNBvEWs=
Date: Sat, 4 May 2024 18:08:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v5 09/30] serial: core: Introduce wrapper to set
 @uart_port->cons
Message-ID: <2024050433-power-dictation-acce@gregkh>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-10-john.ogness@linutronix.de>

On Thu, May 02, 2024 at 11:44:18PM +0206, John Ogness wrote:
> Introduce uart_port_set_cons() as a wrapper to set @cons of a
> uart_port. The wrapper sets @cons under the port lock in order
> to prevent @cons from disappearing while another context is
> holding the port lock. This is necessary for a follow-up
> commit relating to the port lock wrappers, which rely on @cons
> not changing between lock and unlock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
