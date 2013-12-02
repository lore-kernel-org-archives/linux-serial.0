From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/11] serial: support for 16550 serial ports on LP-8x4x
Date: Mon, 2 Dec 2013 11:30:53 +0000
Message-ID: <20131202113052.GG16735@n2100.arm.linux.org.uk>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com> <1385879185-22455-6-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385879185-22455-6-git-send-email-ynvich@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 01, 2013 at 10:26:18AM +0400, Sergei Ianovich wrote:
> +static struct platform_device lp8x4x_device = {
> +	.name			= "serial8250",
> +	.id			= PLAT8250_DEV_ACCENT,

You should not re-use the enum value here.  The enum is designed as a
method to provide the platform devices with a unique id, not as a means
to identify the manufacturer or anything else like that.
