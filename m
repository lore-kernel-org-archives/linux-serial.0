From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Suspecting kernel timing bug in ppp or tty drivers
Date: Mon, 10 Mar 2014 12:40:07 -0700
Message-ID: <20140310194007.GC3392@kroah.com>
References: <ED3E0BCACD909541BA94A34C4A164D4C5B180258@post.tritech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ppp-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ED3E0BCACD909541BA94A34C4A164D4C5B180258@post.tritech.se>
Sender: linux-ppp-owner@vger.kernel.org
To: Mats =?iso-8859-1?Q?K=E4rrman?= <Mats.Karrman@tritech.se>
Cc: "linux-ppp@vger.kernel.org" <linux-ppp@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 10, 2014 at 01:36:36PM +0000, Mats K=E4rrman wrote:
> Hi Linux serial & PPP experts,
>=20
> For a long time now I have been chasing a problem in my PPP connectio=
n.
> The fault scenario is as follows:
>=20
> - After reboot establishing a PPP connection works OK
> - Network communication over PPP works OK
> - The PPP connection is restarted - could be for any of several reaso=
ns; peer
>   drops the connection gracefully, local restart due to network probl=
ems,
>   local restart due to user request, et.c.
> - After closing down the connection, it is not possible to re-connect=
 again.
>   The Error messages from pppd looks something like:
>=20
> Jan  1 01:04:42 mymachine local2.err chat[631]: Can't get terminal pa=
rameters: Input/output error
> Jan  1 01:04:42 mymachine daemon.debug pppd[629]: Script /usr/sbin/ch=
at -v -f /etc/ppp/chats/gprs-conn -T my-apn (pid 630), status =3D 0x2
> Jan  1 01:04:42 mymachine daemon.err pppd[629]: Connect script failed
>=20
>=20
> Some data about the system:
> - PPP daemon v2.4.5
> - Linux kernel v3.2.51 (same error with v2.6.35 though)

That's a really old kernel version, can you try 3.13 or newer?  Lots of
work has been done in the tty layer since 3.2 was released.

thanks,

greg k-h
