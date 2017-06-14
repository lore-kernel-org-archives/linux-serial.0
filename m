From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty/serial: Kconfig: remove AVR32
Date: Wed, 14 Jun 2017 12:49:45 +0200
Message-ID: <20170614104945.GA11354@kroah.com>
References: <20170613203509.32026-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170613203509.32026-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 13, 2017 at 10:35:09PM +0200, Alexandre Belloni wrote:
> AVR32 is now removed from the kernel, removed the config symbol that
> doesn't exist anymore. Also take the opportunity to reword the help to
> include sama5.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/tty/serial/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Does not apply to tty-next at all :(
