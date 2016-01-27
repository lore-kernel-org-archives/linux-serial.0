From: Martin Fuzzey <mfuzzey-mB3Nsq4MPf1BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Serial ports with non connected RTS/CTS
Date: Wed, 27 Jan 2016 12:33:32 +0100
Message-ID: <56A8AB0C.8010407@parkeon.com>
References: <56A89C48.1040604@parkeon.com>
 <20160127115817.79e384b1@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160127115817.79e384b1-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On 27/01/16 11:58, Lothar Wa=C3=9Fmann wrote:
>
> If a driver has no support for RTS/CTS (e.g. due to the missing
> fsl,uart-has-rtscts property for i.MX UARTs) then trying to enable HW
> flowcontrol via the TCETS ioctl should fail (as is the case with the
> i.MX serial driver).
> Thus it should be impossible to enable crtscts if the serial driver h=
as
> no RTC/CTS support without any need for userspace to know about the
> HW details.

It doesn't do that for me [kernel 4.4]

The stty command to activate rtscts does return an error if the hardwar=
e=20
doesn't support it.

# stty -F /dev/ttymxc1 crtscts
stty: /dev/ttymxc1: unable to perform all requested operations

But the TCETS ioctl  itselfdoes not fail:

ioctl(0, SNDCTL_TMR_STOP or TCSETSW, {B115200 -opost -isig -icanon -ech=
o=20
=2E..}) =3D 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon=20
-echo ...}) =3D 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon=20
-echo ...}) =3D 0
write(2, "stty: ", 6stty: )                   =3D 6
write(2, "/dev/ttymxc1: unable to perform "..., 56/dev/ttymxc1: unable=20
to perform all requested operations) =3D 56


The error message is because stty does a TCGETS afterwards and errors i=
f=20
the result is different to that requested.

slattach does not compare the requested and actual configuaration


The kernel code in the imx driver is:
static void
imx_set_termios(struct uart_port *port, struct ktermios *termios,
            struct ktermios *old)
{
=2E..
     if (termios->c_cflag & CRTSCTS) {
         if (sport->have_rtscts) {
             ucr2 &=3D ~UCR2_IRTS;

             if (port->rs485.flags & SER_RS485_ENABLED) {
                 /*
                  * RTS is mandatory for rs485 operation, so keep
                  * it under manual control and keep transmitter
                  * disabled.
                  */
                 if (!(port->rs485.flags &
                       SER_RS485_RTS_AFTER_SEND))
                     ucr2 |=3D UCR2_CTS;
             } else {
                 ucr2 |=3D UCR2_CTSC;
             }
         } else {
             termios->c_cflag &=3D ~CRTSCTS;
         }
     } else if (port->rs485.flags & SER_RS485_ENABLED)


So requesting RTSCTS if the hardware doesn't support it does not=20
generate an error but the bit is reset in the termios structure.

This makes sense to me. Userspace can ask for something - the driver=20
does it's best and reports to userspace what it actually did.
It's then up to userspace to decide if that's acceptable.

And indeed "man termios" :

"Note that *tcsetattr*() returns success if /any/ of the requested=20
changes could be successfully carried out. Therefore, when making=20
multiple changes it may be necessary to follow this call with a further=
=20
call to *tcgetattr*() to check that all changes have been performed=20
successfully. "



Martin


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
