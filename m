From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] serial: digicolor: fix sysrq handling
Date: Wed, 14 Jan 2015 07:57:01 +0200
Message-ID: <20150114055701.GX2481@sapphire.tkos.co.il>
References: <1730002.vWGOEymGdz@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1730002.vWGOEymGdz@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

On Tue, Jan 13, 2015 at 03:37:11PM +0100, Arnd Bergmann wrote:
> Trying to build the digicolor-usart driver when sysrq is disabled
> results in a compile error:
> 
> drivers/tty/serial/digicolor-usart.c: In function 'digicolor_uart_console_write':
> drivers/tty/serial/digicolor-usart.c:407:33: error: 'struct uart_port' has no member named 'sysrq'
> 
> Like a lot of other drivers, this one requires an #ifdef to avoid
> accessing the sysrq field here. While looking into this, I noticed
> that the case where sysrq support is enabled is also broken, because
> the driver fails to set the SUPPORT_SYSRQ macro.
> 
> This patch hopefully fixes both, but I do not hardware to test if sysrq
> is actually working now.

Unfortunately the hardware is not able to detect the BREAK condition, so it is 
not possible to support sysrq on this hardware. I'll send a patch removing 
sysrq reference.

Thanks for build testing and reporting.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
