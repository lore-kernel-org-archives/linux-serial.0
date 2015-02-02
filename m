From: Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support
 noinit option
Date: Mon, 2 Feb 2015 13:33:22 +0800
Message-ID: <1422855202.26131.31.camel@mtksdaap41>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
 <54CE53F3.5040709@hurleysoftware.com> <54CE6FD9.5030606@hurleysoftware.com>
 <1422846994.5512.25.camel@mtksdaap41> <54CEF2C8.1050808@hurleysoftware.com>
 <20150202042843.GA24765@kroah.com> <54CF07F3.2040100@hurleysoftware.com>
 <20150202052423.GA3346@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150202052423.GA3346@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>, yh.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, linux-serial@vger.kernel.org, "Joe.C" <yingjoe.chen@mediatek.com>, devicetree@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Sun, 2015-02-01 at 21:24 -0800, Greg Kroah-Hartman wrote:
> On Mon, Feb 02, 2015 at 12:15:31AM -0500, Peter Hurley wrote:
> > On 02/01/2015 11:28 PM, Greg Kroah-Hartman wrote:
> > > On Sun, Feb 01, 2015 at 10:45:12PM -0500, Peter Hurley wrote:
> > >> On 02/01/2015 10:16 PM, Eddie Huang wrote:
> > 
> > >> I'll respin proper patches on top of Greg's tty-testing branch with reverts
> > >> for the noinit options. I noticed that one of the noinit patches actually
> > >> has the linkage for the mtk earlycon, so I'll be sure to preserve that.
> > > 
> > > I can just drop the patches in the tty-testing branch, that's what it is
> > > there for :)
> > > 
> > > Just let me know the specific patches and I will do so, thanks.
> > 
> > Well that pretty much means dropping the 3 patches that add earlycon to
> > 8250_mtk and then applying my patch (needs fixed to apply cleanly, which
> > I can do) and then applying a fixed-up replacement patch to add earlycon
> > to 8250_mtk (which I can also supply).
> > 
> > Is that the way you want to go?
> 
> Sounds good to me, send your patch, and I'll fix it all up tomorrow.
> 
> thanks,
> 
> greg k-h

Actually, your patch is a little different from my original idea.
Although my use case only care about divisor now, but other hardware
setting is still hard-code, not from parameter. In init_port()
function:   
	serial8250_early_out(port, UART_LCR, 0x3); /* 8n1 */
	serial8250_early_out(port, UART_IER, 0);/* no interrupt */
	serial8250_early_out(port, UART_FCR, 0); /* no fifo */
	serial8250_early_out(port, UART_MCR, 0x3); /* DTR + RTS */

This is why I propose a new option "noinit".

After checking further, in my case, I found that your patch should be
unnecessary because if skip baudrate, probe_baud() read DLL/DLM register
and init_port() write the same DLL/DLM value back, no touch any high
speed register, which means keep uart divisor setting as loader

Since I don't take "console=uart,mmio32,<addr>,noinit" into
consideration, it is good to drop my patches in the tty-testing branch.
For my case, I can send another series without noinit, just 8250_mtk.c
and its linkage modification in 8250_early.c

Eddie
