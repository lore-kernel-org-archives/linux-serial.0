Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216E45D5D0;
	Mon, 21 Sep 2026 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016625; cv=none; b=k7jZ+r9f6hka8SqtpCrYyTzwMneplNx38Zu+n5qJn0oipUG+jzY91N0RZ+g2Dn/Upto+REXyFeJZ5jlLkc3NRH4fBxx9PeREqgBDQo3PxYCqfYaG+QG6INyuKgmien3b70JnwyDjO6LRA1SFlGsWPi3ji5mW8O+hutbkXNYDiqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016625; c=relaxed/simple;
	bh=nW0IMAV4z5cfa3B7MmgaURhZ4gjSCCrc7R9V/r34I/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV6f81T+3mQdE+KBJAqSrtglJHAvWjnaE6yUTMGGzjxOX39l+xydhpxiOFqHJV7SVfitBjWTSyk4+jwItCLMujNdxgFdzQ2LY3zyUcodq1bhZLRu+/Zcb39v8YQHc9cg/eMyKUa0v4KXSJxsQ2fZg2rnK7gQslQToCo/qgI/LFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QbGrg8LE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QbGrg8LE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D4E1F000FF;
	Mon, 21 Sep 2026 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790016623;
	bh=bGNaovLE/0JqFTMgkr4D4XAvXALgacDL2ZDGo2aiMkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QbGrg8LEp8qfzuwYXoZG0YCvChhgz0TPgC3ipJgVW/TT0zaIOFU1kVRfnxsEWb9oC
	 fJ4JdirRXadvrsufjlUY6Ss1rt89OBD03KSGsjtInm633XSnYHwI7y7TWTWVtWT4A1
	 erW0BPX1bFfyK5yGx1fkyYjRTpd4w3PPrMeY+vUQ=
Date: Mon, 21 Sep 2026 20:50:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-remoteproc@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: Re: [RFC] tty: rpmsg: possible lookup-to-reference lifetime race
Message-ID: <2026092154-anger-sensually-aae8@gregkh>
References: <179000811428.1227592.8003229121862460039.idr-bug-84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179000811428.1227592.8003229121862460039.idr-bug-84@gmail.com>

On Tue, Sep 22, 2026 at 01:28:34AM +0900, Sang-Hoon Choi wrote:
> Hi,
> 
> I would like to report a possible lifetime gap between looking up a port
> in tty_idr and acquiring its reference in rpmsg_tty_install().
> 
> The source reviewed is mainline commit
> 5dd1818b15d98d4a20806cd00b1b40320b06004f.
> 
> The install path calls idr_find() without idr_lock, stores the result in
> tty->driver_data, and calls tty_port_get(&cport->port). The port destructor
> removes the IDR entry under idr_lock, drops the mutex, and frees cport.
> 
> If the last reference is dropped during that lookup-to-get interval, the
> following order appears possible:
> 
>     rpmsg_tty_install()              rpmsg_tty_destruct_port()
>     -------------------              -------------------------

Why would these ever run at the same time?  How can that happen?


>     cport = idr_find(...)
>                                      take idr_lock
>                                      idr_remove(...)
>                                      drop idr_lock
>                                      kfree(cport)
>     tty_port_get(&cport->port)
> 
> tty_port_get() uses kref_get_unless_zero(), but this cannot protect memory
> that has already been freed. The install path also does not check for a
> missing ID or a failed reference acquisition before tty_port_install().
> 
> TTY installation is serialized by tty_mutex, but the RPMsg remove path
> does not explicitly take that mutex around its final tty_port_put().
> The destructor can consequently run from RPMsg removal, not just from
> TTY cleanup. I have not established all cross-subsystem ordering rules.
> 
> A draft takes idr_lock across idr_find() and tty_port_get(), and returns
> -ENODEV if no live reference is obtained. This uses the mutex already
> taken by the destructor before removing the entry. Its scope is this
> lookup/destruction gap; it does not establish safety of every probe or
> remove interaction.
> 
> The draft was compile-checked as rpmsg_tty.o with W=1 in an x86
> allmodconfig build at the commit above and passed checkpatch. There is
> no runtime reproducer with an RPMsg endpoint or sanitizer trace. Device
> permissions and the ability to remove the endpoint also remain relevant
> to any security assessment.
> 
> Does another TTY or RPMsg lifetime rule prevent this particular overlap?
> 
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Assisted-by: LLM

Why not have your LLM make a patch for this that you can test and get
credit for the fix if there really is an issue?

And again, how can those two things ever run at the same time in a real
system controlled by a normal user (i.e. not root permissions)?

thanks,

greg k-h
