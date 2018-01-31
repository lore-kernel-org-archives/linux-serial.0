From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: Handling of chars received while a UART is not open
Date: Wed, 31 Jan 2018 13:45:14 +0000
Message-ID: <20180131134514.GO5862@e103592.cambridge.arm.com>
References: <20180131120628.GL5862@e103592.cambridge.arm.com>
 <20180131121931.GH9418@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180131121931.GH9418@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Peter Maydell <peter.maydell@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 31, 2018 at 12:19:31PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 31, 2018 at 12:06:29PM +0000, Dave Martin wrote:
> > Hi all,
> > 
> > Question:
> > 
> >  1) Should a UART definitely discard the RX FIFO on ->startup()?
> 
> Yes; POSIX makes no guarantees about the configuration of the port
> while it is closed, and when it is re-opened, it is permitted that
> the port is reset back to a set of default parameters rather than
> the previous parameter set that was configured.
> 
> You also have the CREAD flag which indicates whether we want the
> receiver enabled or not, but it is not defined by POSIX whether the
> receiver remains enabled when the port is closed.
> 
> Linux behaviour has always been to flush the port of received
> characters at close and open time (see 8250 driver), meaning that
> characters received while the TTY is closed are ignored - just like
> what happens on the physical console keyboard, which is also a TTY.
> Doing otherwise is likely to confuse applications and potentially
> introduce buggy behaviour that would only be detected on UARTs with
> differing behaviour to 8250.
> 
> Linux follows POSIX General Terminal Interface for its TTY handling.

OK, that all sounds good.

Explicitly reading the RX FIFO until empty on startup seems compatible
with this, and harmless even on hardware that can't show the lockup.

I'll cook up another patch.

Cheers
---Dave
