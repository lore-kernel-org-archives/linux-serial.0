Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660704657C6;
	Thu, 30 Jul 2026 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428410; cv=none; b=tGqa837cL0SzyFur1m2SC4HBxZ4vlxFl60q2LjdbePix5iZDyqZio0ZOzbZvr0t/P82+bHdIHTvDEXa3Uj3fW0NxB35ADu4aerQQBw3KVqPkwU76OjMB6J8VwB/xL5IfbxsgtcnrvsJ0KelJwgSy9UuBrVm//dCKa8APZ2LAR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428410; c=relaxed/simple;
	bh=jtLD44PS9KfLShwvLyab9AEBLG0km2w7oivQujNyqQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeINW4p6IgiImPkjPvJwFAVwCa2EhpsqkqAtOpz3v4xLFmC6jFgvqKpSGEQtU+jdlnIh2go9+ofC1+ImTqWWHIke3Ek5189haE+f5c5NFyxWxzWf0iXyCkYPmanh9c2z8HC8aIXYVw07xKYErKe+I/mJDZJjjIoepyGVpQwkhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nfQlXD7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nfQlXD7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD581F000E9;
	Thu, 30 Jul 2026 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428409;
	bh=+et6MuDB94xkiEa7CEbOdaZvjh9tKaXmjJQZ9oFvMnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nfQlXD7jEPSokhQRMsbEtoc2gOYqTXl4VaoAQBjljepvP/j7WNhIhn69tRSJXtN2X
	 rFU/R/TWVk2C1x0WyMz0uJAXB7NvcGpZH69TVKe8ufv1B6hk1T8+RetUbAZOmyVlOb
	 UGwP+pZnBzYgY4yj+hSdQZMqY0pCrmH89pBuZKPE=
Date: Thu, 30 Jul 2026 16:48:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Kees Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v11 0/2] Convert 8250 to NBCON, take 2
Message-ID: <2026073028-festive-shaping-392e@gregkh>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729120439.281252-1-john.ogness@linutronix.de>

On Wed, Jul 29, 2026 at 02:10:32PM +0206, John Ogness wrote:
> Hi,
> 
> This is v11 of a series to convert the 8250 driver to an NBCON
> console, providing both threaded and atomic printing
> implementations. v10 of this series is here [0].
> 
> Note that v5 was pulled into the 6.14 merge window, but was
> then reverted before the 6.14-rc1 release due to kernel test
> robot problems. It turned out that the problems were related
> to general 8250 driver issues. Those issues have now been
> addressed mainline, paving the way for a second take at
> converting the 8250 driver to NBCON.

Nice work, now queued up, let's see what breaks!  :)

