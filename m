Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC8C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 27 Jan 2022 00:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiA0ABJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jan 2022 19:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiA0ABJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jan 2022 19:01:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03ADC061749
        for <linux-serial@vger.kernel.org>; Wed, 26 Jan 2022 16:01:08 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 192so1120296pfz.3
        for <linux-serial@vger.kernel.org>; Wed, 26 Jan 2022 16:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MGYUHvi7A8UXxVTDgB3ih2stRzXMVUnntclvN7F/AzE=;
        b=JEGd+o20mPZUSmrq26hBe4QINZZn+vMPf01vwKMv6npr5YAluWU38aDcAqiZ98C210
         H4FlAWiy5nYrZiOT1O5HO//2GxEl8PCDRo/u8hlfrP5Bf5sQ31JAwcZXDTJwJjodJsyB
         WpzlUhXLkyNiRHY8/MNn4DqEM0wyY6WduwTDs/Fhi0gZmiQ5J2nE10IPuolTyCdrNyS0
         2O2o0br22Z1HEAW1emSVgWzOipCEgFXbNvN0tNP1xkvBx2ZhpIm5c7Ug0rTctPCPNSWJ
         RvnQZlMfCEFy67ZqpntMJrB3Jvw/4MERhpZbl+I65H48lp7M7J3GeHhjGFZ2xoxkxxcW
         1oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MGYUHvi7A8UXxVTDgB3ih2stRzXMVUnntclvN7F/AzE=;
        b=pNu0YIOxDhvszyNKB7cZREzL48tGxG8hMBfwIpiy5fak/F/nwR4JAbWlbelcjbg5gt
         VI1eUR1asJApI+t9jjSGw4SBzPJgSu4O8PPE9vM5GuzA6rZKBmkpyrdR3UTGswba6xVz
         6dRLcu/XAqy1iD+HV3RgkaEkwa6rbqWKOtdxBVmTnk43+X89ysVlHxC9wcbnv9NJgsY5
         pj2IalWRcdm3PTuTTdECAr8Sa90FBLnZ+iaP4OR8F7nN5xlUhXum5Sp2ngBF1v2TR3Mc
         /dxBJvE+LH6YF7NS7je9FBaaMiSijIi64wj3CofsFEuTK+QmWHJNm7Ct8XVpR53DMKT1
         lHDQ==
X-Gm-Message-State: AOAM530y4kSJX3lQlLEfBoqHWsY32Y1/FLEdlAoUUSmybVET8Qt86vIq
        6gyey0/LuCPXLMImR+I2dlU2RS/r6UdWVRW2ZXS7BA==
X-Google-Smtp-Source: ABdhPJx42T8RGo3UMxZy1iziC9KDYYp4R/jXg6o1hiZBVhaG3v7OkGzGAkI31Whed2j5EqgcA6R4/eWG0GnTyZnGW9s=
X-Received: by 2002:a05:6a00:1305:: with SMTP id j5mr825437pfu.34.1643241668301;
 Wed, 26 Jan 2022 16:01:08 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU0CrD8091W5zH7ve9v3ZVAGXR6=6DGebd5LhHz4mzt4+w@mail.gmail.com>
 <CAJ+vNU1tJ5W5RCUsPehgH7CS=v=7mttHgNOu-UdWGVpzf2LcBQ@mail.gmail.com>
 <4bdbd9c0-8ce3-84b1-9f89-be89b686c652@camlingroup.com> <c66ae9ce-7345-736c-010e-1dd5602b67df@gmail.com>
In-Reply-To: <c66ae9ce-7345-736c-010e-1dd5602b67df@gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 26 Jan 2022 16:00:56 -0800
Message-ID: <CAJ+vNU2qk6G_YLAr-1_FP1czBe8wF2OUOTu914zLVNN0Lm9UFQ@mail.gmail.com>
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

On Mon, Jan 24, 2022 at 1:52 AM Richard Genoud <richard.genoud@gmail.com> w=
rote:
>
>
> Hi,
>
> Le 14/01/2022 =C3=A0 07:19, Tomasz Mo=C5=84 a =C3=A9crit :
> > On 14.01.2022 04:08, Tim Harvey wrote:
> >> So I believe in order to support using gpios for rts/cts in the imx
> >> uart driver I must find the right place to call imx_uart_rts_active
> >> and imx_uart_rts_inactive when the FIFO is not full and full
> >> respectively. I'm not that familiar with the Linux uart driver
> >> framework - am I on the right track and if so any ideas where this is
> >> best done?
> >
> > It is not really the driver (and thus FIFO level), but rather the amoun=
t
> > of free space in tty buffer (checked by Line Discipline workqueue) that
> > determines when to throttle (set RTS inactive). This mostly works fine,
> > but fails [1] when the RX interrupt frequency is too high [2].
> >
> > The throttle/unthrottle request, when termios CRTSCTS is set, is seen b=
y
> > the driver as the call to .set_mctrl (imx_uart_set_mctrl) with TIOCM_RT=
S
> > bit cleared/set in mctrl parameter. Currently imx_uart_set_mctrl() only
> > controls the UCR2_CTS and UCR2_CTSC bits based on mctrl.
> >
> > To support your case you would most likely have to add the gpio handlin=
g
> > in imx_uart_set_mctrl(). However, I am unaware what other issues you
> > might encounter (i.e. if it is not done there yet simply because nobody
> > had that use case or if there is some deeper problem).
> >
> > [1] https://lore.kernel.org/linux-serial/10e723c0-a28b-de0d-0632-0bd250=
478313@camlingroup.com/
> > [2] https://lore.kernel.org/linux-serial/20220104103203.2033673-1-tomas=
z.mon@camlingroup.com/
> >
> > Best Regards,
> > Tomasz Mon
> >
>
> I'd suggest to start testing with a serial port connected to nothing, and=
 check the pins values
> with a scope or a voltmeter.
> Setting pins values from userspace can done quite easily with :
> #include <unistd.h>
> #include <termios.h>
> #include <stdio.h>
> #include <sys/ioctl.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
>
> void usage(char *prog)
> {
>         printf("usage: %s serial_port id 0/1 sleep_time_sec\n", prog);
>         printf("%s\n", "1:DTR   DTR (data terminal ready)");
>         printf("%s\n", "2:RTS   RTS (request to send)");
>         printf("%s\n", "3:Both");
> }
>
> int main(int argc, char **argv)
> {
>         int fd;
>         unsigned status =3D 0;
>         int enable;
>         int err;
>
>         if (argc < 5) {
>                 usage(argv[0]);
>                 return -1;
>         }
>
>         fd =3D open(argv[1], O_RDWR | O_NOCTTY);
>
>         enable =3D atoi(argv[3]);
>
>         if (fd < 0)
>                 return -1;
>
>
>         switch(atoi(argv[2])) {
>         case 0:
>                 if (enable)
>                         status |=3D TIOCM_LE;
>                 break;
>         case 1:
>                 if (enable)
>                         status |=3D TIOCM_DTR;
>                 break;
>         case 2:
>                 if (enable)
>                         status |=3D TIOCM_RTS;
>                 break;
>         case 3:
>                 if (enable)
>                         status |=3D TIOCM_DTR | TIOCM_RTS;
>                 break;
>         default:
>                 printf("unknown signal\n");
>         }
>
>         err =3D ioctl(fd, TIOCMSET, &status);
>         sleep(atoi(argv[4]));
> out:
>         if (fd > -1)
>                 close(fd);
>
>         return err;
> }
>

Richard,

Thanks, I've been able to use this as well as terminal apps like
picocom and a scope to ensure that the RTS gpio is getting asserted
properly and that the CTS gpio is getting handled accordingly. Both
these signals are configured with internal pull-ups.

With for example:
        cts-gpios =3D <&gpio6 2 GPIO_ACTIVE_LOW>; // input to IMX
        rts-gpios =3D <&gpio6 3 GPIO_ACTIVE_LOW>; // output from IMX

I see that when rts is set to 1 (ie 'uart_test /dev/ttymxc3 2 1 3' or
'picocom /dev/ttymxc3 --flow h') the normally pulled-up logic high RTS
gpio goes to 0V and when rts is set to 0 it goes back to 3.3V via the
pull-up.

I've also been able to add debugging to ensure that when the CTS
signal is manually grounded that mctrl_gpio_irq_handle is called with
CTS=3D1 and imx_uart_start_tx is called to enable transmission and when
CTS signal is released from GND going back to 3.3V via the pull-up
mctrl_gpio_irq_handle is called with CTS=3D0 and imx_uart_stop_tx is
called to halt transmission.

I've also verified that changing the gpio descriptor in the dts above
to GPIO_ACTIVE_HIGH negates the above logic which is clearly wrong as
these are active-low signals.

In this specific case the device I am connecting the IMX
UART3_TX/UART3_RX and the GPIO's for RTS/CTS to is a Laird
Sterling-LWB wifi/BT chip. The datasheet [1] shows:
pin 31: BT_UART_RTS_L output UART Request-to-send
pin 32: BT_UART_CTS_L input UART Clear-to-send
pin 33: BT_UART_TXD output UART transmit
pin 34: BT_UART_RXD input UART input

They are connected to the IMX as:
BT_UART_RXD(pin34) <- IMX CSI0_DAT12_UART4_TXD
BT_UART_TXD(pin33) -> IMX CSI0_DAT13_UART4_RXD
BT_UART_CTS_L(pin32) <- IMX CSI0_DAT17_UART4_RTS_B (GPIO6_IO3)
BT_UART_RTS_L(pin31) -> IMX CSI0_DAT16_UART4_CTS_B (GPIO6_IO2)

And again if pinmuxed as RTS/CTS communication with the BT HCI is fine
but if pinmuxed as GPIO and configured as the following BT HCI
communication fails:
        cts-gpios =3D <&gpio6 2 GPIO_ACTIVE_LOW>; /* in to IMX from HCI
BT_UART_RTS_L output */
        rts-gpios =3D <&gpio6 3 GPIO_ACTIVE_LOW>; /* out from IMX to HCI
BT_UART_CTS_L input */

I'm not sure what else to look at here.

Best regards,

Tim
[1] - https://www.lairdconnect.com/documentation/datasheet-sterling-lwb
