From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 5/5] ARM: shmobile: defconfig: Disable CONFIG_EMBEDDED
Date: Tue, 5 Dec 2017 09:28:34 +0100
Message-ID: <20171205082833.fqwuyvlmupwektny@verge.net.au>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
 <1512047522-16312-6-git-send-email-geert+renesas@glider.be>
 <20171201083305.5vhvr6dfrbzemqgc@verge.net.au>
 <CAMuHMdXSWhXXEzPgp8Y35df7B6G+TUkddRK8=p6T3q+ugDNxCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXSWhXXEzPgp8Y35df7B6G+TUkddRK8=p6T3q+ugDNxCA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 04, 2017 at 10:46:22AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Dec 1, 2017 at 9:33 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Nov 30, 2017 at 02:12:02PM +0100, Geert Uytterhoeven wrote:
> >> CONFIG_EXPERT exposes too many config options that do not matter for
> >> development. However, CONFIG_EMBEDDED selects CONFIG_EXPERT, so it
> >> cannot be disabled.
> >>
> >> Hence disable CONFIG_EMBEDDED, and compensate for the loss of
> >> CONFIG_DEBUG_KERNEL by enabling the latter.
> >>
> >> Actual impact:
> >>   - CONFIG_NAMESPACES=y,
> >>   - CONFIG_SYSCTL_SYSCALL=n,
> >>   - CONFIG_SERIAL_SH_SCI_NR_UARTS changed from 20 to 18,
> >>   - CONFIG_SERIAL_SH_SCI_EARLYCON=y,
> >>   - Some HID support became enabled,
> >>   - CONFIG_DEBUG_MEMORY_INIT=y,
> >>
> >> Refresh the result.
> >
> > I'm sorry but I don't understand the motivation for this change.
> > I understand that it might make the image smaller or build times faster.
> > But it seems to be a risky change for those benefits.
> 
> My main motivation is to start using the default values for the various SH_SCI
> options from the first 4 patches, but that requires disabling CONFIG_EXPERT.
> Sorry for not making that clearer.

Thanks for explaining, that helps me significantly.

> > What are the side-effects of the changes you describe above?
> 
> Enabling CONFIG_NAMESPACES shouldn't hurt (isn't that also needed for
> systemd anyway?), just like the HID devices, or CONFIG_DEBUG_MEMORY_INIT
> (it does a few more checks, and defaults to yes).
> 
> Disabling CONFIG_SYSCTL_SYSCALL also shouldn't hurt (it defaults to no),
> except for very old userland not yet using /proc/sys, which might have been
> broken along the way by changed binary paths anyway.

Understood. I (no longer) have any particular objections to this,
though I would appreciate an enhanced changelog.
