From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch v1 1/2] drivers: jtag: Add JTAG core driver
Date: Wed, 2 Aug 2017 06:44:26 -0700
Message-ID: <20170802134426.GC27481@kroah.com>
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
> JTAG class driver provide infrastructure to support hardware/software
> JTAG platform drivers. It provide user layer API interface for flashing
> and debugging external devices which equipped with JTAG interface
> using standard transactions.

Yeah, it's nice to see this.

Some "meta" comments on this patch first:

> --- /dev/null
> +++ b/drivers/jtag/jtag.c
> @@ -0,0 +1,347 @@
> +/*
> + * Copyright (c) 2017 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2017 Oleksandr Shamray <oleksandrs@mellanox.com>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the names of the copyright holders nor the names of its
> + *    contributors may be used to endorse or promote products derived from
> + *    this software without specific prior written permission.
> + *
> + * Alternatively, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") version 2 as published by the Free
> + * Software Foundation.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + */

Ok, dual BSD/GPL, that's fine, but really?  In this day and age you want
to deal with that complexity?

I ask because then you export your symbols as "gpl only" everywhere:

> +void *jtag_priv(struct jtag *jtag)
> +{
> +	return jtag->priv;
> +}
> +EXPORT_SYMBOL_GPL(jtag_priv);

Which I don't object to at all, and personally really like, but it kind
of doesn't make sense, right?  How about just dropping the dual license
mess?  There's nothing here that any other OS will ever care about,
right?

For your uapi header file, that makes sense to keep it dual.


Now a technical comment:

> +/**
> + * struct jtag_run_test_idle - forces JTAG sm to
> + * RUN_TEST/IDLE state *
> + * @mode: access mode
> + * @reset: 0 - run IDEL/PAUSE from current state
> + *         1 - go trough TEST_LOGIC/RESET state before  IDEL/PAUSE
> + * @end: completion flag
> + * @tck: clock counter
> + *
> + * Structure represents interface to JTAG device for jtag idle
> + * execution.
> + */
> +struct jtag_run_test_idle {
> +	enum jtag_xfer_mode	mode;
> +	unsigned char		reset;
> +	enum jtag_endstate	endstate;
> +	unsigned char		tck;
> +};

All structures that cross the user/kernel boundry have to use the __
type variables.

No "unsigned char", it has to be "__u8", no "unsigned short", it has to
be "__u16", and so on.

Also, watch out for your enumerated types, what's the packing end up
looking like on these structures?  Have you verified it works with a
64bit kernel and 32bit userspace all correctly?

thanks,

greg k-h
