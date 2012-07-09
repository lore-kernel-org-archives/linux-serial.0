From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 11/11] MAINTAINERS: add fblog entry
Date: Mon, 9 Jul 2012 09:33:02 +0200
Message-ID: <CAMuHMdX_aC1hzKf1eRqoSsQ4oALBev8p77v7++aoB2KrkOUaEw@mail.gmail.com>
References: <1341784614-2797-1-git-send-email-dh.herrmann@googlemail.com>
	<1341784614-2797-12-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:35334 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab2GIHdE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Jul 2012 03:33:04 -0400
In-Reply-To: <1341784614-2797-12-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, florianschandinat@gmx.de, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, alan@lxorguk.ukuu.org.uk, bonbons@linux-vserver.org

On Sun, Jul 8, 2012 at 11:56 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Add myself as maintainer for the fblog driver to the MAINTAINERS file.
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ae8fe46..249b02a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2854,6 +2854,12 @@ F:       drivers/video/
>  F:     include/video/
>  F:     include/linux/fb.h
>
> +FRAMEBUFFER LOG DRIVER
> +M:     David Herrmann <dh.herrmann@googlemail.com>
> +L:     linux-serial@vger.kernel.org

Why linux-serial, and not linux-fbdev?

> +S:     Maintained
> +F:     drivers/video/console/fblog.c
> +
>  FREESCALE DMA DRIVER
>  M:     Li Yang <leoli@freescale.com>
>  M:     Zhang Wei <zw@zh-kernel.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
