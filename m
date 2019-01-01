From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v7 00/11] Add initial RDA8810PL SoC and Orange Pi boards
 support
Date: Tue, 1 Jan 2019 08:32:47 +0530
Message-ID: <20190101030247.GB2736@Mani-XPS-13-9360>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
 <20181231211342.ulg4jytermffqi34@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181231211342.ulg4jytermffqi34@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: devicetree@vger.kernel.org, arm@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, linux-unisoc@lists.infradead.org, robh+dt@kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, afaerber@suse.de, linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
List-Id: linux-serial@vger.kernel.org

Hi Olof,

On Mon, Dec 31, 2018 at 01:13:42PM -0800, Olof Johansson wrote:
> On Tue, Dec 18, 2018 at 08:32:27PM +0530, Manivannan Sadhasivam wrote:
> > Hello Maintainers,
> > 
> > This patch series adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
> > i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
> > GPU. The SoC has been added as a new ARM sub architecture with myself as the
> > maintainer.
> > 
> > More information about the boards can be found in below links:
> > 
> > 1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
> > 2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/
> > 
> > All patches are reviewed by the corresponding subsystem maintainers. The
> > clocksource and irqchip patches are reviewed and merged while the serial
> > driver got review from Greg but I'm not sure who will apply it.
> > 
> > So as per my discussion with Arnd, sending the individual patches instead
> > of a Pull request so that the rest of the patches can go through the
> > ARM SoC tree.
> > 
> > Please consider applying it.
> 
> Hi,
> 
> I've applied this series to our next/late branch. It's a branch we'll try to
> get merged by the end of the merge window, but it's not a guarantee that we'll
> be able to get it done. If not, the material will be moved to the next release
> instead.
>

Okay, thanks for the update!

Regards,
Mani

> 
> Thanks!
> 
> 
> -Olof
