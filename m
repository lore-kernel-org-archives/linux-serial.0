Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89F2170D8;
	Thu,  7 Nov 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996216; cv=none; b=suKzJnkTN3jwfibmXrL/emMRMNkdgQkn1LfHN8QEoGQ+Lz45eOfp101RsUjb4fpjPvA3FszOKlUUaIdYeAjvN6itjAcbFPKphVAV4H2l28vwzCkFLZgjLLywDxC/diB9f5rYhCWtt/Iq469h5o0f2I2SJyNdvGtRCLqVo68rt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996216; c=relaxed/simple;
	bh=7GSFin9V+jUCzibi/TtyrmEmxyYCEplPjpGi82p5ZOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTPCy6EY/bAmzW1LdbZYk/RVWb/PAg80pwnjGKLQYSg+8hBYJJb2JBkx2yTLAN52aRGrPDk4XBjBK2KJDYr5FfCG071PYoc9xA4OD9K+1nlHVf1cgngS7rNZrPGZa5R6zu/owZdLLuN0Afc/tG5teb444IPwRYl7NOmN34/zF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rMnJxv3E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rMnJxv3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B5AC4CED2;
	Thu,  7 Nov 2024 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730996215;
	bh=7GSFin9V+jUCzibi/TtyrmEmxyYCEplPjpGi82p5ZOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMnJxv3E71c8K4qaLxJES+Prj9nI2kf5vQoC3qK5nxj/9h46kBgQheY5/LZ5QJRUw
	 hKaAtSzoq57T6Xw3w5/LEXaGflv7q7qqVlvDGT3520zU8SYRniBbt0NxVnnYQ8GHUv
	 h+oa+W6iunEm3ZXIhBUpdS1PZvqRxUVw63P7coBo=
Date: Thu, 7 Nov 2024 17:16:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 0/2] printk: Add force_con printk flag to not suppress
 sysrq header msgs
Message-ID: <2024110742-opposing-chirpy-f74a@gregkh>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
 <ZyzjcLF-wleMTpoY@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyzjcLF-wleMTpoY@pathway.suse.cz>

On Thu, Nov 07, 2024 at 04:57:36PM +0100, Petr Mladek wrote:
> On Tue 2024-11-05 16:45:07, Marcos Paulo de Souza wrote:
> > Hello,
> > 
> > This is the second version of the patchset. It now addresses comments
> > from John and Petr, while also mentioning that the current work solves
> > one issue on handle_sysrq when the printk messages are deferred.
> > 
> > The original cover-letter in is the v1.
> > 
> > Please review!
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > Changes in v2:
> > - Mentioned that it fixes a bug related to loglevel= dance (suggested by John)
> > - Changed to loud_con to FORCE_CON (John, Petr)
> > - Don't skip printk delay if FORCE_CON is specified (John)
> > - Set FORCE_CON when LOG_CONT is handled (John)
> > - Changed force_con from a per-CPU variable to a global variable because
> >   we can't disable migration on the callsites. (John, Petr)
> > - Used is_printk_force_console() on boot_delay_msec(), since it's used
> >   when the message is stored, instead of setting is as an argument.
> > - Link to v1: https://lore.kernel.org/r/20241016-printk-loud-con-v1-0-065e4dad6632@suse.com
> > ---
> > Marcos Paulo de Souza (2):
> >       printk: Introduce FORCE_CON flag
> >       tty: sysrq: Use printk_force_console context on __handle_sysrq
> 
> The patchset looks ready for linux-next from my POV. I am going to
> push it there tomorrow or on Monday unless anyone complains.
> 
> There was some bike-shedding about the code style in the reviews.
> But the proposals did not look like a big win. I think that it
> is not worth a respin.

No objection from me!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
