From: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Subject: [RFC PATCH v2 0/3] genirq, serial: 8250: Workaround to avoid irq=0
 for console
Date: Wed, 29 Jul 2015 08:12:49 +0000
Message-ID: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>
Cc: Taichi Kageyama <t-kageyama@cp.jp.nec.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: linux-serial@vger.kernel.org


This patch set provides a workaround to avoid the following problem.
It's based on Linux 4.2-rc4 mainstream kernel.
I've tested this patch set on x86-64 machine and KVM.

RFC
--------------------------
During interrupt probing phase, irq affinity of candidate IRQs
can be changed immediately and safely?
I'd like to discuss how irq affinity should be set during 
interrupt probing phase without paying attention to the kind of
chip->irq_set_affinity.

[patch v2 2/3] tries to set irq affinity and expects that irq affinity
is set immediately if possible.
I've tested this patch with 4.1-rc3 and 4.2-rc4, but the behavior of
this patch was different between both versions and depends on the 
kind of chip->irq_set_affinity although I could test only 2 types 
of machines.
I don't know whether these differences are problem or not. 
It seems other modules don't call irq_do_set_affinity() directly
before irq setup, so my usage of irq affinity may not be good.


v4.1-rc3 with CONFIG_GENERIC_PENDING_IRQ
  + x86-64(IvyBridge): intel_ioapic_set_affinity()
        -  irq affinity is changed immediately[No pending]
  + KVM(x86-64): native_ioapic_set_affinity()
        -  irq affinity is changed immediately  [No pending]
        -  assign_irq_vector() fails with EBUSY because the status 
           is still "move_in_progress"
           when other device calls setup_affinity() with the same irq.

v4.2-rc4 with CONFIG_GENERIC_PENDING_IRQ
   + x86-64(IvyBridge): intel_ir_set_affinity()
        - irq affinity is changed immediately [No pending]
   + KVM(x86-64): ioapic_set_affinity()
        - irq affinity is NOT changed immediately [Pending]
        - The following error was shown when other device calls
          setup_affinity() with the same irq 
          because the status is still "move_in_progress".
                "Failed to recover vector for irq 6"


Problem
--------------------------
There're cases where autoconfig_irq() fails during boot.
In these cases, the console doesn't work in interrupt mode
and "input overrun" (which makes operation mistakes) can happen
on some systems. This problem can happen with high rate every boot
once it occurs because the boot sequence is always almost same.
I saw the original problem on RHEL6.6.

Conditions of Reproduction
--------------------------
- Need non-PnP console serial 
  or PnP console without CONFIG_SERIAL_8250_PNP
- Build with CONFIG_SERIAL_8250_DETECT_IRQ.
- Keep interrupt disabled on the CPU which is used to detect 
  an interrupt during the timeout of autoconfig_irq().
     + Kick printk() on the CPU which detects interrupt 
       from a console serial port.

Change Log
--------------------------
v1:
  http://www.spinics.net/lists/linux-serial/msg17744.html
v2:
- Updated commit log of v1 patch 1/2 --> v2 1/3
- Removed v1 patch 2/2
- Added v2 2/3 patch to set irq affinity
- Added v2 3/3 patch to resolve other cases of this problem
   This is based on Peter's idea.
   It depends on v2 2/3 to set irq affinity.


Taichi Kageyama (3):
  serial: 8250: Fix autoconfig_irq() to avoid race conditions
  genirq: Add a function to set irq affinity of candidate IRQs
  serial: 8250: Fix autoconfig_irq() to reduce the risk of failure

 drivers/tty/serial/8250/8250_core.c | 15 +++++++++++++++
 include/linux/interrupt.h           |  4 ++++
 kernel/irq/autoprobe.c              | 31 +++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

-- 
2.4.6
