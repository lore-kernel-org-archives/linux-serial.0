From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 09/11] tty: serial: 8250: Fix multi-line strings
Date: Fri, 18 Dec 2015 07:45:03 -0800
Message-ID: <567429FF.9050908@hurleysoftware.com>
References: <1450437723-2978-1-git-send-email-anton.wuerfel@fau.de>
 <1450437723-2978-10-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1450437723-2978-10-git-send-email-anton.wuerfel@fau.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Phillip Raffeck <phillip.raffe>
List-Id: linux-serial@vger.kernel.org

On 12/18/2015 03:22 AM, Anton Wuerfel wrote:
> Merged user-visible multi-line strings into a single line according to the
> Linux Kernel Coding Style, which allows user-visible strings to exceed the
> maximum line length of 80 characters. The main reason for this is to
> facilitate grepping for these strings.
> However, some strings were ignored in this patch, because the use of
> format specifiers breaks the ability to grep anyway.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
