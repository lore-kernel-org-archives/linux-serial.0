From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/2] serial: 8250_ingenic: delete redundant "select
 SERIAL_EARLYCON"
Date: Tue, 27 Oct 2015 10:15:57 -0400
Message-ID: <562F871D.4060401@hurleysoftware.com>
References: <1445607076-14135-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445607076-14135-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-serial@vger.kernel.org
Cc: Paul Burton <paul.burton@imgtec.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joachim Eastwood <manabian@gmail.com>, John Crispin <blogic@openwrt.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

On 10/23/2015 09:31 AM, Masahiro Yamada wrote:
> SERIAL_8250_INGENIC depends on SERIAL_8250_CONSOLE, which already
> selects SERIAL_EARLYCON.
> 
> This line is redundant.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
