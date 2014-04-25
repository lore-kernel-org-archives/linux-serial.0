From: Greg KH <greg@kroah.com>
Subject: Re: Line Discipline Kernel BUG when using usb-serial and mos7840 in
 v3.11
Date: Fri, 25 Apr 2014 11:20:25 -0700
Message-ID: <20140425182025.GA6331@kroah.com>
References: <CAEBke53+w73+hBmNpafnaY9dYps=JayZGjYz2E=BrmTFsOfVmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60955 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751342AbaDYSRd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 14:17:33 -0400
Content-Disposition: inline
In-Reply-To: <CAEBke53+w73+hBmNpafnaY9dYps=JayZGjYz2E=BrmTFsOfVmg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Coleman Brumley <coleman.brumley@gmail.com>
Cc: linux-serial@vger.kernel.org

On Fri, Apr 25, 2014 at 11:05:54AM -0400, Coleman Brumley wrote:
> I'm working with a line discipline in v3.11.10.5 in Ubuntu 12.04 LTS.
> The kernel has been modified to use a HZ of 1000. CONFIG_HZ_1000=y and
> CONFIG_HZ=1000 in .config.

3.11 is really old, can you try something that we can actually do
something about, like 3.14 or Linus's tree?

Also, do you have a pointer to your line discipline code anywhere?
There's been lots of changes in the tty layer over the past year or so.
Odds are, you need to update your code to reflect the changes that we
have made.

Along those lines, why isn't your code merged into the main kernel tree?
If you submit it, changes like this would be done automatically for you.

thanks,

greg k-h
