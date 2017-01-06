From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
Date: Fri, 06 Jan 2017 12:43:32 +0100
Message-ID: <4069640.PHLdmY3C6P@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <CACVXFVNS9n9_ty8y3CyqfRaLitqDKdk1mMOrQHM-enOgJtUBeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACVXFVNS9n9_ty8y3CyqfRaLitqDKdk1mMOrQHM-enOgJtUBeQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, gabriele.paoloni@huawei.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linuxarm@huawei.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ming Lei <tom.leiming@gmail.com>, xuwei5@hisilicon.com, linux-serial@vger.kernel.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, minyard@acm.org, Liviu Dudau <liviu.dudau@arm.com>, john.garry@huawei.com, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, kantyzc@163.com, zhichang.yuan02@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "zhichang.yuan" <yuanzhichang@hisilicon.com>, zourongrong@gmail.com
List-Id: linux-serial@vger.kernel.org

On Thursday, December 22, 2016 4:15:57 PM CET Ming Lei wrote:
> ERROR: "inb" [drivers/watchdog/wdt_pci.ko] undefined!
> ERROR: "outb" [drivers/watchdog/wdt_pci.ko] undefined!
> ERROR: "outb" [drivers/watchdog/pcwd_pci.ko] undefined!
> ERROR: "inb" [drivers/watchdog/pcwd_pci.ko] undefined!
> ERROR: "outw" [drivers/video/vgastate.ko] undefined!
> ERROR: "outb" [drivers/video/vgastate.ko] undefined!
> ERROR: "inb" [drivers/video/vgastate.ko] undefined!
> ERROR: "outw" [drivers/video/fbdev/vt8623fb.ko] undefined!
> ERROR: "inb" [drivers/video/fbdev/vt8623fb.ko] undefined!
> ERROR: "outb" [drivers/video/fbdev/vt8623fb.ko] undefined!
> ERROR: "outw" [drivers/video/fbdev/tridentfb.ko] undefined!
> ERROR: "inb" [drivers/video/fbdev/tridentfb.ko] undefined!
> ERROR: "outb" [drivers/video/fbdev/tridentfb.ko] undefined!
> ERROR: "inb" [drivers/video/fbdev/tdfxfb.ko] undefined!
> 

In case you haven't figured it out by now, the new code is simply
missing a few "EXPORT_SYMBOL" lines.

	Arnd
