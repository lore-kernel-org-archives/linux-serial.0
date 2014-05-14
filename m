From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 1/4] serial: core: Consistent LF handling for poll_put_char
Date: Wed, 14 May 2014 10:08:07 -0500
Message-ID: <537386D7.4060407@windriver.com>
References: <1400079335-32125-1-git-send-email-daniel.thompson@linaro.org> <1400079335-32125-2-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400079335-32125-2-git-send-email-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Colin Cross <ccross@android.com>, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@kernel.crashing.org>, Pantelis Antoniou <panto@intracom.gr>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Schultz <jschultz@xes-inc.com>, Loic Poulain <loic.poulain@intel.com>, Kyle McMartin <kyle@infradead.org>, Stephen Warren <swarren@nvidia.com>, Ingo Molnar <mingo@elte.hu>, Paul Gortmaker <paul.gortmaker@windriver.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Jingoo Han <jg1.han@samsung.com>, Christophe Leroy <christophe.leroy@c-s.fr>
List-Id: linux-serial@vger.kernel.org

On 05/14/2014 09:55 AM, Daniel Thompson wrote:
> The behaviour of the UART poll_put_char infrastructure is inconsistent
> with respect to linefeed conversions. This in turn leads to difficulty
> using kdb on serial ports that are not also consoles
> (e.g. console=ttyAMA0,115200 kgdboc=ttyAMA1,115200).
>
> The following drivers automatically convert '\n' to '\r\n' inside their
> own poll functions but the remaining seventeen do not:
>
>     serial8250, cpm, pch_uart, serial_pxa, serial_txx9,
>
> This can be made fully consistent but performing the conversion in
> uart_poll_put_char(). A similar conversion is already made inside
> uart_console_write() but it is optional for drivers to use this
> function. Fortunately we can be confident the translation is safe
> because the (very common) 8250 already does this translation.


I'll have to take a look at some of the other drivers.  If all the instances of the function calls are going to coded per driver, it might make more sense to add variable to struct uart_port, vs changing the number of arguments to uart_poll_put_char.  And then the default can simply be coded in the struct initialization to the most common need.

Cheers,
Jason.
