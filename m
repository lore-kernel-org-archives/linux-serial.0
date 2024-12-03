Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA2224F0
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230988; cv=none; b=uE3xvxWayIbbnwzh8cUxcI57UqYziEsi8ppqSYShO9mDDgIJJEG9WGHvQD9B5cMtnLIqnj44byu1lh414GJ0VTjDnOWntwSFNXrwps9jr0CMpZT9/7yNwJwYoZFBBz12jX+JdImr5CrH2QPKy4Uh/XXyFHBF83p0ljQWmfHl5YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230988; c=relaxed/simple;
	bh=vV/BXZF8od6m6YxSrDLIzwly//rmJJzdfl3MjHKCwvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbgf/IICG9fl00ZtHQ8WBrQW0yXlYYAGVqWR4X34lmrBT5p6xtd+4f1AkkrOuY8SKbs+5vPaWkEajcwvSwnfvlFVCPUg0pIXGfpkL1VvcerZcgB1EwgHOZ7+DREU9Gg+QeRJDjVS6sBNouipfmZzbwM3yq4QPEhZLtuRoY1zyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k3vXsxq1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k3vXsxq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA32C4CECF;
	Tue,  3 Dec 2024 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733230986;
	bh=vV/BXZF8od6m6YxSrDLIzwly//rmJJzdfl3MjHKCwvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k3vXsxq18xmf8w4/xW72mXczsWusctzg8dbz3MO1SAKUaz2xfULsRwyasr/YTqRTL
	 hBKmKJWFIHudtv4HUmSYE7+3oy7pgFyf5LS+t7UUS17y/dUi2wRzWestfbTePJoqtD
	 jwpdYicmD5AmU0Zfqb2lsBhlim/mUQwngUAQzAFM=
Date: Tue, 3 Dec 2024 14:03:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: altera_jtaguart: Use DRV_NAME to initialize
 uart_driver.driver_name
Message-ID: <2024120337-unending-renewed-8e7e@gregkh>
References: <20241203125654.29657-1-tklauser@distanz.ch>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203125654.29657-1-tklauser@distanz.ch>

On Tue, Dec 03, 2024 at 01:56:54PM +0100, Tobias Klauser wrote:
> Use the DRV_NAME constant instead of the verbatim string.

Why?

> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/tty/serial/altera_jtaguart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
> index b9c3c3bed0c1..9657c3bb8e66 100644
> --- a/drivers/tty/serial/altera_jtaguart.c
> +++ b/drivers/tty/serial/altera_jtaguart.c
> @@ -365,7 +365,7 @@ OF_EARLYCON_DECLARE(juart, "altr,juart-1.0", altera_jtaguart_earlycon_setup);
>  
>  static struct uart_driver altera_jtaguart_driver = {
>  	.owner		= THIS_MODULE,
> -	.driver_name	= "altera_jtaguart",
> +	.driver_name	= DRV_NAME,

Why don't we just use KBUILD_MODNAME here and get rid of DRV_NAME
entirely?

thanks,

greg k-h
