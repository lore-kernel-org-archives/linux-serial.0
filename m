Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E642E0914;
	Wed, 23 Sep 2026 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167885; cv=none; b=btdGPQGNqSKidmNE06u3C6FIqEVSeMm7m5jqyMa1zKLavyjBRJAMaRm8s9IKoK3T8DOVqn2cYAOWnywrDkxIU9QWIKThYXaKGFesrz0i8tcv6PLkhGIVYw8Sv7/bDJdlDkVtPMQaG6AWdRlf+XiIcDnclW8QBcSrkHqBLVurQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167885; c=relaxed/simple;
	bh=6UYwEuvMzHEdqLCKYGKK3XmOzKJZkrbeDCHq/9bqJ0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/mqtYP8sRh7Ylxu1y1WwU7dMO8YqWBqBg5Gf/Timqc9eCdiFPZwLn+uEJIilrLk1V5ri2403CyUYXJrHOPnwAXvneFSJsm1Rv71qXtqvv4YfejyhcWoZUir1amyT+aut5L4zvsZ+q5k4vyzQvd9V1zHi8OI+NB3jgZ/BL01rjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UaoGOdlh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UaoGOdlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352961F000FF;
	Wed, 23 Sep 2026 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790167877;
	bh=f6fn+hhr1NkZCBOEKLV6pQJkP78WskLC3N5n+G4dnrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UaoGOdlhcZhTYkZF2jKUMy0bPUAjTxn5NpeWcYDQhtR6VQF/oH46D7wMrkrhHMHQS
	 XyQe7sB2EFDUwf7iuw3NF9p0zahevXkVWS0fSmwXLcS1QlnbafUbuAPRZj0v3ccMwc
	 3OaFTRSIaNy1dSt/t6FiWsqspbeCJq04zDmAAtMo=
Date: Wed, 23 Sep 2026 14:51:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: jaidevshastri@vt.edu
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/6] vt: keyboard: publish shift_state with release
 semantics
Message-ID: <2026092305-carless-stammer-cb15@gregkh>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
 <20260921-mb-keyboard-v1-1-d170228b80c0@vt.edu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-mb-keyboard-v1-1-d170228b80c0@vt.edu>

On Mon, Sep 21, 2026 at 09:28:14PM -0400, Jaidev Shastri via B4 Relay wrote:
> From: Jaidev Shastri <jaidevshastri@vt.edu>
> 
> k_shift() updates shift_down[] and then shift_state under
> kbd_event_lock. vt_get_shift_state() reads shift_state without the lock
> for TIOCL_GETSHIFTSTATE, so the plain accesses leave the relation
> between the counters and the summary word unspecified.
> 
> Store shift_state with smp_store_release() and read it with
> smp_load_acquire().
> 
> Found with MBCheck, a static herd7-based memory consistency checker.
> 
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
> ---
>  drivers/tty/vt/keyboard.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c41d850b2..089f3b048 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -865,6 +865,7 @@ static void k_pad(struct vc_data *vc, unsigned char value, char up_flag)
>  static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
>  {
>  	int old_state = shift_state;
> +	int state;
>  
>  	if (rep)
>  		return;
> @@ -889,9 +890,11 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
>  		shift_down[value]++;
>  
>  	if (shift_down[value])
> -		shift_state |= BIT(value);
> +		state = shift_state | BIT(value);
>  	else
> -		shift_state &= ~BIT(value);
> +		state = shift_state & ~BIT(value);
> +	/* Pairs with the smp_load_acquire() in vt_get_shift_state(). */
> +	smp_store_release(&shift_state, state);

Again, no.
