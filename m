Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088D25A655;
	Fri, 16 Jan 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569866; cv=none; b=lYZy1rFBrc5Wms6w8itgRnfOgi67gPBPt08mO2LFPZ5HG/u6OFByCopMb/8JFV3hqBn6yOfdQyu2ezxYbNqmYu7WDQcYM9tRhR10AOHLQx7CI4gyWz3GSTtMiT5fLroU3d8dK48od+P4JNJZNnfwhQcqxj72gAErGFqniFminv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569866; c=relaxed/simple;
	bh=pqqAQ9RTqrsczyech2YP7xs9nKnEjTUeLL3XnvUcXjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyolTXhNpd8g0ybaffcMabHELBdC6t6GtAuiKEm3pC9vRgSp37KuMDC1dzSGFS3myPWd2mtemOwpGdJ2Tv1Uy+SlGFyfXYcMMEOoSrTYxCzW+0Sp4hBT3JQm7zW3mhFWU/oQojiqiEIlj+UopfOCAToSrA7lKMSSu2GvxnXTyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yzNaM9ce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yzNaM9ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E972C116C6;
	Fri, 16 Jan 2026 13:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768569865;
	bh=pqqAQ9RTqrsczyech2YP7xs9nKnEjTUeLL3XnvUcXjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yzNaM9ceMCrhonRGcAfYednwNOaNaTV9nkhmLL1sAXBzD7Z6/hADwW15/2f0OPpMA
	 m2tmBrx9Ev7ZrPo2/Ujr1C/taE9T+miQKyRffQwtwR0pE9nx0f0GzbBc8rGPAVXSSU
	 hAdfMWYH9SGkCHrWZ5Pl6A5BZPCckBWSYmBqgOSc=
Date: Fri, 16 Jan 2026 14:24:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, tj@kernel.org, hch@infradead.org
Subject: Re: [PATCH v8] tty: tty_port: add workqueue to flip TTY buffer
Message-ID: <2026011615-luxury-hunchback-1b12@gregkh>
References: <20251223034836.2625547-1-jackzxcui1989@163.com>
 <20251230090341.853655-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230090341.853655-1-jackzxcui1989@163.com>

On Tue, Dec 30, 2025 at 05:03:41PM +0800, Xin Zhao wrote:
> Hi all,
> 
> On Tue, 23 Dec 2025 11:48:36 +0800 Xin Zhao <jackzxcui1989@163.com> wrote:
> > On the embedded platform, certain critical data, such as IMU data, is
> > transmitted through UART. The tty_flip_buffer_push() interface in the TTY
> > layer uses system_dfl_wq to handle the flipping of the TTY buffer.
> > Although the unbound workqueue can create new threads on demand and wake
> > up the kworker thread on an idle CPU, it may be preempted by real-time
> > tasks or other high-prio tasks.
> > 
> > flush_to_ldisc() needs to wake up the relevant data handle thread. When
> > executing __wake_up_common_lock(), it calls spin_lock_irqsave(), which
> > does not disable preemption but disables migration in RT-Linux. This
> > prevents the kworker thread from being migrated to other cores by CPU's
> > balancing logic, resulting in long delays. The call trace is as follows:
> > 
> > ...
> 
> 
> Are there any other changes needed before the patch is merged?
> 
> Jiri has reviewed the patch, and I have made the modifications. :)

I need Jiri to ack it :)

thanks,

greg k-h
