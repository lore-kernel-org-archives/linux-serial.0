Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872511CAE
	for <linux-serial@vger.kernel.org>; Fri, 15 Dec 2023 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T3RF40kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BE6C433C8;
	Fri, 15 Dec 2023 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702629845;
	bh=Zz8x/KehBvqbLFt42xqXDxlCDNTajxU4Q7eSn03r2JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3RF40kjZ7CaFhr95/ceMBh738VqNThe5cNTwulkSKFip2U28W1sS+aEjh5HyV1vb
	 zL6ic6YkeSeiP1fTzv6HFIqC72SI8+pQ6ohz5nWky42h1I3A2dsi9uAEptp62OIseM
	 s/qZv8gWzHUrFf3f9Rxxh6iG9F+NkhFF6MGu36cc=
Date: Fri, 15 Dec 2023 09:43:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1] tty: Fix a security issue related to tty-ldisc module
 loading
Message-ID: <2023121530-crept-unisexual-de76@gregkh>
References: <1702628933-6070-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702628933-6070-1-git-send-email-quic_zijuhu@quicinc.com>

On Fri, Dec 15, 2023 at 04:28:53PM +0800, Zijun Hu wrote:
> Function tty_ldisc_get() has a simple logical error and may cause tty-ldisc
> module to be loaded by a user without CAP_SYS_MODULE, this security issue
> is fixed by correcting the logical error.

What specific security issue are you referring to here?

> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/tty/tty_ldisc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index 3f68e213df1f..b490c0adf00f 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -150,7 +150,7 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
>  	 */
>  	ldops = get_ldops(disc);
>  	if (IS_ERR(ldops)) {
> -		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
> +		if (!capable(CAP_SYS_MODULE) || !tty_ldisc_autoload)

I'm missing something, why change this?

Remember if tty_ldisc_autoload is enabled, then any user can auto-load a
tty ldisc, permissions are not needed.

as it's confusing to read, let me break this down to see if the original
code is correct or not:
	If you do NOT have CAP_SYS_MODULE AND you do NOT have
	tty_ldisc_autoload enabled, then the kernel will NOT call
	request_module

	If you do have CAP_SYS_MODULE enabled then the kernel will call
	request_module()

	If you do have tty_ldisc_autoload enabled, then you can autoload
	a module.

Is this not the correct functionality?

You are changing this to:
	If you do NOT have CAP_SYS_MODULE enabled, then no matter what,
	do NOT call request_module()

	If you do NOT have tty_ldisc_autoload enabled, then no matter
	what, do NOT call request_module()

Are you sure that's what you want to change this to?

What am I missing here?

confused,

greg "boolean logic is hard" k-h
