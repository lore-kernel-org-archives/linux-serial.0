From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Tue, 18 Oct 2011 11:39:11 +0800
Message-ID: <CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com>
References: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57297 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab1JRDjc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Oct 2011 23:39:32 -0400
Received: by bkbzt19 with SMTP id zt19so267831bkb.19
        for <linux-serial@vger.kernel.org>; Mon, 17 Oct 2011 20:39:31 -0700 (PDT)
In-Reply-To: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, Linus Walleij <linus.walleij@linaro.org>, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org

2011/10/14 Barry Song <Barry.Song@csr.com>:
> From: Rong Wang <Rong.Wang@csr.com>
>
> SiRFprimaII is the latest generation application processor from CSR=E2=
=80=99s
> multi-function SoC product family.
> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> 3.0.
>
> There are three dedicated UARTs in system. This patch adds basic driv=
er
> support for them.
>
> It has used the newest pinmux subsystem from Linus Walleij.

Hi Alan, it means this patch doesn't compile until pinmux tree of
Linus Walleij is merged into mainline.
Now it is a linux next tree.

>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rong Wang <Rong.Wang@csr.com>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
> =C2=A0-v2:
> =C2=A0rename device name from ttyS to ttySiRF;
> =C2=A0use dynamic device major and minor;
> =C2=A0support non-Bxxx baudrate;
> =C2=A0fix other minor issues Alan Cox required.
>

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
