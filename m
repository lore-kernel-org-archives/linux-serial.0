From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3 0/3] Complete ZTE PL011 device support
Date: Tue, 9 Aug 2016 11:21:53 +0800
Message-ID: <20160809032153.GK4678@tiger>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <20160714132620.GB4382@tiger>
 <20160718133516.GG1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160718133516.GG1041@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, Timur Tabi <timur@codeaurora.org>, xie.baoyou@zte.com.cn, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-serial@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 18, 2016 at 02:35:16PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 14, 2016 at 09:26:20PM +0800, Shawn Guo wrote:
> > Most of the changes of patch #3 are yours, so presumably you are fine
> > with it.  What about #1 and #2?  May I have your ACK on them, so that I
> > can ask Greg to pick up the series?  Thanks.
> 
> Yes, the three patches look fine.  For the first two:
> 
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Hi Greg,

The series missed 4.8 merge window.  Since v4.8-rc1 is out there, can
you please queue the it up for the next?  The series can still apply
on v4.8-rc1 cleanly.  Thanks.

Shawn
