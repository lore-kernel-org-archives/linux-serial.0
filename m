From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH RFC lora-next 0/5] net: lora: sx130x: USB CDC Picocell Gateway serdev driver via fake DT nodes
Date: Fri,  4 Jan 2019 12:21:26 +0100
Message-ID: <20190104112131.14451-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Frank Kunz <mailinglists@kunz-im-inter.net>, Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew@lunn.ch>, Sebastian Reichel <sre@kernel.org>, netdev@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello everyone,

Following up on a discussion in August 2018 [1] and my ELCE 2018 talk [2, 3],
I have been searching for an easy way to connect kernel network drivers to
a family of cards/adapters that expose a /dev/ttyACMx device today and
with the vendor's reference software would be accessed from userspace.

While a tty obviously works technically, it leaves us with per-vendor forks
of userspace software without a real upstream community (rare code drops).
It also doesn't allow code sharing with in-kernel protocol stacks or with
the SPI and UART based drivers we've already been working on.

One option suggested by Oliver was a line discipline - that would have the
advantage that it could work with virtually any tty, but on the downside
it would not work out-of-the-box and would require some userspace tool to
manually switch the tty into the new mode. Scalability was another concern,
as was duality of ldisc vs. serdev based implementations.

This patchset rather explores the use of Device Tree nodes to load a serdev
driver on top of the cdc-acm driver. By loading a modified cdc-acm module
plus this quickly hacked-together usb driver, I could play with it on 4.20
on an arm based Turris Omnia router with n-fuse mPCIe card, for instance.

I would hope that the shim approach taken here might also work for FTDI
MPSSE based SPI, encountered by Frank. Not with serdev then, of course,
but as pure USB interface/device driver piggy-backing on what exists.

An unsolved problem is that Semtech in version v0.2.1 switched away from
their own VID/PID to a generic STM32 VID/PID (due to Windows drivers...),
with the only distinction in iProduct string that usb_device_id does not
consider for probing. Since I'm reusing the cdc-acm driver, I can't have
it fail in probe, as it would then fail when called from my driver, too.

Various smaller issues are mentioned in the individual commit messages.

This patchset is based on my linux-lora.git lora-next staging branch.
Please consider taking the small usb patch to aid in further evaluating
serdev on cdc-acm and in resolving the remaining issues.
The others are for testing on our staging tree and for discussion.

Have a lot of fun!

Cheers,
Andreas

[1] https://marc.info/?l=linux-serial&m=153421371800416&w=2
[2] https://www.youtube.com/watch?v=Jjel65sZO9M
[3] https://events.linuxfoundation.org/wp-content/uploads/2017/12/ELCE2018_LoRa_final_Andreas-Farber.pdf

Cc: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Frank Kunz <mailinglists@kunz-im-inter.net>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-lpwan@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org

Andreas Färber (5):
  net: lora: sx130x: Factor out SPI specific parts
  net: lora: sx130x: Prepare storing driver-specific data
  net: lora: sx130x: Add PicoCell serdev driver
  usb: cdc-acm: Enable serdev support
  HACK: net: lora: sx130x: Add PicoCell gateway shim for cdc-acm

 drivers/net/lora/Makefile        |   4 +
 drivers/net/lora/picogw.c        | 337 ++++++++++++++++++++++++++++
 drivers/net/lora/sx130x.c        | 158 ++++++++-----
 drivers/net/lora/sx130x_picogw.c | 466 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/class/cdc-acm.c      |   8 +-
 include/linux/lora/sx130x.h      |   9 +
 6 files changed, 926 insertions(+), 56 deletions(-)
 create mode 100644 drivers/net/lora/picogw.c
 create mode 100644 drivers/net/lora/sx130x_picogw.c

-- 
2.16.4
