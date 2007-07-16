From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: build #306 failed for 2.6.22-g8d9107e in undefined reference
	to `netif_carrier_on'
Date: Mon, 16 Jul 2007 14:35:23 -0500
Message-ID: <1184614523.10967.1.camel@x2.microgate.com>
References: <200707152350.49174.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:56692
	"EHLO gw.microgate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762628AbXGPVlF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 Jul 2007 17:41:05 -0400
In-Reply-To: <200707152350.49174.toralf.foerster@gmx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-serial@vger.kernel.org

On Sun, 2007-07-15 at 23:50 +0200, Toralf F=C3=B6rster wrote:
> Hello,
>=20
> the build with the attached .config failed, make ends with:
> ...
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `isr_io_pin':
> synclinkmp.c:(.text+0x43d27): undefined reference to `netif_carrier_o=
n'
> synclinkmp.c:(.text+0x43d2e): undefined reference to `netif_carrier_o=
ff'
> drivers/built-in.o: In function `rx_get_frame':
> synclinkmp.c:(.text+0x44167): undefined reference to `__alloc_skb'
> synclinkmp.c:(.text+0x441ff): undefined reference to `skb_over_panic'
> synclinkmp.c:(.text+0x44265): undefined reference to `netif_rx'

I built with your .config and did not get these errors.
The build completed successfully.

--
Paul Fulghum
Microgate Systems, Ltd

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
