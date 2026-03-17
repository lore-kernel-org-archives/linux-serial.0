Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3A3976BF;
	Tue, 17 Mar 2026 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735790; cv=none; b=P4iXCj4Km3Xdt5hgi1cct6JWzFoDRIs7qWErMw2GBrJDn+18xS1qbFUvnTGiq1OCWCPGnneDSYK2pldGL8LOZfPouPM7b/8C/RB8NgbT7WHbpM/+ihD/J7kpxDMKfxXsmLgatS3Y+fvWG8SxOilx3vjAOB/IVC641g9vwcO6xlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735790; c=relaxed/simple;
	bh=ui2spBu1HLv2k+u/pld5kKmyFx33HgSpeunUWC4nuoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPj2XlzKO7AbpGbyWKQnBV/Toj7umleLqs98DuIfXIWL5se4+y6TNtafjXRqNnQYLt5wpy41huIWE6uo9lrB/SrsMZ3P3rgq2mlI8kchTmU/vU0p1+uWFzTWH1M+XMzpQgAVn5j28RTDjpLXgiW8v+Xs5KQdSVHJgBa9o3kvt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m1nS022S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m1nS022S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E34C2BCB2;
	Tue, 17 Mar 2026 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773735790;
	bh=ui2spBu1HLv2k+u/pld5kKmyFx33HgSpeunUWC4nuoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1nS022SV6u2B46dVCtfZnxhp19CASVaWYvxId3PaHvpIFa9df2E9S43ofee9QXLS
	 0P6WHGnQ91t7oaHlpl7+nqNQ+svWa6MuGW/YcF6zds62xpkX81CHj+GbJpsRFM8R5Q
	 yvUMfvOX34Hngsvq9sBVeA3B3XCe5yc7wXZBSB3k=
Date: Tue, 17 Mar 2026 09:23:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ziyu Zhang <ziyuzhang201@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, baijiaju1990@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] tty: n_tty: annotate lockless read of ldata->icanon
 in input_available_p()
Message-ID: <2026031702-unsheathe-gizmo-6851@gregkh>
References: <20260317081911.24390-1-ziyuzhang201@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317081911.24390-1-ziyuzhang201@gmail.com>

On Tue, Mar 17, 2026 at 04:19:11PM +0800, Ziyu Zhang wrote:
> n_tty_poll() calls input_available_p() without holding termios_rwsem to
> check input readiness for select()/poll(). input_available_p() reads
> ldata->icanon, which can be concurrently written by n_tty_set_termios()
> under down_write(termios_rwsem).
> 
> This is a benign race: poll/select readiness is best-effort, and the
> actual n_tty_read() path re-checks icanon under down_read(termios_rwsem).
> A stale icanon value in poll only causes a transiently incorrect
> readiness result, which is permitted by POSIX poll/select semantics.
> 
> Since icanon is a bitfield, READ_ONCE()/WRITE_ONCE() cannot be used.
> Annotate the read with data_race() and evaluate it as a boolean to document
> the intentional lockless access, bypass __auto_type compiler errors, and
> suppress data race detector warnings.
> 
> Reported-by: kernel test robot <lkp@intel.com>

No this robot did not report this issue :(

> Closes: https://lore.kernel.org/oe-kbuild-all/202603162328.vY9JOJWL-lkp@intel.com/
> Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
> ---
>  drivers/tty/n_tty.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index e6a0f5b40..0a0d8d70c 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1909,7 +1909,8 @@ static inline int input_available_p(const struct tty_struct *tty, int poll)
>  	const struct n_tty_data *ldata = tty->disc_data;
>  	int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ? MIN_CHAR(tty) : 1;
>  
> -	if (ldata->icanon && !L_EXTPROC(tty))
> +	/* data_race: benign race, poll readiness is best-effort */
> +	if (data_race(!!ldata->icanon) && !L_EXTPROC(tty))
>  		return ldata->canon_head != ldata->read_tail;

Given that the previous patch was not even tested, how was this found
and most importantly, tested?  What error was reported that this now
fixes?

What changed to cause this to now be needed?

thanks,

greg k-h
