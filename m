From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Sun, 16 Dec 2018 22:16:24 +0000
Message-ID: <20181216221622.fi3q475zlhquv4ph@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
Content-Language: en-US
Content-ID: <D30D33DAA29A9B468D3A323B8ECE97C0@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 16, 2018 at 10:45:23PM +0100, Marek Vasut wrote:
> >> I am unable to test it on such a short notice as I'm currently ill, so=
 I
> >> cannot tell if your change breaks the OMAP3/AM335x boards or not. Give=
n
> >> that there are very few CI20 boards in use, I'd like to ask you for so=
me
> >> extra time to investigate this on the OMAP3 too.
> >=20
> > I'm sorry to hear that you're ill, but your patch is getting awfully
> > close to becoming part of a stable kernel release & it causes
> > regressions. Even if it didn't break a board I use, I think the patch
> > would be broken & risky for the reasons I outlined in my revert's commi=
t
> > message.
>=20
> That's what the incremental releases are for, so that minor problems can
> get fixed there. Sure, it's great to have things perfect in the first
> release, but if that breaks other systems, too bad.

I don't think the purpose of stable kernels is to intentionally break
systems in a stable release & backport fixes later...

> > Ultimately it's Greg's decision but it sounds like you're asking me to
> > say it's OK to break the JZ4780 in a stable kernel with a patch that I
> > think would be risky anyway, and I won't do that.
>=20
> I am saying this revert breaks AM335x, so this is a stalemate. I had a
> discussion with Ezequiel (on CC) and he seems to have a different
> smaller patch coming for this problem.

Well, no. Your patch says commit 2bed8a8e7072 ("Clearing FIFOs in RS485
emulation mode causes subsequent transmits to break") broke RS485 on
AM33x in v4.10, and it took 10 release cycles for someone to notice &
fix it. You're asking to break a system that is used & working in order
to fix a problem that seemingly wasn't even noticed for nearly 2 years.

Your fix breaks my system, but I outlined 4 reasons that I believe your
patch to be wrong anyway - breaking my system is just one part of that.

I'll rely to Ezequiel's patch now, but it again addresses just one part
of one of the 4 points I listed in the reasoning for my revert.

Thanks,
    Paul
