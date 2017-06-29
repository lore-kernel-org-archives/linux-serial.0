From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 07/10] serial: exar: Factor out platform hooks
Date: Thu, 29 Jun 2017 16:48:18 +0200
Message-ID: <20170629144818.GA23512@kroah.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
 <8baf62a96105a2d8f84a73f887e55f6d86b7cae4.1497033197.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8baf62a96105a2d8f84a73f887e55f6d86b7cae4.1497033197.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 09, 2017 at 08:33:15PM +0200, Jan Kiszka wrote:
> This prepares the addition of IOT2040 platform support by preparing the
> needed setup and rs485_config hooks.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
