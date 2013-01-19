From: Eric Sandeen <sandeen@redhat.com>
Subject: Re: WARNING: at drivers/tty/tty_buffer.c:476 flush_to_ldisc()
Date: Sat, 19 Jan 2013 16:51:16 -0600
Message-ID: <50FB2364.8090403@redhat.com>
References: <CA+icZUV2Fj4wtObY94s3h5=24dOhcxSuVUNv-qtRXAU5Hi-p1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CA+icZUV2Fj4wtObY94s3h5=24dOhcxSuVUNv-qtRXAU5Hi-p1w@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: Dave Jones <davej@redhat.com>, Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ilya Zykov <ilya@ilyx.ru>, LKML <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, linux-serial@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 1/19/13 4:44 PM, Sedat Dilek wrote:
> Hi Dave,
> 
> I suspected after initial testing a problem in TTY and applied two patches.
> After more testing the root cause was a problem in JBD2.
> A patch from Eric helped!

oh, excellent ;)

Helped what, exactly?

> Follow the thread in [1] for more details.
> 
> If you are on Linux-Next (next-20130118) you need the following three patches.
> 
> Ilya Zykov (2):
>       tty: Correct tty buffer flush.
>       tty: Add driver unthrottle in ioctl(...,TCFLSH,..).
> 
> Eric Sandeen (1):
>       jbd2: don't wake kjournald unnecessarily

Hum, I would not have expected this to *matter*, I thought it was just a perf
optimization.  Hm.  What do you think it fixed, exactly?

(sorry, have not followed that thread, busy elsewhere ATM)

-eric

> Hope this helps you.
> 
> Regards,
> - Sedat -
> 
> [0] http://marc.info/?t=135862023700004&r=1&w=2
> [1] http://marc.info/?l=linux-serial&m=135860500714909&w=2
> [2] http://git.kernel.org/?p=linux/kernel/git/gregkh/tty.git;a=commitdiff;h=a1bf9584429d61b7096f93ae09325e1ba538e9e8
> [3] http://patchwork.ozlabs.org/patch/207237/
> 
