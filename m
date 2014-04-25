From: Greg KH <greg@kroah.com>
Subject: Re: Line Discipline Kernel BUG when using usb-serial and mos7840 in
 v3.11
Date: Fri, 25 Apr 2014 12:24:05 -0700
Message-ID: <20140425192405.GA32455@kroah.com>
References: <CAEBke53+w73+hBmNpafnaY9dYps=JayZGjYz2E=BrmTFsOfVmg@mail.gmail.com>
 <20140425182025.GA6331@kroah.com>
 <CAEBke535FyNouGNg+2A3jeyO+F_Mfj8KG822SXBbH_rSzWm_6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38652 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754308AbaDYTVN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 15:21:13 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 21A44215FD
	for <linux-serial@vger.kernel.org>; Fri, 25 Apr 2014 15:21:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAEBke535FyNouGNg+2A3jeyO+F_Mfj8KG822SXBbH_rSzWm_6A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Coleman Brumley <coleman.brumley@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Fri, Apr 25, 2014 at 03:09:16PM -0400, Coleman Brumley wrote:
> 
> 
> On Friday, April 25, 2014, Greg KH <greg@kroah.com> wrote:
> 
>     On Fri, Apr 25, 2014 at 11:05:54AM -0400, Coleman Brumley wrote:
>     > I'm working with a line discipline in v3.11.10.5 in Ubuntu 12.04 LTS.
>     > The kernel has been modified to use a HZ of 1000. CONFIG_HZ_1000=y and
>     > CONFIG_HZ=1000 in .config.
> 
>     3.11 is really old, can you try something that we can actually do
>     something about, like 3.14 or Linus's tree
> 
> 
> I can do that, it was just that 3.11 is what Ubuntu gave me.

We can't do anything with what Ubuntu gave you :)

>     Also, do you have a pointer to your line discipline code anywhere?
>     There's been lots of changes in the tty layer over the past year or so.
> 
> 
> Can you point me to a document that outlines the changes, or a how to for
> writing a line discipline for 3.14?

Look at the kernel changes made from your last working version to today.
It's all in our git history, no need for a "document".

best of luck,

greg k-h
