Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8039430CC8;
	Thu, 30 Jul 2026 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428358; cv=none; b=M47wW63unu/iM68FfV/GRFQH9JGy9EvFPCAz3idPUSCtR4ymhc1cluX0JBEw6/Qns44oXjlUfSV7EsGeSFyu32v9yW6ZRCUpU3pSV/U8L152hYgrWEuXT28/K37P2t8Ac71vnXXdCp/yfO9uYUqON58949bwllLuJNeqiUYBVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428358; c=relaxed/simple;
	bh=ULMurXPWkALbuWJjfVI1Ho5ZBuckLdGOMr3WvkGpEqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfqb+S4GEifFvtahLmPgStALla7F43dXW/sKw+stDbVi0fYAo2qtdlbQf+hvuWJbrkukQY2umGPRVZyIHshAYwALuAxzzf6agfM3nYhd379pLXFh/nfAcXVGXj14VRbFTgG9bLfWIrIwo2xJBqZomOfaX/Y9fNb/0izCXJn7aF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y9LT/UW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y9LT/UW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027B31F000E9;
	Thu, 30 Jul 2026 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428357;
	bh=f4LUnX4cY7cOxRXoGgUKH61DEza8b/ZjjuWlNzKlt58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=y9LT/UW4WZvVgX6Oh068Aw+HSr2SQyX6lZAsiRZggjP9ScPr2B85K7KuFFmS0SqSj
	 zZdvI/CvviXGmvd+pb9mU1n8PBbkEV0QHIH8GxTGDe0aMEr3esUv8bTXTaMJ0VmrUk
	 7+Hox7gW2GLeQet7l2qJlbSrawmRhz9PpxEbIU9o=
Date: Thu, 30 Jul 2026 16:22:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: broonie@kernel.org, andy.shevchenko@gmail.com,
	asrinivasan@oss.tenstorrent.com, jackzxcui1989@163.com,
	jirislaby@kernel.org, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	osama.abdelkader@gmail.com, wangfushuai@baidu.com
Subject: Re: [PATCH v2] Revert "serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration"
Message-ID: <2026073045-valuables-custodian-7cde@gregkh>
References: <e086c2da-e08b-4d53-abb1-e7a5cfd0d6f6@sirena.org.uk>
 <20260729112605.11764-1-fushuai.wang@linux.dev>
 <2026072927-lather-print-3f5f@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026072927-lather-print-3f5f@gregkh>

On Wed, Jul 29, 2026 at 03:11:39PM +0200, Greg KH wrote:
> On Wed, Jul 29, 2026 at 07:26:05PM +0800, Fushuai Wang wrote:
> > > > From: Fushuai Wang <wangfushuai@baidu.com>
> > > > 
> > > > This reverts commit d338ab1d90603f875c4f7ed223406535378173a5.
> > > > 
> > > > uart_console() only indicates that the port is selected as the console.
> > > > It does not mean that the console has already been registered or has
> > > > printed the buffered messages.
> > > 
> > > The multi-system boot regression this fixes is still present in -next.
> > 
> > Hi, Greg
> > 
> > Just a ping.
> > 
> > Mark has confirmed that the regression is still present in -next.
> > Could you please take a look and consider applying it to tty/tty-testing 
> > and tty/tty-next?
> 
> Will do, working on my patch queue right now...
> 

Sorry for the delay, now queued up.

greg k-h
