From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: ns16550 earlycon baud broken on BCM5301X since commit
 31cb9a8575ca0 ("earlycon: initialise baud field of earlycon device structure")
Date: Thu, 29 Mar 2018 16:37:51 +0200
Message-ID: <CACna6rwfCVFHLc_uVQRR=F+53uj8OVtMi1jUygJfTSmDK99+zQ@mail.gmail.com>
References: <CACna6rzki=sjXQS12eF3yPXH7XeFYTCXVOdj--F=P=jkJZX7fg@mail.gmail.com>
 <1522329420.32101.3.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1522329420.32101.3.camel@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jonmason@broadcom.com" <jonmason@broadcom.com>, "hauke@hauke-m.de" <hauke@hauke-m.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 29 March 2018 at 15:17, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com> wrote:
> Hm, your 'port->uartclk' value (and therefore 'BASE_BAUD' value) looks strange to me...
> Looks like you have 'BASE_BAUD' set to 115200.
>
>
> Here is my example:
> uart clock is 33333333Hz (fixed 33.33MHz xtal clock)
> So 'BASE_BAUD' is 33333333/16 = 2083333
> So 'port->uartclk' is BASE_BAUD*16 = 33333328
> 'device->baud' is 115200 (which is read from device tree)
> So when we calculate divisor with this code
> ------------------->8---------------
> divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
> ------------------->8---------------
> We got 'divisor' = 181 which is correct value for us.

You're right. 115200 is the default BASE_BAUD value coming from:
./include/asm-generic/serial.h:#define BASE_BAUD (1843200 / 16)

You must be using arch/machine that has custom serial.h with different value.

Could there be some wrong logic regarding uartclk / BASE_BAUD / baud
in the tty subsystem?
