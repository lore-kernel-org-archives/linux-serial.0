From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Tue, 21 Jul 2015 19:34:32 -0400
Message-ID: <55AED708.903@hurleysoftware.com>
References: <55AC1883.4050605@svenbrauch.de> <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de> <1437486195.3823.13.camel@suse.com> <55AEBD06.6020402@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AEBD06.6020402@svenbrauch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Brauch <mail@svenbrauch.de>
Cc: Oliver Neukum <oneukum@suse.com>, Johan Hovold <johan@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Toby Gray <toby.gray@realvnc.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07/21/2015 05:43 PM, Sven Brauch wrote:
> Hi,
> 
> Thank you for your comments.
> 
> On 21/07/15 15:43, Oliver Neukum wrote:
>> But others won't and we'd preserve stale data in preference over fresh
>> data.
> If that is important for your device, you should be using an isochronous
> endpoint, not bulk, no?
> Also note that the driver currently does this anyways. It loses a few kB
> of data, and _then_ it throttles the producer and forces it to wait.
> 
> On 21/07/15 11:18, Johan Hovold wrote:
>> In general if data isn't being consumed fast enough we eventually need
>> to drop it (unless we can throttle the producer).
> Yes, maybe this is the first thing which should be cleared up: Is
> "throttle the producer" always preferable over "lose data"? I'd say yes
> for bulk transfers, no for isochronous. It is in principle easy enough
> to throttle the producer, that is what e.g. my patch does. Whether a
> different approach may be more appropriate than the "don't resubmit the
> urbs" thing is then of course open to debate.
> 
> As far as I can see, throttling the producer is the only way to
> guarantee data delivery. So if we want that (and I certainly want it for
> my application, I don't know about the general case), I think all
> changes to the tty buffers or throttling mechanisms are "just"
> performance optimization, since no such modification will ever guarantee
> delivery if the producer is not throttled in time.
> And, this I want to mention again, if your producer is timing-sensitive
> you would not be using bulk anyways. The USB controller could just
> decide that your device cannot send data for the next five seconds, and
> it will have to handle that case as well. Thus I see no reason to not
> throttle the producer if necessary.

It's unclear to me that you haven't hit some other bug (buffer miscalc,
failure to progress, etc.) which is affecting other users but just not
to the extent you're experiencing.

For example, I made changes to the conditions required to restart the
input worker; I may have omitted some necessary condition which you've
triggered.


> On 21/07/15 18:45, Peter Hurley wrote:
>> 1. Instrument acm_read_bulk_callback with tty_buffer_space_avail()
>> to track the (approx) fill level of the tty buffers. I would
>> use ftrace/trace_printk() to record this.
> I already did this while debugging. For a while, the buffer is almost
> empty (fluctuates by a few kB), then it rapidly drops to zero bytes
> free. Only after a few urbs where submitted (or rather, not submitted)
> into the full buffer, the throttle flag gets set.

I'd like to see that data, if you can, which will help me understand
at least the timing.

Regards,
Peter Hurley
