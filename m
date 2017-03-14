From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 0/2] serdev API extension
Date: Tue, 14 Mar 2017 06:48:17 -0700
Message-ID: <20170314134819.19476-1-andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, cphealy@gmail.com, Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Rob,

These patches are a continuation of discussion about adding
functionality to serdev API we had off-list.

Being added are a function to do a blocking write capable of
dispatching multiple calls to write_buf() and some very minimalistic
bus locking API.

Any feedback is appreciated.

Thanks,
Andrey Smirnov

Andrey Smirnov (2):
  serdev: Add serdev_device_write subroutine
  serdev: Add minimal bus locking API

 drivers/tty/serdev/core.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/serdev.h    | 34 ++++++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 6 deletions(-)

-- 
2.9.3
