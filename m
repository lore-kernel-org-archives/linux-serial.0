From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] atmel_serial: keep the platform_device unchanged
Date: Fri, 17 Jun 2011 05:06:12 +0200
Message-ID: <20110617030612.GK4581@game.jcrosoft.org>
References: <1302724038-26236-1-git-send-email-plagnioj@jcrosoft.com>
	<1307522703.10626.9.camel@hcegtvedt.norway.atmel.com>
	<20110608134730.GA17584@game.jcrosoft.org>
	<1307541740.10626.15.camel@hcegtvedt.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1307541740.10626.15.camel@hcegtvedt.norway.atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Patrice Vilchez <patrice.vilchez@atmel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 16:02 Wed 08 Jun     , Hans-Christian Egtvedt wrote:
> On Wed, 2011-06-08 at 15:47 +0200, Jean-Christophe PLAGNIOL-VILLARD
> wrote:
> > On 10:45 Wed 08 Jun     , Hans-Christian Egtvedt wrote:
> > > On Wed, 2011-04-13 at 21:47 +0200, Jean-Christophe PLAGNIOL-VILLARD
> > > wrote:
> 
> <snipp>
> 
> > > > diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
> > > > index bfc9d07..aa677e2 100644
> > > > --- a/arch/avr32/mach-at32ap/at32ap700x.c
> > > > +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> > > > @@ -1014,6 +1014,7 @@ static struct platform_device *__initdata at32_usarts[4];
> > > >  void __init at32_map_usart(unsigned int hw_id, unsigned int line, int flags)
> > > >  {
> > > >  	struct platform_device *pdev;
> > > > +	struct atmel_uart_data *pdata;
> > > >  
> > > >  	switch (hw_id) {
> > > >  	case 0:
> > > > @@ -1042,7 +1043,8 @@ void __init at32_map_usart(unsigned int hw_id, unsigned int line, int flags)
> > > >  		data->regs = (void __iomem *)pdev->resource[0].start;
> > > >  	}
> > > >  
> > > > -	pdev->id = line;
> > > 
> > > AVR32 needs this to be present to work independent of which USART
> > > peripheral the user chooses to use for console.
> > > 
> > > > +	pdata = pdev->dev.platform_data;
> > > > +	pdata->num = portnr;
> > here supposed to be
> > 	pdata->num = line;
> 
> I know, but that doesn't fix the problem about not able to find a
> console, the platform data id must also be 0 (if console is on ttyS0)
> AFAICT.
will test this weekend on avr32

Best Regards,
J.
