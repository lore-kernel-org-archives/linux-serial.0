From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/2] tty: serial: men_z135_uart.c: Don't initialize port->lock
Date: Thu, 06 Aug 2015 07:29:56 -0400
Message-ID: <55C34534.4060503@hurleysoftware.com>
References: <cover.1438844880.git.jthumshirn@suse.de> <12fb311fcd1757b779ed0eed009c0eba3b2aa8c0.1438844880.git.jthumshirn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12fb311fcd1757b779ed0eed009c0eba3b2aa8c0.1438844880.git.jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Werner <andreas.werner@men.de>
List-Id: linux-serial@vger.kernel.org

On 08/06/2015 03:16 AM, Johannes Thumshirn wrote:
> port->lock get's initialized in uart_add_one_port(), no need to do it
> in men_z135_probe().

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
