Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C831AE876;
	Thu,  4 Jul 2024 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097830; cv=none; b=PrjD+IWS4AN2gcLOJ8v/vi6II234MVIhF3+oZM0DzgUPnC+f/oLXS4qYdk+1QdQk7MEfGH9i7D9Mg+xnAMIfAVqkrirX61iMJSOO+k6yZi99k7uPdon83ggcpP73JJBGXPj1ZMzckyOwyGLzDD5IBwUOrTQim+1uWPcrbTB4ww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097830; c=relaxed/simple;
	bh=cEPKMXyGKOpfpyTPW/VQW4JG0KcfgBIjs1jWSYlHGzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9CMoFWOS0Tyhs8mVyyBKSt6WlL4OQ4P1cclrLkoXeTS7jluZA6A8MwkGfhqK1rnFRXQEEh2Mi2Nq79siCI/xh6rwOh0FzUwI4tbqMnIhG23/b4j4AXarlTIJfFzhiyWO4IjiLGJXDZbmuWM/PUw8PQQVtWLdpeh3kpXJlOkEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J8FDxNYI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J8FDxNYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F20C4AF0B;
	Thu,  4 Jul 2024 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720097830;
	bh=cEPKMXyGKOpfpyTPW/VQW4JG0KcfgBIjs1jWSYlHGzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8FDxNYIKPn0W0IWh/cX6WB51wpuVVBNXRSeHxt7MRULKt9nqJFKv/S+f8jVOzBL6
	 AYMlK3h2K6dmhx3Sh0s2EdYGRAkK0L4vdy1acaK9USxWT3ix89y1ngmdMsIwp+ST6J
	 yxNQkDLswVOQU4h7G80F+wIVVmVJbvO1Pki+pOEc=
Date: Thu, 4 Jul 2024 14:57:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Dhruva Gole <d-gole@ti.com>,
	Sebastian Reichel <sre@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] printk: Add
 match_devname_and_update_preferred_console()
Message-ID: <2024070446-shuffling-maimed-85eb@gregkh>
References: <20240703100615.118762-1-tony.lindgren@linux.intel.com>
 <20240703100615.118762-2-tony.lindgren@linux.intel.com>
 <ZoaLA5IVTnh0E0QI@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoaLA5IVTnh0E0QI@pathway.suse.cz>

On Thu, Jul 04, 2024 at 01:44:03PM +0200, Petr Mladek wrote:
> On Wed 2024-07-03 13:06:08, Tony Lindgren wrote:
> > Let's add match_devname_and_update_preferred_console() for driver
> > subsystems to call during init when the console is ready, and it's
> > character device name is known. For now, we use it only for the serial
> > layer to allow console=DEVNAME:0.0 style hardware based addressing for
> > consoles.
> > 
> > The earlier attempt on doing this caused a regression with the kernel
> > command line console order as it added calling __add_preferred_console()
> > again later on during init. A better approach was suggested by Petr where
> > we add the deferred console to the console_cmdline[] and update it later
> > on when the console is ready.
> > 
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Co-developed-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks for the review, I'll take this through the tty tree now.

greg k-h
