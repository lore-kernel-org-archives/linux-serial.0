From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC RESEND] serial: 8250: fix regression in 8250 uart driver
Date: Wed, 17 Aug 2016 14:21:52 +0300
Message-ID: <20160817112152.GR9927@kuha.fi.intel.com>
References: <575F7325.3030907@kernel.org>
 <1465897220.30123.26.camel@linux.intel.com>
 <cca9fb6eca58d8a29e3070e3f34fa40f.squirrel@emailmg.ipower.com>
 <1465920046.30123.83.camel@linux.intel.com>
 <dbaa0abe-06ab-57ee-4ba3-4e4717af4a62@leemhuis.info>
 <1471432466.4887.134.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471432466.4887.134.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, dinh.linux@anniebear.net, Dinh Nguyen <dinguyen@kernel.org>, peter@hurleysoftware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 17, 2016 at 02:14:26PM +0300, Andy Shevchenko wrote:
> On Sat, 2016-07-02 at 13:53 +0200, Thorsten Leemhuis wrote:
> > On 14.06.2016 18:00, Andy Shevchenko wrote:
> > > 
> > > On Tue, 2016-06-14 at 10:27 -0500, dinh.linux@anniebear.net wrote:
> > > > 
> > > > > 
> > > > > On Mon, 2016-06-13 at 21:59 -0500, Dinh Nguyen wrote:
> > > > Does this mean that the 8250_dw.c driver can no longer use DMA?
> > > 
> > > It means that previously the use of DMA engine whatever was used is
> > > not
> > > correct in your case. There is no issues in UART driver, the issue
> > > is in
> > > DMA controller driver.
> > > 
> > > I'm working on a quirk that will allow user to enforce PIO mode for
> > > Rx/Tx or both. In that case if DMA controller can't be fixed you
> > > still
> > > might use DMA for Tx.
> > 
> > What's the status of this issue? Just wondering, as this issue is
> > listed
> > in my regression reports for 4.7 and it seems nothing much happened
> > for
> > more than a week now – which is a bad sign as the 4.7 release seems
> > only
> > a week or two away.
> 
> I sent a v2 of the series for internal review, same you may found on
> [1]. If Heikki is okay to that I'll send it here.
> 
> [1] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fqrk

Go for it.

Thanks,

-- 
heikki
