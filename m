From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 5/9] serial: doc: Document .set_ldisc()
Date: Wed, 16 Mar 2016 09:49:46 -0700
Message-ID: <56E98EAA.8040103@hurleysoftware.com>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
 <1457968577-22379-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-6-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/14/2016 08:16 AM, Geert Uytterhoeven wrote:

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/serial/driver | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/serial/driver b/Documentation/serial/driver
> index 3b2a97d5ecc79491..3b08df5bcc17e944 100644
> --- a/Documentation/serial/driver
> +++ b/Documentation/serial/driver
> @@ -259,6 +259,11 @@ hardware.
>  	Interrupts: caller dependent.
>  	This call must not sleep
>  
> +  set_ldisc(port,termios)
> +	Notifier for discipline change. See Documentation/serial/tty.txt.
> +
> +	Locking: caller holds port->mutex
> +
>    pm(port,state,oldstate)
>  	Perform any power management related activities on the specified
>  	port.  State indicates the new state (defined by
> 

