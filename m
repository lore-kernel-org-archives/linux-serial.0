From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 3/5] serial: core: Support common rs485 binding for RTS
 polarity
Date: Wed, 8 Nov 2017 18:33:27 +0100
Message-ID: <20171108173327.GA10670@wunner.de>
References: <cover.1510134353.git.lukas@wunner.de>
 <e85e3d02a45e79e410b6606d8fdec347f03053f4.1510134353.git.lukas@wunner.de>
 <20171108111355.pzcrvdgqqeleinss@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171108111355.pzcrvdgqqeleinss-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>, Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 08, 2017 at 12:13:55PM +0100, Uwe Kleine-König wrote:
> On Wed, Nov 08, 2017 at 11:32:34AM +0100, Lukas Wunner wrote:
> > When a driver invokes the uart_get_rs485_mode() helper, set the RTS
> > polarity to active high by default unless the newly introduced
> > "rs485-rts-active-low" property was specified.

Thanks a lot Uwe for your review comments, those are good points,
d'accord on all of them.  I've already incorporated all suggested
changes into my local repo but will wait a few days before respinning
to see if there are further comments.

Best,

Lukas
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
