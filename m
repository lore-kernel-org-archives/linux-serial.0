From: Jaeden Amero <jaeden.amero@ni.com>
Subject: Re: [tty:tty-next 10/16] fs/compat_ioctl.c:869:1: error: 'TIOCSRS485' undeclared here (not in a function)
Date: Mon, 24 Sep 2012 10:39:44 -0500
Message-ID: <1348501185-23657-1-git-send-email-jaeden.amero@ni.com>
References: <20120922005021.GM5959@localhost>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120922005021.GM5959@localhost>
Sender: linux-next-owner@vger.kernel.org
To: fengguang.wu@intel.com
Cc: linux-next@vger.kernel.org, sfr@canb.auug.org.au, gregkh@linuxfoundation.org, alan@linux.intel.com, kernel-janitors@vger.kernel.org, linux-serial@vger.kernel.org, Jaeden Amero <jaeden.amero@ni.com>
List-Id: linux-serial@vger.kernel.org

On Sat, 22 Sep 2012 08:50:21 +0800, Fengguang Wu wrote:
> FYI, kernel build failed on
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> tty-next
> head:   ac57e7f38ea6fe7358cd0b7a2f2d21aef5ab70cd
> commit: 84c3b84860440a9e3a3666c14112f41311b8f623 [10/16]
>   compat_ioctl: Add RS-485 IOCTLs to the list
> config: mips-fuloong2e_defconfig
>
> All related error/warning messages:
>
> fs/compat_ioctl.c:869:1: error: 'TIOCSRS485' undeclared here (not in
>   a function)
> fs/compat_ioctl.c:870:1: error: 'TIOCGRS485' undeclared here (not in
>   a function)

I could fix this by defining these IOCTLs for all architectures that
don't have them yet, but I'm unsure of what values to give them or why
MIPS isn't using 'include/asm-generic/ioctls.h'.

Perhaps it is better to leave adding those IOCTLs up to those who add
the first RS-485 capable driver for that platform and to wrap the use
of these defines in compat_ioctl.c with #ifdefs, as I've done in this
patch. What do you think is best?

Cheers,
Jaeden Amero

Jaeden Amero (1):
  compat_ioctl: Avoid using undefined RS-485 IOCTLs

 fs/compat_ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
1.7.12
