From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Stable kernel 3.8.4/3.9-rc3 breaks PNP serial port
Date: Tue, 2 Apr 2013 09:23:36 -0700
Message-ID: <20130402162336.GB318@kroah.com>
References: <20130402155344.GA29980@hansolo.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:42715 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553Ab3DBQXi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Apr 2013 12:23:38 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so260212dae.3
        for <linux-serial@vger.kernel.org>; Tue, 02 Apr 2013 09:23:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130402155344.GA29980@hansolo.jdub.homelinux.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Josh Boyer <jwboyer@redhat.com>, Sean Young <sean@mess.org>
Cc: Jiri Slaby <jslaby@suse.cz>, tkil@scrye.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 02, 2013 at 11:53:44AM -0400, Josh Boyer wrote:
> Hi All,
> 
> We've had a report [1] that the 3.8.4 stable kernel makes a PNP serial
> port stop working.  After testing 3.8.3, the reporter narrowed it down
> to stable commit eec98f82c637 (tty/8250_pnp: serial port detection
> regression since v3.7) (upstream commit 77e372a3d82).  Reverting that
> single commit from 3.8.5 allows the serial port to continue working.
> 
> The machine in question is using an AMI UEFI implementation as the
> firmware, and on 3.8.3 the serial port has the following in
> /sys/bus/pnp/devices/00:0a/resources
> 
> 	state = active
> 	io disabled
> 	irq 4
> 	dma disabled
> 
> With 3.8.[45], the same file has:
> 
> 	state = disabled
> 	io disabled
> 	irq 4
> 	dma disabled
> 
> In both cases, the io and dma resources are disabled, and an IRQ is
> assigned.  However, the state remains active for the port on 3.8.3.
> 
> The offending commit mentions this is a BIOS bug from InsydeH2O and that
> the port is bogus in that case, but we have something similar here with
> an AMI UEFI implementation (Version: 0406 Release Date: 06/06/2012)
> where the port isn't bogus.
> 
> I'm not sure exactly what the solution should be here.  Any thoughts?

Sean, should I just revert this patch now, and wait for a better fix
later?

thanks,

greg k-h
