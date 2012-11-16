From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: [PATCH v2 00/10] serial: sh-sci fixes - console PM, SCIFB, SMP lockup,
 etc.
Date: Fri, 16 Nov 2012 10:49:15 +0900
Message-ID: <50A59B9B.2010501@renesas.com>
References: <509A0658.1010503@renesas.com> <509A0B4E.1030801@renesas.com>
 <20121116010107.GA6068@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <20121116010107.GA6068@kroah.com>
Sender: linux-sh-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: lethal@linux-sh.org, magnus.damm@gmail.com, rjw@sisk.pl, alan@linux.intel.com, takashi.yoshii.zj@renesas.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On 11/16/2012 10:01 AM, Greg KH wrote:> On Wed, Nov 07, 2012 at 04:18:38PM +0900, Shinya Kuribayashi wrote:
>> On 11/7/2012 3:57 PM, Shinya Kuribayashi wrote:
>>> Hi Paul and serial forks,
>> [...]
>>> Takashi YOSHII (4):
>>>       serial: sh-sci: fix condition test to set SCBRR
>>>       serial: sh-sci: support lower baud rate
>>>       serial: sh-sci: mask SCTFDR/RFDR according to fifosize
>>>       serial: sh-sci: fix common SCIFB regmap definition
>>>
>>> Teppei Kamijou (1):
>>>       serial: sh-sci: console runtime PM support (revisit)
>>>
>>>  drivers/tty/serial/sh-sci.c | 140 ++++++++++++++++++--------------------------
>>>  1 file changed, 56 insertions(+), 84 deletions(-)
>>
>> Oops, I forgot to append proper From: author lines in five commits
>> (patch 04/10 to 09/10).  Didn't mean to supersede your authoship.
>>
>> I'd respin the patchset later, waiting for some feedback.
> 
> Can you please resend this with this fixed up if you want to get this
> into 3.8?

Thanks for your kind reminder.  Here's v2, providing From: authorship
lines in five patches (04 to 08).  No logical change in the patches.

--- 8< ---

V2: provide missing authorship From: lines in five patches (04 to 08)

Here are sh-sci serial driver fixes that have been cooking for months
privately on my end:
* rework console PM with the help of serial-core's uart_change_pm()
* provide missing piece in SCIFB support (from Yoshii-san)
* address console write function vs. SMP lockup issue

and so on.  Comments and suggestions are welcome.

Build tested with vanilla v3.6, but not boot- nor PM-tested with
newer kernels after v3.4.  Anyone with can-sleep shmobile systems,
please give it try.

Thanks in advance,

----------------------------------------------------------------
Shinya Kuribayashi (5):
      Revert "sh-sci / PM: Avoid deadlocking runtime PM"
      Revert "sh-sci / PM: Use power.irq_safe"
      Partially revert "serial: sh-sci: console Runtime PM support"
      serial: sh-sci: add locking to console write function to avoid SMP lockup
      serial: sh-sci: fix possible race cases on SCSCR register accesses

Takashi YOSHII (4):
      serial: sh-sci: fix condition test to set SCBRR
      serial: sh-sci: support lower baud rate
      serial: sh-sci: mask SCTFDR/RFDR according to fifosize
      serial: sh-sci: fix common SCIFB regmap definition

Teppei Kamijou (1):
      serial: sh-sci: console runtime PM support (revisit)

 drivers/tty/serial/sh-sci.c | 140 ++++++++++++++++++--------------------------
 1 file changed, 56 insertions(+), 84 deletions(-)

-- 
Shinya Kuribayashi
Renesas Electronics
