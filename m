Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A881E1F4282;
	Wed, 19 Feb 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973791; cv=none; b=JlxXI0dlJR0KXOaOcdODGwKWSH8NC59nqjv6VN02mHx8KnKPBpsQIR5Lmes0k5LWmQKv46EspIGPlrHzMG0R0pxEAd9nvdNx7T+6hK/KQ7teX3q8WkZy6KlOEEdyjHOamtaBoTw8slMEhMa65676CjpVPpbZ1i4jDg4bKf14oLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973791; c=relaxed/simple;
	bh=SfAIfh9gg1gimR0KP+9aUQefudfdjJawcYirIdCagfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep5eTPn5S26qdLrBviWXtOaeGLN1vaFosNgQYk3btPoEv7AaNT5ITdw7fxkJYunzPEKLh50u9M6TD4ubGD1QpxyutfsTuAj6TM2SbfgsDUFTQcrd+wmH5r/a8se765HhgOS8hllgVJVQgN8NWBwv80VKtWU5yf7AxRh0GK8VrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZuXacvM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZuXacvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4546C4CEFE;
	Wed, 19 Feb 2025 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739973791;
	bh=SfAIfh9gg1gimR0KP+9aUQefudfdjJawcYirIdCagfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZuXacvMi2IS2MDJ0/dZ1oJtrC9Bmnneh1sd54LILUI5ZVUJas+KmW31MQQsveqZj
	 IA7aa/UKS2di8up/HoK43468WEtHW3ybVIryeD2tTP00DdWbS/zMhRg2DsUHPk1rAh
	 tyGaFlVGRytiW4Wk50LkVVjIL4HQL8YmUs3TzQVQ=
Date: Wed, 19 Feb 2025 15:03:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 2/2] tty: Change order of ttynull to be loaded sooner.
Message-ID: <2025021957-babble-delivery-3035@gregkh>
References: <20250217040748.2017975-1-adamsimonelli@gmail.com>
 <20250217040748.2017975-3-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217040748.2017975-3-adamsimonelli@gmail.com>

On Sun, Feb 16, 2025 at 11:07:48PM -0500, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> If CONFIG_NULL_TTY_CONSOLE is enabled, and CONFIG_VT is disabled, ttynull
> will become the default primary console device, based on the load order.

You mean "link order" right?

> Users and distributions that are migrating away from CONFIG_VT will
> benefit from this as /dev/console would not suddenly become /dev/ttyS0
> which could otherwise cause some user space behavior changes, namely the
> TCGETS ioctl failing, which causes libc's isatty() to incorrectly return
> false when /dev/ttyS0 is disabled, and will prevent a device that is
> connected to a user's /dev/ttyS0 to suddenly start getting kernel log
> messages.

I'm sorry, but I can not parse that very long sentance.  If CONFIG_VT is
not enabled, this isn't going to change anything with ttynull, it will
just happen to have this console loaded before all others, right?

Which implies that this might break existing systems when this loads
before the expected platform-specific drivers.  Was this tested on those
systems?

> 
> Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> ---
>  drivers/tty/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> index 07aca5184a55..03bb47e11e1c 100644
> --- a/drivers/tty/Makefile
> +++ b/drivers/tty/Makefile
> @@ -11,6 +11,8 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
>  obj-$(CONFIG_N_GSM)		+= n_gsm.o
>  
>  obj-y				+= vt/
> +obj-$(CONFIG_NULL_TTY)		+= ttynull.o

If you are going to rely on link order here, and HAVE to have this above
all other consoles, please document it as such so that people have a
hint as to why you are doing this in the file so it dosn't change again.

thanks,

greg k-h
