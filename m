Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FFD314A6B;
	Mon, 26 Jan 2026 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423449; cv=none; b=XRNAiGV+4MSKNmFdwuIBaPMI1s0SQKAyHUQBpjkR5tuj0VF4DnTg4h/UxYLd5JzK+3ACtuSeig/PVZjhnYabBot2ZygceZ8d1PlBRPx+zrF5NFIPG9dZBtmWz4XUr24xNNjHdbd9HZ4ZVpiwlGI49CFJPfOZWTBPwXtEjC2kdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423449; c=relaxed/simple;
	bh=DZpUj0XgjraMHp5fVE1GchTKj9SFKXHE6u8Z2fyXQEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CO5R1qpWQ0WRUJDkPG7EpXWdzPXV4jhoAZnOfqkAoMeK/uee/KGsVSHO56tzRC3YV5DQZy04DS96D6gsGO/IW+CgFhhqxOmypDyQjHGtfdGQMzEUaOfh6RkNzLb7xr/VBawiAEJoQjrNXjtV2n7sW75R9t6Qf+1JXFPkUe8Xmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=URyiRCs2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="URyiRCs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976A9C116C6;
	Mon, 26 Jan 2026 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769423448;
	bh=DZpUj0XgjraMHp5fVE1GchTKj9SFKXHE6u8Z2fyXQEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URyiRCs2RPsy/aq/sYKt0laQYAv+B6u0OtE7JdatU7mFbmvbWuBEbZ/vc9kPbjgsk
	 dOKGKDDU2CRUCnIAUER3s2Kn+STcecRHwPT9YldH9sn+owwoX/qb6H04o++xVNCWum
	 wRboxf/NMW9f1eKkWx5c6/HwMuG/ZuuP+gWq0+84=
Date: Mon, 26 Jan 2026 11:30:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Add enable module parameter
Message-ID: <2026012659-credit-suing-72ce@gregkh>
References: <20260126092234.713465-1-jfalempe@redhat.com>
 <2026012613-cotton-jellied-b67a@gregkh>
 <48be84fb-bee4-4a22-bde4-0d0c78282f80@redhat.com>
 <2026012648-vantage-mummified-2a43@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026012648-vantage-mummified-2a43@gregkh>

On Mon, Jan 26, 2026 at 11:20:21AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
> > On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
> > > On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
> > > > This allows to build the kernel with CONFIG_VT enabled, and choose
> > > > on the kernel command line to enable it or not.
> > > 
> > > This says what is happening, but not why?
> > > 
> > > > Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
> > > 
> > > Why are we using a 1990's technology for a new feature?  What is this
> > > going to allow to have happen?  Who needs/wants this?  Who will use it?
> > > For what?
> > 
> > The goal is to ease the transition to disable CONFIG_VT.
> > 
> > So if this is merged, you can boot without VT on any Linux distribution,
> > without rebuilding the kernel.
> 
> But that's a distro-specific thing, the distro should be enabling or
> disabling the option as it needs, it should not be a user-configurable
> boot-time selection option as userspace depends entirely on this either
> being there or not.  Why would you have a kernel with both options but
> userspace without that?

And to follow-up on this, if a distro wanted to support this, why not
just provide 2 different kernel images?  One with this enabled and one
without?  It's up to the distro to support such a thing, not the kernel
community, right?

thanks,

greg k-h
