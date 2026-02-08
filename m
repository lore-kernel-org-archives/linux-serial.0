Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61152874F5;
	Sun,  8 Feb 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571542; cv=none; b=nZzjVTnA+6uXwG7LxuOBj3MX9GXDkiETNc8LkavJ0czByo3pJrpHhyG9fdk2+M5GVK3GaSmScZlhcSWVlSEDaAo02m6hwmcKnjV1S9v123F6aib8MJGES4QJ/rKEl97le0Ml1juJ0+vUCXSYlF4C07ASekaBinI4ox5WEx4V5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571542; c=relaxed/simple;
	bh=QjxBm0Vi2AzC3VXESPNLQQrvvMZwNydF3PrHmlltDQU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fMYWDCROulIbYezFKXuOOX1u1o8Sji+JL5k1Tgnd1QtLoa3pbo7hH5my9OScsWxojkEmdr36/nfmA7+UIiu8n4VydsFndXI6Bp0CcLHu0slLaf2nNzESvl0RayhII6QUKgGtIDQm0WYQrAQpfTcCoNaacov0C5XzBd1gy92G9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipgovp8j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipgovp8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F77C4CEF7;
	Sun,  8 Feb 2026 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770571541;
	bh=QjxBm0Vi2AzC3VXESPNLQQrvvMZwNydF3PrHmlltDQU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Ipgovp8jb6cZup+v2ODyf8gjQAeug/yWeYTFS1CsPnGqKBPshw/PMM8xrFW0WEw0w
	 SHv4wL+45IJkHygRNdPqvyF7CSTMgQ3gM/yiSMcyMuURihs0oEIncNJni2FQXibFXz
	 leuIiJ5OGzNuw7XgDgY+ZgOpuo1qujkccQAdSpLJksvQmal+9Hfi9fZgUMVlr80n7U
	 IzV0YCmI1n/dIrXr0JCzN1y6kUY99avq/7QSZaJGoVb7ZY4QBevv54jNWT/dM57MX/
	 IxbDEIxvo+exQq/UmMVNPJEfNbS6jV+jnjqvZGJxxbgYv0xH4ExsNuJ+9p4JRobpj8
	 pp3SK0lKm00AQ==
Date: Sun, 8 Feb 2026 18:25:38 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
cc: duoming@zju.edu.cn, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org, dsterba@suse.com, jirislaby@kernel.org, 
    kuba@kernel.org, alexander.deucher@amd.com, akpm@linux-foundation.org, 
    pkshih@realtek.com, tglx@kernel.org, mingo@kernel.org
Subject: Re: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during
 device removal
In-Reply-To: <2026020859-caretaker-duckbill-0fb3@gregkh>
Message-ID: <p16239r9-692o-859r-6006-7o611r2rn2qs@xreary.bet>
References: <20260208062538.29608-1-duoming@zju.edu.cn> <2026020828-unretired-mannish-8465@gregkh> <41b47e38.6ddb4.19c3ccb8e4d.Coremail.duoming@zju.edu.cn> <2026020859-caretaker-duckbill-0fb3@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 8 Feb 2026, Greg KH wrote:

> > I don't have the real hardware. In order to reproduce the bug, I simulate 
> > the IPWireless PCMCIA card in the qemu by allocating and configuring the 
> > necessary resources(I/O ports, memory regions, interrupts and so on) to
> > correspond with the hardware expected by the driver in the initialization 
> > code of the virtual device.
> 
> I wonder if this device even is still around, given that pcmcia is all
> but dead for a very long time.

I doubt that this device is still around anywhere where reasonably new 
kernels (including LTS) would matter.

I don't think I've seen this device (which was back then donated to me by 
T-Mobile CZ in order to get it supported in Linux, and I am not sure how 
much global adoption it got afterwards) for, let's say, past 15 years :)

I think (let's see what David, ho took the maintainership over for me 
afterwards, has to say) we'd better deprecate and drop the whole thing, 
rather than trying to pretend that it's still actively being taken care 
of.

-- 
Jiri Kosina
SUSE Labs

