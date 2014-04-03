From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH] USB: usb_wwan: fix handling of missing bulk endpoints
Date: Thu, 3 Apr 2014 16:21:42 +0200
Message-ID: <20140403142142.GA5038@localhost>
References: <20140403101729.GG22587@localhost>
 <1396523206-19973-1-git-send-email-jhovold@gmail.com>
 <CACna6rxGKz9=qGGanC9T6KTAnMPCYuTLJxxY+KG6NzdZKYmrzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACna6rxGKz9=qGGanC9T6KTAnMPCYuTLJxxY+KG6NzdZKYmrzQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Johan Hovold <jhovold@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-serial@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 03, 2014 at 01:32:19PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote=
:
> 2014-04-03 13:06 GMT+02:00 Johan Hovold <jhovold@gmail.com>:
> > Fix regression introduced by commit 8e493ca1767d ("USB: usb_wwan: f=
ix
> > bulk-urb allocation") by making sure to require both bulk-in and ou=
t
> > endpoints during port probe.
>=20
> Ohh, that was quick! :)
=20
:)

> This patch works for me:
> [33050.103575] option 1-1.2:1.0: GSM modem (1-port) converter detecte=
d
> [33050.103617] [usb_wwan_port_probe] bulk_in_size:0 bulk_out_size:0
> [33050.103653] option 1-1.2:1.1: GSM modem (1-port) converter detecte=
d
> [33050.103676] [usb_wwan_port_probe] bulk_in_size:0 bulk_out_size:0
> [33050.103712] option 1-1.2:1.3: GSM modem (1-port) converter detecte=
d
> [33050.103737] [usb_wwan_port_probe] bulk_in_size:512 bulk_out_size:5=
12
> [33050.103799] usb 1-1.2: GSM modem (1-port) converter now attached t=
o ttyUSB2
> (out of curiosity I added one pr_info to print sizes).
>=20
> Thank you!

Thanks for testing. (You can respond to the patch-submission mail with =
a
Tested-by tag to get some credit for that too.)

As you might have noticed the third interface still shows up as ttyUSB2
as the first two minors will still be allocated for the unusable
interfaces.

Perhaps I should add a usb_wwan_probe (that would have to be called fro=
m
every driver relying on usb_wwan) to determine whether the required
endpoints are present before binding to the interface.

But I think the current fix is the right one for stable to fix the
regression.

Johan
