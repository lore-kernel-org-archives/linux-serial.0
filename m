Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5776447808;
	Tue,  4 Aug 2026 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838003; cv=none; b=cWJmCCIkTYFeo22CSAJKLEdF6U3f3Bqh8ypXpvuLnZE8Zpwy2mn502e6bcw6vw3ohZoDjF62JfKTUkctNDgFd7ozdSSsdK6kQ2ZL1IkiXBSVnrTySW5Vg82v2dZj5KiUZ+yfl2pwu5/Psx8d4Evnu7ZFAEzDJx/A1dXU3tPe/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838003; c=relaxed/simple;
	bh=u9qkPsxiAicOI6v9LuziZhTLdtg6OhGAUDLDwQRXhvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oty6B9lhgBOusHsb2CzTiJJ5u3mgZkwHcyAn8vzssnstuwoaHDjrmJu4EWp5bCVFnNZz8Yyoc/CUlqfWWCoi5PFEZciARcYgU97vwgBk+iu31rVdY1YoHX8xgeUV04eVioJOyNj8HWgzxYRF56xsBUsZedoBWl2XBDaLxrJfsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IgZoDlC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IgZoDlC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E3E1F000E9;
	Tue,  4 Aug 2026 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785838002;
	bh=5/BBDjT1o3qmVO+g4IxqCy9koGf80asojskfV9ghGLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IgZoDlC88YeQDfFMgnSqDCRwCOzJJb/r+GtAEnxodFsseSKPLAxnG6uVL9fq/23rI
	 RxT6ywxhT7iZjAQJC7tZ1RX+GMowSI2Z2lhTBBCbI5DJnv+v7OjEBfPb4h6xpLkdHR
	 EYbuUH2BSvym4WhgwmYV8F6qLVZzXY4p08EYtvZE=
Date: Tue, 4 Aug 2026 12:06:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: jirislaby@kernel.org, viro@zeniv.linux.org.uk, willy@infradead.org,
	kees@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devpts: fix pty count limit off by one
Message-ID: <2026080420-pastor-kelp-c4a1@gregkh>
References: <2026080419-chatting-curve-e49c@gregkh>
 <20260804095252.889108-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804095252.889108-1-chenyichong@uniontech.com>

On Tue, Aug 04, 2026 at 05:52:52PM +0800, Yichong Chen wrote:
> Hi Greg,
> 
> Yes, this is user-visible.

Sorry, always include the proper context, and respond after email text.
Remember, some of us get 1000+ emails a day to deal with.

For specifics:

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

> The reason I sent the patch is that this used to allow pty_count to reach
> the configured limit.  Before commit 0f0a0e54a2a1 ("devpts: Convert to new
> IDA API"), devpts_new_index() checked the old pty_count first and only
> incremented it after the allocation succeeded:
> 
>   if (pty_count >= limit)
>           return -ENOSPC;
>   ...
>   pty_count++;
> 
> After that commit, the code started using atomic_inc_return(), but kept the
> >= comparison:
> 
>   if (atomic_inc_return(&pty_count) >= limit)
>           goto out;
> 
> So a count equal to the configured limit became rejected.  That makes
> kernel.pty.max behave as an effective max - 1 limit.
> 
> I thought allowing the count to reach kernel.pty.max again would better
> match the usual interpretation of a "max" sysctl.  But I agree this also
> changes visible behavior again, and the current max - 1 behavior has been
> around since 2018.
> 
> So if you prefer to preserve the existing behavior for compatibility, I am
> fine with dropping the patch.

What is currently breaking that was working just fine with the way the
code is today?  If nothing, then we should probably leave it alone,
right?

thanks,

greg k-h
