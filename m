From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Sun, 16 Dec 2018 22:28:17 +0000
Message-ID: <20181216222815.4t4xhaiy6rvfaogq@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
 <20181216213901.hpll7wqzhqvfgkfy@pburton-laptop>
 <28a1d4ae-493d-8bbc-46f7-ad41ca04d782@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <28a1d4ae-493d-8bbc-46f7-ad41ca04d782@denx.de>
Content-Language: en-US
Content-ID: <DA0C4268FD6E894792F1C2D310A6C236@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Marek,

On Sun, Dec 16, 2018 at 11:01:18PM +0100, Marek Vasut wrote:
> >>> I did suggest an alternative approach which would rename
> >>> serial8250_clear_fifos() and split it into 2 variants - one that
> >>> disables FIFOs & one that does not, then use the latter in
> >>> __do_stop_tx_rs485():
> >>>
> >>> https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-=
laptop/
> >>>
> >>> However I have no access to the OMAP3 hardware that Marek's patch was
> >>> attempting to fix & have heard nothing back with regards to him testi=
ng
> >>> that approach, so here's a simple revert that fixes the Ingenic JZ478=
0.
> >>>
> >>> I've marked for stable back to v4.10 presuming that this is how far t=
he
> >>> broken patch may be backported, given that this is where commit
> >>> 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subseque=
nt
> >>> transmits to break") that it tried to fix was introduced.
> >>
> >> OK, I tested this on AM335x / OMAP3 and the system is again broken, so
> >> that's a NAK.
> >=20
> > To be clear - what did you test? This revert or the patch linked to
> > above?
> >=20
> > This revert would of course reintroduce your RS485 issue because it jus=
t
> > undoes your change.
>=20
> The revert. Which of the two patches do you need me to test.

The one in the email I sent on Thursday 13th at 01:48:06 UTC, linked to
at lore.kernel.org in the quote right above:

https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-laptop=
/

You replied with comments on the patch, you just never tested it or
never told me if you did. The lack of response means I don't know
whether that potential patch even still works for your system, hence the
revert.

Thanks,
    Paul
