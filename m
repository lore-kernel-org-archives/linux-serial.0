From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Sun, 16 Dec 2018 22:35:12 +0000
Message-ID: <20181216223510.hxsdotf332ousinh@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
 <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
 <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
Content-Language: en-US
Content-ID: <CE4E5AEA69002C469A7FED8C8B44C52B@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Marek Vasut <marex@denx.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-serial@vger.kernel.org

Hi Ezequiel,

On Sun, Dec 16, 2018 at 07:28:22PM -0300, Ezequiel Garcia wrote:
> On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
> > This helps, but it only addresses one part of one of the 4 reasons I
> > listed as motivation for my revert. For example serial8250_do_shutdown(=
)
> > also clearly intends to disable the FIFOs.
> >
>=20
> OK. So, let's fix that :-)

I already did, or at least tried to, on Thursday [1].

> By all means, it would be really nice to push forward and fix the garbage
> issue on JZ4780, as well as the transmission issue on AM335x.
>
> AM335x is a wildly popular platform, and it's not funny to break it.

Well, clearly not if it was broken in v4.10 & only just fixed..? And
from Marek's commit message the patch in v4.10 doesn't break the whole
system just RS485.

> So, let's please stop discussing which board we'll break and just fix bot=
h.

I completely agree that would be ideal and I wrote a patch hoping to do
that on Thursday, but didn't get any response on testing. It's late in
the cycle hence a revert made sense. Simple as that.

Thanks,
    Paul

[1] https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-la=
ptop/
