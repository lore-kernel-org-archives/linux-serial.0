From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCHv4 1/3] serial: mctrl_gpio: implement mctrl_gpio_use_rtscts
Date: Tue, 4 Oct 2016 09:28:56 +0200
Message-ID: <20161004072856.cgocbex2uj5f3yp4@pengutronix.de>
References: <20160930085801.21497-1-richard.genoud@gmail.com>
 <20160930085801.21497-2-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160930085801.21497-2-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Genoud <richard.genoud@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello Greg,

On Fri, Sep 30, 2016 at 10:57:59AM +0200, Richard Genoud wrote:
> This function returns true if CTS and RTS are used as GPIOs.
> Some drivers (like atmel_serial) needs to know if the flow control is
> handled by the controller or by GPIOs.

just for the record: I don't like this patch because I think it's highly
at91 specific and could so well live in that driver. Moreover I'm not
conviced yet that it's really the correct thing to do even for this
driver. So please don't apply, at least until we're done with the
discussion of patch 2.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
