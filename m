Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F283451B5;
	Tue, 21 Oct 2025 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064016; cv=none; b=emGCWoSEbJuVcMeG7jiXr9FKF9FjzPVh9KPMlypG2ewjz95Lgtspe7p7Lf0X88gSbQpHwGSveEbDQFdx/olwcQ6/YmiMCtIrRO76EQ1jKuiATBUDsD9p+CYhlMmpPonCEm/g7XXN0SEjuEK42527fOe2G8qFrTQ/WuWI9kgRF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064016; c=relaxed/simple;
	bh=s3oZkA4nJ7dcSOY1YyzCYB73ZTlasatK8ZPHkJrRTVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS1WC5G5GmWNc3cFBhH6MDGHkzmUle6Ao+RxpLF+IYVGz1ZIWqxVzpKIM08T1IqNaFNRx0ms8SmpyhOKU23zU2EtyKsbzbcSbIfN1TS8FakSdy/nw19DlbKxExXG04hun3fVyQdwoRDwq2WNpzIKWkbxxaVDzXMPUdc+DsEO1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LfcSrQDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LfcSrQDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4ACC4CEF1;
	Tue, 21 Oct 2025 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761064016;
	bh=s3oZkA4nJ7dcSOY1YyzCYB73ZTlasatK8ZPHkJrRTVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfcSrQDCHwNzt4RPoijyP5r0oK8HcWQBlbSmOFbeqL9mn8i0lkkTjAwvLzcDbuUwM
	 vE9SUCijeOuSDKyKmh3PhrCBrDmRLLzE10f5QYAIvtOEoTOwiX+godV6ke7jqvIKVd
	 AbVhNANUvKUi4MT9Vbog25sWcreBAckm2pKGxgDk=
Date: Tue, 21 Oct 2025 18:26:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: hch@infradead.org, jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on
 specific cpu
Message-ID: <2025102107-player-baggie-37fc@gregkh>
References: <2025102157-goal-grandma-36d4@gregkh>
 <20251021130513.871830-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021130513.871830-1-jackzxcui1989@163.com>

On Tue, Oct 21, 2025 at 09:05:13PM +0800, Xin Zhao wrote:
> On Tue, 21 Oct 2025 13:28:46 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > Meta-comment, this is a v2, and was not threaded with patch 1/1.  Please
> > use a tool like b4 or git send-email to send patches out so that we can
> > properly review/apply them.
> 
> I did use git send-email to send the patches. I have successfully used the
> git send-email tool to send a series of patches before, and that series was
> later merged into 6.18-rc1. Therefore, I feel that my usage of git send-email
> should not be an issue. The only difference of my current submission is that
> after sending each patch with git send-email, I waited for the patches to
> appear on lkml.org before sending the next one. I had encountered issues before
> where sending multiple patches in a row caused only some of them to appear on
> lkml.org, with others taking a long time to show up. That's why I specifically
> decided to wait a bit after each patch this time. I'm really not sure why the
> system didn't group my three patches together; it's quite puzzling to me.

I do not know, but it was not threaded :(

Try sending it to yourself and see if the delay maybe caused a problem?
there should not be an issue sending just 3 messages at once.

> > Are you using the RT kernel?  It seems odd that this is just coming up
> > now, given our normal latency issues in the tty layer.  What changed to
> > cause this?
> 
> > > In our system, the processing interval for each frame of IMU data
> > > transmitted via UART can experience significant jitter due to this issue.
> > > Instead of the expected 10 to 15 ms frame processing interval, we see
> > > spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> > > be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> > > jitter exceeds the software's tolerable limit of 20 ms.
> > 
> > Again, are you using the RT kernel?  If not, can you try that?
> 
> Our system is indeed RT-Linux, version 6.1.146-rt53. Our project has been
> ongoing for about 2 years, and we hadn't paid close attention to these jitter
> issues before. It is only recently that we needed to focus on them specifically.

6.1 is very old, please try the latest 6.17.y release, or 6.18-rc1.
Lots and lots of RT stuff has been fixed since 6.1.

> > This is not the 1990's, we don't add new module parameters :)
> > 
> > This will not work for systems with multiple tty devices/drivers, please
> > use a correct api for this if you really really need it.
> > 
> > But again, I think this might not be needed if you use the RT kernel
> > issue.
> 
> If user-configurable CPUs are really needed for queueing, do you have any
> recommendations on how to implement this? Would it be appropriate to create
> a new node under /sys/devices/platform/serial8250/tty/ttyS*?
> As mentioned earlier, our system is an RT-Linux system. As you say that
> using an RT kernel may not encounter this issue, are you implying that RT-Linux
> has priority inheritance logic?

I'm saying that the RT selection should cause you not to have those
larger variants in delays.  Try a newer kernel and see.

> However, the logic within work items isn't
> always protected by locks. Even if everything is under lock protection, when a
> work item starts executing and hasn't yet entered the lock, it can still be
> preempted by real-time tasks. In an RT-Linux system, such preemption of kworker
> by real-time tasks is more common compared to a standard kernel.

True, which is something that the rt changes should have addressed.
This sounds like an overall rt issue, not a serial port issue.  Have you
asked about this on the rt mailing list?

> > So you just bound ALL tty devices to the same cpu?  That feels very
> > wrong, how will that work with multiple devices on different interrupts
> > coming in on different cpus?
> > 
> > Why not just queue this up on the cpu that the irq happened on instead?
> 
> If possible, I will later add a node to separately configure each tty/ttyS*
> device. The approach I intend to use is to add this tty_flip_cpu node under
> /sys/devices/platform/serial8250/tty/ttyS*. Is it OK?
> Based on our project, the DMA RX complete events for tty are almost evenly
> distributed across each core.

This should come from a hardware definition somewhere in your DT, not as
a user-selectable option.  And again, why not just tie it to the cpu
where the irq came from automatically?

> I believe it is necessary to increase the
> flexibility of the queue_work to be located on a specific CPU, as it is difficult
> to predict whether a core is running many long-duration real-time tasks based on
> the driver code or low-level logic strategy.

That's a system design issue, not a kernel issue :)

thanks,

greg k-h
