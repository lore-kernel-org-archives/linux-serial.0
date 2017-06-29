From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 0/9] Add and make use of a common rs485 device tree
 parsing function
Date: Thu, 29 Jun 2017 17:12:00 +0200
Message-ID: <20170629151200.GA16362@kroah.com>
References: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
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
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 26, 2017 at 11:07:54AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
> =

> this is v3 of the series that targets to consolidate parsing the rs485 sp=
ecific
> dt properties in a single place.

This patch breaks the build, and not all of them applied properly :(

Please be more careful when you fix this up and resend...

thanks,

greg k-h
