From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 429/493] tty: remove use of __devexit
Date: Tue, 20 Nov 2012 09:06:25 -0800
Message-ID: <20121120170624.GF21706@codeaurora.org>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <sparclinux-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
Sender: sparclinux-owner@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@gmail.com>, Alan Cox <alan@linux.intel.com>, Tobias Klauser <tklauser@distanz.ch>, Lucas Tavares <lucaskt@linux.vnet.ibm.com>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Peter Korsgaard <jacmet@sunsite.dk>, Tony Prisk <linux@prisktech.co.nz>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, uclinux-dist-devel@blackfin.uclinux.org, linux-arm-msm@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 19, 2012 at 01:26:18PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> ---
>  drivers/tty/serial/msm_serial.c             |  2 +-
>  drivers/tty/serial/msm_serial_hs.c          |  2 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
