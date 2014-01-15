From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
Date: Wed, 15 Jan 2014 12:17:07 +0100
Message-ID: <15900408.Osb5heuoGi@wuerfel>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com>
 <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
 <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Yuan Yao <yao.yuan@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Wednesday 15 January 2014 11:05:37 Mark Rutland wrote:
> On Wed, Jan 15, 2014 at 05:21:05AM +0000, Yuan Yao wrote:
> > --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> > +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> > @@ -4,11 +4,24 @@ Required properties:
> >  - compatible : Should be "fsl,<soc>-lpuart"
> >  - reg : Address and length of the register set for the device
> >  - interrupts : Should contain uart interrupt
> > +- clocks : from common clock binding: handle to uart clock
> > +- clock-names : from common clock binding: Shall be "ipg"
> 
> Why are these now requried if they weren't previously? That breaks old
> dts. I can't see any new code touching clocks. Was this an old but
> undocumented requirement?

It was previously required but not documented. I asked Yuan Yao to
add the text to the binding along with the new "dmas" addition.

It would have been cleaner to do this as a separate patch, but at
the very least it should be mentioned in the changelog.

	Arnd
