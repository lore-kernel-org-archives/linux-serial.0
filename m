From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] PNPACPI: support shareable interrupts
Date: Fri, 30 Jun 2006 16:02:34 -0700
Message-ID: <20060630160234.5d8e67e0.akpm@osdl.org>
References: <200606301258.26794.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200606301258.26794.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: ambx1@neo.rr.com, castet.matthieu@free.fr, shaohua.li@intel.com, len.brown@intel.com, linux-acpi@vger.kernel.org, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
> --- work-mm7.orig/drivers/pnp/pnpacpi/rsparser.c	2006-06-30 11:52:18.000000000 -0600
> +++ work-mm7/drivers/pnp/pnpacpi/rsparser.c	2006-06-30 12:18:41.000000000 -0600

pnpacpi confuses me.  Who maintains it?  Is it considered an APCI thing, or
a PNP thing or a Bjorn thing?

Thanks.
