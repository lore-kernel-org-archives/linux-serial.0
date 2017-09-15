From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: Re: [PATCH v2 3/6] serial: imx: remove CTSC and CTS handling
Date: Fri, 15 Sep 2017 21:57:30 +0100
Message-ID: <20170915205730.GA31343@hermes.home>
References: <20170705133845.32ov37meqcea3wtz@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170705133845.32ov37meqcea3wtz@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: u.kleine-koenig@pengutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>, Fabio Estevam <fabio.estevam@nxp.com>, Clemens Gruber <clemens.gruber@pqgruber.com>
List-Id: linux-serial@vger.kernel.org

Hi

On Wed, Jul 05, 2017 at 03:38:45PM +0200, Uwe Kleine-König wrote:
> Cc += Clemens Gruber + Fabio Estevam
> 
> On Wed, Jul 05, 2017 at 03:07:03PM +0200, Romain Perier wrote:
> > From: Nandor Han <nandor.han@ge.com>
> > 
> > CTSC and CTS are not related to DMA and might add
> > disruption in some cases.
> > 
> > Signed-off-by: Romain Perier <romain.perier@collabora.com>
> 
> If it was Nandor Han who created this patch, it would be great to get
> his sob. If it was you, drop the From: line above.
> 

This patch was broken out from a larger one written by Nandor, who is
happy for me to add his sob.

> > ---
> >  drivers/tty/serial/imx.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 5291b86..dd3ebb4 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1249,11 +1249,6 @@ static void imx_disable_dma(struct imx_port *sport)
> >  	imx_stop_rx_dma(sport);
> >  	imx_stop_tx_dma(sport);
> >  
> > -	/* clear UCR2 */
> > -	temp = readl(sport->port.membase + UCR2);
> > -	temp &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
> > -	writel(temp, sport->port.membase + UCR2);
> > -
> 
> Before this patch imx_disable_dma resulted in the #CTS pin being high
> (inactive).
> 
> Does this qualify as a fix? If so, you should sort this patch to the
> beginning of the series. Did you do test this patch and its effects
> separately?
> 

I've been giving the RTS/CTS lines a bit of a kick with (and without) this
patch and I'm seeing what I'd expect to see on the CTS pin (the Wandboard
I'm using runs this in DCE mode even though it really should be in DTE
mode, hey ho). Using a little test app I've found/modified (listed below),
the CTS line can be (de)asserted whilst the device is open and the line
gets deasserted when the device closes. I have tested this port both when
acting as a console (and thus with DMA turned off) and when not used as a
console, with DMA enabled (confirmed with existing debug in driver).

This matches the behaviour of a FTDI based debug board that I've also
tried (in this case I looked at the RTS line as the device is running as a
DTE).

On my PC the same test app sets the RTS line (the serial port running as a
DTE, 8250_pnp driver) results in the CTS line being set appropriately as
well. It also stays in that state even after the serial device is closed,
this does seem right either but there you go.

With regards to the operation of the CTS/RTS line when twiddling it via
the ioctl, I think the behaviour of the IMX/FTDI is the expected one. Is
that the case?

Which I guess brings us to the lines above.

When running as an RS232 port (i.e. not rs485) the driver is using the
automatic CTSC control based on a rxFIFO watermark unless the state of the
CTS line is explictly set via an ioctl call. As such, unless I'm missing
something, the rxFIFO (and thus the automatic CTS control) is independent
of whether the DMA is running or not and thus this section looks wrong or
is at the very least in the wrong place.

Have I misunderstood something?

IIRC, the timing of DMA being enabled and disabled was changed reasonably
recently did that fix the #CTS issue possibly?

Martyn

----

Test app:

#include <stdio.h>
#include <stdlib.h>
#include <termios.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdbool.h>

static struct termios oldterminfo;


void closeserial(int fd)
{
    tcsetattr(fd, TCSANOW, &oldterminfo);
    if (close(fd) < 0)
        perror("closeserial()");
}


int openserial(char *devicename)
{
    int fd;
    struct termios attr;

    if ((fd = open(devicename, O_RDWR)) == -1) {
        perror("openserial(): open()");
        return 0;
    }
    if (tcgetattr(fd, &oldterminfo) == -1) {
        perror("openserial(): tcgetattr()");
        return 0;
    }
    attr = oldterminfo;
    attr.c_cflag |= CRTSCTS | CLOCAL;
    attr.c_oflag = 0;
    if (tcflush(fd, TCIOFLUSH) == -1) {
        perror("openserial(): tcflush()");
        return 0;
    }
    if (tcsetattr(fd, TCSANOW, &attr) == -1) {
        perror("initserial(): tcsetattr()");
        return 0;
    }
    return fd;
}


int setRTS(int fd, int level)
{
    int status;

    if (ioctl(fd, TIOCMGET, &status) == -1) {
        perror("setRTS(): TIOCMGET");
        return 0;
    }
    if (level)
        status |= TIOCM_RTS;
    else
        status &= ~TIOCM_RTS;
    if (ioctl(fd, TIOCMSET, &status) == -1) {
        perror("setRTS(): TIOCMSET");
        return 0;
    }
    return 1;
}


int main(int argc, char *argv[])
{
    int fd;
    bool loop = true;
    int state = 1;
    int got;
    

    fd = openserial(argv[1]);
    if (!fd) {
        fprintf(stderr, "Error while initializing %s.\n", argv[1]);
        return 1;
    }


    while(loop) {
        printf("Switching RTS %s\n", state ? "on" : "off");
        setRTS(fd, state);

        state = (++state) % 2;

	got = getchar();
	if (got == 'q')
            break;
    }
    closeserial(fd);
    return 0;
}
