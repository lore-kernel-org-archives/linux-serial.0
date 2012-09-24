From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH v8 0/11] KGDB/KDB FIQ (NMI) debugger
Date: Mon, 24 Sep 2012 05:46:09 -0500
Message-ID: <506039F1.2040108@windriver.com>
References: <20120919234003.GA24143@lizard> <505B1CC7.9000005@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <505B1CC7.9000005@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/20/2012 08:40 AM, Jason Wessel wrote:
> On 09/19/2012 06:40 PM, Anton Vorontsov wrote:
>> Hi all,
>>
>> In v8, addressed Jason's comments:
>>
>> - Changed kgdb_enable_nmi() weak function to kgdb_arch callbck;
>> - We no longer register disable_nmi command if arch does not register
>>   KGDB NMI handling (i.e. not filling kgdb_arch.enable_nmi callback);
>> - The same is for ttyNMI: if architecure does not provide us with
>>   enable_nmi call, we don't need the tty device. Of course, there is no
>>   way to tell wether a specific serial device can be used for NMI
>>   debugging, as it is not serial-device specific, but specific to
>>   whether IRQ can be rerouted to an NMI (for most our cases, pretty
>>   much every IRQ can be rerouted, e.g. a hot-pluggable serial device on
>>   a PCI bus).
>> - Rebased on the latest and greatest tty-next, just in case.
>
> I have the kgdb regression builder running right now (it will be done in about 1 hour), and so far it picked up one new warning.
>
> drivers/tty/serial/kgdb_nmi.c: In function 'kgdb_nmi_poll_one_knock':
> drivers/tty/serial/kgdb_nmi.c:161: warning: field width should have type 'int', but argument 4 has type 'size_t'
>

Hi Anton,

You can add my ack to the series, for what you have in: "git://git.infradead.org/users/cbou/linux-nmi-kdb.git master", and then drop a pull request to Greg for the next merge window.  Thank you for your hard work through all the revisions of this code and this slick new feature.

Acked-by: Jason Wessel <jason.wessel@windriver.com>

Cheers,
Jason.
