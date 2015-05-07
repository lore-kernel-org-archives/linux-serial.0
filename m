From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: 8250: do not copy port.fifosize member twice
Date: Thu, 07 May 2015 06:12:03 -0400
Message-ID: <554B3A73.2000305@hurleysoftware.com>
References: <1430993086-15652-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430993086-15652-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
List-Id: linux-serial@vger.kernel.org

On 05/07/2015 06:04 AM, Masahiro Yamada wrote:
> The port.fifosize member has already been copied at 8 lines above.
> Maybe the compiler optimization can clean it away, but just in case.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
