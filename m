From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH v2] tty: serial: sc16is7xx
Date: Fri, 21 Mar 2014 13:22:37 +0000
Message-ID: <20140321132237.7aebefcf@alan.etchedpixels.co.uk>
References: <1395324333-21221-1-git-send-email-jon@ringle.org>
	<20140321082609.GA3801@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140321082609.GA3801@xps8300>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, shc_work-JGs/UdohzUI@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 21 Mar 2014 10:26:09 +0200
Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> Hi,
>=20
> On Thu, Mar 20, 2014 at 10:05:33AM -0400, jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org wrote:
> > From: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>
> >=20
> > The SC16IS7xx is a slave I2C-bus/SPI interface to a single-channel
> > high performance UART. The SC16IS7xx=E2=80=99s internal register se=
t is
> > backward-compatible with the widely used and widely popular 16C450.
>=20
> So couldn't this be just a probe driver for 8250?

That was my first thought but if you look at 8250 and its locking
assumptions it is a very poor fit. Better for now it is separate I thin=
k.

Alan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
