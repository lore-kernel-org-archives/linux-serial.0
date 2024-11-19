Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBEA1C07C2;
	Tue, 19 Nov 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009507; cv=none; b=qB1jP5f6umsDlkvXyBEaW6LwElXuUBrHEyolZFmnf72jgtl0jtT4NxCkWQd88L9fEgiVKbEq6B3j+YgmAm+hYw7XNDNjimoziVwZN2/VVDb5/zdT+B1JbX3zq1PgmzR3SXIOwl2w27Z3L9TMLi1PJgeaZ6h3pa+fair9H0p4TG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009507; c=relaxed/simple;
	bh=gdJ4SG6Z6DmoaBcbOqpOl0mtJKOHDhBL82DMvMF1PjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFtzBNnR1NGkq0M+HMN6yy9dh8/wThtFWmvddUufN9cEkqynFLovabBZoZoMTO+4ek4MoWfAS/+N7cTLuFG9chl5uhmEVqSDEBGZZK3r/onC8xr3rWxo8XJug50DjYDSIuLk9+FzHdMRhzj3+vMvSfV7GrGp5t1hN09M8RxsJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBpBH2Up; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBpBH2Up"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A059C4CECF;
	Tue, 19 Nov 2024 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732009506;
	bh=gdJ4SG6Z6DmoaBcbOqpOl0mtJKOHDhBL82DMvMF1PjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBpBH2Upo7HOxmVRl3+OFinc8pHgw1ngdTjTZy0CG0iiJIOrXXuGRk45FT1XMS3tZ
	 U5j/Fq974NnK3IprCDJgSghmyrEkFMUFMH57rFVBVSM8ALoW4HqMPhkG0nzCaos+CQ
	 IMPFlMY3fK0RbdpJYE7s4Hx4gQJlGps1NqN0Usvg=
Date: Tue, 19 Nov 2024 10:30:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Juefei Pu <juefei.pu@email.ucr.edu>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: BUG: KASAN: slab-use-after-free Read in gsm_dlci_config
Message-ID: <2024111921-launch-countdown-a813@gregkh>
References: <CANikGpf8mkdZ+MVjLWoBEg0XZOBmwHVGaZVKX6eBSst+a2-Y8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANikGpf8mkdZ+MVjLWoBEg0XZOBmwHVGaZVKX6eBSst+a2-Y8w@mail.gmail.com>

On Mon, Nov 18, 2024 at 09:22:54PM -0800, Juefei Pu wrote:
> Hello,
> We found the following issue using syzkaller on Linux v6.11.
> In function `gsm_dlci_config`, a use-after-free on object `dlci` has
> been detected.
> Since the reproducer takes around 10 seconds to trigger the bug, it
> might be a race condition one.

There are so many race conditions and other known-broken things in this
driver, please see the mailing list archives for the details.  It's well
documented that no one should be using this code unless you have the
hardware and know how to lock down your system for it.

That being said, patches are gladly accepted to resolve these issues,
please send them as you have a working reproducer!

thanks,

greg k-h
