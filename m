From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/4 V2] pch_uart: Cleanups, board quirks, and user
 uartclk parameter
Date: Thu, 1 Mar 2012 10:40:28 +0800
Message-ID: <20120301024028.GA6612@feng-i7>
References: <cover.1330539597.git.dvhart@linux.intel.com>
 <CANKRQnhFVJAUHAg0qTPFJ8L0L_+-_q4ZtfOnV0wSR1Xa6Mn8UQ@mail.gmail.com>
 <4F4EC73E.40209@linux.intel.com>
 <CANKRQnjQ4WB-ExmM5G5diw1LyA_HwySzkNyhKmf4fDLn0ZO7wg@mail.gmail.com>
 <4F4ECCE8.90207@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27604 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758233Ab2CACmt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Feb 2012 21:42:49 -0500
Content-Disposition: inline
In-Reply-To: <4F4ECCE8.90207@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>, Alan Cox <alan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Wed, Feb 29, 2012 at 05:12:08PM -0800, Darren Hart wrote:
>=20
>=20
> On 02/29/2012 05:06 PM, Tomoya MORINAGA wrote:
> > 2012=E5=B9=B43=E6=9C=881=E6=97=A59:47 Darren Hart <dvhart@linux.int=
el.com>:
> >> how do we force the
> >> 192MHz clock setting BEFORE the pch_phub code runs?
> >=20
> > To realize your requirement,
> > I think that set by BIOS is only way.
>=20
> Perhaps a pch_phub.bios_uartclk parameter could be used for setting u=
p
> the initial console and once the phub driver is loaded, it can make t=
he
> necessary changes and fix things up in the uart port? This would add =
a
> binding between the pch_uart and pch_phub code.
>=20
> Thoughts?

To satisfy the early console, one way may be add a x86_init_ops for all
Tunnel Creek compatible platform like what Moorestown/Medfield have don=
e,
and insert the uart clk setting work into one of the early init functio=
n.=20

Thanks,
=46eng
>=20
> --=20
> Darren Hart
> Intel Open Source Technology Center
> Yocto Project - Linux Kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
