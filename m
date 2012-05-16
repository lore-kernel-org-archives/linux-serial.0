From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Excessive logging causing rcu_sched_state stall (wait_for_xmitr
 8250.c)
Date: Wed, 16 May 2012 08:12:06 -0700
Message-ID: <20120516151206.GA9153@kroah.com>
References: <1337128888.46194.YahooMailNeo@web160804.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61831 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab2EPPMK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 May 2012 11:12:10 -0400
Received: by dady13 with SMTP id y13so1104958dad.19
        for <linux-serial@vger.kernel.org>; Wed, 16 May 2012 08:12:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337128888.46194.YahooMailNeo@web160804.mail.bf1.yahoo.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: joe shmoe <joeshmoeypeter@yahoo.com>
Cc: linux-serial@vger.kernel.org

On Tue, May 15, 2012 at 05:41:28PM -0700, joe shmoe wrote:
> Hi, 
> It's been more than a week since I am stuck with this. I am relatively a newbie venturing into linux 
> kernel, so please be gentle. 
> 
> I have a non-tained 2.6.35.14 kernel that needs to output a lot using the serial console. To reproduce I 
> simply run klogd -2 -c 7 and this causes rcu_sched_state to detect stall with a trace such as pasted 
> below. 

Does running 3.3, or 3.4-rc6 show the same problems?  I ask as 2.6.35
really is very old and not supported much at all, and tens of thousands
of changes to the kernel have happened since then.

So if you could check the latest kernel, that would be great.

thanks,

greg k-h
