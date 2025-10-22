Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15A35B120;
	Wed, 22 Oct 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152351; cv=none; b=KaYcKs8XJ8g0c9PUe+z2hZfsjn2AkMNzZd4LRoVyG1rCHXQaymdH9uE3j0e149NDEdegJJcLT6VQRaSk55I/Bh0Ngc6i8I5rVjY9m82uf/AYdOT9QMndFvLgimeWdZ9vRun7pqZ9JxFqhwIe55kBOz7+F0oLfNRaQ7aegZrYKS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152351; c=relaxed/simple;
	bh=DSC879bFyWmLTMOWd8I8iBVgQPU4kWfn8MtaUuS15aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJJVU+suJSor5w+nozqo8WWkgSVEPawHyeD7CUWPyI+U//F+a8qD9qqo5aMuLTwuy1CFMgVNVinnBkNW9O6mn3YvwBkkvZthGb9A8+zXl40tDroyeQk1QI2F3LG8k7v9zbLKV/mJZ/AuLAEj8piSMdAX6WGmh196Re01AnWBZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BdVWqzMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BdVWqzMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B08FC4CEE7;
	Wed, 22 Oct 2025 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761152351;
	bh=DSC879bFyWmLTMOWd8I8iBVgQPU4kWfn8MtaUuS15aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BdVWqzMYLcVVHi8iTcrdbYWRapBG++IhnnZCtVTks1iC1U/rqDNeQiDf5CvSzjW3v
	 dCpNqgyaKSa/EuuFJIpCMHAkPr+++SK3cS7qEDjFyVcRxJUfv8VmUXTAWp00u/StAC
	 M5g/nsIrLJIUSoP2HLu/gbkFtAHN2Ewu5skxCeQ4=
Date: Wed, 22 Oct 2025 18:59:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: hch@infradead.org, jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on
 specific cpu
Message-ID: <2025102206-gainfully-chariot-407d@gregkh>
References: <2025102107-player-baggie-37fc@gregkh>
 <20251022144707.160181-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022144707.160181-1-jackzxcui1989@163.com>

On Wed, Oct 22, 2025 at 10:47:07PM +0800, Xin Zhao wrote:
> > This should come from a hardware definition somewhere in your DT, not as
> > a user-selectable option.  And again, why not just tie it to the cpu
> > where the irq came from automatically?
> 
> I don't think binding the work task to the CPU that handles the interrupt is feasible,
> because, in practice, this hardware interrupt is evenly distributed across all cores
> in our system.

I suggest fixing that, that's ripe for lots of latency as cores hit
cache misses and the like.  Learn from the networking people, you want
the cpu that handled the irq to handle the data processing too.  They
learned that years ago.

> Moreover, from the ftrace data we captured, the IRQ handler thread that
> wakes up the kworker threads in RT-Linux is also distributed across various CPUs by
> default.

Again, don't do that, bind things to cpus that previously handled the
data if at all possible to avoid these latencies.  That's what you are
trying to do here anyway, so you kind of have proof of that being a
viable solution :)

good luck!

greg k-h
