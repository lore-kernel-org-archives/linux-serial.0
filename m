From: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH 1/2] tty: serial: altera_uart: remove
 early_altera_uart_setup
Date: Tue, 25 Jan 2011 19:27:56 +0300
Message-ID: <20110125144529.GA4804@oksana.dev.rtsoft.ru>
References: <1295966417-11306-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imap.ru.mvista.com ([213.79.90.228]:19140 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751379Ab1AYQ7F (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Jan 2011 11:59:05 -0500
Content-Disposition: inline
In-Reply-To: <1295966417-11306-1-git-send-email-tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 25, 2011 at 03:40:17PM +0100, Tobias Klauser wrote:
> The function has no users inside the tree and the nios2 architecture
> doesn't use it (anymore) either.
> 
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

We don't use it either, at least so far. If/whenever we need it,
we can always revert this commit. So,

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!
