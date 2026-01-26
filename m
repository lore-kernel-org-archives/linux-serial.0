Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1F3019C5;
	Mon, 26 Jan 2026 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419992; cv=none; b=S7dM6M9gND115fDkLKF5hbU82QV+0g3q9yx712x6OVTxhi0413PlLHFVCYQjtZ5Lpknp+MGMLZuSI4DTheGNJjmQ2LxFMcQ7eJJYES+FE9uLeLzKFA0b9almiP0mI++T52YFf9pkcAxkupTFi4Vt/i7gzXAfKUB0fUR4gb9y69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419992; c=relaxed/simple;
	bh=PS5mbIMuADDlufHPrnaGyWbJ4OxAS8gn1/pM0v3KfYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqnBbfLwEWdXhawcvt5j0IcvGRwRU5HtvKcEg26p1QEmKtXm044aRJt5uBIXEnXixx5sMdIgCDZkdRLPAm6QabWQ8917cW855XOoLZrl06xoMYF9f1S19If7T8hmJxMJQ5PerwHpRJLfHaDMDP1EocEQT0MsvinQfCvt3qbqFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6gsH/Af; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6gsH/Af"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3E0C116C6;
	Mon, 26 Jan 2026 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769419991;
	bh=PS5mbIMuADDlufHPrnaGyWbJ4OxAS8gn1/pM0v3KfYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6gsH/Af0jcCLaDhut9lUdds0pzT3XP3M8Fkyufp48cyY4RF85FpzwqFYd2iTlkGL
	 UjeLR0fkQxECuKthOvsMI73e18iB7KobmcZvEjjUh19G1MWsxvA8rGVywTEMQhcLDD
	 hRwoFOn0sCQ34ApcLEgFj4j7QI7fnvKIgc2J94mg=
Date: Mon, 26 Jan 2026 10:33:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Add enable module parameter
Message-ID: <2026012613-cotton-jellied-b67a@gregkh>
References: <20260126092234.713465-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126092234.713465-1-jfalempe@redhat.com>

On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
> This allows to build the kernel with CONFIG_VT enabled, and choose
> on the kernel command line to enable it or not.

This says what is happening, but not why?

> Add vt.enable=1 to force enable, or vt.enable=0 to force disable.

Why are we using a 1990's technology for a new feature?  What is this
going to allow to have happen?  Who needs/wants this?  Who will use it?
For what?

> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/tty/Kconfig | 13 +++++++++++++
>  drivers/tty/vt/vt.c |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 149f3d53b7608..2b94c2710687a 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -41,6 +41,19 @@ config VT
>  	  If unsure, say Y, or else you won't be able to do much with your new
>  	  shiny Linux system :-)
>  
> +config VT_ENABLE
> +	depends on VT
> +	default y
> +	bool "enable VT terminal" if EXPERT

So no one will ever really use this config option?

And you are doing 2 things in this patch, not just one, unlike what the
changelog said :(

thanks,

greg k-h
