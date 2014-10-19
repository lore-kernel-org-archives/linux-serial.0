From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add entry for rp2 (Rocketport
 Express/Infinity) driver
Date: Sun, 19 Oct 2014 11:22:28 -0700
Message-ID: <CAGVrzcaOL_2RsVs2RAnMqzZFFhZ=PDoo_-QYTnBotrBCX19+8Q@mail.gmail.com>
References: <1413685818-32265-1-git-send-email-cernekee@gmail.com> <1413685818-32265-3-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37273 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbaJSSXK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 19 Oct 2014 14:23:10 -0400
Received: by mail-ig0-f172.google.com with SMTP id r2so4124698igi.17
        for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2014 11:23:10 -0700 (PDT)
In-Reply-To: <1413685818-32265-3-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby <jslaby@suse.cz>, mbizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org

2014-10-18 19:30 GMT-07:00 Kevin Cernekee <cernekee@gmail.com>:
> I wrote this driver and use it daily on several machines for work, so
> why not.

Since I also use this driver daily, let's get crazy:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 809ecd6..c08d8d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7663,6 +7663,12 @@ S:       Maintained
>  F:     Documentation/serial/rocket.txt
>  F:     drivers/tty/rocket*
>
> +ROCKETPORT EXPRESS/INFINITY DRIVER
> +M:     Kevin Cernekee <cernekee@gmail.com>
> +L:     linux-serial@vger.kernel.org
> +S:     Odd Fixes
> +F:     drivers/tty/serial/rp2.*
> +
>  ROSE NETWORK LAYER
>  M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-hams@vger.kernel.org
> --
> 2.1.1
>



-- 
Florian
