From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: core: Fix handling of options after MMIO address
Date: Mon, 12 Sep 2016 06:27:21 -0700
Message-ID: <82c71830-c19b-8eec-3281-13ee0f6514e4@roeck-us.net>
References: <af0e6790-c9e0-a3ed-ac17-1a6a56d954ce@nokia.com>
 <20160911004554.GA3562@roeck-us.net>
 <5e28d338-7667-f889-fae2-5aba0fdeb647@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e28d338-7667-f889-fae2-5aba0fdeb647@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>, linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On 09/12/2016 04:29 AM, Alexander Sverdlin wrote:
> Guenter Roeck reported a regression caused by commit "serial: earlycon:
> Extend earlycon command line option to support 64-bit addresses":
>
> console= and earlycon= options have the following format:
> ...,<addr>,<options>
>
> Historically used here simple_strtoul() had no problems with comma, but the
> new and recommended kstrtoull() requires null-terminated string and returns
> -EINVAL in case there are "options" at the end. There is no recommended to
> use function currently that will support it, so stick to obsolete
> simple_strtoull() variant.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/tty/serial/serial_core.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 89f5d6a..f2c8a8d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1938,14 +1938,11 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
>   *	   console=<name>,0x<addr>,<options>
>   *	is also accepted; the returned @iotype will be UPIO_MEM.
>   *
> - *	Returns 0 on success, -EINVAL or -ERANGE on failure
> + *	Returns 0 on success or -EINVAL on failure
>   */
>  int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
>  			char **options)
>  {
> -	int ret;
> -	unsigned long long tmp;
> -
>  	if (strncmp(p, "mmio,", 5) == 0) {
>  		*iotype = UPIO_MEM;
>  		p += 5;
> @@ -1971,10 +1968,11 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
>  		return -EINVAL;
>  	}
>
> -	ret = kstrtoull(p, 0, &tmp);
> -	if (ret)
> -		return ret;
> -	*addr = tmp;
> +	/*
> +	 * Before you replace it with kstrtoull(), think about options separator
> +	 * (',') it will not tolerate
> +	 */
> +	*addr = simple_strtoull(p, NULL, 0);
>  	p = strchr(p, ',');
>  	if (p)
>  		p++;
>
