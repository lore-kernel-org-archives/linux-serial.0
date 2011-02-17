From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5] tty: serial: Updates for altera_jtaguart driver
Date: Thu, 17 Feb 2011 14:15:04 -0800
Message-ID: <20110217221504.GA10686@kroah.com>
References: <cover.1297974227.git.tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33806 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755961Ab1BQWQn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Feb 2011 17:16:43 -0500
Content-Disposition: inline
In-Reply-To: <cover.1297974227.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw

On Thu, Feb 17, 2011 at 09:28:23PM +0100, Tobias Klauser wrote:
> This patchset adds updates taken from the Nios2 Linux port (currently
> out-of-tree) repository to the altera_jtaguart driver.
>=20
> And this time with the correct cover letter right away :-)
>=20
> Tobias Klauser (5):
>   tty: serial: altera_jtaguart: Don't use plain integer as NULL point=
er
>   tty: serial: altera_jtaguart: Remove unused function
>     early_altera_jtaguart_setup
>   tty: serial: altera_jtaguart: Support getting mapbase and IRQ from
>     resources
>   tty: serial: altera_jtaguart: Fixup type usage of port flags
>   tty: serial: altera_jtaguart: Add device tree support

After this series, I get the following build error:
	  CC [M]  drivers/tty/serial/altera_jtaguart.o
	  drivers/tty/serial/altera_jtaguart.c:485:3: error: unknown field =E2=
=80=98of_match_table=E2=80=99 specified in initializer

So I can't take them, sorry.

Care to fix this and resend them after testing them?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
