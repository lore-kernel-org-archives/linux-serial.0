From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] serial: SAMSUNG: Fix dev_name and driver_name
Date: Tue, 18 May 2010 06:36:45 +0100
Message-ID: <20100518053645.GN27571@trinity.fluff.org>
References: <4BF13ABA.3090504@samsung.com> <20100518024820.GK27571@trinity.fluff.org> <4BF20EED.5040306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:48486 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756553Ab0ERFgr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 May 2010 01:36:47 -0400
Content-Disposition: inline
In-Reply-To: <4BF20EED.5040306@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com

On Tue, May 18, 2010 at 12:52:13PM +0900, Joonyoung Shim wrote:
> On 5/18/2010 11:48 AM, Ben Dooks wrote:
> > On Mon, May 17, 2010 at 09:46:50PM +0900, Joonyoung Shim wrote:
> >> Thd dev_name and driver_name should be switched each other.
> > 
> > Hmm, this doesn't seem to have appeard on the linux-arm-kernel list yet.
> >  
> > Please provide some information about what problem that this is fixing
> > and the impact on any existing systems.
> > 
> 
> The serial device nodes are created to s3c2410_serial* on android 
> platform instead of ttySAC*.

This has been how they've been for ages, surely the android device node
creation sytstem supports symlinking /dev/SACx -> /dev/s3c2410_serialx,
like many other operating sysyerms that can already do this.

Changing this just because android (something as-yet unmerged into mainline)
does not like it. I'm not even happy with an #ifdef around this.

If you really feel this is a problem that you absolutely must fix in kernel
then please provide a kernel commandline option to change the serial driver
name and use that on any platform that needs it. Another way would be to
update the serial platform data to have a field for which name to choose.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

