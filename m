From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [patch v1 1/2] drivers: jtag: Add JTAG core driver
Date: Wed, 2 Aug 2017 16:16:38 +0200
Message-ID: <20170802141638.GC25781@lunn.ch>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, devicetree@vger.kernel.org, jiri@resnulli.us, system-sw-low-level@mellanox.com, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, mec@shout.net, Jiri Pirko <jiri@mellanox.com>, joel@jms.id.au, linux-serial@vger.kernel.org, vadimp@maellanox.com, tklauser@distanz.ch, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

> +void jtag_unregister(struct jtag *jtag)
> +{
> +	struct device *dev = jtag->dev;
> +
> +	mutex_lock(&jtag_mutex);
> +	list_add_tail(&jtag->list, &jtag_list);

add?

> +	mutex_unlock(&jtag_mutex);
> +	cdev_del(&jtag->cdev);
> +	device_unregister(dev);
> +	ida_simple_remove(&jtag_ida, jtag->id);
> +}

  Andrew
