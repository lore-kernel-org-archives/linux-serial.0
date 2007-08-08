From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] serial: turn serial console suspend a boot rather than
 compile time option
Date: Wed, 8 Aug 2007 15:41:30 -0700
Message-ID: <20070808154130.9cc3a30e.akpm@linux-foundation.org>
References: <20070808183535.2a2c6edf.dilinger@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934931AbXHHWlx@vger.kernel.org>
In-Reply-To: <20070808183535.2a2c6edf.dilinger@queued.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 8 Aug 2007 18:35:35 -0400
Andres Salomon <dilinger@queued.net> wrote:

> Currently, there's a CONFIG_DISABLE_CONSOLE_SUSPEND that allows one to stop
> the serial console from being suspended when the rest of the machine goes
> to sleep.  This is incredibly useful for debugging power management-related
> things; however, having it as a compile-time option has proved to be
> incredibly inconvenient for us (OLPC).  There are plenty of times that we
> want serial console to not suspend, but for the most part we'd like serial
> console to be suspended.
> 
> This drops CONFIG_DISABLE_CONSOLE_SUSPEND, and replaces it with a kernel
> boot parameter (no_console_suspend).  By default, the serial console will
> be suspended along with the rest of the system; by passing
> 'no_console_suspend' to the kernel during boot, serial console will remain
> alive during suspend.
> 
> I have another version of this patch which keeps #ifdefs around; however,
> it's uglier.  I prefer this version of the patch, and don't feel that it
> increases bloat.  If people strongly disagree, let me know and I'll submit
> the other patch.
> 

yep, compile-time options suck.

> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -172,6 +172,8 @@ extern int __printk_ratelimit(int ratelimit_jiffies, int ratelimit_burst);
>  extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
>  				unsigned int interval_msec);
>  
> +extern int console_suspend;
> +

That's a somewhat vague-sounding identifier.  Could we call it
console_suspend_enabled or something?
