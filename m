From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] tty: serial: jsm_tty: fixed redundant variable issue.
Date: Sat, 6 Feb 2016 22:14:00 -0800
Message-ID: <20160207061400.GA30939@kroah.com>
References: <1454682063-3630-1-git-send-email-jakob.jensen.91@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454682063-3630-1-git-send-email-jakob.jensen.91@gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jakob =?iso-8859-1?Q?=D8stergaard?= Jensen <jakob.jensen.91@gmail.com>
Cc: cascardo@linux.vnet.ibm.com, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 05, 2016 at 03:21:03PM +0100, Jakob =D8stergaard Jensen wro=
te:
> Fixes unnecessary variable reassignment to a new redundant variable.
>=20
> Signed-off-by: Jakob =D8stergaard Jensen <jakob.jensen.91@gmail.com>
> ---
>  drivers/tty/serial/jsm/jsm_tty.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

What changed in v2?  Please always be specific.  I'll drop this, please
resend v3 and describe what changed in the proper way.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
