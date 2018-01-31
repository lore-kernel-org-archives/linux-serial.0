From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: Handling of chars received while a UART is not open
Date: Wed, 31 Jan 2018 13:32:14 +0000
Message-ID: <20180131133213.GN5862@e103592.cambridge.arm.com>
References: <20180131120628.GL5862@e103592.cambridge.arm.com>
 <CAFEAcA8D2RLSbHO-OdULHre4oVr=vU+Yb+6sp55XiP6Mrtg1xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAFEAcA8D2RLSbHO-OdULHre4oVr=vU+Yb+6sp55XiP6Mrtg1xA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, arm-mail-list <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 31, 2018 at 01:12:15PM +0000, Peter Maydell wrote:
> On 31 January 2018 at 12:06, Dave Martin <Dave.Martin@arm.com> wrote:
> > Now, Qemu has a facility for stuffing some input to an emulated UART
> > immediately on boot, and wouldn't work in case (2) above.  OTOH, that
> > may be a mistaken approach: it's unlikely to work reliably on hardware
> > due to the problem of knowing when a physical UART is actually ready to
> > receive input.  So maybe Qemu should be waiting for a prompt to be
> > transmitted before stuffing input.  In case (1) or (3), qemu probably
> > needs to do something like that.
> 
> FWIW, there isn't a QEMU "facility" for doing this particularly:
> we just don't take any trouble to stop the user from providing
> input whenever the user likes. (If the user is an automatic test
> script then it's that script's job to wait for suitable prompts
> from the guest before feeding input into the emulated serial port
> if it wants to be reliable, the same way you'd have to if you
> were feeding the data to a real serial line.)

Fair enough.  I misunderstood slightly there.

> (I think) wouldn't affect the behaviour here, though, because the
> data will just get held in QEMU's input buffer until the guest
> driver sets UARTEN and then immediately fill the FIFO.

On the Linux side, I guess we nonetheless need to cope with input
stuffed early for the SBSA UART case, but if you're saying that
qemu (or software talking to qemu) shouldn't assume that input
stuffed at boot will actually be received (unless it qemu waits for
UARTEN) then we have some flexibility in the amba-pl011 driver here.

Based on Russell's comments, I guess the fix for the SBSA UART case
would be to read and discard the contents of the RX FIFO on UART open.
It seems harmless to do that for pl011 also, so I would suggest putting
it on the common code path.  This likely minimises the chance of being
tripped up by vendor-specific quirks.

> What QEMU doesn't do and probably should fix is that we allow data
> into the FIFO even if UARTCR.UARTEN is 0 ("UART disabled"). This

That probably does makes sense, providing qemu models a pl011.
A real pl011 wouldn't receive anything while that bit is clear.

SBSA UART doesn't have this control (or most of the others): it's
just always on.


Cheers
---Dave
