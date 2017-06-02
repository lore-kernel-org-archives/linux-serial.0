From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
Date: Fri, 2 Jun 2017 20:11:24 +0300
Message-ID: <CAHp75VcH0j3ddaZ3iStNO4QcAwJKZ7BAMwUTthum2no1ucs2ww@mail.gmail.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com> <CAHp75Vemc5qoD7gbc_sJBSasYTFYSYOuWZv4N-4X60arWX8aJg@mail.gmail.com>
 <AM3PR04MB3062F7BCE82860C377C214E80F10@AM3PR04MB306.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM3PR04MB3062F7BCE82860C377C214E80F10@AM3PR04MB306.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "A.S. Dong" <aisheng.dong@nxp.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Duan <fugang.duan@nxp.com>, Stefan Agner <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Wed, May 31, 2017 at 5:18 PM, A.S. Dong <aisheng.dong@nxp.com> wrote:
>> On Tue, May 9, 2017 at 10:50 AM, Dong Aisheng <aisheng.dong@nxp.com> wro=
te:

By some reason my previous message went privately.
It didn't have anything major anyway and here I'm suggesting
optimization of finding factors of the formula in use. See below.

>> > +       u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
>> > +       u32 clk =3D sport->port.uartclk;
>> > +
>> > +       /*
>> > +        * The idea is to use the best OSR (over-sampling rate) possib=
le.
>> > +        * Note, OSR is typically hard-set to 16 in other LPUART
>> instantiations.
>> > +        * Loop to find the best OSR value possible, one that generate=
s
>> minimum
>> > +        * baud_diff iterate through the rest of the supported values =
of
>> OSR.
>> > +        *
>> > +        * Calculation Formula:
>> > +        *  Baud Rate =3D baud clock / ((OSR+1) =C3=97 SBR)
>> > +        */
>> > +       baud_diff =3D baudrate;
>> > +       osr =3D 0;
>> > +       sbr =3D 0;
>> > +
>>
>> > +       for (tmp_osr =3D 4; tmp_osr <=3D 32; tmp_osr++) {

I missed one thing, what happened by default to OSR? What is the value in u=
se?

>> I _think_ you may simplify this and avoid for-loop if you reconsider
>> approach.

> But there is indeed a optimization way, see below.

> To optimize the looping, we probably could do:
> If (!baud_diff)
>         Break;

It's a small one, we may have more interesting approach.

So, the algo is the following:

Assume the ranges like this:
OSR =3D [4 ... 32]
SBR =3D [2 ... 8192]

Then:

1. Get ratio factor as
      ratio =3D CLK / desired baud rate
2. If ratio < 8192 * 9 / 2, just use (ratio / 4, 4) as (OSR, SBR)
setting. (Needs clarification on OSR < 4)
3. if ratio >=3D 8192 * 31, just use those two numbers (8192, 31). You
can't do anything better there.
4. Otherwise, get a minimum required factor of OSR
      osr_min =3D ratio / 8192
5. Start your loop from osr_min + 1 to 31.

6 (optional). Of course you may not consider baud_diff > osr_min, it's
I suppose obvious

P.S. Note, all divisions by 2^n are just simple right shifts. Diffs
are calculated as multiplication of OSR and SBR in comparison to
ratio. One division so far.

--=20
With Best Regards,
Andy Shevchenko
