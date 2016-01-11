From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH -next] tty/serial: atmel: Include module.h to fix build
 failure
Date: Mon, 11 Jan 2016 17:04:27 +0530
Message-ID: <20160111113427.GA17846@sudip-pc>
References: <1452363335-2535-1-git-send-email-linux@roeck-us.net>
 <20160109182908.GB29967@kroah.com>
 <20160111083536.GB8070@sudip-pc>
 <20160111111101.GA18945@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160111111101.GA18945@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 11, 2016 at 03:11:01AM -0800, Guenter Roeck wrote:
> On Mon, Jan 11, 2016 at 02:05:36PM +0530, Sudip Mukherjee wrote:
> > On Sat, Jan 09, 2016 at 10:29:08AM -0800, Greg Kroah-Hartman wrote:
> > > On Sat, Jan 09, 2016 at 10:15:35AM -0800, Guenter Roeck wrote:
> > > > If serial/atmel_serial.c is compiled with devicetree enabled, the
> > > > following build error is observed.
> > > > 
> > > > drivers/tty/serial/atmel_serial.c:192:1: warning:
> > > > 	data definition has no type or storage class
> > > > drivers/tty/serial/atmel_serial.c:192:1: error:
> > > > 	type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
> > > > drivers/tty/serial/atmel_serial.c:192:1: warning:
> > > > 	parameter names (without types) in function declaration
> > > > 
> > > > MODULE_DEVICE_TABLE is used to specify devicetree compatibilities.
> > > > 
> > > > Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular")
> > > > Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > ---
> > > >  drivers/tty/serial/atmel_serial.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > 
> > > This hit my tree last night already with commit
> > > 041497eb721ddbdc1e690316976dd8ba7bc136a2, so all should be fine in the
> > > next linux-next release.
> > 
> > Hi Guenter,
> > Just a thought. It has happended many times that we both have sent
> > patches to fix the same build fail. Maybe your patch got applied and
> > mine came late or maybe mine was applied and you came late. But I think
> > if we have a separate mailing list where people interested to fix and
> > monitor build failures will be members and we Cc that list whenever we
> > send patch for build fail and then in that case we will know that
> > someone else has already sent a patch for this failure and we can invest
> > the time in some other problem.
> > 
> 
> Hi Sudip,
> 
> I agree, it would make sense to have a build(/runtime?)-fixes-only mailing
> list. Question though is how to limit noise on such a list

The list can be moderated for non-subscribers. We both can be admin and
can approve the mails if it is relevant to this list. Due to our
timezones atleast one of us will be always available to approve mails.

> and, of course, > where and how to set it up. Any thoughts ?

since the list is kernel related, i think the best place should be
vger.kernel.org but I have no idea how or whom to approach to have a
list there. Maybe Greg can guide.
And if that is not possible then there are many alternatives.

regards
sudip
