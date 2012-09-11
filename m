From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 08/12] tty/serial: Add kgdb_nmi driver
Date: Tue, 11 Sep 2012 15:14:20 +0100
Message-ID: <20120911151420.14a29485@pyramind.ukuu.org.uk>
References: <20120911093042.GA12471@lizard>
	<1347356106-25368-8-git-send-email-anton.vorontsov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53426 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828Ab2IKOKb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Sep 2012 10:10:31 -0400
In-Reply-To: <1347356106-25368-8-git-send-email-anton.vorontsov@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

> +struct kgdb_nmi_tty_priv {
> +	struct tty_port port;
> +	int opened;
> +	struct tasklet_struct tlet;
> +	STRUCT_KFIFO(char, KGDB_NMI_FIFO_SIZE) fifo;

I don't see where "opened" is used.


> +static const struct tty_operations kgdb_nmi_tty_ops = {
> +	.open		= kgdb_nmi_tty_open,
> +	.close		= kgdb_nmi_tty_close,
> +	.install	= kgdb_nmi_tty_install,
> +	.cleanup	= kgdb_nmi_tty_cleanup,
> +	.write_room	= kgdb_nmi_tty_write_room,
> +	.write		= kgdb_nmi_tty_write,

And a hangup method (just using tty_port helpers will do the job - it's
needed so vhangup() works as expected on a port)


Alan
