Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E71F4187;
	Fri, 11 Apr 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380949; cv=none; b=eoTim6T41CjWQvrwrSSXIe+8x9Df9tmWybwHNEQZM8y0furdFRa1hUl/ZfmdNAPaL3ehr0E1iqYPBx07BlQx4XCKh0QeApZPSbMx0ITFaDVolBlPURT7fG3Hae8hIrJjQ2LN7y9FUgKkLlQCkzUYeANnJM0N7heRgc2Ngx7vYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380949; c=relaxed/simple;
	bh=EaEKx/nxBpBM2aYDw8fa2VbXbaxB77+eijX3v0Gitn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebyVzTlmFeaqbdqplh++eCjg6LHC0Tkaa9fryv1UszHC2tPtSYENzQYyXBje+y7u6FKW4qtxQSDPUFjsBzWx7Fko7Fv6c3Wx02IvfTL/ad5uAm+N7wkwcVl5jv42AXE8N8QewPGWfFSRTvEwrvGOBVdEOgaL3fNqnQXEy9s3RAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xwrgmfP1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xwrgmfP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7911C4CEE7;
	Fri, 11 Apr 2025 14:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744380948;
	bh=EaEKx/nxBpBM2aYDw8fa2VbXbaxB77+eijX3v0Gitn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xwrgmfP1mQZVHl/nCatEZe4vjpNbI8wax7+n+jKF2RMFTh/2FrPSHd3GHghF0OhiT
	 CNrtPmrxA1/iY1KQa5v1N9ExjwuP3okyc5XLAL8C99db9AXrfgIdLUq0FtTbgKMYch
	 mBniP9UDmC8UPnvYrgiZtnc5X9DDmc/Q9ETcsSkM=
Date: Fri, 11 Apr 2025 16:15:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: jirislaby@kernel.org, tglx@linutronix.de, hdegoede@redhat.com,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: vt: keyboard: Fix uninitialized variables in
 vt_do_kdgkb_ioctl
Message-ID: <2025041145-plating-unlined-edf1@gregkh>
References: <20250411111548.31399-1-purvayeshi550@gmail.com>
 <2025041107-postbox-bonanza-2049@gregkh>
 <641cb805-b279-48af-a3a9-492a8738c841@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641cb805-b279-48af-a3a9-492a8738c841@gmail.com>

On Fri, Apr 11, 2025 at 06:48:13PM +0530, Purva Yeshi wrote:
> On 11/04/25 16:58, Greg KH wrote:
> > On Fri, Apr 11, 2025 at 04:45:48PM +0530, Purva Yeshi wrote:
> > > Fix Smatch-detected issue:
> > > 
> > > drivers/tty/vt/keyboard.c:2106 vt_do_kdgkb_ioctl() error:
> > > uninitialized symbol 'kbs'.
> > > drivers/tty/vt/keyboard.c:2108 vt_do_kdgkb_ioctl() error:
> > > uninitialized symbol 'ret'.
> > > 
> > > Fix uninitialized variable warnings reported by Smatch in
> > > vt_do_kdgkb_ioctl(). The variables kbs and ret were used in the kfree
> > > and return statements without guaranteed initialization paths, leading to
> > > potential undefined behavior or false positives during static analysis.
> > > 
> > > Initialize char *kbs to NULL and int ret to -EINVAL at declaration.
> > > This ensures safe use of kfree(kbs) and return ret regardless of control
> > > flow. Also add a default case in the switch to preserve fallback behavior.
> > 
> > When you say "also" in a patch, that is a HUGE flag that this should be
> > split up into a separate change.  Please do that here, don't mix changes
> > that have nothing to do with each other together into one.
> > 
> > Also, why isn't the compilers noticing that these are uninitialized
> > variables?  Are you sure the warning is correct?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Thank you for the feedback.
> 
> Got it. I will remove the default case from this patch and resend it with
> only the fix for the uninitialized variables.
> 
> Yes, Smatch reports uninitialized variable warnings for kbs and ret because,
> in the function vt_do_kdgkb_ioctl(), both variables are used outside the
> switch block but are only initialized conditionally within certain case
> branches. If the cmd value passed to the function does not match any of the
> explicitly handled cases (KDGKBSENT or KDSKBSENT), then the switch body is
> skipped entirely. In such a scenario, kbs remains uninitialized, yet
> kfree(kbs) is still called, which could result in undefined behavior.

But can that ever really happen?  And if so, how have we never noticed
that before?  And why doesn't gcc/clang warn of this?

> Similarly, ret is returned at the end of the function even though it may not
> have been assigned a value, leading to unpredictable results.

Again, are you sure that can happen?  Please walk through the code paths
to verify this.

thanks,

greg k-h
