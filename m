From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v3 01/13] of: earlycon: Fix 'stdout-path' with ':' path terminator
Date: Wed, 8 Apr 2015 16:24:04 -0500
Message-ID: <CAL_JsqLvKVDTD9-ees=gynVD2WDtEPGAa+XPCCpkX9ydaAVyTw@mail.gmail.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com> <1428515119-25248-2-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-2-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 8, 2015 at 12:45 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> stdout-path defines ':' as a path terminator and commit 75c28c09af99a
> ("of: add optional options parameter to of_find_node_by_path()") added
> the necessary support to parse paths terminated with ':'.
> commit 7914a7c5651a5 ("of: support passing console options with
> stdout-path") added options string support to the stdout-path property,
> which broke earlycon.
>
> Add the same support to earlycon to process 'stdout-path' properties
> which contain an options string.
>
> Requires: "libfdt: Add fdt_path_offset_namelen()"

Since David has applied this, we can cherrypick that commit for the
kernel copy. Ideally, we would do a dtc sync, but it's not going to
happen for 4.1.

Rob

> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/of/fdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 3a896c9..7cef9f9 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -765,7 +765,7 @@ extern struct of_device_id __earlycon_of_table[];
>  static int __init early_init_dt_scan_chosen_serial(void)
>  {
>         int offset;
> -       const char *p;
> +       const char *p, *q;
>         int l;
>         const struct of_device_id *match = __earlycon_of_table;
>         const void *fdt = initial_boot_params;
> @@ -782,8 +782,10 @@ static int __init early_init_dt_scan_chosen_serial(void)
>         if (!p || !l)
>                 return -ENOENT;
>
> +       q = strchrnul(p, ':');
> +
>         /* Get the node specified by stdout-path */
> -       offset = fdt_path_offset(fdt, p);
> +       offset = fdt_path_offset_namelen(fdt, p, (int)(q - p));
>         if (offset < 0)
>                 return -ENODEV;
>
> --
> 2.3.5
>
