Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5930D2EDD58;
	Mon,  4 May 2026 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881214; cv=none; b=enuH+6h0RZ8j7LXz1a/7u1i/hZUGUKrZEIPaH7Q0+lztYGnIGzCfbjnrB/cdeVwc7WPNUkHIz15IVc4d43ku9h49YlUb7/HSG7HXln3Eb9vVTQz6TrL+DWncot+P+VMrsmw7zQJMo7OUZT6Dp8ITznTxh8+U28cKNT0Lvs/Ur34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881214; c=relaxed/simple;
	bh=jkA3gxQpHJVlKAaPFrrkAi6Xe8QcdXcvBN1PUIYVzCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETb7ykAjZy/MVAG3+nLvfSUps33urizWotGbtLp/h7lgk5CDcfC+OfXvMBa5WkHT+ukIxMW98hqei8TvrxAWg1E2gyaAESYC9ZJy1zXhm5Nj1d+gQ5+e3NWV7WNgSaRF02FeQ1SZAePOLhAznMQLp4GmSzXE8lHiIl82C76i1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oBgcOaJy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oBgcOaJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A48C2BCB8;
	Mon,  4 May 2026 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777881213;
	bh=jkA3gxQpHJVlKAaPFrrkAi6Xe8QcdXcvBN1PUIYVzCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBgcOaJyVNSvrD230P4h4JA2jL2fFlvlaCEbTyMysBw9yrvVEBUa+4ZYHO1nL6YGB
	 Nn1SxpNlMAYx2PBOdLETjupMSFVfAG0oKBSMgcraCmwwmaLzS1XE+3sB5GOD18/G6v
	 L19CWdq4VLYbuE/YF2cASI1E8ldxtDnJBInpXmEg=
Date: Mon, 4 May 2026 09:53:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: jirislaby@kernel.org, peter@hurleysoftware.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH] tty: n_tty: order lockless input availability checks
Message-ID: <2026050455-secret-monetary-bb37@gregkh>
References: <20260504072321.928921-1-zzzccc427@gmail.com>
 <2026050451-tree-trustful-a841@gregkh>
 <CAFRLqsVMYRESR4dhpcsxXF17FvaX5obXyT0ZXZMkHymnw-6K6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFRLqsVMYRESR4dhpcsxXF17FvaX5obXyT0ZXZMkHymnw-6K6Q@mail.gmail.com>

On Mon, May 04, 2026 at 03:47:01PM +0800, Cen Zhang wrote:
> Dear Greg KH
> 
> Thanks for taking a look, and sorry if the changelog made this sound
> stronger than the evidence I have.
> 
> > What tests show that this is needed?  That commit was a long time ago,
> > and surely we would have had some bug reports since then, right?
> >
> > thanks,
> >
> > greg k-h
> 
> The evidence I have is from data-race reports produced while stressing
> pty/tty ioctls.  The relevant stacks, mapped to current v7.0.3 source,
> are:

Cool, where are those reports?

>   - read/unthrottle side:
>       chars_in_buffer() at drivers/tty/n_tty.c:216
>       n_tty_check_unthrottle() at drivers/tty/n_tty.c:275
>       n_tty_read()
> 
>     racing with the receive side:
>       n_tty_receive_char_canon() at drivers/tty/n_tty.c:1258
>       __receive_buf() at drivers/tty/n_tty.c:1588
> 
>   - poll/select side:
>       input_available_p() at drivers/tty/n_tty.c:1912-1915
>       n_tty_poll() at drivers/tty/n_tty.c:2440/2444
> 
>     racing with termios changes:
>       n_tty_set_termios() at drivers/tty/n_tty.c:1782,
>       drivers/tty/n_tty.c:1786 and drivers/tty/n_tty.c:1789
> 
> My reasoning was that these helpers sample the same lockless read-buffer
> availability state that the read/copy paths already handle with
> smp_store_release()/smp_load_acquire(), but I do not have a test showing
> a concrete functional failure beyond the data-race reports.
> 
> Would you prefer that I drop the Fixes tag and respin the changelog to
> describe this as a conservative KCSAN/LKMM cleanup?  Or do you think the
> evidence is too weak for a change here?

I don't really know as I haven't seen any such reports before that I can
recall.

thanks,

greg k-h
