From: Calvin Owens <calvinowens@fb.com>
Subject: [RFC][PATCH 0/4] Per-console loglevel support, console device bus
Date: Fri, 1 Mar 2019 16:48:16 -0800
Message-ID: <cover.1551486732.git.calvinowens@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Calvin Owens <calvinowens@fb.com>
List-Id: linux-serial@vger.kernel.org

Hello all,

This is an extremely overdue refresh of this series:

	https://lkml.org/lkml/2017/9/28/770

The big change here is the 3rd patch, which actually wires up the console
drivers to support embedding a device structure, so we can place them on
a "console" bus and expose attributes in sysfs.

I left the very long list of driver maintainers off this first submission,
once there's agreement on the core idea here I'll add them.

Thanks,
Calvin


Calvin Owens (4):
  printk: Introduce per-console loglevel setting
  printk: Add ability to set loglevel via "console=" cmdline
  printk: Add consoles to a virtual "console" bus
  printk: Add a device attribute for the per-console loglevel

 131 files changed, 1859 insertions(+), 1061 deletions(-)

-- 
2.17.1
