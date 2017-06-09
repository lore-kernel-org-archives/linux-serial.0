From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
Date: Fri, 9 Jun 2017 12:26:20 +0300
Message-ID: <CAHp75VcSToSfbUZ2TP0OsLRjV4TNpq7D_=4tnB_+rDvS2jp22Q@mail.gmail.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com> <CAHp75Vemc5qoD7gbc_sJBSasYTFYSYOuWZv4N-4X60arWX8aJg@mail.gmail.com>
 <AM3PR04MB3062F7BCE82860C377C214E80F10@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VcH0j3ddaZ3iStNO4QcAwJKZ7BAMwUTthum2no1ucs2ww@mail.gmail.com> <AM3PR04MB306214514B820D66535E28B80CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM3PR04MB306214514B820D66535E28B80CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "A.S. Dong" <aisheng.dong@nxp.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Duan <fugang.duan@nxp.com>, Stefan Agner <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>, Dong Aisheng <dongas86@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 9, 2017 at 11:01 AM, A.S. Dong <aisheng.dong@nxp.com> wrote:

>> >> > +       u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
>> >> > +       u32 clk =3D sport->port.uartclk;
>> >> > +
>> >> > +       /*
>> >> > +        * The idea is to use the best OSR (over-sampling rate)
>> possible.
>> >> > +        * Note, OSR is typically hard-set to 16 in other LPUART
>> >> instantiations.
>> >> > +        * Loop to find the best OSR value possible, one that
>> >> > + generates
>> >> minimum
>> >> > +        * baud_diff iterate through the rest of the supported
>> >> > + values of
>> >> OSR.
>> >> > +        *
>> >> > +        * Calculation Formula:
>> >> > +        *  Baud Rate =3D baud clock / ((OSR+1) =C3=97 SBR)
>> >> > +        */
>> >> > +       baud_diff =3D baudrate;
>> >> > +       osr =3D 0;
>> >> > +       sbr =3D 0;
>> >> > +
>> >>
>> >> > +       for (tmp_osr =3D 4; tmp_osr <=3D 32; tmp_osr++) {
>>
>> I missed one thing, what happened by default to OSR? What is the value i=
n
>> use?
>>
>
> No valid default value. (osc/sbr are 0 by default)
> If no proper osc and sbr calculated, a WARNING will show.

Okay, so, it means the maximum supported speed is UART clock / 4. Correct?

>> So, the algo is the following:
>>
>> Assume the ranges like this:
>> OSR =3D [4 ... 32]
>> SBR =3D [2 ... 8192]
>>
>
> Baud Rate =3D baud clock / ((OSR+1) =C3=97 SBR)
>
> In HW:
> OSR range : 3 =E2=80=93 31
> SBR range: 1 =E2=80=93 8191

I've read that, but think outside the box.

>> Then:
>>
>> 1. Get ratio factor as
>>       ratio =3D CLK / desired baud rate
>> 2. If ratio < 8192 * 9 / 2, just use (ratio / 4, 4) as (OSR, SBR) settin=
g.
>> (Needs clarification on OSR < 4)
>
> Sorry that I'm a bit mess here.
> What is 8192 * 9 /2 meaning?

I forgot the details...

> And for (ratio / 4, 4) as (OSR,SBR), take 115200 as an example:
> Assuming baud clock 24Mhz.
>
> Ratio =3D 24000000 / 115200 =3D 208
> OSR =3D Ratio / 4 =3D 52
> Then OSR is out of range which seems wrong.

...yes...

>> 3. if ratio >=3D 8192 * 31, just use those
>> two numbers (8192, 31). You can't do anything better there.
>
> This actually may not happen.
> Even take a 9600 as example, the clk becomes:
> 8191 * 31 * 9600 =3D 2.4GHz
> Which is theoretically not exist.
>
>> 4. Otherwise, get a minimum required factor of OSR
>>       osr_min =3D ratio / 8192
>> 5. Start your loop from osr_min + 1 to 31.
>>
>> 6 (optional). Of course you may not consider baud_diff > osr_min, it's I
>> suppose obvious
>>
>> P.S. Note, all divisions by 2^n are just simple right shifts. Diffs are
>> calculated as multiplication of OSR and SBR in comparison to ratio. One
>> division so far.

> I'm not quite understand the approach.

...lemme prepare a python script demonstrating it.

> How about you send a separate baud algorithm improvement patch later?

Why not to do it right a way?

Just describe it in a comment if you afraid of reader can't understand
from the code.

--=20
With Best Regards,
Andy Shevchenko
