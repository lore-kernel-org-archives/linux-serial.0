Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D7270042;
	Thu, 27 Feb 2025 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617454; cv=none; b=SzHgXAx/1VyqffoWOupHQ8Pyru9E7Rdl/su6gH5v3WzkYqncG31aOx9FFJCJENCgLY3Nl+3x/MLa5iQ43VBIQ41W2sb35hHegxZVJ8zMRSmF+IU7nF58ltdLTlimZmg3RNFw58dy9irovsieRWd/+BDkExxCxcyXnMxAwdS7aiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617454; c=relaxed/simple;
	bh=wvfRR8PjV+qegkfR0ZtNP9Xy3R7GdHmzfT0wtK2n0LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8GtaAn2ueZfC+3DaSamoXSPGSR76ev+QbvLwlccpcvEGSZLf33I7sl4WQox49XwdIkBj9lrgl7P4NVimSQJfS1oTOblO0RWFRuD5DXsN5P6gLebn6nzm0f5iptZ5HCh/ohxABPC51+u1qoPpOhP/Or4cPNvRUCnp8qhZvt6JKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BxQfiApQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BxQfiApQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C43C4CED6;
	Thu, 27 Feb 2025 00:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740617454;
	bh=wvfRR8PjV+qegkfR0ZtNP9Xy3R7GdHmzfT0wtK2n0LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxQfiApQecs90DsGHqplK4jUHSWc+4vW32Z8Sujco8sC4U4f5f/Kd9/Y4+LYkLSUh
	 V6Z17lHiyYRGfZymymSBR4WwqFiidBrTMsrrygFrgPAokH0H1RiZpzdFqXfVM4mW28
	 dYgwix0iMiriTxLYtu8JhG1miClt0dS7DlUgVJLk=
Date: Wed, 26 Feb 2025 16:49:45 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: pty: remove redundant local variable
Message-ID: <2025022632-syrup-regretful-79df@gregkh>
References: <20250226204707.1941274-1-vvidic@valentin-vidic.from.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226204707.1941274-1-vvidic@valentin-vidic.from.hr>

On Wed, Feb 26, 2025 at 09:47:07PM +0100, Valentin Vidic wrote:
> The value of to is only used once, so no need to store it in a
> variable.
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  drivers/tty/pty.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index df08f13052ff..c6eb711500b6 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -110,12 +110,10 @@ static void pty_unthrottle(struct tty_struct *tty)
>  
>  static ssize_t pty_write(struct tty_struct *tty, const u8 *buf, size_t c)
>  {
> -	struct tty_struct *to = tty->link;
> -
>  	if (tty->flow.stopped || !c)
>  		return 0;
>  
> -	return tty_insert_flip_string_and_push_buffer(to->port, buf, c);
> +	return tty_insert_flip_string_and_push_buffer(tty->link->port, buf, c);

does this actually change the resulting code any?

"to" actually means something here, the tty is the "from" and the link
is the "to" where the data is going, so having it be "to" makes the code
easier to understand by humans, which is the first goal of code.
Maintaining it for long periods of time is key.

Otherwise your change "tty->link->port" doesn't make it all that obvious
that the this is being written not to the tty device itself, but to
somewhere else, right?

thanks,

greg k-h
