From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: mctrl-gpio: fix build warning
Date: Wed, 11 Mar 2015 14:01:05 +0100
Message-ID: <20150311130105.GB16733@kroah.com>
References: <2661449.5Eht12RCUu@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <2661449.5Eht12RCUu@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 11, 2015 at 11:25:41AM +0100, Arnd Bergmann wrote:
> A recent fix to the error handling in this driver introduced a
> harmless warning:
> 
> serial/serial_mctrl_gpio.c: In function 'mctrl_gpio_init':
> serial/serial_mctrl_gpio.c:110:4: warning: return makes pointer from integer without a cast
> serial/serial_mctrl_gpio.c:90:6: warning: unused variable 'err' [-Wunused-variable]
> 
> This removes the unused variable and uses the ERR_CAST helper
> to return the error value as the correct type.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 1d267ea6539f2 ("serial: mctrl-gpio: simplify init routine")

Someone else sent me this before you did, sorry.

greg k-h
