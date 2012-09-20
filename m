From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH v8 0/11] KGDB/KDB FIQ (NMI) debugger
Date: Thu, 20 Sep 2012 08:40:23 -0500
Message-ID: <505B1CC7.9000005@windriver.com>
References: <20120919234003.GA24143@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120919234003.GA24143@lizard>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Brian Swetland <swetland@google.com>, linaro-kernel@lists.linaro.org, Russell King <linux@arm.linux.org.uk>, patches@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, John Stultz <john.stultz@linaro.org>, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, kgdb-bugreport@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, kernel-team@android.com, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 09/19/2012 06:40 PM, Anton Vorontsov wrote:
> Hi all,
>
> In v8, addressed Jason's comments:
>
> - Changed kgdb_enable_nmi() weak function to kgdb_arch callbck;
> - We no longer register disable_nmi command if arch does not register
>   KGDB NMI handling (i.e. not filling kgdb_arch.enable_nmi callback);
> - The same is for ttyNMI: if architecure does not provide us with
>   enable_nmi call, we don't need the tty device. Of course, there is no
>   way to tell wether a specific serial device can be used for NMI
>   debugging, as it is not serial-device specific, but specific to
>   whether IRQ can be rerouted to an NMI (for most our cases, pretty
>   much every IRQ can be rerouted, e.g. a hot-pluggable serial device on
>   a PCI bus).
> - Rebased on the latest and greatest tty-next, just in case.


I have the kgdb regression builder running right now (it will be done in about 1 hour), and so far it picked up one new warning.

drivers/tty/serial/kgdb_nmi.c: In function 'kgdb_nmi_poll_one_knock':
drivers/tty/serial/kgdb_nmi.c:161: warning: field width should have type 'int', but argument 4 has type 'size_t'

Jason.
