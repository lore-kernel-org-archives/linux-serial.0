From: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Subject: Re: [PATCH] serial: 8250: Fix THRE flag usage for CAP_MINI
Date: Tue, 27 Jun 2017 11:30:12 +0100
Message-ID: <2669bcda-e1f5-ecb1-a986-99947658bac7@raspberrypi.org>
References: <1498485581-72097-1-git-send-email-phil@raspberrypi.org>
 <627a530c-d78c-5338-5ddf-0b3f6a09c37e@i2se.com>
 <bf050731-6b05-9e35-8b50-ea9115b4197f@raspberrypi.org>
 <1498554936.22624.180.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1498554936.22624.180.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 27/06/2017 10:15, Andy Shevchenko wrote:
> On Mon, 2017-06-26 at 16:15 +0100, Phil Elwell wrote:
> 
>>> But this looks like a bug / quirk than a capability?
>>>
>>> It would be better to name this define more self-explaining.
>>>
>>> Btw can't see the definition of UART_CAP_MINI?
>>
>> The capability was added in d087e7a991f1f61ee2c07db1be7c5cc2aa373f5d,
>> which
>> is in linux-next. Given that the "capability" already exists and the
>> quirk
>> is likely to be unique to BCM2835 MINI UART, I don't think we should
>> create
>> a new quirk.
>>
>> Besides, the "HFIFO" capability looks a lot like quirk to me.
> 
> To me either, which raises a question "Should it be fixed accordingly?"

If I was going to make these quirks, are we simply talking about renaming the
capability or is there another mechanism? I've found the 8250_pci quirks, and
they look quite different.

I'm also happy to make this code conditional on CONFIG_SERIAL_8250_BCM2835AUX
if that is more acceptable.

Phil (still hoping to lose newb status one day)
