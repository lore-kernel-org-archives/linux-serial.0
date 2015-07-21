From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Tue, 21 Jul 2015 12:45:08 -0400
Message-ID: <55AE7714.80306@hurleysoftware.com>
References: <55AC1883.4050605@svenbrauch.de> <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de> <20150721091838.GG20628@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150721091838.GG20628@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Toby Gray <toby.gray-BiNz9QiKYoNBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Sven,

On 07/21/2015 05:18 AM, Johan Hovold wrote:
> On Mon, Jul 20, 2015 at 08:07:33PM +0200, Sven Brauch wrote:
>> On 20/07/15 19:25, Johan Hovold wrote:
> 
>>> The idea of adding another layer of buffering in the cdc-acm driver has
>>> been suggested in the past but was rejected (or at least questioned).
>>> See for example this thread:
>>>
>>> 	https://lkml.kernel.org/r/20110608164626.22bc893c-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
>> Yes, that is indeed pretty much the same problem and the same solution.
>> Answering to the questions brought up in that thread:
>>
>>> a) Why is your setup filling 64K in the time it takes the throttle
>>> response to occur
>> As far as I understand, the throttle happens only when there's less than
>> 128 bytes of free space in the tty buffer. Data can already be lost
>> before the tty even decides it should start throttling, simply because
>> the throttle threshold is smaller than the amount of data potentially in
>> each urb. Also (excuse my cluelessness) it seems that when exactly the
>> throttling happens depends on some scheduling "jitter" as well.
>> Additionally, the response of the cdc_acm driver to a throttle request
>> is not very prompt; it might have a queue of up to 16kB (16 urbs) pending.
> 
> Not really. The n_tty ldisc throttles when *its* buffer space is low,
> but there should still be plenty of room in the tty buffers.
> 
> Looks like the ldisc processing is being starved.

Just to expand on Johan's explanation somewhat.

The tty buffers are separate from the fixed 4KB n_tty line discipline
read buffer. The 4KB read buffer holds data which has already been
processed as input based on the current termios settings.

The tty buffers hold unprocessed rx data; because the cdc-acm driver
does not use per-char flags, the default tty buffer limit amounts to
a 128KB buffer, which is roughly 10ms at your line rate of 96Mb/s.

10ms is a long time for a kworker thread (which would indicate throttle)
to not be running once scheduled, so I doubt scheduler latency is
actually the problem.

More likely suspects are:
1. Because most drivers don't properly handle concurrent throttle/unthrottle,
   the n_tty line discipline excludes one while the other is in-progress.
   acm_tty_unthrottle() first clears throttle state, thus letting input
   proceed, and then continues to submit previously in-flight urbs. During this
   time, the driver cannot receive throttle notification (ie., acm_tty_throttle()
   will not be called).

2. The reader/consumer can't process at that line rate, or related, the
   reader/consumer can't catch up once it has fallen behind.

Some interesting experiments would be:
1. Instrument acm_read_bulk_callback with tty_buffer_space_avail() to track
   the (approx) fill level of the tty buffers. I would use ftrace/trace_printk()
   to record this.
2. Similarly instrument acm_tty_throttle/acm_tty_unthrottle.


>>> b) Do we care (is the right thing to do to lose bits anyway at
>>> that point)
>> This I cannot answer, I don't know enough about the architecture or
>> standards. I can just say that for my case, there's a lot of losses;
>> this it not an issue which happens after hours when the system is under
>> heavy load, it happens after just a few seconds reproducably.
> 
> In general if data isn't being consumed fast enough we eventually need
> to drop it (unless we can throttle the producer).
> 
> But this isn't necessarily the case in your setup.
> 
>>> The tty buffers are quite large these days, but could possibly be bumped
>>> further if needed to give the ldisc some more time to throttle the
>>> device at very high speeds.
>> I do not like this solution. It will again be based on luck, and you
>> will still be unable to rely on the delivery guarantee made by the USB
>> stack (at least when using bulk).
> 
> See above.

A driver can set the upper limit of tty buffers on a per-tty basis with
tty_buffer_set_limit(). The default limit is 64KB. This limit must be
set before the tty can receive input.


>> My suggestion instead stops the host system from accepting any more data
>> from the device when its buffers are full, forcing the device to wait
>> before sending out more data (which many kinds of devices might very
>> well be able to do).
> 
> This is what we are supposed to do today, but by relying on the ldisc
> and tty buffers rather than forcing every driver to implement another
> custom throttling mechanism.
> 
> But something obviously isn't working as intended.

Let me know if you need help instrumenting the tty buffers/throttling
to help figure out what the actual problem is.

Regarding the patch itself, I have no opinion on the suitability of
simply not resubmitting urbs. However, that is exactly how the throttle
mechanism works, and the tty buffer API is specifically designed to
allow drivers to manage flow via that interface as well (especially
for high-throughput drivers).

The n_tty throttle/unthrottle is a very indirect method for restricting
flow, and at extremely high bit rates may not be appropriate. (It's
mostly a historical vestige from pre-tty buffer days).

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
