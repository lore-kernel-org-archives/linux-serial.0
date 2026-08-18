Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22EC345751;
	Tue, 18 Aug 2026 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038484; cv=none; b=FAoEVZyIZ1vKMsZ+84u/JNcrkfGydYmZPxXnB5UeKBQ+TlQjEW4Vm3cl7ZxtUNLRLf3Ft+7yUDo06cv2xuZYODHXxedOoPOe0G/cbRpMsbfEtf5Si7vyLo4n+SH/5N27ZSJF7UL89WuauZ2XFCWeqeZ3y9euXYbRfaTAGNLktmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038484; c=relaxed/simple;
	bh=gSc6oIG4mj84DLQaiBQS/FKV2kNn2uJZdnCIJOkjX6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La0CZcMljpucmrUBAls28Z78+U23rcYGoKE6zLSlIuAokd/7H0IeWz+3NHSqp5im36b0iNElw5lXeM72KaI6x+ibQf7Ya/r6aTwiz6LioOTIkrC+VK112bTzEe8kIlmbXnqjOXHWxQRfEQJLA5HTUcXhqotwo2elowQpNeYC5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nseSnHDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nseSnHDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3F71F000E9;
	Tue, 18 Aug 2026 07:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787038476;
	bh=Q99c67m5xWEDZoBVJD/cTSQbtJGBUjArCNB8ck0T9Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nseSnHDf8LKFGS9KjTccuP7keT5eT/8CTjE/ePm/MQlPtjzY0ax1hwnou3zcxRDdp
	 FLUT1hBuM3BHJ4139dVZHxIs9n98U8Qf3P79ApOQZuDfcFiqHlo+gSHO2uxzYPy09b
	 iWtZ3PxPjOqmdppz2HaQDVa51yU88LeVXvIwD/co=
Date: Tue, 18 Aug 2026 09:34:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Chen <xin.chen2@oss.qualcomm.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, liulzhao@qti.qualcomm.com,
	cheng.jiang@oss.qualcomm.com, cxin@qti.qualcomm.com
Subject: Re: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
Message-ID: <2026081851-krypton-shady-b18d@gregkh>
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <2026081706-tricky-slicing-166f@gregkh>
 <2026081747-secret-partly-158a@gregkh>
 <066081a1-e644-4b01-86c5-e5ab908a7754@oss.qualcomm.com>
 <2026081814-sash-sandbag-6e11@gregkh>
 <5c0fdf81-950c-427f-8327-a8b4b1ad922f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c0fdf81-950c-427f-8327-a8b4b1ad922f@oss.qualcomm.com>

On Tue, Aug 18, 2026 at 02:58:41PM +0800, Xin Chen wrote:
> On Tue, Aug 18, 2026, Greg KH wrote:
> > But that's not a problem with the tty layer, if something else happens
> > to "drain" the pool again you can not create a skb.  You are not
> > solving the root problem here.
> 
> You are right that this does not prevent every possible order-0
> exhaustion. However, the specific and reproducible trigger is
> n_tty_open() consuming order-0 pages via vzalloc() immediately before
> skb_clone() runs. Eliminating that unnecessary pressure removes the
> failure in practice, even if it does not make skb_clone() immune to
> all possible memory pressure.

Then you are going to play whack-a-mole on your very memory-constrained
system in order to work around the root problem here.  Please don't do
that, solve the real problem you are having.

> > But that's not really a change, when was vmalloc() first used?
> > As nothing has changed here, then why is this suddenly showing up now?
> 
> ldata was originally allocated with kzalloc() (introduced in commit
> 70ece7a73159, "TTY: n_tty, add ldisc data to n_tty", 2012).  Commit
> ebec3f8f5271 switched it to vmalloc()/vzalloc() in 2018 as a side
> effect of fixing an echo buffer race — the allocation change was
> incidental, not intentional.  The issue surfaces now because the BT
> enable-disable sanity test exercises a back-to-back open pattern that
> was not common before serdev-based UART transports became widespread.

So this is purely because you are stress-testing the BT stack now,
right?

> > Again, that sounds like a bluetooth issue, and why can't you just
> > properly handle the skb out of memory issue?
> 
> The skb_clone() failure is silent — it returns NULL and the code
> continues without error, leaving hdev->req_skb NULL.

Why not fix that?

> By the time
> the BT layer observes the problem (a -ETIMEDOUT 10 seconds later),
> it is several layers removed from the skb_clone() failure: the
> firmware has already replied successfully, hci_req_cmd_complete()
> has already run and found req_skb NULL, and the completion callback
> was never invoked.

Again, fix that.

> At that point the BT layer has no way to
> distinguish a memory failure from a genuine firmware timeout, let
> alone recover from it. 

But that's not a TTY layer issue, it's a BT issue.  Please fix that.

> And even if the NULL req_skb were detected
> and surfaced as an error immediately, there is nothing the BT layer
> could do to recover — it cannot reclaim memory or retry the
> allocation itself.

Nor should it, it should handle the error properly and recover
correctly.

>  The only option would be to wait for the memory
> to be reclaimed and retry the entire BT enable sequence from
> userspace, which is exactly the kind of fragile error handling we
> want to avoid.

No, you need to handle the error properly because it could happen at any
point in time.

> The tty change is simpler and correct: ldata was originally a
> kzalloc() allocation and there is no reason for it to use
> vmalloc-backed pages that interfere with unrelated allocations.

It is not "correct", but rather papering over the root problem.

Fix the bluetooth stack please.

thanks,

greg k-h
