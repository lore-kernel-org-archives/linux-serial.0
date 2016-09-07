From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC RESEND] serial: 8250: fix regression in 8250 uart driver
Date: Wed, 07 Sep 2016 20:16:04 +0300
Message-ID: <1473268564.11323.91.camel@linux.intel.com>
References: <575F7325.3030907@kernel.org>
         <1465897220.30123.26.camel@linux.intel.com>
         <cca9fb6eca58d8a29e3070e3f34fa40f.squirrel@emailmg.ipower.com>
         <1465920046.30123.83.camel@linux.intel.com>
         <dbaa0abe-06ab-57ee-4ba3-4e4717af4a62@leemhuis.info>
         <1471432466.4887.134.camel@linux.intel.com>
         <abf9f9cb-c14c-7efb-8d1c-ed89a6a979a3@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <abf9f9cb-c14c-7efb-8d1c-ed89a6a979a3@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dinh Nguyen <dinguyen@kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-08-23 at 08:53 -0500, Dinh Nguyen wrote:
> Hi Andy,
> 
> On 08/17/2016 06:14 AM, Andy Shevchenko wrote:
> > 
> > 
> > I sent a v2 of the series for internal review, same you may found on
> > [1]. If Heikki is okay to that I'll send it here.
> > 
> > [1] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fqrk
> > 
> 
> I tested this branch on SoCFPGA hardware and encountered this
> error[1].
> Doing a bisect led me to this commit[2].

Forgot to add you to Cc list, there is new version there.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
