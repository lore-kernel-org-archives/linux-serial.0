From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 1/3] serial: imx: set_termios(): do not enable autoRTS
 if RTS is unset
Date: Mon, 22 Jul 2019 11:54:05 +0200
Message-ID: <20190722095405.qdc77cb2qrgltzrx@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563787330-1394-1-git-send-email-sorganov@gmail.com>
 <1563787330-1394-2-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1563787330-1394-2-git-send-email-sorganov@gmail.com>
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
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 12:22:08PM +0300, Sergey Organov wrote:
> Don't let receiver hardware automatically control RTS output if it
> was requested to be inactive.
> =

> To ensure this, set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS
> (=3DTIOCM_RTS) is cleared. Added corresponding check in imx_uart_rts_auto=
()
> to fix this.
> =

> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I think it's a bit bold to add a review-tag for me here. The best reason
for that that I'm aware of is that I wrote for v4: "[I]f you update the
commit log as agreed already before and even add a comment in
imx_uart_rts_auto along the lines of ... you can have my Ack." which IMO
isn't good enough to justify a "Reviewed-by". I wouldn't even add an
Acked-by: without the other person being able to actually see the
changed patch (but this might be arguable).

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
