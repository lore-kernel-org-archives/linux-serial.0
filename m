From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH RFC v1 0/7] serial: imx: fix RTS and RTS/CTS handling
Date: Wed, 26 Jun 2019 12:00:41 +0200
Message-ID: <20190626100041.a7hyyhubun6y2r2z@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561042073-617-1-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1561042073-617-1-git-send-email-sorganov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergey Organov <sorganov@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Hi Sergey,

On Thu, Jun 20, 2019 at 05:47:46PM +0300, Sergey Organov wrote:
> The patches are not tested yet, so the RFC in the header. I'll re-roll
> without RFC once Sasha Hauer tests them.
> 
> Sasha, in addition to already discussed fixes, I've also reordered 2
> patches so that the sequence makes sense.
> 

I reviewed and tested this series, so when resending you can add my:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
