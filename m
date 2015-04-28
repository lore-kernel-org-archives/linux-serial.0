From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] earlycon: Fix uart_parse_earlycon() if
 !CONFIG_SERIAL_CORE_CONSOLE
Date: Tue, 28 Apr 2015 14:22:10 +0200
Message-ID: <20150428122210.GA16972@kroah.com>
References: <1428763356-29158-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428763356-29158-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, tfiga@google.com, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 11, 2015 at 10:42:36AM -0400, Peter Hurley wrote:
> Arnd Bergmann wrote:
> > A configuration that enables earlycon but not the core console
> > code causes a link error:
> >
> > drivers/built-in.o: In function `setup_earlycon':
> > drivers/tty/serial/earlycon.c:70: undefined reference to `uart_parse_earlycon'
> 
> CONFIG_SERIAL_EARLYCON should not require CONFIG_SERIAL_CORE_CONSOLE.
> Move uart_parse_earlycon() and compile if either CONFIG_SERIAL_CORE_CONSOLE
> or CONFIG_SERIAL_EARLYCON.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
> 
> NB: The diff moves everything else around uart_parse_earlycon() :/
> 
>  drivers/tty/serial/serial_core.c | 90 ++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 44 deletions(-)

This doesn't apply to my tty-next branch :(
