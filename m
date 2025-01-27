Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17C126BEE;
	Mon, 27 Jan 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969226; cv=none; b=bVaMQtDEkYHARDt9J70ciYqF3K8QQ+eKFkMWSV4guPO3jfkGhtpDtgkrnTl6wHBnnNkTNNRsyR+SHjSaTVQV0uIHvktaXdoZl5KxLjr1FqyAZIel5n93lDVYuUpbHku9TvXupBg1+cUrFgnznRFE0cl1LquUyeJJue8wyx91EHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969226; c=relaxed/simple;
	bh=R0KvIRk4IHpGeBWAw6p6jfbW8+tx2JcHL5Fq4wcuTZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw3u2eC0lraw8StM4dIgoR71hzgz90QZ5eV0Jxo/aCGuhFoZAY9rGlkOcqcQ5izdfB0BOIpVrg1Ad7DtxORjzSNmMeaDAP4bPwqjHTO7dtQHOn6qMmaWmVyJTiyW4hBHvkvZaz2OjaQC97VPd1cRCCIjPFmAtFMWfiHrdLJLka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oax4Lrf0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oax4Lrf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03860C4CED2;
	Mon, 27 Jan 2025 09:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737969225;
	bh=R0KvIRk4IHpGeBWAw6p6jfbW8+tx2JcHL5Fq4wcuTZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oax4Lrf06zTTG38EAz6Ee98HuQfGW5UAQdl39QICOXS/JdOrqoKsWxfvhPtKmOA+B
	 ZxYWJBOycrHYrhe1p5ETutXJAJLRgMfcEebAA9YZ/knNwGNz3PAxKGsuGTaV2zej2Z
	 dfzsMBOWcjTZIYRcYxdj3rxtUgOYRNu5IKFsFIKU=
Date: Mon, 27 Jan 2025 10:12:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] serial: pic32: Fix build warning when CONFIG_OF is
 disabled
Message-ID: <2025012726-macaroni-unbiased-e6c3@gregkh>
References: <20250126163115.3200308-1-eleanor15x@gmail.com>
 <2025012604-undamaged-earring-d16c@gregkh>
 <Z5dD5Fz2vf-nnjvg@eleanor-wkdl>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5dD5Fz2vf-nnjvg@eleanor-wkdl>

On Mon, Jan 27, 2025 at 04:29:24PM +0800, Yu-Chun Lin wrote:
> On Sun, Jan 26, 2025 at 08:30:33PM +0100, Greg KH wrote:
> > On Mon, Jan 27, 2025 at 12:31:15AM +0800, Yu-Chun Lin wrote:
> > > As reported by the kernel test robot, the following warning occurs:
> > > 
> > > >> drivers/tty/serial/pic32_uart.c:904:34: warning: 'pic32_serial_dt_ids' defined but not used [-Wunused-const-variable=]
> > >      904 | static const struct of_device_id pic32_serial_dt_ids[] = {
> > >          |                                  ^~~~~~~~~~~~~~~~~~~
> > > 
> > > The 'pic32_serial_dt_ids' array is only used when CONFIG_OF is enabled.
> > > Wrapping its definition and 'MODULE_DEVICE_TABLE' in '#ifdef CONFIG_OF'
> > > prevents a compiler warning when OF is disabled.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202501260006.ecUsBidz-lkp@intel.com/
> > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > ---
> > >  drivers/tty/serial/pic32_uart.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
> > > index 14d50bd7f1bd..a228a55102c6 100644
> > > --- a/drivers/tty/serial/pic32_uart.c
> > > +++ b/drivers/tty/serial/pic32_uart.c
> > > @@ -948,11 +948,13 @@ static void pic32_uart_remove(struct platform_device *pdev)
> > >  	pic32_sports[sport->idx] = NULL;
> > >  }
> > >  
> > > +#ifdef CONFIG_OF
> > >  static const struct of_device_id pic32_serial_dt_ids[] = {
> > >  	{ .compatible = "microchip,pic32mzda-uart" },
> > >  	{ /* sentinel */ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, pic32_serial_dt_ids);
> > > +#endif
> > 
> > That should not be needed, no other bus requires this, please fix up the
> > use of the OF macros instead.
> 
> So I should remove of_match_ptr and add the CONFIG_OF as a dependency
> for the configuration. Correct?

I don't know, but putting #ifdef in .c files is not the correct solution
at all.

thanks,

greg k-h
