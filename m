From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] USB: usb_wwan: fix handling of missing bulk endpoints
Date: Thu, 3 Apr 2014 17:20:28 +0200
Message-ID: <CACna6rx1qFRn2VXFZAGadksm8FwcaHMqd4NCjp0G6Fe4RojFEQ@mail.gmail.com>
References: <20140403101729.GG22587@localhost>
	<1396523206-19973-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:34127 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbaDCPU3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Apr 2014 11:20:29 -0400
In-Reply-To: <1396523206-19973-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-serial@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>, stable <stable@vger.kernel.org>

2014-04-03 13:06 GMT+02:00 Johan Hovold <jhovold@gmail.com>:
> Fix regression introduced by commit 8e493ca1767d ("USB: usb_wwan: fix
> bulk-urb allocation") by making sure to require both bulk-in and out
> endpoints during port probe.

Tested-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
