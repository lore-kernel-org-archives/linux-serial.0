Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20D1E7C2D;
	Tue,  5 Aug 2025 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754429692; cv=none; b=eYV2SpREYzfArOo4q92mzonGaCOqtFtByoA1N4Iw/+7+fPM4t2jROPpVVoAeNX/LKJCZJbsNPVBtzOBqJjSe2TFoM/+CfMptjWSo9JnSIuhX8laWgfSP5gxsdQ5IWhVW55yFZMie8g3VIzV9rtoayxq+I0P5RsytusQtahQgZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754429692; c=relaxed/simple;
	bh=U1GLvy0RfDC0fOvJ/9NF1wuUkyRXzkHh++g+56ZJGnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw6+eSrjjzmW1N4Pph1FJrjVpLVWoOS7mZntG9N0SSK9/kH7zvGJUbhEEWTHQ5JSlfsPKgn0YDPYRG8TTivnMXVOfEwhMZnU3+RKNMYtqW1DaKK1EmVhVB/lg0/aJJ9Pp7XbhmUTWoNxh9IquTv634CzDXXJuvx0CLsDWLpqaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8MNQa+L; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8MNQa+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754429691; x=1785965691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U1GLvy0RfDC0fOvJ/9NF1wuUkyRXzkHh++g+56ZJGnc=;
  b=W8MNQa+LrVqE5kjfqdeVhV1xBO8Qw+pZj2i65JvIXlpBAISvfyBcmQ2O
   Yhe3UuuysyRiYH09AqxDdMPqAxj1wjtr8N96s4OfoiFq8Q5cQwu8eBh08
   mF7v/u0QMhpiH3BJFwj+Sa5SmVkBhbdtyZa/2TPLesSi+ffgvAwRgKFvn
   PmpHjEiAJtdIfhDhysf36bv4LUtZc0QXGJNzmTCKQIQFME8Qj0fWgW87O
   /8h607NDXMp8vW5pPMWB+7ciYioU9z8Ycg5VaCJ039rCuRNCCC6CouvYM
   xICeJJeuUcVrVvRPz+R4NOOT+qfOCk0dbaaXjF/SSsJXKnMYX+uJofuIk
   g==;
X-CSE-ConnectionGUID: wOjytfivThuw88O1RI6lXQ==
X-CSE-MsgGUID: n+6yjsWGRQaosqYwyU1u3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="60374349"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60374349"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:34:50 -0700
X-CSE-ConnectionGUID: BjRInXNaQYi0vhMGgv+a8w==
X-CSE-MsgGUID: 6mpQ5sidTWWZvbKNuVeCtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164938840"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:34:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ujPIy-00000003rIN-49Un;
	Wed, 06 Aug 2025 00:34:44 +0300
Date: Wed, 6 Aug 2025 00:34:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH] tty: serial: 8250: exar: fix kernel warning in
 default_setup function
Message-ID: <aJJ49CSBqGZM_b1Y@smile.fi.intel.com>
References: <aIiDf31HzRBGuMN2@monster.localdomain>
 <2025072929-distant-hardener-0e75@gregkh>
 <20250730130348.082ad53d@posteo.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730130348.082ad53d@posteo.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 30, 2025 at 11:03:50AM +0000, Wilken Gottwalt wrote:
> On Tue, 29 Jul 2025 10:48:17 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > > index 04a0cbab02c2..5660bb897803 100644
> > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > @@ -500,12 +500,13 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> > >  			 struct uart_8250_port *port)
> > >  {
> > >  	const struct exar8250_board *board = priv->board;
> > > +	unsigned int bar = 0;
> > >  	unsigned char status;
> > > -	int err;
> > >  
> > > -	err = serial8250_pci_setup_port(pcidev, port, 0, offset, board->reg_shift);
> > > -	if (err)
> > > -		return err;
> > > +	port->port.iotype = UPIO_MEM;
> > > +	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
> > > +	port->port.membase = priv->virt + offset;
> > > +	port->port.regshift = board->reg_shift;
> > 
> > And so now serial8250_pci_setup_port() is never called?  Are you sure
> > that's ok?
> 
> Hi Greg,
> 
> I will not provide a second version of this patch, because this is a bigger
> problem involving 8250_exar, 8250_pci and 8250_pci1xxxx. With the changes from
> kernel 6.10 to 6.11 the underlying pcim_* functions where changed. The
> serial8250_pci_setup_port() does checks on pci_dev + BAR where resources were
> already mapped via pcim_iomap(), pci_iomap() or even pci_ioremap_bar(). Not
> sure if mixing this is a good idea after the kernel 6.11 changes.
> 
> serial8250_pci_setup_port() uses pcim_iomap() and pcim_iomap_table() for checking
> these already mapped resources. But the pcim_iomap_table() is deprecated and
> suggests to use pcim_iomap() function to aquire the pointer to the resources
> while at the same time pcim_iomap() description states, don't use this function 
> twice on the same BAR. I think the most sane approach would be to drop the
> pcim_iomap() and pcim_iomap_table() checks from the serial8250_pci_setup_port()
> function. But I can not fully test this, I only have access to some hardware
> used by the 8250_exar driver. I also CC Andy and Parker, both worked on the
> affected code.

I'm on vacations right now and I lost context of this a long ago, please Cc me
to any new version of this change to have a fresh look.

-- 
With Best Regards,
Andy Shevchenko


