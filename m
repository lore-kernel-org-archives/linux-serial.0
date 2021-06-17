Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB107C49EA2
	for <linux-serial@archiver.kernel.org>; Thu, 17 Jun 2021 16:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8356613A9
	for <linux-serial@archiver.kernel.org>; Thu, 17 Jun 2021 16:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhFQQPZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Jun 2021 12:15:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:50757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233973AbhFQQOO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Jun 2021 12:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623946322;
        bh=r5/I5B0Vnz3iUBZp4kZkh1KGd6Kh5ZWsWBR7WGQnF6M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h5/3nYFOxSkkTQMkRSUXYU0hfcG2IiHA4EKaFhR9azvbowUbM5Wo3YzJR6NLOwfTX
         AkJsLFxhCswWItzVNyAs2X9+bEzqkdyHZvQW785vMBXiC5LAY+Jmzf8eUZXhPpkW8/
         SQ+tjb0HvDwc3rN8+bvGeQLwj3NG98VbefBTZNZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([149.172.234.120]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1lz7Hb0lM5-005r9E; Thu, 17
 Jun 2021 18:12:02 +0200
Subject: Re: [PATCH] serial: amba-pl011: add RS485 support
To:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux@armlinux.org.uk, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210610135004.7585-1-LinoSanfilippo@gmx.de>
 <5f00ff43-9287-4027-7d80-474da957703c@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <98c29d64-3155-4769-8336-413325de4057@gmx.de>
Date:   Thu, 17 Jun 2021 18:12:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f00ff43-9287-4027-7d80-474da957703c@kernel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gYhl3DhnjcjxDBSEAFDK5aGNxAE9MP3TLPWMYDvAHDgBL5mboSo
 WpX5Ly3u8KPF50wS39FXghDeeJiAA/fvP8WU3Gt0v52AyNBzlTl6IyiS2ac2I/feFy/L+LM
 CZrdCfAOTcQY2zVqp/LBsVmZAIWjk13H0+B8eWr6fDH+XCSUV4ItkFB8wYRuP5RWHKWpJvF
 ZC1fJOEU5E6xziauaIPPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zn0+x4+swtI=:FwzqTc09oj3dT7aNSf89Ch
 4FzohALxxr/95tc6Xg7INuuGnwnqFHK2+X53wnqc5RxKVdMrHa+d7j3aiBavF20BuSV8FtoTy
 qe0xM88zYl7lj42jjS1acrcP0QJlNfYQLmsnFqw4uN9Z+xRngGdMm/ij1sJK44T7b3iYpRYla
 ybazP6vrRZZn2v81IJ/dYajloTbgDY4o7D0bzOZOv2P+816lM6l1i5dP7BQc861HoVfp4t995
 xK1REj2VbznxB3N77sN5HmTf1sMXs7Od7/2wpE+zHe6UFt5AO3R8/DVt5gWwB/gVr2zBjjSGz
 Qqypr1mENSmQBNGBOg4n6YLnrvxFp41al/MTWl7fCYlUpgJjTQqfoXfj895R928zSLRDKU/Pn
 B3NqDLODD9EBAyCgwReswW+9sA93TfQ55zfzCfLA9FPIIHS2X0RLyZwG9GmhojwF8CnN0YFk6
 xvtr3GhC065YjMJEc7AZROcbtMW1gIlLJMRDIvvYQwuVWeKBdaqm+P1p13Mqa+43DPRgmdEy/
 Eq8Kg9GwmFbuewIBvSsFKH+TqUKtLvEurEco8RoYDDG89h6M4Dp4rJlLGEJJLNaco/9IuIwMy
 LF2MCGUa+kRdgzGcInEJFpj2qeDJl9An3z4lWfgK1htRE4tK6kz7UyKh86j4d9fG/gfiGhWKC
 N92SaMpnssXfWiLNOmyNM+l7iJtvFmcmhfLfzqQY5puACIqLKGoeBjfa4L7+3Y+3sbmsLBUGU
 MUfHnWIXVf8AAqSCNVjPXZ0Tc7hyWA+rPtlIiJKSg7HgUq3oGx41FcxbpLZCoDLSOerQxC/LN
 n/ekrxkbObcMpAXdJFgnIr9CQf4/BOgzzLrcaoqv1FUmL+cuLXVf8ofG1MJnJNYtjvGU24wBe
 A6by5oZZsuiqebn7iRQIL6KnFIBd33cJOHUclV5+E9T1h9r4sx3yugj3Q6zA3L7BLSDgIdN+/
 QOqOLzhcZE9ZuwFheKc8cYbdTYDbzeufM0wcARbkNJTVJCslpz/EBuTbXnHR9sthN2NW+2ZTA
 PAVfgrsVYoeC2o2ue7xzmMOUWvdurwvoXjRf4axFn9dv6CmQphllFyVVQ6RDkS7Yd+Dv4Bp3e
 xEzYdrK6b9jln6acztGq7rRNBgZJgxFybeUQI3hKfxk0tPhRrYzytcLgQ==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Hi,

On 16.06.21 at 08:18, Jiri Slaby wrote:

>> +=A0=A0=A0 if (port->rs485.delay_rts_before_send)
>> +=A0=A0=A0=A0=A0=A0=A0 mdelay(port->rs485.delay_rts_before_send);
>
> This is up to 1 second delay with interrupts disabled. Definitely not ni=
ce. 8250 clamps this to 100 ms at least, why did you choose 1000 ms?
>

I got this value from rs485.yaml where the max number for both rts delay b=
efore and after send
is specified as 1000ms. I thought to keep it up to the user to choose a sa=
ne setting. But yes,
its a very long time with interrupts disabled. I will send an updated vers=
ion of this patch that
limits both values to 100ms.


os(struct uart_port *port, struct ktermios *termios,
>> =A0=A0=A0=A0=A0 unsigned int lcr_h, old_cr;
>> =A0=A0=A0=A0=A0 unsigned long flags;
>> =A0=A0=A0=A0=A0 unsigned int baud, quot, clkdiv;
>> +=A0=A0=A0 unsigned int bits;
>> =A0 =A0=A0=A0=A0=A0 if (uap->vendor->oversampling)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 clkdiv =3D 8;
>> @@ -1968,25 +2049,32 @@ pl011_set_termios(struct uart_port *port, struc=
t ktermios *termios,
>> =A0=A0=A0=A0=A0 switch (termios->c_cflag & CSIZE) {
>> =A0=A0=A0=A0=A0 case CS5:
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 lcr_h =3D UART01x_LCRH_WLEN_5;
>> +=A0=A0=A0=A0=A0=A0=A0 bits =3D 7;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> =A0=A0=A0=A0=A0 case CS6:
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 lcr_h =3D UART01x_LCRH_WLEN_6;
>> +=A0=A0=A0=A0=A0=A0=A0 bits =3D 8;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> =A0=A0=A0=A0=A0 case CS7:
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 lcr_h =3D UART01x_LCRH_WLEN_7;
>> +=A0=A0=A0=A0=A0=A0=A0 bits =3D 9;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> =A0=A0=A0=A0=A0 default: // CS8
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 lcr_h =3D UART01x_LCRH_WLEN_8;
>> +=A0=A0=A0=A0=A0=A0=A0 bits =3D 10;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> =A0=A0=A0=A0=A0 }
>> -=A0=A0=A0 if (termios->c_cflag & CSTOPB)
>> +=A0=A0=A0 if (termios->c_cflag & CSTOPB) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 lcr_h |=3D UART01x_LCRH_STP2;
>> +=A0=A0=A0=A0=A0=A0=A0 bits++;
>> +=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 if (termios->c_cflag & PARENB) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 lcr_h |=3D UART01x_LCRH_PEN;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!(termios->c_cflag & PARODD))
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 lcr_h |=3D UART01x_LCRH_EPS;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (termios->c_cflag & CMSPAR)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 lcr_h |=3D UART011_LCRH_SPS;
>> +=A0=A0=A0=A0=A0=A0=A0 bits++;
>> =A0=A0=A0=A0=A0 }
>
> You can do simply:
> =A0 bits =3D tty_get_frame_size(termios->c_cflag);
> now:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=
=3Dtty-testing&id=3D3ec2ff37230e1c961d4b0d0118dd23c46b5bcdbb

Ah thats a nice function, thanks for pointing at it. I will adjust the cod=
e accordingly.


>
> thanks,

Thanks for the review!

Regards,
Lino


