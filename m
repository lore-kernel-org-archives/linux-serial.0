From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/3] parisc/uapi: Add definition of TIOC[SG]RS485
Date: Tue, 9 Sep 2014 11:43:18 -0700
Message-ID: <20140909184318.GA6231@kroah.com>
References: <1410285991-24833-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410285991-24833-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 09, 2014 at 08:06:31PM +0200, Ricardo Ribalda Delgado wrote:
> Commit: e676253b19b2d269cccf67fdb1592120a0cd0676 (serial/8250: Add
> support for RS485 IOCTLs), adds support for RS485 ioctls for 825_core on
> all the archs. Unfortunaltely the definition of TIOCSRS485 and
> TIOCGRS485 was missing on the ioctls.h file
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  arch/parisc/include/uapi/asm/ioctls.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/uapi/asm/ioctls.h
> index 66719c3..3af2d02 100644
> --- a/arch/parisc/include/uapi/asm/ioctls.h
> +++ b/arch/parisc/include/uapi/asm/ioctls.h
> @@ -50,6 +50,8 @@
>  #define TCSETS2		_IOW('T',0x2B, struct termios2)
>  #define TCSETSW2	_IOW('T',0x2C, struct termios2)
>  #define TCSETSF2	_IOW('T',0x2D, struct termios2)
> +#define TIOCGRS485	0x542E
> +#define TIOCSRS485	0x542F

As David pointed out with the sparc patch, please use the proper ioctl
macros for these numbers.

Please redo all of these patches and resend.

thanks,

greg k-h
