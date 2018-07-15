From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [SPAM]Re: [PATCH v5 2/7] serdev: add dev_pm_domain_attach|detach()
Date: Sun, 15 Jul 2018 10:12:10 +0200
Message-ID: <20180715081210.GB20758@kroah.com>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
 <ED7E5A98-81DC-41B9-9B9A-3EF4EBBED854@holtmann.org>
 <1531632595.26214.31.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1531632595.26214.31.camel@mtkswgap22>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sean Wang <sean.wang@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sun, Jul 15, 2018 at 01:29:55PM +0800, Sean Wang wrote:
> On Sat, 2018-07-14 at 18:27 +0200, Marcel Holtmann wrote:
> > Hi Sean,
> > 
> > > In order to open up the required power gate before any operation can be
> > > effectively performed over the serial bus between CPU and serdev, it's
> > > clearly essential to add common attach functions for PM domains to serdev
> > > at the probe phase.
> > > 
> > > Similarly, the relevant dettach function for the PM domains should be
> > > properly and reversely added at the remove phase.
> > > 
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jiri Slaby <jslaby@suse.com>
> > > Cc: linux-serial@vger.kernel.org
> > > ---
> > > drivers/tty/serdev/core.c | 15 ++++++++++++++-
> > > 1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > can we take this through the serial subsystem? Or should I just take it when the driver is ready to be included?
> > 
> > Regards
> > 
> > Marcel
> > 
> 
> I think it's better if the change is taken through serial subsystem
> first.
> 
> Hi, Rob
> 
> do you have any comment? 

Yeah, I've been ignoring it to wait to get an ack from someone...

greg k-h
