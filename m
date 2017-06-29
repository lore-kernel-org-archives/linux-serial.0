From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 01/10] gpio-exar/8250-exar: Do not even instantiate a
 GPIO device for Commtech cards
Date: Thu, 29 Jun 2017 16:48:52 +0200
Message-ID: <20170629144852.GB23512@kroah.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
 <4c5f5a761255c584e57fb96e35021104367616e5.1497033197.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4c5f5a761255c584e57fb96e35021104367616e5.1497033197.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 09, 2017 at 08:33:09PM +0200, Jan Kiszka wrote:
> Commtech adapters need the MPIOs for internal purposes, and the
> gpio-exar driver already refused to pick them up. But there is actually
> no point in even creating the underlying platform device.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
