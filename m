From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: How to use serial ports from a kernel module.
Date: Sat, 26 Jan 2008 23:37:09 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801262333250.7261@axis700.grange>
References: <1201375164.3368.6.camel@wirenth>  <Pine.LNX.4.64.0801262138470.3642@axis700.grange>
 <1201386616.3368.10.camel@wirenth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:51918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752460AbYAZWhH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 26 Jan 2008 17:37:07 -0500
In-Reply-To: <1201386616.3368.10.camel@wirenth>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: ian <spyro@f2s.com>
Cc: linux-serial@vger.kernel.org

On Sat, 26 Jan 2008, ian wrote:

> 
> On Sat, 2008-01-26 at 21:41 +0100, Guennadi Liakhovetski wrote:
> 
> > You need to write a line discipline... have a look here: 
> > http://www.linux.it/~rubini/docs/serial/serial.html
> 
> Hi,
> 
> Thanks for the reply!
> 
> What I cant see from that is how one can avoid touching userspace at all
> - as far as I can see, only userspace can actually attach a line
> discipline to a serial port. I'd like to have this happen in the kernel
> so that I dont need some program sitting idly opening the serial device
> the whole time.

Right, you need a user-space daemon for that. In your original post you 
only said

> > Ideally I'd want to prevent userspace being able to use the port which 
> > has the keypad connected, but not touch the other two ports.

which I understood as "I want to lock this port, and leave the rest 
untouched" and not as "avoid touching userspace at all". I don't think 
you can do it without a user-space programme.

Thanks
Guennadi
---
Guennadi Liakhovetski
