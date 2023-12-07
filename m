Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ADA1DA34
	for <linux-serial@vger.kernel.org>; Thu,  7 Dec 2023 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIFjf6k4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D50C433C8;
	Thu,  7 Dec 2023 08:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701937121;
	bh=c1IibyTEeI1rZhj66cRp9B60N7vFGETPlS+Ga10AvM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIFjf6k4YcQnN7KNTaegjYJlwtyp/redptAppn34XT9apIriJ4nG3ot52aLD9Dp2P
	 dbWcF8klMd5p07ZmFllcFXdqP+WgFgyAKhvnj2uq3dGKGoaahZg9d09OBcASofm3VR
	 zg3L4YD6iTxFD2nFXGazaz8wliaww7T7lTmg+rSvF2qh0AAeH6e+uENFazzZ/khpdu
	 S8LB+whRi3Kqzx9ZD/qPZeQsBzXB5F1/8JXZxH8f1TqFf5bwSXTfR7ZjHrydUAkHQI
	 ozlggiQIZK2sWD1ckysDrUOjgtafuCaluIAhLlRRSEwWzax6ndTg3OLfIyNEQJCo1o
	 817XYArcD+Pnw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rB9bV-0007kD-2e;
	Thu, 07 Dec 2023 09:19:30 +0100
Date: Thu, 7 Dec 2023 09:19:29 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 23/27] tty: serdev: convert to u8 and size_t
Message-ID: <ZXGAEThOendGmjb4@hovoldconsulting.com>
References: <20231206073712.17776-1-jirislaby@kernel.org>
 <20231206073712.17776-24-jirislaby@kernel.org>
 <ZXAsSjFzBaBdqJSg@hovoldconsulting.com>
 <2023120736-bullpen-edgy-3c02@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120736-bullpen-edgy-3c02@gregkh>

On Thu, Dec 07, 2023 at 10:47:18AM +0900, Greg Kroah-Hartman wrote:
> On Wed, Dec 06, 2023 at 09:09:46AM +0100, Johan Hovold wrote:
> > On Wed, Dec 06, 2023 at 08:37:08AM +0100, Jiri Slaby wrote:

> > > diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> > > index 5d8e9bfb24d0..baa956494e79 100644
> > > --- a/drivers/gnss/serial.c
> > > +++ b/drivers/gnss/serial.c
> > > @@ -80,8 +80,8 @@ static const struct gnss_operations gnss_serial_gnss_ops = {
> > >  	.write_raw	= gnss_serial_write_raw,
> > >  };
> > >  
> > > -static int gnss_serial_receive_buf(struct serdev_device *serdev,
> > > -					const unsigned char *buf, size_t count)
> > > +static ssize_t gnss_serial_receive_buf(struct serdev_device *serdev,
> > > +				       const u8 *buf, size_t count)

> > The gnss subsystem consistently use tabs-only for indentation of
> > continuation lines so please don't change the indentation for these
> > files.
> 
> That's going to drive checkpatch.pl crazy, please don't inist on it as
> that is not going to work well over time as we would all have to
> remember that just for this one subsystem :(

Open-parenthesis alignment is not part of the coding standard and is
hidden behind the checkpatch.pl --strict option along with other (often
excessive) checks that are not generally agreed upon.

Only staging and networking enable that option by default and I think
checkpatch.pl handles that transparently.

So this should not be an issue unless you're trying to enforce the
contentious checks tree wide (i.e. just drop the --strict option).

That said, as this only affects one function (the other one happened to
align while still only using tabs) I can fix that up later unless Jiri
is resending for some other reason.

Johan
