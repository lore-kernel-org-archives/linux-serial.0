From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Tue, 04 Aug 2015 20:26:57 -0400
Message-ID: <55C15851.8070003@hurleysoftware.com>
References: <55AC1883.4050605@svenbrauch.de>		 <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de>		 <20150721091838.GG20628@localhost> <55AE7714.80306@hurleysoftware.com>	 <1437554428.5445.0.camel@suse.com> <55AFA900.6040605@hurleysoftware.com> <1437577303.5445.7.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437577303.5445.7.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Toby Gray <toby.gray-BiNz9QiKYoNBDgjK7y7TUQ@public.gmane.org>, Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 07/22/2015 11:01 AM, Oliver Neukum wrote:
> On Wed, 2015-07-22 at 10:30 -0400, Peter Hurley wrote:
>> 3. Pre-allocate space _before_ the data arrives (with
>> tty_buffer_request_room());
>>    this is applicable to subsystems which know how much data can be
>> in-flight
>>    at any one time. This guarantees that when rx data arrives buffer
>> space is
>>    available (since it has already been allocated).
>>
>> Drivers that use method 2 typically attempt to recopy the buffered
>> data
>> when either new data arrives or @ unthrottle. I've seen others use
>> deferred
>> work as well.
>>
>> AFAIK no driver/subsystem is using method 3 for guaranteed delivery
>> of in-flight data, but it seems ideally suited to usb serial.
> 
> Indeed. But flow control is still done by throttle/unthrottle, isn't it?

Oliver, somehow I never saw this. Please accept my apologies.

Well, input flow control from the driver would be implicitly limited
by a failure to allocate new buffer space after the old buffer was
inserted and pushed. In the case of urbs, this would simply mean that
the urb could not be resubmitted yet, and would have to be deferred.
So preventing buffer overrun wouldn't rely on throttle.

WRT flow control, method 3 only needs to know when to resume.
As with method 2, this could be @ unthrottle or by retry in deferred work
(essentially polling). At least that's what's currently available.

Regardless, tty drivers should still respond to throttle/unthrottle
requests so as to limit input data when there is no active reader.

All that being said, unthrottle behaves degenerately at very high line
rates and throughput, which needs to be resolved.

The central issue is that the wrong thread is evaluating the wrong
conditions for restart. A further complication is that unthrottle
is guaranteed race-free reads of struct termios which limit the contexts
from which unthrottle can be called.

So to recap; the tty buffer api already provides the necessary interface
for preventing buffer overrun and drivers/subsystems with very high line
rates should be utilizing that interface instead of relying on throttle.

In addition, a more reliable/appropriate method of restart is required
(preferably by fixing when/why unthrottle is invoked). I'll look into that.

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
