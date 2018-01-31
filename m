From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Handling of chars received while a UART is not open
Date: Wed, 31 Jan 2018 13:12:15 +0000
Message-ID: <CAFEAcA8D2RLSbHO-OdULHre4oVr=vU+Yb+6sp55XiP6Mrtg1xA@mail.gmail.com>
References: <20180131120628.GL5862@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180131120628.GL5862@e103592.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: arm-mail-list <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 31 January 2018 at 12:06, Dave Martin <Dave.Martin@arm.com> wrote:
> Now, Qemu has a facility for stuffing some input to an emulated UART
> immediately on boot, and wouldn't work in case (2) above.  OTOH, that
> may be a mistaken approach: it's unlikely to work reliably on hardware
> due to the problem of knowing when a physical UART is actually ready to
> receive input.  So maybe Qemu should be waiting for a prompt to be
> transmitted before stuffing input.  In case (1) or (3), qemu probably
> needs to do something like that.

FWIW, there isn't a QEMU "facility" for doing this particularly:
we just don't take any trouble to stop the user from providing
input whenever the user likes. (If the user is an automatic test
script then it's that script's job to wait for suitable prompts
from the guest before feeding input into the emulated serial port
if it wants to be reliable, the same way you'd have to if you
were feeding the data to a real serial line.)

What QEMU doesn't do and probably should fix is that we allow data
into the FIFO even if UARTCR.UARTEN is 0 ("UART disabled"). This
(I think) wouldn't affect the behaviour here, though, because the
data will just get held in QEMU's input buffer until the guest
driver sets UARTEN and then immediately fill the FIFO.

thanks
-- PMM
