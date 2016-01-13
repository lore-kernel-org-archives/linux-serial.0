From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH -next] tty/serial: atmel: Include module.h to fix build
 failure
Date: Wed, 13 Jan 2016 16:02:46 +0530
Message-ID: <20160113103246.GB26117@sudip-pc>
References: <1452363335-2535-1-git-send-email-linux@roeck-us.net>
 <20160109182908.GB29967@kroah.com>
 <20160111083536.GB8070@sudip-pc>
 <20160111111101.GA18945@roeck-us.net>
 <5693C553.7050400@windriver.com>
 <5695E207.9080309@roeck-us.net>
 <1452663850.8586.3.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452663850.8586.3.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, postmaster <postmaster@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 12, 2016 at 09:44:10PM -0800, Joe Perches wrote:
> On Tue, 2016-01-12 at 21:35 -0800, Guenter Roeck wrote:
> > On 01/11/2016 07:08 AM, Paul Gortmaker wrote:
> > > On 2016-01-11 06:11 AM, Guenter Roeck wrote:
> > > > On Mon, Jan 11, 2016 at 02:05:36PM +0530, Sudip Mukherjee wrote:
> > > > > On Sat, Jan 09, 2016 at 10:29:08AM -0800, Greg Kroah-Hartman wrote:
> > > > > > On Sat, Jan 09, 2016 at 10:15:35AM -0800, Guenter Roeck wrote:
> > > > > > > If serial/atmel_serial.c is compiled with devicetree enabled, the
<snip>
> >
> > Sudip, one option would be to set up a semi-private mailing list.
> > My build tests now have a dedicated virtual host (kerneltests.org).
> > I could set up a managed list there.
> 
> Perhaps it'd be better to have something like linux-build-failures@vger.kernel.org

yes, much better. But if me and Guenter are the only two members of that
list then it will not look nice. :)

regards
sudip
