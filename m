From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/3] serial: earlycon: Add device-tree support for
 earlycon on Tegra
Date: Wed, 13 Jan 2016 17:21:54 +0000
Message-ID: <569687B2.9090609@nvidia.com>
References: <1452594809-17972-1-git-send-email-jonathanh@nvidia.com>
 <20160113160340.GJ2588@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160113160340.GJ2588@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


On 13/01/16 16:03, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Jan 12, 2016 at 10:33:26AM +0000, Jon Hunter wrote:
>> For Tegra the early console is support by passing the console information
>> via the boot parameter earlycon. This series allows us to use the
>> device-tree "stdout-path" property for early console (as well as the
>> console) on Tegra.
>>
>> Jon Hunter (3):
>>   serial: earlycon: Add device-tree support for other IO types
>>   serial: 8250_early: Add support for regshift
>>   serial: 8250_early: Add earlycon support for Tegra
>>
>>  drivers/of/fdt.c                     | 26 +++++++++++++++++++++++-
>>  drivers/tty/serial/8250/8250_early.c | 38 ++++++++++++++++++++++++++----------
>>  drivers/tty/serial/earlycon.c        |  6 ++++--
>>  include/linux/serial_core.h          |  3 ++-
>>  4 files changed, 59 insertions(+), 14 deletions(-)
> 
> The series:
> 
> Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Thanks. However, Peter Hurley also has a series he just refreshed from
early last year that includes similar changes to patches 1 and 2 [0]. So
I will probably drop these and just re-post patch 3 once his series is
merged.

> Jon, do you have plans on adding the stdout-path properties to existing
> device tree files?

I think that it would be a good idea and so I could include that in a
series with patch #3.

Cheers
Jon

[0] http://marc.info/?t=145262776100005&r=1&w=2
