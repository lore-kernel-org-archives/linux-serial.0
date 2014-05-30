From: "Valerio Vanni" <valerio.vanni@inwind.it>
Subject: Re: serial console does not wake from S3 suspend
Date: Fri, 30 May 2014 11:53:14 +0200
Message-ID: <7EC4C3FDEFF6492F91DEE16AEE0831E6@vanni.it>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, baryluk@smp.if.uj.edu.pl, davem@davemloft.net, peter@hurleysoftware.com, rjw@rjwysocki.net, aaron.lu@intel.com, tianyu.lan@intel.com
List-Id: linux-serial@vger.kernel.org

> When resuming from S3 suspend, serial console starts sending garbage
> on the serial port.
> Not continuously, it sends garbage only when in local console prints a
> text.
> It stops only when the (sending) machine is shut down, or if some
> text is sent manually (i.e. with "cat txtfile > /dev/ttyS0").
> 
> Full details are here:
> https://bugzilla.kernel.org/show_bug.cgi?id=69751

The problem is still present in 3.14.4, 3.15-rc7 and today's next.

I hope someone is going to look at this bug.
