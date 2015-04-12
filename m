From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [serial] BUG: spinlock bad magic on CPU#0, swapper/0
Date: Sun, 12 Apr 2015 09:01:31 -0400
Message-ID: <552A6CAB.1080605@hurleysoftware.com>
References: <20150412124113.GA15431@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150412124113.GA15431@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>, Corey Minyard <cminyard@mvista.com>
Cc: LKP <lkp@01.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Fengguang,

On 04/12/2015 08:41 AM, Fengguang Wu wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> git://git.code.sf.net/p/openipmi/linux-ipmi master-ipmi-rebase
> 
> commit ccfb59efb7a78e606516ce878d8dde4690419a5f
> Author:     Corey Minyard <cminyard@mvista.com>
> AuthorDate: Mon Mar 19 16:00:55 2012 -0500
> Commit:     Corey Minyard <cminyard@mvista.com>
> CommitDate: Fri Apr 10 20:51:46 2015 -0500
> 
>     serial: Add a polled interface to the 8250 driver
>     
>     Remove the console code from the 8250 driver and add the poll code and
>     setup to use the console over the polled interface.
>     
>     FIXME - The interactions between the 8250_early and 8250 code need to
>     be analyzed and tested.
>     
>     Signed-off-by: Corey Minyard <minyard@acm.org>
>     
>      drivers/tty/serial/8250.c |  227 ++++++++++++++++++++++------------------------
>      1 file changed, 112 insertions(+), 115 deletions(-)

This is not an upstream bug.

Regards,
Peter Hurley
