From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V1 1/1] serial: 8250_fintek: Fix crash with baud rate B0
Date: Wed, 8 Nov 2017 17:34:14 +0000
Message-ID: <20171108173414.7b16c796@alans-desktop>
References: <1510110346-28893-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510110346-28893-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, lukas@wunner.de, rel+kernel@agilox.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ricardo.ribalda@gmail.com, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed,  8 Nov 2017 11:05:46 +0800
"Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com> wrote:

> The 8250_fintek.c is support the Fintek F81866/F81216 with dynamic clock.
> But It'll generate "division by zero" exception and crash in
> fintek_8250_set_termios() with baud rate 0 on baudrate_table[i] % baud.

0 means "hang up", so this looks good providing it leaves the device in a
sane state.


Reviewed-by: Alan Cox <alan@linux.intel.com>
