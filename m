Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625DF22C6C5;
	Sun,  8 Dec 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733664644; cv=none; b=cQGPnpeC1KmGR10LqQh4FiJ9MVefRAzN5tws2tGNU35WakKKRF9xbq0RFKoP0WhoHPeP9S7NSODYPA33NH5nyVpgFKov8wM0rcWuiVK3HgNClA04ZagkXzuUBF6WGlOj7jRgLFoDYyA47bN32K+P8nKJhZZJvqbKGdBJyg5olHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733664644; c=relaxed/simple;
	bh=S6/kpuYlooMtNVNYvTvV8cbANzdpAUkz10M7ftx/R8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eswof2yndmNXsJ9huQF3pFqZugtjZ5fvsZCaOo0NP43px7NaAWZOGzGc2vRM+FDEM7kVUqi5lnmyZ6SOWJdrJ7sx/VpMmW7CB0s5OpDpTxAyBxN7IOu6X/fxIBKxsCDLGX6zL/j8NZcDUztsWRW6bI2jXNjLvXrUFiv7gUNb6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Suk1pKkT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Suk1pKkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822DCC4CED2;
	Sun,  8 Dec 2024 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733664643;
	bh=S6/kpuYlooMtNVNYvTvV8cbANzdpAUkz10M7ftx/R8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Suk1pKkTj0NLd+jhKOyRMLPx1nqJFs4p3+q3QaKd/GgLUwCm+ptacr0Ru2aP2Eb5e
	 cDYD/yvdJ7CSWmnw8RmsILVaIIc+8jBhsY05lHXifenWqb6FwKMK9YsG7XEy0w7UM5
	 2vRKZ3CvZQneJ0sJHJ6q/VIVKGk+T2a4XdYwWKWQ=
Date: Sun, 8 Dec 2024 14:30:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used
 as a console device
Message-ID: <2024120803-pending-handbag-4641@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <3758619.RUnXabflUD@nerdopolis2>
 <2024120700-expansion-pretense-b6e9@gregkh>
 <3271291.vfdyTQepKt@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3271291.vfdyTQepKt@nerdopolis2>

On Sun, Dec 08, 2024 at 12:25:12AM -0500, nerdopolis wrote:
> On Saturday, December 7, 2024 1:50:50 AM EST Greg Kroah-Hartman wrote:
> > On Fri, Dec 06, 2024 at 12:36:21PM -0500, n3rdopolis wrote:
> > > On Wednesday, December 4, 2024 2:37:55 PM EST n3rdopolis wrote:
> > > > On Wednesday, December 4, 2024 1:06:50 PM EST Greg Kroah-Hartman wrote:
> > > > > On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> > > > > > On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > > > > > > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > > > > > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > > > > > > initialized by console_initcall() and selected as a possible console
> > > > > > > > device.
> > > > > > > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > > > > > > 
> > > > > > > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > > > > > > real name here, sorry.  I can't do anything with these (including
> > > > > > > reviewing them), until that happens.
> > > > > > > 
> > > > > > Oh, I thought that I didn't need a real name
> > > > > > 
> > > > > > I found a recent thread that seems like it suggests that I thought
> > > > > > https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> > > > > > https://drewdevault.com/2023/10/31/On-real-names.html[2]
> > > > > > Or do I need to wait for that change to the guideline be merged?
> > > > > 
> > > > > That change has been merged a long time ago, but as far as I can tell,
> > > > > this signed-off-by you used here does not meet this category.
> > > > > 
> > > > Oh, what would it take to meet that category? I've been using this nick to
> > > > contribute to other projects, and it matches my GitHub name, and FreeDesktop
> > > > GitLab name
> > > > 
> > > What if I made the signed-off-by (and committer name) this email address? would
> > > that work?
> > 
> > Do you sign documents with your bank with an email address in the line
> > that says "name"?
> > 
> No, I guess not, the no pseudonym requirement was dropped, but if my nickname
> doesn't work If I really have to, can it just be my first name, instead of my
> full name if it comes down to it?

No.
