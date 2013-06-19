From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 1/5] ARM: davinci: uart: move to devid based clk_get
Date: Wed, 19 Jun 2013 09:20:19 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA82A60@DBDE04.ent.ti.com>
References: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
	<1369729686-6595-2-git-send-email-prakash.pm@ti.com>
	<51B06547.8030709@ti.com> <51B06803.2020008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51B06803.2020008-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "hs-ynQEQJNshbs@public.gmane.org" <hs-ynQEQJNshbs@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Sekhar,

Thanks for the review.

On Thu, Jun 06, 2013 at 16:14:19, Nori, Sekhar wrote:
> 
> 
> On 6/6/2013 4:02 PM, Sekhar Nori wrote:
> > Hi Prakash,
> > 
> > It appears that this patch was not tested thoroughly. See below:
> > 
> > On 5/28/2013 1:58 PM, Manjunathappa, Prakash wrote:
> >> For modules having single clock, clk_get should be done with dev_id.
> >> But current davinci implementation handles multiple instances
> >> of the UART devices with single platform_device_register. Hence clk_get
> >> is based on con_id rather than dev_id, this is not correct. Do
> >> platform_device_register for each instance and clk_get on dev_id.
> >>
> >> Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
> >> ---
> > 
> >> -static struct plat_serial8250_port da8xx_serial_pdata[] = {
> >> +static struct plat_serial8250_port da8xx_serial0_pdata[] = {
> >>  	{
> >>  		.mapbase	= DA8XX_UART0_BASE,
> >>  		.irq		= IRQ_DA8XX_UARTINT0,
> >> @@ -75,7 +75,9 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
> >>  					UPF_IOREMAP,
> >>  		.iotype		= UPIO_MEM,
> >>  		.regshift	= 2,
> >> -	},
> >> +	}
> >> +};
> >> +static struct plat_serial8250_port da8xx_serial1_pdata[] = {
> >>  	{
> >>  		.mapbase	= DA8XX_UART1_BASE,
> >>  		.irq		= IRQ_DA8XX_UARTINT1,
> >> @@ -83,7 +85,9 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
> >>  					UPF_IOREMAP,
> >>  		.iotype		= UPIO_MEM,
> >>  		.regshift	= 2,
> >> -	},
> >> +	}
> >> +};
> >> +static struct plat_serial8250_port da8xx_serial2_pdata[] = {
> >>  	{
> >>  		.mapbase	= DA8XX_UART2_BASE,
> >>  		.irq		= IRQ_DA8XX_UARTINT2,
> >> @@ -91,18 +95,31 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
> >>  					UPF_IOREMAP,
> >>  		.iotype		= UPIO_MEM,
> >>  		.regshift	= 2,
> >> -	},
> >> -	{
> >> -		.flags	= 0,
> >> -	},
> >> +	}
> > 
> > 8250_core.c relies on sentinel value with p->flags = 0 to terminate
> > looking for more ports. You don't have sentinel values in any of pdata
> > the arrays you introduced so the code basically goes looking into areas
> > of memory not its own. This caused bunch of "cannot register port"
> > errors for me but I can easily imagine more serious errors.

Will fix this.

> 
> Similarly, you check for platform_data being NULL to go over the list of
> serial devices in the code in serial.c you introduced, but don't have a
> sentinel when you define the serial device array.
> 

I have fixed this and above, posted patch here:
http://davinci-linux-open-source.1494791.n2.nabble.com/PATCH-v3-0-5-ARM-davinci-fix-UART-clock-enabling-tt7583378.html

Thanks,
Prakash
