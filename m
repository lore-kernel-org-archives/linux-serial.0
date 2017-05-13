From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] serial: altera_jtaguart: adding iounmap()
Date: Sat, 13 May 2017 13:00:55 +0200
Message-ID: <20170513110054.GE3447@distanz.ch>
References: <1494624982-3245-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1494624982-3245-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

On 2017-05-12 at 23:36:22 +0200, Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:
> The driver does ioremap(port->mapbase, ALTERA_JTAGUART_SIZE),
> but there is no any iounmap().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks!
