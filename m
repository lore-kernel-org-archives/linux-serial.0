Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F047143C;
	Fri, 25 Sep 2026 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330962; cv=none; b=lbzdU5p9DZIrNumv2JFQCLP3oiaEpFdSk633DHDdDOnxPg++IW/YhVwHdNMGuaB7SPz2nFEEjvOt53FZM5c2KhyaTvXowDMBUNhRbBzHrWF4pOnaeewvDLlHFQgmgHjtLgSSN6u9fCJ/ByPs3vl0bHePahazWypLcRI4Ric5Mxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330962; c=relaxed/simple;
	bh=Iq6fhZxE1I42ljnuePaa3E2pV+zUhgw1f7dsbCrvjfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl8AS1pd+072j+IjQlv0CLPgqKcnHMx4C5r7GDOLCX+XQ/EZSwcBojUwYaSRPOqLtuGlcLF7MgKyQcy9TLhNouC6rRos53ExquCTC8yk+AbSMTwpz5xF473JV5K/hiZxkBwrXNjMRclpD3cVvWxFCC9DbNNurUiZk05yLOXX8Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SYLrP0W4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SYLrP0W4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4276D1F000FF;
	Fri, 25 Sep 2026 10:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790330960;
	bh=r4VcBAGMaBtD3eaP3crF0aa1T4HPjvttKsIqdVRgaJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SYLrP0W4Iu/iRfW/CQF/Cbm1vV2qaLzblZQYaV8ylLFdtakWrk5X1gRMO4fognyt9
	 WEXJ3pexKDU8gxOsDa6e2Dtr7ajmW+vkG0rMv/yjjaXRbKaKyPxx5GWW3cUtu+Fcna
	 fgtmUBjYxOn3TX6xlD1LSFICrmoGduB9QYUGmgHk=
Date: Fri, 25 Sep 2026 12:09:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] tty: add break_wait kernel-doc
Message-ID: <2026092508-eligibly-celery-650f@gregkh>
References: <20260925094222.18303-1-johan@kernel.org>
 <2026092538-available-multiple-6b11@gregkh>
 <arZGmBW-hG7Vv66M@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arZGmBW-hG7Vv66M@hovoldconsulting.com>

On Fri, Sep 25, 2026 at 12:02:00PM +0200, Johan Hovold wrote:
> On Fri, Sep 25, 2026 at 11:55:48AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Sep 25, 2026 at 11:42:22AM +0200, Johan Hovold wrote:
> > > Add the missing kernel-doc description for the new break_wait field in
> > > struct tty_struct.
> > > 
> > > Fixes: c7e9bff9b4b3 ("tty: abort break signalling on hangup")
> > 
> > Don't you mean:
> > 	845a2737e0f5 ("tty: abort break signalling on hangup")
> > ?
> 
> Yes, sorry. Can you fix it up when applying or do you want me to resend?

I'll fix it up, no worries, thanks.

greg k-h
