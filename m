From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 01/11] serial: exar: Leave MPIOs as output for
 Commtech adapters
Date: Fri, 9 Jun 2017 10:29:39 +0200
Message-ID: <20170609082939.GB29675@kroah.com>
References: <cover.1496388533.git.jan.kiszka@siemens.com>
 <0c7b59cdc5a4cb7035656b081e36457eb675fc29.1496388533.git.jan.kiszka@siemens.com>
 <CACRpkdYeTGkp1e1gGAzhwXjS8dBCJiWror68Wov-j4g4t4zt2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYeTGkp1e1gGAzhwXjS8dBCJiWror68Wov-j4g4t4zt2Q@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 09, 2017 at 09:20:43AM +0200, Linus Walleij wrote:
> On Fri, Jun 2, 2017 at 9:28 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
> > Commtech adapters apparently need the original setting as outputs, see
> > https://marc.info/?l=linux-gpio&m=149557425201323&w=2. Account for that.
> >
> > Fixes: 7dea8165f1d6 ("serial: exar: Preconfigure xr17v35x MPIOs as output")
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Greg can you pick this up for fixes?

Ok, will do, thanks.

greg k-h
