From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 6/9] serial: doc: .break_ctl() is called with
 port->mutex() held
Date: Wed, 16 Mar 2016 09:46:12 -0700
Message-ID: <56E98DD4.3030302@hurleysoftware.com>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
 <1457968577-22379-7-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-7-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/14/2016 08:16 AM, Geert Uytterhoeven wrote:
> Note that mutex_lock() should not be called with interrupts disabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/serial/driver | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/serial/driver b/Documentation/serial/driver
> index 3b08df5bcc17e944..09e73e061fcf795c 100644
> --- a/Documentation/serial/driver
> +++ b/Documentation/serial/driver
> @@ -177,8 +177,7 @@ hardware.
>  	should be terminated when another call is made with a zero
>  	ctl.
>  
> -	Locking: none.
> -	Interrupts: caller dependent.
> +	Locking: caller holds port->mutex


>  	This call must not sleep
           ^^^^^^^
And remove this line as well.

>  
>    startup(port)
> 

