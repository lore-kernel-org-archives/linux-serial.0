From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 5/5] ARM: shmobile: defconfig: Disable CONFIG_EMBEDDED
Date: Fri, 1 Dec 2017 09:33:06 +0100
Message-ID: <20171201083305.5vhvr6dfrbzemqgc@verge.net.au>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
 <1512047522-16312-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1512047522-16312-6-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 30, 2017 at 02:12:02PM +0100, Geert Uytterhoeven wrote:
> CONFIG_EXPERT exposes too many config options that do not matter for
> development. However, CONFIG_EMBEDDED selects CONFIG_EXPERT, so it
> cannot be disabled.
> 
> Hence disable CONFIG_EMBEDDED, and compensate for the loss of
> CONFIG_DEBUG_KERNEL by enabling the latter.
> 
> Actual impact:
>   - CONFIG_NAMESPACES=y,
>   - CONFIG_SYSCTL_SYSCALL=n,
>   - CONFIG_SERIAL_SH_SCI_NR_UARTS changed from 20 to 18,
>   - CONFIG_SERIAL_SH_SCI_EARLYCON=y,
>   - Some HID support became enabled,
>   - CONFIG_DEBUG_MEMORY_INIT=y,
> 
> Refresh the result.

I'm sorry but I don't understand the motivation for this change.
I understand that it might make the image smaller or build times faster.
But it seems to be a risky change for those benefits.
What are the side-effects of the changes you describe above?
