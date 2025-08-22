Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490212FE597;
	Fri, 22 Aug 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856169; cv=none; b=mcdXN0xnwdlfbn3v9nJ9JU9/c/yrGUwWHP/ZriL2wk2zhJenUFtSbJm2AvIh8Ehqdbl00MPyl4Fypoo3RVQ70UGmdvE66CTQkgoJqT0NvofSP4sooJjua00zbYOZUuod/S02fxxewDrR+WKmSPV3vJ/5pPdp78BnOKg4QWiGN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856169; c=relaxed/simple;
	bh=1rFgtM0fVkXIuX1D+FqX1wTKg0I12f4f1S+Tik65V6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQDOpqGFwdXJjIqfgm5VUQ8rTbFpll0vmcShVhxXwyeMVdY+yj11YmaB+E5AvvtBBcrNuRs/20FuA4YKKQpUR4kd0j4KTBzkhxckRxBR6l4lQfZ0aEDuWzpqwI3n0OIwzbXM/gOkjCaNkrb9vBsmBH8JPG67vAmLYBSIWtdLGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sa6Gh3iq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sa6Gh3iq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22535C4CEED;
	Fri, 22 Aug 2025 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755856168;
	bh=1rFgtM0fVkXIuX1D+FqX1wTKg0I12f4f1S+Tik65V6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sa6Gh3iq4bnx971G234tKpIlYWhvBoy0mm/5+9n/WSXkRU7GSb2E8AZX9ZUZ7ztWC
	 R0PdFgy+x47Nl6GUrZQu5SUsN42Qx1s2AlHQ7f7Ak1yYpe7+2GopbjIN5usGPf7VbO
	 B22aBe3VJctudGYBE1AcY6lGTImPdkMDNz+4D/4M=
Date: Fri, 22 Aug 2025 11:49:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com, mingo@kernel.org,
	john.ogness@linutronix.de, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_core: fix coding style issue
Message-ID: <2025082212-crunchy-crewless-7eab@gregkh>
References: <20250822082311.16501-1-osama.abdelkader@gmail.com>
 <2025082235-wriggly-wildcat-0477@gregkh>
 <6503f380-1566-4efc-913d-125d316787d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6503f380-1566-4efc-913d-125d316787d1@gmail.com>

On Fri, Aug 22, 2025 at 11:42:55AM +0200, Osama Abdelkader wrote:
> 
> On 8/22/25 10:45 AM, Greg KH wrote:
> > On Fri, Aug 22, 2025 at 10:23:10AM +0200, Osama Abdelkader wrote:
> >> Fix a coding style issue in 8250_core.c:
> >>
> >> - Remove redundant NULL initialization of a global pointer
> >>
> >> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> >> ---
> >>  drivers/tty/serial/8250/8250_core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> >> index feb920c5b2e8..225bb7e4b89c 100644
> >> --- a/drivers/tty/serial/8250/8250_core.c
> >> +++ b/drivers/tty/serial/8250/8250_core.c
> >> @@ -307,7 +307,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
> >>  		serial_unlink_irq_chain(up);
> >>  }
> >>  
> >> -const struct uart_ops *univ8250_port_base_ops = NULL;
> >> +const struct uart_ops *univ8250_port_base_ops;
> >>  struct uart_ops univ8250_port_ops;
> >>  
> >>  static const struct uart_8250_ops univ8250_driver_ops = {
> >> -- 
> >> 2.43.0
> >>
> >>
> >
> > Hi,
> >
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> >
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> >
> > - This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/process/submitting-patches.rst for what
> >   needs to be done here to properly describe this.
> >
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> >
> > thanks,
> >
> > greg k-h's patch email bot
> 
> Hi All,
> 
> I forgot to include the changelog in v2.
> 
> v2:
> 
> - Dropped extra blank line after gpios declaration

Please send a v3 with that.
