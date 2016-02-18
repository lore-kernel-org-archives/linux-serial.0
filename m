From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/3] serial: xuartps: Enable OF earlycon support
Date: Thu, 18 Feb 2016 09:20:32 -0800
Message-ID: <56C5FD60.4090906@hurleysoftware.com>
References: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
 <23ab10a19b21df2ef17a5bb6ce2a70d2d3fd3551.1455552315.git.michal.simek@xilinx.com>
 <56C34F65.1040506@hurleysoftware.com> <56C57A60.4070600@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56C57A60.4070600@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, monstr@monstr.eu, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On 02/18/2016 12:01 AM, Michal Simek wrote:
> BTW: Is it normal that when earlycon support is enabled that the bootlog
> is copied again? All what was printed before bootconsole [xxx] disabled
> is printed twice.

I think it has to do with the dummy console bug w/ OF.

Masahiro Yamada reported this back with 4.4-rc1 [1] but problem occurs before
then as well.

[1] http://www.gossamer-threads.com/lists/linux/kernel/2313050

> Or is this just bug in our driver?

No.

Regards,
Peter Hurley
