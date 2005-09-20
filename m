From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] serial: remove 8250_acpi (subsumed by 8250_pnp and PNPACPI)
Date: Tue, 20 Sep 2005 10:04:31 -0600
Message-ID: <200509201004.31224.bjorn.helgaas@hp.com>
References: <200509161142.33723.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509161142.33723.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Russell King <rmk+serial-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mattieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Friday 16 September 2005 11:42 am, Bjorn Helgaas wrote:
> With the combination of PNPACPI and 8250_pnp, we no longer need
> 8250_acpi.
> 
> The only in-tree configs that contain CONFIG_SERIAL_8250_ACPI are ia64.
> ia64 users should make sure CONFIG_PNP and CONFIG_PNPACPI are set so
> 8250_pnp.c can discover built-in serial ports.  Tony has already
> accepted a patch to turn them on in the default configs.

Please don't apply this just yet.  Tony Luck tried it and tripped
over a deficiency in PNPACPI that I'll have to fix first.

(HP rx1620 has an ACPI_RSTYPE_ADDRESS32 item in its _PRS, and
PNPACPI doesn't know what to do with it.)


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
