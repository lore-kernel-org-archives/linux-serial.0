From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3 0/3] Complete ZTE PL011 device support
Date: Thu, 14 Jul 2016 21:26:20 +0800
Message-ID: <20160714132620.GB4382@tiger>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@armlinux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Timur Tabi <timur@codeaurora.org>, xie.baoyou@zte.com.cn, linux-serial@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 08, 2016 at 05:00:38PM +0800, Shawn Guo wrote:
> This is a pick-up of Jun's v2 patch which tries to complete ZTE PL011
> support.
> 
> Commit 7ec758718920 ("tty: amba-pl011: add support for ZTE UART
> (EXPERIMENTAL)") from Russell had already done part of the work that is
> needed for ZTE PL011 support.  The series adds the missing pieces which
> includes handling Flag Register bit position oddness and getting ZTE
> PL011 device probed by amba-pl011 driver.
> 
> Thanks to Russell for the "official" pseudo-ID idea.
> 
> Changes since v2:
>  - Split changes into 3 separate patches
>  - Take Russell's suggestion using helper macro to create pseudo-ID
>  - Rebase to v4.7-rc6
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/417192.html
> 
> Shawn Guo (3):
>   tty: amba-pl011: define flag register bits for ZTE device
>   tty: amba-pl011: add .get_fifosize for ZTE device
>   tty: amba-pl011: probe ZTE device from AMBA bus with a pseudo-ID

Hi Russell,

Most of the changes of patch #3 are yours, so presumably you are fine
with it.  What about #1 and #2?  May I have your ACK on them, so that I
can ask Greg to pick up the series?  Thanks.

Shawn
