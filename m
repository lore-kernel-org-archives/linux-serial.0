From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] 8250_pci.c: Update NI specific devices class to multi serial
Date: Fri, 25 Jan 2019 00:47:43 +0200
Message-ID: <CAHp75Vc0OShOP_MzCuaObJQcnHcyJF1pvPnD9mNugK92rKAPqA@mail.gmail.com>
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
 <CAHp75VcxtSi64qsK6tHx+vtEeRsX3ZVwfzRYOVuyS=qSTnK0qQ@mail.gmail.com>
 <CAHp75Vd+p8d87v_YEkzMLh8sxmvPYk3XeFdkpsrY_jTsC2zHCQ@mail.gmail.com> <d24b4177fda84042b4f59f2bb77e149e@atfkex01.bachmann.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d24b4177fda84042b4f59f2bb77e149e@atfkex01.bachmann.at>
Sender: linux-kernel-owner@vger.kernel.org
To: "KHUENY.Gerhard" <Gerhard.KHUENY@bachmann.info>
Cc: Guan Yung Tseng <guan.yung.tseng@ni.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 24, 2019 at 1:15 PM KHUENY.Gerhard
<Gerhard.KHUENY@bachmann.info> wrote:
>
> Hi,
>
> I would appreciate this change since this would solve my problem also ;-)
>

I have sent couple of hours ago the patch to upstream. If I'm not
mistaken, you did test it and I put deliberatly your tag. Tell me if
it's not the case or, if you have a chance, test it.

> Best regards,
> Gerhard Kh=C3=BCny
>
> -----Urspr=C3=BCngliche Nachricht-----
> Von: linux-serial-owner@vger.kernel.org <linux-serial-owner@vger.kernel.o=
rg> Im Auftrag von Andy Shevchenko
> Gesendet: Mittwoch, 23. J=C3=A4nner 2019 17:07
> An: Guan Yung Tseng <guan.yung.tseng@ni.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; open list:SERIAL DRI=
VERS <linux-serial@vger.kernel.org>; Linux Kernel Mailing List <linux-kerne=
l@vger.kernel.org>
> Betreff: Re: [PATCH] 8250_pci.c: Update NI specific devices class to mult=
i serial
>
> On Wed, Jan 23, 2019 at 5:18 PM Andy Shevchenko <andy.shevchenko@gmail.co=
m> wrote:
> >
> > On Mon, Jan 14, 2019 at 4:13 PM Guan Yung Tseng <guan.yung.tseng@ni.com=
> wrote:
> > >
> > > Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> > > The reason of doing this is because all NI multi port serial cards
> > > use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
> > > serial_pci_is_class_communication test added in the commit
> > > 7d8905d06405
> > > ("serial: 8250_pci: Enable device after we check black list").
> >
> > Guan, can you provide an output of the
> >
> > lspci -nk -xx -vv -s <BDF>
> >
> > of your device, where <BDF> is a PCI address in a form of bus:device.fu=
nction?
>
> While I'm still wondering of the above, can you also test the bellow patc=
h if it fixes your issue?
>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



--=20
With Best Regards,
Andy Shevchenko
