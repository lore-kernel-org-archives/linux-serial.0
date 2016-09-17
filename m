From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for
 ZTE device
Date: Sat, 17 Sep 2016 10:17:54 +0100
Message-ID: <20160917091753.GJ1041@n2100.armlinux.org.uk>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
 <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
 <20160916163952.GH1041@n2100.armlinux.org.uk>
 <57DC27A9.3060307@codeaurora.org> <20160917053753.GG7398@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160917053753.GG7398@tiger>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Timur Tabi <timur@codeaurora.org>, xie.baoyou@zte.com.cn, Andre Przywara <andre.przywara@arm.com>, linux-serial@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sat, Sep 17, 2016 at 01:37:53PM +0800, Shawn Guo wrote:
> I still think that's a bad idea.  ZTE is not the first one making such
> small customization on PL011, and likely won't be the last one.  We
> don't want to clone PL011 driver every time there is a such vendor
> hardware coming out, do we?  Having PL011 driver being able to handle
> different register layout is very helpful to handle such vendor
> variants, IMHO.

Well, it's turning out that handling ZTE in PL011 is turning into a
bad idea as well - we keep getting these breakages each time we try.

I think ZTE is sufficiently different from PL011 with the different
register layout _and_ the different bits, _and_ the pain that this
is causing, that it should have been a separate driver.

The only way I can think of dealing with the console issue is to
replicate the console code, once for the PL011 variant and then
again for the ZTE variant.  We can't _both_ give them the same names
_and_ register them together - we either have to give them different
names, which makes it confusing because one name won't match the
userspace name for the UART, or we need the driver to detect the
port type early.  That's made much more difficult because ZTE didn't
bother with the ID registers, unlike every other vendor.

Serial drivers are not that complex anymore, compared to how they
were back before serial_core happened, so having it as a separate
driver isn't that big a deal.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
