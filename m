From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again"
Date: Mon, 17 Dec 2018 13:30:53 -0300
Message-ID: <CAAEAJfDHvGTPN9u4zwWRFvK1WmpLmz87CjsjzmyhcExTGHQPmA@mail.gmail.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com> <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop> <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
 <20181216222411.5jkexuaqxpfudj7b@pburton-laptop> <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
 <20181216223510.hxsdotf332ousinh@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181216223510.hxsdotf332ousinh@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: Marek Vasut <marex@denx.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-serial@vger.kernel.org

On Sun, 16 Dec 2018 at 19:35, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Ezequiel,
>
> On Sun, Dec 16, 2018 at 07:28:22PM -0300, Ezequiel Garcia wrote:
> > On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
> > > This helps, but it only addresses one part of one of the 4 reasons I
> > > listed as motivation for my revert. For example serial8250_do_shutdow=
n()
> > > also clearly intends to disable the FIFOs.
> > >
> >
> > OK. So, let's fix that :-)
>
> I already did, or at least tried to, on Thursday [1].
>
> > By all means, it would be really nice to push forward and fix the garba=
ge
> > issue on JZ4780, as well as the transmission issue on AM335x.
> >
> > AM335x is a wildly popular platform, and it's not funny to break it.
>
> Well, clearly not if it was broken in v4.10 & only just fixed..? And
> from Marek's commit message the patch in v4.10 doesn't break the whole
> system just RS485.
>

Careful here. It's naive to consider v4.10 as old in this context.

AM335x is used in hundreds of thousands of products, probably
"industrial" products.
Manufacturers don't always follow the kernel, and it's entirely
likely that they notice a regression only when developing a new product,
or when rebasing on top of a newer longterm kernel.

Then again, I don't have any details about what is Marek's original fix
actually fixing.

Marek: could you please post the test case that you used to validate your f=
ix?
I can't find that anywhere.

> > So, let's please stop discussing which board we'll break and just fix b=
oth.
>
> I completely agree that would be ideal and I wrote a patch hoping to do
> that on Thursday, but didn't get any response on testing. It's late in
> the cycle hence a revert made sense. Simple as that.
>
> Thanks,
>     Paul
>
> [1] https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-=
laptop/

Well, I think this patch a lot of sense. But since Greg wants to
revert Marek's fix,
it would make sense to collate both Marek's and Paul's in a single commit.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
