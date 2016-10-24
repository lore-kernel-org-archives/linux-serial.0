From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [serial: 8250_lpss] a13e19cf3d: BUG: kernel hang in boot stage
Date: Mon, 24 Oct 2016 12:18:09 +0300
Message-ID: <1477300689.6423.44.camel@linux.intel.com>
References: <57ca88ec.8Uwmgj9cHsfC4q6Q%fengguang.wu@intel.com>
         <1473088503.11323.8.camel@linux.intel.com>
         <1477154414.6423.34.camel@linux.intel.com>
         <20161024021353.ij63ldkfl7cigcwr@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161024021353.ij63ldkfl7cigcwr@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, LKP <lkp@01.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 2016-10-24 at 10:13 +0800, Fengguang Wu wrote:
> Hi Andy,
> 
> On Sat, Oct 22, 2016 at 07:40:14PM +0300, Andy Shevchenko wrote:
> > On Mon, 2016-09-05 at 18:15 +0300, Andy Shevchenko wrote:
> > > +Heikki
> > > 
> > > On Sat, 2016-09-03 at 16:25 +0800, kernel test robot wrote:
> > > > Greetings,
> > > > 
> > > > 0day kernel testing robot got the below dmesg and the first bad
> > > > commit
> > > > is
> > > 
> > > Briefly tested I have hang issues *with* or *without* the
> > > mentioned
> > > commit if under hang you meant no getty available on serial
> > > console.
> > > Otherwise I see output from kernel till 
> > > 
> > > [   61.625900] raid6test: complete (2429 tests, 0 failures)
> > > [   61.671165] BIOS EDD facility v0.16 2004-Jun-25, 0 devices
> > > found
> > > [   61.678004] EDD information not available.
> > > [   61.714036] ALSA device list:
> > > [   61.717459]   #0: Dummy 1
> > > [   61.720480]   #1: MTPAV on parallel port at 0x378
> > > 
> > > Attached defconfigs per commit I have tested (also diff between
> > > mine
> > > and
> > > yours when I did make savedefconfig).
> > > 
> > > So, may I ask what exact hardware you are using to test this one?
> > 
> > May I ask beloved LKP team what the status of the issue is? Shall we
> > close it or there is more information coming?
> 
> Please close the issue.
> 
> I tried rebuild the kernel and redo the tests, and find the new kernel
> no longer has early boot hang. Sorry for the noise!

Thank you for confirming!

It's really good that we have 0-day LKP testing established.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
