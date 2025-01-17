Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621921FC7F4;
	Fri, 17 Jan 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114822; cv=none; b=rp3OPsIHqXMakHZp3U4lYNWW4q8qzaADeg5k7SR0GdvfOSeX8I7hczj5uSERe8Z92eOgP+3pRiekfLqCkHmApVSY/IsKo1YrhYDwN2mtOW4HHbv80NpBGjx+QbX/fTFPNGARbMhxK5UklQ0d0rGCSbD7t5hTVZl8zQW31i6EDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114822; c=relaxed/simple;
	bh=0zZXpSz47v+UqA3suZe4AcahION/UIHqd8eJ9H8osKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0Q5llW6sJ5MGUBCz5X5GPlrwNjSseNeAksiXsojsrmXdo1dqWrHb4oeLYVOT0oAWEYhh3v+WhG/yTZGCcwE0A4Sr2mM12Uh//ZKURdeR5T7HRg8FA+tW3T41SwU5awArFoe0bDSBKq6DoWSaAuyRUUkeFrL7gUVH+Vt1p8gc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ajsdKEAw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ajsdKEAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED40C4CEDD;
	Fri, 17 Jan 2025 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737114821;
	bh=0zZXpSz47v+UqA3suZe4AcahION/UIHqd8eJ9H8osKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajsdKEAwPRPkkWB1mEUBErOvZzj8UpNeTQ+16bPRWvSweJ6fiGiuslTg8e/fIKo6J
	 BRzdHbhq7y+nzRWtaxyC0EjFGPyJoo/knBT68AcddDt7jRBx4oJDRZETYYHInR8crA
	 Obgf+wAizimJ0uAr+RhYDximXOVpU/9Td8QuSZGM=
Date: Fri, 17 Jan 2025 12:53:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
Cc: Russell King <linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: amba-pl011: Implement nbcon console
Message-ID: <2025011743-rummage-civic-5c14@gregkh>
References: <20250115052749.3205675-1-fj6611ie@aa.jp.fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115052749.3205675-1-fj6611ie@aa.jp.fujitsu.com>

On Wed, Jan 15, 2025 at 05:27:48AM +0000, Toshiyuki Sato wrote:
> Implement the callbacks required for an NBCON console [0] on the 
> amba-pl011 console driver.
> 
> Referred to the NBCON implementation work for 8250 [1] and imx [2].
> 
> The normal-priority write_thread checks for console ownership
> each time a character is printed.
> write_atomic holds the console ownership until the entire string
> is printed.
> 
> UART register operations are protected from other contexts by 
> uart_port_lock, except for a final flush(nbcon_atomic_flush_unsafe) 
> on panic.
> 
> The patch has been verified to correctly handle the output and
> competition of messages with different priorities and flushing
> panic message to console after nmi panic using ARM64 QEMU and
> a physical machine(A64FX).
> 
> [0] https://lore.kernel.org/all/ZuRRTbapH0DCj334@pathway.suse.cz/
> [1] https://lore.kernel.org/all/20240913140538.221708-1-john.ogness@linutronix.de/T/
> [2] https://lore.kernel.org/linux-arm-kernel/20240913-serial-imx-nbcon-v3-1-4c627302335b@geanix.com/T/
> 
> Signed-off-by: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
> ---
> This patch removes the legacy console code.
> Please comment if you have any concerns.
> 
> I plan to try a stress test, referencing the work for 8250.
> https://lore.kernel.org/lkml/ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb/#t
> 
> Changes in v2:
> - Remove the module parameter used to switch between legacy and nbcon.
> - Remove codes for legacy console.
> - Fix build errors detected by the test robot.
> - based on 6.13-rc7

This fails to apply to my tty-next branch, which has 38 commits on top
of that release and at least one of them caused conflicts here.  Please
always work on the development tree you want to submit a patch to, OR
against linux-next, to help prevent merge issues like this.

thanks,

greg k-h
