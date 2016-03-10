From: Jiang Lu <lu.jiang@windriver.com>
Subject: [v2]serial_core:recognize invalid pointer from userspace
Date: Thu, 10 Mar 2016 11:17:22 +0800
Message-ID: <1457579843-29676-1-git-send-email-lu.jiang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org




Hi,
[v1 -> v2]

Fix a compile warning with data convert.

[v1 log]

When running setserial, application issue a TIOCGSERIAL iotcl to get serial setting, then update 
serial setting with TIOCSSERIAL ioctl. It always failed with TIOCSSERIAL ioctl, for application
pass 0xffffffff for iomem_base in serial_struct to kernel.

On 32bit rootfs & 64bit kernel, compat_ioctl use 0xffffffff as a magic number to mark invalid pointer
for iomem_base in serial_struct when truncating a 64bit pointer into 32bit.

Serial driver need recognize this invalid pointer when parsing serial_struct from userspace.

Thanks
Jiang Lu
