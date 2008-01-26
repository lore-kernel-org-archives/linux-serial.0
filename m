From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: How to use serial ports from a kernel module.
Date: Sat, 26 Jan 2008 21:41:05 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801262138470.3642@axis700.grange>
References: <1201375164.3368.6.camel@wirenth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43440 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753580AbYAZUlF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 26 Jan 2008 15:41:05 -0500
In-Reply-To: <1201375164.3368.6.camel@wirenth>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: ian <spyro@f2s.com>
Cc: linux-serial@vger.kernel.org

On Sat, 26 Jan 2008, ian wrote:

> I'd like to use one of the serial ports on my embedded device from a
> module (so I can write an input driver for the buttonpad on my PDA).
> 
> I need to be able to set the data type to 8O1 and set the port speed,
> and send and receive data.
> 
> Whats the proper way to do this? Ideally I'd want to prevent userspace
> being able to use the port which has the keypad connected, but not touch
> the other two ports.

You need to write a line discipline... have a look here: 
http://www.linux.it/~rubini/docs/serial/serial.html

Thanks
Guennadi
---
Guennadi Liakhovetski
