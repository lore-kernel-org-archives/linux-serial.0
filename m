From: Yao Yuan <yao.yuan@freescale.com>
Subject: RE: [PATCH 2/2] serial: fsl_lpuart: add eDMA support
Date: Mon, 13 Jan 2014 06:47:14 +0000
Message-ID: <1d437762499348b6aeca3621b151d770@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
 <1389236681-30372-3-git-send-email-yao.yuan@freescale.com>
 <201401090956.38789.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201401090956.38789.arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi, Arnd

> Arnd Bergmann wrote:
> 
> > @@ -131,6 +158,10 @@ static struct of_device_id lpuart_dt_ids[] = {
> > };  MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
> >
> > +static int lpuart_dma_tx(struct lpuart_port *sport, unsigned long
> > +count); static int lpuart_dma_rx(struct lpuart_port *sport); static
> > +void lpuart_prepare_tx(struct lpuart_port *sport);
> > +
> >  static void lpuart_stop_tx(struct uart_port *port)  {
> >  	unsigned char temp;
> 
> Coding style: Please try to avoid forward declarations for "static"
> functions.
> Instead, reorder the code in a way that they are not needed.
> 
> 	Arnd
> 

I need the functions like this:
Static A()
{
	if(condition) 
		B();
}
Static B()
{
	callback:C();
}
Static C()
{
	if(condition)
		A();
}

So, it's hard to avoid forward declarations for "static" functions. I'm very glad for a better way.
