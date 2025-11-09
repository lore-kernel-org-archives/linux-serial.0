Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BEC1925BC;
	Sun,  9 Nov 2025 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762650854; cv=none; b=LKY8/aCIfLHvdWjPGJ1XkdeFQL9Ml9MNj1IFMRFX6jn19n4SmdiBYjr5H0AvhP4DT93xG1TiHQ0SaTkCGDHxoOIAr7jb5gtYLe4fRFtqgr3ThZvYFHc2nzq4EcZEg+t5ynDexMhMbS3kEQnK0xDmmNp2IEYAXf9Fx1qupqSf/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762650854; c=relaxed/simple;
	bh=TbNj6GYPbm6qdt0QlpsEYV6u2D3QDP7IcXUOH4BFRlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGtUb6LmbJa4CUt0ZCiUPYjlAH/uj3eKyWe0frrVD0DMXTdh01ohzkLmxS5nPyH8XvwrwCN2n8XKONmEObFoA7oJFGvnz/8A90Iypnqx2uIcUz4dWU/FJ2/PtBLQJUWkvnsBk/ESDCj71ibYlxRgebGEXMHBRV9AF3yz2gPTGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dzX/M/oI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dzX/M/oI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5D8C113D0;
	Sun,  9 Nov 2025 01:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762650854;
	bh=TbNj6GYPbm6qdt0QlpsEYV6u2D3QDP7IcXUOH4BFRlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzX/M/oI+gyDXlFTzG7OjQShMrlV8bzeCj7PrSUjAAh/u5+EkAfJndLrL7bQFBe/O
	 eTa9/fYfUnWQcKbRPu0Ja2z6YsUfjMSSNEYjnkLkzkg0LVhdNL9lNtsBfgg9oa0iIY
	 PylPfiWBHbz6u60rNX/hoh/5rf15NnoVa37oc/As=
Date: Sun, 9 Nov 2025 09:49:29 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephen Rothwell <sfr@rothwell.id.au>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alex Davis <alex47794@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Borislav Petkov <bp@alien8.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
Message-ID: <2025110956-swaddling-chapter-5932@gregkh>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com>
 <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local>
 <aQzJveMYT6O3EHeK@smile.fi.intel.com>
 <20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local>
 <3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
 <ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com>
 <82e2ce7f-bd08-4b53-b232-3dd8cb1a0726@kernel.org>
 <20251109105203.622ebe9e@pine.rothwell.emu.id.au>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251109105203.622ebe9e@pine.rothwell.emu.id.au>

On Sun, Nov 09, 2025 at 10:52:03AM +1100, Stephen Rothwell wrote:
> Hi Jiri,
> 
> On Fri, 7 Nov 2025 07:20:26 +0100 Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > On 06. 11. 25, 19:00, Ilpo Järvinen wrote:
> > > This seems to resolve the build issue for me:
> > > 
> > > --
> > > From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
> > > Subject: [PATCH 1/1] serial: 8250: Fix 8250_rsa symbol loop
> > > 
> > > make allmodconfig build fails due to dependency loop:
> > > 
> > >    depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> > >    depmod: ERROR: Found 2 modules in dependency cycles!
> > > 
> > > Break dependency loop by moving 8250_rsa.o into 8250_base and by
> > > passing univ8250_port_base_ops to univ8250_rsa_support() that can make
> > > a local copy of it.
> > > 
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Reported-by: Alex Davis <alex47794@gmail.com>
> > > Fixes: b20d6576cdb3 ("serial: 8250: export RSA functions")
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>  
> > 
> > LGTM, thanks for the fix.
> > 
> > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> > 
> > If the reporters could give it a shot and mark this by Tested-by, it would be great...
> 
> I have not seen this for quite some time ... I assumed it had been
> fixed.

I too thought this was fixed a while ago, what changed to cause this to
happen now?  Anyone have a .config to reproduce this, 'allmodconfig' on
x86 works for me.

greg k-h
