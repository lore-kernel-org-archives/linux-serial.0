From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 0/3] UART slave device support (goldelico version)
Date: Fri, 16 Oct 2015 20:08:32 +0200
Message-ID: <cover.1445018912.git.hns@goldelico.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Sergei Zviagintsev <sergei@s15v.net>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Marek Belisko <marek@goldelico.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-serial@vger.kernel.org

H. Nikolaus Schaller (3):
  tty: serial core: provide a method to search uart by phandle
  tty: serial_core: add hooks for uart slave drivers
  misc: Add w2sg0004 gps receiver driver

 .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  18 +
 .../devicetree/bindings/serial/slaves.txt          |  16 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 Documentation/serial/slaves.txt                    |  36 ++
 drivers/misc/Kconfig                               |  18 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/w2sg0004.c                            | 443 +++++++++++++++++++++
 drivers/tty/serial/serial_core.c                   | 214 +++++++++-
 include/linux/serial_core.h                        |  25 +-
 include/linux/w2sg0004.h                           |  27 ++
 10 files changed, 793 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
 create mode 100644 Documentation/devicetree/bindings/serial/slaves.txt
 create mode 100644 Documentation/serial/slaves.txt
 create mode 100644 drivers/misc/w2sg0004.c
 create mode 100644 include/linux/w2sg0004.h

-- 
2.5.1

