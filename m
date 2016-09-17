From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for
 ZTE device
Date: Sat, 17 Sep 2016 13:37:53 +0800
Message-ID: <20160917053753.GG7398@tiger>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
 <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
 <20160916163952.GH1041@n2100.armlinux.org.uk>
 <57DC27A9.3060307@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <57DC27A9.3060307@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, xie.baoyou@zte.com.cn, Russell King - ARM Linux <linux@armlinux.org.uk>, Andre Przywara <andre.przywara@arm.com>, linux-serial@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 16, 2016 at 12:11:05PM -0500, Timur Tabi wrote:
> Russell King - ARM Linux wrote:
> >Maybe what we should've done with ZTE is insisted that they implement
> >a complete new driver, rather than trying to shoe-horn it into PL011
> >even though it is in theory PL011.
> 
> When I suggested that a year ago, I was shot down:
> 
> http://www.spinics.net/lists/arm-kernel/msg455888.html

I still think that's a bad idea.  ZTE is not the first one making such
small customization on PL011, and likely won't be the last one.  We
don't want to clone PL011 driver every time there is a such vendor
hardware coming out, do we?  Having PL011 driver being able to handle
different register layout is very helpful to handle such vendor
variants, IMHO.

I still appreciate rmk's insistence to handle ZTE device with PL011
driver, and the effort of adding a little "infrastructure" to handle
all such possible variants.

Shawn
