From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/4] tty: serial: 8250_mtk: Use devm_clk_get
Date: Mon, 4 May 2015 11:36:00 +0200
Message-ID: <CABuKBe+qXf6xHkvTbBQ-FDVQAoQL-S-OiAS6dCry6e+aCyVvqQ@mail.gmail.com>
References: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
	<1430117397-13517-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430117397-13517-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

2015-04-27 8:49 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> When a struct device * is present clk_get should be used rather
> than of_clk_get. Use the devm variant of this function to be able to
> drop the clk_put in the error and remove pathes. While at it fix
> a wrong error message.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
