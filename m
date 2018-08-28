From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: 8250_omap: Make 8250_omap driver driver depend
 on ARCH_K3
Date: Tue, 28 Aug 2018 09:21:07 -0700
Message-ID: <20180828162107.GP7523@atomide.com>
References: <20180828010302.2751-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828010302.2751-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vignesh R <vigneshr@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

* Nishanth Menon <nm@ti.com> [180828 01:07]:
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> Allow 8250 omap serial driver to be used for K3 platforms.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Now that we have the device tree support merged integrated AND we have ARCH_K3,
> Lets enable the 820 OMAP Driver to build for ARCH_K3 and make it operational.

Acked-by: Tony Lindgren <tony@atomide.com>
