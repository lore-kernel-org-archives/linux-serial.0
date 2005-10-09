From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [patch 3/4] new serial flow control
Date: Sun, 9 Oct 2005 15:29:52 +0200
Message-ID: <20051009132952.GH5104@bouh.residence.ens-lyon.fr>
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr> <20051009000153.GA23083@flint.arm.linux.org.uk> <20051009002129.GJ5150@bouh.residence.ens-lyon.fr> <20051009083724.GA14335@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailfe02.tele2.fr ([212.247.154.44]:26044 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750709AbVJINab (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Oct 2005 09:30:31 -0400
Content-Disposition: inline
In-Reply-To: <20051009083724.GA14335@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Russell King, le Sun 09 Oct 2005 09:37:24 +0100, a =E9crit :
> the majority of the more inteligent 8250- compatible UARTs with large
> FIFOs only do hardware flow control on RTS/CTS

BTW, nobody tried to use hardware implementation of software flow
control? (UART_(XON/XOFF)[12] of TI16C752, ST16650, ST16650A, ST16654
UARTs).

Regards
Samuel
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
