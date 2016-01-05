From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] drivers/tty/serial: delete unused MODULE_DEVICE_TABLE
 from atmel_serial.c
Date: Tue, 5 Jan 2016 12:33:17 +0530
Message-ID: <20160105070317.GA32311@sudip-pc>
References: <1450364746-815-1-git-send-email-paul.gortmaker@windriver.com>
 <20160102074740.GA11430@sudip-pc>
 <20160104204324.GP12458@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160104204324.GP12458@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudip Mukherjee <sudip@vectorindia.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 04, 2016 at 03:43:25PM -0500, Paul Gortmaker wrote:
> [Re: [PATCH] drivers/tty/serial: delete unused MODULE_DEVICE_TABLE from atmel_serial.c] On 02/01/2016 (Sat 13:17) Sudip Mukherjee wrote:
> 
> > On Thu, Dec 17, 2015 at 10:05:46AM -0500, Paul Gortmaker wrote:
> > > In commit c39dfebc7798956fd2140ae6321786ff35da30c3 ("drivers/tty/serial:
> > > make serial/atmel_serial.c explicitly non-modular") we removed the code
> > > relating to modular support since it currently only supports built in.
> > > 
> > > However, when redoing my build coverage for mips allmodconfig, which
> > > sets CONFIG_OF, I noticed a remaining line that needs to be removed,
> > > else we will get a build failure for an undefined module macro.
> > > 
> > > Unfortunately this didn't appear for any of the other arch I tested
> > > more frequently, such as ARM.
> > > 
> > > Since MODULE_DEVICE_TABLE is a no-op for non-modular code, we can just
> > > remove the offending line.
> > > 
> > > Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular")
> > > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > Cc: Jiri Slaby <jslaby@suse.com>
> > > Cc: linux-serial@vger.kernel.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Sudip Mukherjee <sudip@vectorindia.org>
> > > Reported-by: Sudip Mukherjee <sudip@vectorindia.org>
> > > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > ---
> > 
> > I think this has not yet landed in linux-next. next-20151231 still
> > fails.
> 
> Greg has a lot of irons in the fire, and it is also the season where a
> lot of people have unplugged for the last two weeks to be with family,
> friends, etc, so lets be patient.

Ohhh .. sorry , i didn't notice it will go through Greg.

regards
sudip
