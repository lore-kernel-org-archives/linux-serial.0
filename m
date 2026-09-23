Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C934B1D19;
	Wed, 23 Sep 2026 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165409; cv=none; b=s38qpotFUdoqGqmwM/TBLpr47DRzOI24D++RiwuIXVDehZDZo1keNZDdany1AuSc8MVdlwf3BzYY2ZTSrjuouVgIRv5zXGbmKH/pE79RywC929mLMzisJir5V1JnDAlk4bFjoWj160G4l1uiQFEp2p3KF5W7pW7Z/wgCLzwTT2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165409; c=relaxed/simple;
	bh=1Aldte1teQEHzFbdY3GMHvxmJ+zOpLLSAlJ03X5Piek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owW9QhPtJ/GWXjeW3f+O2tNU9vwybCYA/6y7HYH9UPP3dW5vrEqqJKwod0XGbU1+OmU014ROIIbdHKgq6eKFvPYEToiWPR3Z+DnQ5oL6pN/1c0Anfo8A4FrXUX/+UWqYtkvvjaqswyhhhBj+bVY+Y6ZOVLqSmuPqLaqWONqK+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Y4ivBBr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Y4ivBBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEEC1F000FF;
	Wed, 23 Sep 2026 12:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790165397;
	bh=pJVbAGcOZGnJN4IyBN/g4zJUe5Tk7AARm7pJxURbPCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1Y4ivBBrrw3krdh6UVfrylP95ihx5JRm85j9NFWJnyB/WJuLqOohHAeYszlfV0Z88
	 Kr9mX39KsiBeEDbwUczK9COJBGQioc8ky9C4IKfLfJNm9alENKglyRNZoOVooF9uEk
	 Jiip1l1z/94AU/niv0DTxIQe8NLJLauJwYG3yoeA=
Date: Wed, 23 Sep 2026 14:09:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: jaidevshastri@vt.edu
Cc: Russell King <linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: publish amba_ports[] entries with
 release semantics
Message-ID: <2026092307-congress-glance-4a36@gregkh>
References: <20260921-mb-pl011-v1-1-b378bb057d43@vt.edu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-mb-pl011-v1-1-b378bb057d43@vt.edu>

On Mon, Sep 21, 2026 at 09:20:12PM -0400, Jaidev Shastri via B4 Relay wrote:
> From: Jaidev Shastri <jaidevshastri@vt.edu>
> 
> pl011_setup_port() fills the port structure and then stores its address
> into amba_ports[] with a plain store. The console callbacks read the
> slot through co->index with plain loads.
> 
> Store the slot with smp_store_release() and read it with
> smp_load_acquire().
> 
> Found with MBCheck, a static herd7-based memory consistency checker.
> 
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
> ---
>  drivers/tty/serial/amba-pl011.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index c4824c201..696c12ca9 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2536,7 +2536,8 @@ static int pl011_console_setup(struct console *co, char *options)
>  	 */
>  	if (co->index >= UART_NR)
>  		co->index = 0;
> -	uap = amba_ports[co->index];
> +	/* Pairs with the smp_store_release() in pl011_setup_port(). */
> +	uap = smp_load_acquire(&amba_ports[co->index]);

That is usually wrong and not how to do this :(

Pleaase fix this properly, if it actually is a real issue.

thanks,

greg k-h
