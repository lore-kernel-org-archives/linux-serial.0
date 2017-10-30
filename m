From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] tty: amba-pl011: Report AUTOCTS capability to framework
Date: Tue, 31 Oct 2017 00:46:53 +0100 (CET)
Message-ID: <2129655909.63812.1509407213334@email.1und1.de>
References: <1509368586-26662-1-git-send-email-stefan.wahren@i2se.com>
 <20171030233228.GA3183@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171030233228.GA3183@wunner.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lukas Wunner <lukas@wunner.de>
Cc: gregkh@linuxfoundation.org, phil@raspberrypi.org, linux-serial@vger.kernel.org, jslaby@suse.com, loic.poulain@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Lukas,

> Lukas Wunner <lukas@wunner.de> hat am 31. Oktober 2017 um 00:32 geschrieben:
> 
> 
> On Mon, Oct 30, 2017 at 11:24:31PM +0000, Stefan Wahren wrote:
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -2029,9 +2029,11 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
> >  
> >  		old_cr |= UART011_CR_CTSEN;
> >  		uap->autorts = true;
> > +		port->status |= UPSTAT_AUTOCTS;
> >  	} else {
> >  		old_cr &= ~(UART011_CR_CTSEN | UART011_CR_RTSEN);
> >  		uap->autorts = false;
> > +		port->status &= ~UPSTAT_AUTOCTS;
> >  	}
> >  
> >  	if (uap->vendor->oversampling) {
> 
> Don't you also need to clear the UPSTAT_AUTOCTS bit in pl011_disable_uart()?
> 
> FWIW I posted a patch to linux-serial on Oct 25 which subsumes the above
> patch, would that work for you?
> 
> https://marc.info/?l=linux-serial&m=150891880104614&w=4

sorry for missing your patch. Mine should be ignored.

> 
> Thanks,
> 
> Lukas
