From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Suspecting kernel timing bug in ppp or tty drivers
Date: Tue, 11 Mar 2014 11:50:19 -0700
Message-ID: <20140311185019.GA32618@kroah.com>
References: <ED3E0BCACD909541BA94A34C4A164D4C5B180258@post.tritech.se>
 <20140310194007.GC3392@kroah.com>
 <ED3E0BCACD909541BA94A34C4A164D4C5B180A77@post.tritech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ppp-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ED3E0BCACD909541BA94A34C4A164D4C5B180A77@post.tritech.se>
Sender: linux-ppp-owner@vger.kernel.org
To: Mats =?iso-8859-1?Q?K=E4rrman?= <Mats.Karrman@tritech.se>
Cc: "linux-ppp@vger.kernel.org" <linux-ppp@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 11, 2014 at 09:41:56AM +0000, Mats K=E4rrman wrote:
> On Monday, March 10, 2014 8:40 PM, Greg KH wrote:
> > On Mon, Mar 10, 2014 at 01:36:36PM +0000, Mats K=E4rrman wrote:
> >> Some data about the system:
> >> - PPP daemon v2.4.5
> >> - Linux kernel v3.2.51 (same error with v2.6.35 though)
> >=20
> > That's a really old kernel version, can you try 3.13 or newer?  Lot=
s of
> > work has been done in the tty layer since 3.2 was released.
> >=20
>=20
> Thanks for your reply Greg!
>=20
> For various reasons I'd prefer to go to the long-term release 3.12.y,=
 would
> that be sufficient or do you think the changes made to 3.13 are criti=
cal?

It's a good place to start testing, and better than 3.2 :)

> (Btw. You recently set a tag for 3.12.14 but the tip of 3.12.y is 3.1=
2.13
>  according to git pull and kernel.org cgit, how come?)

I messed up and forgot to push the tree, should be fine now.

> As the MPC5125 is not main-line and I have some drivers for proprieta=
ry
> hardware the porting and re-testing will take me at least a week I gu=
ess.

Why aren't these drivers and arch code upstream?

greg k-h
