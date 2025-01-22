Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19B84A3E;
	Wed, 22 Jan 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538626; cv=none; b=HYXu+wDAWTLYyZV8y1fBNiebn/keYRlFlhBliEqWpowlFEzdI8qRrhjJBJrbDKxD1NwrdoMg7HUja0xquOEjPZXWa/Al+apx0NFaFFBXNKqC2QkjTacU8vb/OJyVxlPigyzSTHVpVVSY/7rrLOzhgZKe3XmIx4xJhIXR1C/9yJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538626; c=relaxed/simple;
	bh=rlOGGkUnIGnmjC3eFC6UX3ykRXwRn+BB1McLj1+eX2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGium538vyAiXdro71aEe0rcsFirUt5oq7GgV+nqw5bdbSxzKmEMVzsfiq22p8FJKFYcGHxrDfxBoay6ei5FFXRPzbvTzA4/S7tLElt9V+JJHHnroLOyvU/D2gO+EQIUUNi2PuOgTnTB9tivyEHFIn8S9tmosQVKPeMnfy+58dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iyt7IThq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iyt7IThq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB83C4CED6;
	Wed, 22 Jan 2025 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737538626;
	bh=rlOGGkUnIGnmjC3eFC6UX3ykRXwRn+BB1McLj1+eX2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iyt7IThqsBbaLvHNayFGfFXmQFxlZZdQNtCrr7Q3vNt9dqOOdIEGtTD1Wcoyta/sk
	 ujlZnZkHTg2bugJfMcIFLmKfbtpKlLvJ6ym7aZY4t3ekheAVykjbFmF3IMxG+U2q3Z
	 LSrfxfvJ/6jN7BhDInjoilCEfDWeI8X5pjWunW0o=
Date: Wed, 22 Jan 2025 10:37:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Petr Mladek <pmladek@suse.com>,
	linux-serial@vger.kernel.org
Subject: Re: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Message-ID: <2025012240-creatable-defective-d713@gregkh>
References: <202501221029.fb0d574d-lkp@intel.com>
 <84wmenqm03.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84wmenqm03.fsf@jogness.linutronix.de>

On Wed, Jan 22, 2025 at 09:47:00AM +0106, John Ogness wrote:
> Hi Greg,
> 
> On 2025-01-22, kernel test robot <oliver.sang@intel.com> wrote:
> > kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]" on:
> >
> > commit: b63e6f60eab45b16a1bf734fef9035a4c4187cd5 ("serial: 8250: Switch to nbcon console")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> It looks like we need to revert this commit (and the one after it) until
> I can find out what is going on here.
> 
> >From linux-next they are:
> 
> b63e6f60eab4 serial: 8250: Switch to nbcon console
> 
> 422c9727b07f serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"

Ok, now reverted, thanks for finding the offending commits.

> I hope to get this solved soon, but I am currently taking part in a Rust
> training, which does not leave me many extra brain cycles at the moment.

Totally understood :)

thanks,

greg k-h
