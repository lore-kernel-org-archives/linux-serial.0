From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V8 2/2] serial/uart/8250: Add tunable RX interrupt
 trigger I/F of FIFO buffers
Date: Thu, 10 Jul 2014 15:31:57 +0100
Message-ID: <20140710153157.57902972@alan.etchedpixels.co.uk>
References: <20140530061617.21929.25777.stgit@yunodevel>
	<20140530061622.21929.82083.stgit@yunodevel>
	<20140710002837.GA5429@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:40924 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbaGJOcc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Jul 2014 10:32:32 -0400
In-Reply-To: <20140710002837.GA5429@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Stephen Warren <swarren@nvidia.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, linux-serial@vger.kernel.org, yrl.pp-manager.tt@hitachi.com, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Aaron Sierra <asierra@xes-inc.com>, Jiri Slaby <jslaby@suse.cz>

> I really don't like the way that the tty core has been changed to handle
> multiple attribute groups, as I feel tty drivers shouldn't be creating
> "special" sysfs files, depending on what driver is bound to them.

The intent isn't that it is "special" but that it can be propogated to
others as and when they wish to provide it.
 
> Usually we have handled this using tools like 'stty' and ioctls, right?
> Surely there is an ioctl to control the interrupt level, right?  Hasn't
> this been covered before somehow?

No, and the direction when this started was to use sysfs as we have also
been moving all the other attributes towards sysfs and has been since
2012.

TTY devices do have lots of strange attributes and right now many of them
are only programmable by using device tree and rebooting.

Alan
