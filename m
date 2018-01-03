From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] serial: imx: fix endless loop during suspend
Date: Wed, 3 Jan 2018 14:20:48 -0200
Message-ID: <CAOMZO5BVQE45W6cSaPVLkDWAvTsaR54FPWD20krKCpgdGLX3CQ@mail.gmail.com>
References: <1514395632-15390-1-git-send-email-martin@kaiser.cx>
 <1514395632-15390-2-git-send-email-martin@kaiser.cx> <CAOMZO5AvFePCoKYQe7bt9bzFmdLYrgDyPLkepz99bJk7BTB0Lg@mail.gmail.com>
 <20180102161555.GA4503@botnar.kaiser.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102161555.GA4503@botnar.kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kaiser <martin@kaiser.cx>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <kernel@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Martin,

On Tue, Jan 2, 2018 at 2:15 PM, Martin Kaiser <martin@kaiser.cx> wrote:

> I tested on an imx258.

I am not able to reproduce this problem on a imx25 pdk running 4.14.11
or linux-next.

Is it 100% reproducible on your board?

Care to share its dts? Do you use multiple UART ports? Do any of them
use RTS/CTS?

Do you have any logs to share?

Thanks
