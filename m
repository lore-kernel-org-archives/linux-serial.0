From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v3 4/5] serial/8250_fintek: Support keys different than
 default
Date: Tue, 16 Jun 2015 10:50:30 +0200
Message-ID: <557FE356.9040805@suse.cz>
References: <1434444069-30260-1-git-send-email-ricardo.ribalda@gmail.com> <1434444069-30260-5-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434444069-30260-5-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Huewe <PeterHuewe@gmx.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw
List-Id: linux-serial@vger.kernel.org

On 06/16/2015, 10:41 AM, Ricardo Ribalda Delgado wrote:
> @@ -148,20 +148,25 @@ static int fintek_8250_rs485_config(struct uart_port *port,
>  	return 0;
>  }
>  
> -static int fintek_8250_base_port(void)
> +static int fintek_8250_base_port(u8 *key)
>  {
>  	static const u16 addr[] = {0x4e, 0x2e};
> -	int i;
> +	static const u16 keys[] = {0x77, 0xa0, 0x87, 0x67};

Hi, given keys are treated as u8 everywhere, this should be u8 too.

regards,
-- 
js
suse labs
