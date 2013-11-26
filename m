From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
Date: Tue, 26 Nov 2013 15:03:03 -0800
Message-ID: <CAAYSxhqU9GZdaoTjoCAeyQ4h-KPVzU0BH0D1eLYJoFZ+s8tPgQ@mail.gmail.com>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
	<20131126183559.GA18570@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:50336 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab3KZXDF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Nov 2013 18:03:05 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so6590718obb.32
        for <linux-serial@vger.kernel.org>; Tue, 26 Nov 2013 15:03:04 -0800 (PST)
In-Reply-To: <20131126183559.GA18570@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Patch Tracking <patches@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Tue, Nov 26, 2013 at 10:36 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:

> Since v3.13-rc1, this commit seems to have introduced some oddities o=
n
> some of our boards. See this log snippet:
>
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDR=EF=BF=BDconsole [ttyS0] enabled
> console [ttyS0] enabled
> bootconsole [earlycon0] disabled
> bootconsole [earlycon0] disabled
> dw-apb-uart d0012100.serial: Couldn't set LCR to 191
> dw-apb-uart d0012100.serial: Couldn't set LCR to 191
> dw-apb-uart d0012100.serial: Couldn't set LCR to 224
> dw-apb-uart d0012100.serial: Couldn't set LCR to 224
> d0012100.serial: ttyS1 at MMIO 0xd0012100 (irq =3D 18, base_baud =3D =
15625000) is a 16550A
>
> This behavior appear in at least Armada 370 and Armada XP boxes.
>
> I confirm reverting this commit fixes the issue and things get back t=
o normal.
> Here's the complete kernel log: sprunge.us/gMdL
>
> Ideas?

Hi Ezequiel,

An external device may be keeping the UART busy and preventing LCR
from being written.

What device is attached to ttyS1?  Also, do you know the version of
the Synopsys IP?

If built with ADDITIONAL_FEATURES=3DYES, the version can be read from
the hardware:

# busybox devmem 0xd00121f8 32

-Tim
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
