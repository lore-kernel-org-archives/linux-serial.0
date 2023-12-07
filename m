Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EAA35287
	for <linux-serial@vger.kernel.org>; Thu,  7 Dec 2023 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ge6SijUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24870C433C8;
	Thu,  7 Dec 2023 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701943786;
	bh=mlf+E9uAxcA9DH2IJGNsrr3vRH7MvPzIWWShzXKzrW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge6SijUtS4LpfTcbDkYt4hdfhyhH6LxLfzLBBGN0w130qSSsTAyIk+lLkVfpKJdLw
	 Jl/xlWAzKIxRe0GBt4HKzG6tnRFm3IgO+WxIlcR1dFcL2dIxOk7DwH344DOAve4MWB
	 w7tonU+Nf7szhNxH2YJytPPdlrEIPr0ExzRZhA/Y=
Date: Thu, 7 Dec 2023 11:09:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 23/27] tty: serdev: convert to u8 and size_t
Message-ID: <2023120709-revise-retaliate-3796@gregkh>
References: <20231206073712.17776-1-jirislaby@kernel.org>
 <20231206073712.17776-24-jirislaby@kernel.org>
 <ZXAsSjFzBaBdqJSg@hovoldconsulting.com>
 <2023120736-bullpen-edgy-3c02@gregkh>
 <ZXGAEThOendGmjb4@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXGAEThOendGmjb4@hovoldconsulting.com>

On Thu, Dec 07, 2023 at 09:19:29AM +0100, Johan Hovold wrote:
> On Thu, Dec 07, 2023 at 10:47:18AM +0900, Greg Kroah-Hartman wrote:
> > On Wed, Dec 06, 2023 at 09:09:46AM +0100, Johan Hovold wrote:
> > > On Wed, Dec 06, 2023 at 08:37:08AM +0100, Jiri Slaby wrote:
> 
> > > > diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> > > > index 5d8e9bfb24d0..baa956494e79 100644
> > > > --- a/drivers/gnss/serial.c
> > > > +++ b/drivers/gnss/serial.c
> > > > @@ -80,8 +80,8 @@ static const struct gnss_operations gnss_serial_gnss_ops = {
> > > >  	.write_raw	= gnss_serial_write_raw,
> > > >  };
> > > >  
> > > > -static int gnss_serial_receive_buf(struct serdev_device *serdev,
> > > > -					const unsigned char *buf, size_t count)
> > > > +static ssize_t gnss_serial_receive_buf(struct serdev_device *serdev,
> > > > +				       const u8 *buf, size_t count)
> 
> > > The gnss subsystem consistently use tabs-only for indentation of
> > > continuation lines so please don't change the indentation for these
> > > files.
> > 
> > That's going to drive checkpatch.pl crazy, please don't inist on it as
> > that is not going to work well over time as we would all have to
> > remember that just for this one subsystem :(
> 
> Open-parenthesis alignment is not part of the coding standard and is
> hidden behind the checkpatch.pl --strict option along with other (often
> excessive) checks that are not generally agreed upon.
> 
> Only staging and networking enable that option by default and I think
> checkpatch.pl handles that transparently.

Ah, didn't realize this was a staging-only thing, sorry.  As that's what
I get loads of checkpatch fixes for, I figured it was what everyone
should be using :)

thanks,

greg k-h
