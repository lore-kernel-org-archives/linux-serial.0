From: Shuyu Wei <wsy-flSAGy4ZnMjQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH][RFC] 8250_dw: unregister dw8250_set_termios for rk3188
 chip
Date: Wed, 22 Nov 2017 01:17:13 +0800
Message-ID: <20171121171712.GA4462@home.dogben.com>
References: <20171120144045.juwm64m2j736h5ps@home.dogben.com>
 <20171120161455.orvooleyzfsslon3@home.dogben.com>
 <0a4ce349-d386-0f1b-e973-e77af7f75d23@sondrel.com>
 <1854299.UNFOX8ncyA@diego>
 <20171121030949.a6bsapueiicdbonj@home.dogben.com>
 <4010bd84-7c88-5410-820f-bd3d04f1fbb5@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4010bd84-7c88-5410-820f-bd3d04f1fbb5-56FIPCJpnYtBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ed Blake <ed.blake-56FIPCJpnYtBDgjK7y7TUQ@public.gmane.org>
Cc: wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 21, 2017 at 10:23:17AM +0000, Ed Blake wrote:

> Is this on 4.14 or next?
> Can you try applying this patch series and see if it fixes the problem?
> https://www.spinics.net/lists/linux-serial/msg27672.html

I'm working on the mainline, which already has this patch applied, so it
doesn't fix the problem.

The breaking commit I mentioned is a merge on mainline, the
underlying commit is 6a171b on 2017-01-19.


> What baud rate is being set, and what rate does clk_round_rate() return
> in dw8250_set_termios()?

I'm using baud 115200, clk_round_rate() returns 1843200.
