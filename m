From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 2/2] parport/serial: add support for Timedia/SUNIX cards
 to parport_serial
Date: Wed, 1 Jun 2011 13:41:07 +0100
Message-ID: <20110601134107.74e4dbf7@bob.linux.org.uk>
References: <1306696084-17977-1-git-send-email-fbriere@fbriere.net>
	<1306696084-17977-2-git-send-email-fbriere@fbriere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2522 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab1FAMx7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Jun 2011 08:53:59 -0400
In-Reply-To: <1306696084-17977-2-git-send-email-fbriere@fbriere.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-14?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, linux-parport@lists.infradead.org

On Sun, 29 May 2011 15:08:04 -0400
=46r=E9d=E9ric Bri=E8re <fbriere@fbriere.net> wrote:

> Timedia/SUNIX PCI cards with both serial and parallel ports are
> currently supported by 8250_pci and parport_pc individually.  Moving
> that support into parport_serial allows using both types of ports at
> the same time.
>=20
> This was successfully tested with a SUNIX 4079T.
>=20
> Signed-off-by: Fr=E9d=E9ric Bri=E8re <fbriere@fbriere.net>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-parport@lists.infradead.org

Acked-by: Alan Cox <alan@linux.intel.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
