From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 161/493] tty: remove use of __devinit
Date: Tue, 20 Nov 2012 10:44:49 +0100
Message-ID: <20121120094449.GG25445@distanz.ch>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-161-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353349642-3677-161-git-send-email-wfp5p@virginia.edu>
Sender: linux-ia64-owner@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@gmail.com>, Alan Cox <alan@linux.intel.com>, Lucas Tavares <lucaskt@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, Peter Korsgaard <jacmet@sunsite.dk>, Tony Prisk <linux@prisktech.co.nz>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-ia64@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 2012-11-19 at 19:21:50 +0100, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Jiri Slaby <jirislaby@gmail.com> 
> Cc: Alan Cox <alan@linux.intel.com> 
> Cc: Tobias Klauser <tklauser@distanz.ch> 
> Cc: Lucas Tavares <lucaskt@linux.vnet.ibm.com> 
> Cc: "David S. Miller" <davem@davemloft.net> 
> Cc: Peter Korsgaard <jacmet@sunsite.dk> 
> Cc: Tony Prisk <linux@prisktech.co.nz> 
> Cc: linuxppc-dev@lists.ozlabs.org 
> Cc: linux-serial@vger.kernel.org 
> Cc: nios2-dev@sopc.et.ntust.edu.tw 
> Cc: linux-ia64@vger.kernel.org 
> Cc: sparclinux@vger.kernel.org 
> Cc: linux-arm-kernel@lists.infradead.org 
> ---
[...]
>  drivers/tty/serial/altera_jtaguart.c        |  2 +-
>  drivers/tty/serial/altera_uart.c            |  2 +-

Acked-by: Tobias Klauser <tklauser@distanz.ch>
