From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: tty loop-back device
Date: Sat, 28 Sep 2013 16:03:20 +0000 (UTC)
Message-ID: <l26uk7$id2$2@ger.gmane.org>
References: <l26jrq$48d$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39471 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754339Ab3I1QDk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Sep 2013 12:03:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1VPwza-0004nz-QM
	for linux-serial@vger.kernel.org; Sat, 28 Sep 2013 18:03:38 +0200
Received: from c-24-118-110-103.hsd1.mn.comcast.net ([24.118.110.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sat, 28 Sep 2013 18:03:38 +0200
Received: from grant.b.edwards by c-24-118-110-103.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sat, 28 Sep 2013 18:03:38 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-09-28, Matwey V. Kornilov <matwey.kornilov@gmail.com> wrote:

> Not sure whether here is the right place to ask. Do the kernel already 
> has (or, would it be great to have) the tty loop-back support? At least 
> I've not found something appropriate. I mean, imagine kind of /dev/tty 
> device, supporting read/write and termios interface and transferring 
> your read/write/ioctl calls to another user-space application listening, 
> for instance, /dev/tty_loopback_master. Like a named pipe device.

What you're talking about is pretty much the existing pty device.

Unfortunately, Linux pty's only support a subset of the serial port
API, so they can't be used for applications like network-connected
serial ports.  So people like me have to write kernel-mode drivers for
such devices.

I've suggested extending the Linux pty so that it _does_ support the
rest of the serial port API.  I even offered to work on it if the
results would likely be accepted into the kernel tree, but my
questions/offers have never gotten any response.

-- 
Grant



