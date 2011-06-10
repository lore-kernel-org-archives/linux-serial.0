From: Shane McDonald <mcdonald.shane@gmail.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct accessors
Date: Fri, 10 Jun 2011 12:58:20 -0600
Message-ID: <BANLkTikatUdC=9tPts9_UjzHcz1UfTktAg@mail.gmail.com>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
	<20110610035817.GA6740@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43943 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757622Ab1FJS6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Jun 2011 14:58:21 -0400
Received: by iwn34 with SMTP id 34so2390816iwn.19
        for <linux-serial@vger.kernel.org>; Fri, 10 Jun 2011 11:58:20 -0700 (PDT)
In-Reply-To: <20110610035817.GA6740@linux-mips.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org, Marc St-Jean <bluezzer@gmail.com>, Anoop P A <anoop.pa@gmail.com>

On Thu, Jun 9, 2011 at 9:58 PM, Ralf Baechle <ralf@linux-mips.org> wrot=
e:
> On Thu, Jun 09, 2011 at 11:48:45AM +0100, Jamie Iles wrote:
>
> The original read access was for a read access at offset 0xc0 from th=
e
> base address. =A0Your patch changes this to offset 0x1f * 4 =3D 0x7c.
>
> If you look at arch/mips/include/asm/pmc-sierra/msp71xx/msp_regs.h th=
ere's
>
> #define MSP_UART0_BASE =A0 =A0 =A0 =A0 =A0(MSP_SLP_BASE + 0x100)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0/* UART0 controller base =A0 =A0 =A0 =A0*/
> #define MSP_BCPY_CTRL_BASE =A0 =A0 =A0(MSP_SLP_BASE + 0x120)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0/* Block Copy controller base =A0 */
>
> So there are just 0x20 of address space reserved for that UART. =A0Me=
 thinks
> that PMC-Sierra clamped the 256 byte address space of the DesignWare =
APB
> UART to what is standard for 16550 class UARTs, 8 registers which at =
a
> shift of 4 is 0x20 bytes and the status register being accesses is re=
ally
> something else. =A0I'd guess PMC-Sierra just remapped the register to
> another address.
=2E..
> On a 2nd thought I wonder if the restricted address space of the PMC-=
Sierra
> variant and the strange remapping would justify treating it as a subv=
ariant
> of the DW APB UART, rename it to UPIO_PMC_MSP_DWAPB, hardcode the acc=
ess to
> the remapped status register. =A0And get rid of the unused UPIO_DWAPB=
32 ...
>
> I've cced a few people who should know more about this.

Marc and I were originally responsible for this code, but we're no long=
er
at PMC-Sierra, and I don't remember the details.  If Anoop isn't able
confirm Ralf's suspicions regarding the smaller address space
and remapped register, I'll see if I can track down some former co-work=
ers
that could shed some light on this.

Ralf's 2nd thought makes perfect sense to me, though.

Shane
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
