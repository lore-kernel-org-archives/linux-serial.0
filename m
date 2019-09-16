From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Mon, 16 Sep 2019 05:18:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1909160513100.9917@viisi.sifive.com>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de> <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de> <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com> <mvm7e68fo2g.fsf@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1252070807-1568636337=:9917"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvm7e68fo2g.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1252070807-1568636337=:9917
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 16 Sep 2019, Andreas Schwab wrote:

> On Sep 16 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:
>=20
> > On Tue, 10 Sep 2019, Andreas Schwab wrote:
> >
> >> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
> >>=20
> >> > On Tue, Sep 10, 2019 at 08:57:37AM +0200, Andreas Schwab wrote:
> >> >> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
> >> >>=20
> >> >> > The sifive serial driver implements earlycon support,
> >> >>=20
> >> >> It should probably be documented in admin-guide/kernel-parameters.t=
xt.
> >> >
> >> > How so?  W=D1=96th OF and a stdout path you just set earlycon on the
> >> > command line without any arguments and it will be found.
> >>=20
> >> Doesn't work for me.
> >>=20
> >> [    0.000000] Malformed early option 'earlycon'
> >
> > Try:
> >
> >     earlycon=3Dsifive,0x10010000
>=20
> That's not what Christoph wants.

I support Christoph's plan to add generic implicit earlycon support.

In the meantime, once v5.4-rc1 is released, I'll send a patch to add a=20
sifive driver section to the earlycon documentation in=20
admin-guide/kernel-parameters.txt.  Thanks for the (earlier) suggestion.


- Paul
--8323329-1252070807-1568636337=:9917--
