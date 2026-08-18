Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967D18B0A;
	Tue, 18 Aug 2026 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033366; cv=none; b=nQEYOStPdREeJLqcGMWyvoZZj2HRl4puE1zxCBNQH7GWRXTSKlpHEwMkscYndVo37gIfQFLtHiFO73vb6O7dJeGyCRtMQdjvfYMGJ6Jy+CP5TTpKc5RlRn0hQs1qORGiDU/Idb87SqKqsjmutgzpyu5hdTadVqKk/20z5aL9Lu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033366; c=relaxed/simple;
	bh=gB6uRz7eRY0JmDLwfu4co3mm9os4niF+AxsGWiqdtA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPhthyLWq5CGHNgG6KXc2g8Q1JoxZtE9notqs+g/jQZfti+ao3CeZseVdZF6vphHuqEP26s3lu5+CGBU3/qKu+GowMt0dC/K6KiN0ytY7dygIMBNu9D1YF+vBQ01paE1k3w10rq+xJWngLfG9xX0sPMBvJdvVwpHBa9O1JwfSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pcRKIYHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pcRKIYHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E461F000E9;
	Tue, 18 Aug 2026 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787033364;
	bh=khAEW55O1G15+kYQqrcsG6wJrv8NjtopgQ4/4yjakCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pcRKIYHchjYfjc/e970YxkGeoLeiPaQb2fUr1ua/NjZVYlxNR+z+/0WTrLtz+bAMN
	 bZA6zfkNrC4ezuVnvD8BhFWIZYEe2GC0W3qzJMB+koJou+uPtihCDfXvCAT3ftRKoI
	 zQCdDBwrpvbJnh2laGgis4AYjhNIBh7BchtdxnZU=
Date: Tue, 18 Aug 2026 08:07:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Chen <xin.chen2@oss.qualcomm.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, liulzhao@qti.qualcomm.com,
	cheng.jiang@oss.qualcomm.com, cxin@qti.qualcomm.com
Subject: Re: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
Message-ID: <2026081841-relation-barn-304e@gregkh>
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <2026081706-tricky-slicing-166f@gregkh>
 <d2aa3572-e3f3-44c1-816e-a95bbbc77abb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2aa3572-e3f3-44c1-816e-a95bbbc77abb@oss.qualcomm.com>

On Tue, Aug 18, 2026 at 11:31:14AM +0800, Xin Chen wrote:
> On Mon, Aug 17, 2026, Greg KH wrote:
> > So you run out of memory?  That feels wrong.
> 
> Not a full OOM — just a transient exhaustion of order-0 pages caused
> by repeated vzalloc() calls each draining the buddy order-0 free list.
> The system recovers quickly, but the damage is already done by then.

What specific "damage"?

> > Why not just use a specific slab for this one structure if it is so
> > important that it never run out?
> 
> kvzalloc() already achieves that: it tries kmalloc() first, which
> serves the ~10 KB n_tty_data from the kmalloc-16384 slab (an order-2
> compound page), leaving the order-0 free list intact. A dedicated slab
> would add complexity without further benefit.
> 
> > Why was this using vzalloc() in the first place if it could fail?
> 
> Historically, ~10 KB was considered too large for kmalloc(), so
> vzalloc() was used. kvzalloc() is the natural modern replacement: it
> tries kmalloc() first and falls back to vmalloc() only on failure,
> which is strictly better.
> 
> > And if it does fail, doesn't everything work properly, you just need
> > to handle that failure in userspace correctly, right?
> 
> Even if the error were surfaced correctly to userspace, there is
> nothing useful it can do. The actual failure here is that skb_clone()
> in hci_send_cmd_sync() silently fails due to the depleted order-0
> free list, leaving hdev->req_skb NULL. The firmware reply arrives and
> is processed, but hci_req_cmd_complete() cannot find the completion
> callback, so the waiter times out with -ETIMEDOUT. From userspace's
> perspective this looks like a hardware or firmware timeout, not a
> memory issue. Even if userspace retried BT enable, it would trigger
> serdev_device_open() again, which calls n_tty_open() again, which
> calls vzalloc() again — further draining the order-0 free list and
> making recovery harder. The root fix is to stop consuming order-0
> pages unnecessarily in the first place, which is exactly what
> switching to kvzalloc() achieves.

But it's not consuming them "unnecessarily" as the memory is needed.
Why not fix the root problem here of having this be called so many times
that you are running out of memory?

And why isn't memory being reclaimed properly if we do not have any left
in that free list?  The allocation can sleep, so it should be always
succeeding if the system isn't truely out of memory, as you imply it is
not.

thanks,

greg k-h
