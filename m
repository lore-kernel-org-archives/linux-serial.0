Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC1149C4D;
	Mon, 16 Sep 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482404; cv=none; b=Zs9FYuAoMPu1n9cJ9l4vzwrR5wlNTII41UVRahzLB6NAq1i6fXhbCTq5DnHeENKmW5pxY5pyxe32MgcqBpatNAm/Nkv/n45LMXQagswSV4KSO/CosmgRLGnNH2QqwkLL0P+MoblOXad5qyNes0EgenCEGCR2NvYUMJedjbGeHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482404; c=relaxed/simple;
	bh=tuiiejCLYekPYzX/9j6m5RNIAqec/N9ey5RiZ7ZTINE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVj5UpAcF1BCbIZtND1s04Tcn6Un6aUy8/L674SIUV/lTOOAN2S2qTdkQJcEFRVvMn1RvD+576trVsajrpM0txaTndYqkwJPfB2TupaW8uWoTuYqz3F+wYm0m9Z6fBnf5Qw/TkdVmGez4kSlMOZjlk6+JUhU9h8NoF1xYHhf578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r11uJGg3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r11uJGg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B0C4CEC4;
	Mon, 16 Sep 2024 10:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726482403;
	bh=tuiiejCLYekPYzX/9j6m5RNIAqec/N9ey5RiZ7ZTINE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r11uJGg3I12uRlfUXmbvjnxx5Q1ZMHGVRFfq8JoTzIhauHEEkKHJbFT9shMaRj+vg
	 U7+Zn96OTebvApPfGbSgvwtrtnUygHNwOb/zqwZ/OWVwQOUVzU9JdvPiOgGLdALQrI
	 XzHvlBbK4tTK5i/QE4ZnD2D7P8OyHTgiOCfdZo5c=
Date: Mon, 16 Sep 2024 12:25:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <parker@finest.io>, Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <2024091632-oboe-subfloor-afc8@gregkh>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
 <2024091438-charity-borough-54b3@gregkh>
 <ZugAeVWeMZGtjYme@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZugAeVWeMZGtjYme@smile.fi.intel.com>

On Mon, Sep 16, 2024 at 12:55:05PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 14, 2024 at 08:58:50PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:
> 
> ...
> 
> > > -			printk(KERN_ERR "%s: timeout\n", __func__);
> > > +			pr_err("%s: timeout\n", __func__);
> > 
> > It's a device, please use dev_err().
> 
> The problem is that this library doesn't know about this fact. I.e. it would
> need a new member just for this message. Instead, maybe drop the message as we
> anyway get a unique enough error code?

Fair enough, although adding real device pointers would be good to do in
the future...

thanks,

greg k-h
