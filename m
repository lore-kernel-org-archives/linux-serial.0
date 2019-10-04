From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 3/5] serial: fsl_linflexuart: Be consistent with the
 name
Date: Fri, 4 Oct 2019 15:07:12 +0200
Message-ID: <20191004130712.GA622272@kroah.com>
References: <20191002130425.28905-1-stefan-gabriel.mirea@nxp.com>
 <20191002130425.28905-4-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191002130425.28905-4-stefan-gabriel.mirea@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 02, 2019 at 01:04:42PM +0000, Stefan-gabriel Mirea wrote:
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -290,7 +290,7 @@
>  /* Sunix UART */
>  #define PORT_SUNIX	121
>  
> -/* Freescale Linflex UART */
> -#define PORT_LINFLEXUART	121
> +/* Freescale LINFlexD UART */
> +#define PORT_LINFLEXUART	122

This is a different change, and one that should be split out and
submitted now, for 5.4.  Please do that as the id number is incorrect,
don't bury a valid change in the middle of a "marketing renamed the
device" patch :)

thanks,

greg k-h
