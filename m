From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] serial: turn serial console suspend a boot rather than
 compile time option
Date: Wed, 8 Aug 2007 16:13:45 -0700
Message-ID: <20070808161345.4733b656.akpm@linux-foundation.org>
References: <20070808183535.2a2c6edf.dilinger@queued.net>
	<20070808154130.9cc3a30e.akpm@linux-foundation.org>
	<20070808190713.b59c9b00.dilinger@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33816 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756466AbXHHXNy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Aug 2007 19:13:54 -0400
In-Reply-To: <20070808190713.b59c9b00.dilinger@queued.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 8 Aug 2007 19:07:13 -0400
Andres Salomon <dilinger@queued.net> wrote:

> On Wed, 8 Aug 2007 15:41:30 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Wed, 8 Aug 2007 18:35:35 -0400
> > Andres Salomon <dilinger@queued.net> wrote:
> > 
> [...]
> > > --- a/include/linux/kernel.h
> > > +++ b/include/linux/kernel.h
> > > @@ -172,6 +172,8 @@ extern int __printk_ratelimit(int ratelimit_jiffies, int ratelimit_burst);
> > >  extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
> > >  				unsigned int interval_msec);
> > >  
> > > +extern int console_suspend;
> > > +
> > 
> > That's a somewhat vague-sounding identifier.  Could we call it
> > console_suspend_enabled or something?
> > 
> 
> Hm, how about serial_console_suspend_enabled or enable_serial_console_suspend?  I can send an updated patch later.
> 

I prefer the big-endian version (serial_console_suspend_enabled)
