From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 0/4] bcm2835: enable auxiliary uart1
Date: Mon, 21 Sep 2015 19:39:16 -0700
Message-ID: <5600BF54.9090802@wwwdotorg.org>
References: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
 <87r3m1jbmr.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r3m1jbmr.fsf-omZaPlIz5HhaEpDpdNBo/KxOck334EZe@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 09/14/2015 07:53 AM, Eric Anholt wrote:
> kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:
> 
>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> 
>> The bcm2835 SOC contains an auxiliary uart, which is very close 
>> to the ns16550 with some differences.
>> 
>> The big difference is that the uart HW is not using an internal
>> divider of 16 but 8, which results in an effictive baud-rate
>> being twice the requested baud-rate.
>> 
>> The bcm2835-aux-uart is also special in such that it is
>> enabled/disabled by a gate in the clock, which is managed by the
>> clk-bcm2835-aux clock driver.
>> 
>> there are 2 options: * defining the clock-frequency property in
>> the device tree to 500k instead of 250k, but this keeps the HW
>> block disabled making the uart not work.

Why does this keep the HW block disabled?

>> * defining a clock in the device tree, but this results in a baud
>> rate that is twice the requested baud-rate.
>> 
>> To address this this patch-set introduce a new property in the
>> device tree to define a clock divider other than 16.
>> 
>> This currently just scales the clock by a factor of 16/divider.
>> 
>> Note that the use of fixed-factor-clock has also been proposed as
>> a workarround, but this does not really describe the hw in the
>> device tree so another solution was needed that allows a correct
>> representation of the HW in the device tree.
> 
> I personally lean toward the fixed-factor-clock solution, but could
> go either way.  Serial maintainers, what do you think?

The external fixed-factor-clock solution sounds more like a workaround
than a real fix. It means that the UART driver isn't aware of what's
going on and only "accidentally" works due to some manipulation of the
clock values that it requests. That kind of thing almost always come
back to bite you later.

Rather than adding a DT property to configure the internal clock
divider, it seems best to add a new compatible value to the list it
supports, and have that compatible value set up internal data that
indicates divide-by-16 vs. divide-by-8. After all, the HW isn't 100%
compatible with ns16550, so the DT should not say that it is. While
the clock-divider property this series adds to the DT does solve the
issue, it does not prevent an older piece of SW that predates this
series, and hence which does not implement clock-divider, attempting
to bind to this DT but fail to operate correctly since it doesn't know
about the different divider.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
