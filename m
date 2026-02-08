Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4212BF3D7;
	Sun,  8 Feb 2026 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561293; cv=none; b=KBVPn0VJpVjYW3RkdLKs2Rj3403b9T3rIz+394GsaoM2njzsYGqnDky5qugui9xHTCRzfZXAJ3AHc+dCKeq07Fw/KPMzgoN2bLiLR4R6QmhyTVK/n3b3ibBhWz1V+2rhoMR7+gtCsyhqZQ0q5SuVwlvIEr1s4wa95UAETM2fbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561293; c=relaxed/simple;
	bh=dBEV0r3GyVSudeXoQ0gF7O7y3J492c9XPTMdURIjE6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb6fs/y9y6H420hDly4nrCEpNDZXtzL9k7Yfy2b8WEdI5sxB0jkNsxlYzsoLxAxcLGPZDvEUHSENtl6IEmM8ywLDk8bONNLj496mohuHEMshnYqGnpXMKjTq6s25OBo9w1jXuGsppBLCYrPCwEt7I8pS/+boAHF9XR4J5NSi1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=szbQ10T6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="szbQ10T6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A755C4CEF7;
	Sun,  8 Feb 2026 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770561292;
	bh=dBEV0r3GyVSudeXoQ0gF7O7y3J492c9XPTMdURIjE6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szbQ10T6pxf8l90ZkEUZObZ9zyT0yfyZH4ChN61KlQ4di4v1i8rMjIZbhjdSfpqjV
	 YTKnJZ62wMpihdr7k9aLALZHfrHo6W5NKMgtRFUh5qntvvaVcJMu41I46bouofGN+Q
	 G1R8J4agPc5SwnzRJjGbk5ZLFfVkfcK5j8MgMjzs=
Date: Sun, 8 Feb 2026 15:34:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: duoming@zju.edu.cn
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	jikos@kernel.org, dsterba@suse.com, jirislaby@kernel.org,
	kuba@kernel.org, alexander.deucher@amd.com,
	akpm@linux-foundation.org, pkshih@realtek.com, tglx@kernel.org,
	mingo@kernel.org
Subject: Re: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during
 device removal
Message-ID: <2026020814-aorta-reptilian-e91a@gregkh>
References: <20260208062538.29608-1-duoming@zju.edu.cn>
 <2026020828-unretired-mannish-8465@gregkh>
 <41b47e38.6ddb4.19c3ccb8e4d.Coremail.duoming@zju.edu.cn>
 <2026020859-caretaker-duckbill-0fb3@gregkh>
 <777dbdbf.6d6f0.19c3d8b1a1c.Coremail.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777dbdbf.6d6f0.19c3d8b1a1c.Coremail.duoming@zju.edu.cn>

On Sun, Feb 08, 2026 at 09:57:32PM +0800, duoming@zju.edu.cn wrote:
> On Date: Sun, 8 Feb 2026 12:00:08 +0100 Greg KH wrote:
> > > > > When IPWireless PCMCIA card is being detached, the ipw_hardware is
> > > > > deallocated in ipwireless_hardware_free(). However, the hw->tasklet may
> > > > > still be running or pending, leading to use-after-free bugs when the
> > > > > already freed ipw_hardware is accessed again in ipwireless_do_tasklet().
> > > > 
> > > > Nice, do you have this hardware to test this with?
> > > 
> > > I don't have the real hardware. In order to reproduce the bug, I simulate 
> > > the IPWireless PCMCIA card in the qemu by allocating and configuring the 
> > > necessary resources(I/O ports, memory regions, interrupts and so on) to
> > > correspond with the hardware expected by the driver in the initialization 
> > > code of the virtual device.
> > 
> > I wonder if this device even is still around, given that pcmcia is all
> > but dead for a very long time.
> > 
> > > > > One race condition scenario is as follows:
> > > > > 
> > > > > CPU 0 (cleanup)               | CPU 1 (interrupt)
> > > > > ipwireless_hardware_free()    | ipwireless_interrupt()
> > > > >   ipwireless_stop_interrupts()|   ipwireless_handle_v1_interrupt()
> > > > >     do_close_hardware()       |     tasklet_schedule()
> > > > >       synchronize_irq()       |
> > > > >   kfree(hw) //FREE            | ipwireless_do_tasklet() //handler
> > > > >                               |   hw = from_tasklet() //USE
> > > > >                               |   hw-> //USE
> > > > > 
> > > > > Fix this by ensuring hw->tasklet is properly canceled before ipw_hardware
> > > > > is released. Add tasklet_kill() in ipwireless_stop_interrupts() to
> > > > > synchronize with any pending or running tasklet. Since do_close_hardware()
> > > > > could prevent further interrupts, place tasklet_kill() after it to avoid
> > > > > the tasklet being rescheduled by ipwireless_interrupt().
> > > > 
> > > > How was this issue found and tested?
> > > 
> > > The issue was found by static analysis. I test it through the following steps:
> > > 1. Simulating the IPWireless PCMCIA device in the qemu and enable it to trigger interrupts.
> > > 2. Controlling the removal and attachment of device via sysfs.
> > 
> > So this is with the bind/unbind logic, or some other way?  If you are
> > unloading the driver, that is something that only root can do, and this
> > is a debugging facility, not a "real" way to control drivers and devices
> > (yes, the virt drivers abuse this to no end, every time I see this I
> > laugh...)
> 
> When the PCMCIA device is attached, we can operate the file
> /sys/bus/pcmcia/devices/.../remove to detach the device.

'remove' should be removing the driver from the device, something that
is only allowed by root and is not a normal operation at all.  race
conditions there are "at your own risk" for all drivers as it's pretty
much the same as unloading the module, it is there for developer ease
only.

> > > 3. Triggering interrupts by writing data to device registers via /dev/mem memory mapping
> > >    in userspace.
> > 
> > Interrupts would not happen if the device is removed.  Or is this only
> > if the driver is unbound?
> 
> The interrupts should be triggered before the deivce is removed.

But when the device is physically removed from the system, no more
interrupts will happen.

thanks,

greg k-h
