From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [RFC] firmware: annotate thou shalt not request fw on init or
 probe
Date: Sat, 29 Aug 2015 18:18:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1508291812350.2057@localhost6.localdomain6>
References: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: ming.lei@canonical.com, Julia Lawall <julia.lawall@lip6.fr>, torvalds@linux-foundation.org, liam.r.girdwood@linux.intel.com, yang.jie@intel.com, tiwai@suse.de, dmitry.torokhov@gmail.com, joonas.lahtinen@linux.intel.com, teg@jklm.no, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, kay@vrfy.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org, yalin.wang2010@gmail.com, "Luis R. Rodriguez" <mcgrof@suse.com>, Jonathan Corbet <corbet@lwn.net>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, linux-doc@vger.kernel.org, cocci@systeme.lip6.fr, Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> +@ defines_module_init exists @
> +declarer name module_init;
> +identifier init;
> +@@
> +
> +module_init(init);
> +
> +@ has_probe depends on defines_module_init @
> +identifier drv_calls, drv_probe;
> +type bus_driver;
> +identifier probe_op =~ "(probe)";
> +@@
> +
> +bus_driver drv_calls = {
> +	.probe_op = drv_probe,
> +};

I'm not sure that this is enough.  For example, there is the macro
platform_driver_probe that initializes probe fields.  There is likewise
module_platform_driver, which is a top-level declaration that encapsulates
the module_init and the definition of the module_init function, which in
turn calls platform_driver_probe.  There is also module_platform_driver,
which encapsulates the module_init, but not the initialization of the probe
field.  Are you concerned with any of these cases?

julia
