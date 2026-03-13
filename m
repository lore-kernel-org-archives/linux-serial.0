Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3793DA7E1;
	Fri, 13 Mar 2026 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428057; cv=none; b=bu46ScY6SZG5bUu2QobK+se6dzaVNViIpN7uO3II93avaVP6DUkwlD88iOlVSR01lUq912wgsT/pKA1W1oxiYt36fy9SXUsvHK6EfMR5PE+AZAT+LnVZv453xxTpx3oiTUulcw2D0FjGMQs+ye3ULlL0H563cUWfz93jxHV47Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428057; c=relaxed/simple;
	bh=Tl7z6Yy78Glh81sdWONlPM4L+CSlgG9MTjUYqLG4czg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGAmsjzrTZJ5Lpnonk0g3bLPYDghJlzYGZQ92LbxDh5DbXszkX/a12GwkFvDDYOjnFEUAFPa9P91IETl985xt3HqDaft4QIDpwDy0BoiaRWmUdKi0IVu9PVim4/bB2Go7NYnpzfB+EdOr48/UmgncE2YzpJXAPs4Eo9I+/R4jgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=Zs0REexm; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=0QBfe134; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="Zs0REexm";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="0QBfe134"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1773428042; bh=G4OJqkgFHy0NygoDtUbppgl
	yYlJv1XQcBEJJ9rMCP1s=; b=Zs0REexmp5gQKl7C07IOWnMA10B/m1Vdbdcu9XTw03fkBmsIl6
	9oj6BJ5r/xzPZyXBnBkp3DVbGciw7vHbtWHvUmmVnJb1VJDKROMPpd6ftQPSTDhbieW0rSC/s3u
	uWkPvQP2vG8eHbmLpVSDUZ9SWMT2kasj0x+HdNcrdplRpX+NKa5CNXHyLVRkGOcKMNxoR/NCNSB
	QHxcAQw8yJkIirl5L/6lS7RLMjIdQ0H4GM/vcAFOzPBsrknX895/7uKbwK6Mddy3DlOk8mtAbB1
	dJrf42fRbAZpACGd8ROK/YLeeIAp669OzjJtxiLZcY3vq+2c2VkCF0PCBDhbsk0T1+w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1773428042; bh=G4OJqkgFHy0NygoDtUbppgl
	yYlJv1XQcBEJJ9rMCP1s=; b=0QBfe134KAo42sBw/N5+GthR6Q4RaH/FXFSxKNPqUX6igcNj1w
	Jfz5BeNZls28vSIjqdmXa6sBwOzWcyMFJBAg==;
Date: Fri, 13 Mar 2026 14:54:01 -0400
From: Daniel Hodges <daniel@danielhodges.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Hodges <git@danielhodges.dev>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzbot+c3693b491545af43db87@syzkaller.appspotmail.com, syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
Subject: Re: [PATCH] vt: keyboard: add NULL check for vc_cons[fg_console].d
 in kbd_keycode and kbd_rawcode
Message-ID: <zwtqyw3ztjbgjodwrnriex3plpr4akz3nz3aj7tvfeyflo4be3@mp4emzvcug6r>
References: <20260208003112.6040-1-git@danielhodges.dev>
 <2026031236-unfold-repurpose-52e6@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031236-unfold-repurpose-52e6@gregkh>

On Thu, Mar 12, 2026 at 03:22:09PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Feb 07, 2026 at 07:31:12PM -0500, Daniel Hodges wrote:
> > kbd_keycode() and kbd_rawcode() dereference vc_cons[fg_console].d
> > without checking if it is NULL. The foreground console should normally
> > always be allocated, but there could be a time during console setup or
> > teardown where this pointer could be NULL, leading to a general
> > protection fault.
> > 
> > Syzkaller triggers this by injecting USB HID input events that reach
> > kbd_event() while the console state may not be fully consistent. The crash
> > manifests as a null-ptr-deref in __queue_work when put_queue() or
> > puts_queue() calls tty_flip_buffer_push() on the uninitialized vc port.
> > 
> > Add a NULL check for vc at the start of both kbd_rawcode() and
> > kbd_keycode() to bail out early if the foreground console is not allocated.
> > 
> > Reported-by: syzbot+c3693b491545af43db87@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c3693b491545af43db87
> > Reported-by: syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=03f79366754268a0f20c
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > ---
> >  drivers/tty/vt/keyboard.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > index a2116e135a82..975830013d24 100644
> > --- a/drivers/tty/vt/keyboard.c
> > +++ b/drivers/tty/vt/keyboard.c
> > @@ -1389,6 +1389,9 @@ static void kbd_rawcode(unsigned char data)
> >  {
> >  	struct vc_data *vc = vc_cons[fg_console].d;
> >  
> > +	if (!vc)
> > +		return;
> > +
> 
> What prevents vc from being NULL right after checking this?

Yeah, your right about that. I spent a bit of time to make a reproducer
using a kernel module and I think if RCU is used on vc_cons[].d it
should then be properly protected. Let me know if that sounds like a
reasonable approach and I can send a v2.

> 
> 
> 
> >  	kbd = &kbd_table[vc->vc_num];
> >  	if (kbd->kbdmode == VC_RAW)
> >  		put_queue(vc, data);
> > @@ -1405,6 +1408,9 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
> >  	struct keyboard_notifier_param param = { .vc = vc, .value = keycode, .down = down };
> >  	int rc;
> >  
> > +	if (!vc)
> > +		return;
> 
> Same here, where is the locking?
> 
> thanks,
> 
> greg k-h

Same as above if this is protected with RCU I think that should work
properly.

-Daniel
