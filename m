From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct
 accessors
Date: Wed, 15 Jun 2011 09:49:59 +0100
Message-ID: <20110615084959.GG3075@pulham.picochip.com>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
 <20110610035817.GA6740@linux-mips.org>
 <BANLkTi=0Pk-2YT=jLeBTNLYELfo+e-saZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42363 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab1FOIuN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jun 2011 04:50:13 -0400
Received: by wya21 with SMTP id 21so130716wya.19
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2011 01:50:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=0Pk-2YT=jLeBTNLYELfo+e-saZA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shane McDonald <mcdonald.shane@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org, Marc St-Jean <bluezzer@gmail.com>, Anoop P A <anoop.pa@gmail.com>

On Tue, Jun 14, 2011 at 09:33:45AM -0600, Shane McDonald wrote:
> On Thu, Jun 9, 2011 at 9:58 PM, Ralf Baechle <ralf@linux-mips.org> wr=
ote:
> > If you look at arch/mips/include/asm/pmc-sierra/msp71xx/msp_regs.h =
there's
> >
> > #define MSP_UART0_BASE =A0 =A0 =A0 =A0 =A0(MSP_SLP_BASE + 0x100)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0/* UART0 controller base =A0 =A0 =A0 =A0*/
> > #define MSP_BCPY_CTRL_BASE =A0 =A0 =A0(MSP_SLP_BASE + 0x120)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0/* Block Copy controller base =A0 */
> >
> > So there are just 0x20 of address space reserved for that UART. =A0=
Me thinks
> > that PMC-Sierra clamped the 256 byte address space of the DesignWar=
e APB
> > UART to what is standard for 16550 class UARTs, 8 registers which a=
t a
> > shift of 4 is 0x20 bytes and the status register being accesses is =
really
> > something else. =A0I'd guess PMC-Sierra just remapped the register =
to
> > another address.
>=20
> I have confirmed with a contact at PMC-Sierra that this is the case.

Thanks for confirming that Shane.  I'm currently working on a series to=
=20
move the DesignWare handling code into the pmc-sierra platform and kill=
=20
off UPIO_DWAPB{,32} and will post it in a couple of days.

Jamie
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
