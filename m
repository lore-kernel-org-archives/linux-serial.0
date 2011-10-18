From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Tue, 18 Oct 2011 11:13:19 -0700
Message-ID: <20111018181319.GA7015@kroah.com>
References: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
 <CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60820 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751083Ab1JRSWL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Oct 2011 14:22:11 -0400
Content-Disposition: inline
In-Reply-To: <CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, Linus Walleij <linus.walleij@linaro.org>, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org

On Tue, Oct 18, 2011 at 11:39:11AM +0800, Barry Song wrote:
> 2011/10/14 Barry Song <Barry.Song@csr.com>:
> > From: Rong Wang <Rong.Wang@csr.com>
> >
> > SiRFprimaII is the latest generation application processor from CSR=
=E2=80=99s
> > multi-function SoC product family.
> > The SoC support codes are in arch/arm/mach-prima2 from Linux mainli=
ne
> > 3.0.
> >
> > There are three dedicated UARTs in system. This patch adds basic dr=
iver
> > support for them.
> >
> > It has used the newest pinmux subsystem from Linus Walleij.
>=20
> Hi Alan, it means this patch doesn't compile until pinmux tree of
> Linus Walleij is merged into mainline.
> Now it is a linux next tree.

So should it go through the pinmux tree?  Or do you want to wait for th=
e
3.3 kernel release to get this merged?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
