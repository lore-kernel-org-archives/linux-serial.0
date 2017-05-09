From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [regression, bisected] 4.11+ imx uarts broken
Date: Tue, 9 May 2017 09:14:35 +0200
Message-ID: <20170509071435.kxt6pjlglzinf2w5@pengutronix.de>
References: <f6fded83-f062-94da-ec1b-b2ab6e6c5101@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f6fded83-f062-94da-ec1b-b2ab6e6c5101@nextfour.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Mika,

On Tue, May 09, 2017 at 07:18:09AM +0300, Mika Penttilä wrote:
> The following commit e61c38d85b7 makes the uarts on i.MX6 nonfunctional (no data transmitted or received). 
> With e61c38d85b7 reverted the uarts work ok.
> 
> -------------------
> commit e61c38d85b7392e033ee03bca46f1d6006156175
> Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Date:   Tue Apr 4 11:18:51 2017 +0200
> 
>     serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off
>  
> --------------------

are you operating the UART in DTE or DCE mode? Does this affect all
UARTs or only those that are not used in the bootloader?

Looking at the patch I wonder if setting IMX21_UCR3_RXDMUXSEL |
UCR3_ADNIMP is missing for you.

Can you please check which hunk of e61c38d85b73 is giving you problems?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
