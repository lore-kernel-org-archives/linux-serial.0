From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH linux-next] MIPS: ioctls: Add missing TIOC{S,G}RS485
 definitions
Date: Tue, 9 Sep 2014 12:17:36 -0700
Message-ID: <20140909191736.GA7467@kroah.com>
References: <1410263575-26720-1-git-send-email-markos.chandras@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410263575-26720-1-git-send-email-markos.chandras@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 09, 2014 at 12:52:55PM +0100, Markos Chandras wrote:
> Commit e676253b19b2d269cccf67fdb1592120a0cd0676
> (serial/8250: Add support for RS485 IOCTLs) added cases for the
> TIOC{S,G}RS485 commands but this broke the build for MIPS:
> 
> drivers/tty/serial/8250/8250_core.c: In function 'serial8250_ioctl':
> drivers/tty/serial/8250/8250_core.c:2874:7: error: 'TIOCSRS485' undeclared
> (first use in this function)
> drivers/tty/serial/8250/8250_core.c:2886:7: error: 'TIOCGRS485' undeclared
> (first use in this function)
> 
> This patch adds these missing definitions
> 
> Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Cc: <linux-next@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Cc: <linux-serial@vger.kernel.org>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/include/uapi/asm/ioctls.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
> index b1e637757fe3..34050cb6b631 100644
> --- a/arch/mips/include/uapi/asm/ioctls.h
> +++ b/arch/mips/include/uapi/asm/ioctls.h
> @@ -76,6 +76,8 @@
>  
>  #define TIOCSBRK	0x5427	/* BSD compatibility */
>  #define TIOCCBRK	0x5428	/* BSD compatibility */
> +#define TIOCGRS485	0x542E
> +#define TIOCSRS485	0x542F

Any reason you aren't using the _IOR() type macros here?

thanks,

greg k-h
