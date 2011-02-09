From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/4] tty: serial: altera_uart: Use port->regshift to
 store bus shift
Date: Wed, 9 Feb 2011 13:46:35 +0300
Message-ID: <20110209104635.GB21588@oksana.dev.rtsoft.ru>
References: <cover.1297245277.git.tklauser@distanz.ch>
 <6ced1dcb96fc56fcdc8fb0daab898a773a7a320c.1297245277.git.tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52172 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab1BIKqj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Feb 2011 05:46:39 -0500
Content-Disposition: inline
In-Reply-To: <6ced1dcb96fc56fcdc8fb0daab898a773a7a320c.1297245277.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org

On Wed, Feb 09, 2011 at 10:57:04AM +0100, Tobias Klauser wrote:
> Use the regshift member of struct uart_port to store the address stride
> from platform data. This way we can save one dereference per call of
> altera_uart_readl and altera_uart_writel.
> 
> This also allows us to use the driver without platform data, which is
> needed for device tree support in the Nios2 port.
> 
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
