From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/6] vt: push the tty_lock down into the map handling
Date: Thu, 8 Mar 2012 11:14:36 -0800
Message-ID: <20120308191436.GA30341@kroah.com>
References: <20120302145628.32320.53944.stgit@bob.linux.org.uk>
 <20120302150012.32320.70608.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36520 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957Ab2CHTOk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 14:14:40 -0500
Received: by iagz16 with SMTP id z16so1081373iag.19
        for <linux-serial@vger.kernel.org>; Thu, 08 Mar 2012 11:14:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120302150012.32320.70608.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Mar 02, 2012 at 03:00:14PM +0000, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
>=20
> When we do this it becomes clear the lock we should be holding is the=
 vc
> lock, and in fact many of our other helpers are properly invoked this=
 way.
>=20
> We don't at this point guarantee not to race the keyboard code but th=
e results
> of that appear harmless and that was true before we started as well.
>=20
> We now have no users of tty_lock in the console driver...
>=20
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>=20
>  drivers/tty/vt/consolemap.c |  119 ++++++++++++++++++++++++++++++++-=
----------
>  drivers/tty/vt/vt_ioctl.c   |   25 ++-------
>  include/linux/vt_kern.h     |    1=20
>  3 files changed, 93 insertions(+), 52 deletions(-)
>=20

With this patch applied, I get the following build error:

drivers/tty/vt/consolemap.c: In function =E2=80=98con_set_trans_old=E2=80=
=99:
drivers/tty/vt/consolemap.c:315:2: error: implicit declaration of funct=
ion =E2=80=98console_lock=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
drivers/tty/vt/consolemap.c:323:2: error: implicit declaration of funct=
ion =E2=80=98console_unlock=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]

what went wrong?

I've applied the first 5 in this series to my tree now, but not this
one.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
