From: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Subject: Re: [PATCH] serial: 8250: Fix THRE flag usage for CAP_MINI
Date: Tue, 27 Jun 2017 10:24:21 +0100
Message-ID: <041c0471-0435-be8e-ade5-ee5438ef3a2d@raspberrypi.org>
References: <1498485581-72097-1-git-send-email-phil@raspberrypi.org>
 <1498555113.22624.182.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1498555113.22624.182.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 27/06/2017 10:18, Andy Shevchenko wrote:
> On Mon, 2017-06-26 at 14:59 +0100, Phil Elwell wrote:
>> The BCM2835 MINI UART has non-standard THRE semantics. Conventionally
>> the bit means that the FIFO is empty (although there may still be a
>> byte in the transmit register), but on 2835 it indicates that the FIFO
>> is not full. This causes interrupts after every byte is transmitted,
>> with the FIFO providing some interrupt latency tolerance.
>>
>> A consequence of this difference is that the usual strategy of writing
>> multiple bytes into the TX FIFO after checking THRE once is unsafe.
>> In the worst case of 7 bytes in the FIFO, writing 8 bytes loses all
>> but the first since by then the FIFO is full.
>>
>> There is an HFIFO ("Hidden FIFO") capability that causes the transmit
>> loop to terminate when both THRE and TEMT are set, i.e. when the TX
>> block is completely idle. This is unnecessarily cautious, potentially
>> causing gaps in transmission.
>>
>> Add a new conditional to the transmit loop, predicated on CAP_MINI,
>> that exits when THRE is no longer set (the FIFO is full). This allows
>> the FIFO to fill quickly but subsequent writes are paced by the
>> transmission rate.
>>
> 
>>  		if ((up->capabilities & UART_CAP_HFIFO) &&
>>  		    (serial_in(up, UART_LSR) & BOTH_EMPTY) !=
>> BOTH_EMPTY)
>>  			break;
>> +		/* The BCM2835 MINI UART THRE bit is really a not-
>> full bit. */
>> +		if ((up->capabilities & UART_CAP_MINI) &&
>> +		    !(serial_in(up, UART_LSR) & UART_LSR_THRE))
>> +			break;
> 
> Might this end up with two sequential read of LSR?

The same thought crossed my mind, but CAP_MINI is essentially CAP_BCM2835,
and we won't be setting CAP_HFIFO on BCM2835.
