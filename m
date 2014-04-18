From: Greg KH <greg@kroah.com>
Subject: Re: How can I help?
Date: Fri, 18 Apr 2014 16:19:40 -0700
Message-ID: <20140418231940.GA3833@kroah.com>
References: <8A1E86F6-47F2-44A7-A8DB-8A643FE9796B@usgs.gov>
 <20140418220903.GA22429@kroah.com>
 <E4E661B3-7296-4666-8A59-D9D52BC3D6D0@usgs.gov>
 <20140418224357.GA32442@kroah.com>
 <AD1ED14D-A603-4E02-8A2E-4E5113E20FBD@usgs.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60005 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754491AbaDRXTf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 19:19:35 -0400
Content-Disposition: inline
In-Reply-To: <AD1ED14D-A603-4E02-8A2E-4E5113E20FBD@usgs.gov>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Larry Baker <baker@usgs.gov>
Cc: linux-serial@vger.kernel.org

On Fri, Apr 18, 2014 at 04:11:26PM -0700, Larry Baker wrote:
> Greg,
> 
> On 18 Apr 2014, at 3:43 PM, Greg KH wrote:
> 
> > On Fri, Apr 18, 2014 at 03:37:53PM -0700, Larry Baker wrote:
> >> Greg,
> >> 
> >> Any suggestions how to trace what is going on?
> > 
> > Going on with what?  Was there a bug report in that wall of text that I
> > missed?  :)
> 
> "It sort of works.  What happens is, after about 8 or 9 hours, the RX
> to the TTY port times out.  Sometimes it happens in only an hour,
> other times it takes about 14 hours."
> 
> "I am suspicious, for example, that the CTS grant is getting lost."
> 
> Should I report this on the linux-usb@vger.kernel.org mailing list?

Yes, that would be good.

But failures like this is going to be hard to track down, as you said,
how do you know it's not just the uart in the chip that drops this?

These chips are really not meant to be run all the time like this, with
constant data streams.  They are really cheep chips.

I'd go buy a few different types, of different cores, and try to find
one that works for your workload.  That's going to be the simplest, and
probably cheapest, way to do this.

best of luck,

greg k-h
