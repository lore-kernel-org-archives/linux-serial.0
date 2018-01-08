From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] serdev: bus-code clean ups
Date: Mon,  8 Jan 2018 13:42:31 +0100
Message-ID: <20180108124233.26729-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

As noted by Hans, we currently fail to generate uevents for ACPI serdev
controller as they do not have any ACPI companions from which ACPI
modaliases are constructed.

In fact, we should not have been generating modaliases for controllers
in the first place as controllers are not bound to drivers.

This series applies on top of Hans's minimal fix which suppresses the
uevent errors for ACPI controllers (even though it could replace it
entirely if preferred).

Johan


Johan Hovold (2):
  serdev: do not generate modaliases for controllers
  serdev: only match serdev devices

 drivers/tty/serdev/core.c | 80 +++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

-- 
2.15.1
