Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03424476060;
	Fri,  2 Oct 2026 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933473; cv=none; b=X6BsMxV8Ib8F+XL7CLTj0VTkHu2JY5cuNACOII/nKNXTxpad31m9SGQxxli5uBg8t7oKOh3+OBAUWJaPQ7mXHWcmhWY2fYgAHn3ZO/rAlDFcv5bdCXnbYaSJ7GNLkAjMolA3aBiGvK8ZkCOMHx/+BLMZ6NMlFin7AYj5irOSzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933473; c=relaxed/simple;
	bh=pxTqRBvWWNY+2t0x2rvY/Lq0DIchGsQ44X7MT8tAFac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvSflTvW2hWC5xvaExHaHiPjCQkUWUxdY4lxWDQa+cOPQ7Z3xxmfIuQnF5dEBU3Q4TJ6OuDaoR5be5vCLvTD2slETxpY1UC/iG8cBF3XskrfB+QV7yafzfM5LHZdCOCLzrq8FgAOw4GiwdMGcxQNEnOhe9BbvQWMlgOMrV6SaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mthCENXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mthCENXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933021F000FF;
	Fri,  2 Oct 2026 09:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790933466;
	bh=RROvv7SpMjgWwYyXh0XPs2wA0dNJPafDvX80Tq8YizU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mthCENXO4MjlME2af+hav35eJapu/S0OWWPjro8OuyUxErSvOG2ry+z19QGR4O4c4
	 EIQGGYD5rZHE0cFoAlTcIur1VLXMmT4QXiaMPdDG2PZN5LKhIFa9FbyWxKJh17MpZj
	 mu5CA+uFMSIFnnb1jC0FwWirf6jrbc1Da6qBq7E8=
Date: Fri, 2 Oct 2026 11:30:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Imre Kaloz <kaloz@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] MIPS: SGI-IP27: print the NMI dump on an nbcon console
Message-ID: <2026100248-scone-rink-e1a3@gregkh>
References: <20261001191938.3256-1-kaloz@kernel.org>
 <ar9c6LwwwRbKW4fp@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar9c6LwwwRbKW4fp@pathway.suse.cz>

On Fri, Oct 02, 2026 at 09:27:36AM +0200, Petr Mladek wrote:
> On Thu 2026-10-01 21:19:38, Imre Kaloz wrote:
> > Since the 8250 console became nbcon, printk() in nmi_dump() only queues
> > records for a printer thread that never runs, as no CPU leaves the NMI
> > handler. Print from an emergency section and flush pending records
> > before the hub reset.
> > 
> > Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> > Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> 
> Looks good to me:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I assume that it would go via mips or drivers tree.
> Please, let me know if you would prefer to push it via printk tree.

Should probably go through a mips tree to resolve the conflicts.

thanks,

greg k-h
