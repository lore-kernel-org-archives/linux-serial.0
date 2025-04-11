Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F4238C28;
	Fri, 11 Apr 2025 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370885; cv=none; b=aqC8bK40iO/N7BQ2vVHobwQXM34w9zBgJCjjGQn1IPbR9+9nYoKTDLkUfWMnEdYYzWSJGepbZX07FSPt1Do1D9fPvC0F+cFjeV12GpuInumSNPqlECtaHYaUsiu1q5z8kIiKORI8m1HaSj9JKbEbdySYPWFf+DD7Wt+ynrjXR+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370885; c=relaxed/simple;
	bh=PMrFqn0nyRfC8J2rw/XDvWMq3cWijSqwq93QHGwq52Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqP9ztbXhcXZp+tE+5u62QHycq5UFjcCisnjWQKgGplqKZr9CmKhhfxDPj4n2Lp36yydLxzutAZpaMuFfD4GcsNpD99zSa9ukZW5wcy7lqg70bOTbPNtCD9kGdt2fizq13DpCk3z30KXIP7xNR2cv+MwleCxGFcYvWQiIneMUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bsinzBPU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bsinzBPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52D5C4CEE2;
	Fri, 11 Apr 2025 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744370884;
	bh=PMrFqn0nyRfC8J2rw/XDvWMq3cWijSqwq93QHGwq52Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsinzBPU8iguOMknJQMlok18HB1bg5kRgHrvNRc5x5Jz1YLymK5Gb0zw5xKwQwC5W
	 KUvbk2FTKUGLoAjIz7FHH2fIGqskU8HmoYFkr/ZFUKDGSbV+bjk73gWtrG2aa6XvAd
	 Q+TerFksEZDcfZrrIQYWqmE6i/Xuf+/a9bHL8vNI=
Date: Fri, 11 Apr 2025 13:28:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: jirislaby@kernel.org, tglx@linutronix.de, hdegoede@redhat.com,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: vt: keyboard: Fix uninitialized variables in
 vt_do_kdgkb_ioctl
Message-ID: <2025041107-postbox-bonanza-2049@gregkh>
References: <20250411111548.31399-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411111548.31399-1-purvayeshi550@gmail.com>

On Fri, Apr 11, 2025 at 04:45:48PM +0530, Purva Yeshi wrote:
> Fix Smatch-detected issue:
> 
> drivers/tty/vt/keyboard.c:2106 vt_do_kdgkb_ioctl() error:
> uninitialized symbol 'kbs'.
> drivers/tty/vt/keyboard.c:2108 vt_do_kdgkb_ioctl() error:
> uninitialized symbol 'ret'.
> 
> Fix uninitialized variable warnings reported by Smatch in
> vt_do_kdgkb_ioctl(). The variables kbs and ret were used in the kfree
> and return statements without guaranteed initialization paths, leading to
> potential undefined behavior or false positives during static analysis.
> 
> Initialize char *kbs to NULL and int ret to -EINVAL at declaration.
> This ensures safe use of kfree(kbs) and return ret regardless of control
> flow. Also add a default case in the switch to preserve fallback behavior.

When you say "also" in a patch, that is a HUGE flag that this should be
split up into a separate change.  Please do that here, don't mix changes
that have nothing to do with each other together into one.

Also, why isn't the compilers noticing that these are uninitialized
variables?  Are you sure the warning is correct?

thanks,

greg k-h
