From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/8] Generic serial earlycon
Date: Sat, 22 Mar 2014 10:54:39 +0100
Message-ID: <201403221054.39799.arnd@arndb.de>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Friday 21 March 2014, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This started out as an attempt to add arm64's earlyprintk support to ARM
> in order to get an earlier, runtime setup console on multi-platform
> kernels. The first issue was needing the fixmap support which
> conveniently Mark Salter was working on and is mostly in place now. Like
> many things on ARM and arm64 now, it then became where do I put the now
> common, shared code. After digging more into various early console/printk
> support, it turns out the 8250_early.c setup code was the best starting
> point. 
> 
> This is based on Mark Salter's fixmap support currently in linux-next.
> This is tested on arm64 and ARM with pl011 and 8250. The ARM support
> also requires fixmap and fixed mapping support which are not yet in place.
> I have some patches in my tree to support fixmap, but they need some more
> work. Fortunately, once fixmap is in place, it is just a Kconfig option
> to enable earlycon support on ARM. A git tree is available here[1].
> 
> Based on this series, I would like to add support for doing earlycon
> setup using DT.

Hi Rob,

I like this series a lot, great work!

I would consider the DT parsing support essential here, we should not
merge the patches until that is done as well, because I don't want
to see users pass earlycon command line options in DT when they can
use the established "linux,stdout-path" property instead. I would
expect that in almost every case in which we are booting using DT
today, we can just use linux,stdout-path to locate the device that
the boot loader has already set up and start usign it.

	Arnd
