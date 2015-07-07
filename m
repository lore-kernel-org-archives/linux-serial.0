From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] serial: 8250: Workaround to avoid irq=0 for console
Date: Tue, 7 Jul 2015 15:42:05 -0700
Message-ID: <20150707224205.GB30851@kroah.com>
References: <55717224.9060104@cp.jp.nec.com>
 <559B8A48.5060004@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559B8A48.5060004@cp.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 07, 2015 at 08:13:59AM +0000, Taichi Kageyama wrote:
> On 2015/06/05 18:55, Taichi Kageyama wrote:
> > This patch set provides a workaround to avoid the following problem.
> > It's based on Linux 4.1-rc3 mainstream kernel.
> > I've tested this patch set on x86-64 machine and KVM.
> >
> > Problem
> > --------------------------
> > There're cases where autoconfig_irq() fails during boot.
> > In these cases, the console doesn't work in interrupt mode,
> > the mode cannot be changed anymore, and "input overrun"
> > (which can make operation mistakes) happens easily.
> > This problem happens with high rate every boot once it occurs
> > because the boot sequence is always almost same.
> > I saw the original problem on RHEL6.6.
> >
> > Fix
> > --------------------------
> > serial: 8250: Fix autoconfig_irq() to avoid race conditions
> >   Fix one of autoconfig_irq() failure case.
> > serial: 8250: Allow to skip autoconfig_irq() for a console
> >   Provide a workaround to avoid other autoconfig_irq() failure cases.
> >
> > Conditions of Reproduction
> > --------------------------
> > - Build with CONFIG_SERIAL_8250_DETECT_IRQ.
> > - Need non-PnP console serial or PnP console with no CONFIG_SERIAL_8250_PNP
> > - Kick printk() repeatedly on the CPU which can handle an interrupt
> >    from a console serial during autoconfig_irq(). The CPU is basically cpu0.
> > - Disable the interrupt of the CPU for longer during autoconfig_irq().
> >
> > Note
> > --------------------------
> > Ideally, I think autoconfig_irq() should be fixed completely,
> > but it's hard from the following points
> > as long as auto_irq algorithm is used.
> >   - How long it should wait for an interrrupt
> >   - How to assure the interrupt of the CPU enabled during auto_irq
> >   - How to know which CPU can handle an interrupt from a serial.
> >
> > Do you have any other idea?
> > In my opinion, providing a workaround is better than
> > applying big changes to the old function for legacy devices.
> >
> > Taichi Kageyama (2):
> >    serial: 8250: Fix autoconfig_irq() to avoid race conditions
> >    serial: 8250: Allow to skip autoconfig_irq() for a console
> >
> >   drivers/tty/serial/8250/8250_core.c |   23 +++++++++++++++++++++++
> >   1 files changed, 23 insertions(+), 0 deletions(-)
> >
> 
> Could you review this patch set?

Relax, it's in my queue...
