Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6525B0BB;
	Tue, 18 Aug 2026 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034961; cv=none; b=EvkCIW4UiPtP6BS+OkfxleScGA8c9g9Ri7kik8SFhzcDM1E9FUzyTW24XYQV3HEJNHjfIDYVAs1PNG6V9KqzQfkXPHlkPjTSBtPwMEV/13DE7vUTRaCu+Kj9zri5GQN5Q8RBuJ7bglIgx8I0ntvuNRNRgfUH/aYXKlWTrmv2ejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034961; c=relaxed/simple;
	bh=yKPPn0E9DrArq2+1EDbsrGMQFW6hGrBTkfHyZ/yHH94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgXNvFWcS+nFUGI99uCLAsGrZQB/Dpo05DIqcH4JApq3kYDOC6JsBiMPsZ/Gh9joi6iN1Vz+Q62JK7gPvFNh0fayBKS42XjQapmdaZn1L4s5rP39iLDjVEa9PwRn/Nn1+VDU4RVcP3BmSgcO43pYfBjOLpRBqCoi9O+1p4RvUVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2MhK/WQJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2MhK/WQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E59A1F000E9;
	Tue, 18 Aug 2026 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787034959;
	bh=BxDcZr1nGh1OQCPFXaUu+7xRFe+WmwvUsdvXzejaPqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2MhK/WQJkyjKny5eFhYL1RRRsuAW/w4qWzDJnXg6DKhibYt1CJPVFYCxOhzRq1bCi
	 eVWXKFtneAz1Z+qjyrAaTsM8BQrhh4TnQLsQ/30ufRr5kCMEs7+PEDSv/eHrgv0mQu
	 CeCKRJkgXphDmILbv9irqNwJgnjQfK47jtUd1N8Y=
Date: Tue, 18 Aug 2026 08:34:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Chen <xin.chen2@oss.qualcomm.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, liulzhao@qti.qualcomm.com,
	cheng.jiang@oss.qualcomm.com
Subject: Re: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
Message-ID: <2026081814-sash-sandbag-6e11@gregkh>
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <2026081706-tricky-slicing-166f@gregkh>
 <2026081747-secret-partly-158a@gregkh>
 <066081a1-e644-4b01-86c5-e5ab908a7754@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <066081a1-e644-4b01-86c5-e5ab908a7754@oss.qualcomm.com>

On Tue, Aug 18, 2026 at 02:02:43PM +0800, Xin Chen wrote:
> On Mon, Aug 17, 2026, Greg KH wrote:
> > Also, you are papering over the real problem here.  If this one
> > allocation is failing, what keeps the next one from failing and then
> > the skb will not be able to be allocated?
> 
> The key difference is allocation size and allocator behavior.
> vzalloc() always allocates page-by-page from the buddy order-0 free
> list, so two back-to-back vzalloc() calls for ~10 KB each consume
> ~5 order-0 pages each, transiently depleting the order-0 free list.
> kvzalloc() serves the same ~10 KB from the kmalloc-16384 slab, which
> is backed by order-2 compound pages — a completely separate pool from
> the order-0 pages that skb_clone(GFP_KERNEL) needs. So switching to
> kvzalloc() eliminates the interference between n_tty_open() and
> skb_clone().

But that's not a problem with the tty layer, if something else happens
to "drain" the pool again you can not create a skb.  You are not solving
the root problem here.

> > Why is the system so out of memory in this slab that this is
> > happening?  What changed in the tty layer to cause this?  Or did it
> > happen elsewhere?
> 
> Nothing changed recently in the tty layer. vzalloc() has been used
> here since commit ebec3f8f5271 ("n_tty: Access echo_* variables
> carefully.", 2018), which replaced vmalloc() with vzalloc().

But that's not really a change, when was vmalloc() first used?

As nothing has changed here, then why is this suddenly showing up now?

> The
> issue surfaces only when serdev_device_open() is called multiple times
> in quick succession (as happens during BT UART transport init),
> triggering multiple n_tty_open() calls back-to-back. Each vzalloc()
> drains order-0 pages, and the window where skb_clone() fails is
> narrow but reproducible under this specific pattern. It was found
> during a BT enable-disable sanity test that repeatedly cycles BT on
> and off, which consistently triggers the back-to-back n_tty_open()
> calls that expose the issue.

Again, that sounds like a bluetooth issue, and why can't you just
properly handle the skb out of memory issue?

This feels like papering over the real problem.

> > And no cc: stable or Fixes: tag?
> 
> Both will be added in v2:
> 
>   Fixes: ebec3f8f5271 ("n_tty: Access echo_* variables carefully.")

No, that did not change the behavior of the tty call here to use a
different pool, all it did was change the zeroing out of the buffer
allocated.

thanks,

greg k-h
