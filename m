From: Larry Baker <baker@usgs.gov>
Subject: Re: How can I help?
Date: Fri, 18 Apr 2014 16:11:26 -0700
Message-ID: <AD1ED14D-A603-4E02-8A2E-4E5113E20FBD@usgs.gov>
References: <8A1E86F6-47F2-44A7-A8DB-8A643FE9796B@usgs.gov> <20140418220903.GA22429@kroah.com> <E4E661B3-7296-4666-8A59-D9D52BC3D6D0@usgs.gov> <20140418224357.GA32442@kroah.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from SMTP5.doi.gov ([137.227.28.11]:29603 "EHLO smtp5.doi.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaDRXLb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 19:11:31 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so1841251pdi.2
        for <linux-serial@vger.kernel.org>; Fri, 18 Apr 2014 16:11:29 -0700
 (PDT)
In-Reply-To: <20140418224357.GA32442@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

Greg,

On 18 Apr 2014, at 3:43 PM, Greg KH wrote:

> On Fri, Apr 18, 2014 at 03:37:53PM -0700, Larry Baker wrote:
>> Greg,
>> 
>> Any suggestions how to trace what is going on?
> 
> Going on with what?  Was there a bug report in that wall of text that I
> missed?  :)

"It sort of works.  What happens is, after about 8 or 9 hours, the RX to the TTY port times out.  Sometimes it happens in only an hour, other times it takes about 14 hours."

"I am suspicious, for example, that the CTS grant is getting lost."

Should I report this on the linux-usb@vger.kernel.org mailing list?

>> I see all the tracing debug code has been removed in the latest
>> ftdi_sio driver.
> 
> That's because the kernel provides tracing functionality built-in, no
> need for it to be on a driver-by-driver basis.  Use it if you think it
> is necessary.

Can you point me to a web page or kernel doc for how to use it?

> Everything else are very cheap devices, with questionable UART silicon.

That's what I'm afraid I may never be able to determine -- whether the problem I have is between the driver and the chip (USB protocol), or is in the UART chip (could be USB protocol or the UART itself).  This is basically a side project, and I don't have the proper tools anyway to do that kind of trouble-shooting.  I will do what I can and report any findings, especially if a different USB serial driver works.

Thanks,

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov


