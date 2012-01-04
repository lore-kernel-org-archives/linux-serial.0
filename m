From: Bdale Garbee <bdale-wvU4uTqWWAI@public.gmane.org>
Subject: Re: USB disconnect -> kernel panic
Date: Tue, 03 Jan 2012 20:09:03 -0700
Message-ID: <87fwfwmaeo.fsf@gag.com>
References: <87mxahk3d1.fsf@gag.com> <20120102182255.GC8562@xanatos> <20120103235847.GF21311@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120103235847.GF21311-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Oliver Neukum <oliver-Q6YOFhsQ4GZ7tPAFqOLdPg@public.gmane.org>
Cc: keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Jan 2012 15:58:47 -0800, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Jan 02, 2012 at 10:22:55AM -0800, Sarah Sharp wrote:
> > On Sat, Dec 24, 2011 at 03:32:26PM -0700, Bdale Garbee wrote:
> > > Hi Sarah!  Merry Christmas!
> > >=20
> > > I've been working on another production run of Altus Metrum products
> > > today, and in the process of flashing and calibrating a pile of our
> > > TeleDongle units, I've been seeing sporadic kernel panics when
> > > unplugging them from my notebook USB.  Has now happened three times t=
his
> > > morning.=20
> > >=20
> > > I'm running 3.1.6 now, but I saw this under 3.1.5 too, at least once.
> > > The notebook is an HP 2540p.
> > >=20
> > > Keith suggested I send you the attached photo of my screen showing the
> > > panic info.=20
> >=20
> > It's somewhere in the tty layer, and doesn't look USB related.  I think
> > Greg KH is the tty maintainer right now, so you might want to ask him.
>=20
> We've had some cdc_acm driver problems in the past, but I thought they
> were all resolved.  3.1.3 should have fixed those problems.  We have
> some more cleanups queued up for 3.3, but nothing that should be fixing
> something like this.
>=20
> Oliver, any thoughts about this (see the original post on linux-usb for
> the crash dump.)

For what it's worth, it happened to me again today running 3.2.0-rc7.  I
didn't bother photographing the screen again, though I'm happy to do
that if it'll help.

Bdale

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTwPCzzqTYZbAldlBAQpbCQ/9FFtqskQIoBpp3q6TQsU6vAgcfw6Tybrz
VwYa4jermef5JXUBXor+sucPWBmZCglWQA5HBwiR1IrvckSCReKsJg1USoFShZIv
3GRD13CG1eYD0Z6BxgQiEO+pXuS02tHR5WDqO7XmP95Y3LOym7JTme7ueT70vVDT
0pBTBdZjx3P2Q5R2TiJQA5/cjY6uctZCl3S2Di4971pWvyUzuoK2UQsi+BqIQopL
w6s/bkwYvR1ahbhPWBxS6A3vpIKItCdIXbEaGW7F3U4/YdzA2I5xI0T27zFQlTZy
hJIUiy9HeePysHGqwKNkpuVJ5+ng4Ly/AJViLyFCmaREizkenpRlDbJscmuk6TGG
BaqEgNwTQX4I5pJVvpbHDZIjNthTAtd6/TqxLB0HyWUrSqEiW6nRGNw3O4bcN9NH
CD2Ei2YkNZgfb09qA9YPjPGtVGxEVMstBlPQ4ya4OjoRAI4vwl6jmIuT9W8K3xgC
+kcaR32UWQ3/Gd6wmEnfMgE4LiniSwbYHxPMgAX01OYwipFQImBSWX5D4c4i912K
yvlQbG4+rwULveLKi/A6SJkUp7kLjkUD/sQYkkVpjZryFLS4jm/xK3ymj6mrGJ5H
23GvZTeFpIZDZ/wQANHFRv/rqI3mZJiEInOda2nbdPT9lGaX97119+X693a/0Nlo
PES8lUQqLFc=
=KspF
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
