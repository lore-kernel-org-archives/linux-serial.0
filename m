Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721618A6AD;
	Tue, 26 Aug 2025 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192104; cv=none; b=JMVzJFtIXg11AOmpgl8+tvBZ1Bra5KoeNmtH9KNYeFGKbEKoQRb5HOlyFiKrzRrwgZISwpIz8Nf5sj5edmh5ADYBxfSBF5//JLgNtdIJ2mDWL9xQjalivm5JG1tIuDg0+aVW9czRnYfCmRGMwuU4AEU0kGUuxeptDYHg2l7kYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192104; c=relaxed/simple;
	bh=bz60ZHQMGoOcKZCj6uQPRAQshhck8rgKEursI1Ot91k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chF+K5rkUczoPasOfTsfFcW7KpkI1GXzJjl2bo+y7Yphj2YEzqc5Uc6SaQHKvLUcO+zzK6wdjwua16MenssE0S44qKGxWzZb+c9iJcenUiSKUG2NfBptuDcyxy8ZPYaznvYgeTzuhhg++qSmMstuJE1w13ZjCKrNBLui262x0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=07c9xgeE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="07c9xgeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AEBC4CEF1;
	Tue, 26 Aug 2025 07:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756192103;
	bh=bz60ZHQMGoOcKZCj6uQPRAQshhck8rgKEursI1Ot91k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=07c9xgeE5nPjIroTAzXxAJMcgX5FoCZTcNMy8B9YSIVtjHJFWj2sO7e2XNE+/hAmG
	 eynQ8+9nhqiX19/30tNVwsGwt4nI1Fb8a71Fv+mJgitxbSOgffIFskdelczuspg4me
	 V5Y5hpT9Gu04lV9vmPZM+ubZATAy7S4h7a474ixw=
Date: Tue, 26 Aug 2025 09:08:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Seppo Takalo <seppo.takalo@nordicsemi.no>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: Don't block input queue by waiting MSC
Message-ID: <2025082617-unjustly-dust-4976@gregkh>
References: <20250825135500.881285-1-seppo.takalo@nordicsemi.no>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825135500.881285-1-seppo.takalo@nordicsemi.no>

On Mon, Aug 25, 2025 at 04:55:00PM +0300, Seppo Takalo wrote:
> Add parameter "wait" for gsm_modem_update() to indicate if we
> should wait for the response.
> 
> Currently gsm_queue() processes incoming frames and when opening
> a DLC channel it calls gsm_dlci_open() which calls gsm_modem_update().
> If basic mode is used it calls gsm_modem_upd_via_msc() and it
> cannot block the input queue by waiting the response to come
> into the same input queue.
> 
> Instead allow sending Modem Status Command without waiting for remote
> end to respond.
> 
> Signed-off-by: Seppo Takalo <seppo.takalo@nordicsemi.no>

What commit id does this fix?

> ---
>  drivers/tty/n_gsm.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 8dd3f23af3d2..8e8475d9fbeb 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -454,7 +454,7 @@ static const u8 gsm_fcs8[256] = {
>  
>  static void gsm_dlci_close(struct gsm_dlci *dlci);
>  static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
> -static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk);
> +static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk, bool wait);

Adding a random boolean to a function is almost never a good idea.  Now
every time you call this function, you have to go and look up what that
boolean means.

Please never do that, instead make a "wrapper" function that will then
call this "core" function with the boolean set properly.  That way you
can name the wrapper functions in a way that describes what it does.

>  static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
>  								u8 ctrl);
>  static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg);
> @@ -2174,7 +2174,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
>  		pr_debug("DLCI %d goes open.\n", dlci->addr);
>  	/* Send current modem state */
>  	if (dlci->addr) {
> -		gsm_modem_update(dlci, 0);
> +		gsm_modem_update(dlci, 0, false);

See, what does false mean?  No clue :(

Why not call gsm_modem_update_and_wait() instead?

thanks,

greg k-h
