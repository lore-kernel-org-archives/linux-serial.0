Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD435A948;
	Sun,  8 Feb 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770562684; cv=none; b=ZAJdP/2+dn94QxbL/fxP6Y24z9mceM7kgmH9RIdIFcUMa6lTYOuFKylJrCnRWggSDf1C9s4zqpgjKV8eSXmPmWXRfr9Ts1rjf5cNuYktDyNK94JjLybS9mJTLKyIUGmxEgb/vpzoZUO+YbmGDuNiiriR2e9iwYj5kmRN2MGbw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770562684; c=relaxed/simple;
	bh=hOk2byfPQZRwPxqdq7JgTR4yzfFktsHBAFdN9WwKYpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAuplGuF4B+98vYUVuHTKNrWYexiHSefAsvjQTB8J6BOXQ1JIFh7j02oG1dVv0Q0b1Y2kp/+ubyN9ROUOeiVZPCxAeRQPR0ibS+pJ/C3uVJnR2289XkuZMO2160gu41xWfZfz1g+ZdOSYGWp64g39Vueq+V5zE3bFxelLLHtI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ToW9U7kl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ToW9U7kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF690C4CEF7;
	Sun,  8 Feb 2026 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770562683;
	bh=hOk2byfPQZRwPxqdq7JgTR4yzfFktsHBAFdN9WwKYpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToW9U7kl/afZbZPBTHOgVpxf6hoekt/n3eKbzntE0QkzgSoHEsJOQb5iPTIhJ9+RY
	 kRNlGYePvHd/CyiMzERItvgqHb4kKxlhdi32I65VbI0Q3uKcfkJ6icuW+svoZDllSg
	 3WhecM1qbgNkfOLpR1WqFgOLysB8DEeGdufNLJ/c=
Date: Sun, 8 Feb 2026 15:58:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: duoming@zju.edu.cn
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	jikos@kernel.org, dsterba@suse.com, jirislaby@kernel.org,
	kuba@kernel.org, alexander.deucher@amd.com,
	akpm@linux-foundation.org, pkshih@realtek.com, tglx@kernel.org,
	mingo@kernel.org
Subject: Re: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during
 device removal
Message-ID: <2026020853-revered-charging-719f@gregkh>
References: <20260208062538.29608-1-duoming@zju.edu.cn>
 <2026020828-unretired-mannish-8465@gregkh>
 <41b47e38.6ddb4.19c3ccb8e4d.Coremail.duoming@zju.edu.cn>
 <2026020859-caretaker-duckbill-0fb3@gregkh>
 <777dbdbf.6d6f0.19c3d8b1a1c.Coremail.duoming@zju.edu.cn>
 <2026020814-aorta-reptilian-e91a@gregkh>
 <7ece79f6.6d747.19c3dbe4a1f.Coremail.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ece79f6.6d747.19c3dbe4a1f.Coremail.duoming@zju.edu.cn>

On Sun, Feb 08, 2026 at 10:53:26PM +0800, duoming@zju.edu.cn wrote:
> On Sun, 8 Feb 2026 15:34:49 +0100 Greg KH wrote:
> > > > > > > When IPWireless PCMCIA card is being detached, the ipw_hardware is
> > > > > > > deallocated in ipwireless_hardware_free(). However, the hw->tasklet may
> > > > > > > still be running or pending, leading to use-after-free bugs when the
> > > > > > > already freed ipw_hardware is accessed again in ipwireless_do_tasklet().
> > > > > > 
> > > > > > Nice, do you have this hardware to test this with?
> > > > > 
> > > > > I don't have the real hardware. In order to reproduce the bug, I simulate 
> > > > > the IPWireless PCMCIA card in the qemu by allocating and configuring the 
> > > > > necessary resources(I/O ports, memory regions, interrupts and so on) to
> > > > > correspond with the hardware expected by the driver in the initialization 
> > > > > code of the virtual device.
> > > > 
> > > > I wonder if this device even is still around, given that pcmcia is all
> > > > but dead for a very long time.
> > > > 
> > > > > > > One race condition scenario is as follows:
> > > > > > > 
> > > > > > > CPU 0 (cleanup)               | CPU 1 (interrupt)
> > > > > > > ipwireless_hardware_free()    | ipwireless_interrupt()
> > > > > > >   ipwireless_stop_interrupts()|   ipwireless_handle_v1_interrupt()
> > > > > > >     do_close_hardware()       |     tasklet_schedule()
> > > > > > >       synchronize_irq()       |
> > > > > > >   kfree(hw) //FREE            | ipwireless_do_tasklet() //handler
> > > > > > >                               |   hw = from_tasklet() //USE
> > > > > > >                               |   hw-> //USE
> > > > > > > 
> > > > > > > Fix this by ensuring hw->tasklet is properly canceled before ipw_hardware
> > > > > > > is released. Add tasklet_kill() in ipwireless_stop_interrupts() to
> > > > > > > synchronize with any pending or running tasklet. Since do_close_hardware()
> > > > > > > could prevent further interrupts, place tasklet_kill() after it to avoid
> > > > > > > the tasklet being rescheduled by ipwireless_interrupt().
> > > > > > 
> > > > > > How was this issue found and tested?
> > > > > 
> > > > > The issue was found by static analysis. I test it through the following steps:
> > > > > 1. Simulating the IPWireless PCMCIA device in the qemu and enable it to trigger interrupts.
> > > > > 2. Controlling the removal and attachment of device via sysfs.
> > > > 
> > > > So this is with the bind/unbind logic, or some other way?  If you are
> > > > unloading the driver, that is something that only root can do, and this
> > > > is a debugging facility, not a "real" way to control drivers and devices
> > > > (yes, the virt drivers abuse this to no end, every time I see this I
> > > > laugh...)
> > > 
> > > When the PCMCIA device is attached, we can operate the file
> > > /sys/bus/pcmcia/devices/.../remove to detach the device.
> > 
> > 'remove' should be removing the driver from the device, something that
> > is only allowed by root and is not a normal operation at all.  race
> > conditions there are "at your own risk" for all drivers as it's pretty
> > much the same as unloading the module, it is there for developer ease
> > only.
> 
> I did this only to verify the existence of the bug. In real word scenarios,
> the device removal code can be triggered by removing the real pcmcia hardware.

How?  Doesn't the interrupt not happen, and the device get cleaned up by
the bus when it is noticed and then removed?  ipwireless_hardware_free()
should not be called if ipwireless_interrupt() is ever happening in that
case just by virtue of the fact that the interrupt will not be there.

> > > > > 3. Triggering interrupts by writing data to device registers via /dev/mem memory mapping
> > > > >    in userspace.
> > > > 
> > > > Interrupts would not happen if the device is removed.  Or is this only
> > > > if the driver is unbound?
> > > 
> > > The interrupts should be triggered before the deivce is removed.
> > 
> > But when the device is physically removed from the system, no more
> > interrupts will happen.
> 
> I think the tasklet is a deferred mechanism. Although interrupts cannot
> happen after device is removed, the tasklet handler may still be executing
> or pending. This is why tasklet_kill() needs to be added.

Ok, there might be a small race, but given that no one has ever seen
this with real hardware (and you need physical access for it), it's
pretty small.  But again, I'll let the maintainers here decide if it
should be accepted or not.

thanks,

greg k-h
