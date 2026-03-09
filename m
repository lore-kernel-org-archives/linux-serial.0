Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9903793BD;
	Mon,  9 Mar 2026 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055541; cv=none; b=l1cpiLkvSKKaGMQbCIlzYrFUhBl1kXWKqGEV9RgzdTL/gPXXzv00GFerXQGpmvaikZEGTcORLkhgkUhudfxblMLm8QeYob2Itq07gbFcBLkqT+PPezp7p6jrKwx5SVq70OzGaLRL0vRBY6Go7zBswMqVT8nxdNSU3Fm43NkbhRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055541; c=relaxed/simple;
	bh=bSuZZr55QS1721CinloAsTk5Na8KUkD++Kmlpm1grk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE9PiudAoheJzMu2GKgfctyRqNidwh6/ebONpcWJfF9Dd8r/eMkDKDYDFew5YFDhvE7bjESCfB5nVyV0T0pMAJxWww6FsLHnMKzcJT62ZC5jSFGFuffLgmQ4/975pE2VtILrNazi26d/W4Q18yJxzLY6Z9aaa86fLHpivQfFT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y1zL0x7C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y1zL0x7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC542C4CEF7;
	Mon,  9 Mar 2026 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773055541;
	bh=bSuZZr55QS1721CinloAsTk5Na8KUkD++Kmlpm1grk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1zL0x7C+eAvXbPvBIMT4LCiDLYXWinOnixefW4OcbJFEJPT3b5RTwXHOE8oOmgad
	 e32C19Z0OdcIQ1qtYkMrk7WDIRohN4vPNysCAoqwbGfkCFu2uO7BFZyO+ZZEq/lrpj
	 +Wrw0FNn3dAHhREWO2+HohwVKGgPRO6+VYi5lV0Y=
Date: Mon, 9 Mar 2026 12:25:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Jiri Slaby <jirislaby@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, duoming@zju.edu.cn,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsterba@suse.com, kuba@kernel.org, alexander.deucher@amd.com,
	akpm@linux-foundation.org, pkshih@realtek.com, tglx@kernel.org,
	mingo@kernel.org
Subject: Re: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during
 device removal
Message-ID: <2026030912-mutt-armchair-019c@gregkh>
References: <20260208062538.29608-1-duoming@zju.edu.cn>
 <2026020828-unretired-mannish-8465@gregkh>
 <41b47e38.6ddb4.19c3ccb8e4d.Coremail.duoming@zju.edu.cn>
 <2026020859-caretaker-duckbill-0fb3@gregkh>
 <p16239r9-692o-859r-6006-7o611r2rn2qs@xreary.bet>
 <20260209102117.GZ26902@suse.cz>
 <a77224d3-04d8-4a62-bb48-06fee922013c@kernel.org>
 <20260218152330.GI26902@suse.cz>
 <20260309111827.550-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309111827.550-1-dqfext@gmail.com>

On Mon, Mar 09, 2026 at 07:18:18PM +0800, Qingfang Deng wrote:
> Hi, David
> 
> On Wed, 18 Feb 2026 16:23:30 +0100, David Sterba wrote:
> > On Tue, Feb 17, 2026 at 09:03:25AM +0100, Jiri Slaby wrote:
> > > Hi,
> > > 
> > > On 09. 02. 26, 11:21, David Sterba wrote:
> > > > On Sun, Feb 08, 2026 at 06:25:38PM +0100, Jiri Kosina wrote:
> > > >> On Sun, 8 Feb 2026, Greg KH wrote:
> > > >>
> > > >>>> I don't have the real hardware. In order to reproduce the bug, I simulate
> > > >>>> the IPWireless PCMCIA card in the qemu by allocating and configuring the
> > > >>>> necessary resources(I/O ports, memory regions, interrupts and so on) to
> > > >>>> correspond with the hardware expected by the driver in the initialization
> > > >>>> code of the virtual device.
> > > >>>
> > > >>> I wonder if this device even is still around, given that pcmcia is all
> > > >>> but dead for a very long time.
> > > >>
> > > >> I doubt that this device is still around anywhere where reasonably new
> > > >> kernels (including LTS) would matter.
> > > >>
> > > >> I don't think I've seen this device (which was back then donated to me by
> > > >> T-Mobile CZ in order to get it supported in Linux, and I am not sure how
> > > >> much global adoption it got afterwards) for, let's say, past 15 years :)
> > > >>
> > > >> I think (let's see what David, ho took the maintainership over for me
> > > >> afterwards, has to say) we'd better deprecate and drop the whole thing,
> > > >> rather than trying to pretend that it's still actively being taken care
> > > >> of.
> > > > 
> > > > https://lore.kernel.org/all/20230223172403.GW10580@suse.cz/ last time
> > > > the question of keeping the driver was asked (2023). Back then I was
> > > > able to find the cards on second hand market but now I can't on a local
> > > > market and there's exactly one hit on global eBay.
> > > > 
> > > > Local linux related or telco support forums seem to mention the driver
> > > > until 2011 (root.cz, abclinuxu.cz, t-mobile.cz). It does not prove
> > > > nobody is using it but I think the chances are quite low to justify
> > > > keeping the driver.  It is simple enough to be built as an external
> > > > module eventually, I can help with that in case somebody really needs
> > > > that.
> > > 
> > > So, would you want to submit the removal? Or anyone else, if you don't 
> > > want to lose time with this? (I can do that, if noone wants to.)
> > 
> > Let me do it after rc1 so I can finish the journey of this driver which
> > was my first nontrivial contribution to linux kernel.
> 
> I found a memory leak in the driver:
> 
> - https://lore.kernel.org/linux-serial/20260306034058.386747-1-dqfext@gmail.com/T/
> 
> The bug has been present since the first version of this driver, but it
> seems no one has noticed it until now. So I believe the driver has not
> been actively used.

A small memory leak like that will probably not be noticed at all, so I
don't think that shows how many people are using the driver, sorry.

greg k-h
