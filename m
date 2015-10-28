From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Wed, 28 Oct 2015 12:20:35 -0400
Message-ID: <5630F5D3.8050203@hurleysoftware.com>
References: <1445958479.2043.6.camel@suse.com>
 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
 <5630BE5E.6040204@hurleysoftware.com> <5630EF8A.8060904@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5630EF8A.8060904-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>, Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 10/28/2015 11:53 AM, Sven Brauch wrote: 
> On 28/10/15 13:23, Peter Hurley wrote:
>> Sven, please test Oliver's patch on that tree.
> I will do as soon as I get around to it, I hope on the weekend.

Ok.

I'll get you the kworker scheduler latency profiling howto so
we can find out what accounts for the scheduling lag, if still causing
issues when you test that tree.

>> Lastly, please confirm your test method/termios settings (iow, are
>> you using a reproducer or just 'cat big_file > /dev/ttyACM1')
> Sorry, what exactly do you mean by "reproducer"? I have a
> microcontroller which acquires and transmits the data on the device end
> of the USB connection. The data flows from device to host.

Ok. (A reproducer in your case would be a _very simple_ host sink, and
maybe a software simulation of the device.)

Are you using an application to setup and log the host side?
Or are you just using the shell (eg., 'cat /dev/ttyACM1 > log_file')?

I ask because the termios settings on the host are relevant to the
problem. If you're using an application, then you can capture the termios
settings on the host side _while the app is acquiring_ with, eg.:

	sudo stty -a -F /dev/ttyACM1


>> I would much rather rework URB flow + unthrottle, as I previously
>> outlined in the original thread instead of introducing another
>> buffering layer.
> From my non-kernel-dev point of view, this seems the way to go if the
> strategy in my patch (technical flaws aside) is not acceptable.
> Everything else, i.e. larger buffers or less delay, will certainly be a
> welcome improvement but still does not guarantee data delivery.
> 
> A very similar patch, by the way, was already submitted a few years ago
> [1] but not accepted for similar reasons as brought up here (I only
> found that thread later on). That patch has a more elegant
> implementation than mine, so you might prefer reviving that, if it
> becomes relevant.

I've done similar things on very-high-speed serial connections as
a stopgap, but I'd really like to solve this within the tty layer
rather than by each very-high-speed driver.


> I will be happy to test any fixes which come up, although I can't
> promise I can get around to do it immediately.

Thanks again.

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
