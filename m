Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C7410A00
	for <linux-serial@vger.kernel.org>; Thu,  7 Dec 2023 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="to17iC5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BA5C433C7;
	Thu,  7 Dec 2023 06:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701931831;
	bh=vqgmxvtHdH524IT5OoMaM15bH8qpnsIkh6S4xu+XSxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=to17iC5LcWb0i2pmWujxZYbaGuiujJ9OFrtiYvhYHQGvFbnKFIui3x0oCPZg/13Sp
	 yX3QhHnj98dbh48AdjNfHaabqXzI9Dli1CP22PFAz2iWd8ZtnWdAcCeUwanmWqyZEp
	 V5yv20LWOSvdnz8PoKjOXYo3BWiwIYsJzS7DIF90=
Date: Thu, 7 Dec 2023 10:33:16 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RESEND PATCH] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe
 boards not work by default
Message-ID: <2023120755-dance-request-8293@gregkh>
References: <20231201074055.259207-1-crescentcy.hsieh@moxa.com>
 <2023120146-pyramid-salsa-d8cd@gregkh>
 <ZWmhKS+quI3dmOND@moxa-ThinkCentre-M90t>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWmhKS+quI3dmOND@moxa-ThinkCentre-M90t>

On Fri, Dec 01, 2023 at 05:02:33PM +0800, Crescent CY Hsieh wrote:
> On Fri, Dec 01, 2023 at 08:27:05AM +0000, Greg Kroah-Hartman wrote:
> > On Fri, Dec 01, 2023 at 03:40:55PM +0800, Crescent CY Hsieh wrote:
> > > MOXA PCIe RS422/RS485 boards will not function by default because of the
> > > initial default serial interface of all MOXA PCIe boards is set to
> > > RS232.
> > > 
> > > This patch fixes the problem above by setting the initial default serial
> > > interface to RS422 for those MOXA RS422/RS485 PCIe boards.
> > > 
> > > Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> > > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> > > ---
> > >  drivers/tty/serial/8250/8250_pci.c | 58 +++++++++++++++++++++++++++++-
> > >  1 file changed, 57 insertions(+), 1 deletion(-)
> > 
> > Why is this a RESEND?  What happened to the first attempt, did I miss it
> > somewhere?
> 
> This RESEND patch is the first patch of this patch series [1], Jiri
> reviewed the first patch and suggested to split the second patch, so I
> split the second patch and sent it as a new patch.
> 
> However, the first patch seems to be overlooked, so I resend it.
> 
> [1] https://lore.kernel.org/all/20231027062440.7749-1-crescentcy.hsieh@moxa.com/

Looks like 0-day had a problem with it, please fix that up and resend a
new version.

thanks,

greg k-h
