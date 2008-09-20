From: Michael Trimarchi <trimarchimichael@yahoo.it>
Subject: Re: [PATCH] atmel_serial: update the powersave handler to match serial core
Date: Sat, 20 Sep 2008 09:31:23 +0000 (GMT)
Message-ID: <332452.26141.qm@web26208.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752985AbYITJbg@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anti Sullin <anti.sullin@artecdesign.ee>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Victor <linux@maxim.org.za>
List-Id: linux-serial@vger.kernel.org

Hi,

----- Messaggio originale -----
> Da: Anti Sullin <anti.sullin@artecdesign.ee>
> A: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
> Cc: Michael Trimarchi <trimarchimichael@yahoo.it>; linux-serial@vger.=
kernel.org; linux-kernel@vger.kernel.org; Andrew Victor <linux@maxim.or=
g.za>
> Inviato: Venerd=EC 19 settembre 2008, 23:49:29
> Oggetto: Re: [PATCH] atmel_serial: update the powersave handler to ma=
tch serial core
>=20
> Haavard Skinnemoen wrote:
> > Michael Trimarchi wrote:
> > =20
> >>> I agree it would be useful. It would require changing the port mu=
x
> >>> configuration from the driver though, and there's no standardized
> >>> interface for doing that. Maybe this is a good motivation to come=
 up
> >>> with one?
> >>> =20
> >>>     =20
> >> I think that a driver can do the request to a the gpio layer (may =
can be=20
> implemented
> >> by the gpio-lib ) and give it only the gpio. The "gpio-lib" can sa=
ve and=20
> restore
> >> the status of the gpio, and request the handler, passing the gpio-=
id as=20
> >> a data. So when the handler fire, we can now which peripheral is
> >> interested on the wake-up event.
> >>   =20
> >
> > I don't think the gpio layer is supposed to touch the portmux. Davi=
d
> > has always been very clear about that. But if we somehow manage to =
get
> > the pin configured as a GPIO, we can use the GPIO layer to request =
a
> > pin change interrupt.
> >
> > It _might_ work even if you don't reconfigure the pin as a GPIO...b=
ut
> > then I think we'd be relying on undocumented behaviour.
> > =20
> I believe that you don't need to reconfigure the pin. The gpio hw doe=
s
> not require the pin to be multiplexed to any given state, so does not=
=20
> request_irq (correct?).
> I did this trick in my [2/3] MCI driver patch I sent to arm-linux-ker=
nel at=20
> 18.03.2008 (the
> e-mail subject line was wrong, [1/3], though) and I'm using that patc=
h still on=20
> my
> production devices to avoid some rare but critical SD data corruption=
 (mainline=20
> kernel still=20
> screws up the filesystem on SD sometimes). The same should be easily =
usable on=20
> serial port, too.
>

I must to check this point. I do it few months ago, and if I remember I=
 change
the serial configuration on rx line to a gpio and request and interrupt=
=2E I don't
have the hardware to recheck.

> > =20
> >>> Btw, I assume the first character you receive will be lost when y=
ou do
> >>> this, right?
> >>> =20
> >>>     =20
> >> Yes, I haven't done a lot of test to see how many chars are lost (=
sure one I=20
> think).=20
> >> Depends on the time spent after
> >>
> >>  /* Wait for interrupt to wake us up */=20
> >>   mcr p15, 0, r0, c7, c0, 4=20
> >>   =20
> >
> > Yes, we need to reach the atmel_serial resume handler before the UA=
RT
> > gets any chance to recognize the character. It's probably too late =
for
> > the first one, but it may catch the next one assuming the baud rate
> > isn't too high.
> > =20
> I believe, that we loose quite many characters. We are running at 32/=
16kHz
> (switching the master clock divider /2 off proved unstable) and
> this is not enough to even receive 9600 baud until we have the fast c=
lock
> running again.
>=20
> Some quick calculations:
> For waking up, we need to switch on the main oscillator, wait until i=
t
> stabilizes (default should be max: ~60ms), switch on plla, wait until=
 it
> locks (2ms), switch on pllb, wait until it locks (2ms), switch system=
 to PLLA...
> And then set up the drivers again... On 115200 baud, this is almost 1=
kB!
>=20
> So in many applications we could not use this. But this might still c=
ome handy
> in a lot of cases we can poll and find out what caused the data on th=
e serial
> port etc. Or on applications, where this loss of data does not matter=
 (like=20
> debug
> console where the resume is usable even if it does not wake up on the=
 first=20
> byte).

Of course, but it is the same for all devices when you do a suspend wit=
h a=20
slow clock.
=20
>=20
>=20
> --=20
> Anti Sullin
> Embedded Software Engineer
> Artec Design LLC
> Akadeemia tee 23A, 12618, Tallinn, Estonia
> http://www.artecdesign.ee=20

Regards Michael

__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da ta=
nto spazio gratuito per i tuoi file e i messaggi=20
http://mail.yahoo.it=20
