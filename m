Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AF39020C;
	Sat, 11 Jul 2026 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783762219; cv=none; b=NjLMao88V8op0NMVbzIkI18CUT3nLGcu2QK1PCoaGGA1/AUxK3hLH5L3mkjUEybnKG3754l2b9aF4SF5rEwrGEJluwnsDPj6JcoCU6ZHAFwTHrVylxp4fO5jwEmD591zyUMcaWsyGvE/fY8XOOSxxtUuNUzc1nfr8JUD0rXf7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783762219; c=relaxed/simple;
	bh=Yea8PnTpdkhdRiK+h6PYszvaim+cPlJXvnqZnvdTVaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIq7atf4i9igCWlKzZ6prmrwvEoMndcHtQZrc8/PpQKVzk4uVLIGtdeiIHQSO6v5noY+GbJCI7iX6yQB48KhAhqa8cwzbKfAHtQeCabRTgs8Rpg+a6bCKfhMXm0/sbLG4Icbnj6yPOP8WHsK8USwIlSbIjd/HmrRsSbm9rsR8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKHJRnBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKHJRnBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DCA1F000E9;
	Sat, 11 Jul 2026 09:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783762218;
	bh=wMYPfyTsBLTuv/VNc1Ad6qGQ7OM9n6X/3M55TFPtdc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oKHJRnBPFx5ib22zJ5SuEM6vSjo63Hsw+PMuKp0Vczhmn3i7ESnfc/eYbgMF2I/CG
	 Unvtjto65X/PtKcCKSHMn/hfQ7IBn6NNy0//Xw3Nb7lJH04SvAYHXtJ+7hLoAeu4WP
	 CXlo7sqO3wa+2fxlcy9vp5yMJDpl08i5VUvXAAAGZCSrSAPVICVtKWmuviqCzZEHfZ
	 YIf6DcjUaI0kIZZg0wupyGaHg8Pq8b5HJnup/4pjY8hxetJLZI2wpHcZk+x+HkxsMm
	 jJRH64uxBhsQssoRV6sOT0gYsnSxa0Ee+el6WJJCsjXGjCg7COYDZSVgJZ9bjUQEV8
	 lHREPDJ+GE7Kw==
Date: Sat, 11 Jul 2026 12:30:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 0/4] tty: replace __get_free_pages() with kmalloc()
Message-ID: <alINJCLaJ8xo4ein@kernel.org>
References: <20260630-b4-tty-v3-0-a8476c66c582@kernel.org>
 <2026071056-comfort-dynamic-a713@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026071056-comfort-dynamic-a713@gregkh>

On Fri, Jul 10, 2026 at 02:44:16PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 30, 2026 at 12:54:02PM +0300, Mike Rapoport (Microsoft) wrote:
> > This is a (tiny) part of larger work of replacing page allocator calls
> > with kmalloc.
> > 
> > Nowadays the right way to say "I need a buffer" is kmalloc() rather than
> > ancient and ugly __get_free_pages().
> 
> I already applied an earlier version of this series, so can you just
> send the fixes you made between them?

The only change was the placement of include <linux/slab.h> in
men_z135_uart and it looks like you fixed it up when applying :)

> thanks,
> greg k-h

-- 
Sincerely yours,
Mike.
