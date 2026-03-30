Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1F362156;
	Mon, 30 Mar 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884762; cv=none; b=VsvYXO6O/xSXHHnp4paHpCTDGywJHXU5tPAuE+PXTzGUJTyNFa8FL3h9qPwC7mafRa9KgjB+kOcNvfVMwHdJBlUJ7vCYjt9c+GAXTvCa/242v+45hot4SwZhJ4mTbGxiPPifD5naF5PrKouFzppP5JB85ntZZ6qjxa/IRcnFb8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884762; c=relaxed/simple;
	bh=r0IE8whf6JLUw7+2f+muBIwcGu1rn3rkPlR+JkEmAYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2ooLVEjN2RezYQyMWV0LqO6UJilt/2xWWTkLtrgnSRuvZvp2CIHZcTstTOfh8TJdroBXzrrWq4OAdB99e0ymsp0MkWT0v0yYwui68Bowntuddeq7JqkARZcAIaKRUMGwokQQ/MmVOdOJJcakfNb05byhlvl1Zr41SVmsU4MDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGKHPTj7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGKHPTj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2962C4CEF7;
	Mon, 30 Mar 2026 15:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774884761;
	bh=r0IE8whf6JLUw7+2f+muBIwcGu1rn3rkPlR+JkEmAYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGKHPTj78PDyEVMG9S8U1h/QrqtOV6nLsULrCYE36V56MhGOiHSYsmPBfSBCz01iW
	 4CoGACRwLIcLMSkYG9jLW1bMDFntwTPdHub4EWqTW9xPtwUjXnLo2cU0uLS58CKIv8
	 hBDwrUBwu+Nlq+wQVFZWtkXYpGTCKI00iPyHUHjw=
Date: Mon, 30 Mar 2026 17:32:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Hodges <daniel@danielhodges.dev>
Cc: Daniel Hodges <git@danielhodges.dev>, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	syzbot+c3693b491545af43db87@syzkaller.appspotmail.com,
	syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
Subject: Re: [PATCH] vt: keyboard: add NULL check for vc_cons[fg_console].d
 in kbd_keycode and kbd_rawcode
Message-ID: <2026033002-game-parsnip-955c@gregkh>
References: <20260208003112.6040-1-git@danielhodges.dev>
 <2026031236-unfold-repurpose-52e6@gregkh>
 <zwtqyw3ztjbgjodwrnriex3plpr4akz3nz3aj7tvfeyflo4be3@mp4emzvcug6r>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zwtqyw3ztjbgjodwrnriex3plpr4akz3nz3aj7tvfeyflo4be3@mp4emzvcug6r>

On Fri, Mar 13, 2026 at 02:54:01PM -0400, Daniel Hodges wrote:
> On Thu, Mar 12, 2026 at 03:22:09PM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Feb 07, 2026 at 07:31:12PM -0500, Daniel Hodges wrote:
> > > kbd_keycode() and kbd_rawcode() dereference vc_cons[fg_console].d
> > > without checking if it is NULL. The foreground console should normally
> > > always be allocated, but there could be a time during console setup or
> > > teardown where this pointer could be NULL, leading to a general
> > > protection fault.
> > > 
> > > Syzkaller triggers this by injecting USB HID input events that reach
> > > kbd_event() while the console state may not be fully consistent. The crash
> > > manifests as a null-ptr-deref in __queue_work when put_queue() or
> > > puts_queue() calls tty_flip_buffer_push() on the uninitialized vc port.
> > > 
> > > Add a NULL check for vc at the start of both kbd_rawcode() and
> > > kbd_keycode() to bail out early if the foreground console is not allocated.
> > > 
> > > Reported-by: syzbot+c3693b491545af43db87@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=c3693b491545af43db87
> > > Reported-by: syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=03f79366754268a0f20c
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > > ---
> > >  drivers/tty/vt/keyboard.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > > index a2116e135a82..975830013d24 100644
> > > --- a/drivers/tty/vt/keyboard.c
> > > +++ b/drivers/tty/vt/keyboard.c
> > > @@ -1389,6 +1389,9 @@ static void kbd_rawcode(unsigned char data)
> > >  {
> > >  	struct vc_data *vc = vc_cons[fg_console].d;
> > >  
> > > +	if (!vc)
> > > +		return;
> > > +
> > 
> > What prevents vc from being NULL right after checking this?
> 
> Yeah, your right about that. I spent a bit of time to make a reproducer
> using a kernel module and I think if RCU is used on vc_cons[].d it
> should then be properly protected. Let me know if that sounds like a
> reasonable approach and I can send a v2.

Maybe?  But can this really ever be hit on a non-syzkaller workload?

thanks,

greg k-h
