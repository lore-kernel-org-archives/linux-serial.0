From: Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support
 noinit option
Date: Mon, 2 Feb 2015 10:45:04 +0800
Message-ID: <1422845104.5512.18.camel@mtksdaap41>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
 <54CE53F3.5040709@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54CE53F3.5040709@hurleysoftware.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>, yh.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, linux-serial@vger.kernel.org, "Joe.C" <yingjoe.chen@mediatek.com>, devicetree@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Sun, 2015-02-01 at 11:27 -0500, Peter Hurley wrote:
> Hi Eddie,
> 
> On 01/12/2015 08:08 AM, Eddie Huang wrote:
> > Add earlycon support not only baudrate option, but also add noinit option.
> > If use noinit option, 8250 earlycon will not init serial hardware and use
> > loader setting.
> 
> I see this went into Greg's tty-testing branch.
> 
> The only point of this is to not program the divisor, right?
In this case, yes.

> I ask because early_serial8250_setup() could already handle this without
> extra options by simply not doing divisor programming if no baud option is
> present.
MTK support high speed UART, which means baudrate can be more than
115200. You can reference mtk8250_set_termios() function in 8250_mtk.c.
Unfortunately, the early_serial8250_setup() can not handle high speed
case. This is why I add noinit parameter.

Besides, I think "no baud option" is a little tricky, and maybe someday
someone not only care about divisor, but also flow. Legacy earlyprintk
and other uart drivers like msm_serial.c also don't init uart hardware.

> 
> And this blows up if the optional console= form is used:
>     console=uart,mmio32,<addr>,noinit
> because the ttyS console will expect line settings for console match.
> 
Yes, you are right. console parameter case will fail, I only consider
earlycon parameter case.

> 
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  drivers/tty/serial/8250/8250_early.c |  7 ++++---
> >  drivers/tty/serial/earlycon.c        | 17 ++++++++++++-----
> >  include/linux/serial_8250.h          |  2 ++
> >  include/linux/serial_core.h          |  1 +
> >  4 files changed, 19 insertions(+), 8 deletions(-)
> > 
