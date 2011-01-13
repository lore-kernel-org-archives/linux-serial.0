From: Greg KH <greg@kroah.com>
Subject: Re: JSM module patch
Date: Thu, 13 Jan 2011 09:43:32 -0800
Message-ID: <20110113174332.GB28247@kroah.com>
References: <op.vo8g42gfgaomyf@pepper.eatpbank.ru>
 <op.vo8nbrx3gaomyf@pepper.eatpbank.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:45980 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756825Ab1AMRqq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Jan 2011 12:46:46 -0500
Content-Disposition: inline
In-Reply-To: <op.vo8nbrx3gaomyf@pepper.eatpbank.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?utf-8?B?0J/QsNGB0LDRiNC90LjQutC+0LIg0JAu0JAu?= <pepper@eatpbank.ru>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Jan 13, 2011 at 11:32:05AM +0300, =D0=9F=D0=B0=D1=81=D0=B0=D1=88=
=D0=BD=D0=B8=D0=BA=D0=BE=D0=B2 =D0=90.=D0=90. wrote:
> Hello
>=20
> We use the OS Debian Squeeze kernel 2.6.32-5-686.
> There is a problem:
> We have an internal PCI card Digi Neo 4 with device ID 114F:00B0 (has=
 4
> COM-ports).
> Core module JSM doesn't support device described above, but support t=
he
> same device with 8 COM-port and device ID 114F:00B1.
> Can you include this patches:

I would be glad to, if you can resend them in a format that I can apply
them in.  Hint, read the file, Documentation/SubmittingPatches and redo
your patch as it describes (properly level for patch, Signed-off-by:
line, etc.)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
