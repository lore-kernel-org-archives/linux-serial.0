From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v5 2/7] serdev: add dev_pm_domain_attach|detach()
Date: Sat, 14 Jul 2018 18:27:33 +0200
Message-ID: <ED7E5A98-81DC-41B9-9B9A-3EF4EBBED854@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Johan Hedberg <johan.hedberg@gmail.com>, devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Sean,

> In order to open up the required power gate before any operation can be
> effectively performed over the serial bus between CPU and serdev, it's
> clearly essential to add common attach functions for PM domains to serdev
> at the probe phase.
> 
> Similarly, the relevant dettach function for the PM domains should be
> properly and reversely added at the remove phase.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> ---
> drivers/tty/serdev/core.c | 15 ++++++++++++++-
> 1 file changed, 14 insertions(+), 1 deletion(-)

can we take this through the serial subsystem? Or should I just take it when the driver is ready to be included?

Regards

Marcel
