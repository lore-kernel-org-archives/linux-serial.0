From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/5] serial: atmel: fix error handling when
 mctrl_gpio_init fails
Date: Fri, 27 Feb 2015 12:49:07 -0800
Message-ID: <20150227204907.GA27277@kroah.com>
References: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150227204018.GA8174@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150227204018.GA8174@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-serial@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Nicolas Ferre <nicolas.ferre@atmel.com>, Janusz Uzycki <j.uzycki@elproma.com.pl>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 27, 2015 at 09:40:18PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Greg,
> =

> probably it's just me being impatient, but I wonder about not getting
> any feedback for the several patches I sent for drivers/tty/serial.
> =

> Are you just not yet in patch-collecting mode for 4.1? Although the
> patches in this series might even be post-merge-window material.

I'm not in a patch-collecting mode for tty/serial drivers for 4.1 just
yet, sorry, I hope to get to them next week.

thanks,

greg k-h
