From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Tue, 20 Oct 2015 14:16:20 -0400
Message-ID: <562684F4.1020501@hurleysoftware.com>
References: <55AC1883.4050605@svenbrauch.de>
 <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de>
 <1437486195.3823.13.camel@suse.com> <55AEBD06.6020402@svenbrauch.de>
 <55AED708.903@hurleysoftware.com> <55AEE805.9050204@svenbrauch.de>
 <55B01554.90201@hurleysoftware.com> <55B01EDE.3050503@svenbrauch.de>
 <55C249A3.6030809@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55C249A3.6030809-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>, Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Toby Gray <toby.gray-BiNz9QiKYoNBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 08/05/2015 01:36 PM, Peter Hurley wrote:
> On 07/22/2015 06:53 PM, Sven Brauch wrote:
>> On 23/07/15 00:12, Peter Hurley wrote:
>>> The premature unthrottle actually leads to the data loss but the throttling
>>> with a mere 2K left is _way too late_.
>> Ok, yes, I think so too.
>>
>>> 10ms is a _really_ long time for a cpu not to attend to a kworker.
> 
> I haven't forgotten about this problem and I still plan to look into why
> the long delay, particularly focusing on the scheduling latency from
> tty_flip_buffer_push() => flush_to_ldisc().

I made some changes wrt which CPU is scheduled for the flush_to_ldisc()
input worker, which should reduce the kworker latency. The changes are
on the tty-next branch of Greg's tty.git tree; please test at your earliest
convenience.


>>> 1. What are the termios settings of the tty receiving input? Is it 'raw'
>>>    mode or typical terminal mode (icanon, echo, etc.) or something else?
>> In my test code, I open the tty like
>>   fd = open("/dev/ttyACM0", O_RDWR | O_NOCTTY | O_NONBLOCK);
>> I don't make any other changes to the default settings. To be honest,
>> I'm not sure in which mode it is operating then (I was assuming raw, but
>> I might be wrong?).

ECHO is on by default and the cdc-acm driver does not implement the
put_char() and flush_chars() tty driver methods, which made the problem
_way worse_, since every echoed char is sent as it's own URB.

Since echoing is performed by the input worker, this seems the likely
cause for the significant delay in ldisc processing.

Echo processing should probably be performed by a separate kworker rather
than by the input kworker.

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
