From: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Subject: Re: [PATCH] tty: amba-pl011: Make TX optimisation conditional
Date: Fri, 12 Jul 2019 13:20:42 +0100
Message-ID: <5bf03345-6a36-1b87-ca0c-e918b6030a74@raspberrypi.org>
References: <1562852732-123411-1-git-send-email-phil@raspberrypi.org>
 <20190712112105.GH2790@e103592.cambridge.arm.com>
 <20190712121000.GK11350@BitWizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190712121000.GK11350-ijfVyLOlgnXGjfRZg6uqBA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rogier Wolff <R.E.Wolff-ijfVyLOlgnXGjfRZg6uqBA@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Rogier,

On 12/07/2019 13:10, Rogier Wolff wrote:
> On Fri, Jul 12, 2019 at 12:21:05PM +0100, Dave Martin wrote:
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index 89ade21..1902071 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -1307,6 +1307,13 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
>>  /* Start TX with programmed I/O only (no DMA) */
>>  static void pl011_start_tx_pio(struct uart_amba_port *uap)
>>  {
>> +	/*
>> +	 * Avoid FIFO overfills if the TX IRQ is active:
>> +	 * pl011_int() will comsume chars waiting in the xmit queue anyway.
>> +	 */
>> +	if (uap->im & UART011_TXIM)
>> +		return;
>> +
> 
> I'm no expert on PL011, have no knowledge of the current bug, but have
> programmed serial drivers in the past.
> 
> This looks "dangerous" to me.
> 
> The normal situation is that you push the first few characters into
> the FIFO with PIO and then the interrupt will trigger once the FIFO
> empties and then you can refil the FIFO until the buffer empties.
> 
> The danger in THIS fix is that you might have a race that causes those
> first few PIO-ed characters not to be put in the hardware resulting in
> the interrupt never triggering.... If you can software-trigger the
> interrupt just before the "return" here that'd be a way to fix things.

I'm also not a serial driver expert, but I think this simplified patch is safe.
The reason is that the UART011_TXIM flag is only set after the pio thread has failed
to write some data into the FIFO because it is full, which would guarantee that
an interrupt is generated once the fill level drops below the half-way mark.

> I'm ok with a reaction like "I've thought about this, it's not a
> problem, now shut up".

I don't think that reaction would be justified - these things are difficult, and having
many minds on the problem helps to avoid bugs like this.

Phil
