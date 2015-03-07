From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 -next 03/13] console: Add extensible console matching
Date: Sat, 07 Mar 2015 08:00:25 -0500
Message-ID: <54FAF669.6060303@hurleysoftware.com>
References: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com> <1425225958-17908-4-git-send-email-peter@hurleysoftware.com> <20150307025754.GA23812@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150307025754.GA23812@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 03/06/2015 09:57 PM, Greg Kroah-Hartman wrote:
> On Sun, Mar 01, 2015 at 11:05:48AM -0500, Peter Hurley wrote:
>> Add match() method to struct console which allows the console to
>> perform console command line matching instead of (or in addition to)
>> default console matching (ie., by fixed name and index).
>>
>> The match() method returns 0 to indicate a successful match; normal
>> console matching occurs if no match() method is defined or the
>> match() method returns non-zero. The match() method is expected to set
>> the console index if required.
>>
>> Re-implement earlycon-to-console-handoff with direct matching of
>> "console=uart|uart8250,..." to the 8250 ttyS console.
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>  drivers/tty/serial/8250/8250_core.c  | 64 +++++++++++++++++++++++++++---------
>>  drivers/tty/serial/8250/8250_early.c | 23 -------------
>>  include/linux/console.h              |  3 +-
>>  include/linux/serial_8250.h          |  2 --
>>  kernel/printk/printk.c               | 52 ++++++++++-------------------
>>  5 files changed, 67 insertions(+), 77 deletions(-)
> 
> This didn't apply, so I've stopped here.

Hi Greg,

Your tty-testing branch doesn't have "console: Fix console name size mismatch"
that you added to tty-linus. I tried to draw attention to that in the series
cover letter:

On 03/01/2015 11:05 AM, Peter Hurley wrote:
> Changes from v1:
> * rebased on and requires "console: Fix console name size mismatch"

Regards,
Peter Hurley
