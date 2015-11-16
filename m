From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: fix clk_prepare/unprepare usage
Date: Mon, 16 Nov 2015 12:11:44 -0200
Message-ID: <CAOMZO5ATDh9puhS7MDiziwt6UVNezGyecMKsF2wCb3bgwwHwyA@mail.gmail.com>
References: <1447322328-5171-1-git-send-email-marcus.folkesson@gmail.com>
	<20151116121625.GD22022@pengutronix.de>
	<20151116135252.GA14555@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151116135252.GA14555@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 16, 2015 at 11:52 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:

> Sorry, seems like the cover-letter was never sent.
> The patch solves this issue:
>
>
> [    6.374678] ------------[ cut here ]------------
> [    6.374716] WARNING: CPU: 0 PID: 113 at kernel/locking/mutex.c:868 mutex_trylock+0x234/0x238()
> [    6.374733] DEBUG_LOCKS_WARN_ON(in_interrupt())
> [    6.374741] Modules linked in:
> [    6.374762] CPU: 0 PID: 113 Comm: mmcqd/0 Not tainted 4.3.0-rc4-dirty #18

This is an old kernel :-) We fixed this in 4.3.0-rc5.
