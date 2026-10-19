Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31AC488D95;
	Mon, 19 Oct 2026 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402764; cv=none; b=nCBcjUSXcKZlGN7nDTa4HfrsnKlyLGzvLkscXCEiGxaqP7/K41doPTaXmrmwjFJpzgXiDCYr4ZHFnpidKxcPiv2oYxabe3ppsonCxSUHHruhy0h7nX37lctEdkXTxpcDbECBplZ++M+2YldzPVv6g8IAgtht3SIJkDIe2S9afZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402764; c=relaxed/simple;
	bh=mQCkmSSJkUL3FJbfj3RjGn270uscEvDqWebTGDYSHrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPHJhnC/KrLPVxihC7L2voAoytCL0oShqyhmE3xCo91llTGB8unQcb3RA2GgvUuvTUh22yg7bxRHZNQ44vgrLViBiZgPXEnte/Lqz9WavOcKnbMjnxFyL7crQjRC6tZqL1KJlh5USo/LrR1xoq1iePCf+9UOs/ztv/tcQb3DWNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IsFtIxyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IsFtIxyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03211F000C4;
	Mon, 19 Oct 2026 09:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792402763;
	bh=+G081mjw92pLC8lCLOXqTG061tR6XF7QBjZhnsnh4xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IsFtIxyMSQudGwESLIIjlsHuUuC53CKLBetywjuV6FrTHxUCUO4ma8QLIXTQCXL5E
	 7t/64zuETUqvP2AxqtdgCWK4Xpe8fx0cjbJEkE0PGeHmy2i+Hq7fsNykl0f5/s96DF
	 mFS86gdTb+td2vRa25M6zZN+vBWoXGekry+unIIw=
Date: Mon, 19 Oct 2026 11:39:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] [v3] serial: 8250: remove obsolete and broken PORT_RSA
 support
Message-ID: <2026101952-wham-earthly-c149@gregkh>
References: <20261019090017.430425-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019090017.430425-1-arnd@kernel.org>

On Mon, Oct 19, 2026 at 10:56:55AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> For all I can tell, the RSA support in the 8250 driver is not functional
> and has not been for a long time.
> 
> The RSA-DV II/S ISA card[1] was sold by IODATA in the 1990s as a faster
> alternative to regular ISA serial ports, and it was discontinued in
> 2002. Linux support was added by Kiyokazu SUTO in 2000.
> 
> The driver defines an I/O port base address of -8 (negative eight),
> which should always get refused by request_region on all architectures
> for being outside of the valid resource range.
> 
> Further, it seems that a patch to setserial would be required in order
> to set PORT_RSA when not using autoconfiguration.
> 
> This patch removes all code related to the RSA support, with the exception
> of the user-visible PORT_RSA definition.
> 
> Link: http://translate.google.com/translate?hl=en&sl=ja&u=http://www.iodata.jp/products/network/rsadv2s.htm
> Link: https://lore.kernel.org/all/1309211120-2803-6-git-send-email-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rebased my own patch after 15 years
> v3: fix up Makefile and sunsu.c file
> ---
>  drivers/tty/serial/8250/8250.h          |  17 --
>  drivers/tty/serial/8250/8250_core.c     |   6 -
>  drivers/tty/serial/8250/8250_platform.c |   4 -
>  drivers/tty/serial/8250/8250_port.c     |   8 -
>  drivers/tty/serial/8250/8250_rsa.c      | 209 ------------------------
>  drivers/tty/serial/8250/Kconfig         |  11 --
>  drivers/tty/serial/8250/Makefile        |   1 -
>  drivers/tty/serial/sunsu.c              |  92 -----------
>  include/uapi/linux/serial_reg.h         |  51 ------
>  9 files changed, 399 deletions(-)
>  delete mode 100644 drivers/tty/serial/8250/8250_rsa.c

Any objection for me to sneak this into 7.4-rc1?

thanks,

greg k-h
