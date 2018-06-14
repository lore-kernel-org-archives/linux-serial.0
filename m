From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via
 sysfs*
Date: Thu, 14 Jun 2018 12:48:20 +0200
Message-ID: <20180614104820.GC32411@localhost>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Ricardo, 

On Mon, Jun 11, 2018 at 01:52:16PM +0200, Ricardo Ribalda Delgado wrote:
> There are some situations where it is interesting to load/remove serdev
> devices dynamically, like during board bring-up or when we are
> developing a new driver or for devices that are neither described via
> ACPI or device tree.

First of all, this would be more appropriately labeled an RFC as this is
far from being in a mergeable state. Besides some implementation issues,
we need to determine if this approach is at all viable.

Second, I wonder how you tested this given that this series breaks RX
(and write-wakeup signalling) for serial ports (patch 19/24)?

Third, and as Marcel already suggested, you need to limit your scope
here. Aim at ten patches or so, and use a representative serdev driver
as an example of the kind of driver updates that would be needed. It
also looks like some patches should be squashed (e.g. the ones
introducing new fields and the first one actually using them).

> This implementation allows the creation of serdev devices via sysfs,
> in a similar way as the i2c bus allows sysfs instantiation [1].

Note that this is a legacy interface and not necessarily something that
new interfaces should be modelled after.

Johan
