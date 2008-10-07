From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: Add Cavium OCTEON UART definitions.
Date: Tue, 7 Oct 2008 11:34:50 +0200
Message-ID: <200810071134.51012.arnd@arndb.de>
References: <48EAAF97.8050307@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:57130 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYJGJfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Oct 2008 05:35:09 -0400
In-Reply-To: <48EAAF97.8050307@caviumnetworks.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, "Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>

On Tuesday 07 October 2008, David Daney wrote:
>=20
> -=A0=A0=A0=A0=A0=A0=A0up->port.type =3D PORT_16550A;
> +#ifdef CONFIG_CPU_CAVIUM_OCTEON
> +=A0=A0=A0=A0=A0=A0=A0/* UPF_FIXED_PORT indicates an internal UART. =A0=
*/
> +=A0=A0=A0=A0=A0=A0=A0if (up->port.flags & UPF_FIXED_PORT)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0up->port.type =3D PORT_=
OCTEON;
> +=A0=A0=A0=A0=A0=A0=A0else
> +#endif
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0up->port.type =3D PORT_=
16550A;
> +

This looks somewhat wrong, IMHO a device driver should not assume that
a CONFIG_CPU_* symbol is exclusive. You could have (maybe not now, but
in the future) a kernel that supports running on an Octeon as well
as some other Mips64 processor, and have UPF_FIXED_PORT uart on some
other machine, which will make the kernel think it is a PORT_OCTEON.

	Arnd <><
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
