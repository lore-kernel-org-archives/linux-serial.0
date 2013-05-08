From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH 2/7] USB: serial: add generic wait_until_sent
 implementation
Date: Wed, 8 May 2013 17:48:55 +0200
Message-ID: <20130508154855.GA14438@localhost>
References: <20130505182913.GE16818@localhost>
 <1367778753-22297-1-git-send-email-jhovold@gmail.com>
 <1367778753-22297-3-git-send-email-jhovold@gmail.com>
 <518A6049.4090303@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65227 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018Ab3EHPtA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 May 2013 11:49:00 -0400
Content-Disposition: inline
In-Reply-To: <518A6049.4090303@list.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stas Sergeev <stsp@list.ru>
Cc: Johan Hovold <jhovold@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jarkko Huijts <jarkko.huijts@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Caylan Van Larson <i@caylan.net>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, May 08, 2013 at 06:25:13PM +0400, Stas Sergeev wrote:
> 05.05.2013 22:32, Johan Hovold =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Add generic wait_until_sent implementation which polls for empty
> > hardware buffers using the new port-operation tx_empty.
> >
> > The generic implementation will be used for all sub-drivers that
> > implement tx_empty but does not define wait_until_sent.
> Hi Johan.
>=20
> The customer reports an Oops below.
> Does that ring any bells?
> Well, there is only one division in usb_serial_generic_wait_until_sen=
t(),
> anyway. :)

Yes, you're right I forgot about B0. I'll send a v2.

Thanks for catching this,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
