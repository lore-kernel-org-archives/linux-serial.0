From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] serial: 8250-mtk: modify mtk uart power and clock
 management
Date: Thu, 25 Jul 2019 11:47:51 +0200
Message-ID: <20190725094751.GB31845@kroah.com>
References: <1563505182-2408-1-git-send-email-changqi.hu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1563505182-2408-1-git-send-email-changqi.hu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changqi Hu <changqi.hu@mediatek.com>
Cc: Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Peter Shih <pihsun@chromium.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 19, 2019 at 10:59:42AM +0800, Changqi Hu wrote:
> modify mtk uart runtime interface, add uart clock use count.
> merge patch v1 and patch v2 together.
> 
> Signed-off-by: Changqi Hu <changqi.hu@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 50 ++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 18 deletions(-)

Always describe what changed from the previous versions in the area
below the --- line.

Also, your changelog needs a lot more work.  Please read the section
entitled "The canonical patch format" in the kernel file,
Documentation/SubmittingPatches for a description of how to do this.

thanks,

greg k-h's patch email bot

thanks,

greg k-h
