From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH v8 4/4] serial: pl011: add console matching function
Date: Wed, 3 Aug 2016 09:33:51 +0100
Message-ID: <20160803083351.GD18515@xora-haswell.xora.org.uk>
References: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
 <1463749405-11640-5-git-send-email-aleksey.makarov@linaro.org>
 <c37d62c7-1e1b-0b10-a083-c5207fbbb820@gmail.com>
 <fd9443e7-67f1-93e7-834b-445f9c29d876@linaro.org>
 <20160620151913.GR1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160620151913.GR1041@n2100.armlinux.org.uk>
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
Cc: Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Lorenzo.Pieralisi@arm.com, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Sudeep.Holla@arm.com, linux-acpi@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>, "Zheng, Lv" <lv.zheng@intel.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Len Brown <lenb@kernel.org>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Christopher Covington <cov@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 20, 2016 at 04:19:14PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 20, 2016 at 03:26:39PM +0300, Aleksey Makarov wrote:
> > 
> > On 06/02/2016 09:02 PM, Aleksey Makarov wrote:
> > > 
> > > On 05/20/2016 04:03 PM, Aleksey Makarov wrote:
> > 
> > Hi Russell,
> > 
> > Can you review this patch please?
> > 
> > Thank you
> > Aleksey Makarov
> > 
> > >> This patch adds function pl011_console_match() that implements
> > >> method match of struct console.  It allows to match consoles against
> > >> data specified in a string, for example taken from command line or
> > >> compiled by ACPI SPCR table handler.
> > >>
> > >> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> > >> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> > > 
> > > Hi Greg, Russell,
> > > 
> > > Can you review this patch and consider ACKing it please?
> > > It had an ACK from Greg in v7 but since then I changed it a bit.
> > > 
> > > The patch by Christopher Covington [1] specifies that SBSA uart 
> > > does 32-bit access to registers and this breaks the match function.  
> > > In this series the function was changed to match when SPCR specifies
> > > both mmio32 and mmio access.  I removed Acked-by: Greg from this
> > > patch because of these changes.
> > > 
> > > The difference between v7 and v8:
> > > 
> > > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > > index 4139b64..388edc8 100644
> > > --- a/drivers/tty/serial/amba-pl011.c
> > > +++ b/drivers/tty/serial/amba-pl011.c
> > > @@ -2328,10 +2329,10 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
> > >  
> > >                 port = &amba_ports[i]->port;
> > >  
> > > -               if (port->iotype != iotype)
> > > +               if (iotype != UPIO_MEM && iotype != UPIO_MEM32)
> > >                         continue;
> > > -               if ((iotype == UPIO_MEM || iotype == UPIO_MEM32) &&
> > > -                   (port->mapbase != addr))
> > > +
> > > +               if (port->mapbase != addr)
> > >                         continue;
> > >  
> > >                 co->index = i;
> 
> I'm looking at this change, and I don't know what effect it ultimately
> has.  This is kind of a problem, because I've zero knowledge of ACPI,
> and so I can't say whether this change is appropriate or not.  I have
> no ARM server platforms (yet), nor any access to them, so I can't even
> try it out.
> 
> In short, I've no idea.  I guess it's up to those who have come up
> with SBSA to decide whether this is an appropriate change or not.
> 

Lorenzo, Sudeep, as ARM ACPI maintainers and keepers of SBSA do you have
any comment on this?

Graeme
