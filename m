From: Bdale Garbee <bdale@gag.com>
Subject: Re: USB disconnect -> kernel panic
Date: Wed, 04 Jan 2012 22:36:48 -0700
Message-ID: <87mxa2ww0f.fsf@gag.com>
References: <87mxahk3d1.fsf@gag.com> <20120102182255.GC8562@xanatos> <20120103235847.GF21311@kroah.com> <87fwfwmaeo.fsf@gag.com> <20120104230149.GA16655@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from winfree.gag.com ([192.133.104.8]:38027 "EHLO winfree.gag.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913Ab2AEFhN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Jan 2012 00:37:13 -0500
In-Reply-To: <20120104230149.GA16655@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Oliver Neukum <oliver@neukum.name>, keithp@keithp.com, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

--=-=-=

On Wed, 4 Jan 2012 15:01:49 -0800, Greg KH <greg@kroah.com> wrote:
> Ok, can you try the patch below and let me know if it solves the problem
> or not?

It's hard to prove a negative, but after applying the patch to 3.2.0-rc7
and running with it for a while doing frequent power cycles on our
devices attached via USB, abruptly disconnecting USB during active
serial connections, etc .. I haven't seen the panic again.

Will report if it happens again with the patch in place, but so far so good.

Bdale

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTwU28DqTYZbAldlBAQqGDhAAxlwlTVTAb03iWckBvieCiCue/zZmjHRz
zeE783qg/Wx9741yEyW9pIed7Q3tPoSqD9SImXDhiblXX2wt03hyIPkG9/x90pcx
3z4I6yaxZMs8MYDFcYUK1mwFrKMmcPflF1nC0gmnq5L6nEl5KLAPf71DAFrZJEaZ
rRx8JuhTSqzuDW8io0Vpz1LHBD1PNuUxiySFI8XP1h8oM0CG0EgoVwLT3oUY6NQB
30rxA3bdnkXVtR/fqmqoC0zo3E/1PlJH252MsUbW3OajRKlBmA7SUEx2FkO/Qmgn
5FwTnMkdhXAqwTvOVjddQYssCDHqZA63bGm21FIH4DDlwcVS83efhU20/tCQHUT5
13lcNeDaIQOQf5OaEwP7EkmmhtyUVfb7zhTaA/ruNRpTQzhhU3rtFzQdEY0g8o7Z
M7ig+PvWXTAzhJP9WBppnS2HwEbxk4wWlSnsESZaEA4bqd9jv14A/8pGqKBjT/K5
i6NewWk7VcH3R6S/lvKv9HMSu3YsABQkh3OFhh42RUFwkb0lJnfZ9l/NOL6GUd1z
gSSF7EsQlIF9E/nrj/66IPxItSInEFWAZd8bKKswhVPZVQgENqklurmgI7JkzIZS
647Bl3SrcgNwgfzL+utyWEvuwj0yx/xwFFOpg34suaOvMCaWa7UptYVsQcM9jpMP
gYlw04Re5Qk=
=iDsx
-----END PGP SIGNATURE-----
--=-=-=--
