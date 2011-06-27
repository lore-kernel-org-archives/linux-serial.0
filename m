From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHv3 2/2] tty: of_serial: support for 32 bit accesses
Date: Mon, 27 Jun 2011 19:49:09 +0100
Message-ID: <20110627194909.7636eddc@pyx>
References: <1309177954-8786-1-git-send-email-jamie@jamieiles.com>
	<1309177954-8786-2-git-send-email-jamie@jamieiles.com>
	<BANLkTin2Bs6HxOmVHzbsxdwEViy6-DBtTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40096 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753560Ab1F0Stf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Jun 2011 14:49:35 -0400
In-Reply-To: <BANLkTin2Bs6HxOmVHzbsxdwEViy6-DBtTw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>

On Mon, 27 Jun 2011 10:57:26 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Mon, Jun 27, 2011 at 6:32 AM, Jamie Iles <jamie@jamieiles.com> wro=
te:
> > Some platforms e.g. TI Davinci require 32-bit accesses to the UARTs=
=2E
> > The of_serial driver currently registers all UARTs as UPIO_MEM. =C2=
=A0Add a
> > new attribute "io-width" to allow the port to be registered with
> > different IO width requirements.
> >
> > Acked-by: Alan Cox <alan@linux.intel.com>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
>=20
> Alan, who should pick this series up?  Should I take it via the
> devicetree/next tree?

Please
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
