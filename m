From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/10] drivers: PL011: add support for the ARM SBSA
 generic UART
Date: Mon, 19 Jan 2015 14:31:06 +0100
Message-ID: <5407007.ZAjCvvOzus@wuerfel>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <54B95960.9070906@arm.com> <20150116183717.GM32155@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150116183717.GM32155@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "rob.herring@linaro.org" <rob.herring@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Andre Przywara <andre.przywara@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Friday 16 January 2015 18:37:17 Mark Rutland wrote:
> 
> > Makes some sense, so what about:
> > -----------------------
> > Required properties:
> > - compatible: must be "arm,sbsa-uart"
> > - reg: exactly one register range
> > - interrupts: exactly one interrupt specifier
> > 
> > Optional properties:
> > - current-speed : the current active speed of the UART
> > - fifo-size : always 32 as per the SBSA specification
> > - word-size : the number of payload bits per word
> > - parity : used parity method, can be:
> >       "n": no parity
> >       "e": even parity
> >       "o": odd parity
> >       "m": always mark (logical 1)
> >       "s": always space (logical 0)
> > - stop-bits : the number of stop bits after the payload
> 
> Generally those look fine, though someone more familiar with serial
> should take a look.
> 
> We can drop fifo-size given it's fixed. Anything that we know outright
> doesn't need to be described.
> 
> We might want to make them mandatory. I don't see any value in not
> knowing.

I think making them optional is useless, so either make them mandatory or
drop them if we can avoid it. Unfortunately, LCR is not part of SBSA,
that would let us drop the properties and still report the correct settings.

Would we be better off documenting that 8-n-1 is the only allowed settting?
I can't think of a reason why anyone would use something else.

	Arnd
