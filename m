Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE8EC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 16:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F28660200
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 16:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhGWP4x (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:56:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:42059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhGWP4u (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 11:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627058232;
        bh=CVnvzIMltbSZVZh9Um+aC87wv4W4qAOZHLkJjIMzqMo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jTtAg8JihfvUAZO5P2E8+4aHGLEM35Olb94ACn3dOon5te6VEmvDk4C4MHnyaDUq/
         hEcFy8m6XQG6sEcoHdsZ8GjDo4MhJDwRU9sWEFrPlmCqcmbbN1nX9h1y1Zb3r6LFHK
         y/VqG4JY/d0535iQVeqyD/sb+f1+cqGHNA9tS0AQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.130.19]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1lZaX645Ih-00XpHX; Fri, 23
 Jul 2021 18:37:12 +0200
Subject: Re: [PATCH 3/8] tty: don't store semi-state into tty drivers
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Felipe Balbi <balbi@kernel.org>
References: <20210723074317.32690-1-jslaby@suse.cz>
 <20210723074317.32690-4-jslaby@suse.cz>
From:   Helge Deller <deller@gmx.de>
Message-ID: <584aafd9-843c-6f26-ae0c-3cddaff3000c@gmx.de>
Date:   Fri, 23 Jul 2021 18:37:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723074317.32690-4-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SN7OHPumkOylbXvEtsZN83FNVE3cet8/qDwosCbhqHh+40/bLko
 XP87HhyiV2fUqF3KJSe3fc/bttFmlesi9RUXj8qcvClRvO6T1KeqgNNYKDdP2BRAo96DZEE
 SVASCnc/RDlKXHYHvbVezGOjjG/nkziLDIyRy4HAA2YXDSuE0+YOvWJhcHUz1GLb5TqsFAc
 lZUNmOoSUPaE/WvdFv3pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5zYZ07VVkr0=:2nssXwobJm42IscIFRNvWp
 ANm68LTonMEXAoW2aUd7WMkqN5iQ7mTUHE2ZoeloCVNj5JUXr//p+1dNCjZqLAPeZ9yKYCTtc
 kI2ljyjxgAN0Ur7vlFpGzqSwTE59rMRk260EcJgULA8+UaxKeWY7J7JPB9qfhSnSo/Bdntv4U
 Hof4MpUUfL9z2hJ/SwMFb0nEoxAI2k/T+3JDJz0Fu+hGubCYCSwdbZy3sLJJ3wwcko2H62deG
 QKOV+ziitnIskNzHPaRodFwiBPhfd5+BVUwUvq8a9ZJ4oHpEPOfi+Cd4gz9cnlQZ16NeOEZP7
 w6hoiTnXK7S40ukygNOXfqR5oTof1UMGiLUo/lRWMLCKXn05gAO33yBwWgvWDrajAHtso812H
 x97LpjdGE7FUudIAQOSnEWpGKfxZ1TXqq/19TJO8jKddtsMQ7MKB5vd3qQU+fLzNCt87yvyxo
 K3C2TNKa1CspAdDOZ53XdyjVYD+5vMdFCwX7xhbe51e6EmvhGz9hrsSb2pDBXci/FV3nXluHg
 PdgCsKi17OJSRm9PH3AjSYVVuUSAUuqmm3Tha1CdL8AnVt7hR10kaFiwDEXc6DmdQlL87qzaX
 G3H09TiDO2MrREF7D8NriLOwEWSAumoZ867rZgYGDhARVh4Rp/aZHiX33j3WhMWOuZ2n+Pyw9
 mC60Ilx/vkXogCcy3rf599oV1EeddXJUzQHj0Bh05AbJBffk2b1tnwswAME7hw/PrXq1ufcKk
 NcBgIpU1YLXuqQ0pJOukxV+aelAlpd+0E6o0rrdamW07ZrFAT7X4B/50kBAS1nNdwIVKoOASw
 V9MwADYYaKDmc6TOZAFvJsVM5BeP/YRONmXn9jRjXTtoOr5EbCauq4K6iwY84XuJ6ktnQC0Me
 lPuMDJ+rhvpKs+rS06C34dQWBlLfbXdaxkCRpWdviGjC73HDouWYJW5maO3YxA5efGi2d/ahP
 VQCKDIhi5zmtZpVwKVasNB7h92RFAzWJYpFjZrgXy3r37ltdnqgEZT0t+6gYscoZfqmy7ELdg
 IcSB5EhNGbz/n7SmMiLiTozFyhj8HWQ7vDTHEZ0epUARBt0bH+zIt1YoM6p1mIcbYu8Df2HFy
 k9ekVaxfDRm3glR8KtA++O/pKT00fFRe9La
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 7/23/21 9:43 AM, Jiri Slaby wrote:
> When a tty driver pointer is used as a return value of struct
> console's device() hook, don't store a semi-state into global variable
> which holds the tty driver. It could mean console::device() would return
> a bogus value. This is important esp. after the next patch where we
> switch from alloc_tty_driver to tty_alloc_driver. tty_alloc_driver
> returns ERR_PTR in case of error and that might have unexpected results
> as the code doesn't expect this.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> ---
>   arch/m68k/emu/nfcon.c                  | 27 +++++++++++---------
>   arch/parisc/kernel/pdc_cons.c          | 28 +++++++++++----------
>   arch/xtensa/platforms/iss/console.c    | 33 +++++++++++++-----------
>   drivers/tty/amiserial.c                | 35 ++++++++++++++------------
>   drivers/tty/ehv_bytechan.c             | 28 ++++++++++++---------
>   drivers/tty/hvc/hvsi.c                 | 35 ++++++++++++++------------
>   drivers/usb/gadget/function/u_serial.c | 32 ++++++++++++-----------
>   7 files changed, 119 insertions(+), 99 deletions(-)
>
...

You may add:

Acked-by: Helge Deller <deller@gmx.de>	# parisc

to the whole series (specifically patches 3, 4 and 8) regarding the parisc=
 changes.

Thank you!
Helge

>
> diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons=
.c
> index 39ccad063533..650cb01203de 100644
> --- a/arch/parisc/kernel/pdc_cons.c
> +++ b/arch/parisc/kernel/pdc_cons.c
> @@ -138,6 +138,7 @@ static struct tty_driver *pdc_console_tty_driver;
>
>   static int __init pdc_console_tty_driver_init(void)
>   {
> +	struct tty_driver *driver;
>   	int err;
>
>   	/* Check if the console driver is still registered.
> @@ -160,31 +161,32 @@ static int __init pdc_console_tty_driver_init(void=
)
>   	printk(KERN_INFO "The PDC console driver is still registered, removin=
g CON_BOOT flag\n");
>   	pdc_cons.flags &=3D ~CON_BOOT;
>
> -	pdc_console_tty_driver =3D alloc_tty_driver(1);
> -
> -	if (!pdc_console_tty_driver)
> +	driver =3D alloc_tty_driver(1);
> +	if (!driver)
>   		return -ENOMEM;
>
>   	tty_port_init(&tty_port);
>
> -	pdc_console_tty_driver->driver_name =3D "pdc_cons";
> -	pdc_console_tty_driver->name =3D "ttyB";
> -	pdc_console_tty_driver->major =3D MUX_MAJOR;
> -	pdc_console_tty_driver->minor_start =3D 0;
> -	pdc_console_tty_driver->type =3D TTY_DRIVER_TYPE_SYSTEM;
> -	pdc_console_tty_driver->init_termios =3D tty_std_termios;
> -	pdc_console_tty_driver->flags =3D TTY_DRIVER_REAL_RAW |
> +	driver->driver_name =3D "pdc_cons";
> +	driver->name =3D "ttyB";
> +	driver->major =3D MUX_MAJOR;
> +	driver->minor_start =3D 0;
> +	driver->type =3D TTY_DRIVER_TYPE_SYSTEM;
> +	driver->init_termios =3D tty_std_termios;
> +	driver->flags =3D TTY_DRIVER_REAL_RAW |
>   		TTY_DRIVER_RESET_TERMIOS;
> -	tty_set_operations(pdc_console_tty_driver, &pdc_console_tty_ops);
> -	tty_port_link_device(&tty_port, pdc_console_tty_driver, 0);
> +	tty_set_operations(driver, &pdc_console_tty_ops);
> +	tty_port_link_device(&tty_port, driver, 0);
>
> -	err =3D tty_register_driver(pdc_console_tty_driver);
> +	err =3D tty_register_driver(driver);
>   	if (err) {
>   		printk(KERN_ERR "Unable to register the PDC console TTY driver\n");
>   		tty_port_destroy(&tty_port);
>   		return err;
>   	}
>
> +	pdc_console_tty_driver =3D driver;
> +
>   	return 0;
>   }
>   device_initcall(pdc_console_tty_driver_init);
...
