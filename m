From: Helge Deller <deller@gmx.de>
Subject: serial console broken in v3.17-rc6 ?
Date: Tue, 23 Sep 2014 22:11:15 +0200
Message-ID: <5421D3E3.6080805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-parisc <linux-parisc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

During the release cycle of v3.17 I've seen sometimes a broken serial console output
on the parisc platform. Interestingly all kernel messages printed by the kernel via printk() show
up correctly, but output from userspace (e.g. by the init process during boot) show
up as random bytes.
Since the printk() output is correct the serial port itself and setup is probably correct.
Is parisc the only arch which has this problem, or are other architectures affected as well?
Maybe someone has an idea what could be wrong?
I did not try to bisect it yet.

Thanks,
Helge

Here is a sample output during bootup:

<lots of standard kernel printk output>...
usb 1-2: Manufacturer: SILITEK
rs
      og
  ]f"
s l
random: nonblocking pool is initialized
net eth0: Setting full-duplex based on MII#1 link partner capability of 45e1
tpdsystemd-udevd[744]: starting version 215
.
  eg..
      vp..
          ..Adding 1350652k swap on /dev/sdb6.  Priority:-1 extents:1 across:1350652k
.
  EXT4-fs (sdb5): re-mounted. Opts: (null)
