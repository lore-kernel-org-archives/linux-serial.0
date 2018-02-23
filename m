From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/9] serial: imx: Fix out-of-bounds access through
 serial port index
Date: Fri, 23 Feb 2018 14:51:29 +0100
Message-ID: <20180223135129.lvk3rgepyuik7a2y@pengutronix.de>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
 <1519393117-31998-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1519393117-31998-4-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, Barry Song <baohua@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 23, 2018 at 02:38:31PM +0100, Geert Uytterhoeven wrote:
> The imx_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, or from platform data, which may lead to an
> out-of-bounds access.
> =

> Fix this by adding a range check.
> =

> Fixes: ff05967a07225ab6 ("serial/imx: add of_alias_get_id() reference bac=
k")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for your time
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
