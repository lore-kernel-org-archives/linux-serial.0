From: Shuyu Wei <wsy-flSAGy4ZnMjQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH][RFC] 8250_dw: unregister dw8250_set_termios for rk3188
 chip
Date: Tue, 21 Nov 2017 11:09:50 +0800
Message-ID: <20171121030949.a6bsapueiicdbonj@home.dogben.com>
References: <20171120144045.juwm64m2j736h5ps@home.dogben.com>
 <20171120161455.orvooleyzfsslon3@home.dogben.com>
 <0a4ce349-d386-0f1b-e973-e77af7f75d23@sondrel.com>
 <1854299.UNFOX8ncyA@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1854299.UNFOX8ncyA@diego>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Ed Blake <ed.blake-56FIPCJpnYtBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 20, 2017 at 06:51:37PM +0100, Heiko St=FCbner wrote:
 =

> Also, the rk3188 uarts are definitly not fixed at 24MHz and can use other =

> sources as well. So I'm puzzled because at least the serial console on my =

> rk3188 radxarock works without issues.
> =

> Can you tell us which uart you are failing to control correctly?
> =

> =

> I do remember that I ran into problems when the set_termios change
> was introduced originally, resulting in the patch
> 	"serial: 8250_dw: Honor clk_round_rate errors in dw8250_set_termios" [0]
> but that is in mainline for quite some time now.
> =

> [0] https://patchwork.kernel.org/patch/9594657/
> =

> =

> Heiko

Hi Heiko,

I'm using ttyS2(uart2).
My board starts to fail on mainline since the exact commit 37c8596,
that's why I try to remove dw8250_set_termios() and it worked.
