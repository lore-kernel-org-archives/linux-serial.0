Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160813F7A98;
	Tue,  7 Jul 2026 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427760; cv=none; b=SWdf4OCLZIBTO7cDiH2y5poM9vJBXDEWliVYjMJXsVBXddDHLDjyILvjpx8+uwXTBm+c4B8o8ggZ6Wc1aCesf7UelHn/n6kmJp9dGxcxYnnaGVUT9f4XQtGWYGsaM7n8KJSyeduTPyik+XnUhceadGTz9EC187FdOetKmwZ1XkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427760; c=relaxed/simple;
	bh=ZFNf8PU32+xfGIA7noyz0R5DS3DVyyVutnoc7xo7BX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhgOK07Q2w1U4nfq9NvW9T0Tjhs43C6yzsKkap8D0nRGFv+nab0+ZM+gKKu/dopd0KhdxM5ZNd8yVl0sBe3JJGdmfW9lWmJqIMxClec0GPWHYndovMw2Y67nyxmbe640nOGJ0PQePZuN2XcjRBZNSDhH/KCcEsEtAmA+3z63P2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ooZyM4Mh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ooZyM4Mh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275231F00A3A;
	Tue,  7 Jul 2026 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783427758;
	bh=oY+rl16umWD6hYjzLtEH/FQpth1bEVCHent+KzC8B3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ooZyM4Mhf4Wt4WElyFE+9SSq6t+GwLyf6b7/jcJa1ocI6aklLWHIsbfYZWajryzGD
	 cuYvWsD/lFBf4TaaMwMUJG73trEn1xYIhbtI4c3DysAavkbfvZOA1gwpjX608OckJO
	 ysN7mEAS24WC71HO3IwHFC0B/08m+Q/6m2V/X2xY=
Date: Tue, 7 Jul 2026 14:35:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: jirislaby@kernel.org, peter@hurleysoftware.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH] tty: n_tty: order lockless input availability checks
Message-ID: <2026070700-exorcism-deluxe-4165@gregkh>
References: <20260504072321.928921-1-zzzccc427@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504072321.928921-1-zzzccc427@gmail.com>

On Mon, May 04, 2026 at 03:23:21PM +0800, Cen Zhang wrote:
> The N_TTY read buffer uses release/acquire ordering for its
> lockless ring indices. Input producers release-publish canon_head and
> commit_head after updating the buffer and delimiter flags, and readers
> acquire those heads before copying data. Readers also release-publish
> read_tail before producers use it to calculate room.
> 
> chars_in_buffer() and input_available_p() sample the same indices
> for availability and flow-control decisions, but use plain loads. That
> can miss the ordering used by the data-copy paths and can also let
> poll() observe termios-synthesized availability with weaker ordering
> than normal receive-side publication.
> 
> Use acquire loads for the lockless head/tail samples in those
> helpers. When n_tty_set_termios() updates canonical/noncanonical
> availability, publish the updated heads with release stores as well.
> Keep the cached icanon bit as an intentionally lockless mode snapshot
> and annotate that access.
> 
> Fixes: 70aca71f92ca ("n_tty: Fix unordered accesses to lockless read buffer")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  drivers/tty/n_tty.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index e6a0f5b40d0a..56b0cd96a453 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -213,9 +213,17 @@ static void n_tty_kick_worker(const struct tty_struct *tty)
>  static ssize_t chars_in_buffer(const struct tty_struct *tty)
>  {
>  	const struct n_tty_data *ldata = tty->disc_data;
> -	size_t head = ldata->icanon ? ldata->canon_head : ldata->commit_head;
> +	bool icanon = data_race((int)ldata->icanon); /* lockless snapshot */
> +	size_t head;
> +	size_t tail;
>  
> -	return head - ldata->read_tail;
> +	if (icanon)
> +		head = smp_load_acquire(&ldata->canon_head); /* producer publish */
> +	else
> +		head = smp_load_acquire(&ldata->commit_head); /* producer publish */
> +	tail = smp_load_acquire(&ldata->read_tail); /* consumer publish */

I still don't understand the need for this change, nor do I understand
the changelog text, sorry.

These reads can not "tear", so there shouldn't be an issue with the
read, so why is smp_load_acquire() suddenly now required?  What changed
to need this?


> +
> +	return head - tail;
>  }
>  
>  /**
> @@ -1779,14 +1787,14 @@ static void n_tty_set_termios(struct tty_struct *tty, const struct ktermios *old
>  		bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
>  		ldata->line_start = ldata->read_tail;
>  		if (!L_ICANON(tty) || !read_cnt(ldata)) {
> -			ldata->canon_head = ldata->read_tail;
> +			smp_store_release(&ldata->canon_head, ldata->read_tail); /* publish */

So everything is a "publish"?  That doesn't make sense to me, what am I
missing?

>  			ldata->push = 0;
>  		} else {
>  			set_bit(MASK(ldata->read_head - 1), ldata->read_flags);
> -			ldata->canon_head = ldata->read_head;
> +			smp_store_release(&ldata->canon_head, ldata->read_head); /* publish */
>  			ldata->push = 1;
>  		}
> -		ldata->commit_head = ldata->read_head;
> +		smp_store_release(&ldata->commit_head, ldata->read_head); /* publish */
>  		ldata->erasing = 0;
>  		ldata->lnext = 0;
>  	}
> @@ -1908,11 +1916,17 @@ static inline int input_available_p(const struct tty_struct *tty, int poll)
>  {
>  	const struct n_tty_data *ldata = tty->disc_data;
>  	int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ? MIN_CHAR(tty) : 1;
> +	bool icanon = data_race((int)ldata->icanon); /* lockless snapshot */

What is racing?  How?


> +	size_t tail = smp_load_acquire(&ldata->read_tail); /* consumer publish */
> +	size_t head;
>  
> -	if (ldata->icanon && !L_EXTPROC(tty))
> -		return ldata->canon_head != ldata->read_tail;
> -	else
> -		return ldata->commit_head - ldata->read_tail >= amt;
> +	if (icanon && !L_EXTPROC(tty)) {
> +		head = smp_load_acquire(&ldata->canon_head); /* producer publish */
> +		return head != tail;
> +	}
> +
> +	head = smp_load_acquire(&ldata->commit_head); /* producer publish */
> +	return head - tail >= amt;

Again, this is some very old and battle-tested code, and I am loath to
touch it and add any additional latencies here unless there is a real
reported bug that can be found, and not just some theoretical one.

thanks,

greg k-h
