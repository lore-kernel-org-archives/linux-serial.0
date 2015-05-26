From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: samsung: only use earlycon for console
Date: Tue, 26 May 2015 10:00:30 -0400
Message-ID: <55647C7E.6010907@hurleysoftware.com>
References: <3397068.2Doeo7zeZ1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <3397068.2Doeo7zeZ1@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tfiga@google.com, Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-serial@vger.kernel.org

On 05/19/2015 04:26 PM, Arnd Bergmann wrote:
> A configuration that enables earlycon but not the core console
> code causes a link error:
> 
>   drivers/built-in.o: In function `setup_earlycon':
>   drivers/tty/serial/earlycon.c:70: undefined reference to `uart_parse_earlycon'
> 
> That error can be triggered by the newly added samsung earlycon support,
> which is missing a 'select' statement.
> 
> As suggested by Peter Hurley, solves the problem by moving the
> 'select SERIAL_EARLYCON' statement to the samsung console driver
> option, as it is done by all other console drivers.

Thanks.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
