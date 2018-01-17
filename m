From: Shankara Pailoor <sp3485@columbia.edu>
Subject: RCU stall in 8250 serial driver Linux 4.15-rc1
Date: Wed, 17 Jan 2018 08:53:06 -0800
Message-ID: <CAASgV=tHtf88=h-wtUrnoC74M6BEnNXcCg8d3DyWJfx21dnLYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Syzkaller found the following rcu stall report in Linux 4.15-rc1:
https://pastebin.com/NyZ9JdRv

The following C program reproduces it: https://pastebin.com/gqwDWWpA

Configs Here: https://pastebin.com/v6M3iKi1

Regards,
Shankara
