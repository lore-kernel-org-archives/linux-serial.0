From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/12] tty: amba-pl011: add register lookup table
Date: Thu, 24 Dec 2015 11:01:09 +0000
Message-ID: <20151224110108.GD8644@n2100.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNlS-0003jg-46@rmk-PC.arm.linux.org.uk>
 <20151224065437.GA18445@robwan01-pc.asiapac.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151224065437.GA18445@robwan01-pc.asiapac.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Huang Shijie <shijie.huang@arm.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 24, 2015 at 06:54:40AM +0000, Huang Shijie wrote:
> On Mon, Nov 16, 2015 at 05:40:26PM +0000, Russell King wrote:
> Hi Russell,
> 
> > Add a register lookup table, which allows the register offsets to be
> > adjusted on a per-port basis.
> I met a console hang with my ARM juno-r1 board after the linux-next merge this patch.
> 
> The console hang like this:
> 
> ==================================
> on will start in   1 seconds
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from command line
> EFI stub: Exiting boot services and installing virtual address map...
> ==================================
> 
> The console runs well if I revert this patch. Does anyone also meet the
> same hang issue?

I'd guess that this is some kind of conflict between EFI patches and
this patch set - this patch is a no-op in itself when applied to the
version it was developed against.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
