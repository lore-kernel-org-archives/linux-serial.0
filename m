From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH -next] tty/serial: atmel: Include module.h to fix build
 failure
Date: Tue, 12 Jan 2016 21:44:10 -0800
Message-ID: <1452663850.8586.3.camel@perches.com>
References: <1452363335-2535-1-git-send-email-linux@roeck-us.net>
	 <20160109182908.GB29967@kroah.com> <20160111083536.GB8070@sudip-pc>
	 <20160111111101.GA18945@roeck-us.net> <5693C553.7050400@windriver.com>
	 <5695E207.9080309@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5695E207.9080309@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, postmaster <postmaster@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-01-12 at 21:35 -0800, Guenter Roeck wrote:
> On 01/11/2016 07:08 AM, Paul Gortmaker wrote:
> > On 2016-01-11 06:11 AM, Guenter Roeck wrote:
> > > On Mon, Jan 11, 2016 at 02:05:36PM +0530, Sudip Mukherjee wrote:
> > > > On Sat, Jan 09, 2016 at 10:29:08AM -0800, Greg Kroah-Hartman wr=
ote:
> > > > > On Sat, Jan 09, 2016 at 10:15:35AM -0800, Guenter Roeck wrote=
:
> > > > > > If serial/atmel_serial.c is compiled with devicetree enable=
d, the
> > > > > > following build error is observed.
> > > > > >=20
> > > > > > drivers/tty/serial/atmel_serial.c:192:1: warning:
> > > > > > 	data definition has no type or storage class
> > > > > > drivers/tty/serial/atmel_serial.c:192:1: error:
> > > > > > 	type defaults to 'int' in declaration of 'MODULE_DEVICE_TA=
BLE'
> > > > > > drivers/tty/serial/atmel_serial.c:192:1: warning:
> > > > > > 	parameter names (without types) in function declaration
> > > > > >=20
> > > > > > MODULE_DEVICE_TABLE is used to specify devicetree compatibi=
lities.
> > > > > >=20
> > > > > > Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel=
_serial.c explicitly non-modular")
> > > > > > Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > > > ---
> > > > > > =A0 drivers/tty/serial/atmel_serial.c | 1 +
> > > > > > =A0 1 file changed, 1 insertion(+)
> > > > >=20
> > > > > This hit my tree last night already with commit
> > > > > 041497eb721ddbdc1e690316976dd8ba7bc136a2, so all should be fi=
ne in the
> > > > > next linux-next release.
> > > >=20
> > > > Hi Guenter,
> > > > Just a thought. It has happended many times that we both have s=
ent
> > > > patches to fix the same build fail. Maybe your patch got applie=
d and
> > > > mine came late or maybe mine was applied and you came late. But=
 I think
> > > > if we have a separate mailing list where people interested to f=
ix and
> > > > monitor build failures will be members and we Cc that list when=
ever we
> > > > send patch for build fail and then in that case we will know th=
at
> > > > someone else has already sent a patch for this failure and we c=
an invest
> > > > the time in some other problem.
> > > >=20
> > >=20
> > > Hi Sudip,
> > >=20
> > > I agree, it would make sense to have a build(/runtime?)-fixes-onl=
y mailing
> > > list. Question though is how to limit noise on such a list and, o=
f course,
> > > where and how to set it up. Any thoughts ?
> >=20
> > Since most (all?) of these kind of fails are on linux-next, why not
>=20
> Most or many, but not all.
>=20
> > do what everyone else does, and report the fail there and/or ensure
> > the fix is cc'd there?=A0=A0=A0Before I waste time trying to fix st=
h on
> > linux-next, I always google for the error msg and many times that
> > leads me to a lkml or linux-next post where it was reported and
> > fixed already.
>=20
> Many times, Sudip and I end up fixing problems literally in parallel,
> and it happened quite often lately that we do send patches in paralle=
l.
> Even if I do a Google search for an error message, it happens quite
> often that I get no results, yet the fix is already out there on
> some list.
>=20
> Sudip, one option would be to set up a semi-private mailing list.
> My build tests now have a dedicated virtual host (kerneltests.org).
> I could set up a managed list there.

Perhaps it'd be better to have something like linux-build-failures@vger=
=2Ekernel.org
