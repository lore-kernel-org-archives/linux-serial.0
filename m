Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964271FBEB0;
	Sun,  7 Jun 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780844631; cv=none; b=Qpc/y1TRYrXqXdOno4PmFOLlcWzztYVDoN96TGovlkQ8lJXYH7CUPmp9QWAnJKiJzrA3JBm+MS70kgVHf+PoiiLZMn0/qmjZg6CYu4O60+7ZhziOttieTbCjLHj18lV1Ew/m4LjOkLUM2YYfhTml3m2ep8W58cLo7xamU77RYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780844631; c=relaxed/simple;
	bh=mzH4lF4OqOaF85ZWJH7ZQo/V9KOwqiUIxxWIUB6GUak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIIJ2nKyHgtRCdLEiuTjsZjD2ml8KESLax5sooQ5N5Iqk5KJczK98DvTY/tKRG5zljQvhKToDfVXPQPKwXUlcm64YWxkjB8gWMfQB/0zMM5J39fF82Mr/PrxEoZJN/h9+Pn5DFPyF9Z0pew151yXN4QYyDA/BxiZJwzoB8GvAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQMryM82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SQMryM82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B831F00893;
	Sun,  7 Jun 2026 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780844630;
	bh=oo04OIRZtXkObZy/+Vc6mFnRrFMMLzwwvpixdFTJazo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SQMryM82iivZGyiiKToPyKLJGgIdgEBAtlB8T47gj5wAiJC3fxaWLORc7LWrOePsP
	 5YhGnfz0Aa5UgrbzGZdD1JvyT7UkIeI4hsMUKCTpOzQ1cakRG7s3LVgFeM9lX2wVe8
	 pGoIQBsHccKsKbB9E1J11yLsWKTEhl2j3mliyKOo=
Date: Sun, 7 Jun 2026 16:57:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: bound the EA scan in gsm_control_rls()
Message-ID: <2026060721-herring-renewably-622b@gregkh>
References: <20260606170323.1522340-1-michael.bommarito@gmail.com>
 <2026060715-quarterly-dexterity-982c@gregkh>
 <CAJJ9bXw46vThuvzE-x73unRDm8n2ibq8+KF0+YO3gtipf1PNkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJJ9bXw46vThuvzE-x73unRDm8n2ibq8+KF0+YO3gtipf1PNkQ@mail.gmail.com>

On Sun, Jun 07, 2026 at 07:09:06AM -0400, Michael Bommarito wrote:
> On Sun, Jun 7, 2026 at 2:38 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > While it's fun to throw LLMs at this codebase, how was this actually
> > tested?  there are loads of documented "problems" with this file, but in
> > the real world, with real devices, it works fine so without testing of
> > the code with those devices, we have to be careful with changing
> > anything here.
> 
> Understood.  A few different notes for you to consider on this one:
> 
> 1. This is almost certainly the continuation / completion of
> 669609cea1d29, where two other sites were similarly addressed.  I
> think Daniel could answer if there was a reason why he didn't include
> this spot, but there's no evidence in the commit log or code comments
> otherwise.

It was perhaps missed, or not actually needed?  Again, how was this
tested?

> 2. The backport situation on 67c37756898a5 (the CAP_NET_ADMIN gate)
> looks complicated because it wasn't originally stable tagged and
> didn't get actioned by vendors for awhile, so I think reachability for
> unprivileged chaining in attacks is still high.

Distros/vendors know all about this line dicipline and they enable it at
their own risk.  There should not be any that has it enabled for normal
users, and I would not enabling it at all except for systems that
actually has this hardware.

> 3. I'm normally running tests on UML or qemu for every patch I submit.
> Sometimes, the AI assistance tag is more about the testing side of the
> patch than anything else.

That's fine, but where is the test?

> For example, for this patch, here's what Claude logged for the
> regression testing:
> 
> <CLAUDE>
>   repro/loopback.c stands up two real N_GSM0710 line disciplines in
> one UML kernel, wired back to back through a userspace byte relay — so
> the kernel runs both the
>   initiator and responder TS 27.010 state machines (not a
> userspace-faked peer like trigger.c). Phases:
> 
>   - A — DLCI0 + DLCI1 SABM/UA handshake (kernel both ends)
>   - B — bidirectional gsmtty data, byte-exact (PING/PONG)
>   - C — drop/raise DTR/RTS → real MSC frames → peer modem lines track
> them (before=0x0 low=0x40 high=0x166)
>   - D — inject a valid CMD_RLS (clen=2) on DLCI0 → accepted by the
> patched gsm_control_rls, mux keeps carrying data
>   - E — clean teardown
> </CLAUDE>

Adding tests like this to the tree would be great.

> 4.  Relatedly, I think it would be helpful for someone (Willy again?)
> to improve the guidance for AI assisted testing and establish some
> standards for documentation.

Why not submit it yourself?

> Because most of the kernel doesn't have
> established KUnit setups and dumping all this info is frowned upon in
> commit logs or notes, it seems like there is a tension between
> "showing your work" and sticking to general convention.

Add the test!  We'll gladly take them, that would make it even easier to
prove changes work, AND prevent regressions in the future.

thanks,

greg k-h
