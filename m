From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 10/10] drivers: PL011: add support for the ARM SBSA
 generic UART
Date: Thu, 5 Mar 2015 11:15:56 +0000
Message-ID: <20150305111550.GA3612@e103592.cambridge.arm.com>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <1421428986-11300-11-git-send-email-andre.przywara@arm.com>
 <54E36477.3050406@codeaurora.org>
 <20150217161613.GC3783@e103592.cambridge.arm.com>
 <54F7453C.5060407@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54F7453C.5060407@arm.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "rob.herring@linaro.org" <rob.herring@linaro.org>, Philip Elcan <pelcan@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 04, 2015 at 05:47:40PM +0000, Andre Przywara wrote:
> Philip,
> 
> sorry for the late reply, that was stuck in my Drafts folder :-(
> 
> On 02/17/2015 04:16 PM, Dave P Martin wrote:
> > On Tue, Feb 17, 2015 at 10:55:35AM -0500, Philip Elcan wrote:

[...]

> >> I'm a little late to address this patchset, but the SBSA defines all
> >> the Generic UART registers 32-bit wide. However, the amba-pl011 driver
> >> uses 16-bit accessors. How will you be handling that? Can the ARM PL011
> >> hardware handle 32-bit access?
> > 
> > Interesting question.  The PL011 TRM [1] specifies only a 16-bit-wide
> > APB bus interface, but does not say that 32-bit accesses won't work.
> > 
> > I suspect that 32-bit accesses will work on all or most PL011s -- if
> > that looks too risky or we can't find enough test platforms to be sure
> > of this, then we could maybe abstract the register access size as a
> > quirk.
> > 
> > Andre may already have an answer on this.
> 
> I am not sure if the 32-bit register _width_ mentioned in the spec
> really mandates 32-bit accesses, also the width may be just a spec bug.
> Since the SBSA states that an ARM PL011r1p5 is a valid SBSA-UART
> implementation, I wonder how this goes together. Also the highest
> non-reserved bit in the registers is bit 15 in PL011 and bit 11 in the
> SBSA subset.
> 
> I fear the actual bus connection is an implementation detail. Given the
> fact that all existing PL011 hardware so far works with the 16bit
> accesses, I don't dare to change this.
> 
> So I'd suggest to keep it as readw/writew for now and the revisit this
> topic if some SBSA UART users complain. That makes it easier to justify
> the rather invasive change to all MMIO accessors (which I already tried
> on one machine for now without problems, btw).

+1

As I understand it, the PL011 bus interface does not take access size
into account at all, so providing "large-enough" accesses are used to
cover all the bits meaningful to the UART, things are likely to work
fine -- and this seems to be the case for all platforms currently
supported by the amba-pl011 driver.

Cheers
---Dave
