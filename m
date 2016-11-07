From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC] serial: sh-sci: Fix deadlock caused by serial output
 request
Date: Mon, 7 Nov 2016 16:40:01 +0100
Message-ID: <20161107154000.GB9233@verge.net.au>
References: <1478531681-1561-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdW8VPo5Vx08CdN9ZHw=ujamNc+Th5VftE5CxJdxbGwZVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW8VPo5Vx08CdN9ZHw=ujamNc+Th5VftE5CxJdxbGwZVg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 07, 2016 at 04:20:56PM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 7, 2016 at 4:14 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > From: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
> >
> > While spin is already locked, serial output request causes the deadlock,
> > because serial output process also tries to lock the spin.
> > This patch removes serial output with spin locked.
> >
> > Signed-off-by: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,

Thanks. Will you pass this on to Greg or should I do so?
