From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Fri, 28 Oct 2011 09:11:29 +0200
Message-ID: <20111028071129.GA2362@tarshish>
References: <1319772453-1275-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tango.tkos.co.il ([62.219.50.35]:36712 "EHLO tango.tkos.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163Ab1J1HMN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Oct 2011 03:12:13 -0400
Content-Disposition: inline
In-Reply-To: <1319772453-1275-1-git-send-email-Barry.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: torvalds@linux-foundation.org, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, linux-serial@vger.kernel.org, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

Hi Barry,

On Thu, Oct 27, 2011 at 08:27:33PM -0700, Barry Song wrote:
> From: Rong Wang <Rong.Wang@csr.com>
>=20
> SiRFprimaII is the latest generation application processor from CSR=E2=
=80=99s
> multi-function SoC product family.
> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> 3.0.
>=20
> There are three dedicated UARTs in system. This patch adds basic driv=
er
> support for them.
>=20
> It has used the newest pinmux subsystem from Linus Walleij.
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rong Wang <Rong.Wang@csr.com>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Acked-by: Alan Cox <alan@linux.intel.com>
> ---

[snip]

> +config SERIAL_SIRFSOC
> +        tristate "SiRF SoC Platform Serial port support"
> +        depends on ARM && ARCH_PRIMA2
> +        select SERIAL_CORE
> +        help
> +          Support for the on-chip UART on the CSR SiRFprimaII series=
,
> +          providing /dev/ttyS0, 1 and 2 (note, some machines may not
> +          provide all of these ports, depending on how the serial po=
rt
> +          pins are configured.

Unbalanced parentheses.

baruch

--=20
                                                     ~. .~   Tk Open Sy=
stems
=3D}------------------------------------------------ooO--U--Ooo--------=
----{=3D
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
