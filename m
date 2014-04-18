From: Larry Baker <baker@usgs.gov>
Subject: Re: How can I help?
Date: Fri, 18 Apr 2014 16:43:52 -0700
Message-ID: <38D023F2-DDC3-4F1F-BD2C-737AE1CB012C@usgs.gov>
References: <8A1E86F6-47F2-44A7-A8DB-8A643FE9796B@usgs.gov> <20140418220903.GA22429@kroah.com> <E4E661B3-7296-4666-8A59-D9D52BC3D6D0@usgs.gov> <20140418224357.GA32442@kroah.com> <AD1ED14D-A603-4E02-8A2E-4E5113E20FBD@usgs.gov> <20140418231940.GA3833@kroah.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [137.227.28.12] ([137.227.28.12]:4082 "EHLO smtp6.doi.gov"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaDRXoV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 19:44:21 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so1882744pab.36
        for <linux-serial@vger.kernel.org>; Fri, 18 Apr 2014 16:43:57 -0700
 (PDT)
In-Reply-To: <20140418231940.GA3833@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

Greg,

> I'd go buy a few different types, of different cores, and try to find
> one that works for your workload.  That's going to be the simplest, and
> probably cheapest, way to do this.

Thanks a lot for your help.  I have to pick my poison.  The ARM SoC box I'm using has a UART, but their RTS/CTS is broken (as in, stty crtscts rejected; they fixed that, but I still get no data).  I can work on that driver or board configuration, and have a fix for a single platform.  Or, I can find a working or fix (questionable) a broken USB serial driver and have a solution good for multiple platforms.  I'd really like to give back and fix both.  Unfortunately, I don't have enough lifetimes.  As challenging and interesting as that may be, I have an actual job I have to do.  And my boss likes it better when I spend time on that. :)

I'll collect more data using adapters with different chips as well as a more recent kernel.  Then I can provide more useful information to the linux-usb@vger.kernel.org email list.

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov

