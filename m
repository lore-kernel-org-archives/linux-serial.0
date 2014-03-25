From: =?iso-8859-1?Q?Mats_K=E4rrman?= <Mats.Karrman@tritech.se>
Subject: RE: Suspecting kernel timing bug in ppp or tty drivers
Date: Tue, 25 Mar 2014 09:51:24 +0000
Message-ID: <ED3E0BCACD909541BA94A34C4A164D4C5B3A5F4A@post.tritech.se>
References: <ED3E0BCACD909541BA94A34C4A164D4C5B180258@post.tritech.se>
 <20140310194007.GC3392@kroah.com>
 <ED3E0BCACD909541BA94A34C4A164D4C5B180A77@post.tritech.se>,<20140311185019.GA32618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ppp-owner@vger.kernel.org>
In-Reply-To: <20140311185019.GA32618@kroah.com>
Content-Language: en-US
Sender: linux-ppp-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-ppp@vger.kernel.org" <linux-ppp@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tuesday, March 11, 2014 7:50 PM, Greg KH wrote:
> On Tue, Mar 11, 2014 at 09:41:56AM +0000, Mats K=E4rrman wrote:
> > On Monday, March 10, 2014 8:40 PM, Greg KH wrote:
> > > On Mon, Mar 10, 2014 at 01:36:36PM +0000, Mats K=E4rrman wrote:
> > >> Some data about the system:
> > >> - PPP daemon v2.4.5
> > >> - Linux kernel v3.2.51 (same error with v2.6.35 though)
> > >
> > > That's a really old kernel version, can you try 3.13 or newer?  L=
ots of
> > > work has been done in the tty layer since 3.2 was released.
> > >
> >
> > Thanks for your reply Greg!
> >
> > For various reasons I'd prefer to go to the long-term release 3.12.=
y, would
> > that be sufficient or do you think the changes made to 3.13 are cri=
tical?
>=20
> It's a good place to start testing, and better than 3.2 :)

After porting to 3.12.14 and testing for about a week I have been unabl=
e to
reproduce the problem. Hopefully this means the issue is solved...

BR // Mats