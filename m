From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] TTY/Serial patches for 4.3-rc1
Date: Fri, 21 Aug 2015 22:44:34 -0700
Message-ID: <20150822054434.GA6245@kroah.com>
References: <20150820191121.GA24594@kroah.com>
 <20150821095733.479a51aa@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150821095733.479a51aa@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 21, 2015 at 09:57:33AM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Thu, 20 Aug 2015 12:11:21 -0700 Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > All have been in linux-next with no reported issues.
> 
> Except see below.
> 
> > Eduardo Valentin (4):
> >       serial: imx: introduce serial_imx_enable_wakeup()
> 
> I reported that this commit breaks the arm multi_v7_defconfig build and
> I have seen no fix applied.
> 
> I have been applying the following patch for a few days but do not know
> if it is the correct resolution:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 18 Aug 2015 15:56:40 +1000
> Subject: [PATCH] serial: imx: partial revert of "introduce serial_imx_enable_wakeup()"
> 
> This reverts the part of commit 189550b8644e that affects
> arch/arm/boot/dts/Makefile
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/arm/boot/dts/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d3ee1f01ffc7..233159d2eaab 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -330,7 +330,6 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-wandboard-revb1.dtb
>  dtb-$(CONFIG_SOC_IMX6SL) += \
>  	imx6sl-evk.dtb \
> -	imx6sl-fox-p1.dtb \
>  	imx6sl-warp.dtb
>  dtb-$(CONFIG_SOC_IMX6SX) += \
>  	imx6sx-sabreauto.dtb \
> -- 
> 2.5.0

Ugh, you are right, sorry about that.  I can't add it to my tree at the
moment, but can do so in a few weeks...

greg k-h
