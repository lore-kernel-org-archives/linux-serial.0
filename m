From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v3 02/12] irqchip: armada-370-xp: do not enable it by
 default when ARCH_MVEBU is selected
Date: Tue, 16 Feb 2016 18:16:58 +0000
Message-ID: <20160216181658.GH5183@io.lakedaemon.net>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
 <1454951660-13289-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454951660-13289-3-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hey Gregory,

On Mon, Feb 08, 2016 at 06:14:10PM +0100, Gregory CLEMENT wrote:
> The irq-armada-370-xp driver can only be built for ARM 32 bits. The mvebu
> family had grown with a new ARM64 SoC which will also select the
> ARCH_MEVBU configuration. Since "ARM: mvebu: use the ARMADA_370_XP_IRQ
> option", the ARM32 mvebu SoC directly select this new option. Selecting
> it by default when ARCH_MEVBU is selected is no more needed.
> 
> This patch removes this dependency, thanks to this, a kernel for ARM64
> mvebu SoC can be built without error due this driver.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/irqchip/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Applied to irqchip/mvebu

thx,

Jason.
