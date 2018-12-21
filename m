From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Fri, 21 Dec 2018 21:08:30 +0000
Message-ID: <20181221210818.g3kbv7bnr577dane@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
 <20181216213901.hpll7wqzhqvfgkfy@pburton-laptop>
 <28a1d4ae-493d-8bbc-46f7-ad41ca04d782@denx.de>
 <20181216222815.4t4xhaiy6rvfaogq@pburton-laptop>
 <78839e8c-0278-6060-0dd2-a84a19258a8a@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <78839e8c-0278-6060-0dd2-a84a19258a8a@denx.de>
Content-Language: en-US
Content-ID: <482416DD55D0374C9214F154210B2320@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-serial@vger.kernel.org

Hi Marek,

On Fri, Dec 21, 2018 at 09:08:28PM +0100, Marek Vasut wrote:
> On 12/16/2018 11:28 PM, Paul Burton wrote:
> > On Sun, Dec 16, 2018 at 11:01:18PM +0100, Marek Vasut wrote:
> >>>>> I did suggest an alternative approach which would rename
> >>>>> serial8250_clear_fifos() and split it into 2 variants - one that
> >>>>> disables FIFOs & one that does not, then use the latter in
> >>>>> __do_stop_tx_rs485():
> >>>>>
> >>>>> https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburto=
n-laptop/
> >>>>>
> >>>>> However I have no access to the OMAP3 hardware that Marek's patch w=
as
> >>>>> attempting to fix & have heard nothing back with regards to him tes=
ting
> >>>>> that approach, so here's a simple revert that fixes the Ingenic JZ4=
780.
> >>>>>
> >>>>> I've marked for stable back to v4.10 presuming that this is how far=
 the
> >>>>> broken patch may be backported, given that this is where commit
> >>>>> 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subseq=
uent
> >>>>> transmits to break") that it tried to fix was introduced.
> >>>>
> >>>> OK, I tested this on AM335x / OMAP3 and the system is again broken, =
so
> >>>> that's a NAK.
> >>>
> >>> To be clear - what did you test? This revert or the patch linked to
> >>> above?
> >>>
> >>> This revert would of course reintroduce your RS485 issue because it j=
ust
> >>> undoes your change.
> >>
> >> The revert. Which of the two patches do you need me to test.
> >=20
> > The one in the email I sent on Thursday 13th at 01:48:06 UTC, linked to
> > at lore.kernel.org in the quote right above:
> >=20
> > https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-la=
ptop/
> >=20
> > You replied with comments on the patch, you just never tested it or
> > never told me if you did. The lack of response means I don't know
> > whether that potential patch even still works for your system, hence th=
e
> > revert.
>=20
> I shared the entire testcase, which now fails on AM335x due to this
> revert. Is there any progress on a proper fix from your side which does
> not break the AM335x ?

No.

Let's be clear - I didn't break your AM335x system, your broken patch
says that Daniel did with a commit applied back in v4.10. As such I
don't consider it my responsibility to fix your problem at all, I don't
have any access to the hardware anyway & I won't be buying hardware to
fix a bug for you.

Despite all that I did write a patch which I expect would have solved
the problem for both of us, which is linked *twice* in the quoted emails
above & which as far as I can tell you *still* have not tested. I can
only surmise that you're trying deliberately to be annoying at this
point.

If you want to try the patch I already wrote, and confirm whether it
actually works for you, then let's talk. Otherwise we're done here.

Thanks,
    Paul
