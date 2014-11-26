From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Uart2 can't work well after the system goto standby and then
 resume at csr primaII platform
Date: Wed, 26 Nov 2014 10:43:48 -0800
Message-ID: <20141126184348.GA6958@kroah.com>
References: <CAMLw+SEMavUKc1-9mZA+-UJ=UJiBhBp=7=srNNqg-W74C=BLSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41403 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbaKZSnt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Nov 2014 13:43:49 -0500
Content-Disposition: inline
In-Reply-To: <CAMLw+SEMavUKc1-9mZA+-UJ=UJiBhBp=7=srNNqg-W74C=BLSQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guoqing Liu <lgqgood@gmail.com>
Cc: linux-serial@vger.kernel.org

On Wed, Nov 26, 2014 at 02:17:06PM +0800, Guoqing Liu wrote:
> Daer Sir,
> =E3=80=80=E3=80=80 I'm very sorry to trouble you.
>      Recently I found the uart2 at csr primaII platform can't work
> well after the system  goto standby and then resume.
>=20
> My test environment is as follows=EF=BC=9A
>      kernel:   3.10.16

That is a very old and obsolete kernel version.  If a vendor is forcing
you to stick to that version, please ask them for support as there's
nothing that we can to do help here, sorry.

Now if you can duplicate this on the 3.17 kernel release, that's a
different story...

good luck,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
