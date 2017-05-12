From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2] serial: efm32: Fix parity management in
 'efm32_uart_console_get_options()'
Date: Fri, 12 May 2017 22:17:03 +0200
Message-ID: <20170512201703.puk6xit34d3dnddv@pengutronix.de>
References: <20170512143545.15394-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170512143545.15394-1-christophe.jaillet@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, kernel@pengutronix.de, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, May 12, 2017 at 04:35:45PM +0200, Christophe JAILLET wrote:
> UARTn_FRAME_PARITY_ODD is 0x0300
> UARTn_FRAME_PARITY_EVEN is 0x0200
> So if the UART is configured for EVEN parity, it would be reported as ODD.
> Fix it by correctly testing if the 2 bits are set.
> 
> Fixes: 3afbd89c9639 ("serial/efm32: add new driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for picking this topic up again.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
