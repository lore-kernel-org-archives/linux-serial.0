From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Mon, 16 Sep 2019 04:57:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de> <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1619585291-1568635034=:7214"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvmzhjcr2d4.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1619585291-1568635034=:7214
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 10 Sep 2019, Andreas Schwab wrote:

> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
>=20
> > On Tue, Sep 10, 2019 at 08:57:37AM +0200, Andreas Schwab wrote:
> >> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
> >>=20
> >> > The sifive serial driver implements earlycon support,
> >>=20
> >> It should probably be documented in admin-guide/kernel-parameters.txt.
> >
> > How so?  W=D1=96th OF and a stdout path you just set earlycon on the
> > command line without any arguments and it will be found.
>=20
> Doesn't work for me.
>=20
> [    0.000000] Malformed early option 'earlycon'

Try:

    earlycon=3Dsifive,0x10010000

If it works, you should see this message on the kernel console very early=
=20
in the boot:

[    0.000000] earlycon: sifive0 at MMIO 0x0000000010010000 (options '')


- Paul
--8323329-1619585291-1568635034=:7214--
