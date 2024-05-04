Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49453225D0;
	Sat,  4 May 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714838596; cv=none; b=UDOz/5SheN7Dr+XMdy2Ib7YWlll3t2yvogDmHzSg8THg+c3uD+sP7dICWupOLP3V/Taexm6+fhiAjRaJ/D6kve5LyGPC7o507WG46NzRKZ08bkhynqTso8a0UpAWSL3TjVZhK0ymx95pFbrgwmzp3ft3Isa/Oa9bA01LQKMBytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714838596; c=relaxed/simple;
	bh=qQWj9cQTIT/uL819c+QTV1lqwO4CytNsjLuIpXZMtDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loC2uBQ/TlNE8bnozS1BgMD0RdI9FpZG3lxBYkcHQX1d2MpKOoNY/z1QUvMMJU4MP4PjMS3mMF5u+GTGY3B0q1tQvoxME5ctERW/AhQwTSDJ3AyBflKKRKWtYmxEF38JW/ZzJsZS7zwtzUZ7WLufuNN+gSnGsAVNYB2JQ7sfOek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Do6M31KX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Do6M31KX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9785FC072AA;
	Sat,  4 May 2024 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714838596;
	bh=qQWj9cQTIT/uL819c+QTV1lqwO4CytNsjLuIpXZMtDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Do6M31KXhTQ74JldmKCrmwhafuBv+BHvOjoedUEKv3WO/WlRtb0EZE26MXo2SYtws
	 wDFTIc/W2+ok0gJBT1cA2TAqalVbTceIdHs4PCGcus33wdVbjRixrnjp+QN03DfMac
	 N06v5LH1asuJie237NfQ1vcUMcb3yXmoYIi9MB08=
Date: Sat, 4 May 2024 18:03:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Sergey Organov <sorganov@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] serial: imx: Introduce timeout when waiting on
 transmitter empty
Message-ID: <2024050451-gangly-gloomily-e4eb@gregkh>
References: <cf197182beab7acf6ea7ead54fb4324e97e18cbc.1712733269.git.esben@geanix.com>
 <919647898c337a46604edcabaf13d42d80c0915d.1712837613.git.esben@geanix.com>
 <87sez060el.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sez060el.fsf@geanix.com>

On Thu, May 02, 2024 at 11:14:26AM +0200, Esben Haabendal wrote:
> Esben Haabendal <esben@geanix.com> writes:
> 
> > By waiting at most 1 second for USR2_TXDC to be set, we avoid a potential
> > deadlock.
> >
> > In case of the timeout, there is not much we can do, so we simply ignore
> > the transmitter state and optimistically try to continue.
> >
> > Signed-off-by: Esben Haabendal <esben@geanix.com>
> > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >
> > v2:
> > - Fixed commit message typo
> > - Remove reference to patch series it originated from. This is a
> >   stand-alone patch
> >
> > v3:
> > - Moved this version information into the correct patch section
> 
> Anything more needed in order to get this merged?

Sorry, but I don't see this in my review queue anymore.  If this isn't
already accepted, please resend it, sorry about that.

greg k-h
