From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/7] serdev: add dev_pm_domain_attach|detach()
Date: Mon, 16 Jul 2018 11:50:18 +0200
Message-ID: <20180716095018.GA11078@kroah.com>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
 <20180715085628.GI10204@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180715085628.GI10204@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org, johan.hedberg@gmail.com, devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Jul 15, 2018 at 10:56:28AM +0200, Johan Hovold wrote:
> On Mon, Jul 09, 2018 at 11:56:58PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > In order to open up the required power gate before any operation can be
> > effectively performed over the serial bus between CPU and serdev, it's
> > clearly essential to add common attach functions for PM domains to serdev
> > at the probe phase.
> > 
> > Similarly, the relevant dettach function for the PM domains should be
> > properly and reversely added at the remove phase.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-serial@vger.kernel.org
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks, now applied.

greg k-h
