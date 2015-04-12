From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: 8250: remove Kconfig indirection
Date: Sun, 12 Apr 2015 12:13:30 -0400
Message-ID: <552A99AA.4050909@hurleysoftware.com>
References: <1428853044-5954-1-git-send-email-valentinrothberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428853044-5954-1-git-send-email-valentinrothberg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Valentin Rothberg <valentinrothberg@gmail.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, geert@linux-m68k.org, rth@twiddle.net, ink@jurassic.park.msu.ru
List-Id: linux-serial@vger.kernel.org

On 04/12/2015 11:37 AM, Valentin Rothberg wrote:
> Remove CONFIG_SERIAL_DETECT_IRQ and CONFIG_SERIAL_MANY_PORTS, and
> substitute all references to the proper 8250 Kconfig options.  Now, the
> actual Kconfig dependencies are not hidden when reading the code and
> static analyzers are less confused.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

[Greg: this required reduced context (-C1) to apply on top of my 8250 split ]
