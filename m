From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH 00/10] drivers: PL011: add ARM SBSA Generic UART support
Date: Tue, 20 Jan 2015 14:52:21 +0000
Message-ID: <20150120145221.GC6858@xora-yoga-13.xora.org.uk>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <20150120130832.GA6858@xora-yoga-13.xora.org.uk>
 <54BE5E35.50906@arm.com>
 <20150120142612.GB6858@xora-yoga-13.xora.org.uk>
 <54BE671C.4050300@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <54BE671C.4050300@arm.com>
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
Cc: "rob.herring@linaro.org" <rob.herring@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 20, 2015 at 02:33:00PM +0000, Andre Przywara wrote:
> 
> 
> On 20/01/15 14:26, Graeme Gregory wrote:
> > On Tue, Jan 20, 2015 at 01:55:01PM +0000, Andre Przywara wrote:
> >> Hi Graeme,
> >>
> >> On 20/01/15 13:08, Graeme Gregory wrote:
> >>> On Fri, Jan 16, 2015 at 05:22:56PM +0000, Andre Przywara wrote:
> >>>> The ARM Server Base System Architecture[1] document describes a
> >>>> generic UART which is a subset of the PL011 UART.
> >>>> It lacks DMA support, baud rate control and modem status line
> >>>> control, among other things.
> >>>> The idea is to move the UART initialization and setup into the
> >>>> firmware (which does this job today already) and let the kernel just
> >>>> use the UART for sending and receiving characters.
> >>>>
> >>>> This patchset integrates support for this UART subset into the
> >>>> existing PL011 driver - basically by refactoring some
> >>>> functions and providing a new uart_ops structure for it. It also has
> >>>> a separate probe function to be not dependent on AMBA/PrimeCell.
> >>>> It provides a device tree binding, but can easily be adapted to other
> >>>> device configuration systems.
> >>>> Beside the obvious effect of code sharing reusing most of the PL011
> >>>> code has the advantage of not introducing another serial device
> >>>> prefix, so it can go with ttyAMA, which seems to be pretty common.
> >>>>
> >>>> This series relies on Dave's recent PL011 fix[2], which gets rid of
> >>>> the loopback trick to get the UART going. There is a repo at [3]
> >>>> (branch sbsa-uart/v1), which has this patch already integrated.
> >>>>
> >>>> Patch 1/10 contains a bug fix which applies to the PL011 part also,
> >>>> it should be considered regardless of the rest of the series.
> >>>> Patch 2-7 refactor some PL011 functions by splitting them up into
> >>>> smaller pieces, so that most of the code can be reused later by the
> >>>> SBSA part.
> >>>> Patch 8 and 9 introduce two new properties for the vendor structure,
> >>>> this is for SBSA functionality which cannot be controlled by
> >>>> separate uart_ops members only.
> >>>> Patch 10 then finally drops in the SBSA specific code, by providing
> >>>> a new uart_ops, vendor struct and probe function for it. Also the new
> >>>> device tree binding is documented.
> >>>>
> >>>> For testing you should be able to take any hardware which has a PL011
> >>>> and change the DT to use a "arm,sbsa-uart" compatible string.
> >>>> Of course testing with a real SBSA Generic UART is welcomed!
> >>>>
> >>> I have tested this series on Juno where it seems to work and also on FVP
> >>> model where there are some issues.
> >>>
> >>> On the FVP when we enter usespace a couple of 32 character strings are
> >>> printed then nothing else. 32 Characters is a suspicious number.
> >>
> >> Can you try to add:
> >> -C bp.pl011_uart0.untimed_fifos=0
> >> to your model command line? (given that your model supports this option)
> >>
> >> We discovered that lately, also not sure how the default for this
> >> setting is handled these days in the various model versions.
> >>
> >> We are about to investigate this here atm.
> >> This issue seems to be introduced by Dave's FIFO patch.
> >>
> > 
> > With this setting userspace functions better but loses characters
> > fairly regularly.
> 
> Are you using arm,sbsa-uart in the DT, but a default PL011 in the model
> config? In my model the default PL011 version has a 16 byte FIFO only,
> specifying:
> -C bp.pl011_uart0.revision="r1p5"
> upgrades this to the SBSA specified 32 byte FIFO size.
> With this setting I don't see any character loses.
> 
Yes with this setting all works with untimed_fifos=0

I was not aware of the differences in versions thanks.

Graeme
