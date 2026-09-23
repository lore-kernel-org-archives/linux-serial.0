Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAC49DB99;
	Wed, 23 Sep 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168172; cv=none; b=aC8obccCmU8JQXm9tDguERc9QYawDqm1+Kv1UUMAlurJdOw06YvI8IkPZWHt425lMDmvuG9WSeYOAfipF52RAR6x9/D1ABhjd8qu6rYA9qYBx1Ffdkj7i6msds46iNML9M395Zqff6pifcxRuViBduUg6R5Q4eOSXBkGt8JgARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168172; c=relaxed/simple;
	bh=3sSP4Pn3z6ALETc0ZMBZlUCy45qLtaqtPePVor8ofoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ak16e41M4a7s8bT0ZG5y8w6cXGP5xBevGbt83uzYyfIOJxCowGZLjRMQQQd9G7Mx9l4vsdVeEIi+kFJwHYfDnP5v2t1hXBl715iTGY08L5+GteRh/2bipF58dZG9sA6aJRk8XtzTWw/i7ah/yFcH6jnurAQFQNRi3pNEtO0Uprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ktg31nqx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ktg31nqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385211F00898;
	Wed, 23 Sep 2026 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790168170;
	bh=uQ+gbSkfoyyrEl5NHA6J/S5gznBt22JeGTI7PKrUUTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ktg31nqxaSYAwdZhY6jQiB9tn+T6+a8yMUvdp+I4M9ovxgaJspGlvOYwFBF4k5W/5
	 9gAr4Oia4921Tr7W8eBS7h6OBdRl8Vkb1tthbcC4GG6ci7Y8kOjHnKRwhEVBu8J3VQ
	 b7R4E3WhMxmPBgJcv52y3/j6XR75xXHuv0OaeQSc=
Date: Wed, 23 Sep 2026 14:56:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?=D6mer?= Mete Kaya <omermetekaya0@gmail.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzbot+d84934b4184d7f9a1aed@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: fix lock order inversion in tty_buffer_flush()
Message-ID: <2026092316-treadmill-disparity-8a38@gregkh>
References: <20260804140251.8197-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804140251.8197-1-omermetekaya0@gmail.com>

On Tue, Aug 04, 2026 at 05:02:51PM +0300, Ömer Mete Kaya wrote:
> tty_buffer_flush() calls ld->ops->flush_buffer() while holding
> buf->lock. For the N_TTY line discipline, flush_buffer() is
> n_tty_flush_buffer(), which acquires termios_rwsem.
> 
> However, the documented stable lock order (see tty.h) is:
>   termios_rwsem -> buf->lock
> 
> Calling flush_buffer() under buf->lock inverts this order and creates
> a circular locking dependency detected by lockdep:
> 
>   &buf->lock -> console_lock -> &port->mutex -> &tty->termios_rwsem
>                                                 -> &buf->lock
> 
> Fix this by moving the flush_buffer() call outside buf->lock.
> The buffer data has already been discarded at this point, so the
> ordering change is safe.
> 
> Reported-by: syzbot+d84934b4184d7f9a1aed@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d84934b4184d7f9a1aed

Did syzbot actually test this?  How did you test this?

Did you forget an Assisted-by: tag?

> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
> ---
>  drivers/tty/tty_buffer.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 96be90db5..bb7b7fbcb 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -244,11 +244,15 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
>  	buf->head->read = buf->head->commit;
>  	buf->head->lookahead = buf->head->read;
>  
> -	if (ld && ld->ops->flush_buffer)
> -		ld->ops->flush_buffer(tty);
> -
>  	atomic_dec(&buf->priority);
>  	mutex_unlock(&buf->lock);
> +	/*
> +	 * Call flush_buffer() outside buf->lock: n_tty_flush_buffer()
> +	 * acquires termios_rwsem, but the required lock order is
> +	 * termios_rwsem -> buf->lock, not the other way around.
> +	 */
> +	if (ld && ld->ops->flush_buffer)
> +		ld->ops->flush_buffer(tty);

This feels wrong, what is going to break with this change?  What commit
does this change fix?

thanks,

greg k-h
