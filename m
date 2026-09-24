Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03963CD8BD
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260645; cv=none; b=D/OmZbFPp31C061LaKIp/TeQ9aogwawbHOLBYXPAEN13tTsTLYBk09mXipkqNlke39M34dwmB33irlL5kOGWBRZFNGvA+ybfT1xvJjY5PmA9D+PMS622ISdmtdoVdfVjVbRPVCqzyzfv3bseAuqid7wRhlP317q5yND7J8JQzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260645; c=relaxed/simple;
	bh=QK7TM2CMRVADNGJIas84aaO2yYb6DcMJScMPZg6rOM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7Rp8VwAFCDq8TWxyHo0onm0TGK7uS7EMCavqX2OO1e/65KC2bi9MFn8UNH/ftn6/b+Dnlhbm/bit8DfYWIWtANHgSW0BrrK8XNxjwJjBA0xy0rQnsP5wos0IkxLeRSA/UeggFznBhCuMf+37uyW19varsmxPrqTdsC11ct2n/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pgTPPLHH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pgTPPLHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E8B1F000FF;
	Thu, 24 Sep 2026 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790260644;
	bh=esvXTJJ9TY0pHzxj8s15QjegHkyI0T//GuPDQQa9QRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pgTPPLHHhf4mhJm3AvKu9OxEVDBp9AXiZUoHKf5fcngVycXGalU9bOBm0NDXC4o7g
	 on18YGIKXlzwzpUmUQnd1kcPRju5VaT/Tn4l8QAmqqmFE3h+koxQr8RPhLDzXS0wAp
	 IHopw+ZT52Bsc0HRjJ4b7xFNDUctoswixsyljQhM=
Date: Thu, 24 Sep 2026 16:37:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cuigaosheng <cuigaosheng1@huawei.com>
Cc: sashiko-bot@kernel.org, lujialin4@huawei.com, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, kmehltretter@gmail.com,
	john.ogness@linutronix.de, andriy.shevchenko@linux.intel.com,
	tony@atomide.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH -next] serial: core: fix NULL/dangling port_dev on failed
 re-register
Message-ID: <2026092440-wobbling-gecko-210d@gregkh>
References: <20260914135154.3260303-1-cuigaosheng1@huawei.com>
 <2026092332-divisible-hypocrite-d223@gregkh>
 <d3cb66b5-5b2a-ee57-8eb6-4e66d7e575be@huawei.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cb66b5-5b2a-ee57-8eb6-4e66d7e575be@huawei.com>

On Thu, Sep 24, 2026 at 09:28:23PM +0800, cuigaosheng wrote:
> Thanks for the review, I have submitted v2 of the patch.

Great, but please do not top-post, you just lost all relevant
information :(

> I have tested on x86_64 linux-next (7.2.0-rc7) with KASAN, failslab and
> fault injection debugfs enabled;
> 
> It takes two unbind rounds to reproduce since
> serial8250_unregister_port() first unregisters and then re-registers
> the port: the fault injection must hit the re-registration to plant
> the stale port_dev, and only the next unbind dereferences it.

What do you mean by this?  What fault injection and why do we care about
that if it can never hit in real life?

> The
> reproducer is a small userspace program that loops over sysfs
> bind/unbind of serial8250 and scans /proc/self/fail-nth from 1 to
> 6000, making the Nth slab allocation on the re-register path fail
> with -ENOMEM:

bind/unbind is not a normal operation that a user can do, and is for
debugging only.  So are you sure this is a real issue?

thanks,

greg k-h
