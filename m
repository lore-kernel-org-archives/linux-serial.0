From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] tty: amba-pl011: add options to earlycon for 32-bit reg
 access
Date: Sat, 7 Nov 2015 23:02:37 +0000
Message-ID: <20151107230237.GU8644@n2100.arm.linux.org.uk>
References: <1446770267-26749-1-git-send-email-timur@codeaurora.org>
 <563C07C8.9060506@hurleysoftware.com>
 <563C09BB.9030706@codeaurora.org>
 <563C1409.4070804@hurleysoftware.com>
 <563CF8AF.50808@codeaurora.org> <563E7CF2.60609@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <563E7CF2.60609@hurleysoftware.com>
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
Cc: andre.przywara@arm.com, Timur Tabi <timur@codeaurora.org>, Andrew.Jackson@arm.com, jun.nie@linaro.or, linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, jslaby@suse.com, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sat, Nov 07, 2015 at 05:36:34PM -0500, Peter Hurley wrote:
> On 11/06/2015 01:59 PM, Timur Tabi wrote:
> > On 11/05/2015 08:44 PM, Peter Hurley wrote:
> >> Or better yet, for sbsa32 earlycon, just use the existing port type constructs.
> >> So,
> >>
> >>     earlycon=pl011,mmio32,0x3ced1000
> >>
> >> which will set port->iotype to UPIO_MEM32, which in turn can be used to select
> >> the correct i/o width in pl011_putc().
> > 
> > That's a great idea.  But why aren't we using it for pl011_write()?
> 
> I'll note that when I review Russell's v2 series, if necessary.

And I'm not rushing to post them yet as the merge window is currently
open.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
