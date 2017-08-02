From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch v1 1/2] drivers: jtag: Add JTAG core driver
Date: Wed, 2 Aug 2017 06:44:56 -0700
Message-ID: <20170802134456.GD27481@kroah.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch, linux-serial@vger.kernel.org, mec@shout.net, vadimp@maellanox.com, system-sw-low-level@mellanox.com, Jiri Pirko <jiri@mellanox.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 02, 2017 at 04:18:37PM +0300, Oleksandr Shamray wrote:
> +menuconfig JTAG
> +	tristate "JTAG support"
> +	default n

'n' is always the default, no need for this line at all.

thanks,

greg k-h
