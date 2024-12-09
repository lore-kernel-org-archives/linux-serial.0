Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083514E2CF;
	Mon,  9 Dec 2024 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726141; cv=none; b=h4CpEAbmhMsZXrPMkO3NPcfop0oSvEP/N6W8vfOEjDPfDSLjftwckgKqKByZkgGfVJie3/l3IXrXvs+VRoWBc/Dr5WPD4W2qnJnd6RvGcu16BYf8cd+HWrGaqAhDoz3jJTc9UAOV6AfddKeNtxVqwNxMBOLxW1XBLFaKYvSCjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726141; c=relaxed/simple;
	bh=Fo/LkVH1Yo14m6nLHr8c+8Sd94oGLfup0CqjT0GlZcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azPbINg/IPxp4fw3jutiMfbsiryCRumrWeEhDfTmir4qn0KE5TbZ8dS/f08gHwQdLi6rQaahKRCyOtxyDBEoa3ZZXNGYHOTrpeCAx3YFJg8H60lpTMHKThmmdQmxbiv36czqlvAgFLijHV8QZj9p12C7ytgsFONLKTPyMD1phMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LGqWF2l9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LGqWF2l9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756DDC4CED1;
	Mon,  9 Dec 2024 06:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733726141;
	bh=Fo/LkVH1Yo14m6nLHr8c+8Sd94oGLfup0CqjT0GlZcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGqWF2l92V7qZPc/PWF+zMU3lEJC/RlWHhbRCphvw4u2WIxZhVnWrJzwdDMfabQ7p
	 8FH5wntBBShASBOQllbmrlS41fmNT8J9ND2o4AJWGEUC01WhUT1kbbxJQm/JzPZWUq
	 RhdOdN8vgvX7lhm9suc9ky72VG3bOkvJBPjmbp6Q=
Date: Mon, 9 Dec 2024 07:35:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: n3rdopolis <bluescreen_avenger@verizon.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used
 as a console device
Message-ID: <2024120911-daylight-feminist-a1e1@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <3271291.vfdyTQepKt@nerdopolis2>
 <2024120803-pending-handbag-4641@gregkh>
 <2959951.SvYEEZNnvj@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2959951.SvYEEZNnvj@nerdopolis2>

On Sun, Dec 08, 2024 at 09:16:28PM -0500, n3rdopolis wrote:
> On Sunday, December 8, 2024 8:30:08 AM EST Greg Kroah-Hartman wrote:
> > On Sun, Dec 08, 2024 at 12:25:12AM -0500, nerdopolis wrote:
> > > On Saturday, December 7, 2024 1:50:50 AM EST Greg Kroah-Hartman wrote:
> > > > On Fri, Dec 06, 2024 at 12:36:21PM -0500, n3rdopolis wrote:
> > > > > On Wednesday, December 4, 2024 2:37:55 PM EST n3rdopolis wrote:
> > > > > > On Wednesday, December 4, 2024 1:06:50 PM EST Greg Kroah-Hartman wrote:
> > > > > > > On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> > > > > > > > On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > > > > > > > > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > > > > > > > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > > > > > > > > initialized by console_initcall() and selected as a possible console
> > > > > > > > > > device.
> > > > > > > > > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > > > > > > > > 
> > > > > > > > > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > > > > > > > > real name here, sorry.  I can't do anything with these (including
> > > > > > > > > reviewing them), until that happens.
> > > > > > > > > 
> > > > > > > > Oh, I thought that I didn't need a real name
> > > > > > > > 
> > > > > > > > I found a recent thread that seems like it suggests that I thought
> > > > > > > > https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> > > > > > > > https://drewdevault.com/2023/10/31/On-real-names.html[2]
> > > > > > > > Or do I need to wait for that change to the guideline be merged?
> > > > > > > 
> > > > > > > That change has been merged a long time ago, but as far as I can tell,
> > > > > > > this signed-off-by you used here does not meet this category.
> > > > > > > 
> > > > > > Oh, what would it take to meet that category? I've been using this nick to
> > > > > > contribute to other projects, and it matches my GitHub name, and FreeDesktop
> > > > > > GitLab name
> > > > > > 
> > > > > What if I made the signed-off-by (and committer name) this email address? would
> > > > > that work?
> > > > 
> > > > Do you sign documents with your bank with an email address in the line
> > > > that says "name"?
> > > > 
> > > No, I guess not, the no pseudonym requirement was dropped, but if my nickname
> > > doesn't work If I really have to, can it just be my first name, instead of my
> > > full name if it comes down to it?
> > 
> > No.
> > 
> 
> Can I do first name, last initial? Or does it have to be a full name?

Honestly, based on this long discussion, I really don't think we can
take any contribution from you without having someone else verify that
the the name you use here is correct.  Please work with the kernel.org
ring-of-trust to get a valid signature added to it and then I'll be glad
to reconsider.

And note, I'm not singling you out at all, we have recently had to do
this for many new contributors.

thanks,

greg k-h
