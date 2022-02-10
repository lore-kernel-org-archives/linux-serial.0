Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3435DC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Feb 2022 21:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbiBJVaq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Feb 2022 16:30:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiBJVaq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Feb 2022 16:30:46 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C718FAF
        for <linux-serial@vger.kernel.org>; Thu, 10 Feb 2022 13:30:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a39so11761151pfx.7
        for <linux-serial@vger.kernel.org>; Thu, 10 Feb 2022 13:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5sSuTv01uKJX2BSY7gXajvrbiy249c2MdujX+HPxpDI=;
        b=lopQbUk3YDraN3JAFtk//t1xpsV+xisZ64cmsRReuJq20Ku5VgzE7eEUQ5+IGxUuDz
         SL0P4OxNgFhByw6TKTcOLJiEfNaOTrTeB5l5Hrv+8tzoMsff6Sm4iQtmHaFs/2Yslu+G
         N/paGZ62h8ytYx/l8R3Lc0ekbcZ2Imib03ZU5FE+5jioGxOTDUq5M3rE3Q+a4/eOSzFl
         xFLeFNuXAASTNovZs94pOEpI6g2yLhyTy2oT2lm353f3DIVmUEIO9eWvUTwGbdmQaKdr
         8Kq6SlPWqnjfEeppVKcSq9iJbvmVKxgT3AkqCovqUxP50LoIV1Qs2jMhjYcNtwF+w/2b
         JeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5sSuTv01uKJX2BSY7gXajvrbiy249c2MdujX+HPxpDI=;
        b=5SsguQT/h0jd21Vboe2UqwS5TRO4ub0LsCZW5S41P1RwThshhu3QO0jF59oiWC8Yuc
         397vRoF/NTK7IUCo42DoyUiLviHjXSPKL00BhSP/OXi5KhjOF5KEhmRmWVba9rp4+eKE
         kjgh3LoJkOJcTaTy7rHf6tDLRMtXWa1CId15tUEsNJzDZ4LcHQ9FO3VTLYAIYOatXQsH
         v+8F2rD18beuvJV9BBKgMzbLT1oW6yz9z1NdJoMDgtvzaAsJblgsv6yM2360Yr4lDOwu
         HPCkZ2FWth8JrvTcXEmiEXhc33+SOdpwmMStcTMg3JaJTHZqa2dw0WhdjR1Udjh/Iz4e
         Xgng==
X-Gm-Message-State: AOAM533oo6lNidnzEW5Tju3fza7ybGjxkabTwMdaFoiYF6hvQOwuLqzB
        Co3R4fVJayVnnljaC0pjhTFDc6dcjVtft37MEeBMbJttprpVRA==
X-Google-Smtp-Source: ABdhPJxZ068WqeKiQ8jA0eV+KVQ67f4cucCBjR4NafSv2eqwSxGF1Efgx4uR7Um/JFd5A8JcU5FwkrB4XdalMj4vSWY=
X-Received: by 2002:a63:874a:: with SMTP id i71mr4039591pge.440.1644528644898;
 Thu, 10 Feb 2022 13:30:44 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU0CrD8091W5zH7ve9v3ZVAGXR6=6DGebd5LhHz4mzt4+w@mail.gmail.com>
 <CAJ+vNU1tJ5W5RCUsPehgH7CS=v=7mttHgNOu-UdWGVpzf2LcBQ@mail.gmail.com>
 <4bdbd9c0-8ce3-84b1-9f89-be89b686c652@camlingroup.com> <c66ae9ce-7345-736c-010e-1dd5602b67df@gmail.com>
 <CAJ+vNU2qk6G_YLAr-1_FP1czBe8wF2OUOTu914zLVNN0Lm9UFQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU2qk6G_YLAr-1_FP1czBe8wF2OUOTu914zLVNN0Lm9UFQ@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 10 Feb 2022 13:30:33 -0800
Message-ID: <CAJ+vNU2ra8g90ZWcwS0xnRq3LO_4Q2PFJo-OuXuBgCpPsXcXkg@mail.gmail.com>
Subject: Re: Modem control lines for RTSCTS hardware flow control via rts-gpio
 and cts-gpio with IMX
To:     Richard Genoud <richard.genoud@gmail.com>
Cc:     =?UTF-8?Q?Tomasz_Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Huang Shijie <b32955@freescale.com>,
        Dirk Behme <dirk.behme@googlemail.com>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 26, 2022 at 4:00 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Mon, Jan 24, 2022 at 1:52 AM Richard Genoud <richard.genoud@gmail.com>=
 wrote:
> >
> >
> > Hi,
> >
> > Le 14/01/2022 =C3=A0 07:19, Tomasz Mo=C5=84 a =C3=A9crit :
> > > On 14.01.2022 04:08, Tim Harvey wrote:
> > >> So I believe in order to support using gpios for rts/cts in the imx
> > >> uart driver I must find the right place to call imx_uart_rts_active
> > >> and imx_uart_rts_inactive when the FIFO is not full and full
> > >> respectively. I'm not that familiar with the Linux uart driver
> > >> framework - am I on the right track and if so any ideas where this i=
s
> > >> best done?
> > >
> > > It is not really the driver (and thus FIFO level), but rather the amo=
unt
> > > of free space in tty buffer (checked by Line Discipline workqueue) th=
at
> > > determines when to throttle (set RTS inactive). This mostly works fin=
e,
> > > but fails [1] when the RX interrupt frequency is too high [2].
> > >
> > > The throttle/unthrottle request, when termios CRTSCTS is set, is seen=
 by
> > > the driver as the call to .set_mctrl (imx_uart_set_mctrl) with TIOCM_=
RTS
> > > bit cleared/set in mctrl parameter. Currently imx_uart_set_mctrl() on=
ly
> > > controls the UCR2_CTS and UCR2_CTSC bits based on mctrl.
> > >
> > > To support your case you would most likely have to add the gpio handl=
ing
> > > in imx_uart_set_mctrl(). However, I am unaware what other issues you
> > > might encounter (i.e. if it is not done there yet simply because nobo=
dy
> > > had that use case or if there is some deeper problem).
> > >
> > > [1] https://lore.kernel.org/linux-serial/10e723c0-a28b-de0d-0632-0bd2=
50478313@camlingroup.com/
> > > [2] https://lore.kernel.org/linux-serial/20220104103203.2033673-1-tom=
asz.mon@camlingroup.com/
> > >
> > > Best Regards,
> > > Tomasz Mon
> > >
> >
> > I'd suggest to start testing with a serial port connected to nothing, a=
nd check the pins values
> > with a scope or a voltmeter.
> > Setting pins values from userspace can done quite easily with :
> > #include <unistd.h>
> > #include <termios.h>
> > #include <stdio.h>
> > #include <sys/ioctl.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> >
> > void usage(char *prog)
> > {
> >         printf("usage: %s serial_port id 0/1 sleep_time_sec\n", prog);
> >         printf("%s\n", "1:DTR   DTR (data terminal ready)");
> >         printf("%s\n", "2:RTS   RTS (request to send)");
> >         printf("%s\n", "3:Both");
> > }
> >
> > int main(int argc, char **argv)
> > {
> >         int fd;
> >         unsigned status =3D 0;
> >         int enable;
> >         int err;
> >
> >         if (argc < 5) {
> >                 usage(argv[0]);
> >                 return -1;
> >         }
> >
> >         fd =3D open(argv[1], O_RDWR | O_NOCTTY);
> >
> >         enable =3D atoi(argv[3]);
> >
> >         if (fd < 0)
> >                 return -1;
> >
> >
> >         switch(atoi(argv[2])) {
> >         case 0:
> >                 if (enable)
> >                         status |=3D TIOCM_LE;
> >                 break;
> >         case 1:
> >                 if (enable)
> >                         status |=3D TIOCM_DTR;
> >                 break;
> >         case 2:
> >                 if (enable)
> >                         status |=3D TIOCM_RTS;
> >                 break;
> >         case 3:
> >                 if (enable)
> >                         status |=3D TIOCM_DTR | TIOCM_RTS;
> >                 break;
> >         default:
> >                 printf("unknown signal\n");
> >         }
> >
> >         err =3D ioctl(fd, TIOCMSET, &status);
> >         sleep(atoi(argv[4]));
> > out:
> >         if (fd > -1)
> >                 close(fd);
> >
> >         return err;
> > }
> >
>
> Richard,
>
> Thanks, I've been able to use this as well as terminal apps like
> picocom and a scope to ensure that the RTS gpio is getting asserted
> properly and that the CTS gpio is getting handled accordingly. Both
> these signals are configured with internal pull-ups.
>
> With for example:
>         cts-gpios =3D <&gpio6 2 GPIO_ACTIVE_LOW>; // input to IMX
>         rts-gpios =3D <&gpio6 3 GPIO_ACTIVE_LOW>; // output from IMX
>
> I see that when rts is set to 1 (ie 'uart_test /dev/ttymxc3 2 1 3' or
> 'picocom /dev/ttymxc3 --flow h') the normally pulled-up logic high RTS
> gpio goes to 0V and when rts is set to 0 it goes back to 3.3V via the
> pull-up.
>
> I've also been able to add debugging to ensure that when the CTS
> signal is manually grounded that mctrl_gpio_irq_handle is called with
> CTS=3D1 and imx_uart_start_tx is called to enable transmission and when
> CTS signal is released from GND going back to 3.3V via the pull-up
> mctrl_gpio_irq_handle is called with CTS=3D0 and imx_uart_stop_tx is
> called to halt transmission.
>
> I've also verified that changing the gpio descriptor in the dts above
> to GPIO_ACTIVE_HIGH negates the above logic which is clearly wrong as
> these are active-low signals.
>
> In this specific case the device I am connecting the IMX
> UART3_TX/UART3_RX and the GPIO's for RTS/CTS to is a Laird
> Sterling-LWB wifi/BT chip. The datasheet [1] shows:
> pin 31: BT_UART_RTS_L output UART Request-to-send
> pin 32: BT_UART_CTS_L input UART Clear-to-send
> pin 33: BT_UART_TXD output UART transmit
> pin 34: BT_UART_RXD input UART input
>
> They are connected to the IMX as:
> BT_UART_RXD(pin34) <- IMX CSI0_DAT12_UART4_TXD
> BT_UART_TXD(pin33) -> IMX CSI0_DAT13_UART4_RXD
> BT_UART_CTS_L(pin32) <- IMX CSI0_DAT17_UART4_RTS_B (GPIO6_IO3)
> BT_UART_RTS_L(pin31) -> IMX CSI0_DAT16_UART4_CTS_B (GPIO6_IO2)
>
> And again if pinmuxed as RTS/CTS communication with the BT HCI is fine
> but if pinmuxed as GPIO and configured as the following BT HCI
> communication fails:
>         cts-gpios =3D <&gpio6 2 GPIO_ACTIVE_LOW>; /* in to IMX from HCI
> BT_UART_RTS_L output */
>         rts-gpios =3D <&gpio6 3 GPIO_ACTIVE_LOW>; /* out from IMX to HCI
> BT_UART_CTS_L input */
>
> I'm not sure what else to look at here.
>
> Best regards,
>
> Tim
> [1] - https://www.lairdconnect.com/documentation/datasheet-sterling-lwb

I have found the issue here which causes hardware flow control when
using GPIO's with the imx UART driver to fail. The
imx_uart_set_termios() function clears the UCR2_IRTS whenver hardware
flow control is enabled which configures the transmitter to only send
with the RTS pin is asserted. In the case of a GPIO being used instead
of the dedicated internal RTS pin for the uart, this will keep the
transmitter from ever transmitting. In the hardware flow control case
where a GPIO is used UCR2_IRTS must be set to ignore the RTS pin. We
can use the have_rtsgpio flag which is set when 'rts-gpios' property
is used as a qualifier for this.

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index df8a0c8b8b29..d506cbd679dd 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1674,8 +1674,7 @@ imx_uart_set_termios(struct uart_port *port,
struct ktermios *termios,
                if (ucr2 & UCR2_CTS)
                        ucr2 |=3D UCR2_CTSC;
        }
-
-       if (termios->c_cflag & CRTSCTS)
+       if (!sport->have_rtsgpio && termios->c_cflag & CRTSCTS)
                ucr2 &=3D ~UCR2_IRTS;
        if (termios->c_cflag & CSTOPB)
                ucr2 |=3D UCR2_STPB;

If this makes sense, I'll send a patch.

Best regards,

Tim
