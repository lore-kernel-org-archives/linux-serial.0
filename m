From: christian pellegrin <chripell@fsfe.org>
Subject: Re: [PATCH v1 3/4] max3100: adds console support for MAX3100
Date: Tue, 30 Mar 2010 08:49:57 +0200
Message-ID: <cabda6421003292349m2dd6125cp2bcc1060f5aa8741@mail.gmail.com>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	 <1269340170-6558-1-git-send-email-chripell@fsfe.org>
	 <20100329104838.49c18075@feng-i7>
	 <cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
	 <20100329150642.4a94e78a@feng-i7>
	 <cabda6421003290555k70d13168y4beba2c3ae6e2ece@mail.gmail.com>
	 <20100330101445.5c64dedb@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56706 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab0C3Gt6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Mar 2010 02:49:58 -0400
Received: by gyg13 with SMTP id 13so1989662gyg.19
        for <linux-serial@vger.kernel.org>; Mon, 29 Mar 2010 23:49:58 -0700 (PDT)
In-Reply-To: <20100330101445.5c64dedb@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "greg@kroah.com" <greg@kroah.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Mar 30, 2010 at 4:14 AM, Feng Tang <feng.tang@intel.com> wrote:
> On Mon, 29 Mar 2010 20:55:51 +0800

> DW controller driver don't need max3110 driver to use big spi transfe=
r,
> the early version of our max3110 is also one word per spi transfer mo=
de,
> and the 2 drivers work fine, though the rx performance is not good (c=
opy
> & paste a bulk message to console).

What I'm saying is that the reason of bad performance is that the
underlying SPI driver has bad performance. A SPI master driver should
do as little work as possible. For small transfers (2 bytes =3D=3D 16
bits) at 5MHz (=3D=3D 3.2 us) it's much better to spin in spi_transfer
waiting for SPI done than scheduling anything or setting up a DMA
transfer. Especially if you do *2* task schedule (spi_transfer queues
a workqueue that schedules a tasklet) be prepared for *big* latency. I
hope other people can comment on this if I'm saying something wrong.

>
> When the HW works at 230400 bps, when we copy bulk data to the consol=
e,
> max3110 will probably receive about 20K characters, so the time for
> handling each char is 50us. If you use one char per spi transfer, it
> will have to execute 20K spi_transfer in one second, and each need be
> done in 50us, in this 50us you'll have to deal with controller IRQ
> handler + spi system overhead + tty receiving overhead. Is it a littl=
e
> over-killing to use one char per spi transfer? while the HW does
> have a 8 words RX FIFO

this is too hackish, max3100 wasn't conceived this way. Let me point
some problems of such an approach:

1) latency on rx chars becomes very high because we can process
incoming transfers only after a full 8 byte (or whatever the spi
transfer dimension is). For a 9600 this is too much.

2) even worse is that we can do flow control decision only on such boun=
dary.

3) this is not reliable: think of what happens if the actual SPI
transfer speed we get will be slower that the one we requested. We
won't be emptying the RX buffer fastly enough even if could.

4) for low speeds we are going to monopolize the SPI bus for ages.

So I'm rather convinced that the SPI transfer has to happen as soon as
possible at a SPI device driver level without any guess on how the
data will be clocked out. I suggest you to improve the dw_spi driver
for better performance.

> [[ =A0 =A0..000000 =A0iiuu =A0eessoo =A0....44rr11((eeggffnn--77 =A0g=
gccvvrriinn444411((bbnnuu44441144bbnnuu))))
> [[ =A0 =A0..000000 =A0BBOO--8800 =A00000000000001100--000000000000880=
0 =A0uuaall))

huh, here I'm seeing another kind of problem: the same char is
repeated two times (for example BBOO is written instead of BIOS). I'm
quite sure (but I will triple check shortly) the the console driver
doesn't do this (it's quite an easy loop in max3100_console_work, I
will check wit a printascii to another serial port what is sent). So I
guess the problem can be in the SPI master driver: is it correctly
handling the CS changes? Isn't it having problems with DMA for example
(I always found DMA for small data transfer (such 2 bytes in this
case) problematic (for example many platforms just do it on a 4 byte
boundary))? Have you tested it with other devices?

--=20
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
