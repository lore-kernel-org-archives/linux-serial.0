Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF33D8906;
	Wed, 29 Jul 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330714; cv=none; b=LrHrIPSnhv6goV1CzEWMB5T535kmu7dZUNKRHdy2UPXpHMwxoLmjRPWcNvM+ICYOUV5u5VZURTYcu5q0v4zj3eDArbK3JXCXkA0weIk2q6jPqWy+7ghF0OM1fA+RzQeKkTwXZoBtx+YCnlGDxzI0lXD4cUM1TrnbM2NBhP1vjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330714; c=relaxed/simple;
	bh=fWcBn41P6wep3ms0WPH04zf2BmmESrzXZapodwPG+No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2JfvjnZfCgoFY+Kaj1ouxQA3xoUgXN1Aon/mioW/mDw0eNFXngPAukCbmQsAC7/sNkWl+RJUYBmWRoIbIYX1D0mzGiC4roNkcIMzx4EUfsUgW1dO5Fg2puSgY1FzF38M2vnZN6T8r639UqIULgV7OxgXvhlvtO1wp/+S78yIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dvzRqxsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dvzRqxsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5EE1F00A3A;
	Wed, 29 Jul 2026 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330712;
	bh=2tob+nXief/QY7nPv0Grw/8tXU0sr1l3RcQbIWbEuFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dvzRqxsYN2haslQ13GXp3szBXXcoRYrhTO0wOnAo25jU3NSrXf6eVhi4W0sRGtpX4
	 7rifRFQhhVyHijzxW9L5OXil11JLFQu7xaDEY0/Ysg9wVLAiTBcW6qm+iTK5+QJJ7x
	 b/UUMVIW5BBmNtQcilSkVzGapf/czMLnlbDPjtjs=
Date: Wed, 29 Jul 2026 15:11:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: broonie@kernel.org, andy.shevchenko@gmail.com,
	asrinivasan@oss.tenstorrent.com, jackzxcui1989@163.com,
	jirislaby@kernel.org, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	osama.abdelkader@gmail.com, wangfushuai@baidu.com
Subject: Re: [PATCH v2] Revert "serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration"
Message-ID: <2026072927-lather-print-3f5f@gregkh>
References: <e086c2da-e08b-4d53-abb1-e7a5cfd0d6f6@sirena.org.uk>
 <20260729112605.11764-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729112605.11764-1-fushuai.wang@linux.dev>

On Wed, Jul 29, 2026 at 07:26:05PM +0800, Fushuai Wang wrote:
> > > From: Fushuai Wang <wangfushuai@baidu.com>
> > > 
> > > This reverts commit d338ab1d90603f875c4f7ed223406535378173a5.
> > > 
> > > uart_console() only indicates that the port is selected as the console.
> > > It does not mean that the console has already been registered or has
> > > printed the buffered messages.
> > 
> > The multi-system boot regression this fixes is still present in -next.
> 
> Hi, Greg
> 
> Just a ping.
> 
> Mark has confirmed that the regression is still present in -next.
> Could you please take a look and consider applying it to tty/tty-testing 
> and tty/tty-next?

Will do, working on my patch queue right now...
