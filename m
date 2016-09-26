From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: Fix DCD reading
Date: Mon, 26 Sep 2016 11:08:20 -0300
Message-ID: <CAOMZO5Cdime2w+R=UirP68ibKogYn2iuzGmuWt4yakQ+kmPDXw@mail.gmail.com>
References: <20160926135531.31888-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160926135531.31888-1-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi Sascha,

On Mon, Sep 26, 2016 at 10:55 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The USR2_DCDIN bit is tested for in register usr1. As the name
> suggests the usr2 register should be used instead. This fixes
> reading the Carrier detect status.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Good catch:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Shouldn't this have stable on Cc?
