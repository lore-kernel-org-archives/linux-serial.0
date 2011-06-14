From: Shane McDonald <mcdonald.shane@gmail.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct accessors
Date: Tue, 14 Jun 2011 09:33:45 -0600
Message-ID: <BANLkTi=0Pk-2YT=jLeBTNLYELfo+e-saZA@mail.gmail.com>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
	<20110610035817.GA6740@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62969 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab1FNPdq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Jun 2011 11:33:46 -0400
Received: by iyb14 with SMTP id 14so4764254iyb.19
        for <linux-serial@vger.kernel.org>; Tue, 14 Jun 2011 08:33:45 -0700 (PDT)
In-Reply-To: <20110610035817.GA6740@linux-mips.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org, Marc St-Jean <bluezzer@gmail.com>, Anoop P A <anoop.pa@gmail.com>

On Thu, Jun 9, 2011 at 9:58 PM, Ralf Baechle <ralf@linux-mips.org> wrot=
e:
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

I have confirmed with a contact at PMC-Sierra that this is the case.

Shane
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
