Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AABA23185E;
	Thu,  2 Oct 2025 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382743; cv=none; b=ICVTnJ/l5XtDbPkvnu8GO/41e/1B8N5F+nwWPI7ZIbZNyfjMt+sRBvA7vJoYwqs7aYcwCBVq7VJGU6yiVItBazsAzfFHOHh22kjblQWOfADQVDZWJdNSLtf9CdritbGF72xPMzhqUdFS7mOvmGIqC3wd3ryxNFX4Bh/M2YrkvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382743; c=relaxed/simple;
	bh=py7zf3DJFpF3arsBTXISGOJbdTRppb2z3gvxL02j5Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwYXtNdbNHXHVlM3vZv0MXKs7whquxSVbs6jsUa457DbNPQkAtUf9WjJEDgtO7JGBDE9RtltJgWR5lmyzJNbmPF0AHfV7ci8S3k1XGe8j17brt9tWHWRxkrNrV8P4O1dfGCpVqfBEbOJDMENCB75NLnTRwn/gn3f1UxwHdmyZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n6NJZ9eu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n6NJZ9eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230C2C4CEF4;
	Thu,  2 Oct 2025 05:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759382742;
	bh=py7zf3DJFpF3arsBTXISGOJbdTRppb2z3gvxL02j5Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6NJZ9eukZwQvk4UG2Xt7xTvdbGXU/oS9RNFtwzRfa4vZacin5Cn9ln2I6pi3Jxfa
	 wd5IpqUkDosyqCk0KM5jLSSCpwo1NjEt2x/4RIBiqMtQsdX6K39yBtO7unXab0mSwK
	 t1TMyOOUkxdr8gf9crjpxoBd2F0GGWMXawx0dQqo=
Date: Thu, 2 Oct 2025 07:25:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, kumaravel.thiagarajan@microchip.com,
	andriy.shevchenko@linux.intel.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, arnd@kernel.org, cang1@live.co.uk,
	macro@orcam.me.uk, schnelle@linux.ibm.com,
	Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pcilib: Replace deprecated PCI functions
Message-ID: <2025100248-chunk-diaper-91e2@gregkh>
References: <20250930072743.791580-1-fe@dev.tdt.de>
 <f6fe95e5-0dd3-4ce0-b741-06cacf283e4c@kernel.org>
 <e19fa21955115f4621b47b170c3a2193@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e19fa21955115f4621b47b170c3a2193@dev.tdt.de>

On Wed, Oct 01, 2025 at 04:45:44PM +0200, Florian Eckert wrote:
> 
> 
> On 2025-09-30 09:34, Jiri Slaby wrote:
> > On 30. 09. 25, 9:27, Florian Eckert wrote:
> > > When the '8250_exar' module is loaded into the kernel, a kernel trace
> > > with 'WARN_ON(legacy_iomap_table[bar])' is dumped to the console,
> > > because the old pci table mapping is still used in '8250_pcilib'.
> > > 
> > > The old function have been deprecated in commit e354bb84a4c1 ("PCI:
> > > Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()").
> > > 
> > > The remapping already takes or must take place in the driver that
> > > calls
> > > the function 'serial8250_pci_setup_port()'. The remapping should
> > > only be
> > > called once via 'pcim_iomap()'. Therefore the remapping moved to the
> > > caller of 'serial8250_pci_setup_port()'.
> > > 
> > > To replace the outdated/legacy iomap_table processing in
> > > '8250_pcilib' the
> > > function signature of 'serial8250_pci_setup_port()' has been
> > > extended with
> > > an already iomapped address value. So this can be used directly
> > > without
> > > io mapping again.
> > > 
> > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > > ---
> > > 
> > > v2:
> > > * The function 'pcim_iomap()' returns a NULL pointer in the event of
> > > an
> > >    error, so error handling has been adjusted.
> > 
> > LGTM now.
> > 
> > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> Thanks for the review tag. Will this be included in linux next?
> Or do I need to do something? I also think that this should be backportet
> to the latest LTS kernel “6.12.*”. This is where I noticed the problem.

The merge window is currently happening, I can't add any changes to my
tree until after that closes in 1 1/2 weeks.  And if you need/want it
backported to stable kernels, can you provide a "Fixes:" tag and a cc:
stable tag as well?

thanks,

greg k-h
