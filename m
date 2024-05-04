Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED740C03;
	Sat,  4 May 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714838915; cv=none; b=emocBChL9Py1N1jHPemVzG3k4aiLIdTz2DgGtjN2nxM6tRx6RrHmVjA/xeixJmSnzP+14sRWqrHssQIiHM6lJuDMlrjyVqncFDi6nHpweaUMLaUbSJqJ4eUMDiGImASdkE6UTT/FVgYsoFIdxDYNmAGUqFIk3AatMkOjzZ+Z/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714838915; c=relaxed/simple;
	bh=wwaTRDS9tEE5USkR/1JxhoWU+nwvf1phzHVbJVUzqA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCIkqYzg7vmsBfAkPsomb33kyAz/8fNyekKbeGgPnEzk4ikmlhDekRb+0g2zMF2wTG+/BUA/pltwmPhxca0RcvfMxVZPEeDsNA7khZZJIGXYcejYjaRvHUzZHjPA1jWCScvsODMGO5f2aFKNlxigxcLofBJdX5PWYMzWKW7REWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YaYlLbtj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YaYlLbtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A94C072AA;
	Sat,  4 May 2024 16:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714838915;
	bh=wwaTRDS9tEE5USkR/1JxhoWU+nwvf1phzHVbJVUzqA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YaYlLbtjCKrLwbl2zTCOZsaIZ5NzeSfKY5zeUamsmHYVO8JclOuCzMfzta7+CKbQi
	 qxcf+quMczY96vtiZsysJdN++RL6KWHK0jwwyfulKW1Bhb/SD1SVlDbwnda+KP/YSl
	 59HA3TzWihmMifjtVgNyMTB8nLbyarkY6qBLaaVY=
Date: Sat, 4 May 2024 18:08:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v5 12/30] serial: core: Implement processing in
 port->lock wrapper
Message-ID: <2024050424-agony-document-677c@gregkh>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-13-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-13-john.ogness@linutronix.de>

On Thu, May 02, 2024 at 11:44:21PM +0206, John Ogness wrote:
> Currently the port->lock wrappers uart_port_lock(),
> uart_port_unlock() (and their variants) only lock/unlock
> the spin_lock.
> 
> If the port is an nbcon console, the wrappers must also
> acquire/release the console and mark the region as unsafe. This
> allows general port->lock synchronization to be synchronized
> with the nbcon console ownership.
> 
> Note that __uart_port_using_nbcon() relies on the port->lock
> being held while a console is added and removed from the
> console list (i.e. all uart nbcon drivers *must* take the
> port->lock in their device_lock() callbacks).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/serial_core.h | 82 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 2 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
