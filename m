Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC33156966
	for <linux-serial@vger.kernel.org>; Wed,  3 Apr 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183172; cv=none; b=QzSNR6CWfQQbBbXqu2eCEMJboEGbWY1VytBHEYbW37VjJFbo9qTEGRRfzC8/e8AJe4bd43yJXB23h2cCfEysiw5bvi6l17TUrhpDyfkkzJnqTTL/tIMT55CbwtLGDX8NxWwOnjDNQHP3JSzdNP3Aj3IQtt4RAOP3XEQB++z+jIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183172; c=relaxed/simple;
	bh=s207HgJoe5eibYyo9LW5tjcHICxSNKnKZt+o0hm3+lw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3uJpS57z+0uf+q6joC0/lNbHqVLAswd7W6NBK7+UHyBT3uFJ4CphWnlQDl2jpWgIAHEd647TqHy4s9guwfXKL5bnLmSz6LLmcTVPnQ9/Yo6ZIEgsNLHnTdNwO8unaxg2WXGYqvbJXMZysU0JbaiFZGY2qgOdnY/UHD4r5Gvi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 2abd16a8-f209-11ee-b972-005056bdfda7;
	Thu, 04 Apr 2024 01:26:08 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Apr 2024 01:26:07 +0300
To: Joshua Droney <josh@fastcomproducts.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Subject: Re: Incorrect UART in /tty/serial/8250
Message-ID: <Zg3Xf_kf7W_Xm5DT@surfacebook.localdomain>
References: <CAJqSBBNc5mPcKfFSH2jXnjp9PB6fQGWN0vB9JPKHENogUw-D+A@mail.gmail.com>
 <2024032920-replay-ruined-d92d@gregkh>
 <CAJqSBBMETm4UVv3F8iUAdMi2tpaSY+-QcxAO2qHOC_O9J=cSqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJqSBBMETm4UVv3F8iUAdMi2tpaSY+-QcxAO2qHOC_O9J=cSqw@mail.gmail.com>

Fri, Mar 29, 2024 at 09:23:49AM -0500, Joshua Droney kirjoitti:

First of all, do not top-post in the Linux kernel related mailing lists.

> I would appreciate some guidance on this. I don't know enough about
> the kernel's serial driver to be confident about what changes need to
> be made, nor anything about creating/submitting a patch.

You may start from here:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
https://www.kernel.org/doc/html/latest/process/submit-checklist.html

> On Fri, Mar 29, 2024 at 1:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Mar 28, 2024 at 02:34:10PM -0500, Joshua Droney wrote:
> > > Hello!
> > >
> > > My name is Josh. I'm currently employed at Commtech, Inc.
> > > (https://fastcomproducts.com/). I'm following the instructions at
> > > https://kernelnewbies.org/FoundBug to report this issue. Please let me
> > > know if this is incorrect.
> > >
> > > We (Commtech) have several serial boards, but the board in question is
> > > the '422/2-PCIe'. This board does not exist, but someone added it to
> > > the Linux kernel at some point in the past. This wouldn't be a
> > > problem, except that the board ID that was used for this non-existent
> > > board (0x22) was ultimately used for a different REAL board, with a
> > > different UART. Instead of a xr172358, we use a 16C950 on the real
> > > board. But the Linux kernel finds our other board ID, and tries to
> > > initialize it as an exar chip and fails. I don't know much about the
> > > kernel, but I believe the lines in question are:
> > >
> > > https://github.com/torvalds/linux/blob/master/drivers/tty/serial/8250/8250_exar.c#L47
> > > https://github.com/torvalds/linux/blob/master/drivers/tty/serial/8250/8250_exar.c#L925
> > >
> > > You can see that we have a different board with device ID 0x22 here:
> > > https://admin.pci-ids.ucw.cz/read/PC/18f7
> > >
> > > The 422/4-PCIe exists (0x20), the 422/8-PCIe exists (0x21), but the
> > > 422/2-PCIe was never created and its device id was used for a
> > > different board (0x22, the SuperFSCC/4-LVDS-PCIe).
> >
> > Can you please submit a patch that fixes this?  We'll be glad to take
> > it.  If you need help making it, please let us know.

-- 
With Best Regards,
Andy Shevchenko


