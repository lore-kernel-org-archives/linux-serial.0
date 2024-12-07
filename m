Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608C2581;
	Sat,  7 Dec 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733554254; cv=none; b=oDFMjqLtUhmpABYiHB/RW76Yajji42atXcXFipPZVVep92UlXmT+9HoRIsF7ATSL3QlMIJnRs8F+4yk+c7fnzDTS1i3VszVP3NFmrgRAORhftXb/l7NEqS9dcWvB5rIFQeE7eUk6f+YtZjHvpyXrv3Jutt+g5KLrgKi8No/s3T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733554254; c=relaxed/simple;
	bh=kBodLiWnDz6YMe+dckTErs6BiwvhICgio0VYQl4n9pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNpeo5mBDyoczl42L3fD6HUPi/B6pHKgenatQMmq/yJRGuZMCxvvwBSyfmTqmfbLmuhlqP9Zz89yLWErVLqMOzJk2cXPy3ShkgYJAs/gZ8HCudRBWVdTsJATdJ0w4zoVk/LLyO5XbjzEidRpn+CqOxg2gQU8KggP9BMZDWP8baw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e+dNS5VE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e+dNS5VE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9697CC4CECD;
	Sat,  7 Dec 2024 06:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733554254;
	bh=kBodLiWnDz6YMe+dckTErs6BiwvhICgio0VYQl4n9pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+dNS5VE9pAeW959FC8VZz2GTZ4Uo+B3TJyHNYky4DY9GXsK9HcXD8p9pmD2ADAZz
	 pNI11H45Y1iSUd7CRKiPoVsCc53D7+NltZJCHEXlEeDx69aY9dLtJ4WGADKOd/mZAL
	 KQnxvDAsfktkUDIa5PRwWZwD0W6FNp629zcfq8FA=
Date: Sat, 7 Dec 2024 07:50:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: n3rdopolis <bluescreen_avenger@verizon.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used
 as a console device
Message-ID: <2024120700-expansion-pretense-b6e9@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <2024120408-moneyless-stood-cda2@gregkh>
 <6622246.K2JlShyGXD@nerdopolis2>
 <3758619.RUnXabflUD@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3758619.RUnXabflUD@nerdopolis2>

On Fri, Dec 06, 2024 at 12:36:21PM -0500, n3rdopolis wrote:
> On Wednesday, December 4, 2024 2:37:55 PM EST n3rdopolis wrote:
> > On Wednesday, December 4, 2024 1:06:50 PM EST Greg Kroah-Hartman wrote:
> > > On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> > > > On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > > > > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > > > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > > > > initialized by console_initcall() and selected as a possible console
> > > > > > device.
> > > > > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > > > > 
> > > > > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > > > > real name here, sorry.  I can't do anything with these (including
> > > > > reviewing them), until that happens.
> > > > > 
> > > > Oh, I thought that I didn't need a real name
> > > > 
> > > > I found a recent thread that seems like it suggests that I thought
> > > > https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> > > > https://drewdevault.com/2023/10/31/On-real-names.html[2]
> > > > Or do I need to wait for that change to the guideline be merged?
> > > 
> > > That change has been merged a long time ago, but as far as I can tell,
> > > this signed-off-by you used here does not meet this category.
> > > 
> > Oh, what would it take to meet that category? I've been using this nick to
> > contribute to other projects, and it matches my GitHub name, and FreeDesktop
> > GitLab name
> > 
> What if I made the signed-off-by (and committer name) this email address? would
> that work?

Do you sign documents with your bank with an email address in the line
that says "name"?
